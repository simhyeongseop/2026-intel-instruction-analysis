"""
1단계 extractor: Intel SDM PDF -> data/db/isa_db.csv

인텔 SDM(Volume 2) 안의 "Opcode/Instruction 인코딩 표"를 전부 찾아서
CSV 한 줄 = 명령어 한 form(=한 행) 으로 정리한다.

SDM 인코딩 표는 헤더 모양이 실제로 6~7가지나 된다. 예:
  - 레거시: Opcode | Instruction | Op/En | 64-Bit Mode | Compat/Leg Mode | Description
    (정수 연산 등 옛날부터 있던 명령어. 예: ADD, AND, MOV, PUSH ...)
  - SIMD/VEX/EVEX: Opcode/Instruction | Op/En | 64/32 Bit Mode Support | CPUID Feature Flag | Description
    (col0 에 opcode 와 instruction 이 줄바꿈으로 합쳐져 있음. 예: ADDPD, VADDSS, AESDEC ...)
  - Op/En 이 없는 표(x87 FPU, RET/RDTSC 등), CPUID 가 없는 표, Op/En 은 있는데 CPUID 는 없는 표
    (PREFETCHT0/T1/T2 등), opcode/instruction 은 합쳐졌는데 CPUID 만 있고 Op/En 은 없는 표
    (XACQUIRE/XRELEASE 등) ... 조합이 계속 나온다.
  -> 컬럼 개수로 표 모양을 일일이 나누면(예전엔 A/B/C/E 로 이름 붙였었다) 새 조합이 나올 때마다
     놓치는 사고가 났다. 그래서 지금은 헤더 "텍스트"만 보고 각 컬럼이 무슨 역할인지(opcode/instruction
     합쳐졌는지, op_en·mode·compat·cpuid·description 컬럼이 몇 번째인지) 찾아서 하나의 파서로 처리한다
     (classify_columns + parse_row).

그 밖에 헤더 셀에 각주 숫자가 붙어 "Opcode1" 처럼 보이거나(PUSH, RDTSC 등), 모드 표기에 슬래시가
빠져 "VV" 로 보이거나(EXTRACTPS 등), 니모닉 자체가 줄바꿈 하이픈으로 쪼개지는 경우(AESDECWIDE128KL 등),
opcode 자체가 두 줄로 나뉘어 니모닉이 세 번째 줄에야 나오는 경우(ROUNDPS 등)도 실제로 발견되어
방어 코드를 넣었다.

각주 숫자("Sreg2", "r/m161", "mm/m641", "UD01" 처럼 오퍼랜드/니모닉 뒤에 숫자가 들러붙는 문제)는
예전엔 "자주 나오는 고정폭 오퍼랜드 단어" 화이트리스트에 문자열 패턴 매칭으로 대응했는데, 이 방식은
목록에 없는 새 단어(Sreg, 단독 m16/m64 등)가 나올 때마다 또 놓치는 구조적 문제가 있었다(실제 사고).
그래서 지금은 PDF 문자 단위 정보(pdfplumber 의 font size)를 직접 봐서 고친다: 표 본문 글자는
9.0pt인데 각주 숫자만 그보다 작은 위첨자(실측 7.2pt, 본문의 80%)로 찍혀 있다는 게 SDM 전체에서
공통이었다. 그래서 "이 셀에서 제일 흔한(=본문) 글자 크기보다 뚜렷하게 작은 숫자 글자"를 표 텍스트를
조립하기 *전에* 걷어낸다(strip_footnote_digit_chars). 이러면 어떤 단어에 각주가 붙든 자동으로
잡히고, 화이트리스트를 유지보수할 필요가 없다. Description 칸은 예외로 둔다 — 그 칸에는 진짜 숫자
각주가 아니라 수식(예: FYL2X 설명의 "2^63" 같은 지수 표기)이 작은 폰트로 들어가는 경우가 있어서,
숫자만 보고 걷어내면 진짜 명령어 설명 내용을 훼손할 수 있기 때문이다.

이 파일은 "표를 CSV로" 만 한다. 고급 오퍼랜드 분해(토큰화)는 2단계(tokenizer) 몫이다.
"""

import collections
import csv
import re

import pdfplumber
from pdfplumber.utils import extract_text as chars_to_text

PDF_PATH = "325383-090-sdm-vol-2abcd.pdf"
OUT_CSV = "data/db/isa_db.csv"
COVERAGE_REPORT = "data/db/coverage_report.md"

# 명령어 레퍼런스(챕터 3~8: opcode 표들)가 있는 페이지 범위.
# 118 = "AAA-ASCII Adjust After Addition" 로 챕터3 본문이 시작하는 페이지(0-based)
# 2393 = "APPENDIX A OPCODE MAP" 이 시작하는 페이지 -> 여기부턴 opcode map/부록이라 제외.
INSTR_REF_START = 118
INSTR_REF_END = 2393

# 목차(Contents)에서 명령어 전체 목록을 뽑을 범위. 실측 결과 이 안에 다 들어있다.
TOC_START = 0
TOC_END = 60

CSV_COLUMNS = [
    "opcode", "instruction", "mnemonic", "operands",
    "op_en", "mode_support", "cpuid_flag", "description", "source_page",
]

# 64비트 모드 valid/invalid 약어 -> 풀어쓴 값
MODE_CODE_MAP = {"V": "Valid", "I": "Invalid", "N.E.": "N.E.", "N.S.": "N.S."}

# 각주 숫자(위첨자)는 실측상 그 칸 본문 글자 크기의 80% 수준(9.0pt -> 7.2pt)이었다.
# 표마다 본문 폰트 크기가 다를 수 있어 절대값이 아니라 "이 칸에서 제일 흔한 크기 대비 비율"로 판정한다.
FOOTNOTE_SIZE_RATIO = 0.9

# pdfplumber.utils.extract_text(=chars_to_text) 는 문자를 "같은 줄"로 묶을 때 문자의
# top 좌표가 y_tolerance(기본 3pt) 이내로 붙어 있어야 같은 줄로 본다. 그런데 아래첨자/
# 위첨자(예: description 안의 "log2ST(0)" 에서 밑첨자 2, "loge2" 의 밑첨자 e)는 폰트
# 크기만 작은 게 아니라 baseline 이 본문보다 3.7~4.4pt 정도 아래로 내려가 있어서, 기본
# tolerance(3) 로는 "다른 줄"로 잘못 갈라진다. 그렇게 갈라지면 그 문자 하나만 별도의 줄이
# 되어 문장 끝(또는 다음 줄 맨 앞)으로 밀려나 보인다 - 이게 FYL2X/FLDLN2 등에서 실제로
# 터진 버그다. 실측한 표의 실제 줄바꿈 간격은 9pt 표 기준 11pt 안팎이라 3.7~4.4pt 와는
# 충분히 차이가 나므로, tolerance 를 5pt 로 올려도 "진짜 다음 줄"과는 절대 안 섞이면서
# 아래첨자/위첨자는 원래 줄에 그대로 남는다.
LINE_Y_TOLERANCE = 5


def clean_text(raw):
    """줄바꿈/잔여 공백 같은 파싱 잔재를 정리한다 (opcode/description 등 공통)."""
    if not raw:
        return ""
    s = raw
    # 1) 줄바꿈 하이픈: "sign-\nextended" -> "sign-extended" (공백 없이 붙임)
    s = re.sub(r"-\s*\n\s*", "-", s)
    # 2) 나머지 줄바꿈은 공백으로
    s = s.replace("\n", " ")
    # 3) 쉼표 앞 공백 정리, 중복 공백 정리
    s = re.sub(r"\s+,", ",", s)
    s = re.sub(r"\s+", " ", s).strip()
    return s


def clean_instruction(raw):
    """instruction(니모닉+오퍼랜드) 전용 정리.

    예전엔 여기서 문자열 패턴(고정폭 오퍼랜드 화이트리스트, 'FN...1' 전용 정규식)으로
    각주 숫자 잔재를 뗐지만, 그 방식은 목록에 없는 새 단어가 나오면 또 놓치는 구조적
    문제가 있었다(Sreg2, r32/m161, mm/m641, UD01 이 실제로 그렇게 놓친 사례).
    지금은 각주 숫자를 PDF 문자 단위에서 이미(strip_footnote_digit_chars, 표를 문자열로
    조립하기 전 단계) 제거하고 들어오므로, 여기서는 clean_text 의 공통 정리만 하면 된다."""
    return clean_text(raw)


def split_mnemonic(instruction):
    """instruction 원문에서 mnemonic(첫 단어)과 operands(나머지)를 1차 분리."""
    instruction = instruction.strip()
    if not instruction:
        return "", ""
    parts = instruction.split(None, 1)
    mnemonic = parts[0]
    operands = parts[1].strip() if len(parts) > 1 else ""
    return mnemonic, operands


def fix_wrapped_mnemonic(opcode, instruction_raw):
    """줄바꿈이 니모닉 한가운데서 일어나 하이픈만 남는 경우 복구.
    예: opcode 마지막 줄이 '... AES-' 로 끝나고 instruction 이 'DECWIDE128KL m384, ...' 로 이어지면
    'AESDECWIDE128KL m384, ...' 로 다시 합친다."""
    if opcode.endswith("-"):
        head, sep, frag = opcode.rpartition(" ")
        if sep and frag.endswith("-") and len(frag) > 1:
            return head, frag[:-1] + instruction_raw
    return opcode, instruction_raw


def normalize_mode(token):
    """'V/V', 'Valid', 'VV'(슬래시 소실), 'V1'(각주숫자 붙음) 등에서
    64비트 모드 유효성만 뽑아 Valid/Invalid/N.E./N.S. 로 통일."""
    if not token:
        return ""
    first = token.split("/")[0].strip()
    if first in MODE_CODE_MAP:
        return MODE_CODE_MAP[first]
    stripped = re.sub(r"\d+$", "", first)  # 'V1' -> 'V' 처럼 각주 숫자만 뗀 버전도 시도
    if stripped in MODE_CODE_MAP:
        return MODE_CODE_MAP[stripped]
    if first[:1] in MODE_CODE_MAP:  # 'VV'처럼 슬래시가 아예 사라진 경우 방어
        return MODE_CODE_MAP[first[:1]]
    return first


MODE_VALUE_RE = re.compile(r"(Valid|Invalid|N\.\s*E\.|N\.\s*S\.)", re.IGNORECASE)


def _tidy_one_mode_value(m):
    """MODE_VALUE_RE 에 매치된 조각 하나(예: 'N. E.')만 공백 제거 + 첫 글자 대문자로."""
    value = re.sub(r"\s+", "", m.group(1))
    return value[0].upper() + value[1:]


def tidy_mode_text(text):
    """'N. E.' -> 'N.E.', 'Invalid*' -> 'Invalid' 처럼 공백/각주 기호가 섞인 모드 표기를 통일.

    실제 사고: SDM 인코딩 표의 64비트 모드 칸은 종종 'V/N.E.' 처럼 값 두 개가
    슬래시로 합쳐져 나온다(앞: 64비트 모드 값, 뒤: Compat/Legacy 모드 값. ADCX/MOVBE 의
    REX.W 폼 등에서 PDF 원문으로 직접 확인). 이전 버전은 re.search 로 문자열 전체에서
    딱 한 군데만 찾아 그 매치된 조각만 돌려줬는데, 약어 'V'/'I' 는 이 정규식(Valid/Invalid/
    N.E./N.S. 풀어쓴 표기만 인식)에 안 걸리다 보니 'V/N.E.' 에서 앞쪽 'V'는 통째로
    사라지고 뒤쪽 'N.E.'만 남아버렸다. 그 결과 64비트 모드에서 유효한(Valid) 명령어가
    N.E.(무효)로 잘못 기록됐다. 그래서 지금은 re.sub 로 문자열에 있는 모든 표기를
    "제자리에서" 통일하고 슬래시 구조는 그대로 보존한다. 슬래시로 나뉜 값 중 어느 쪽
    (64비트 모드)을 최종으로 쓸지는 이 함수의 몫이 아니라 normalize_mode() 가
    'token.split("/")[0]' 로 이미 담당한다."""
    if not text:
        return ""
    return MODE_VALUE_RE.sub(_tidy_one_mode_value, text).strip()


def header_key(header_row):
    """table 첫 행(헤더)을 비교하기 쉬운 대문자 한 줄 리스트로."""
    return [(cell or "").replace("\n", " ").strip().upper() for cell in header_row]


def classify_columns(header_row):
    """헤더를 보고 각 컬럼이 무슨 역할(opcode/instruction 병합 여부, op_en, mode, compat, cpuid,
    description)인지 찾아서 dict로 돌려준다. SDM 표는 실제로 6~7가지 헤더 모양이 있는데
    (레거시, SIMD/VEX/EVEX, Op/En 없는 x87, CPUID 없는 표 등) 컬럼 개수로 일일이 나누는 대신
    헤더 텍스트로 역할을 찾아 하나의 파서로 처리한다. 이렇게 하면 새로운 표 모양이 또 나와도
    (RDPKRU, XACQUIRE, PREFETCHT0 표에서 실제로 3가지가 더 나왔다) 대부분 자동으로 처리된다.

    주의: 헤더 셀에도 각주 숫자가 붙어 "Opcode1" 처럼 나오는 경우가 있어서(PUSH 등)
    '==' 로 정확히 비교하면 놓친다. startswith 로 느슨하게 비교한다.
    """
    hdr = header_key(header_row)
    if not hdr or "DESCRIPTION" not in hdr[-1]:
        return None  # Description 컬럼이 없으면 오퍼랜드 인코딩 표 등 -> 우리가 찾는 표가 아님
    if len(hdr) < 3:
        return None

    if hdr[0].startswith("OPCODE") and (hdr[1].startswith("INSTRUCTION") or hdr[1] == ""):
        # opcode/instruction 이 분리된 컬럼(레거시 A, x87 C, CRC32처럼 헤더만 밀린 경우 포함)
        merged = False
        rest_start = 2
    elif "OPCODE" in hdr[0] and "INSTRUCTION" in hdr[0]:
        # col0 에 opcode+instruction 이 합쳐진 표(SIMD/VEX/EVEX 계열)
        merged = True
        rest_start = 1
    else:
        return None

    description_idx = len(hdr) - 1
    roles = {
        "merged": merged, "description_idx": description_idx,
        "op_en_idx": None, "mode_idx": None, "compat_idx": None, "cpuid_idx": None,
    }
    for i in range(rest_start, description_idx):
        cell = hdr[i]
        if "CPUID" in cell:
            roles["cpuid_idx"] = i
        elif "COMPAT" in cell or "LEG" in cell:
            roles["compat_idx"] = i
        elif "MODE" in cell or "BIT" in cell:
            roles["mode_idx"] = i
        elif "EN" in cell:
            roles["op_en_idx"] = i
    if roles["mode_idx"] is None:
        return None  # 64비트 모드 컬럼을 못 찾으면 우리가 찾는 표가 아닌 것으로 취급
    return roles


def parse_row(row, roles, page_no):
    """classify_columns 가 찾아준 컬럼 역할대로 한 행을 뽑아낸다."""
    if len(row) <= roles["description_idx"]:
        return None
    if roles["merged"]:
        opcode, instruction = split_merged_opcode_instruction(row[0])
    else:
        opcode = clean_text(row[0])
        instruction = clean_instruction(row[1])
    if not opcode or not instruction:
        return None  # NOTES: 같은 잔여 행
    mnemonic, operands = split_mnemonic(instruction)
    op_en = clean_text(row[roles["op_en_idx"]]) if roles["op_en_idx"] is not None else ""
    mode_support = normalize_mode(tidy_mode_text(clean_text(row[roles["mode_idx"]])))
    cpuid_flag = clean_text(row[roles["cpuid_idx"]]) if roles["cpuid_idx"] is not None else ""
    description = clean_text(row[roles["description_idx"]])
    return {
        "opcode": opcode, "instruction": instruction,
        "mnemonic": mnemonic, "operands": operands,
        "op_en": op_en, "mode_support": mode_support,
        "cpuid_flag": cpuid_flag, "description": description,
        "source_page": page_no,
    }


def looks_like_mnemonic_start(token):
    """줄의 첫 토큰이 'opcode 조각'이 아니라 진짜 니모닉처럼 보이는지 확인.
    opcode 조각은 hex byte(0F 등), /r, ib, NP, REX, VEX....처럼 소문자/점/슬래시가 섞이거나
    2자리 hex byte 라서 이 조건에 걸리지 않는다."""
    if not re.match(r"^[A-Z][A-Z0-9]*$", token):
        return False  # 소문자·점·슬래시 등이 섞이면 opcode 조각
    if len(token) == 2 and re.match(r"^[0-9A-F]{2}$", token):
        return False  # 순수 2자리 hex byte
    if token in ("NP", "REX"):
        return False
    return True


# opcode 접미사(ib/ic/id/iw = 1/2/4바이트 즉시값 표시)가 줄바꿈 없이 바로 다음 줄
# 니모닉에 공백 없이 붙어버리는 경우 방어용 (예: 'ibVPERMILPS zmm1, ...').
# 실제 니모닉 줄은 항상 대문자로 시작하므로 소문자 접미사 바로 뒤에 대문자가 오면
# 이 케이스로 본다. ('ib' 한 글자만 있는 정상 줄은 뒤에 글자가 없어 매치되지 않는다.)
GLUED_IMM_SUFFIX_RE = re.compile(r"^(ib|ic|id|iw)([A-Z].*)$")


def fix_glued_opcode_suffix(lines):
    """opcode 접미사가 다음 줄 니모닉과 붙어버린 줄을 'ib' / 'VPERMILPS ...' 두 줄로 되돌린다."""
    fixed = []
    for line in lines:
        m = GLUED_IMM_SUFFIX_RE.match(line)
        if m:
            fixed.append(m.group(1))
            fixed.append(m.group(2))
        else:
            fixed.append(line)
    return fixed


def split_merged_opcode_instruction(col0):
    """opcode/instruction 이 합쳐진 표 공통: col0 여러 줄 중 어디까지가 opcode 이고
    어디부터 instruction 인지 찾는다.

    보통은 첫 줄이 opcode, 나머지가 instruction 이지만(ADDSS 등), opcode 자체가
    두 줄로 나뉘는 경우도 있다(ROUNDPS: '66 0F 3A 08' + '/r ib' + 'ROUNDPS ...').
    그래서 '진짜 니모닉처럼 보이는 첫 줄'을 찾아서 그 줄부터 instruction 으로 본다.
    줄바꿈이 니모닉 한가운데서 일어나 하이픈만 남는 경우(AESDECWIDE128KL 등)도 복구한다."""
    lines = [l for l in (col0 or "").split("\n") if l.strip()]
    lines = fix_glued_opcode_suffix(lines)
    if len(lines) < 2:
        return "", ""
    split_idx = 1  # 못 찾으면 기존 방식(첫 줄만 opcode)으로 대체
    for idx, line in enumerate(lines):
        first_token = line.split(None, 1)[0]
        if looks_like_mnemonic_start(first_token):
            split_idx = max(idx, 1)
            break
    opcode_raw = clean_text(" ".join(lines[:split_idx]))
    instruction_raw = " ".join(lines[split_idx:])
    opcode_raw, instruction_raw = fix_wrapped_mnemonic(opcode_raw, instruction_raw)
    return opcode_raw, clean_instruction(instruction_raw)


def _char_mid_in_bbox(char, bbox):
    """문자 하나(char)의 중심점이 bbox(x0, top, x1, bottom) 안에 있는지.
    pdfplumber.table.Table.extract() 내부 로직과 동일한 판정 기준(중심점 기준)이라야
    표 셀 분리와 어긋나지 않는다."""
    v_mid = (char["top"] + char["bottom"]) / 2
    h_mid = (char["x0"] + char["x1"]) / 2
    x0, top, x1, bottom = bbox
    return (h_mid >= x0) and (h_mid < x1) and (v_mid >= top) and (v_mid < bottom)


def _chars_in_bbox(chars, bbox):
    return [c for c in chars if _char_mid_in_bbox(c, bbox)]


def strip_footnote_digit_chars(chars):
    """셀 안 문자들 중 '위첨자 각주 숫자'를 실제로 걷어낸다.

    화이트리스트(특정 단어 목록) 대신, "이 칸에서 제일 흔한(=본문) 글자 크기보다
    뚜렷하게 작은 숫자 글자"를 각주로 판정한다. 실측: SDM 인코딩 표 본문은 9.0pt인데
    각주 숫자만 7.2pt(본문의 80%)로 작게 찍혀 있고, 이 비율은 표마다 본문 크기가
    달라도(예: 8pt 표) 상대적으로 유지된다. 그래서 절대 크기가 아니라
    FOOTNOTE_SIZE_RATIO 비율로 판정해서 어떤 단어에 각주가 붙든 자동으로 잡는다.
    """
    if len(chars) < 2:
        return chars
    sizes = collections.Counter(round(c["size"], 2) for c in chars)
    # 동점이면(예: 셀에 글자가 2개뿐이고 크기가 갈리는 경우) 더 큰 쪽을 본문으로 본다.
    body_size = max(sizes.items(), key=lambda item: (item[1], item[0]))[0]
    threshold = body_size * FOOTNOTE_SIZE_RATIO
    kept = [c for c in chars if not (c["text"].isdigit() and c["size"] < threshold)]
    return kept if kept else chars  # 전부 걸러지면(이상 상황) 원본 유지


def extract_row_cells(page_chars, row_bbox, cell_bboxes, skip_col):
    """표 한 행의 각 셀 텍스트를 조립한다. skip_col(Description 칸 인덱스)만
    각주 필터를 건너뛴다 - 그 칸은 진짜 숫자 각주가 아니라 수식(지수 표기 등)이
    작은 폰트로 들어가는 경우가 있어서, 숫자만 보고 지우면 설명 내용을 훼손한다."""
    row_chars = _chars_in_bbox(page_chars, row_bbox)
    cells = []
    for col_i, cell_bbox in enumerate(cell_bboxes):
        if cell_bbox is None:
            cells.append(None)
            continue
        chars = _chars_in_bbox(row_chars, cell_bbox)
        if not chars:
            cells.append("")
            continue
        if col_i != skip_col:
            chars = strip_footnote_digit_chars(chars)
        cells.append(chars_to_text(chars, y_tolerance=LINE_Y_TOLERANCE))
    return cells


def extract_rows_from_page(page, page_no):
    """한 페이지 안의 모든 표를 훑어서 우리가 원하는 인코딩 표 행들을 뽑는다.

    page.extract_tables() 대신 page.find_tables() + 직접 셀 텍스트 조립을 쓴다
    (표를 찾는 로직 자체는 동일 - extract_tables() 도 내부적으로 find_tables() 결과에
    table.extract() 를 부르는 것뿐이다). 직접 조립하는 이유는 각 셀의 문자(font size)
    정보에 접근해서 각주 숫자를 걷어내기 위함이다."""
    rows = []
    try:
        tables = page.find_tables()
    except Exception:
        return rows
    page_chars = page.chars
    for table in tables:
        if not table.rows:
            continue
        header_bboxes = table.rows[0].cells
        header = extract_row_cells(page_chars, table.rows[0].bbox, header_bboxes, skip_col=None)
        roles = classify_columns(header)
        if roles is None:
            continue
        for row_obj in table.rows[1:]:
            raw_row = extract_row_cells(
                page_chars, row_obj.bbox, row_obj.cells, skip_col=roles["description_idx"]
            )
            if raw_row is None or all(c is None for c in raw_row):
                continue
            if raw_row[0] and str(raw_row[0]).strip().upper().startswith("NOTES"):
                continue
            parsed = parse_row(raw_row, roles, page_no)
            if parsed:
                rows.append(parsed)
    return rows


def extract_all_rows(pdf):
    """챕터 3~8 범위 페이지를 전부 훑어서 명령어 표 행을 모은다."""
    all_rows = []
    for i in range(INSTR_REF_START, min(INSTR_REF_END, len(pdf.pages))):
        page = pdf.pages[i]
        rows = extract_rows_from_page(page, i + 1)  # source_page는 사람이 보기 쉬운 1-based
        all_rows.extend(rows)
    return all_rows


def write_csv(rows, path):
    with open(path, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=CSV_COLUMNS)
        writer.writeheader()
        for row in rows:
            writer.writerow(row)


# ---------- 목차(TOC) 기반 커버리지 대조 ----------

# 목차 한 줄 예: "AAA-ASCII Adjust After Addition. . . . . . . . 3-1"
# em-dash(—) 또는 hyphen(-) 뒤에 설명, (점 리더가 있을 수도 없을 수도 있음), 마지막에 페이지번호(3-1).
# mnemonic 그룹에 콤마(MOVDQA,VMOVDQA32/64)나 슬래시(BNDCU/BNDCN)가 섞여 나오는 경우도 있다.
TOC_LINE_RE = re.compile(
    r"^([A-Za-z][A-Za-z0-9/,]*)\s*[—-]+\s*(.+?)[.\s]*(\d+-\d+)\s*$"
)
SKIP_PREFIXES = ("FIGURE", "TABLE", "CHAPTER", "APPENDIX")
PAGE_REF_RE = re.compile(r"\d+-\d+\s*$")


def expand_group_name(raw_name):
    """'MOVDQA,VMOVDQA32/64' 나 'VPBROADCASTB/W/D/Q' 같은 묶음 표기를
    ['MOVDQA', 'VMOVDQA32', 'VMOVDQA64'] / ['VPBROADCASTB', 'VPBROADCASTW', ...] 로 풀어준다.

    슬래시 뒤에 짧은(1~2글자) 조각만 남으면(W, D, Q, PS, 64 등) 데이터 타입 접미사로 보고
    바로 앞 완성형 이름에서 '이전 접미사 길이'만큼 잘라낸 접두사에 새 접미사를 붙여 복원한다."""
    names = []
    for comma_part in raw_name.split(","):
        comma_part = comma_part.strip()
        if not comma_part:
            continue
        prev_full = None
        prev_suffix_len = None
        for slash_part in comma_part.split("/"):
            slash_part = slash_part.strip()
            if not slash_part:
                continue
            if prev_full is not None and len(slash_part) <= 2:
                if prev_suffix_len is not None:
                    strip_len = prev_suffix_len
                else:
                    # 원래 첫 토큰의 접미사 길이를 모를 때: 끝이 숫자면 그 숫자 길이만큼,
                    # 아니면(문자 접미사, 예: B/W/D/Q) 지금 조각 길이로 추정한다.
                    trailing_digits = re.search(r"\d+$", prev_full)
                    strip_len = len(trailing_digits.group()) if trailing_digits else len(slash_part)
                base = prev_full[:-strip_len] if strip_len < len(prev_full) else prev_full
                new_full = base + slash_part
                names.append(new_full)
                prev_suffix_len = len(slash_part)
                prev_full = new_full
            else:
                names.append(slash_part)
                prev_full = slash_part
                prev_suffix_len = None
    return names


def extract_toc_mnemonics(pdf):
    """목차에서 명령어 이름 전체 목록을 뽑는다(커버리지 대조용).
    반환: (전체 이름 set(대문자), cc-계열 placeholder 이름 set(대문자))
    cc-계열은 목차 원문에 'Jcc'/'SETcc'처럼 소문자 cc가 섞여 있는 것으로 판별한다
    (실제 표에는 JA/JB/... 식 개별 니모닉으로 나오는 게 정상이라 실제 누락이 아님)."""
    names = set()
    cc_family = set()
    for i in range(TOC_START, min(TOC_END, len(pdf.pages))):
        text = pdf.pages[i].extract_text() or ""
        lines = [l.strip() for l in text.split("\n") if l.strip()]
        idx = 0
        while idx < len(lines):
            line = lines[idx]
            idx += 1
            if line.upper().startswith(SKIP_PREFIXES):
                continue
            candidate = line
            # 설명이 다음 줄로 넘어가서 페이지번호가 다음 줄에 붙는 경우 한 줄만 더 이어붙여본다
            if "—" in line and not PAGE_REF_RE.search(line) and idx < len(lines):
                candidate = f"{line} {lines[idx]}"
                if PAGE_REF_RE.search(candidate):
                    idx += 1
            m = TOC_LINE_RE.match(candidate)
            if not m:
                continue
            raw_group = m.group(1)
            # 목차의 진짜 니모닉은 항상 대문자다. 소문자가 하나라도 섞여 있으면
            # Jcc/SETcc/PREFETCHh/INT n 처럼 와일드카드 자리표시자라는 뜻.
            has_cc_placeholder = re.search(r"[a-z]", raw_group) is not None
            for name in expand_group_name(raw_group):
                name_upper = name.upper()
                if not name_upper:
                    continue
                names.add(name_upper)
                if has_cc_placeholder:
                    cc_family.add(name_upper)
    return names, cc_family


def write_coverage_report(toc_names, cc_family, extracted_mnemonics, row_count, path, page_count):
    """목차 명령어 목록 vs 실제 추출 결과를 대조해서 리포트를 남긴다."""
    extracted_upper = {m.upper() for m in extracted_mnemonics}
    missing = sorted(n for n in toc_names if n not in extracted_upper)
    cc_missing = sorted(n for n in missing if n in cc_family)
    real_missing = sorted(n for n in missing if n not in cc_family)

    lines = []
    lines.append("# Stage 1 Extractor 커버리지 리포트\n")
    lines.append(f"- 스캔한 명령어 레퍼런스 페이지 수: {page_count}")
    lines.append(f"- 추출된 표 행(row) 수: {row_count}")
    lines.append(f"- 추출된 고유 mnemonic 수: {len(extracted_upper)}")
    lines.append(f"- 목차(TOC)에서 뽑은 명령어(계열) 이름 수: {len(toc_names)}")
    lines.append(f"- 추출 결과에 없는 이름 수: {len(missing)} (그중 cc-계열 placeholder: {len(cc_missing)})")
    lines.append("")
    lines.append("## 조건부 접미사(cc) 계열 placeholder (버그 아님, 참고용)")
    lines.append(", ".join(cc_missing) if cc_missing else "(없음)")
    lines.append("")
    lines.append("## 실제 누락 의심 목록 (0 이어야 함)")
    lines.append(", ".join(real_missing) if real_missing else "(없음 - 커버리지 100%)")
    lines.append("")
    lines.append("## 알려진 제한사항 (수동 확인 결과, 실제 파이프라인 버그 아님)")
    lines.append(
        "- 위 목록 대부분은 목차가 '섹션 제목'(예: VPBROADCAST, PMOVSX, VPSHLD, UD)만 적어둔 경우다.\n"
        "  실제 표에는 VPBROADCASTB/W/D/Q, PMOVSXBW, VPSHLDD/Q/W, UD0/UD1/UD2 처럼 구체적인\n"
        "  니모닉으로 나뉘어 있고, 그 구체 니모닉들은 isa_db.csv 에 정상적으로 들어있다(직접 확인함).\n"
        "- PABSQ/PMAXSQ/PMAXUQ/PMINSQ/PMINUQ/PMULLQ/PSRAQ 는 목차엔 바로 옆 형제(PABSB/W/D 등)와\n"
        "  같이 적혀 있지만, 실제로는 V 접두사 붙은 형태(VPABSQ 등)만 존재하고 맨몸 형태는 표에 없다.\n"
        "- REPNZ/REPZ 라는 이름 자체는 TOC 상의 별칭 표기(REPE/REPZ, REPNE/REPNZ)일 뿐이고,\n"
        "  실제 opcode 표(PDF p.1266/1268/1270)는 REP / REPE / REPNE 라는 이름으로 존재하며\n"
        "  isa_db.csv 에 정상적으로 포함되어 있다(직접 확인함).\n"
        "- VCOMPRESSW 는 목차 원문이 'VPCOMPRESSB/VCOMPRESSW'(PDF p.17)로 적혀 있어 P 가 빠진\n"
        "  것으로 보이는 목차 자체의 표기 문제이고, 실제 opcode 표에는 VPCOMPRESSW 로 등재되어\n"
        "  있으며 isa_db.csv 에 정상적으로 포함되어 있다(직접 확인함)."
    )
    with open(path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))
    return real_missing


def main():
    pdf = pdfplumber.open(PDF_PATH)
    print("추출 시작 (챕터 3~8 opcode 표 스캔)...")
    rows = extract_all_rows(pdf)
    print(f"추출된 행 수: {len(rows)}")
    write_csv(rows, OUT_CSV)
    print(f"CSV 저장: {OUT_CSV}")

    print("목차(TOC) 커버리지 대조 중...")
    toc_names, cc_family = extract_toc_mnemonics(pdf)
    extracted_mnemonics = {r["mnemonic"] for r in rows if r["mnemonic"]}
    page_count = INSTR_REF_END - INSTR_REF_START
    real_missing = write_coverage_report(
        toc_names, cc_family, extracted_mnemonics, len(rows), COVERAGE_REPORT, page_count
    )
    print(f"커버리지 리포트 저장: {COVERAGE_REPORT}")
    print(f"실제 누락 의심 개수: {len(real_missing)}")


if __name__ == "__main__":
    main()

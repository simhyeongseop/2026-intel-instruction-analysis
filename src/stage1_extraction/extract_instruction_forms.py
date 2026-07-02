"""
Stage 1 (재작성): Intel SDM Vol.2 description 페이지의 "인코딩 표"에서
instruction form 전체를 추출한다.

배경
----
기존 `extract_intel_instructions.py`는 표의 컬럼 위치를 legacy 6-컬럼 레이아웃
(col0=Opcode, col1=Instruction, ...)으로 고정 가정했다. 그러나 SDM의 벡터
(SSE/AVX/AVX-512) 명령어 표는 레이아웃이 다르다:

  legacy  (예: ADD)      : | Opcode | Instruction | Op/En | 64-bit Mode | ... |
  vector  (예: ADDPS)    : | Opcode/Instruction (병합) | Op/En | 64/32 Mode | CPUID | Desc |
  getsec  (예: GETSEC)   : | Opcode | Instruction | Description |   (Op/En 없음)

벡터 표는 col0에 opcode와 instruction이 한 셀에 합쳐져 있어서, 기존 코드는
col1(=Op/En 코드 "A"/"B"...)을 instruction으로 잘못 읽고 전부 버렸다.
그 결과 V로 시작하는 벡터 명령어가 통째로 누락됐다.

이 재작성 버전의 방침 (교수님 피드백 반영)
-------------------------------------------
- 목차의 압축표기(예: VF[,N]MADD[132,213,231]PH)를 임의로 전개하지 않는다.
- 대신 각 명령어 description 페이지의 인코딩 표를 직접 읽는다. 표에는
  VFMADD132PD / VFMADD213PD / VFMADD231PD 처럼 실제 form이 개별 행으로
  이미 전개되어 있다. 즉 "정답은 매뉴얼 표"라는 원칙.

레이아웃 판별
-------------
표의 헤더행 첫 번째(비어있지 않은) 셀을 정규화했을 때 'opcode'로 시작하면
인코딩 표로 간주한다. 그 첫 셀에 'instruction'이 함께 들어있으면
(예: 'Opcode/Instruction' 또는 'Opcode Instruction') 병합형, 별도의
'Instruction' 컬럼이 따로 있으면 분리형이다. 이 신호는 operand-encoding 표
('Op/En | Tuple Type | ...'), 예외 클래스 표 등 다른 표를 자연스럽게 배제한다.

출력
----
    data/stage1_extracted/instruction_forms.csv
      columns: page, layout, mnemonic, instruction, opcode, mode_support, source_cell
"""

import re
import csv
import time
from pathlib import Path
import pdfplumber

BASE = Path(__file__).parent.parent.parent
PDF = BASE / "325383-090-sdm-vol-2abcd.pdf"
OUT_CSV = BASE / "data" / "stage1_extracted" / "instruction_forms.csv"

# 본문(instruction reference) 페이지 범위. AAA(첫 명령, PDF p.118)부터 시작.
# 108~117은 §3.1.1 해설/예외 표(인코딩 표가 아니라 analyze_header에서 자연 배제).
BODY_START = 118
BODY_END_FALLBACK = 2393  # APPENDIX A 시작(진단으로 확인). 동적 감지도 병행.

# ----------------------------------------------------------------------
# opcode 토큰 판별: 병합 셀(col0)에서 opcode 부분과 instruction 부분을 나눌 때 사용.
# instruction form은 "첫 번째 non-opcode 토큰(=니모닉)"부터 시작한다.
# ----------------------------------------------------------------------
_OPCODE_WORDS = {
    "NP", "NFx", "REX", "REX.W", "REX.W+", "REX.R", "VEX", "EVEX", "MVEX", "XOP",
    "0F", "0F38", "0F3A", "66", "F2", "F3", "F2H", "F3H", "9B",
    "ib", "iw", "id", "io", "is4", "/is4", "cb", "cw", "cd", "cp", "ct",
    "imm8", "imm16", "imm32", "imm64", "imm",     # 일부 표는 opcode칸에 imm8 표기
    "+rb", "+rw", "+rd", "+ro", "+i", "+", "o64", "o32", "a32", "a16",
    "m64", "vm32x", "vm32y", "vm32z", "vm64x", "vm64y", "vm64z", "/vsib", "vsib",
    "WIG", "W0", "W1", "LIG", "LLIG", "LZ",
}


def _is_opcode_token(tok: str) -> bool:
    """토큰이 opcode/인코딩 표기이면 True (니모닉이면 False)."""
    tok = tok.rstrip(",*")                           # 각주 콤마/별표 제거 (E0, → E0)
    if tok in _OPCODE_WORDS:
        return True
    if re.fullmatch(r"[0-9A-Fa-f]{2}", tok):        # 16진수 바이트 (58, 0F ...)
        return True
    if re.fullmatch(r"/[0-7r]", tok):               # ModRM 확장 /r, /0../7
        return True
    if re.fullmatch(r"[0-9A-Fa-f]{2}/[0-7r]", tok): # 글루된 56/r
        return True
    if re.fullmatch(r"/i[bwd]|/is[45]|/ib", tok):   # 즉시값 표기 /ib /iw /id /is4
        return True
    if ":" in tok and re.search(r"11\)|rrr|bbb|reg|:rm|:100|:000|mod", tok):
        return True                                 # ModRM 지정자 !(11):rrr:bbb 등
    if "." in tok and re.match(r"(VEX|EVEX|MVEX|XOP|REX)\.", tok):  # VEX.128.66.0F38.W1
        return True
    if re.fullmatch(r"\+r[bwdo]", tok):             # +rb/+rw/+rd/+ro
        return True
    if re.fullmatch(r"(REX\.?W?\+?)", tok):
        return True
    return False


def _normalize_opcode_artifacts(text: str) -> str:
    """
    벡터표 col0의 opcode 부분에 붙는 각주/글루 아티팩트를 정규화한다.
    (SDM PDF 파싱 시 흔한 케이스)
      "66 0F E0, /r"  → "66 0F E0 /r"   (16진수 뒤 각주 콤마)
      "66 0F 56/r"    → "66 0F 56 /r"   (16진수와 /r 글루)
      "NP 0F E0 /r1"  → "NP 0F E0 /r"   (/r 뒤 각주 숫자)
    """
    text = re.sub(r"\b([0-9A-Fa-f]{2}),", r"\1", text)          # 16진수 뒤 콤마 제거
    # 독립 괄호 주석만 제거: 앞뒤가 공백인 '( ... )' (예: (mod!=11, /5, memory only)).
    # '!(11):rrr:bbb' 처럼 토큰에 붙은 괄호는 건드리지 않는다.
    text = re.sub(r"(?<=\s)\([^)]*\)(?=\s|$)", " ", text)
    text = re.sub(r"\b([0-9A-Fa-f]{2})(/[0-7r])", r"\1 \2", text)  # 글루 분리
    text = re.sub(r"(/[0-7r])\d\b", r"\1", text)               # /r1 → /r
    text = re.sub(r"([A-Za-z])-\s+([A-Za-z])", r"\1\2", text)   # 줄바꿈 하이픈 결합 (AES- ENC → AESENC)
    return re.sub(r"\s+", " ", text).strip()


def split_merged_cell(cell: str) -> tuple[str, str]:
    """
    병합형 col0("VEX.128.66.0F38.W1 98 /r VFMADD132PD xmm1, ...")을
    (opcode, instruction) 로 분리한다.
    니모닉 = 첫 번째 non-opcode 토큰. 그 지점 이후 전체가 instruction form.
    """
    text = re.sub(r"\s+", " ", cell.replace("\n", " ")).strip()
    text = _normalize_opcode_artifacts(text)
    tokens = text.split(" ")
    idx = 0
    while idx < len(tokens) and _is_opcode_token(tokens[idx]):
        idx += 1
    # 안전장치: 니모닉을 못 찾으면(전부 opcode처럼 보이면) 마지막 토큰을 니모닉으로
    if idx >= len(tokens):
        idx = len(tokens) - 1 if tokens else 0
    opcode = " ".join(tokens[:idx]).strip()
    instruction = " ".join(tokens[idx:]).strip()
    return opcode, instruction


# ----------------------------------------------------------------------
# 각주(superscript) 정리: r/m8 뒤 각주 숫자 등. 기존 로직 계승 + 벡터 대응.
# ----------------------------------------------------------------------
def clean_instruction_text(text: str) -> str:
    text = re.sub(r"\s+", " ", text.replace("\n", " ")).strip()
    # 오퍼랜드 타입 뒤 각주 숫자 (r/m8 1, r/m162 등)
    text = re.sub(r"r/m(8|16|32|64)\s*\d\b", r"r/m\1", text)
    text = re.sub(r"\br(8|16|32|64)\d\b", r"r\1", text)
    text = re.sub(r"\bm(8|16|32|64)\d\b", r"m\1", text)
    text = re.sub(r"imm(8|16|32|64)\d\b", r"imm\1", text)
    text = re.sub(r"moffs(8|16|32|64)\d\b", r"moffs\1", text)
    text = re.sub(r"Sreg\d\b", "Sreg", text)
    # FN* 니모닉에 붙은 각주 1 (FNSTSW1 → FNSTSW, FNCLEX1 → FNCLEX 등)
    text = re.sub(r"\b(FN[A-Z]+)1\b", r"\1", text)
    return text.strip()


# ----------------------------------------------------------------------
# 헤더 분석: 컬럼 이름 → 인덱스
# ----------------------------------------------------------------------
def _norm(cell) -> str:
    return re.sub(r"\s+", " ", str(cell or "").replace("\n", " ")).strip().lower()


def _looks_like_instruction_cell(cell: str) -> bool:
    """데이터 셀이 instruction form처럼 보이는지 (니모닉으로 시작 + 오퍼랜드)."""
    s = re.sub(r"\s+", " ", str(cell or "").replace("\n", " ")).strip()
    if not s or len(s) > 120:
        return False
    if not re.match(r"^[A-Z][A-Za-z0-9]", s):   # 대문자 니모닉 시작
        return False
    # Op/En 코드("RM","A","RVMI"), 모드값("V/V") 등 짧은 코드 배제
    if re.fullmatch(r"[A-Z]{1,5}\d?", s) or "/" in s.split(" ")[0] and len(s) < 6:
        return False
    return True


def _find_instruction_column(table: list, exclude: int) -> int | None:
    """
    표 본문에서 instruction form이 들어있는 컬럼을 찾는다.
    (헤더는 'Opcode/Instruction' 병합처럼 보이지만 실제 데이터는 컬럼이
     분리된 CRC32 류 대응.)
    """
    body = [r for r in table[1:] if r and any(c for c in r)]
    if not body:
        return None
    ncol = max(len(r) for r in body)
    best_idx, best_score = None, 0
    for ci in range(ncol):
        if ci == exclude:
            continue
        score = 0
        for r in body[:6]:
            if ci < len(r) and _looks_like_instruction_cell(r[ci]):
                score += 1
        if score > best_score:
            best_score, best_idx = score, ci
    # 최소 절반 이상의 표본이 instruction처럼 보여야 채택
    return best_idx if best_score >= max(1, len(body[:6]) // 2) else None


def analyze_header(table: list) -> dict | None:
    """
    표(헤더+본문)를 보고 인코딩 표인지 판별하고 컬럼 인덱스를 반환.
    반환 dict: {layout, opcode, instruction(optional), mode(optional)}
    인코딩 표가 아니면 None.
    """
    header = table[0] if table else []
    cells = [_norm(c) for c in header]
    if not cells:
        return None

    # 첫 번째 비어있지 않은 셀
    first_idx = next((i for i, c in enumerate(cells) if c), None)
    if first_idx is None:
        return None
    first = cells[first_idx]
    if not first.startswith("opcode"):
        return None

    info: dict = {"opcode": first_idx}

    # mode 컬럼 찾기 (legacy: '64-bit mode', vector: '64/32 ... mode support')
    mode_idx = None
    for i, c in enumerate(cells):
        if "64-bit mode" in c or "64/32" in c or "mode support" in c:
            mode_idx = i
            break
    if mode_idx is not None:
        info["mode"] = mode_idx

    if "instruction" in first:
        # "opcode/instruction" 병합처럼 보이는 형태(벡터/SSE).
        # 단, CRC32 류는 헤더만 병합이고 데이터는 컬럼이 분리돼 있으므로 검증한다:
        # col0 데이터를 split_merged 해서 니모닉이 안 나오면 별도 instruction 컬럼을 찾는다.
        info["layout"] = "merged"
        sample = next(
            (r for r in table[1:] if r and first_idx < len(r) and r[first_idx]),
            None,
        )
        if sample is not None:
            _, instr = split_merged_cell(str(sample[first_idx]))
            if not instr or not re.match(r"^[A-Za-z]", instr):
                ii = _find_instruction_column(table, exclude=first_idx)
                if ii is not None:
                    info["layout"] = "split"
                    info["instruction"] = ii
    else:
        # 분리형: 별도 'instruction' 컬럼 필요 (legacy 6-컬럼, GETSEC 3-컬럼)
        instr_idx = next((i for i, c in enumerate(cells) if c == "instruction"), None)
        if instr_idx is None:
            return None
        info["layout"] = "split"
        info["instruction"] = instr_idx

    return info


# 64-bit 모드에서 무효인 값
_INVALID_LEGACY = {"invalid", "i", "n.e.", "n.s.", "n/a"}


def is_valid_64bit(mode_cell: str, layout: str) -> bool:
    """64-bit 모드에서 유효한 form인지. mode 정보가 없으면 True."""
    v = _norm(mode_cell).replace(" ", "")   # 'N. E.'(공백 아티팩트) → 'n.e.'
    if not v:
        return True
    if layout == "merged":
        # "V/V", "I/V", "V/N.E." → '/' 앞이 64-bit 지원 여부
        sup = v.split("/")[0].strip()
        return sup.startswith("v")
    else:
        return v not in _INVALID_LEGACY


# 니모닉 패턴 (instruction form의 첫 토큰). 대문자로 시작.
_MNEMONIC_RE = re.compile(r"^[A-Za-z][A-Za-z0-9]*")


def looks_like_instruction(instr: str) -> bool:
    if not instr or len(instr) > 120:
        return False
    first = instr.split(" ", 1)[0] if instr else ""
    # 헤더 잔재/노이즈 배제
    if _norm(instr).startswith(("instruction", "opcode", "reserved", "operand", "notes")):
        return False
    # 진짜 명령어 니모닉은 대문자다. 니모닉 코어(뒤의 [LEAF] 제거)가
    # 대문자+숫자 형태가 아니면(=소문자 단어/설명문 조각/레지스터 나열) 배제한다.
    #   허용:  ADC, VFMADD132PD, UD2, VEXTRACTF32x4, GETSEC[CAPABILITIES]
    #   배제:  iopl, dividend, nan, dest, ax, "DX:AX"(콜론), "source 1"(소문자시작)
    core = re.sub(r"\[.*$", "", first)          # GETSEC[CAPABILITIES] → GETSEC
    if not re.fullmatch(r"[A-Z][A-Za-z0-9]+", core):
        return False
    return True


def _looks_like_opcode(op: str) -> bool:
    """opcode 문자열이 진짜 인코딩 표기인지. 설명 표의 'Condition'/'Mode'/'' 등 배제."""
    if not op:
        return False
    return bool(re.search(
        r"\b[0-9A-Fa-f]{2}\b|VEX|EVEX|MVEX|XOP|REX|\b0F\b|\bNP\b|\bNFx\b|/r|/[0-7]",
        op,
    ))


def _row_to_form(row: list, info: dict, pno: int) -> dict | None:
    """한 행을 instruction form dict로 변환. 인코딩 행이 아니면 None."""
    if not row or all(not c for c in row):
        return None

    if info["layout"] == "merged":
        oi = info["opcode"]
        merged = row[oi] if oi < len(row) else ""
        if not merged:
            return None
        opcode, instruction = split_merged_cell(str(merged))
        # merged 행이 진짜 인코딩 행이려면 opcode 부분이 비어있지 않아야 한다
        # (operand-encoding 표의 'A | N/A | ...' 같은 행 배제 → 연속표 오탐 방지)
        if not opcode:
            return None
        source_cell = str(merged)
    else:
        oi = info["opcode"]
        ii = info["instruction"]
        opcode = str(row[oi]) if oi < len(row) and row[oi] else ""
        instruction = str(row[ii]) if ii < len(row) and row[ii] else ""
        opcode = re.sub(r"\s+", " ", opcode.replace("\n", " ")).strip()
        source_cell = instruction

    # opcode 칸이 진짜 opcode 형태가 아니면 배제.
    # (FPU 조건코드표/MWAIT 확장표 등 '설명 표'가 연속표로 잘못 흡수되는 것 방지:
    #  예) 'C3 | Condition | C2' 는 opcode='Condition' 이라 걸러진다.)
    if not _looks_like_opcode(opcode):
        return None

    instruction = clean_instruction_text(instruction)
    if not looks_like_instruction(instruction):
        return None

    mode_cell = ""
    if "mode" in info and info["mode"] < len(row):
        mode_cell = str(row[info["mode"]] or "")
    # Stage 1은 PDF의 모든 form을 그대로 추출한다(64비트 무효 필터 제거).
    # 64비트 유효/무효 판단은 mode_support 컬럼을 근거로 후속 단계에서 수행한다.
    # (AAA/AAD/AAM/AAS/DAA/DAS/BOUND/PUSHA/POPA 등 legacy 명령 포함,
    #  "64비트 무효 opcode" 음성 테스트 재료로도 활용 가능.)

    return {
        "page": pno,
        "layout": info["layout"],
        "mnemonic": instruction.split(" ", 1)[0],
        "instruction": instruction,
        "opcode": opcode,
        "mode_support": re.sub(r"\s+", " ", mode_cell.replace("\n", " ")).strip(),
        "source_cell": re.sub(r"\s+", " ", source_cell.replace("\n", " ")).strip(),
    }


def _is_continuation_table(table: list, info: dict) -> bool:
    """
    헤더가 없는 표가 직전 인코딩 표의 '연속(다음 페이지로 넘어간)'인지 판정.
    첫 번째 유효 데이터 행이 info 레이아웃으로 파싱돼 니모닉 form이 나오면
    연속으로 본다. (operand-encoding 표 등은 opcode가 비어 배제된다.)
    """
    for row in table:
        if not row or all(not c for c in row):
            continue
        return _row_to_form(row, info, -1) is not None
    return False


def extract() -> list[dict]:
    rows: list[dict] = []
    seen: set[tuple] = set()
    t0 = time.time()

    # 다음 페이지로 넘어간 헤더 없는 연속 표 처리를 위해 직전 인코딩 표 정보를 기억
    pending_info: dict | None = None
    pending_page = -10

    def add_rows(table_rows, info, pno):
        added = 0
        for row in table_rows:
            form = _row_to_form(row, info, pno)
            if form is None:
                continue
            key = (form["opcode"], form["instruction"])
            if key in seen:
                continue
            seen.add(key)
            rows.append(form)
            added += 1
        return added

    with pdfplumber.open(str(PDF)) as pdf:
        n = len(pdf.pages)
        for pno in range(BODY_START, min(n, BODY_END_FALLBACK + 5)):
            page = pdf.pages[pno]
            text = page.extract_text() or ""
            head = "\n".join(text.splitlines()[:2])
            if "APPENDIX A" in head:
                print(f"[APPENDIX A 감지 @ {pno}] 본문 파싱 종료")
                break

            for table in page.extract_tables() or []:
                if not table or len(table) < 2:
                    continue
                info = analyze_header(table)
                if info is not None:
                    pending_info = info
                    pending_page = pno
                    add_rows(table[1:], info, pno)
                elif pending_info is not None and pno - pending_page <= 1 \
                        and _is_continuation_table(table, pending_info):
                    # 헤더 없는 연속 표: 직전 표의 컬럼 구조로 전체 행 파싱
                    if add_rows(table, pending_info, pno):
                        pending_page = pno   # 3페이지 이상 연속 대비

            if pno % 200 == 0:
                print(f"  ...page {pno} ({time.time()-t0:.0f}s, {len(rows)} forms)")

    print(f"[완료] {len(rows)} instruction forms, {time.time()-t0:.0f}s")
    return rows


def main():
    OUT_CSV.parent.mkdir(parents=True, exist_ok=True)
    rows = extract()

    with OUT_CSV.open("w", newline="", encoding="utf-8-sig") as f:
        w = csv.DictWriter(f, fieldnames=[
            "page", "layout", "mnemonic", "instruction", "opcode", "mode_support", "source_cell"
        ])
        w.writeheader()
        w.writerows(rows)

    mnem = sorted({r["mnemonic"] for r in rows})
    from collections import Counter
    layout_cnt = Counter(r["layout"] for r in rows)
    print(f"[저장] {OUT_CSV}")
    print(f"  총 form: {len(rows)}, 고유 니모닉: {len(mnem)}")
    print(f"  레이아웃: {dict(layout_cnt)}")
    v = [m for m in mnem if m.startswith("V")]
    print(f"  V로 시작하는 니모닉: {len(v)}")

    # 애매 케이스 확인
    print("\n=== 확인: 애매했던 케이스들의 실제 form ===")
    for target in ["VMOVDQU", "VFMADD132", "MOVDQA", "VMOVDQA", "INT", "VPBROADCAST", "GETSEC"]:
        sample = [r["instruction"] for r in rows if r["mnemonic"].startswith(target)][:4]
        print(f"  {target:12s}: {sample}")


if __name__ == "__main__":
    main()

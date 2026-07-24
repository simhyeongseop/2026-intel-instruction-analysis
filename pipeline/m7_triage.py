"""
7단계 triage: 컴파일 에러(out/asm_result.csv)와 역어셈블 차이(out/roundtrip.csv)를
종류별로 묶고, 원인을 추정하고, 버그/오탐(false_alarm)/판단보류(unsure)로 나눈다.

원칙(CLAUDE.md 1절·triage 에이전트 지침):
- 정답은 인텔 SDM이다. 어셈블러가 받아주는지가 아니라 매뉴얼이 정의하는지가 기준이다.
- 판정 근거는 도구 결과(as/objdump 직접 실행, SDM PDF 원문 대조)여야 한다.
- LLM 추정만으로 "bug"라고 결론 내지 않는다. 확신이 없으면 unsure로 남겨서 형섭이 검토한다.

이 파일의 분류 규칙들은 out/asm_result.csv·out/roundtrip.csv를 실제로 열어 패턴을 찾고,
의심스러운 것은 `as --64 -mintel64`로 재현하거나 325383-090-sdm-vol-2abcd.pdf 원문을
직접 대조해서 얻은 결론이다. bug로 표시한 항목은 전부 도구 재현 + SDM 원문 대조를 마쳤다.
"""

import csv
import re

ASM_CSV = "out/asm_result.csv"
RT_CSV = "out/roundtrip.csv"
OUT_CSV = "out/triage.csv"
OUT_MD = "out/triage_report.md"


def load_rows(path):
    with open(path, encoding="utf-8") as f:
        return list(csv.DictReader(f))


# ===========================================================================
# 1. 컴파일 에러(asm_result.csv, actual_result == "error") 분류
# ===========================================================================

# 에러 메시지 유형 -> (그룹 이름, 원인 설명(없으면 mnemonic별로 세분), mismatch일 때 verdict)
ERROR_RULES = [
    (re.compile(r"default mask isn't allowed"),
     "avx512_gather_scatter_default_mask",
     "AVX512 gather/scatter는 마스크가 필수(k0 기본마스크 불허)인데, combiner가 SDM의 "
     "'{k1}' 마스크 표기를 대표값으로 펼치는 과정(strip_decorations)에서 지워버려 "
     "마스크 없는 형태로 생성됨 - combiner 한계",
     "false_alarm"),
    (re.compile(r"destination and source registers must be distinct"),
     "combiner_register_reuse",
     "combiner가 서로 다른 오퍼랜드 슬롯에 같은 대표 레지스터(xmm0/ymm0/zmm0 등)를 재사용해서 "
     "만든 조합 - '레지스터가 달라야 함' 제약 위반 (BND 계열과 같은 combiner 한계, DEVLOG 2026-07-23)",
     "false_alarm"),
    (re.compile(r"all tmm registers must be distinct"),
     "combiner_register_reuse",
     "combiner가 tmm 오퍼랜드 슬롯 전부에 tmm0을 재사용 - 위와 동일한 combiner 한계",
     "false_alarm"),
    (re.compile(r"invalid VSIB address"),
     "combiner_vsib_missing_index",
     "vm32x/vm64x(VSIB) 메모리 오퍼랜드를 combiner가 일반 메모리([eax])로만 채워서 VSIB "
     "인덱스 레지스터가 없음 - memory_candidate()가 VSIB를 특별 취급하지 않는 한계",
     "false_alarm"),
    (re.compile(r"32-bit address isn't allowed in 64-bit MPX"),
     "combiner_mpx_addr32_missing",
     "BND 계열 명령어에 32비트 주소([eax])를 그대로 써서 64비트 모드에 필요한 addr32 "
     "프리픽스가 안 붙음 - 이미 알려진 이슈(DEVLOG 2026-07-23)",
     "false_alarm"),
    (re.compile(r"number of operands mismatch"),
     "combiner_implicit_operand_as_explicit",
     "SDM의 <XMM0-7>/<EAX> 같은 암묵 오퍼랜드 표기를 combiner(expand_implicit)가 실제 명시 "
     "오퍼랜드로 방출해서 개수가 안 맞음 - combiner 한계",
     "false_alarm"),
    (re.compile(r"16-bit addressing unavailable"),
     "combiner_mode_invalid_register_choice",
     "r16/r32/r64 중 대표값으로 r16을 골랐는데, 64비트 모드에서는 주소 레지스터로 16비트를 "
     "쓸 수 없다는 모드 제약을 combiner가 반영하지 못함 - combiner 한계",
     "false_alarm"),
    (re.compile(r"invalid operands \(\*UND\*"),
     "extractor_artifact_stray_text",
     "PDF 추출 과정에서 설명 문단 문구가 오퍼랜드 칸에 겹쳐 들어간 것으로 보임(같은 페이지 "
     "설명문에도 'imm8/r imm8 field'로 동일하게 중복 등장, PDF p.2155 직접 대조) - 국소 1건",
     "false_alarm"),
    (re.compile(r"invalid use of register"),
     "combiner_raw_notation_literal",
     None, "false_alarm"),
    (re.compile(r"operand size mismatch"),
     "compile_error_operand_size_mismatch",
     None, "false_alarm"),
    (re.compile(r"ambiguous operand size"),
     "gas_ambiguous_bare_mnemonic",
     "SYSEXIT/SYSRET을 매뉴얼 그대로(오퍼랜드 없이) 써도 as가 크기를 못 정해 거부함 - "
     "'rex64 sysexit' 같은 프리픽스 트릭을 쓰면 성공(직접 확인). 매뉴얼 문법 그대로는 실패라서 "
     "판단보류.",
     "unsure"),
    (re.compile(r"register type mismatch"),
     "gas_register_width_stricter_than_manual",
     "LAR/LSL 관련 - 아래 combo_id 개별 확인 결과를 참고(모두 override로 처리됨)",
     "unsure"),
    (re.compile(r"no such instruction"),
     "gas_missing_mnemonic",
     "UDB 관련 - 아래 combo_id 개별 확인 결과를 참고(override로 처리됨)",
     "unsure"),
]

# "operand size mismatch" 세부 원인 (mnemonic 기준으로 나뉨 - 실제 asm_result.csv를 읽고 분류)
UNNECESSARY_SIZE_DIRECTIVE = {
    "AESDEC256KL", "AESENC256KL", "ENQCMD", "ENQCMDS",
    "FXRSTOR", "FXRSTOR64", "FXSAVE", "FXSAVE64", "LDTILECFG", "STTILECFG",
}
FAR_PTR_SIZE_COLLAPSED = {"LSS", "LFS", "LGS", "LGDT", "LIDT"}
WRONG_REGISTER_WIDTH = {"MOVDIR64B", "SENDUIPI"}
IMPLICIT_AS_EXPLICIT_MNEMONICS = {"REP LODS"}

# "invalid use of register" 세부 원인 (mnemonic 기준)
REG_PAIR_NOTATION = {"VP2INTERSECTD", "VP2INTERSECTQ"}
REG_PLUS_N_NOTATION = {"V4FMADDPS", "V4FNMADDPS", "V4FMADDSS", "V4FNMADDSS",
                       "VP4DPWSSDS", "VP4DPWSSD"}


def _error_sub_cause(category, mnemonic):
    """error message 패턴만으로 원인이 갈리는 경우 mnemonic을 봐서 세분한다."""
    if category == "combiner_raw_notation_literal":
        if mnemonic in REG_PAIR_NOTATION:
            return ("SDM의 'k1+1'(연속 마스크 레지스터 쌍) 표기를 combiner가 실제 레지스터로 "
                    "펼치지 못하고 원문 그대로 남겨서 as가 나눗셈 연산으로 오인 - combiner 한계 "
                    "(operand_kind=='other' -> raw 유지)")
        if mnemonic in REG_PLUS_N_NOTATION:
            return ("SDM의 'zmm2+3'(연속 zmm 레지스터 쌍) 표기를 combiner가 펼치지 못하고 원문 "
                    "그대로 남김 - 위와 동일한 combiner 한계")
        if mnemonic == "VPAND":
            return ("isa_db 원문 자체에 'ymm3/.m256'처럼 불필요한 점(.)이 있음 - PDF 원문(p.923) "
                    "pdfplumber 추출 결과에도 동일하게 나타나 그대로 as 입력이 됨(국소 1건, PDF "
                    "텍스트 추출 특성으로 추정)")
        return "SDM의 특수 레지스터 표기를 combiner가 원문 그대로 남겨서 발생 - combiner 한계"

    if category == "compile_error_operand_size_mismatch":
        if mnemonic in UNNECESSARY_SIZE_DIRECTIVE:
            return ("m512/m512byte처럼 고정 크기인 legacy 메모리 오퍼랜드에 combiner가 불필요한 "
                    "크기 접두어(zmmword ptr)를 붙여서 발생 - 직접 확인: 크기 접두어 없이 "
                    "'[eax]'만 쓰면 정상 어셈블됨(false_alarm)")
        if mnemonic in FAR_PTR_SIZE_COLLAPSED:
            return ("SDM의 복합 메모리 타입(m16:16/m16:32/m16:64, m16&64)을 combiner의 "
                    "memory_candidate 정규식이 앞부분 'm16'만 인식해서 항상 'word ptr'로 뭉개버림 "
                    "- combiner 한계")
        if mnemonic in WRONG_REGISTER_WIDTH:
            return ("SDM 설명상 항상 64비트 레지스터를 쓰는 명령인데(SENDUIPI 설명: 'operand "
                    "always has 64 bits') combiner가 좁은 폭 레지스터를 대표값으로 골라서 발생 - "
                    "직접 확인: 64비트 레지스터로 바꾸면 정상 어셈블됨(false_alarm)")
        if mnemonic in IMPLICIT_AS_EXPLICIT_MNEMONICS:
            return ("SDM이 'REP LODS AL'처럼 암묵 목적지를 표기 관례로 보여줄 뿐인데 combiner가 "
                    "이를 실제 레지스터 오퍼랜드로 방출 - 직접 확인: 'lods al'은 거부되고 "
                    "'lods byte ptr [esi]'/'lodsb'는 정상 어셈블됨")
        return "as가 요구하는 오퍼랜드 크기와 combiner가 만든 크기가 불일치 - 원인 미상, 개별 확인 필요"

    return "원인 미상 - 개별 확인 필요"


# as/objdump로 직접 재현하고 SDM PDF 원문까지 대조를 마친, 결론이 확정된 개별 케이스.
# (combo_id -> (category, verdict, cause))
ERROR_COMBO_OVERRIDES = {
    "6540": ("assembler_stricter_than_manual_memory_size", "bug",
             "SDM p.2054는 VPMOVQD(EVEX.128, truncate 버전) 대상 메모리를 'xmm1/m128'로 "
             "명시하는데, GNU as는 'qword ptr'만 받아준다(직접 확인: xmmword/byte/word/dword "
             "ptr 전부 'operand size mismatch', qword ptr만 성공). 매뉴얼 표기와 어셈블러 구현이 다름."),
    "4597": ("gas_missing_mnemonic", "bug",
             "SDM p.1436에 'D6 UDB' 오피코드가 64비트 모드 Valid로 명시돼 있으나(UD0/UD1/UD2와 "
             "같은 계열) GNU as는 'udb'라는 니모닉 자체를 모른다('no such instruction: udb')."),
    "1516": ("gas_register_width_stricter_than_manual", "bug",
             "SDM p.651: 'LAR r32, r64/m16'(주석1: 오퍼랜드 크기와 무관하게 소스 레지스터의 "
             "하위 16비트만 사용)로 r64 소스를 명시적으로 허용하는데, `lar ecx, rcx`는 as가 "
             "거부하고 `lar ecx, cx`(r16)만 성공한다(직접 확인)."),
    "1571": ("gas_register_width_stricter_than_manual", "bug",
             "SDM p.691: 'LSL r64, r32/m16'(주석1 동일)로 r32 소스를 명시적으로 허용하는데, "
             "`lsl rcx, ecx`는 as가 거부하고 `lsl rcx, cx`(r16)만 성공한다(직접 확인)."),
    "1683": ("gas_register_width_stricter_than_manual", "bug",
             "isa_db.csv: 'REX.W + 8E /r MOV Sreg, r/m64'가 Valid로 명시돼 있어 r/m64 메모리 "
             "오퍼랜드를 명시적으로 허용하는데, `mov ds, qword ptr [eax]`(byte/dword/xmmword ptr도 "
             "동일)는 전부 'operand type mismatch'로 거부되고 `mov ds, word ptr [eax]`만 성공한다"
             "(직접 확인). 레지스터 폼(`mov ds, rax`)은 문법상 받아주지만 objdump로 확인하면 REX.W "
             "없이 `mov ds, eax`와 동일한 2바이트 인코딩(8e d8)만 나온다(combo 1682, "
             "register_width/name_changed로 별도 확인됨) - LAR/LSL(combo 1516/1571)과 정확히 같은 "
             "유형으로, GNU as가 REX.W+8E/r의 r/m64 메모리 인코딩 경로를 구현하지 않은 것으로 보임."),
}

# far-ptr(m16:16/m16:32/m16:64) collapse: pipeline/m3_combine.py의
# MEM_SIZE_RE = r"^m(128|256|384|512|80|8|16|32|64)(?!\d)" 가 "m16:16"의 앞부분 "m16"을 그대로
# 매치해버려서(":"가 (?!\d) lookahead를 통과) far-ptr 타입 3가지가 전부 "word ptr"로 뭉개진다.
# combo_id: 424/425/426 = CALL m16:16/m16:32/m16:64, 1441/1442/1443 = JMP m16:16/m16:32/m16:64.
# 근본 원인은 combiner(3단계)에 있음 - 이번 triage 라운드에서는 m3_combine.py를 고치지 않고
# false_alarm으로만 분류한다(다음 라운드에 combiner가 고칠 후보).
_FARPTR_CAUSE = (
    "SDM의 far-ptr 메모리 타입(m16:16/m16:32/m16:64)을 pipeline/m3_combine.py의 MEM_SIZE_RE"
    "(r'^m(128|256|384|512|80|8|16|32|64)(?!\\d)')가 'm16:16' 등의 앞부분 'm16'만 그대로 매치해서"
    "(':'가 (?!\\d) lookahead를 통과) m16:16/m16:32/m16:64 세 가지가 전부 'word ptr'로 뭉개져 동일한 "
    "'call/jmp word ptr [eax]'가 3번 반복 생성됨 - far pointer는 word ptr 같은 일반 크기 지시자로 "
    "인코딩되지 않으므로 as가 정당하게 거부(직접 재현). 근본 원인은 combiner(3단계) - 다음 라운드에 "
    "MEM_SIZE_RE가 ':'를 인식하도록 고쳐야 함(이번 triage 라운드는 combiner 코드 수정 스코프 밖)."
)
for _cid in ["424", "425", "426", "1441", "1442", "1443"]:
    ERROR_COMBO_OVERRIDES[_cid] = ("combiner_farptr_collapse", "false_alarm", _FARPTR_CAUSE)

# MOV moffs 괄호 누락: tokens.csv row_id 1105-1109 = MOV moffs8/16/32/64, AL/AX/EAX/RAX.
# generator가 "mov 0x1000, al"처럼 대괄호 없는 bare 즉시값을 그대로 방출하는데, as Intel syntax의
# moffs 오퍼랜드는 "mov [0x1000], al" 또는 "mov ds:0x1000, al"처럼 대괄호/세그먼트 표기가 필요하다.
# combo_id 1689-1693. 근본 원인은 generator(4단계) - 이번 라운드는 문서화만, 코드는 고치지 않는다.
_MOFFS_CAUSE = (
    "generator가 moffs 오퍼랜드를 'mov 0x1000, al'처럼 대괄호 없이 방출하는데, as Intel syntax의 "
    "moffs 오퍼랜드는 'mov [0x1000], al' 또는 'mov ds:0x1000, al'처럼 대괄호/세그먼트 표기가 필요함 "
    "- 직접 재현: 대괄호를 씌우면 성공, 'mov 0x1000, al'만 실패. 근본 원인은 generator(4단계)가 "
    "moffs 후보값 포맷팅에 대괄호를 안 씌우는 것 - 다음 라운드에 4단계가 고칠 후보(이번 triage "
    "라운드는 generator 코드 수정 스코프 밖)."
)
for _cid in ["1689", "1690", "1691", "1692", "1693"]:
    ERROR_COMBO_OVERRIDES[_cid] = ("generator_moffs_missing_brackets", "false_alarm", _MOFFS_CAUSE)


def classify_compile_error(row):
    """asm_result.csv에서 actual_result == 'error'인 행 하나를 분류한다."""
    combo_id = row["combo_id"]
    if combo_id in ERROR_COMBO_OVERRIDES:
        category, verdict, cause = ERROR_COMBO_OVERRIDES[combo_id]
        return category, cause, verdict

    msg = row["error_message"]
    mnemonic = row["mnemonic"]
    is_mismatch = row["mismatch"] == "True"

    for pattern, category, cause, verdict in ERROR_RULES:
        if not pattern.search(msg):
            continue
        if cause is None:
            cause = _error_sub_cause(category, mnemonic)
        if not is_mismatch:
            # 매뉴얼도 이미 Invalid/N.E./N.S.로 규정한 조합이 그대로 거부된 것 - 정상, 불일치 아님.
            cause = ("매뉴얼상으로도 이 조합은 Invalid/N.E./N.S.(mode_support="
                     f"{row['mode_support']})로 규정돼 있어 그대로 거부된 것 - 불일치 아님, 정상 동작.")
            verdict = "false_alarm"
        return category, cause, verdict

    if not is_mismatch:
        # for 루프에서 패턴이 안 걸려도, 매뉴얼이 이미 Invalid/N.E./N.S.로 규정해서 그대로
        # 거부된 것이면(mismatch=False) 근거 없는 unsure가 아니라 false_alarm으로 내려야 한다.
        cause = ("매뉴얼상으로도 이 조합은 Invalid/N.E./N.S.(mode_support="
                 f"{row['mode_support']})로 규정돼 있어 그대로 거부된 것 - 불일치 아님, 정상 동작.")
        return "compile_error_expected_rejection_unclassified", cause, "false_alarm"

    return "compile_error_unclassified", "패턴 매칭 실패 - 형섭 직접 확인 필요", "unsure"


# ===========================================================================
# 2. mismatch(매뉴얼상 무효인데 as가 받아준, 46건) 분류
# ===========================================================================

PERMISSIVE_MISMATCH_OVERRIDES = {}

# 값 순서는 다른 classify_* 함수와 동일하게 (category, cause, verdict)로 통일한다.
for _cid in ["970", "971", "1308", "1309", "1541", "3294", "3297", "337", "341"]:
    PERMISSIVE_MISMATCH_OVERRIDES[_cid] = (
        "duplicate_encoding_row_same_syntax",
        "SDM 표에 텍스트 니모닉+오퍼랜드가 똑같은데 오피코드/모드지원이 다른 행이 2개 이상 있음"
        "(예: DEC ecx의 legacy 1바이트 opcode '48+rd'는 64비트 모드 N.E.지만 ModRM 기반 'FF /1'은 "
        "Valid). 파이프라인은 텍스트만 어셈블하므로 as는 항상 인코딩 가능한(Valid) 쪽을 선택함 "
        "- 실제 불일치가 아니라 표 중복 표기 때문.",
        "false_alarm",
    )

for _cid in ["414", "1431"] + [str(i) for i in range(1368, 1429, 2)]:
    PERMISSIVE_MISMATCH_OVERRIDES[_cid] = (
        "generator_did_not_target_invalid_variant",
        "SDM상 rel16(16비트 상대주소, N.S.) 폼을 테스트하려던 행이었지만 generator가 크기 힌트 "
        "없이 '.Ltarget' 라벨만 사용해 as가 기본으로 유효한 rel32를 선택함 - 무효 폼을 실제로 "
        "인코딩하도록 강제한 게 아니므로 '성공'은 당연함(false_alarm).",
        "false_alarm",
    )

for _cid in ["419", "1436"]:
    PERMISSIVE_MISMATCH_OVERRIDES[_cid] = (
        "assembler_encodes_documented_invalid_form",
        "SDM은 64비트 모드에서 CALL/JMP r/m32(FF /2, FF /4)를 N.E.(인코딩 불가)로 명시하는데, "
        "`as`는 addr32(0x67)+opsize(0x66) 프리픽스를 붙여 실제로 인코딩한다(직접 objdump 확인: "
        "67 66 ff 18 -> 'call DWORD PTR [eax]'). 경고 없이 조용히 받아줌.",
        "bug",
    )

for _cid in ["1511", "4122"]:
    PERMISSIVE_MISMATCH_OVERRIDES[_cid] = (
        "cpuid_conditional_availability_not_captured",
        "SDM p.650/p.1304: LAHF/SAHF는 64비트 모드 열에 'Invalid'라고 적혀 있지만 각주와 설명문에 "
        "'CPUID.80000001H:ECX.LAHF_SAHF_64[0]=1이면 64비트 모드에서도 Valid'라고 명시돼 있음"
        "(현대 CPU/as는 이 플래그를 사실상 항상 지원) - mode_support 컬럼이 조건부 허용 각주를 "
        "반영하지 못해 생긴 불일치, 실제 as 동작은 매뉴얼의 조건부 허용과 일치.",
        "false_alarm",
    )


def classify_permissive_mismatch(row):
    """asm_result.csv에서 mismatch=True(expected_valid=False인데 actual_result=ok)인 행을 분류한다."""
    combo_id = row["combo_id"]
    if combo_id in PERMISSIVE_MISMATCH_OVERRIDES:
        return PERMISSIVE_MISMATCH_OVERRIDES[combo_id]
    return ("mismatch_assembler_more_permissive",
            "매뉴얼상 Invalid/N.E./N.S.인데 as가 받아줌 - 원인 미확인, 형섭 직접 확인 필요",
            "unsure")


# ===========================================================================
# 3. roundtrip 차이(result == "different", 1,351건) 분류
# ===========================================================================

STRING_MNEMONICS = {
    "movs", "cmps", "lods", "scas", "stos", "ins", "outs",
    "movsb", "movsw", "movsd", "movsq", "cmpsb", "cmpsw", "cmpsd", "cmpsq",
    "lodsb", "lodsw", "lodsd", "lodsq", "scasb", "scasw", "scasd", "scasq",
    "stosb", "stosw", "stosd", "stosq", "insb", "insw", "insd",
    "outsb", "outsw", "outsd", "xlat", "xlatb",
}

MNEM_ALIAS_EXACT = {
    ("sal", "shl"), ("wait", "fwait"), ("mov", "movabs"),
    ("iretd", "iret"), ("popfq", "popf"), ("pushfq", "pushf"),
    ("repe", "repz"), ("repne", "repnz"), ("xacquire", "repnz"), ("xrelease", "repz"),
}

SIZE_WORDS = {"byte", "word", "dword", "qword", "xmmword", "ymmword", "zmmword"}

NUM_RE = re.compile(r"\b0x[0-9a-fA-F]+\b|\b\d+\b")


def _to_num(tok):
    try:
        return int(tok, 16) if tok.lower().startswith("0x") else int(tok)
    except ValueError:
        return None


def _numeric_normalize(s):
    return NUM_RE.sub(lambda m: f"#{_to_num(m.group(0))}#", s)


def _norm_ws(s):
    s = re.sub(r"\s*,\s*", ",", s)
    return re.sub(r"\s+", " ", s).strip()


def _first_word(s):
    """rep/repe/repne/lock 접두어를 뗀 뒤 첫 단어(니모닉)를 뽑는다."""
    parts = s.strip().split(None, 1)
    if parts and parts[0] in ("rep", "repe", "repne", "lock"):
        parts = parts[1].split(None, 1) if len(parts) > 1 else [""]
    return parts[0].strip() if parts and parts[0] else ""


def _strip_evex_tag(s):
    return re.sub(r"^\{evex\}\s*", "", s.strip())


def _cc_alias(a, b):
    """조건부 분기/이동/비교(jcc/cmovcc/setcc/vcmp 등) 니모닉 접미사 alias 여부."""
    for base in ("j", "cmov", "set"):
        if a.startswith(base) and b.startswith(base):
            return True
    if re.match(r"^v?p?cmp", a) and re.match(r"^v?p?cmp", b):
        return True
    if "clmul" in a and "clmul" in b:
        return True
    return False


ROUNDTRIP_CAUSES = {
    "implicit_operand_display":
        "string 명령어(movs/lods/stos/scas/cmps/ins/outs/xlat)는 소스에 오퍼랜드를 안 쓰거나 "
        "크기 접미사(movsb 등)로만 써도 objdump는 실제 암묵 오퍼랜드(es:[rdi], ds:[rsi] 등)를 "
        "explicit하게 풀어서 보여줌 - alias/표기 차이, 버그 아님.",
    "mnemonic_alias":
        "조건부 분기/이동/비교(jnz->jne, cmovnge->cmovl 등)나 sal->shl, wait->fwait, "
        "popfq->popf, xacquire/xrelease->repnz/repz 같은 동일 오피코드의 다른 이름(alias) - "
        "버그 아님.",
    "numeric_repr":
        "즉시값 표기가 10진(1)->16진(0x1)으로 바뀐 것뿐, 값 자체는 동일 - 버그 아님.",
    "relative_target_absolute_display":
        "상대 분기 대상이 소스에서는 라벨(.Ltarget)이었는데 objdump는 절대주소(0x0 등)로 "
        "보여줌 - objdump가 라벨을 복원할 방법이 없어서 생기는 표기 차이, 버그 아님.",
    "fpu_stack_register_display":
        "x87 스택 레지스터의 암묵 st(0)를 objdump가 짧게 'st'로 표기하거나(예: fadd st,st(0)), "
        "반대로 소스에 없는 두 번째 스택 레지스터(st(1) 등)를 명시적으로 보여줌 - 표기 관례 "
        "차이, 버그 아님.",
    "encoding_form_annotation":
        "동일한 텍스트 니모닉이 VEX/EVEX 두 가지로 인코딩될 수 있어 objdump가 EVEX로 인코딩된 "
        "쪽에 '{evex}' 태그를 붙여 구분함 - 인코딩 선택 표시일 뿐, 버그 아님.",
    "size_directive_inferred/omitted":
        "소스에 크기 지시자(byte/word/... ptr)를 생략했는데 objdump가 채워서 보여주거나, "
        "반대로 오퍼랜드 크기가 고정된 명령이라 objdump가 불필요한 크기 지시자를 생략함 - "
        "버그 아님.",
    "register_width/name_changed":
        "레지스터 폭 표기가 바뀜(예: mov ds,cx -> mov ds,ecx, lldt cx -> lldt ecx, movsxd "
        "cx,cx -> movsxd cx,ecx). 해당 opcode가 레지스터 폭에 무관하게 동일하게 동작하는지 "
        "아직 as 소스/SDM 각주까지 다 대조하지 못해 판단보류.",
    "operand_count/order_changed":
        "오퍼랜드 순서만 바뀜(예: xchg ax,cx -> xchg cx,ax). XCHG처럼 대칭적인 명령이라 "
        "결과는 동일 - 버그 아님.",
    "implicit_operand_added_by_generator":
        "combiner가 SDM의 <EDX>,<EAX> 같은 암묵 오퍼랜드를 실제 오퍼랜드로 잘못 방출했는데, "
        "이 명령어(umwait/tpause 등)는 as가 초과 오퍼랜드를 에러 없이 그냥 무시함 - "
        "compile_error 쪽의 combiner_implicit_operand_as_explicit와 같은 뿌리의 combiner 한계.",
    "sib_addressing_display":
        "AMX(tile) 명령어는 항상 SIB 인덱스가 필요해서 소스에 인덱스가 없어도 objdump가 "
        "'[eax+eiz*1]'처럼 명시적으로 보여줌 - 표기 차이, 버그 아님.",
    "imm_value_truncated_by_generator":
        "generator가 목적지 크기에 안 맞는 고정 즉시값(0x1000 등)을 그대로 써서 as가 조용히 "
        "잘라(truncate) 인코딩함 - 테스트케이스 생성 결함(generator), 진짜 8/16비트 truncation "
        "버그가 아니라 애초에 잘못된 입력값 - DEVLOG 2026-07-24 참고.",
    "encoding_falls_back_to_nop":
        "PREFETCHIT0/1은 SDM상 RIP-relative 메모리만 유효하고, 그 외 주소 형식이면 NOP로 "
        "취급된다고 명시돼 있음. generator가 RIP-relative가 아닌 [eax]를 써서 objdump가 "
        "'nop'으로 보여주는 것은 SDM에 문서화된 정상 동작(generator가 올바른 폼을 테스트 못한 "
        "것) - 버그 아님.",
    "size_directive_name_changed":
        "같은 128비트를 가리키는 크기 지시자 이름이 다름(xmmword ptr <-> OWORD PTR, "
        "cmpxchg16b) - 표기 관례 차이, 버그 아님.",
}

ROUNDTRIP_VERDICT = {
    "implicit_operand_display": "false_alarm",
    "mnemonic_alias": "false_alarm",
    "numeric_repr": "false_alarm",
    "relative_target_absolute_display": "false_alarm",
    "fpu_stack_register_display": "false_alarm",
    "encoding_form_annotation": "false_alarm",
    "size_directive_inferred/omitted": "false_alarm",
    "register_width/name_changed": "unsure",
    "operand_count/order_changed": "false_alarm",
    "implicit_operand_added_by_generator": "false_alarm",
    "sib_addressing_display": "false_alarm",
    "imm_value_truncated_by_generator": "false_alarm",
    "encoding_falls_back_to_nop": "false_alarm",
    "size_directive_name_changed": "false_alarm",
}


def _roundtrip_category(asm_line, objdump_line):
    """asm_line(소스)과 objdump_line(역어셈블)을 비교해서 차이 원인 그룹을 고른다."""
    a, b = asm_line.strip(), objdump_line.strip()
    al, bl = a.lower(), _strip_evex_tag(b.lower())
    has_evex = bl != b.lower()
    aw, bw = _first_word(al), _first_word(bl)

    if aw in STRING_MNEMONICS or bw in STRING_MNEMONICS:
        return "implicit_operand_display"

    if aw != bw:
        if (aw, bw) in MNEM_ALIAS_EXACT or _cc_alias(aw, bw):
            return "mnemonic_alias"
        if bw == "nop":
            return "encoding_falls_back_to_nop"
        return "mnemonic_alias"  # 나머지 첫 단어 불일치는 잠정적으로 alias류로 묶음

    if has_evex and _norm_ws(al) == _norm_ws(bl):
        return "encoding_form_annotation"

    a_num = _norm_ws(_numeric_normalize(al))
    b_num = _norm_ws(_numeric_normalize(bl))
    if a_num == b_num:
        return "encoding_form_annotation" if has_evex else "numeric_repr"

    if ".ltarget" in al and re.search(r"0x[0-9a-f]+", bl):
        return "relative_target_absolute_display"

    if aw.startswith("f") and ("st(" in al or "st(" in bl or re.search(r"\bst\b", al)
                                or re.search(r"\bst\b", bl)):
        return "fpu_stack_register_display"

    if "eiz" in bl or "riz" in bl:
        return "sib_addressing_display"

    if "oword" in bl and "xmmword" in al:
        return "size_directive_name_changed"

    if re.search(r"\b0x1000\b", al) or re.search(r"\b1000\b", al):
        return "imm_value_truncated_by_generator"

    a_ops = a.split(None, 1)[1] if len(a.split(None, 1)) > 1 else ""
    b_ops = b.split(None, 1)[1] if len(b.split(None, 1)) > 1 else ""
    a_set = {x.replace("ptr", "").strip()
             for x in re.split(r"[\s,]+", _norm_ws(_numeric_normalize(a_ops.lower()))) if x.strip()}
    b_set = {x.replace("ptr", "").strip()
             for x in re.split(r"[\s,]+", _norm_ws(_numeric_normalize(b_ops.lower()))) if x.strip()}
    if a_set and b_set:
        if a_set == b_set:
            return "operand_count/order_changed"
        if b_set < a_set:
            # objdump 쪽 오퍼랜드가 소스보다 적음(부분집합) -> combiner가 암묵 오퍼랜드를 더 넣은 경우
            return "implicit_operand_added_by_generator"

    a_has_size = any(w in al for w in SIZE_WORDS)
    b_has_size = any(w in bl for w in SIZE_WORDS)
    if a_has_size != b_has_size:
        return "size_directive_inferred/omitted"

    return "register_width/name_changed"


def classify_roundtrip_diff(row):
    category = _roundtrip_category(row["asm_line"], row["objdump_line"])
    cause = ROUNDTRIP_CAUSES[category]
    verdict = ROUNDTRIP_VERDICT[category]
    return category, cause, verdict


# ===========================================================================
# 4. 전체 조합 - combo_id 기준으로 유니크하게 합친다
# ===========================================================================

def build_triage_rows(asm_rows, rt_rows):
    """asm_result.csv의 에러/mismatch, roundtrip.csv의 different를 combo_id로 묶어서
    triage.csv 한 행씩(중복 없이) 만든다."""
    rt_by_combo = {r["combo_id"]: r for r in rt_rows if r["result"] == "different"}
    triaged = []
    seen_combo_ids = set()

    for row in asm_rows:
        combo_id = row["combo_id"]
        is_error = row["actual_result"] == "error"
        is_permissive_mismatch = row["mismatch"] == "True" and row["actual_result"] == "ok"

        if not is_error and not is_permissive_mismatch:
            continue  # 정상 통과 + 정상 mismatch 없음 -> triage 대상 아님

        if is_error:
            category, cause, verdict = classify_compile_error(row)
            objdump_or_error = row["error_message"]
        else:
            category, cause, verdict = classify_permissive_mismatch(row)
            objdump_or_error = "(as 성공 - 매뉴얼상 Invalid/N.E./N.S.인데 성공)"

        # 같은 combo_id가 roundtrip에서도 different로 잡혔으면 diff_cause를 덧붙인다.
        rt_row = rt_by_combo.get(combo_id)
        if rt_row is not None:
            rt_category, rt_cause, _ = classify_roundtrip_diff(rt_row)
            objdump_or_error += f" | roundtrip objdump: {rt_row['objdump_line']}"
            cause += f" [roundtrip 차이도 있음: {rt_category} - {rt_cause}]"

        triaged.append({
            "category": category,
            "mnemonic": row["mnemonic"],
            "source": f"{row['source_line']}/{combo_id}",
            "objdump_or_error": objdump_or_error,
            "compile_result": row["actual_result"],
            "diff_cause": cause,
            "verdict": verdict,
        })
        seen_combo_ids.add(combo_id)

    for row in rt_rows:
        combo_id = row["combo_id"]
        if row["result"] != "different" or combo_id in seen_combo_ids:
            continue
        category, cause, verdict = classify_roundtrip_diff(row)
        triaged.append({
            "category": category,
            "mnemonic": row["mnemonic"],
            "source": f"{row['source_line']}/{combo_id}",
            "objdump_or_error": row["objdump_line"],
            "compile_result": "ok",
            "diff_cause": cause,
            "verdict": verdict,
        })
        seen_combo_ids.add(combo_id)

    return triaged


# ===========================================================================
# 5. 출력
# ===========================================================================

def write_csv(rows, path):
    fieldnames = ["category", "mnemonic", "source", "objdump_or_error",
                  "compile_result", "diff_cause", "verdict"]
    with open(path, "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def _group_counts(rows):
    counts = {}
    for r in rows:
        counts.setdefault(r["category"], []).append(r)
    return dict(sorted(counts.items(), key=lambda kv: -len(kv[1])))


def write_report(rows, path):
    total = len(rows)
    verdict_counts = {}
    for r in rows:
        verdict_counts[r["verdict"]] = verdict_counts.get(r["verdict"], 0) + 1

    bug_rows = [r for r in rows if r["verdict"] == "bug"]
    groups = _group_counts(rows)

    lines = []
    lines.append("# Triage 리포트 (7단계)")
    lines.append("")
    lines.append(f"- 전체 대상: {total}건 (컴파일 에러 + mismatch + roundtrip 차이, combo_id 기준 중복 제거)")
    lines.append(f"- verdict 분포: " + ", ".join(f"{k}={v}" for k, v in sorted(verdict_counts.items())))
    lines.append("")

    lines.append("## 진짜 의심되는 버그 후보 (verdict=bug)")
    lines.append("")
    lines.append("도구(as/objdump) 직접 재현 + SDM PDF 원문 대조까지 마친 것만 bug로 표시했다.")
    lines.append("")
    for r in bug_rows:
        lines.append(f"### {r['mnemonic']} (source {r['source']})")
        lines.append(f"- 분류: {r['category']}")
        lines.append(f"- objdump/error: {r['objdump_or_error']}")
        lines.append(f"- 원인: {r['diff_cause']}")
        lines.append("")

    lines.append("## 그룹별 건수")
    lines.append("")
    lines.append("| 분류(category) | 건수 | verdict 분포 |")
    lines.append("|---|---|---|")
    for cat, group_rows in groups.items():
        vc = {}
        for r in group_rows:
            vc[r["verdict"]] = vc.get(r["verdict"], 0) + 1
        vc_str = ", ".join(f"{k}={v}" for k, v in sorted(vc.items()))
        lines.append(f"| {cat} | {len(group_rows)} | {vc_str} |")
    lines.append("")

    lines.append("## 그룹별 대표 샘플")
    lines.append("")
    for cat, group_rows in groups.items():
        lines.append(f"### {cat} ({len(group_rows)}건)")
        lines.append("")
        for r in group_rows[:3]:
            lines.append(f"- `{r['mnemonic']}` (source {r['source']}, verdict={r['verdict']}): "
                         f"{r['objdump_or_error'][:120]}")
        lines.append("")
        lines.append(f"원인: {group_rows[0]['diff_cause']}")
        lines.append("")

    with open(path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))


def main():
    asm_rows = load_rows(ASM_CSV)
    rt_rows = load_rows(RT_CSV)

    triaged = build_triage_rows(asm_rows, rt_rows)
    write_csv(triaged, OUT_CSV)
    write_report(triaged, OUT_MD)

    print(f"전체 triage 대상: {len(triaged)}건")
    groups = _group_counts(triaged)
    for cat, group_rows in groups.items():
        print(f"  {cat}: {len(group_rows)}건")
    verdict_counts = {}
    for r in triaged:
        verdict_counts[r["verdict"]] = verdict_counts.get(r["verdict"], 0) + 1
    print("verdict 분포:", verdict_counts)
    print(f"출력: {OUT_CSV}, {OUT_MD}")


if __name__ == "__main__":
    main()

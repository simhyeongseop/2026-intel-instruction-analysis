"""
3단계 combiner: tokens.csv -> combos.csv

2단계(tokenizer)가 오퍼랜드 단위로 쪼개놓은 "타입 토큰"(예: r/m32, imm8, xmm2/m128)을
실제 어셈블리에 쓸 수 있는 "구체적인 값"(concrete instance)의 후보로 펼친다.

예: ADD 명령어, row_id 하나에 operand_token 이 ["r/m32", "r32"] 라면
    -> combo 0: ["dword ptr [eax]", "ecx"]   (r/m32 를 메모리로 선택)
    -> combo 1: ["ecx", "ecx"]                (r/m32 를 레지스터로 선택)

원칙(CLAUDE.md, 작업 지시):
- "대표 후보 1개씩"만 둔다. r32 -> 레지스터 1종(ecx), m32 -> 메모리 1종([eax]) 처럼.
  다양한 레지스터/메모리 형태를 다 만들지 않는다 (조합 폭발 방지, 나중 확장 과제).
- r/m32 같은 "슬래시 대안"만 예외적으로 여러 조합(레지스터 버전 / 메모리 버전)으로 늘린다.
- 오퍼랜드 타입 -> 후보 값 매핑은 아래 REG_RULES / MEM_SIZE_MAP 같은 "간단한 딕셔너리"로 둔다.
  형섭이 필요하면 이 딕셔너리만 보고 고칠 수 있게 한다.
- 64비트 모드에서 무효한 form(mode_support 가 Invalid/N.E./N.S.)도 조합은 만들되
  expected_valid=False 로 표시한다(생성은 하고 구분만 한다).
- operand_kind="other"(k1+1, xmm2+3 같은 특이 표기)는 무리해서 펼치지 않고 원문 그대로
  하나의 후보로 남긴다. note 컬럼에 이유를 남긴다.
"""

import csv
import json
from pathlib import Path
import re
from itertools import zip_longest
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from pipeline.input_quality import require_validated_tokens
from pipeline.generation_contract import (REVISION, STRING_NAMES, digest,
    require_generation_metadata, reviewed_generation_form, source_hash, validate_generated)

IN_CSV = ROOT / "data/db/tokens.csv"
OUT_CSV = ROOT / "data/db/combos.csv"

OUT_COLUMNS = [
    "combo_id", "mnemonic", "row_id", "combo_index",
    "operand_types", "operands", "operand_count",
    "expected_valid", "mode_support", "cpuid_flag",
    "note", "raw_instruction", "source_page",
    "opcode", "description", "op_en", "generator_revision", "form_hash", "source_hash",
    "constraint_hash", "input_status", "input_violations", "input_unverified",
    "structured_operands", "asm_mnemonic", "asm_prefix",
    "test_kind", "effective_operand_types", "generation_corrections",
]

# ---------- 오퍼랜드 타입 -> 대표 후보 값 매핑 (형섭이 여기만 보고 고치면 됨) ----------

DECORATION_RE = re.compile(r"\{[^}]*\}")  # {k1}, {z}, {er}, {sae} 제거

# 레지스터 "타입 이름" -> 대표 레지스터 1개.
# 정규식은 위에서부터 순서대로 매치를 시도한다(먼저 매치되면 그걸 쓴다).
REG_RULES = [
    (re.compile(r"^AL$"), "al"), (re.compile(r"^AH$"), "ah"),
    (re.compile(r"^AX$"), "ax"), (re.compile(r"^EAX$"), "eax"), (re.compile(r"^RAX$"), "rax"),
    (re.compile(r"^CL$"), "cl"), (re.compile(r"^DX$"), "dx"),
    (re.compile(r"^CS$"), "cs"), (re.compile(r"^SS$"), "ss"), (re.compile(r"^DS$"), "ds"),
    (re.compile(r"^ES$"), "es"), (re.compile(r"^FS$"), "fs"), (re.compile(r"^GS$"), "gs"),
    (re.compile(r"^r8[ab]?$"), "cl"),
    (re.compile(r"^r16$"), "cx"),
    (re.compile(r"^r32[ab]?$"), "ecx"),
    (re.compile(r"^r64[ab]?$"), "rcx"),
    (re.compile(r"^r$"), "ecx"),          # r/m8 등에서 사이즈 정보 없는 bare 'r' (fallback)
    (re.compile(r"^reg$"), "ecx"),
    (re.compile(r"^Sreg$"), "ds"),
    (re.compile(r"^xmm\d*$"), "xmm0"),
    (re.compile(r"^ymm\d*$"), "ymm0"),
    (re.compile(r"^zmm\d*$"), "zmm0"),
    (re.compile(r"^mm\d*$"), "mm0"),
    (re.compile(r"^k\d+$"), "k1"),
    (re.compile(r"^bnd\d*$"), "bnd0"),
    (re.compile(r"^tmm\d+$"), "tmm0"),
    (re.compile(r"^ST(\(.*\))?$"), "st(0)"),
    (re.compile(r"^CR0[-–]CR7$"), "cr0"),
    (re.compile(r"^DR0[-–]DR7$"), "dr0"),
]

# bare 'r' (예: "r/m32" 를 '/'로 나누면 register 쪽이 그냥 'r'만 남음) 를 만났을 때,
# 짝인 메모리 쪽 크기(m8/m16/m32/m64)를 보고 사이즈를 맞춰주기 위한 표.
BARE_R_SIZE_TO_REG = {"8": "cl", "16": "cx", "32": "ecx", "64": "rcx"}

# 슬롯마다 다른 레지스터를 쓰는 변형에서 쓰는 표.
# 고정 이름 오퍼랜드(AL, DX, CS, ST(0), CR0 ...)는 매뉴얼이 그 레지스터를 지정한 것이므로
# 절대 바꾸지 않는다. 바꾸면 다른 인코딩 행을 시험하게 된다
# (예: "add al, 1"은 04 ib 행이지만 "add cl, 1"은 80 /0 ib 행이다).
GENERIC_REG_RE = re.compile(
    r"^(?:r8[ab]?|r16|r32[ab]?|r64[ab]?|reg|xmm\d*|ymm\d*|zmm\d*|mm\d*|k\d+|bnd\d*|tmm\d+"
    r"|ST\(i\))$")
# x87 의 ST(i)는 "0번이 아닌 스택 레지스터"를 뜻한다. 슬롯 구분 변형에서는 st(1)부터 쓴다.
# 순서가 실제로 인코딩을 바꾸는 자리라 구분이 특히 중요하다
# (as 확인: "fadd st(0), st(1)" -> d8 c1, "fadd st(1), st(0)" -> dc c1).
ST_INDEXED_ATOM = "ST(i)"
# 범용 레지스터는 번호를 붙일 수 없으므로 순서를 직접 적는다.
GPR_SEQUENCE = {
    "cl": ["cl", "dl", "bl"], "cx": ["cx", "dx", "bx"],
    "ecx": ["ecx", "edx", "ebx"], "rcx": ["rcx", "rdx", "rbx"],
}
# 번호가 있는 계열의 최대 번호. k8, bnd4 같은 없는 레지스터를 만들지 않기 위한 상한.
REG_FAMILY_LIMIT = {"xmm": 15, "ymm": 15, "zmm": 15, "mm": 7, "k": 7, "bnd": 3, "tmm": 7}

# 메모리 오퍼랜드 크기(mN) -> Intel syntax 크기 접두어. 대표 주소는 항상 [eax] 하나로 고정.
MEM_SIZE_RE = re.compile(r"^m(128|256|384|512|80|8|16|32|64)(?!\d)")
MEM_SIZE_TO_PTR = {
    "8": "byte ptr", "16": "word ptr", "32": "dword ptr", "64": "qword ptr",
    "80": "tbyte ptr", "128": "xmmword ptr", "256": "ymmword ptr", "512": "zmmword ptr",
    "384": None,  # 딱 맞는 Intel 키워드가 없음 -> 크기 접두어 없이 기본 주소만 사용
}
# 메모리 오퍼랜드가 "레지스터 폭"이 아니라 고정 크기 블록(키 핸들, 저장 영역, 큐 항목,
# 타일 설정)인 명령어들. Intel 크기 지시자를 붙이면 as 가 거부한다.
# (as 확인: "fxsave zmmword ptr [eax]" 거부 / "fxsave [eax]" 수용,
#           "aesdec128kl xmm0, xmmword ptr [eax]" 거부 / "aesdec128kl xmm0, [eax]" 수용)
# 같은 m512 표기라도 VMOVNTDQ/VPCOMPRESS*/VPEXPAND* 는 zmmword ptr 를 붙여도 같은 바이트가
# 나오므로 여기에 넣지 않는다(기존 생성 값을 그대로 둔다).
FIXED_BLOCK_MNEMONICS = {
    "AESDEC128KL", "AESDEC256KL", "AESDECWIDE128KL", "AESDECWIDE256KL",
    "AESENC128KL", "AESENC256KL", "AESENCWIDE128KL", "AESENCWIDE256KL",
    "ENQCMD", "ENQCMDS", "FXRSTOR", "FXRSTOR64", "FXSAVE", "FXSAVE64",
    "LDTILECFG", "STTILECFG", "MOVDIR64B",
}

# 표기만으로는 알 수 없어서 명시하는 레지스터 폭. 64비트 모드에서 as 가 받아주는 폭이 정해져 있다.
# (as 확인: "umonitor cx" 거부 / "umonitor ecx" 수용, "senduipi ecx" 거부 / "senduipi rcx" 수용,
#           "movdir64b cx, [eax]" 거부 / "movdir64b ecx, [eax]" 수용 - 주소 폭과 맞춰야 한다)
MODE_REGISTER_OVERRIDE = {"UMONITOR": "ecx", "MOVDIR64B": "ecx", "SENDUIPI": "rcx"}

# 매뉴얼 표기를 그대로 옮기면 as 가 식(expression)으로 읽어서 거부하는 것들.
# k1+1 은 마스크 쌍, zmm2+3 은 연속 레지스터 블록 표기이므로 블록의 첫 레지스터를 쓴다.
# imm8/r 은 1단계 추출에서 남은 잔여 텍스트다.
# (as 확인: "vp2intersectd k1+1, ..." 거부 / "vp2intersectd k1, ..." 수용)
RAW_NOTATION_FIX = {"k1+1": "k1", "zmm2+3": "zmm2", "xmm2+3": "xmm2", "imm8/r": "1"}

# SDM 은 "REP LODS AL" 처럼 누산기 이름으로 적지만, as 는 읽어올 메모리 오퍼랜드를 요구한다.
# 같은 인코딩(AC/AD)을 가리키는 다른 표기다.
# (as 확인: "rep lods al" 거부 / "rep lods byte ptr [rsi]" 수용 -> f3 ac)
STRING_LOAD_MNEMONICS = {"REP LODS"}
STRING_ACCUMULATOR_MEM = {"AL": "byte ptr [rsi]", "AX": "word ptr [rsi]",
                          "EAX": "dword ptr [rsi]", "RAX": "qword ptr [rsi]"}

# 메모리 주소를 64비트 형태로 바꾸면 짝이 되는 레지스터 폭도 같이 바꿔야 하는 명령어.
# (as 확인: "enqcmd ecx, [rax+rbx*4+0x10]" 거부 / "enqcmd rcx, [rax+rbx*4+0x10]" 수용)
ADDRESS_PAIRED_REGISTER = {"ENQCMD": ("ecx", "rcx"), "ENQCMDS": ("ecx", "rcx"),
                           "MOVDIR64B": ("ecx", "rcx")}

MEM_DEFAULT = "[eax]"
MEM_DEFAULT_64 = "[rax]"  # MPX(BND 계열) 전용: 64비트 모드는 32비트 주소(addr32)를 거부한다.

IMM_MAP = {"imm8": "1", "imm16": "0x100", "imm32": "0x10000", "imm64": "0x100000000"}

# moffs(절대 주소) 오퍼랜드. [0x1000] 처럼 쓰면 as 가 ModRM 인코딩(8A)으로 가버려서
# 매뉴얼의 moffs 행(A0/A1)을 시험하지 못한다.
# (as 확인: "mov al, [0x1000]" -> 8a 04 25, "mov al, ds:0x123456789abcdef0" -> a0 ...)
MOFFS_ADDRESS = "ds:0x123456789abcdef0"
LITERAL_NUM_RE = re.compile(r"^-?\d+$")

FAR_PTR_MAP = {"ptr16:16": "0x10:0x1234", "ptr16:32": "0x10:0x12345678"}

# ---------- far-ptr(m16:16 등) 전용 처리 (combiner_farptr_collapse 수정) ----------
# MEM_SIZE_RE 는 'm16:16'을 만나면 콜론 뒤를 무시하고 'm16'만 매치해버려서(word ptr 로 뭉개짐),
# far-ptr류(콜론 ':', 디스크립터 '&')는 MEM_SIZE_RE 로 보내기 전에 여기서 먼저 걸러낸다.
FAR_PTR_ATOM_RE = re.compile(r"^m16:(16|32|64)$")
# CALL/JMP m16:16/32/64 는 실제 far call/jmp 오퍼랜드라서 'far ptr [..]' 형태가 필요하다
# (as --64 -mintel64 로 확인: "call far ptr [eax]" 는 되지만 "call word ptr [eax]" 는 안 됨).
FAR_CALL_MNEMONICS = {"CALL", "JMP"}
# LSS/LFS/LGS 는 call이 아니라 mov류라서 'far' 키워드 없이 크기 접두어만 다르게 쓰면 된다
# (as 확인: "lfs ecx, fword ptr [eax]" 성공, "lgs rcx, tbyte ptr [rax]" 성공).
FAR_PTR_SIZE_TO_PTR = {"16": "dword ptr", "32": "fword ptr", "64": "tbyte ptr"}
# LGDT/LIDT 의 m16&32/m16&64(의사 디스크립터) 도 같은 정규식 버그의 피해자.
# as 확인: "lgdt [rax]" 처럼 크기 접두어 없이 그냥 메모리 주소만 쓰면 된다.
DESCRIPTOR_ATOM_RE = re.compile(r"^m16&(32|64)$")

# ---------- VSIB (gather/scatter) 전용 처리 (combiner_vsib_missing_index 수정) ----------
# vm32x/vm32y/vm32z/vm64x/vm64y/vm64z: VSIB 는 인덱스 레지스터(xmm/ymm/zmm)가 반드시 있어야
# "invalid VSIB address" 에러가 안 난다.
VSIB_ATOM_RE = re.compile(r"^vm(32|64)([xyz])$")
VSIB_INDEX_REG = {"x": "xmm1", "y": "ymm1", "z": "zmm1"}

# ---------- MPX (BND 계열) 전용 처리 (combiner_mpx_addr32_missing 수정) ----------
MPX_MNEMONICS = {"BNDCL", "BNDCN", "BNDCU", "BNDMK", "BNDMOV", "BNDLDX", "BNDSTX"}

# ---------- AVX512 gather/scatter 필수 마스크 (avx512_gather_scatter_default_mask 수정) ----------
# gather/scatter 계열은 기본 마스크(k0)가 허용되지 않아서 {k1} 표기를 지우면 안 된다.
# {z}/{er}/{sae} 는 마스크가 아니고 없어도 되므로 기존대로 계속 지운다.
MASK_DECORATION_RE = re.compile(r"\{k[0-7]\}")
GATHER_SCATTER_KEYWORDS = ("GATHER", "SCATTER")

# ---------- 레지스터 재사용 방지 (combiner_register_reuse 수정) ----------
# "레지스터가 서로 달라야 한다"는 제약이 as 에러로 실제 확인된 명령어만 적는다
# (모든 레지스터 타입에 다 적용하면 과한 일반화이므로 여기만 예외 처리).
DISTINCT_REG_MNEMONICS = {
    # AMX: "all tmm registers must be distinct"
    "TDPBF16PS", "TDPBSSD", "TDPBSUD", "TDPBUSD", "TDPBUUD", "TDPFP16PS",
    # 복소수 FMA류: "destination and source registers must be distinct"
    "VFCMADDCPH", "VFCMADDCSH", "VFCMULCPH", "VFCMULCSH",
    "VFMADDCPH", "VFMADDCSH", "VFMULCPH", "VFMULCSH",
}


# ---------- 변형 생성 (교수님 4·5회 요청: 메모리 형태·즉시값·마스크 다양화) ----------
# combo_index 0 은 기존 대표값 그대로 두고, 아래 변형을 "뒤에" 덧붙인다.
# 그래야 assign_stable_combo_ids 가 기존 combo_id 를 그대로 보존한다.
VARIANT_MEM_SIB = "[rax+rbx*4+0x10]"   # base+index*scale+disp
VARIANT_MEM_RIP = "[rip+0x10]"         # rip 상대 주소

# 즉시값은 "해당 폭의 최대값"을 쓰되 부호 있는 최대값을 쓴다.
# 0xffffffff 처럼 쓰면 as 가 부호확장 imm8(83 /2)로 줄여서 의도한 imm32 행을 못 때린다.
# (as 확인: "adc eax, 0xffffffff" -> 83 d0 ff, "adc eax, 0x7fffffff" -> 15 ff ff ff 7f)
IMM_MAX_MAP = {"imm8": "0x7f", "imm16": "0x7fff",
               "imm32": "0x7fffffff", "imm64": "0x7fffffffffffffff"}

# AVX-512 브로드캐스트 원소 수는 매뉴얼 표기 안에서 계산할 수 있다.
# 같은 토큰의 일반 메모리 대안 크기 / 브로드캐스트 원소 폭 = 원소 수.
#   zmm3/m512/m64bcst -> 512/64 = {1to8}
#   xmm3/m64/m16bcst  -> 64/16  = {1to4}   (VCVTPH2PD: 소스와 목적지 원소 폭이 다른 변환 계열)
# 목적지 벡터 폭으로 계산하면 변환 계열에서 틀린다
# (as 확인: "vcvtph2pd ymm0, word ptr [eax]{1to16}" 거부 / "{1to4}" 수용).
BCST_PTR = {"16": "word ptr", "32": "dword ptr", "64": "qword ptr"}
BCST_RE = re.compile(r"m(16|32|64)bcst")
# "zmm3" 안의 m3 에 걸리지 않도록 토큰 시작이나 슬래시 뒤에서만 찾는다.
PLAIN_MEM_RE = re.compile(r"(?:^|/)m(\d+)(?!\d|bcst)")
MASK_OR_ZERO_RE = re.compile(r"\{(?:k[0-7]|z)\}")
VSIB_IN_OPERAND_RE = re.compile(r"\[eax \+ (?:xmm|ymm|zmm)")


def strip_decorations(token):
    """{k1}, {z}, {er}, {sae} 같은 마스크/라운딩 표기 제거."""
    return DECORATION_RE.sub("", token).strip()


def extract_mask(token):
    """토큰 원문에서 {k1}~{k7} 마스크 표기만 뽑아 반환한다(없으면 빈 문자열)."""
    m = MASK_DECORATION_RE.search(token)
    return m.group() if m else ""


def is_gather_scatter(mnemonic):
    """mnemonic 이 AVX512 gather/scatter(프리페치 포함) 계열인지 대충 판단."""
    return any(k in mnemonic for k in GATHER_SCATTER_KEYWORDS)


def nth_register(value, occurrence):
    """대표 레지스터 값의 occurrence 번째 것을 고른다.

    'xmm0' -> xmm0, xmm1, xmm2 / 'k1' -> k1, k2, k3 / 'ecx' -> ecx, edx, ebx.
    번호를 붙일 수 없는 고정 레지스터(al, dx, st(0) 등)는 그대로 둔다.
    """
    if not occurrence:
        return value
    if value in GPR_SEQUENCE:
        sequence = GPR_SEQUENCE[value]
        return sequence[min(occurrence, len(sequence) - 1)]
    match = re.match(r"^([a-z]+)(\d+)$", value)
    if not match:
        return value
    family, number = match.group(1), int(match.group(2))
    limit = REG_FAMILY_LIMIT.get(family)
    picked = number + occurrence
    if limit is not None:
        picked = min(picked, limit)
    return f"{family}{picked}"


def register_candidate(atom, occurrence=None):
    """레지스터 타입 이름(atom) 하나 -> 대표 레지스터 값. 모르면 원문 소문자로 fallback.
    occurrence 가 주어지면 슬롯 순번에 맞는 다른 레지스터를 고른다(범용 표기일 때만)."""
    if atom == ST_INDEXED_ATOM and occurrence is not None:
        return f"st({occurrence + 1})"
    if re.fullmatch(r"(?:CR|DR)\d+", atom):
        return atom.lower()
    for pattern, value in REG_RULES:
        if pattern.match(atom):
            if occurrence is None or not GENERIC_REG_RE.match(atom):
                return value
            return nth_register(value, occurrence)
    return atom.lower()


def bump_counter(counters, atom):
    """counters(dict) 안에서 atom의 대표 레지스터 계열(xmm/tmm/bnd 등) 카운트를 하나
    올리고 그 전 값(이번에 쓸 순번)을 돌려준다. counters 가 None 이면 순번을 안 쓴다(None 반환)."""
    if counters is None or not GENERIC_REG_RE.match(atom):
        return None  # 매뉴얼이 지정한 고정 레지스터는 슬롯 순번을 세지 않는다
    base_value = register_candidate(atom)  # 순번 없이 대표값(예: 'xmm0')부터 구한다
    family = re.sub(r"\d+$", "", base_value)  # 'xmm0' -> 'xmm'
    n = counters.get(family, 0)
    counters[family] = n + 1
    return n


def memory_candidate(atom, mnemonic=""):
    """메모리 타입 이름(atom) 하나 -> 대표 메모리 오퍼랜드 문자열.
    mnemonic 에 따라 특수 취급이 필요한 경우가 있어서 함께 받는다:
    - far ptr(m16:16 등): CALL/JMP 는 'far ptr [..]', LSS/LFS/LGS 는 크기 접두어만.
    - VSIB(vm32x 등): 인덱스 레지스터를 반드시 붙여야 한다.
    - MPX(BND 계열): 64비트 모드에서 32비트 주소(eax)를 거부하므로 rax 를 쓴다."""
    base = MEM_DEFAULT_64 if mnemonic in MPX_MNEMONICS else MEM_DEFAULT
    if mnemonic in ('PREFETCHIT0', 'PREFETCHIT1'):
        base = VARIANT_MEM_RIP
    elif mnemonic == 'XLAT':
        base = '[rbx]'

    if mnemonic in FIXED_BLOCK_MNEMONICS:
        return base  # 고정 크기 블록: 크기 접두어를 붙이면 as 가 거부한다

    far_m = FAR_PTR_ATOM_RE.match(atom)
    if far_m:
        if mnemonic in FAR_CALL_MNEMONICS:
            return f"far ptr {base}"
        ptr_kw = FAR_PTR_SIZE_TO_PTR[far_m.group(1)]
        return f"{ptr_kw} {base}"

    if DESCRIPTOR_ATOM_RE.match(atom):
        return base  # LGDT/LIDT m16&64: 크기 접두어 없이 그대로

    vsib_m = VSIB_ATOM_RE.match(atom)
    if vsib_m:
        index_reg = VSIB_INDEX_REG[vsib_m.group(2)]
        return base[:-1] + f" + {index_reg}]"  # '[eax]' -> '[eax + xmm1]'

    m = MEM_SIZE_RE.match(atom)
    if m:
        ptr_kw = MEM_SIZE_TO_PTR.get(m.group(1))
        if ptr_kw:
            return f"{ptr_kw} {base}"
    return base  # 크기를 못 알아낸 경우(m2byte, mem, mib 등) 기본값


def is_memory_atom(part):
    """'/'로 나눈 조각 하나가 메모리 표기인지 대충 판단."""
    if part in ("mem", "sibmem", "mib"):
        return True
    if re.match(r"^m\d", part):
        return True
    if re.match(r"^vm(32|64)[xyz]$", part):
        return True
    return False


def expand_reg_or_mem(clean_token, mnemonic="", counters=None):
    """r/m32, xmm2/m128, xmm2/m128/m32bcst 같은 reg-or-mem 토큰을
    [레지스터 대표값, 메모리 대표값] 두 개의 후보로 나눈다."""
    parts = [p.strip() for p in clean_token.replace(" ", "").split("/") if p.strip()]
    mem_parts = [p for p in parts if is_memory_atom(p)]
    reg_parts = [p for p in parts if not is_memory_atom(p)]

    mem_part = mem_parts[0] if mem_parts else None
    reg_part = reg_parts[0] if reg_parts else None

    default_mem = MEM_DEFAULT_64 if mnemonic in MPX_MNEMONICS else MEM_DEFAULT
    mem_candidate = memory_candidate(mem_part, mnemonic) if mem_part else default_mem

    if reg_part == "r" and mem_part:
        # bare 'r' -> 짝인 메모리 크기에 맞춰 레지스터 사이즈를 고른다.
        size_match = re.match(r"^m(\d+)", mem_part)
        size = size_match.group(1) if size_match else None
        value = BARE_R_SIZE_TO_REG.get(size, "ecx")
        reg_candidate = nth_register(value, bump_counter(counters, f"r{size or 32}"))
    elif reg_part:
        occurrence = bump_counter(counters, reg_part)
        reg_candidate = register_candidate(reg_part, occurrence)
    else:
        reg_candidate = "ecx"

    return [reg_candidate, mem_candidate]


def expand_implicit(token):
    """<EAX>, <XMM0-7> 같은 암묵 오퍼랜드 표기 -> 대표 레지스터 이름 하나."""
    match = re.search(r"<([^>]+)>", token)
    if not match:
        return [token], "implicit_malformed_token"
    inside = match.group(1).split("-")[0].strip()
    return [inside.lower()], ""


def expand_token(token, kind, mnemonic="", counters=None):
    """오퍼랜드 토큰 하나(원문) -> (후보 리스트, 참고 note).
    kind 는 tokenizer 가 이미 분류해둔 operand_kind 힌트.
    mnemonic/counters 는 far-ptr, VSIB, MPX, 마스크, 레지스터 재사용 방지 등
    타입만으로는 판단할 수 없는 특수 처리에 필요해서 넘겨받는다."""
    clean = strip_decorations(token)

    if kind == "immediate":
        if LITERAL_NUM_RE.match(clean):
            return [clean], ""
        return [IMM_MAP.get(clean, "1")], ""

    if kind == "relative":
        return [".Ltarget" if clean == "rel8" else ".Ltarget" + clean[3:]], ""

    if kind == "moffs":
        return [MOFFS_ADDRESS], ""  # 절대 주소 형태라야 moffs 인코딩 행(A0/A1)을 시험한다

    if kind == "far_ptr":
        return [FAR_PTR_MAP.get(clean, "0x10:0x1234")], ""

    if kind == "implicit":
        # <EAX>, <XMM0-7> 은 소스에 적지 않는 암묵 오퍼랜드다. 명시하면 as 가
        # "number of operands mismatch" 로 거부한다. 슬롯 자체를 뺀다.
        return [], "implicit_dropped"

    if kind == "register":
        if mnemonic in STRING_LOAD_MNEMONICS and clean in STRING_ACCUMULATOR_MEM:
            return [STRING_ACCUMULATOR_MEM[clean]], f"string_accumulator_as_memory:{clean}"

        # r16/r32/r64, xmm2/mm128 처럼 순수 레지스터 대안이면 첫 후보만 대표로 쓴다.
        first = clean.split("/")[0].strip()
        occurrence = bump_counter(counters, first)
        value = MODE_REGISTER_OVERRIDE.get(mnemonic) or register_candidate(first, occurrence)
        if is_gather_scatter(mnemonic):
            mask = extract_mask(token)  # gather/scatter 는 마스크가 필수라서 지우면 안 된다
            if mask:
                value = f"{value} {mask}"
        return [value], ""

    if kind == "memory":
        value = memory_candidate(clean, mnemonic)
        if is_gather_scatter(mnemonic):
            mask = extract_mask(token)
            if mask:
                value = f"{value} {mask}"
        return [value], ""

    if kind == "reg_or_mem":
        return expand_reg_or_mem(clean, mnemonic, counters), ""

    # kind == "other" (k1+1, xmm2+3, imm8/r 등)
    if clean in RAW_NOTATION_FIX:
        return [RAW_NOTATION_FIX[clean]], f"other_normalized:{clean}"
    return [token], "other_kept_raw"


def can_vary_memory(operands, mnemonic=""):
    """메모리 형태를 바꿔도 되는 조합인지 본다.

    바꾸면 안 되는 것: VSIB(인덱스 레지스터가 필수라 SIB 로 바꾸면 거부),
    far ptr, moffs(절대 주소). MPX 는 [rax] 를 쓰므로 애초에 걸리지 않는다.
    (as 확인: "vgatherdps xmm1 {k1}, dword ptr [rax+rbx*4+0x10]" -> invalid VSIB address)
    """
    text = ", ".join(operands)
    if mnemonic and mnemonic.split()[-1].upper() in STRING_NAMES:
        return False
    if MEM_DEFAULT not in text:
        return False
    if "far ptr" in text or "ds:" in text:
        return False
    return not VSIB_IN_OPERAND_RE.search(text)


def vary_memory(operands, new_memory, mnemonic=""):
    """대표 메모리 주소 [eax] 를 다른 주소 형태로 바꾼 오퍼랜드 목록.

    주소가 64비트 형태가 되면 짝이 되는 레지스터 폭도 함께 바꾼다
    (ENQCMD 계열은 레지스터 폭과 주소 폭이 같아야 한다).
    """
    out = [op.replace(MEM_DEFAULT, new_memory) for op in operands]
    pair = ADDRESS_PAIRED_REGISTER.get(mnemonic)
    if pair:
        narrow, wide = pair
        out = [wide if op == narrow else op for op in out]
    return out


def vary_immediate(operands, operand_types):
    """즉시값 자리를 해당 폭의 최대 양수로 바꾼다. 바꿀 자리가 없으면 None."""
    out = list(operands)
    changed = False
    for i, token in enumerate(operand_types):
        key = strip_decorations(token)
        if key in IMM_MAX_MAP and i < len(out):
            out[i] = IMM_MAX_MAP[key]
            changed = True
    return out if changed else None


def vary_mask(operands, operand_types):
    """{k1}{z} 마스크 표기를 지우지 않고 살린 변형. 없으면 None.

    기존 조합은 strip_decorations 로 장식을 지우기 때문에, 마스크 표기가 있는
    1,640행 중 실제로 마스크를 쓴 줄이 64개뿐이었다.
    """
    out = list(operands)
    changed = False
    for i, token in enumerate(operand_types):
        if i >= len(out) or "{" in out[i]:
            continue  # 이미 장식이 붙어 있는 자리(gather/scatter 등)는 건드리지 않는다
        decoration = "".join(MASK_OR_ZERO_RE.findall(token))
        if "[" in out[i]:
            # 메모리 목적지에는 zeroing({z})을 쓸 수 없다
            # (as 확인: "vmovdqu32 xmmword ptr [eax] {k1}{z}, xmm0" -> unsupported masking)
            decoration = decoration.replace("{z}", "")
        if decoration:
            out[i] = f"{out[i]} {decoration}"
            changed = True
    return out if changed else None


def broadcast_count(token):
    """'zmm3/m512/m64bcst' 같은 토큰에서 브로드캐스트 원소 수를 계산한다."""
    bcst = BCST_RE.search(token)
    plain = PLAIN_MEM_RE.search(token)
    if not bcst or not plain:
        return None
    element = int(bcst.group(1))
    total = int(plain.group(1))
    if total % element:
        return None
    return f"1to{total // element}"


def vary_broadcast(operands, operand_types):
    """m32bcst/m64bcst 자리를 실제 브로드캐스트 표기로 바꾼다. 없으면 None."""
    out = list(operands)
    changed = False
    for i, token in enumerate(operand_types):
        match = BCST_RE.search(token)
        if not match or i >= len(out) or "[" not in out[i]:
            continue  # 메모리 자리에만 붙인다(레지스터 조합까지 바꾸면 변형이 중복된다)
        count = broadcast_count(token)
        if not count:
            continue
        out[i] = f"{BCST_PTR[match.group(1)]} {MEM_DEFAULT}{{{count}}}"
        changed = True
    return out if changed else None


def build_variants(combos, mnemonic=""):
    """기본 combo 뒤에 붙일 변형 목록. 규칙을 늘리려면 이 함수만 보면 된다."""
    extra = []
    seen = [combo["operands"] for combo in combos]
    for combo in combos:
        operands = combo["operands"]
        types = combo["operand_types"]
        candidates = []
        if can_vary_memory(operands, mnemonic):
            candidates.append(("memory_sib", vary_memory(operands, VARIANT_MEM_SIB, mnemonic)))
            # AMX 의 sibmem 오퍼랜드는 SIB 주소가 필수라 rip 상대를 쓸 수 없다
            # (as 확인: "tileloadd tmm0, [rip+0x10]" -> cannot be used here).
            if not any("sibmem" in token for token in types):
                candidates.append(("memory_rip", vary_memory(operands, VARIANT_MEM_RIP, mnemonic)))
        candidates.append(("imm_max", vary_immediate(operands, types)))
        candidates.append(("avx512_mask", vary_mask(operands, types)))
        candidates.append(("avx512_bcst", vary_broadcast(operands, types)))

        for kind, new_operands in candidates:
            if not new_operands or new_operands == operands:
                continue
            if new_operands in seen:
                continue  # 이미 같은 값의 조합이 있다
            seen.append(new_operands)
            note = "; ".join(x for x in [combo["note"], f"variant:{kind}"] if x)
            extra.append({"operand_types": types, "operands": new_operands, "note": note})
    return extra


def expected_valid(mode_support):
    """mode_support 가 Valid 인 경우만 64비트 모드에서 유효하다고 표시."""
    return mode_support == "Valid"


def read_tokens(path):
    with open(path, newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))


def group_by_row(token_rows):
    """row_id 순서를 보존하면서, 같은 row_id 의 오퍼랜드 행들을 묶는다."""
    groups = {}
    order = []
    for row in token_rows:
        rid = row["row_id"]
        if rid not in groups:
            groups[rid] = []
            order.append(rid)
        groups[rid].append(row)
    return [(rid, groups[rid]) for rid in order]


def expand_operand_rows(operand_rows, mnemonic, counters):
    """오퍼랜드 행들을 후보 값으로 펼친다.

    counters 를 주면 슬롯마다 다른 레지스터를 고른다(None 이면 기존처럼 대표값 하나).
    """
    per_position_candidates = []
    operand_types = []
    notes = []
    for row in operand_rows:
        candidates, note = expand_token(row["operand_token"], row["operand_kind"], mnemonic, counters)
        if note:
            notes.append(f"op{row['operand_index']}:{note}")
        if not candidates:
            continue  # 암묵 오퍼랜드: 자리 자체를 만들지 않는다
        per_position_candidates.append(candidates)
        operand_types.append(row["operand_token"])
    return per_position_candidates, operand_types, notes


def combos_from_candidates(per_position_candidates, operand_types, notes):
    """자리별 후보 목록 -> combo 목록.

    자리마다 후보 개수가 다르면(reg_or_mem=2개, 나머지=1개) 짧은 자리는 첫 후보를
    반복해서 채운다. 전수 곱집합 없이 "대표 조합 몇 개"만 만든다.
    """
    if not per_position_candidates:
        # 오퍼랜드가 없거나 전부 암묵 표기였던 경우 -> 오퍼랜드 없는 명령어 한 줄
        return [{"operand_types": [], "operands": [], "note": "; ".join(notes)}]

    max_len = max(len(c) for c in per_position_candidates)
    combos = []
    for i in range(max_len):
        operands = [c[i] if i < len(c) else c[0] for c in per_position_candidates]
        combos.append({
            "operand_types": operand_types,
            "operands": operands,
            "note": "; ".join(notes),
        })
    return combos


def seed_counters_with_fixed(operand_rows, counters):
    """매뉴얼이 지정한 고정 레지스터와 겹치지 않게 시작 순번을 밀어 둔다.

    예: "RCL r/m8, CL" 은 두 번째 자리가 CL 로 고정이라, 첫 자리도 대표값 cl 을 쓰면
    'rcl cl, cl' 이 되어 자리를 구분할 수 없다. 고정 자리를 먼저 세어 두면 dl 이 나온다.
    """
    for row in operand_rows:
        atom = strip_decorations(row["operand_token"])
        if row["operand_kind"] != "register" or GENERIC_REG_RE.match(atom):
            continue
        family = re.sub(r"\d+$", "", register_candidate(atom))
        counters[family] = counters.get(family, 0) + 1


def distinct_register_combos(operand_rows, mnemonic, base_combos):
    """슬롯마다 다른 레지스터를 쓰는 변형.

    기본 조합은 모든 자리에 같은 대표값을 써서 'vaddpd zmm0, zmm0, zmm0' 같은 줄이
    2,000개 넘게 나온다. 이러면 도구가 오퍼랜드 순서를 바꿔 처리해도 결과가 같아서
    순서 오류를 구분할 수 없다(7회 미팅 "원인 구분이 가능한 입력").

    매뉴얼이 레지스터를 지정한 자리(AL, DX, ST(0) 등)는 바꾸지 않는다.
    """
    counters = {}
    seed_counters_with_fixed(operand_rows, counters)
    candidates, operand_types, notes = expand_operand_rows(operand_rows, mnemonic, counters)
    combos = combos_from_candidates(candidates, operand_types, notes)
    seen = [combo["operands"] for combo in base_combos]
    extra = []
    for combo in combos:
        if combo["operands"] in seen:
            continue  # 바뀐 자리가 없으면 변형을 만들지 않는다
        seen.append(combo["operands"])
        note = "; ".join(x for x in [combo["note"], "variant:distinct_regs"] if x)
        extra.append(dict(combo, note=note))
    return extra


def build_combos_for_row(operand_rows):
    """한 row_id 의 오퍼랜드 행들 -> combo 리스트.
    각 combo 는 {"operand_types": [...], "operands": [...], "note": "..."} 형태다.

    순서: 기본 조합 -> 값 변형(메모리/즉시값/마스크) -> 슬롯별 레지스터 변형.
    순번은 표시용이다. assign_stable_combo_ids는 소스와 검증 근거가 같은 경우에만
    기존 ID를 보존하고, 수정된 입력에는 새 ID를 배정한다.
    """
    first = operand_rows[0]
    raw_types = [row['operand_token'] for row in operand_rows
                 if row['operand_kind'] not in ('none', 'implicit')]
    correction = reviewed_generation_form(first['mnemonic'], first.get('opcode', ''), raw_types)
    if first["operand_kind"] == "none":
        result = [{"operand_types": [], "operands": [], "note": ""}]
        return apply_reviewed_form(result, raw_types, correction)

    if correction:
        # Generate from the reviewed effective tokens, preserving the caller's
        # raw SDM tokens/metadata and restoring raw operand_types in the output.
        operand_rows = [dict(row, operand_token=token) for row, token in
                        zip(operand_rows, correction['effective_types'])]

    mnemonic = first["mnemonic"]
    # "레지스터가 서로 달라야 하는" 명령어는 기본 조합부터 슬롯 순번을 쓴다.
    counters = {} if mnemonic in DISTINCT_REG_MNEMONICS else None
    candidates, operand_types, notes = expand_operand_rows(operand_rows, mnemonic, counters)
    combos = combos_from_candidates(candidates, operand_types, notes)

    result = (combos
            + build_variants(combos, mnemonic)
            + distinct_register_combos(operand_rows, mnemonic, combos))
    name = mnemonic.split()[-1].upper()
    if name == 'XBEGIN' and any(r['operand_token'] == 'rel16' for r in operand_rows):
        # SDM XBEGIN is an exception: rel16 is valid in long mode. Record each
        # assembler's actual tail width; accepting data16 does not prove it.
        for combo in result:
            combo['asm_prefix'] = 'data16'
    if name in STRING_NAMES:
        for combo in result:
            addresses = iter(['rdi', 'rsi'] if name == 'MOVS' else ['rsi', 'rdi'] if name == 'CMPS'
                             else ['rsi'] if name in ('LODS', 'OUTS') else ['rdi'])
            combo['operands'] = [re.sub(r'\[[^]]+\]', '[' + next(addresses) + ']', op)
                                 if '[' in op else op for op in combo['operands']]
        # Correct base operands before generating variants: string opcodes encode no SIB/RIP.
        result = [c for c in result if 'variant:memory_' not in c['note']]
    for combo in result:
        # AVX2 mask, VSIB index and destination share physical vector numbers.
        indices = re.findall(r'\[.*?\b[xyz]mm(\d+)\]', ', '.join(combo['operands']))
        if indices and 'GATHER' in mnemonic:
            used = {int(n) for n in indices}
            fixed = []
            for op in combo['operands']:
                reg = re.fullmatch(r'([xyz]mm)(\d+)', op)
                if reg:
                    number = int(reg.group(2))
                    while number in used:
                        number += 1
                    used.add(number)
                    op = reg.group(1) + str(number)
                fixed.append(op)
            combo['operands'] = fixed
    if any(row['operand_kind'] == 'moffs' for row in operand_rows):
        # Keep former source as an edge observation; canonical movabs is separate.
        for combo in result:
            combo['note'] = '; '.join(filter(None, [combo['note'], 'edge:legacy_moffs_spelling']))
        for combo in list(result):
            ops = list(combo['operands'])
            for i, token in enumerate(combo['operand_types']):
                match = re.fullmatch(r'moffs(8|16|32|64)', token)
                if match:
                    ops[i] = MEM_SIZE_TO_PTR[match.group(1)] + ' [0x100000000]'
            result.append(dict(combo, operands=ops, asm_mnemonic='movabs',
                # RAX already requests REX.W; an extra rex64 makes GNU reject
                # the duplicated prefix. The AL/A0,A2 rows need it explicitly.
                asm_prefix='rex64' if 'REX.W' in first.get('opcode', '') and 'RAX' not in combo['operand_types'] else '',
                note='variant:canonical_moffs_movabs'))
    # Repairing slots can collapse variants. They are not extra coverage.
    unique = {}
    for combo in result:
        key = (tuple(combo['operands']), combo.get('asm_mnemonic', ''), combo.get('asm_prefix', ''))
        unique.setdefault(key, combo)
    return apply_reviewed_form(list(unique.values()), raw_types, correction)


def apply_reviewed_form(combos, raw_types, correction):
    """Keep SDM table types, effective types and explicit rendering reasons apart."""
    if correction is None:
        return combos
    evidence = json.dumps({k: correction[k] for k in ('id', 'reason')},
                          ensure_ascii=False, separators=(',', ':'))
    for combo in combos:
        combo['effective_operand_types'] = list(correction['effective_types'])
        combo['operand_types'] = list(raw_types)
        combo['generation_corrections'] = evidence
        combo['note'] = '; '.join(filter(None, [combo['note'], 'sdm_description_correction:' + correction['id']]))
        if correction['asm_prefix']:
            combo['asm_prefix'] = correction['asm_prefix']
        if correction['asm_mnemonic']:
            combo['asm_mnemonic'] = correction['asm_mnemonic']
        if correction['id'].startswith('far_branch'):
            # Keep these as the original single memory candidate; generating
            # ordinary SIB/RIP variants here would expand the approved scope.
            base = '[rax]' if correction['id'] == 'far_branch64_size' else MEM_DEFAULT
            combo['operands'] = ['fword ptr ' + base]
    return combos


def assign_stable_combo_ids(rows, prior_rows):
    """Keep IDs only for the same source/form; slot order is not source identity."""
    def identity(row):
        if 'operands' not in row:  # compatibility for small callers without source data
            return (str(row['row_id']), str(row['combo_index']))
        return (str(row['row_id']), row.get('mnemonic', '').lower(), row['operands'],
                row.get('asm_mnemonic', ''), row.get('asm_prefix', ''))
    prior_by_key = {identity(row): row for row in prior_rows if str(row.get('combo_id', '')).isdigit()}
    prior = {key: int(row['combo_id']) for key, row in prior_by_key.items()}
    used = {int(row['combo_id']) for row in prior_rows if str(row.get('combo_id', '')).isdigit()}
    next_id = max(used, default=-1) + 1
    assigned = []
    emitted = set()
    for row in rows:
        key = identity(row)
        combo_id = prior.get(key)
        previous = prior_by_key.get(key)
        if previous and previous.get('form_hash') and previous['form_hash'] != row.get('form_hash'):
            combo_id = None
        if previous and previous.get('constraint_hash') and previous['constraint_hash'] != row.get('constraint_hash'):
            combo_id = None
        if combo_id is None or combo_id in emitted:
            while next_id in used or next_id in emitted:
                next_id += 1
            combo_id = next_id
            next_id += 1
        emitted.add(combo_id)
        assigned.append(dict(row, combo_id=combo_id))
    return assigned


def generate_combo_rows(token_rows, prior_rows=()):
    require_validated_tokens(token_rows)
    require_generation_metadata(token_rows)
    out = []
    for row_id, operand_rows in group_by_row(token_rows):
        common = operand_rows[0]
        for index, combo in enumerate(build_combos_for_row(operand_rows)):
            checked = validate_generated(common['mnemonic'], combo['operand_types'], combo['operands'], common['mode_support'],
                opcode=common['opcode'], asm_prefix=combo.get('asm_prefix', ''), asm_mnemonic=combo.get('asm_mnemonic', ''))
            out.append(dict(mnemonic=common['mnemonic'], row_id=row_id, combo_index=index,
                operand_types=', '.join(combo['operand_types']), operands=', '.join(combo['operands']),
                operand_count=len(combo['operands']), expected_valid=expected_valid(common['mode_support']),
                mode_support=common['mode_support'], cpuid_flag=common['cpuid_flag'], note=combo['note'],
                raw_instruction=common['raw_instruction'], source_page=common['source_page'],
                opcode=common['opcode'], description=common['description'], op_en=common['op_en'],
                generator_revision=REVISION, form_hash=common['form_hash'],
                source_hash=source_hash(combo.get('asm_mnemonic') or common['mnemonic'], combo['operands'], combo.get('asm_prefix', '')),
                constraint_hash=digest(checked), input_status=checked['status'],
                input_violations=';'.join(checked['violations']), input_unverified=';'.join(checked['unverified']),
                structured_operands=json.dumps(checked['operands'], ensure_ascii=False, separators=(',', ':')),
                asm_mnemonic=combo.get('asm_mnemonic', ''), asm_prefix=combo.get('asm_prefix', ''),
                effective_operand_types=', '.join(combo.get('effective_operand_types', combo['operand_types'])),
                generation_corrections=combo.get('generation_corrections', ''),
                test_kind='edge' if 'edge:' in combo['note'] else 'negative' if common['mode_support'] != 'Valid'
                    else 'generation_error' if checked['status'] == 'invalid'
                    else 'encoding_directed' if combo.get('asm_prefix') or combo.get('asm_mnemonic') else 'normal'))
    return assign_stable_combo_ids(out, prior_rows)


def main():
    token_rows = read_tokens(IN_CSV)
    require_validated_tokens(token_rows)
    print(f"입력 행 수(오퍼랜드 단위): {len(token_rows)}")

    prior_rows = read_tokens(OUT_CSV) if OUT_CSV.is_file() else []
    out_rows = generate_combo_rows(token_rows, prior_rows)

    with open(OUT_CSV, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=OUT_COLUMNS)
        writer.writeheader()
        for row in out_rows:
            writer.writerow(row)

    print(f"원본 명령어(row_id) 수: {len(group_by_row(token_rows))}")
    print(f"출력 조합(combo) 수: {len(out_rows)}")
    print(f"CSV 저장: {OUT_CSV}")


if __name__ == "__main__":
    main()

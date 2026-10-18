"""'원문 없음' 기준 완화(사용자 결정 2026-10-10, A·B·C).

공통 기준(sdm_review_compare.uniform_status)에서 원문 없음인 오퍼랜드 줄에만 쓴다. Sol 기록은 고치지 않는다.
값마다 근거 단계와 원문 인용을 남긴다. 이름의 숫자만 보고 크기를 정하지 않는다.

- A 'Vol.1': 레지스터 자체의 폭은 Vol.1(253665-093US) 원문을 인용한다(zmm 512, x87 ST(i) 80).
- B '결합': 묶음 표기(xmm3/m128/m32bcst 등)는 '/'로 나눈 각 부분의 정의(총론 SYM, 2.7.7, A)를 그대로 쓴다.
  부분 하나라도 정의가 없으면 결합하지 않는다(m16bcst, m2byte 등). 번호·문자 접미사(xmm1, r32a)와
  레지스터 묶음(k1+1, zmm2+3)은 기본 기호의 정의를 쓴다(묶음 개수의 뜻은 명령 절 원문 몫).
- D '타 명령 절 정의'(사용자 결정 2026-10-10): 총론(2.7.5·2.7.7)은 dword·qword broadcast만 정의하므로
  m16bcst는 FP16 명령 절 Description의 정의 문장(VMAXPH 1889쪽)을 같은 표기 전체에 쓴다. 근거 위치가 다른
  명령 절임을 상태 이름으로 구분한다.
- A의 x87 제어 워드: FSTCW/FNSTCW의 m2byte는 절 원문이 '제어 워드를 저장'만 말하므로(506쪽) Vol.1 213쪽의
  제어 워드 폭 문장을 함께 쓴다(FLDCW는 자기 절 474쪽에 16-bit 문장이 있다).
- C '원문상 가변': 원문이 폭을 고정하지 않는다고 말하는 표기(tmm, VSIB vm32/vm64, mib, sibmem,
  XSAVE 계열의 mem: 저장 영역 크기는 XCR0(압축 형식은 XCR0 | IA32_XSS)에 따라 CPUID가 알려 준다).
"""

import re

RELAXED_A = "원문 확정(완화 A: Vol.1)"
RELAXED_B = "원문 확정(완화 B: 결합)"
VARIABLE_C = "원문상 가변(완화 C)"
RELAXED_D = "원문 확정(완화 D: 타 명령 절 정의)"

# (근거 위치, 원문 문장). tests/test_sdm_relaxation.py가 문장이 그 쪽에 실제로 있는지 검사한다.
VOL1_ZMM = ("Vol.1 332", "32 512-bit vector registers called ZMM0–ZMM31")
VOL1_X87 = ("Vol.1 207", "The x87 FPU data registers (shown in Figure 8-1) consist of eight 80-bit registers")
VOL1_TILE = ("Vol.1 425", "Each tile has a maximum size of 16 rows x 64 bytes, (1 KB), however the programmer "
                          "can configure each tile to smaller dimensions")
VOL2_BCST = ("Vol.2 72 2.7.7", "EVEX encodes an embedded broadcast functionality that is supported on many vector "
                               "instructions with 32-bit (double word or single precision floating-point) and 64-bit "
                               "data elements")

# 기본 기호 -> (종류, 폭, 근거 위치, 원문). 총론 기호는 SYM 번호로 적는다.
PARTS = {
    "xmm": ("register", "128", "SYM058", "The 128-bit XMM registers are: XMM0 through XMM7"),
    "ymm": ("register", "256", "SYM063", "The 256-bit YMM registers are: YMM0 through YMM7"),
    "zmm": ("register", "512") + VOL1_ZMM,
    "k": ("register", "64", "SYM073", "The 64-bit k registers are: k0 through k7."),
    "r32": ("register", "32", "SYM028", "r32 — One of the doubleword general-purpose registers"),
    "r64": ("register", "64", "SYM029", "r64 — One of the quadword general-purpose registers"),
    "m8": ("memory", "8", "SYM041", "m8 — A byte operand in memory"),
    "m16": ("memory", "16", "SYM042", "m16 — A word operand in memory"),
    "m32": ("memory", "32", "SYM043", "m32 — A doubleword operand in memory."),
    "m64": ("memory", "64", "SYM044", "m64 — A memory quadword operand in memory."),
    "m128": ("memory", "128", "SYM045", "m128 — A memory double quadword operand in memory."),
    "m256": ("memory", "256", "SYM064", "m256 — A 32-byte operand in memory."),
    "m512": ("memory", "512", "SYM069", "m512 — A 64-byte operand in memory."),
    "m32bcst": ("broadcast", "원소 32") + VOL2_BCST,
    "m64bcst": ("broadcast", "원소 64") + VOL2_BCST,
}
X87 = ("register", "80") + VOL1_X87
# 다른 명령 절의 정의 문장을 쓰는 기호(완화 D)
OTHER_SECTION = {
    "m16bcst": ("broadcast", "원소 16", "Vol.2 1889 VMAXPH",
                "a 512/256/128-bit vector broadcast from a 16-bit memory location"),
}
# x87 제어 워드 m2byte(완화 A): 절 원문(무엇을 저장하는지) + Vol.1(그 워드의 폭)
X87_CONTROL_WORD = ("FLDCW", "FSTCW", "FNSTCW")
VOL2_FSTCW = ("Vol.2 506", "Stores the current value of the FPU control word at the specified destination in memory.")
VOL1_CONTROL_WORD = ("Vol.1 213", "The 16-bit x87 FPU control word")
VARIABLE = {
    "tmm": ("register", "가변") + VOL1_TILE,
    "vm32x": ("vector_memory", "가변", "SYM075", "A vector array of memory operands specified using VSIB memory addressing"),
    "vm64x": ("vector_memory", "가변", "SYM076", "A vector array of memory operands specified using VSIB memory addressing"),
    "mib": ("memory", "해당 없음", "SYM068",
            "Only the base and displacement are used in effective address calculation."),
    "sibmem": ("memory", "가변", "Vol.2 51 2.4",
               "sibmem is used to denote an encoding where a ModR/M byte and SIB byte are used to indicate a memory "
               "operation"),
}


# XSAVE 계열 'mem'은 니모닉을 함께 본다('mem'이라는 표기 자체에는 총론 정의가 없다).
XSAVE_STANDARD = ("XSAVE", "XSAVE64", "XRSTOR", "XRSTOR64", "XSAVEOPT", "XSAVEOPT64")
XSAVE_COMPACTED = ("XSAVEC", "XSAVEC64", "XSAVES", "XSAVES64", "XRSTORS", "XRSTORS64")
VOL1_XSAVE_SIZE = ("Vol.1 323", "EBX enumerates the size (in bytes) required by the XSAVE instruction for an XSAVE "
                                "area containing all the user state components corresponding to bits currently set in XCR0.")
VOL1_XSAVE_COMPACTED = ("Vol.1 324", "If EAX[3] is enumerated as 1, EBX enumerates the size required by the XSAVES "
                                     "instruction for an XSAVE area containing all the state components corresponding "
                                     "to bits currently set in XCR0 | IA32_XSS.")
VOL2_XSAVE_RFBM = ("Vol.2 2305", "The specific state components saved correspond to the bits set in the "
                                 "requested-feature bitmap (RFBM), which is the logical-AND of EDX:EAX and XCR0.")


def base(part):
    """번호·문자 접미사와 레지스터 묶음 표기를 뗀 기본 기호. 장식({k1}, {sae})과 각주는 이미 뗀 상태로 받는다."""
    part = part.strip()
    part = re.sub(r"\+\d+$", "", part)                       # k1+1, zmm2+3
    part = re.sub(r"^(xmm|ymm|zmm|tmm|k)\d+$", r"\1", part)   # xmm1, k2
    part = re.sub(r"^(r32|r64)[ab]$", r"\1", part)            # r32a, r64b
    part = re.sub(r"^vm(32|64)[xyz]$", r"vm\1x", part)        # vm32y -> vm32x 정의(SYM075/076 묶음)
    return part


def relax(table_symbol, mnemonic=""):
    """원문 없음 줄에 쓸 (상태, 종류, 폭, 근거) 또는 None."""
    symbol = re.sub(r"\s*\{[^}]*\}", "", re.sub(r"\^\d+", "", table_symbol or "")).strip()
    if symbol == "mem" and mnemonic.upper() in XSAVE_STANDARD + XSAVE_COMPACTED:
        size = VOL1_XSAVE_COMPACTED if mnemonic.upper() in XSAVE_COMPACTED else VOL1_XSAVE_SIZE
        return VARIABLE_C, "memory", "가변(XSAVE 영역)", '[%s] "%s" | [%s] "%s"' % (size + VOL2_XSAVE_RFBM)
    if symbol == "m2byte" and mnemonic.upper() in X87_CONTROL_WORD:
        return RELAXED_A, "memory", "16", '[%s] "%s" | [%s] "%s"' % (VOL2_FSTCW + VOL1_CONTROL_WORD)
    symbol = re.sub(r"\s*/\s*", "/", symbol)
    parts = [base(p) for p in symbol.split("/")]
    if len(parts) == 1:
        name = parts[0]
        if name in VARIABLE:
            kind, width, where, quote = VARIABLE[name]
            return VARIABLE_C, kind, width, '[%s] "%s"' % (where, quote)
        if re.fullmatch(r"ST\(i\)|ST", symbol):
            kind, width, where, quote = X87
            return RELAXED_A, kind, width, '[%s] "%s"' % (where, quote)
        if name == "zmm":
            kind, width, where, quote = PARTS["zmm"]
            return RELAXED_A, kind, width, '[%s] "%s"' % (where, quote)
        if name in PARTS:
            kind, width, where, quote = PARTS[name]
            return RELAXED_B, kind, width, '[%s] "%s"' % (where, quote)
        return None
    known = dict(PARTS, **OTHER_SECTION)
    if not all(p in known for p in parts):
        return None
    defs = [known[p] for p in parts]
    kinds = {d[0] for d in defs}
    kind = "register_or_memory" if "register" in kinds and kinds - {"register"} else defs[0][0]
    width = " / ".join("%s %s" % (p, d[1]) for p, d in zip(parts, defs))
    evidence = " | ".join('[%s] "%s"' % (d[2], d[3]) for d in defs)
    if any(p in OTHER_SECTION for p in parts):
        return RELAXED_D, kind, width, evidence
    uses_vol1 = any(d[2].startswith("Vol.1") for d in defs)
    return (RELAXED_A if uses_vol1 else RELAXED_B), kind, width, evidence

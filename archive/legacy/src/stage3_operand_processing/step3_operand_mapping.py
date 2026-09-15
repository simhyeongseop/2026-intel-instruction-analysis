"""
Stage 3 (재작성): 오퍼랜드 타입 → 구체 어셈블리 값 매핑

입력 : data/stage2_opcode_split/step2_instruction_forms_split.csv
출력 :
  data/stage3_operands/step3_operand_candidates.csv  (타입 → 구체값 사전, 검토용)
  data/stage3_operands/step3_coverage.csv            (form별 매핑 가능 여부)
  data/stage3_operands/step3_generated.s             (생성된 Intel-syntax 명령어)

설계 원칙
---------
- reg/mem/bcst 슬래시 대안(xmm3/m128/m64bcst)은 '레지스터 형'을 선택한다 (가장 단순·유효).
- 마스크 데코레이터 {k1}, {k1}{z} 는 유지한다.
- {er}/{sae}(임베디드 라운딩)와 {1toN} 는 선택적 문법이므로 제거한다(기본 form은 유효).
- 암묵 오퍼랜드(<XMM0>, <EAX> 등)는 어셈블리에 쓰지 않으므로 제거한다.
- 알 수 없는 토큰(설명문 유출 노이즈 등)이 하나라도 있으면 그 form은 스킵한다.
"""

import csv
import re
from pathlib import Path

BASE = Path(__file__).parent.parent.parent
IN_CSV = BASE / "data" / "stage2_opcode_split" / "step2_instruction_forms_split.csv"
OUT_DIR = BASE / "data" / "stage3_operands"

# ── 고정/특수 토큰 (정확 일치) ─────────────────────────────
FIXED = {
    "AL": "al", "AX": "ax", "EAX": "eax", "RAX": "rax",
    "CL": "cl", "DX": "dx", "FS": "fs", "GS": "gs",
    "Sreg": "ds",
    "CR0–CR7": "cr0", "CR8": "cr8", "DR0–DR7": "dr0",
    "ST": "st(0)", "ST(0)": "st(0)", "ST(i)": "st(1)",
    "1": "1", "0": "0",
    "reg": "eax",
}

# ── 메모리 타입 → PTR 크기 ─────────────────────────────────
MEM_PTR = {
    "m8": "BYTE PTR", "m16": "WORD PTR", "m32": "DWORD PTR", "m64": "QWORD PTR",
    "m16int": "WORD PTR", "m32int": "DWORD PTR", "m64int": "QWORD PTR",
    "m32fp": "DWORD PTR", "m64fp": "QWORD PTR", "m80fp": "TBYTE PTR",
    "m80bcd": "TBYTE PTR",
    "m16:16": "DWORD PTR", "m16:32": "FWORD PTR", "m16:64": "TBYTE PTR",
}
# PTR 크기 없이 bare [rax] 로 쓰는 메모리 타입.
# m128/m256/m512 등 큰 메모리는 짝 레지스터에서 크기가 추론되거나(vmovaps 등),
# KL/AMX/ENQCMD 처럼 블록 메모리라 PTR 크기를 붙이면 오히려 size mismatch 가 난다.
MEM_BARE = {
    "m", "mem", "m16&64",
    "m2byte", "m14/28byte", "m94/108byte", "m384", "m512byte",
    "m128", "m256", "m512",
}
# SIB 바이트가 필수인 메모리 타입 (§2.4): 반드시 index 포함 형태로 생성
MEM_SIB = {"mib", "sibmem"}

# ── 정규식 기반 레지스터 클래스 ────────────────────────────
def _vec_concrete(prefix: str, idx: str | None) -> str:
    """xmm/ymm/zmm/mm/tmm/bnd/k 레지스터. 인덱스 숫자를 그대로 레지스터 번호로."""
    n = int(idx) if idx and idx.isdigit() else 0
    limit = {"xmm": 31, "ymm": 31, "zmm": 31, "mm": 7, "tmm": 7, "bnd": 3, "k": 7}[prefix]
    if prefix == "k" and n == 0:
        n = 1                       # k0 은 마스크 프레디킷으로 사용 불가
    if n > limit:
        n = 0
    return f"{prefix}{n}"


def _map_reg(tok: str) -> str | None:
    """레지스터 계열 토큰 → 구체 레지스터. 아니면 None."""
    if tok in FIXED:
        return FIXED[tok]
    m = re.fullmatch(r"(xmm|ymm|zmm|tmm|bnd)(\d*)", tok)
    if m:
        return _vec_concrete(m.group(1), m.group(2))
    if re.fullmatch(r"mm\d*", tok):
        return _vec_concrete("mm", tok[2:])
    if re.fullmatch(r"k\d+", tok):
        return _vec_concrete("k", tok[1:])
    # GP 레지스터 (r8/r16/r32/r64, r32a/r64b 등)
    if re.fullmatch(r"r8[a-z]?", tok):
        return "al"
    if re.fullmatch(r"r16[a-z]?", tok):
        return "ax"
    if re.fullmatch(r"r32[a-z]?", tok):
        return "eax"
    if re.fullmatch(r"r64[a-z]?", tok):
        return "rax"
    return None


def _map_mem(tok: str) -> str | None:
    """메모리 계열 토큰 → 구체 메모리 오퍼랜드. 아니면 None."""
    if tok in MEM_BARE:
        return "[rax]"
    if tok in MEM_SIB:
        return "[rax+rbx*1]"          # SIB 필수 (§2.4)
    if tok in MEM_PTR:
        return f"{MEM_PTR[tok]} [rax]"
    # moffs8/16/32/64 (MOV 절대주소)
    if re.fullmatch(r"moffs(8|16|32|64)", tok):
        return "[0x1000]"
    # 브로드캐스트 메모리 (m32bcst 등) — 단독으로 오면 bare 로
    if re.fullmatch(r"m\d+bcst", tok):
        return "[rax]"
    # VSIB (vm32x/vm64z 등): 인덱스 레지스터 폭 = 마지막 문자.
    # 인덱스를 피연산자 풀(xmm0-4)과 겹치지 않는 xmm14 로 두어 gather 의
    # dest/index/mask distinctness(#UD 회피)를 base set에서 보장한다 (§2.4/사례1).
    m = re.fullmatch(r"vm(32|64)([xyz])", tok)
    if m:
        idx = {"x": "xmm14", "y": "ymm14", "z": "zmm14"}[m.group(2)]
        return f"[rax+{idx}*1]"
    return None


def _strip_decorators(token: str) -> tuple[str, str]:
    """
    토큰에서 데코레이터를 분리.
    반환: (base, mask_suffix)
      - {er}/{sae}/{1toN} 제거
      - {k1}/{k2} (+{z}) 는 mask_suffix 로 유지
    """
    er_sae = re.findall(r"\{(?:er|sae|1to\d+|rn-sae|ru-sae|rd-sae|rz-sae)\}", token)
    token = re.sub(r"\s*\{(?:er|sae|1to\d+|rn-sae|ru-sae|rd-sae|rz-sae)\}", "", token)
    masks = re.findall(r"\{k[0-7]\}|\{z\}", token)
    base = re.sub(r"\s*\{k[0-7]\}|\s*\{z\}", "", token).strip()
    mask_suffix = "".join(masks)  # 예: {k1}{z}
    return base, mask_suffix


IMPLICIT_RE = re.compile(r"^<.*>$")


def map_operand(token: str) -> str | None:
    """
    오퍼랜드 타입 토큰 → 구체 어셈블리 오퍼랜드.
    반환:
      - 구체 문자열
      - "" (암묵 오퍼랜드 → 어셈블리에서 생략)
      - None (알 수 없음 → 해당 form 스킵)
    """
    token = token.strip()
    if not token:
        return None

    base, mask = _strip_decorators(token)

    # 토큰 내 암묵 오퍼랜드(<XMM0-6> 등) 제거. 제거 후 남는 게 없으면 생략(""), 있으면 계속.
    if "<" in base:
        base = re.sub(r"\s*<[^>]*>", "", base).strip()
        if not base:
            return ""
    # 순수 암묵 오퍼랜드 (<XMM0>, <EAX> ...) → 생략
    if IMPLICIT_RE.match(base):
        return ""

    # opmask 레지스터 쌍(kN+1, 예: VP2INTERSECT)의 목적지: SDM p.1894가 MODRM.REG
    # 저비트를 마스킹하므로 양성 셋은 짝수 베이스(k2)로 고정한다.
    # 홀수 k1은 음성 셋 N2로 분리 생성한다 (§2.3, Stage 6 사례 2).
    if re.fullmatch(r"k\d+\+\d+", base):
        return "k2" + mask

    # 레지스터 쌍 표기 '+N' 제거 (zmm2+3 → zmm2): 실제 어셈블리는 베이스 레지스터
    base = re.sub(r"\+\d+", "", base).strip()

    # 특수 다중 슬래시 메모리 타입은 분해 금지
    if base in MEM_BARE or base in MEM_PTR:
        val = _map_mem(base)
        return val

    # 슬래시 대안 (xmm3/m128/m64bcst, r32/m32, k2/m16, r16/r32/r64 ...): 레지스터 형 우선
    if "/" in base and base not in ("m14/28byte", "m94/108byte"):
        alts = [a.strip() for a in base.split("/") if a.strip()]
        reg_alts = [(a, _map_reg(a)) for a in alts if _map_reg(a) is not None]
        if reg_alts:
            # GP 레지스터가 여러 크기로 제시되면(r16/r32/r64 등) 64비트를 선호한다:
            # 64비트 모드에서 항상 유효하고, 주소/핸들 레지스터일 때 16비트 주소지정 오류를 피함.
            gp_rank = {"r64": 4, "r32": 3, "r16": 2, "r8": 1}
            def _rank(a: str) -> int:
                m = re.fullmatch(r"(r8|r16|r32|r64)[a-z]?", a)
                return gp_rank[m.group(1)] if m else 0
            if any(_rank(a) for a, _ in reg_alts):
                best = max(reg_alts, key=lambda x: _rank(x[0]))
                return best[1] + mask
            return reg_alts[0][1] + mask
        # 레지스터 대안이 없으면 메모리 대안
        for a in alts:
            mv = _map_mem(a)
            if mv is not None:
                return mv + (" " + mask if mask else "")
        return None

    # 단일 레지스터
    r = _map_reg(base)
    if r is not None:
        return r + mask

    # 단일 메모리
    mv = _map_mem(base)
    if mv is not None:
        return mv + (mask if mask else "")

    # 즉시값 / 상대주소
    if re.fullmatch(r"imm(8|16|32|64)", base):
        return "0x1"
    if re.fullmatch(r"rel(8|16|32)", base):
        return "1f"          # forward local label (파일에 1: 레이블 배치 필요)

    return None


def tokenize(operands: str) -> list[str]:
    return [t.strip() for t in operands.split(",") if t.strip()] if operands else []


# ── 문자열/특수 명령 특수 처리 ─────────────────────────────────────────
# SDM에 의해 고정 주소(rsi/rdi/rbx)를 사용하는 명령은 일반 매핑([rax])이 부적절.
# 크기 suffix 형(cmpsb/lodsq 등)으로 생성하면 주소 문제를 완전히 우회한다.
STRING_MNEMS_DIRECT = {"CMPS", "LODS", "MOVS", "SCAS", "STOS", "INS", "OUTS"}
_MSIZE_SUFFIX = {"m8": "b", "m16": "w", "m32": "d", "m64": "q"}
# XLAT는 [rbx]를 써야 함
XLAT_MNEM = "XLAT"


def gen_string_direct(mnem: str, operands: str) -> str | None:
    """비-prefix 문자열 명령(CMPS m8,m8 / LODS m32 등) → suffix 형으로 생성."""
    mup = mnem.upper()
    if mup not in STRING_MNEMS_DIRECT:
        return None
    # operands에서 메모리 크기 토큰 추출
    suffix = None
    for s, suf in _MSIZE_SUFFIX.items():
        if re.search(rf"\b{s}\b", operands):
            suffix = suf
            break
    if suffix is None:
        # AX/EAX/RAX 같은 레지스터로 크기 추론 (INS m8,DX 등에서 m 크기가 키)
        for reg, suf in [("AL", "b"), ("AX", "w"), ("EAX", "d"), ("RAX", "q"), ("DX", "")]:
            if re.search(rf"\b{reg}\b", operands) and suf:
                suffix = suf
                break
    if suffix is None:
        return None
    if mup in {"INS", "OUTS"} and suffix == "q":
        return None  # insq/outsq 없음
    return f"{mup.lower()}{suffix}"


# 문자열 prefix 명령어 처리: REP/REPE/REPNE 뒤에 문자열 op 가 오퍼랜드로 붙는다.
#   "REPNE SCAS m32" (mnem=REPNE, ops="SCAS m32") → "repne scasd"
#   "REP INS m8, DX"                              → "rep insb"
PREFIX_STRING = {"REP", "REPE", "REPZ", "REPNE", "REPNZ"}
STRING_OPS = {"CMPS", "LODS", "MOVS", "OUTS", "STOS", "SCAS", "INS"}
_SUF_MEM = [("m8", "b"), ("m16", "w"), ("m32", "d"), ("m64", "q")]
_SUF_REG = [("AL", "b"), ("AX", "w"), ("EAX", "d"), ("RAX", "q")]


def gen_prefixed_string(mnem: str, operands: str) -> str | None:
    """REP/REPE/REPNE + 문자열 op → 크기 접미어 형태로 생성. 아니면 None."""
    parts = operands.split()
    if not parts:
        return None
    inner = parts[0].upper()
    if inner not in STRING_OPS:
        return None
    suffix = None
    for s, suf in _SUF_MEM:
        if re.search(rf"\b{s}\b", operands):
            suffix = suf
            break
    if suffix is None:
        for s, suf in _SUF_REG:
            if re.search(rf"\b{s}\b", operands):
                suffix = suf
                break
    if suffix is None:
        return None
    if inner in {"INS", "OUTS"} and suffix == "q":   # insq/outsq 없음
        return None
    return f"{mnem.lower()} {inner.lower()}{suffix}"


# 어셈블 시 니모닉 보정:
#   GETSEC[CAPABILITIES] → getsec (leaf 표기는 어셈블리에 쓰지 않음)
#   SYSEXIT/SYSRET       → sysexitq/sysretq (오퍼랜드 없어 크기 모호 → 64비트 명시)
def normalize_mnemonic(mnem: str) -> str:
    m = re.sub(r"\[.*$", "", mnem)       # GETSEC[...] → GETSEC
    low = m.lower()
    return {"sysexit": "sysexitq", "sysret": "sysretq"}.get(low, low)


# ── mnemonic별 오퍼랜드 보정 (SDM 제약 위반 방지) ──────────────────────
# SDM에 명시된 제약으로 인해 일반 매핑 규칙으로는 거부되는 케이스를 개별 처리.
# 반환: 보정된 concretes 리스트 또는 None(보정 불필요).
def _fixup_operands(mnem: str, toks: list[str], concretes: list[str]) -> list[str] | None:
    mup = mnem.upper()
    # LSL r64, r32/m16 → as는 r64,r32 조합을 거부. SDM은 r64,r64/m16 허용.
    if mup == "LSL" and len(concretes) == 2 and concretes[0] == "rax" and concretes[1] == "eax":
        return ["rax", "rax"]
    # SENDUIPI r64 — SDM은 반드시 64비트 레지스터. r32→r64.
    if mup == "SENDUIPI" and concretes == ["eax"]:
        return ["rax"]
    # MOV Sreg, r/m16 — 세그먼트 레지스터는 r/m16/r/m64 만 수용. m64는 as가 거부.
    # "mov ds, QWORD PTR [rax]" → "mov ds, WORD PTR [rax]" 또는 "mov ds, ax"
    if mup == "MOV" and len(concretes) == 2 and concretes[0] == "ds":
        if "QWORD" in concretes[1]:
            return ["ds", "ax"]
    # PREFETCHIT0/1 — RIP-relative만 수용 (SDM §2.2)
    if mup in ("PREFETCHIT0", "PREFETCHIT1"):
        return ["BYTE PTR [rip+0x100]"]
    return None


# ── 음성 셋(negative set) 생성 — §4 N1/N2, 오라클=SDM #UD/정규화 규정 ──────
# 산출: data/stage3_operands/step3_generated_negative.s
#       + step3_coverage.csv 에 variant_axis="negative" 행으로 병합
VSIB_RE = re.compile(r"vm(32|64)([xyz])")
_VSIB_TYPE = {"x": "xmm", "y": "ymm", "z": "zmm"}


def _base_reg_type(tok: str) -> str | None:
    """토큰에서 벡터 레지스터 타입(xmm/ymm/zmm)만 뽑는다. 아니면 None."""
    b, _ = _strip_decorators(tok)
    m = re.fullmatch(r"(xmm|ymm|zmm)\d*", b.strip())
    return m.group(1) if m else None


def gen_negative_n1(forms: list[dict]) -> list[dict]:
    """
    N1 — gather 레지스터 aliasing (dest == index) → 아키텍처 #UD.
    근거: VGATHERDPS/VGATHERDPD 등 "If any pair of the index, mask, or
    destination registers are the same, this instruction results a UD fault."
    (SDM 325383-090, Vol.2C p.1824/1827). Stage 6 사례 1 재현.
    생성 규칙: dest 레지스터 번호를 index 레지스터 번호(2)와 동일하게 두어
    pair 충돌을 강제한다. VEX 형의 마스크 벡터는 distinct(번호 3)로 둔다.
    """
    rows = []
    seen = set()
    for row in forms:
        mnem = row["Mnemonic"].strip()
        toks = tokenize(row["Operands"])
        vsib_i = next((i for i, t in enumerate(toks)
                       if VSIB_RE.fullmatch(t.strip())), None)
        if vsib_i is None:
            continue
        vm = VSIB_RE.fullmatch(toks[vsib_i].strip())
        itype = _VSIB_TYPE[vm.group(2)]
        _, dmask = _strip_decorators(toks[0])       # EVEX 형의 {k1} 유지
        dtype = _base_reg_type(toks[0])
        if dtype is None:
            continue
        dest = f"{dtype}2{dmask}"                   # dest 번호 = index 번호(2) → #UD
        parts = [dest, f"[rax+{itype}2*1]"]
        if len(toks) >= 3:                          # VEX 형: 마스크 벡터(distinct)
            mtype = _base_reg_type(toks[2])
            if mtype:
                parts.append(f"{mtype}3")
        gen = f"{normalize_mnemonic(mnem)} {', '.join(parts)}"
        if gen in seen:
            continue
        seen.add(gen)
        rows.append({
            "Mnemonic": mnem, "Instruction": row["Instruction"],
            "Operands": row["Operands"], "Mappable": True, "Generated": gen,
            "UnknownTokens": "", "variant_axis": "negative", "variant_value": "N1",
            "expected_valid": "false",
            "sdm_basis": "VGATHER* p.1824/1827 (#UD if dest==index)",
        })
    return rows


def gen_negative_n2(forms: list[dict]) -> list[dict]:
    """
    N2 — VP2INTERSECT 마스크쌍에 홀수 목적지(k1) → 수용되나 정규화 divergence.
    근거: "The low bit of that field is masked off (set to zero) to create the
    first register of the pair." (SDM 325383-090, Vol.2C p.1894). Stage 6 사례 2.
    CPU는 저비트 마스킹으로 수용(아키텍처 유효) → expected_valid=undefined,
    핵심은 as(리터럴 k1) vs llvm(정규화 k0) 인코딩 divergence 측정.
    """
    rows = []
    seen = set()
    for row in forms:
        mnem = row["Mnemonic"].strip()
        if not mnem.upper().startswith("VP2INTERSECT"):
            continue
        toks = tokenize(row["Operands"])
        if not toks:
            continue
        src = []
        for t in toks[1:]:                          # source 오퍼랜드는 레지스터 형
            b, _ = _strip_decorators(t)
            b = re.sub(r"\+\d+", "", b).strip()
            if "/" in b:
                b = b.split("/")[0].strip()
            r = _map_reg(b)
            if r:
                src.append(r)
        gen = f"{normalize_mnemonic(mnem)} {', '.join(['k1'] + src)}"  # 홀수 dest k1
        if gen in seen:
            continue
        seen.add(gen)
        rows.append({
            "Mnemonic": mnem, "Instruction": row["Instruction"],
            "Operands": row["Operands"], "Mappable": True, "Generated": gen,
            "UnknownTokens": "", "variant_axis": "negative", "variant_value": "N2",
            "expected_valid": "undefined",
            "sdm_basis": "VP2INTERSECTD/Q p.1894 (low bit of MODRM.REG masked)",
        })
    return rows


# ── 축 C: EVEX disp8*N 경계 변주 (§3.3, ★측정가치 최대) ────────────────
# disp8 스케일 N = 메모리 오퍼랜드가 실제 접근하는 바이트 수(= 메모리 토큰 크기).
#   full-vector : m512→64, m256→32, m128→16   (tupletype Full/Half/FullMem)
#   scalar/tuple: m64→8, m32→4, m16→2, m8→1    (Tuple1 Scalar/Fixed)
# 브로드캐스트(m*bcst)는 EVEX.b=1 + {1toN} 데코레이터가 필요하므로 축 D에서 다룬다.
# 각 EVEX 메모리 form에 disp 경계 3점을 생성:
#   C1 [rax+N]      : N의 배수 → disp8*N(1바이트) 인코딩 가능
#   C2 [rax+N//2]   : N의 배수 아님 → disp32(4바이트) 강제 (N>=2)
#   C3 [rax+0x7F*N] : disp8*N 상한(127*N)
# → as vs llvm-mc 가 같은 N으로 압축하는지, 경계에서 인코딩 길이가 갈리는지 측정.
_MEM_SIZE_BYTES = {"m512": 64, "m256": 32, "m128": 16,
                   "m64": 8, "m32": 4, "m16": 2, "m8": 1}
# 축 C 전용: 벡터 메모리는 명시적 크기 PTR로 모호성 제거(bare [rax]는 VCVTPD2DQ 등
# 너비 축소 변환에서 크기 추론 불가 → 거부). 크기 지정은 인코딩 바이트를 바꾸지 않는다.
_MEM_PTR_VEC = {"m512": "ZMMWORD PTR", "m256": "YMMWORD PTR", "m128": "XMMWORD PTR"}


def _pick_mem_alt(operand_tok: str) -> str | None:
    """오퍼랜드 토큰에서 '순수 메모리 크기' 대안(m512/m64 등)만 뽑는다. bcst/reg-only는 None."""
    b, _ = _strip_decorators(operand_tok)
    b = re.sub(r"\+\d+", "", b).strip()
    for a in (x.strip() for x in b.split("/")):
        if a in _MEM_SIZE_BYTES:
            return a
    return None


def _disp_mem(mem_size_tok: str, disp: int) -> str | None:
    """메모리 크기 토큰 + disp → '[rax+0x..]' (또는 'SIZE PTR [rax+0x..]')."""
    ptr = _MEM_PTR_VEC.get(mem_size_tok)
    base_mem = f"{ptr} [rax]" if ptr else _map_mem(mem_size_tok)
    if base_mem is None or not base_mem.endswith("]"):
        return None
    d = f"+0x{disp:x}" if disp >= 0 else f"-0x{-disp:x}"
    return base_mem[:-1] + d + "]"


def gen_axis_c(forms: list[dict]) -> list[dict]:
    rows = []
    seen = set()
    for row in forms:
        if not row["Opcode"].strip().startswith("EVEX"):
            continue
        toks = tokenize(row["Operands"])
        if any(VSIB_RE.fullmatch(t.strip()) for t in toks):   # gather/scatter는 제외(VSIB)
            continue
        mem_i = mem_size = None
        for i, t in enumerate(toks):
            ms = _pick_mem_alt(t)
            if ms:
                mem_i, mem_size = i, ms
                break
        if mem_i is None:
            continue
        n = _MEM_SIZE_BYTES.get(mem_size)
        if not n:
            continue
        # 메모리 외 오퍼랜드는 레지스터 형으로 1회 매핑
        base_concretes, ok = [], True
        for i, t in enumerate(toks):
            if i == mem_i:
                base_concretes.append(None)
                continue
            v = map_operand(t)
            if v is None:
                ok = False
                break
            base_concretes.append(v)
        if not ok:
            continue
        _, memmask = _strip_decorators(toks[mem_i])   # 드물게 메모리 오퍼랜드의 마스크
        memmask = memmask.replace("{z}", "")           # 메모리 목적지 store에 {z}는 #UD (Table 2-42) → merge만
        for disp, label in ((n, "C1"), (n // 2, "C2"), (0x7F * n, "C3")):
            if label == "C2" and (n < 2 or disp == 0):
                continue
            memval = _disp_mem(mem_size, disp)
            if memval is None:
                continue
            parts = []
            for i, c in enumerate(base_concretes):
                if i == mem_i:
                    parts.append(memval + memmask)
                elif c != "":
                    parts.append(c)
            gen = normalize_mnemonic(row["Mnemonic"]) + (" " + ", ".join(parts) if parts else "")
            if gen in seen:
                continue
            seen.add(gen)
            rows.append({
                "Mnemonic": row["Mnemonic"].strip(), "Instruction": row["Instruction"],
                "Operands": row["Operands"], "Mappable": True, "Generated": gen,
                "UnknownTokens": "", "variant_axis": "disp8N", "variant_value": label,
                "expected_valid": "true",
                "sdm_basis": f"2.7.5 Table 2-36/37 disp8*N (N={n})",
            })
    return rows


# ── 축 A: 메모리 주소지정 형태 8종 (§3.1, ModRM.mod × SIB × RIP) ──────────
# 비-EVEX(legacy/VEX) 메모리 form 대상. EVEX의 disp 변주는 축 C가 담당하므로 제외.
# A8(r13 base)은 mod=00 불가 → 어셈블러가 강제 disp8=0 우회 인코딩을 택하는 지점(도구 차이 후보).
_ADDR_FORMS = [
    ("A1", "[rax]"),          # mod=00 직접
    ("A2", "[rax+0x7f]"),     # mod=01 disp8
    ("A3", "[rax+0x80]"),     # mod=10 disp32 (disp8 경계 초과)
    ("A4", "[rax+rbx*4]"),    # SIB base+index*scale
    ("A5", "[rbx*8+0x10]"),   # SIB base 없음
    ("A6", "[rip+0x100]"),    # RIP-relative (64-bit 신설)
    ("A7", "[0x1000]"),       # 절대 (SIB, no base/index)
    ("A8", "[r13]"),          # mod=00 불가 → 강제 disp8=0 특수 인코딩
]


def _mem_prefix_of(token: str) -> tuple[str, str] | None:
    """토큰의 메모리 대안이 단순 base('[rax]' / 'SIZE PTR [rax]')로 매핑되면 (prefix, mask).
    moffs/mib/sibmem/vsib(비단순 주소) 및 메모리 없음은 None."""
    b, mask = _strip_decorators(token)
    b = re.sub(r"\+\d+", "", b).strip()
    for a in (x.strip() for x in b.split("/")):
        mv = _map_mem(a)
        if mv is not None and mv.endswith("[rax]"):
            return mv[:mv.index("[")], mask
    return None


def gen_axis_a(forms: list[dict]) -> list[dict]:
    rows = []
    seen = set()
    for row in forms:
        if row["Opcode"].strip().startswith("EVEX"):    # EVEX disp는 축 C
            continue
        toks = tokenize(row["Operands"])
        if any(VSIB_RE.fullmatch(t.strip()) for t in toks):
            continue
        mem_i = prefix = memmask = None
        for i, t in enumerate(toks):
            r = _mem_prefix_of(t)
            if r is not None:
                mem_i, (prefix, memmask) = i, r
                break
        if mem_i is None:
            continue
        base_concretes, ok = [], True
        for i, t in enumerate(toks):
            if i == mem_i:
                base_concretes.append(None)
                continue
            v = map_operand(t)
            if v is None:
                ok = False
                break
            base_concretes.append(v)
        if not ok:
            continue
        for label, addr in _ADDR_FORMS:
            memval = f"{prefix}{addr}{memmask}"
            parts = []
            for i, c in enumerate(base_concretes):
                if i == mem_i:
                    parts.append(memval)
                elif c != "":
                    parts.append(c)
            gen = normalize_mnemonic(row["Mnemonic"]) + (" " + ", ".join(parts) if parts else "")
            if gen in seen:
                continue
            seen.add(gen)
            rows.append({
                "Mnemonic": row["Mnemonic"].strip(), "Instruction": row["Instruction"],
                "Operands": row["Operands"], "Mappable": True, "Generated": gen,
                "UnknownTokens": "", "variant_axis": "addr", "variant_value": label,
                "expected_valid": "true",
                "sdm_basis": "2.1.3/2.1.5 ModRM·SIB·RIP",
            })
    return rows


# ── 축 D: reg/mem/bcst 대안 전개 — 브로드캐스트 D3 (§3.4, §2.7.7) ─────────
# D1(reg)=base, D2(mem)⊂축 C 이므로 여기선 D3(브로드캐스트 {1toK})만 생성.
# K = VL_bytes / element_bytes. VL·element 모두 bcst 오퍼랜드 토큰에서 국소 추출:
#   xmm2/m128/m32bcst → VL=m128=16, elem=m32bcst=4 → {1to4}.
# 축 D 전용: 브로드캐스트 element 크기 → PTR prefix (llvm-mc가 크기 추론 불가 시 거부 방지)
_BCST_ELEM_PTR = {4: "DWORD PTR", 8: "QWORD PTR", 2: "WORD PTR"}


def gen_axis_d(forms: list[dict]) -> list[dict]:
    rows = []
    seen = set()
    for row in forms:
        if not row["Opcode"].strip().startswith("EVEX"):
            continue
        toks = tokenize(row["Operands"])
        if any(VSIB_RE.fullmatch(t.strip()) for t in toks):
            continue
        mem_i = elem = vl = None
        for i, t in enumerate(toks):
            b, _ = _strip_decorators(t)
            b = re.sub(r"\+\d+", "", b).strip()
            alts = [x.strip() for x in b.split("/")]
            e = next((int(m.group(1)) // 8 for a in alts
                      if (m := re.fullmatch(r"m(\d+)bcst", a))), None)
            if e is None:
                continue
            v = next((int(m.group(1)) // 8 for a in alts
                      if (m := re.fullmatch(r"m(\d+)", a))), None)
            mem_i, elem, vl = i, e, v
            break
        if mem_i is None or not elem or not vl:
            continue
        k = vl // elem
        base_concretes, ok = [], True
        for i, t in enumerate(toks):
            if i == mem_i:
                base_concretes.append(None)
                continue
            v = map_operand(t)
            if v is None:
                ok = False
                break
            base_concretes.append(v)
        if not ok:
            continue
        # Element PTR prefix로 llvm-mc 크기 추론 실패 방지
        elem_ptr = _BCST_ELEM_PTR.get(elem, "")
        mem_expr = f"{elem_ptr} [rax]{{1to{k}}}" if elem_ptr else f"[rax]{{1to{k}}}"
        parts = []
        for i, c in enumerate(base_concretes):
            if i == mem_i:
                parts.append(mem_expr)
            elif c != "":
                parts.append(c)
        gen = normalize_mnemonic(row["Mnemonic"]) + " " + ", ".join(parts)
        if gen in seen:
            continue
        seen.add(gen)
        rows.append({
            "Mnemonic": row["Mnemonic"].strip(), "Instruction": row["Instruction"],
            "Operands": row["Operands"], "Mappable": True, "Generated": gen,
            "UnknownTokens": "", "variant_axis": "alt_form", "variant_value": "D3",
            "expected_valid": "true",
            "sdm_basis": f"2.7.7 broadcast {{1to{k}}} (elem N={elem})",
        })
    return rows


def _is_valid_64bit(mode: str) -> bool:
    """ModeSupport 값이 64비트에서 유효(Valid)인지 판별."""
    m = (mode or "").strip().lower()
    if not m:
        return True  # 정보 없으면 유효로 간주
    # 'Valid', 'V/V', 'V/N.E.' 등 — 첫 토큰(64-bit)이 'v'로 시작하면 유효
    first = m.split("/")[0].strip() if "/" in m else m
    return first.startswith("v")


def main():
    OUT_DIR.mkdir(parents=True, exist_ok=True)

    # 1) 전체 오퍼랜드 타입 사전 만들기 (검토용)
    all_tokens: set[str] = set()
    forms: list[dict] = []
    with IN_CSV.open(encoding="utf-8-sig") as f:
        for row in csv.DictReader(f):
            forms.append(row)
            for t in tokenize(row["Operands"]):
                all_tokens.add(t)

    with (OUT_DIR / "step3_operand_candidates.csv").open("w", newline="", encoding="utf-8-sig") as f:
        w = csv.writer(f)
        w.writerow(["operand_type", "concrete_value", "status"])
        for t in sorted(all_tokens):
            v = map_operand(t)
            status = "implicit_drop" if v == "" else ("UNMAPPED" if v is None else "ok")
            w.writerow([t, "" if v is None else v, status])

    # 2) form별 커버리지 + 생성된 어셈블리
    cov_rows = []
    asm_lines = [".intel_syntax noprefix", "// Stage3 generated (register-form, masks kept, er/sae dropped)", ""]
    mappable = 0
    invalid_skipped = 0
    for row in forms:
        mnem = row["Mnemonic"].strip()
        ops_str = row["Operands"]
        toks = tokenize(ops_str)
        mode_valid = _is_valid_64bit(row.get("ModeSupport", ""))

        # 64비트 무효 form은 매핑하되 base asm에는 넣지 않고 expected_valid=false로 마킹
        if not mode_valid:
            concretes, unknown = [], []
            for t in toks:
                v = map_operand(t)
                if v is None:
                    unknown.append(t)
                elif v != "":
                    concretes.append(v)
            gen_mnem = normalize_mnemonic(mnem)
            ok = len(unknown) == 0 and mnem != ""
            cov_rows.append({
                "Mnemonic": mnem,
                "Instruction": row["Instruction"],
                "Operands": ops_str,
                "Mappable": ok,
                "Generated": (gen_mnem + (" " + ", ".join(concretes) if concretes else "")) if ok else "",
                "UnknownTokens": ", ".join(unknown),
                "_mode_valid": False,
            })
            invalid_skipped += 1
            continue

        # bare 프리픽스(LOCK/XACQUIRE/XRELEASE 단독)는 유효 명령이 아님 → 생성 제외 (§3.2)
        if mnem.upper() in {"LOCK", "XACQUIRE", "XRELEASE"} and not toks:
            cov_rows.append({"Mnemonic": mnem, "Instruction": row["Instruction"],
                             "Operands": ops_str, "Mappable": False,
                             "Generated": "", "UnknownTokens": "(bare prefix skipped)"})
            continue

        # 문자열 명령 특수 처리 (SDM: rsi/rdi 고정 주소 — suffix 형으로 우회)
        if mnem.upper() in STRING_MNEMS_DIRECT:
            gen = gen_string_direct(mnem, ops_str)
            if gen is not None:
                mappable += 1
                asm_lines.append(f"    {gen}")
                cov_rows.append({"Mnemonic": mnem, "Instruction": row["Instruction"],
                                 "Operands": ops_str, "Mappable": True,
                                 "Generated": gen, "UnknownTokens": ""})
                continue

        # XLAT: [rbx] 고정 (SDM: DS:rBX+AL)
        if mnem.upper() == "XLAT":
            gen = "xlatb"
            mappable += 1
            asm_lines.append(f"    {gen}")
            cov_rows.append({"Mnemonic": mnem, "Instruction": row["Instruction"],
                             "Operands": ops_str, "Mappable": True,
                             "Generated": gen, "UnknownTokens": ""})
            continue

        # 문자열 prefix 형(REP/REPE/REPNE + 문자열 op) 특수 처리
        if mnem.upper() in PREFIX_STRING:
            gen = gen_prefixed_string(mnem, ops_str)
            if gen is not None:
                mappable += 1
                asm_lines.append(f"    {gen}")
                cov_rows.append({"Mnemonic": mnem, "Instruction": row["Instruction"],
                                 "Operands": ops_str, "Mappable": True,
                                 "Generated": gen, "UnknownTokens": ""})
                continue
            # 실패 시 아래 일반 경로로 (대개 미매핑 처리됨)

        concretes, unknown = [], []
        for t in toks:
            v = map_operand(t)
            if v is None:
                unknown.append(t)
            elif v != "":
                concretes.append(v)
        ok = len(unknown) == 0 and mnem != ""
        gen_mnem = normalize_mnemonic(mnem)
        # SDM 제약에 의한 오퍼랜드 보정
        if ok:
            fixed = _fixup_operands(mnem, toks, concretes)
            if fixed is not None:
                concretes = fixed
        if ok:
            mappable += 1
            line = gen_mnem + (" " + ", ".join(concretes) if concretes else "")
            asm_lines.append(f"    {line}")
        cov_rows.append({
            "Mnemonic": mnem,
            "Instruction": row["Instruction"],
            "Operands": row["Operands"],
            "Mappable": ok,
            "Generated": (gen_mnem + (" " + ", ".join(concretes) if concretes else "")) if ok else "",
            "UnknownTokens": ", ".join(unknown),
        })

    # 3) §6 스키마 컬럼 부여 — 양성(base) 행 기본값
    #    variant_axis=base, variant_value 없음, expected_valid=매핑되면 true(모호하면 undefined)
    #    64비트 무효(Invalid) 행은 expected_valid=false, sdm_basis에 근거 표기
    for r in cov_rows:
        r["variant_axis"] = "base"
        r["variant_value"] = ""
        if r.pop("_mode_valid", True) is False:
            r["expected_valid"] = "false"
            r["sdm_basis"] = "ModeSupport=Invalid (64-bit N.E./N.S.)"
        else:
            r["expected_valid"] = "true" if r["Mappable"] else "undefined"
            r["sdm_basis"] = ""

    # 4) 음성 셋 N1/N2 생성 → 별도 .s + coverage 병합
    neg_rows = gen_negative_n1(forms) + gen_negative_n2(forms)
    neg_lines = [".intel_syntax noprefix",
                 "// Stage3 negative set (N1: gather aliasing #UD, N2: VP2INTERSECT odd-k)",
                 ""]
    neg_lines += [f"    {r['Generated']}" for r in neg_rows]
    (OUT_DIR / "step3_generated_negative.s").write_text(
        "\n".join(neg_lines) + "\n", encoding="utf-8")

    # 5) 축 C — EVEX disp8*N 경계 변주 → 별도 .s + coverage 병합
    axisc_rows = gen_axis_c(forms)
    axisc_lines = [".intel_syntax noprefix",
                   "// Stage3 axis C (EVEX disp8*N boundary: C1 multiple / C2 disp32 / C3 max)",
                   ""]
    axisc_lines += [f"    {r['Generated']}" for r in axisc_rows]
    (OUT_DIR / "step3_generated_axisC.s").write_text(
        "\n".join(axisc_lines) + "\n", encoding="utf-8")

    # 6) 축 A — 주소지정 8종(비-EVEX), 축 D — 브로드캐스트 D3(EVEX) → 별도 .s + 병합
    axisa_rows = gen_axis_a(forms)
    axisa_lines = [".intel_syntax noprefix",
                   "// Stage3 axis A (addressing forms A1-A8: disp8/disp32/SIB/RIP/abs/r13)", ""]
    axisa_lines += [f"    {r['Generated']}" for r in axisa_rows]
    (OUT_DIR / "step3_generated_axisA.s").write_text(
        "\n".join(axisa_lines) + "\n", encoding="utf-8")

    axisd_rows = gen_axis_d(forms)
    axisd_lines = [".intel_syntax noprefix",
                   "// Stage3 axis D (EVEX broadcast form D3: [rax]{1toK})", ""]
    axisd_lines += [f"    {r['Generated']}" for r in axisd_rows]
    (OUT_DIR / "step3_generated_axisD.s").write_text(
        "\n".join(axisd_lines) + "\n", encoding="utf-8")

    schema = ["Mnemonic", "Instruction", "Operands", "Mappable", "Generated",
              "UnknownTokens", "variant_axis", "variant_value",
              "expected_valid", "sdm_basis"]
    with (OUT_DIR / "step3_coverage.csv").open("w", newline="", encoding="utf-8-sig") as f:
        w = csv.DictWriter(f, fieldnames=schema)
        w.writeheader()
        w.writerows(cov_rows + neg_rows + axisc_rows + axisa_rows + axisd_rows)

    (OUT_DIR / "step3_generated.s").write_text("\n".join(asm_lines) + "\n1:\n", encoding="utf-8")

    total = len(forms)
    # 실제로 스킵된 form 에서만 미매핑 토큰을 수집 (prefix 특수처리된 form 제외)
    unmapped_types = set()
    for r in cov_rows:
        if not r["Mappable"] and r["UnknownTokens"]:
            for t in r["UnknownTokens"].split(", "):
                unmapped_types.add(t)
    unmapped_types = sorted(unmapped_types)
    skipped = total - mappable - invalid_skipped
    print(f"[저장] {OUT_DIR}")
    print(f"  form: {total}, 매핑가능(생성됨): {mappable} ({mappable/total*100:.1f}%)")
    print(f"  64비트 무효(Invalid, asm 미포함): {invalid_skipped}")
    print(f"  미매핑 스킵: {skipped}")
    print(f"  스킵 form의 미매핑 타입: {len(unmapped_types)}")
    n1 = sum(1 for r in neg_rows if r["variant_value"] == "N1")
    n2 = sum(1 for r in neg_rows if r["variant_value"] == "N2")
    print(f"  음성 셋: N1(gather aliasing)={n1}, N2(VP2INTERSECT odd-k)={n2} "
          f"→ step3_generated_negative.s")
    from collections import Counter
    cc = Counter(r["variant_value"] for r in axisc_rows)
    print(f"  축 C(disp8*N): {len(axisc_rows)}건 "
          f"(C1={cc['C1']}, C2={cc['C2']}, C3={cc['C3']}) → step3_generated_axisC.s")
    print(f"  축 A(주소지정 8종, 비-EVEX): {len(axisa_rows)}건 → step3_generated_axisA.s")
    print(f"  축 D(broadcast D3, EVEX): {len(axisd_rows)}건 → step3_generated_axisD.s")
    print(f"\n  미매핑 타입 목록:")
    for t in unmapped_types:
        print(f"     {t!r}")


if __name__ == "__main__":
    main()

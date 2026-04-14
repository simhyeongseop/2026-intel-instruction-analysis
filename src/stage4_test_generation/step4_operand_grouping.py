"""
Step 4-1: Operand 그룹화 (4회 미팅 액션 아이템)

Intel 명령어 오퍼랜드 타입(r16, m32 등)을 실제 레지스터/값으로 매핑하는 그룹을 정의하고
조합 리스트를 생성합니다.

미팅 규칙:
- IMM: 최대값(0xFF, 0xFFFF 등) 16진수 사용
- Memory: Effective Addressing + RIP-relative 방식 혼합
- Memory 크기 명시: BYTE PTR, WORD PTR, DWORD PTR, QWORD PTR 등
"""

import pandas as pd
import re
import json
from pathlib import Path
from itertools import product
import random

# ============================================================
# 1. Operand 타입 → 실제 값 매핑 정의
# ============================================================

OPERAND_GROUPS = {
    # ─── 8비트 일반 레지스터 ───
    "r8": ["al", "cl", "dl", "bl", "ah", "ch", "dh", "bh"],
    "r81": ["al", "cl", "dl", "bl"],   # REX prefix 사용 시 ah/ch/dh/bh 사용 불가

    # ─── 16비트 일반 레지스터 ───
    "r16": ["ax", "bx", "cx", "dx", "si", "di", "bp", "sp"],

    # ─── 32비트 일반 레지스터 ───
    "r32": ["eax", "ebx", "ecx", "edx", "esi", "edi", "ebp"],

    # ─── 64비트 일반 레지스터 ───
    "r64": ["rax", "rbx", "rcx", "rdx", "rsi", "rdi", "rbp",
            "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15"],

    # ─── 고정 레지스터 (명시 지정) ───
    "AL":  ["al"],
    "AX":  ["ax"],
    "EAX": ["eax"],
    "RAX": ["rax"],
    "CL":  ["cl"],
    "DX":  ["dx"],
    "CR8": ["cr8"],

    # ─── 세그먼트 레지스터 ───
    "CS": ["cs"], "DS": ["ds"], "ES": ["es"],
    "FS": ["fs"], "GS": ["gs"], "SS": ["ss"],
    "Sreg": ["cs", "ds", "es", "fs", "gs", "ss"],
    "Sreg2": ["fs", "gs"],

    # ─── FPU 레지스터 ───
    "ST":    ["st(0)"],
    "ST(0)": ["st(0)"],
    "ST(i)": ["st(0)", "st(1)", "st(2)", "st(3)"],

    # ─── XMM 벡터 레지스터 (SSE) ───
    "xmm":  ["xmm0", "xmm1", "xmm2", "xmm3"],
    "xmm0": ["xmm0"],
    "xmm1": ["xmm1"],
    "xmm2": ["xmm2"],
    "xmm3": ["xmm3"],
    "xmm4": ["xmm4"],

    # ─── YMM 벡터 레지스터 (AVX) ───
    "ymm":  ["ymm0", "ymm1", "ymm2", "ymm3"],
    "ymm1": ["ymm1"],
    "ymm2": ["ymm2"],
    "ymm3": ["ymm3"],
    "ymm4": ["ymm4"],

    # ─── ZMM 벡터 레지스터 (AVX-512) ───
    "zmm1": ["zmm1"],
    "zmm2": ["zmm2"],
    "zmm3": ["zmm3"],

    # ─── MMX 레지스터 ───
    "mm":   ["mm0", "mm1", "mm2", "mm3"],
    "mm1":  ["mm1"],
    "mm2":  ["mm2"],

    # ─── Mask 레지스터 (AVX-512) ───
    "k1": ["k1"],
    "k2": ["k2"],
    "k3": ["k3"],

    # ─── Bound 레지스터 (MPX) ───
    "bnd":  ["bnd0", "bnd1", "bnd2", "bnd3"],
    "bnd1": ["bnd0"],
    "bnd2": ["bnd1"],

    # ─── 즉시값 (Immediate) - 미팅 규칙: 최대값 사용 ───
    "imm8":  ["0xff"],
    "imm16": ["0xffff"],
    "imm32": ["0xffffffff"],
    "imm64": ["0x7fffffffffffffff"],   # 부호있는 64bit 최대
    "imm81": ["0xff"],   # imm8의 변형 (sign-extended)

    # ─── 상대 주소 (Branch) ───
    "rel8":  ["0x7f"],
    "rel16": ["0x7fff"],
    "rel32": ["0x7fffffff"],

    # ─── 원거리 포인터 ───
    "ptr16:16": ["0x0033:0x00001000"],
    "ptr16:32": ["0x0033:0x00001000"],
}

# ─── 메모리 접근식 생성 (Effective Addressing + RIP-relative) ───
# 미팅 규칙: BYTE/WORD/DWORD/QWORD PTR 명시, 두 가지 방식 혼합
MEM_EFFECTIVE = [
    "[rax]",
    "[rbx]",
    "[rax + rbx*1 + 0x10]",
    "[rax + rbx*2 + 0x100]",
    "[rax + rbx*4 + 0x100]",
    "[rax + rbx*8 + 0x1000]",
]

MEM_RIP_RELATIVE = [
    "[rip + 0x10]",
    "[rip + 0x100]",
    "[rip + 0x1000]",
]

MEM_ALL = MEM_EFFECTIVE + MEM_RIP_RELATIVE

def make_mem_group(ptr_prefix: str):
    """메모리 접근식에 크기 지시어 붙이기"""
    return [f"{ptr_prefix} {addr}" for addr in MEM_ALL]

OPERAND_GROUPS.update({
    "m8":   make_mem_group("BYTE PTR"),
    "m16":  make_mem_group("WORD PTR"),
    "m32":  make_mem_group("DWORD PTR"),
    "m64":  make_mem_group("QWORD PTR"),
    "m128": make_mem_group("XMMWORD PTR"),
    "m256": make_mem_group("YMMWORD PTR"),
    "m512": make_mem_group("ZMMWORD PTR"),
    "m81":  make_mem_group("BYTE PTR"),   # m8의 변형

    # Vector 메모리 (AVX-512 gather/scatter용 - 단순화)
    "vm32x": ["[rax + xmm1*4]"],
    "vm32y": ["[rax + ymm1*4]"],
    "vm32z": ["[rax + zmm1*4]"],
    "vm64x": ["[rax + xmm1*8]"],
    "vm64y": ["[rax + ymm1*8]"],
    "vm64z": ["[rax + zmm1*8]"],
})


# ============================================================
# 2. Instruction 행 파싱 및 operand 토큰 추출
# ============================================================

# 표준 operand 타입 패턴 (인식 가능한 것들)
KNOWN_OPERAND_TYPES = set(OPERAND_GROUPS.keys())

def parse_instruction(instruction_str: str):
    """
    'ADC r16' → ('ADC', ['r16'])
    'MOV r64 r64' → ('MOV', ['r64', 'r64'])
    """
    parts = instruction_str.strip().split(None, 1)
    mnemonic = parts[0]
    if len(parts) == 1:
        return mnemonic, []

    operand_part = parts[1]
    # 쉼표 또는 공백으로 구분 (stage2 데이터는 공백 구분)
    tokens = [t.strip().strip("{}") for t in re.split(r"[,\s]+", operand_part)]
    tokens = [t for t in tokens if t]
    return mnemonic, tokens


def get_operand_candidates(token: str):
    """operand 토큰에 대한 실제 값 후보 목록 반환"""
    if token in OPERAND_GROUPS:
        return OPERAND_GROUPS[token]
    # 알 수 없는 토큰은 그대로 반환 (specific register 등)
    return [token.lower()]


# ============================================================
# 3. 조합 리스트 생성
# ============================================================

def generate_combinations(mnemonic: str, operand_tokens: list, n_random: int = 10):
    """
    주어진 operand 토큰 목록에서 랜덤하게 n_random개 실제 값 조합을 생성.
    Returns: list of assembly instruction strings
    """
    if not operand_tokens:
        return [mnemonic]

    candidate_lists = [get_operand_candidates(tok) for tok in operand_tokens]

    # 전체 경우의 수
    total = 1
    for c in candidate_lists:
        total *= len(c)

    results = set()
    attempts = 0
    max_attempts = n_random * 10

    while len(results) < min(n_random, total) and attempts < max_attempts:
        chosen = [random.choice(cl) for cl in candidate_lists]
        asm_line = mnemonic + " " + ", ".join(chosen)
        results.add(asm_line)
        attempts += 1

    return list(results)


# ============================================================
# 4. 메인 실행 - 그룹화 결과를 CSV로 저장
# ============================================================

def main():
    base = Path(__file__).parent.parent.parent
    stage2_path = base / "data" / "stage2_opcode_split" / "step2_final_instruction_opcode_split.csv"
    out_dir = base / "data" / "stage4_tests"
    out_dir.mkdir(parents=True, exist_ok=True)

    print("=" * 60)
    print("Step 4-1: Operand 그룹화")
    print("=" * 60)

    # Operand 그룹 테이블 저장
    group_rows = []
    for op_type, values in OPERAND_GROUPS.items():
        for v in values:
            group_rows.append({"OperandType": op_type, "ConcreteValue": v})
    df_groups = pd.DataFrame(group_rows)
    group_csv = out_dir / "step4_operand_groups.csv"
    df_groups.to_csv(group_csv, index=False, encoding="utf-8")
    print(f"\n[완료] Operand 그룹 테이블 저장: {group_csv}")
    print(f"  - 총 {len(df_groups['OperandType'].unique())}개 타입, {len(df_groups)}개 매핑")

    # Stage2 데이터 로드
    df2 = pd.read_csv(stage2_path, encoding="utf-16")
    print(f"\n[로드] Stage2 명령어: {len(df2)}개")

    # 표준 패턴 명령어만 필터링
    standard_pat = re.compile(
        r"^[A-Z][A-Z0-9]{1,15}"
        r"(\s+(r8|r81|r16|r32|r64|m8|m81|m16|m32|m64|m128|m256|m512"
        r"|imm8|imm81|imm16|imm32|imm64|rel8|rel16|rel32"
        r"|AL|AX|EAX|RAX|CL|DX|CR8|CS|DS|ES|FS|GS|SS|Sreg|Sreg2|ST"
        r"|xmm\d?|ymm\d?|zmm\d?|mm\d?|k[1-3]|bnd\d?"
        r"|vm32x|vm32y|vm32z|vm64x|vm64y|vm64z"
        r"|ptr16:16|ptr16:32))+$"
    )
    mask = df2["Instruction"].apply(lambda x: bool(standard_pat.match(str(x))) if pd.notna(x) else False)
    df_standard = df2[mask].copy()
    print(f"[필터] 표준 operand 형태: {len(df_standard)}개")

    # 파싱 결과 저장
    parsed_rows = []
    for _, row in df_standard.iterrows():
        mnemonic, tokens = parse_instruction(row["Instruction"])
        parsed_rows.append({
            "Original": row["Original"],
            "Instruction": row["Instruction"],
            "Mnemonic": mnemonic,
            "OperandTokens": "|".join(tokens),
            "OperandCount": len(tokens),
        })

    df_parsed = pd.DataFrame(parsed_rows)
    parsed_csv = out_dir / "step4_instructions_parsed.csv"
    df_parsed.to_csv(parsed_csv, index=False, encoding="utf-8")
    print(f"[완료] 파싱된 명령어 저장: {parsed_csv}")

    # 통계 출력
    print(f"\n=== Operand 개수별 분포 ===")
    print(df_parsed["OperandCount"].value_counts().sort_index().to_string())

    print(f"\n=== 알려진 Operand 타입 목록 ({len(KNOWN_OPERAND_TYPES)}개) ===")
    for t in sorted(KNOWN_OPERAND_TYPES):
        vals = OPERAND_GROUPS[t]
        print(f"  {t:15s} → {len(vals)}개 : {vals[:3]}{'...' if len(vals)>3 else ''}")

    print(f"\n[완료] Step 4-1 Operand 그룹화 완료")
    return df_parsed


if __name__ == "__main__":
    main()

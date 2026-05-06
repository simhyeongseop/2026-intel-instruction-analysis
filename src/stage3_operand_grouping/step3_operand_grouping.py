"""
Stage 3: Operand 그룹화

Stage 2에서 나온 instruction form의 오퍼랜드 타입 각각에 대해
실제 어셈블리에 대입 가능한 후보값(candidate)을 정의한다.

출력:
  data/stage3_operands/step3_operand_groups.csv   — 타입별 후보값 목록
  data/stage3_operands/step3_coverage_report.csv  — instruction form별 매핑 가능 여부
"""

import pandas as pd
from pathlib import Path

# ============================================================
# 1. 오퍼랜드 타입 정규화 매핑 (오타/변형 → 표준 이름)
# ============================================================

NORMALIZE = {
    # r8 계열 변형 (Stage 1 cleaning 후에도 혹시 남아있을 경우 대비)
    'r81': 'r8', 'r82': 'r8',
    # m8 계열 변형
    'm81': 'm8', 'm82': 'm8',
    # 고정 레지스터 약칭
    'RAX': 'RAX', 'EAX': 'EAX', 'AX': 'AX', 'AL': 'AL',
    'CL': 'CL', 'DX': 'DX',
    # 세그먼트 레지스터
    'CS': 'CS', 'DS': 'DS', 'ES': 'ES',
    'FS': 'FS', 'GS': 'GS', 'SS': 'SS',
    # FPU 메모리 → 크기별 m 타입으로 변환
    'm32fp': 'm32', 'm64fp': 'm64', 'm80fp': 'm80',
    'm16int': 'm16', 'm32int': 'm32', 'm64int': 'm64',
    # 상수 리터럴 1 (일부 shift 명령어)
    '1': 'imm_1',
    # moffs 계열 (MOV 절대주소 전용) → moffset 그룹으로 통합
    'moffs8':  'moffset', 'moffs16': 'moffset',
    'moffs32': 'moffset', 'moffs64': 'moffset',
    'moffset': 'moffset',
    # r/m16 혼합 표기 (LAR/LSL/MOV Sreg 등) → 16-bit 메모리로 처리
    'r16/m16':     'm16',
    'r32/m16':     'm16',
    'r64/m16':     'm16',
    'r16/r32/m16': 'm16',
    # INVLPG m (크기 미지정 메모리) → 64-bit 주소로 처리
    'm': 'm64',
    # ENTER 두 번째 operand 0 (nest level, 항상 0)
    '0': 'imm_1',
}

# ============================================================
# 2. 오퍼랜드 그룹 → 실제 값 후보 매핑
# ============================================================

def _mem(ptr: str) -> list[str]:
    return [
        f"{ptr} [rax]",
        f"{ptr} [rbx]",
        f"{ptr} [rax + rbx*1 + 0x10]",
        f"{ptr} [rax + rbx*4 + 0x100]",
        f"{ptr} [rip + 0x100]",
        f"{ptr} [rip + 0x1000]",
    ]

OPERAND_GROUPS: dict[str, list[str]] = {
    # 일반 레지스터
    'r8':  ['al', 'cl', 'dl', 'bl'],
    'r16': ['ax', 'bx', 'cx', 'dx', 'si', 'di'],
    'r32': ['eax', 'ebx', 'ecx', 'edx', 'esi', 'edi'],
    'r64': ['rax', 'rbx', 'rcx', 'rdx', 'rsi', 'rdi',
            'r8',  'r9',  'r10', 'r11', 'r12', 'r13'],

    # 메모리 접근
    'm8':  _mem('BYTE PTR'),
    'm16': _mem('WORD PTR'),
    'm32': _mem('DWORD PTR'),
    'm64': _mem('QWORD PTR'),
    'm80': _mem('TBYTE PTR'),
    'm128': _mem('XMMWORD PTR'),
    'm256': _mem('YMMWORD PTR'),
    'm512': _mem('ZMMWORD PTR'),

    # 즉시값
    # imm8/imm16은 unsigned max 사용 (해당 비트 범위 내에서 유효)
    # imm32는 signed max 사용 — r64+imm32 조합 시 sign-extended이므로
    #   signed 32-bit 범위(-2^31 ~ 2^31-1) 안에 있어야 어셈블러가 수용
    'imm8':  ['0xff'],
    'imm16': ['0xffff'],
    'imm32': ['0xffffffff'],          # r32/m32 대상 — unsigned max (부호없는 32비트 최대)
    'imm32_sext': ['0x7fffffff', '-1'],  # r64/m64 대상 — sign-extended 양쪽 경계값
    'imm64': ['0x7fffffffffffffff'],
    'imm_1': ['1'],  # 시프트 명령어의 상수 1

    # 상대 주소 — '.'(현재 주소)로 고정
    # 절대값을 쓰면 파일 내 PC 위치에 따라 range 초과 오류 발생
    # '.'은 현재 명령어 주소 = offset이 항상 -2 (instruction 크기) → rel8 범위 내
    'rel8':  ['.'],
    'rel16': ['.'],
    'rel32': ['.'],

    # 고정 레지스터
    'AL':  ['al'],  'AX':  ['ax'],
    'EAX': ['eax'], 'RAX': ['rax'],
    'CL':  ['cl'],  'DX':  ['dx'],

    # 세그먼트 레지스터
    'CS': ['cs'], 'DS': ['ds'], 'ES': ['es'],
    'FS': ['fs'], 'GS': ['gs'], 'SS': ['ss'],
    'Sreg':  ['cs', 'ds', 'es', 'fs', 'gs', 'ss'],
    'Sreg2': ['fs', 'gs'],

    # FPU 스택
    'ST':    ['st(0)'],
    'ST(0)': ['st(0)'],
    'ST(i)': ['st(0)', 'st(1)', 'st(2)', 'st(3)'],

    # XMM / YMM / ZMM (AVX)
    'xmm':  ['xmm0', 'xmm1', 'xmm2', 'xmm3'],
    'xmm1': ['xmm0', 'xmm1', 'xmm2'],
    'xmm2': ['xmm0', 'xmm1', 'xmm2'],
    'xmm3': ['xmm0', 'xmm1', 'xmm2'],
    'ymm1': ['ymm0', 'ymm1', 'ymm2'],
    'ymm2': ['ymm0', 'ymm1', 'ymm2'],
    'ymm3': ['ymm0', 'ymm1', 'ymm2'],
    'zmm1': ['zmm0', 'zmm1', 'zmm2'],
    'zmm2': ['zmm0', 'zmm1', 'zmm2'],
    'zmm3': ['zmm0', 'zmm1', 'zmm2'],

    # MMX
    'mm':   ['mm0', 'mm1', 'mm2', 'mm3'],
    'mm1':  ['mm0', 'mm1'],
    'mm2':  ['mm0', 'mm1'],

    # Mask 레지스터 (AVX-512)
    'k1': ['k1'], 'k2': ['k2'], 'k3': ['k3'],

    # Bound 레지스터 (MPX)
    'bnd':  ['bnd0', 'bnd1'],
    'bnd1': ['bnd0'],
    'bnd2': ['bnd1'],

    # 원거리 포인터
    'ptr16:16': ['0x0033:0x1000'],
    'ptr16:32': ['0x0033:0x1000'],

    # MOV 전용 moffset
    'moffset': ['[0x1000]'],

    # far pointer memory
    'm16:16': _mem('DWORD PTR'),
    'm16:32': _mem('FWORD PTR'),
    'm16:64': _mem('TBYTE PTR'),
}

KNOWN_TYPES = set(OPERAND_GROUPS.keys())


def normalize_token(token: str) -> str:
    """오타/변형 → 표준 이름으로 정규화"""
    return NORMALIZE.get(token, token)


def get_candidates(token: str) -> list[str] | None:
    """
    토큰에 대한 후보 값 목록 반환.
    알 수 없는 타입이면 None 반환 (해당 instruction form 스킵 신호).
    """
    norm = normalize_token(token)
    return OPERAND_GROUPS.get(norm)


def parse_operand_tokens(operands_str: str) -> list[str]:
    """
    'r16, r16, imm8' → ['r16', 'r16', 'imm8']
    중괄호 제거 (AVX-512 writemask 표기 등).
    """
    tokens = [t.strip().strip('{}') for t in operands_str.split(',')]
    return [t for t in tokens if t]


# ============================================================
# 3. 메인 - Stage 3 결과물 저장
# ============================================================

def main():
    base = Path(__file__).parent.parent.parent
    out_dir = base / "data" / "stage3_operands"
    out_dir.mkdir(parents=True, exist_ok=True)

    # --- 출력 1: 타입별 후보값 목록 ---
    rows = [{'OperandType': k, 'ConcreteValue': v}
            for k, vals in OPERAND_GROUPS.items() for v in vals]
    df_groups = pd.DataFrame(rows)
    df_groups.to_csv(out_dir / "step3_operand_groups.csv", index=False, encoding='utf-8-sig')
    print(f"[저장] step3_operand_groups.csv: {len(OPERAND_GROUPS)}개 타입, {len(df_groups)}개 후보값")

    # --- 출력 2: instruction form별 커버리지 리포트 ---
    stage2 = base / "data/stage2_opcode_split/step2_final_instruction_opcode_split.csv"
    df2 = pd.read_csv(stage2, encoding='utf-8-sig')

    coverage_rows = []
    for _, row in df2.iterrows():
        ops = str(row.get('Operands', ''))
        if not ops or ops == 'nan':
            mappable = True
            unknown = ''
        else:
            tokens = parse_operand_tokens(ops)
            unknown_tokens = [t for t in tokens if get_candidates(t) is None]
            mappable = len(unknown_tokens) == 0
            unknown = ', '.join(unknown_tokens)

        coverage_rows.append({
            'Instruction': row['Instruction'],
            'Mnemonic':    row['Mnemonic'],
            'Operands':    ops if ops != 'nan' else '',
            'Mappable':    mappable,
            'UnknownTypes': unknown,
        })

    df_cov = pd.DataFrame(coverage_rows)
    df_cov.to_csv(out_dir / "step3_coverage_report.csv", index=False, encoding='utf-8-sig')

    total   = len(df_cov)
    mapped  = df_cov['Mappable'].sum()
    skipped = total - mapped
    print(f"[저장] step3_coverage_report.csv: {mapped}/{total} 매핑 가능 ({mapped/total*100:.1f}%), {skipped}개 스킵")

    if skipped:
        unknown_summary = (
            df_cov[~df_cov['Mappable']]
            .groupby('UnknownTypes')
            .size()
            .sort_values(ascending=False)
        )
        print(f"\n미매핑 타입 상위 10개:")
        for types, cnt in unknown_summary.head(10).items():
            print(f"  {types:40s} : {cnt}건")


if __name__ == "__main__":
    main()

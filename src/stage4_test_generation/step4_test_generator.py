"""
Step 4-2: 어셈블리 테스트 코드 생성 (5회 미팅 수정사항 반영)

핵심 원칙:
- 매뉴얼의 instruction form 구조(오퍼랜드 개수/타입)는 그대로 유지
- 각 오퍼랜드 자리에 해당 타입의 후보값을 랜덤하게 대입
- 알 수 없는 오퍼랜드 타입이 하나라도 있으면 해당 form은 스킵

규칙 (5회 미팅):
- .intel_syntax noprefix 필수
- IMM: 최대값 사용
- Memory: BYTE/WORD/DWORD/QWORD PTR + Effective/RIP-relative 혼합
- 명령어당 약 10개 랜덤 테스트 케이스 생성
"""

import sys
import random
import pandas as pd
import re
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent.parent / "stage3_operand_grouping"))
from step3_operand_grouping import get_candidates, parse_operand_tokens

# stage1 필터를 통과한 노이즈 니모닉 2차 방어
NOISE_MNEMONICS_STAGE4 = {
    'RVMI', 'RVM', 'MVR', 'RVMR', 'RMV', 'RVR', 'ZO', 'MR', 'RM', 'OI',
    'RAX', 'RBX', 'RCX', 'RDX', 'RSI', 'RDI',
    'FISTTPINTEGER64', 'AXCXDXBXSPBPSIDI',
    'S30',  # Stage 1 파싱 garbage
}

random.seed(42)
N_PER_FORM = 10

# 스트링 명령어: 메모리 오퍼랜드가 RSI/RDI로 하드코딩됨
# {mnemonic: [operand_idx별 고정값]} — None이면 일반 후보 사용
STRING_INSTR_MEM = {
    'CMPS':  {0: 'rsi', 1: 'rdi'},  # CMPS m8, m8 → [rsi], [rdi]
    'MOVS':  {0: 'rdi', 1: 'rsi'},  # MOVS m8, m8 → [rdi], [rsi]
    'LODS':  {0: 'rsi'},             # LODS m8     → [rsi]
    'STOS':  {0: 'rdi'},             # STOS m8     → [rdi]
    'SCAS':  {0: 'rdi'},             # SCAS m8     → [rdi]
    'INS':   {0: 'rdi'},             # INS m8, DX  → [rdi]
    'OUTS':  {1: 'rsi'},             # OUTS DX, m8 → [rsi]
}

PTR_MAP = {'8': 'BYTE PTR', '16': 'WORD PTR', '32': 'DWORD PTR', '64': 'QWORD PTR'}

# REX.W 오피코드를 사용하는 명령어 중 어셈블러에서 q suffix로 써야 명확한 것들
REXW_SUFFIX_INSTRS = {'SYSRET': 'sysretq', 'SYSEXIT': 'sysexitq'}

# 64-bit 모드에서 특수 문법이 필요하거나 테스트 불가한 instruction form
SKIP_INSTR_FORMS = {
    # far jump/call
    'JMP m16:16', 'JMP m16:32', 'JMP m16:64',
    'JMP ptr16:16', 'JMP ptr16:32',
    'CALL m16:16', 'CALL m16:32', 'CALL m16:64',
    # IRET/IRETD: 64비트 모드에서 ambiguous — IRETQ 형태로만 테스트
    'IRET', 'IRETD',
    # MOVSXD: 64비트 모드에서 REX.W(r64) 형태만 사용, r16/r32 형태는 GAS 거부
    'MOVSXD r16, r16', 'MOVSXD r16, m16',
    'MOVSXD r32, r32', 'MOVSXD r32, m32',
    # SGDT/SIDT: GAS는 메모리 크기 지정 없이 [mem]만 허용 → 별도 처리
    'SGDT m', 'SIDT m',
}

# SGDT/SIDT: GAS 요구사항 — size prefix 없이 [reg] 형태만 허용
BARE_MEM_INSTRS = {'SGDT', 'SIDT', 'LGDT', 'LIDT'}


def get_string_instr_candidate(mnemonic: str, idx: int, token: str) -> list[str] | None:
    """스트링 명령어의 메모리 오퍼랜드를 RSI/RDI로 고정 반환. 해당 없으면 None."""
    mapping = STRING_INSTR_MEM.get(mnemonic.upper())
    if not mapping or idx not in mapping or not token.startswith('m'):
        return None
    reg = mapping[idx]
    size = token[1:]  # 'm8' → '8'
    ptr = PTR_MAP.get(size, 'BYTE PTR')
    return [f'{ptr} [{reg}]']


def generate_lines(mnemonic: str, operand_tokens: list[str], n: int = N_PER_FORM) -> list[str]:
    """
    매뉴얼 syntax 구조를 유지하면서 각 오퍼랜드 자리에 후보값 대입.
    - 스트링 명령어: 메모리 오퍼랜드를 RSI/RDI로 고정
    - imm32 컨텍스트: r64/m64 대상이면 sign-extend 안전값(0x7fffffff) 사용,
                      r32/m32 대상이면 unsigned max(0xffffffff) 사용
    - 알 수 없는 타입이 있으면 빈 리스트 반환 (스킵)
    """
    if not operand_tokens:
        return [mnemonic.lower()]

    mn_upper = mnemonic.upper()

    # XLAT: 메모리 오퍼랜드는 반드시 [rbx] 형태 — 임의 주소 사용 불가
    if mn_upper == 'XLAT':
        return ['xlat BYTE PTR [rbx]']

    # SGDT/SIDT/LGDT/LIDT: GAS는 size prefix 없는 [reg] 형태만 허용
    if mn_upper in BARE_MEM_INSTRS:
        return [f'{mnemonic.lower()} [rax]',
                f'{mnemonic.lower()} [rbx]',
                f'{mnemonic.lower()} [rip + 0x100]']

    # imm32 컨텍스트 판단: 64-bit 대상이면 sign-extend 양쪽 경계값 사용
    # r64/m64 타입 + 고정 64-bit 레지스터(RAX 등) 포함
    # PUSH imm32는 64비트 모드에서 항상 sign-extend → 명시적으로 포함
    _64BIT_TOKENS = {'r64', 'm64', 'RAX', 'RBX', 'RCX', 'RDX', 'RSI', 'RDI', 'RSP', 'RBP'}
    _SEXT_IMPLICIT = {'PUSH'}  # 명시적 64비트 operand 없이도 sign-extend인 명령어
    dest_is_64 = (mn_upper in _SEXT_IMPLICIT or
                  any(t in _64BIT_TOKENS for t in operand_tokens if t != 'imm32'))

    candidate_lists = []
    for idx, token in enumerate(operand_tokens):
        # 스트링 명령어 특수 처리
        string_cand = get_string_instr_candidate(mnemonic, idx, token)
        if string_cand is not None:
            candidate_lists.append(string_cand)
            continue
        # imm32 컨텍스트 처리:
        # r64/m64 대상(sign-extend) → 양수 경계(0x7fffffff)와 음수 경계(-1) 모두 테스트
        # Codex 검증 결과: GAS는 소스 리터럴의 수학적 값을 검사하므로
        #   '0xffffffff'(= +4294967295, out of signed range) 는 거부되지만
        #   '-1'(= -1, within signed range, 비트패턴 동일) 은 허용됨
        if token == 'imm32' and dest_is_64:
            candidate_lists.append(['0x7fffffff', '-1'])
            continue
        # MOV Sreg, m64: 메모리 소스는 항상 WORD PTR (16비트 세그먼트 선택자)
        if token == 'm64' and 'Sreg' in operand_tokens:
            candidate_lists.append(get_candidates('m16'))
            continue
        # 일반 후보 조회
        cand = get_candidates(token)
        candidate_lists.append(cand)

    # 알 수 없는 타입이 하나라도 있으면 스킵
    if any(c is None for c in candidate_lists):
        return []

    results, seen = [], set()
    for _ in range(n * 20):
        chosen = [random.choice(cl) for cl in candidate_lists]
        line = mnemonic.lower() + " " + ", ".join(chosen)
        if line not in seen:
            seen.add(line)
            results.append(line)
        if len(results) >= n:
            break

    return results


def build_asm_file(df: pd.DataFrame, output_path: Path, n: int = N_PER_FORM):
    lines = [
        ".intel_syntax noprefix",
        "// Auto-generated Intel assembly test",
        "// Rule: follow manual syntax exactly, randomize concrete values only",
        "",
    ]

    total_cases = 0
    skipped_forms = 0
    seen_forms: set[tuple] = set()

    for _, row in df.iterrows():
        instr     = str(row['Instruction'])
        mnemonic  = str(row['Mnemonic'])
        opcode    = str(row.get('Opcode', ''))
        operands_str = str(row.get('Operands', ''))

        if operands_str == 'nan':
            operands_str = ''

        # 노이즈 니모닉 2차 필터 (대소문자 구분 없이)
        if mnemonic.upper() in NOISE_MNEMONICS_STAGE4:
            skipped_forms += 1
            continue

        # 니모닉에 ':' 가 포함되면 PDF 파싱 노이즈 (레지스터 쌍 표기 등)
        # 예: AXDX:AXEDX:EAXRDX:RAX (IDIV 암묵적 레지스터 쌍이 합쳐진 것)
        if ':' in mnemonic:
            skipped_forms += 1
            continue

        # far jump/call 등 특수 문법 필요 form 스킵
        if instr in SKIP_INSTR_FORMS:
            skipped_forms += 1
            continue

        # SYSRET/SYSEXIT non-REX.W form 스킵 (ambiguous) — REX.W form만 sysretq로 테스트
        if mnemonic in REXW_SUFFIX_INSTRS and 'REX.W' not in opcode:
            skipped_forms += 1
            continue

        # REX.W 형태의 SYSRET/SYSEXIT → sysretq/sysexitq 로 니모닉 교체
        if mnemonic in REXW_SUFFIX_INSTRS and 'REX.W' in opcode:
            q_mnemonic = REXW_SUFFIX_INSTRS[mnemonic]
            mnemonic   = q_mnemonic.upper()
            instr      = q_mnemonic

        tokens = parse_operand_tokens(operands_str) if operands_str else []
        form_key = (mnemonic, tuple(tokens))

        if form_key in seen_forms:
            continue
        seen_forms.add(form_key)

        test_lines = generate_lines(mnemonic, tokens, n)

        if not test_lines:
            skipped_forms += 1
            continue

        lines.append(f"// === {instr} ===")
        for tl in test_lines:
            lines.append(f"    {tl}")
            total_cases += 1
        lines.append("")

    output_path.write_text("\n".join(lines), encoding="utf-8")
    return total_cases, len(seen_forms) - skipped_forms, skipped_forms


def main():
    base = Path(__file__).parent.parent.parent
    stage4_dir = base / "data" / "stage4_tests"
    stage4_dir.mkdir(parents=True, exist_ok=True)

    stage2_csv = base / "data/stage2_opcode_split/step2_final_instruction_opcode_split.csv"
    df = pd.read_csv(stage2_csv, encoding='utf-8-sig')
    print(f"[로드] Stage2 명령어: {len(df)}개")

    out_asm = stage4_dir / "test_all_instructions.s"
    total, generated, skipped = build_asm_file(df, out_asm)

    print(f"\n[완료] {out_asm}")
    print(f"  생성된 instruction form: {generated}개")
    print(f"  스킵된 form (알 수 없는 타입): {skipped}개")
    print(f"  총 테스트 케이스: {total}개")

    # 미리보기
    preview = out_asm.read_text(encoding='utf-8').split('\n')[:50]
    print("\n=== 파일 미리보기 (50줄) ===")
    for i, l in enumerate(preview, 1):
        print(f"{i:3d} | {l}")


if __name__ == "__main__":
    main()

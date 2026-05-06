"""
Stage 2: r/m 오퍼랜드 확장

Stage1에서 완전한 instruction form (예: ADC r/m16, r16) 을 받아,
r/m 표기를 r 버전과 m 버전으로 각각 분리한다.

예)
  ADC r/m16, r16  →  ADC r16, r16
                      ADC m16, r16
  SHLD r/m16, r16, imm8  →  SHLD r16, r16, imm8
                              SHLD m16, r16, imm8
"""

import pandas as pd
import re
from pathlib import Path

RM_PATTERN = re.compile(r'r/m(\w*)')


def expand_rm(instruction: str) -> list[str]:
    """
    instruction form에서 r/m 표기를 r 버전과 m 버전으로 확장한다.
    r/m이 없으면 원본 그대로 반환.
    r/m이 여러 개 있으면 첫 번째만 확장 (Intel 매뉴얼 특성상 보통 1개).
    """
    if 'r/m' not in instruction:
        return [instruction]

    r_version = RM_PATTERN.sub(lambda m: 'r' + m.group(1), instruction, count=1)
    m_version = RM_PATTERN.sub(lambda m: 'm' + m.group(1), instruction, count=1)

    if r_version == m_version:
        return [r_version]
    return [r_version, m_version]


def parse_instruction_form(instruction: str):
    """
    'ADC r16, r/m16' → mnemonic='ADC', operands='r16, r/m16'
    'NOP'            → mnemonic='NOP', operands=''
    """
    parts = instruction.strip().split(None, 1)
    mnemonic = parts[0] if parts else ''
    operands = parts[1] if len(parts) > 1 else ''
    return mnemonic, operands


def process(input_csv: str, output_csv: str):
    df = pd.read_csv(input_csv, encoding='utf-8-sig')
    print(f"[로드] {len(df)}개 instruction form")

    rows = []
    for _, row in df.iterrows():
        original = str(row['original'])
        opcode   = str(row['opcode']) if pd.notna(row['opcode']) else ''
        instr    = str(row['instruction'])

        for expanded in expand_rm(instr):
            mnemonic, operands = parse_instruction_form(expanded)
            rows.append({
                'Original':    original,
                'Opcode':      opcode,
                'Instruction': expanded,
                'Mnemonic':    mnemonic,
                'Operands':    operands,
            })

    df_out = pd.DataFrame(rows)
    df_out.to_csv(output_csv, index=False, encoding='utf-8-sig')

    print(f"[완료] {len(df_out)}개 행 저장 → {output_csv}")
    print(f"  r/m 확장으로 늘어난 행: {len(df_out) - len(df)}개")

    # 샘플 확인 - ADC
    sample = df_out[df_out['Mnemonic'] == 'ADC']
    print(f"\n=== ADC 샘플 ({len(sample)}개) ===")
    for _, r in sample.iterrows():
        print(f"  {r['Instruction']}")

    # SHLD (3-operand 케이스)
    sample2 = df_out[df_out['Mnemonic'] == 'SHLD']
    print(f"\n=== SHLD 샘플 ({len(sample2)}개) ===")
    for _, r in sample2.iterrows():
        print(f"  {r['Instruction']}")


def main():
    base = Path(__file__).parent.parent.parent
    input_csv  = base / "data/stage1_extracted/instruction_list_original.csv"
    output_csv = base / "data/stage2_opcode_split/step2_final_instruction_opcode_split.csv"
    output_csv.parent.mkdir(parents=True, exist_ok=True)
    process(str(input_csv), str(output_csv))


if __name__ == "__main__":
    main()

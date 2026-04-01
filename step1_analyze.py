import pandas as pd
import re
from collections import defaultdict

# 단계 1: 데이터 로드
print("\n" + "=" * 80)
print("단계 1: 현재 instruction_list.csv 데이터 로드 및 분석")
print("=" * 80)

df = pd.read_csv('instruction_list.csv')
instructions = df['Instruction Syntax'].tolist()

print(f"\n총 명령어 개수: {len(instructions)}")

# 패턴 카테고리화
opcode_instruction_mixed = []
combined_operands = []
simple_instructions = []

for inst in instructions:
    # Opcode와 Instruction이 섞여 있는 경우
    # (EVEX, VEX, REX 접두사가 있고, 실제 명령어(V로 시작하는 벡터명령어나 다른 니모닉)이 포함)
    if re.search(r'^(EVEX|VEX|REX)', inst):
        opcode_instruction_mixed.append(inst)
    # r/m16, m16&16 같은 combined operand가 있는 경우
    elif '/' in inst or '&' in inst:
        combined_operands.append(inst)
    else:
        simple_instructions.append(inst)

print(f"\n[발견된 패턴]")
print(f"  - Opcode와 Instruction이 섞여 있는 것: {len(opcode_instruction_mixed)}개")
print(f"  - Combined Operand (/, &, :): {len(combined_operands)}개")
print(f"  - 간단한 Instruction: {len(simple_instructions)}개")

# 샘플 표시
print("\n[Opcode-Instruction 혼합 샘플]")
for item in opcode_instruction_mixed[:5]:
    print(f"  - {item}")

print("\n[Combined Operand 샘플]")
for item in combined_operands[:5]:
    print(f"  - {item}")

print("\n[간단한 Instruction 샘플]")
for item in simple_instructions[:10]:
    print(f"  - {item}")

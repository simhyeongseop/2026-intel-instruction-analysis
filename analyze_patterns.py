import pandas as pd
import re
from collections import defaultdict

# CSV 파일 읽기
df = pd.read_csv('instruction_list.csv')
instructions = df['Instruction Syntax'].tolist()

# 패턴 분석을 위한 카테고리 설정
patterns = {
    'opcode_mixed': [],  # Opcode와 Instruction이 섞여 있는 경우 (예: EVEX.128.0F.W0 10 /r)
    'combined_operands': [],  # r/m16, m16&16 등 슬래시로 묶여 있는 오퍼랜드
    'vex_instructions': [],  # V로 시작하는 벡터 명령어들
    'simple_instructions': [],  # 간단한 니모닉만 있는 것
    'register_operands': [],  # 레지스터 오퍼랜드 (r16, r32, r64, xmm 등)
    'memory_operands': [],  # 메모리 오퍼랜드 (m16, m32, m64 등)
    'immediate_operands': [],  # 즉시값 오퍼랜드 (imm8, imm16 등)
}

# 분석 수행
for inst in instructions:
    # Opcode 패턴 (EVEX, VEX 접두사)
    if re.search(r'^(EVEX|VEX|REX)', inst):
        patterns['opcode_mixed'].append(inst)
    
    # V로 시작하는 벡터 명령어 (VMOVUPS, VFMADD 등)
    if re.search(r'V[A-Z0-9]+', inst):
        patterns['vex_instructions'].append(inst)
    
    # 슬래시로 묶여 있는 오퍼랜드 (r/m16, m16&16, ptr16:32 등)
    if '/' in inst or '&' in inst or ':' in inst:
        patterns['combined_operands'].append(inst)
    
    # 레지스터 오퍼랜드만 있는 경우
    if re.search(r'\b(r8|r16|r32|r64|xmm|ymm|zmm|al|ax|eax|rax)\b', inst, re.IGNORECASE):
        patterns['register_operands'].append(inst)
    
    # 메모리 오퍼랜드 (m8, m16, m32, m64, m128 등)
    if re.search(r'\bm(8|16|32|64|128)\b', inst):
        patterns['memory_operands'].append(inst)
    
    # 즉시값 오퍼랜드 (imm8, imm16, imm32 등)
    if re.search(r'\bimm(8|16|32|64)\b', inst):
        patterns['immediate_operands'].append(inst)
    
    # 간단한 니모닉만 있는 경우 (ADD, SUB, MOV 등)
    if re.match(r'^[A-Z][A-Z0-9]*$', inst):
        patterns['simple_instructions'].append(inst)

# 결과 출력
print("=" * 70)
print("현재 instruction_list.csv 데이터 패턴 분석 결과")
print("=" * 70)
print(f"\n[전체 명령어 개수]: {len(instructions)}\n")

for category, items in patterns.items():
    print(f"\n{'─' * 70}")
    print(f"[{category.upper()}] - {len(items)}개")
    print(f"{'─' * 70}")
    if items:
        # 처음 10개만 표시
        for i, item in enumerate(items[:10], 1):
            print(f"  {i:3}. {item}")
        if len(items) > 10:
            print(f"  ... ({len(items) - 10}개 더 있음)")
    else:
        print("  (없음)")

# 오퍼랜드 분석 (현재 포함된 오퍼랜드 타입 추출)
print("\n\n" + "=" * 70)
print("오퍼랜드 타입 분석")
print("=" * 70)

operand_types = defaultdict(int)

for inst in instructions:
    # 레지스터
    if re.search(r'\br(8|16|32|64)\b', inst):
        operand_types['r16'] += inst.count('r16')
        operand_types['r32'] += inst.count('r32')
        operand_types['r64'] += inst.count('r64')
        operand_types['r8'] += inst.count('r8')
    
    # 메모리
    for size in ['8', '16', '32', '64', '128']:
        operand_types[f'm{size}'] += inst.count(f'm{size}')
    
    # 즉시값
    for size in ['8', '16', '32']:
        operand_types[f'imm{size}'] += inst.count(f'imm{size}')
    
    # XMM, YMM, ZMM
    operand_types['xmm'] += len(re.findall(r'\bxmm\b', inst, re.IGNORECASE))
    operand_types['ymm'] += len(re.findall(r'\bymm\b', inst, re.IGNORECASE))
    operand_types['zmm'] += len(re.findall(r'\bzmm\b', inst, re.IGNORECASE))
    
    # 특수 레지스터
    operand_types['AL'] += inst.count('AL')
    operand_types['AX'] += inst.count('AX')
    operand_types['EAX'] += inst.count('EAX')
    operand_types['RAX'] += inst.count('RAX')

print("\n[발견된 오퍼랜드 타입]\n")
sorted_operands = sorted(operand_types.items(), key=lambda x: x[1], reverse=True)
for operand, count in sorted_operands:
    if count > 0:
        print(f"  {operand:15} : {count:4}회")

import pandas as pd
import re
from pathlib import Path

def extract_mnemonic(instruction):
    """
    명령어에서 Mnemonic 추출
    예: "ADC r16" → "ADC"
    """
    if not instruction or pd.isna(instruction):
        return ""
    parts = str(instruction).split()
    return parts[0] if parts else ""

def has_vector_register(instruction):
    """
    벡터 레지스터 사용 여부 (xmm, ymm, zmm)
    """
    if not instruction or pd.isna(instruction):
        return 0
    instr_str = str(instruction).lower()
    return 1 if re.search(r'(xmm|ymm|zmm)\d+', instr_str) else 0

def has_memory_operand(instruction):
    """
    메모리 접근 여부 (m8, m16, m32, m64, m128, m256, m512, ptr, dword, qword, byte, word)
    """
    if not instruction or pd.isna(instruction):
        return 0
    instr_str = str(instruction).lower()
    # 메모리 지정자 또는 메모리 크기 지정 패턴
    return 1 if re.search(r'(m\d+|ptr|byte|word|dword|qword|xmmword|ymmword|zmmword)', instr_str) else 0

def has_immediate(instruction):
    """
    즉시값(상수) 사용 여부 (imm8, imm16, imm32, imm64)
    """
    if not instruction or pd.isna(instruction):
        return 0
    instr_str = str(instruction).lower()
    return 1 if re.search(r'imm\d+', instr_str) else 0

def has_masking(instruction):
    """
    마스킹 지원 여부 (k1-k7, {z}, {k})
    """
    if not instruction or pd.isna(instruction):
        return 0
    instr_str = str(instruction).lower()
    return 1 if re.search(r'(k[1-7]|{z}|{k})', instr_str) else 0

def extract_register_width(instruction):
    """
    주요 레지스터의 비트 폭 추출 (8, 16, 32, 64)
    """
    if not instruction or pd.isna(instruction):
        return 0
    instr_str = str(instruction).lower()
    
    # 64비트
    if re.search(r'(rax|rbx|rcx|rdx|r\d{2}|r64)', instr_str):
        return 64
    # 32비트
    elif re.search(r'(eax|ebx|ecx|edx|r\d{2}d|r32|imm32)', instr_str):
        return 32
    # 16비트
    elif re.search(r'(ax|bx|cx|dx|r16|m16|imm16)', instr_str):
        return 16
    # 8비트
    elif re.search(r'(al|bl|cl|dl|ah|bh|ch|dh|r8|m8|imm8)', instr_str):
        return 8
    
    return 0

def extract_memory_width(instruction):
    """
    메모리 접근 폭 추출 (8, 16, 32, 64, 128, 256, 512)
    """
    if not instruction or pd.isna(instruction):
        return 0
    instr_str = str(instruction).lower()
    
    # 512비트
    if re.search(r'(m512|zmmword)', instr_str):
        return 512
    # 256비트
    elif re.search(r'(m256|ymmword)', instr_str):
        return 256
    # 128비트
    elif re.search(r'(m128|xmmword)', instr_str):
        return 128
    # 64비트
    elif re.search(r'(m64|qword)', instr_str):
        return 64
    # 32비트
    elif re.search(r'(m32|dword)', instr_str):
        return 32
    # 16비트
    elif re.search(r'(m16|word)', instr_str):
        return 16
    # 8비트
    elif re.search(r'(m8|byte)', instr_str):
        return 8
    
    return 0

def extract_prefix_type(opcode):
    """
    접두사 종류 추출 (NONE, REX, VEX, EVEX)
    """
    if not opcode or pd.isna(opcode):
        return "NONE"
    opcode_str = str(opcode).upper()
    
    if 'EVEX' in opcode_str:
        return "EVEX"
    elif 'VEX' in opcode_str:
        return "VEX"
    elif 'REX' in opcode_str:
        return "REX"
    else:
        return "NONE"

def count_operands(instruction):
    """
    오퍼랜드 개수 세기 (쉼표로 구분)
    """
    if not instruction or pd.isna(instruction):
        return 0
    
    # 첫 단어(Mnemonic)를 제거하고 나머지를 쉼표로 분리
    parts = str(instruction).split(None, 1)
    if len(parts) < 2:
        return 0
    
    operands_str = parts[1]
    # 쉼표가 있으면 쉼표로 분리, 없으면 공백으로 분리된 각 항목을 카운트
    if ',' in operands_str:
        return len([op.strip() for op in operands_str.split(',') if op.strip()])
    else:
        # 공백 분리 (간단한 방법)
        return len([op.strip() for op in operands_str.split() if op.strip()])

def main():
    """
    메인 함수: 특징 매트릭스 생성
    """
    # 입력 파일 읽기
    input_file = "data/stage2_opcode_split/step2_final_instruction_opcode_split.csv"
    
    print("단계 1: 데이터 로드 중...")
    
    # 다양한 인코딩 시도
    encodings = ['utf-16', 'utf-8-sig', 'utf-8', 'latin-1', 'cp1252']
    df = None
    for encoding in encodings:
        try:
            df = pd.read_csv(input_file, encoding=encoding)
            print(f"인코딩 '{encoding}'으로 성공적으로 로드됨")
            break
        except Exception as e:
            print(f"인코딩 '{encoding}' 실패: {str(e)[:50]}")
            continue
    
    if df is None:
        print("모든 인코딩 시도 실패")
        return
    
    print(f"로드된 행 수: {len(df)}")
    print(f"컬럼: {df.columns.tolist()}\n")
    
    # 컬럼 이름 정규화 (대소문자 통일)
    df.columns = df.columns.str.lower()
    
    # 특징 추출
    print("단계 2: 특징 추출 중...")
    
    df['mnemonic'] = df['instruction'].apply(extract_mnemonic)
    df['has_vector_reg'] = df['instruction'].apply(has_vector_register)
    df['has_memory'] = df['instruction'].apply(has_memory_operand)
    df['has_immediate'] = df['instruction'].apply(has_immediate)
    df['has_masking'] = df['instruction'].apply(has_masking)
    df['register_width'] = df['instruction'].apply(extract_register_width)
    df['memory_width'] = df['instruction'].apply(extract_memory_width)
    df['prefix_type'] = df['opcode'].apply(extract_prefix_type)
    df['operand_count'] = df['instruction'].apply(count_operands)
    
    # 열 순서 정리
    output_columns = [
        'instruction',      # 기본 키
        'original',         # 원본
        'opcode',          # 기계어 코드
        'mnemonic',        # 명령어 이름
        'operand_count',   # 오퍼랜드 개수
        'has_vector_reg',  # 벡터 레지스터 여부
        'has_memory',      # 메모리 접근 여부
        'has_immediate',   # 즉시값 여부
        'has_masking',     # 마스킹 여부
        'register_width',  # 레지스터 폭
        'memory_width',    # 메모리 폭
        'prefix_type',     # 접두사 종류
    ]
    
    df_output = df[output_columns]
    
    # 통계 계산
    print("\n단계 3: 특징별 통계\n")
    
    print(f"총 명령어: {len(df_output)}")
    print(f"\n벡터 레지스터 사용: {df_output['has_vector_reg'].sum()}")
    print(f"메모리 접근: {df_output['has_memory'].sum()}")
    print(f"즉시값 사용: {df_output['has_immediate'].sum()}")
    print(f"마스킹 지원: {df_output['has_masking'].sum()}")
    
    print(f"\n접두사 분포:")
    print(df_output['prefix_type'].value_counts())
    
    print(f"\nMnemonic 분포 (상위 10개):")
    print(df_output['mnemonic'].value_counts().head(10))
    
    print(f"\n오퍼랜드 개수 분포:")
    print(df_output['operand_count'].value_counts().sort_index())
    
    # 출력 파일 저장
    output_file = "data/stage3_operands/step4_instruction_features.csv"
    print(f"\n단계 4: 파일 저장 중...")
    df_output.to_csv(output_file, index=False, encoding='utf-8-sig')
    
    print(f"\n✅ 완료!")
    print(f"출력 파일: {output_file}")
    print(f"총 {len(df_output)} 행 저장됨")
    
    # 샘플 출력
    print(f"\n샘플 데이터 (처음 5개):")
    print(df_output.head().to_string())

if __name__ == "__main__":
    main()

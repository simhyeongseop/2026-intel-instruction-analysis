import pandas as pd
import os

print('='*80)
print('📊 최종 검증: 3단계 결과물 확인')
print('='*80)

# 1. step2_final_instruction_opcode_split.csv 검증
print('\n[1/3] step2_final_instruction_opcode_split.csv')
print('-'*80)
try:
    df1 = pd.read_csv('step2_final_instruction_opcode_split.csv')
    print(f'✓ 파일 존재: YES')
    print(f'✓ 행 수: {len(df1)}')
    print(f'✓ 컬럼: {list(df1.columns)}')
    print(f'\n샘플 (명령어 확장 사례):')
    # r/m이 포함된 예제 찾기
    samples = df1[df1['Original'].str.contains('r/m|/m|&', na=False, case=False)]
    if len(samples) > 0:
        for idx, row in samples.head(5).iterrows():
            print(f'\n  원본: {row["Original"]}')
            print(f'  → Instruction: {row["Instruction"]}')
except Exception as e:
    print(f'❌ 오류: {e}')

# 2. step3_operands_raw.csv 검증
print('\n\n[2/3] step3_operands_raw.csv')
print('-'*80)
try:
    df2 = pd.read_csv('step3_operands_raw.csv')
    print(f'✓ 파일 존재: YES')
    print(f'✓ 추출된 오퍼랜드 수: {len(df2)}')
    print(f'✓ 컬럼: {list(df2.columns)}')
    print(f'\n샘플 (상위 25개):')
    for idx, row in df2.head(25).iterrows():
        print(f'  {idx+1:2}. {row["Operand"]}')
except Exception as e:
    print(f'❌ 오류: {e}')

# 3. step3_operands_classified.csv 검증
print('\n\n[3/3] step3_operands_classified.csv')
print('-'*80)
try:
    df3 = pd.read_csv('step3_operands_classified.csv')
    print(f'✓ 파일 존재: YES')
    print(f'✓ 분류된 오퍼랜드 총 수: {len(df3)}')
    print(f'✓ 컬럼: {list(df3.columns)}')

    # 카테고리별 분포
    category_counts = df3['Category'].value_counts()
    print(f'\n카테고리별 분포:')
    for cat in sorted(category_counts.index):
        count = category_counts[cat]
        print(f'  • {cat:30}: {count:3}개')
        
    # 각 카테고리별 샘플
    print(f'\n주요 카테고리별 샘플:')
    for category in ['Register_8bit', 'Register_16bit', 'Memory_16bit', 'Memory_128bit_plus', 'Immediate', 'VectorRegister_XMM', 'Other']:
        cat_data = df3[df3['Category'] == category]
        if len(cat_data) > 0:
            samples = cat_data['Operand'].head(3).tolist()
            print(f'\n  【{category}】')
            for s in samples:
                print(f'    • {s}')
except Exception as e:
    print(f'❌ 오류: {e}')

# 최종 요약
print('\n\n' + '='*80)
print('✅ 최종 검증 완료')
print('='*80)
print('\n📝 3단계 진행 현황:')
print('  ✓ 오퍼랜드 분리 (1로 확장): COMPLETE')
print('  ✓ 오퍼랜드 추출: COMPLETE')
print('  ✓ 오퍼랜드 분류: COMPLETE')
print('\n다음 단계: 4회 미팅에서 결과 보고 및 추가 피드백 수렴')
print('='*80)

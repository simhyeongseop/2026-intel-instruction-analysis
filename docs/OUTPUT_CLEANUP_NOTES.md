# 산출물 정리 기준

작성일: 2026-05-29

## 보존할 파일

연구 과정과 중간 보고에 직접 필요한 파일이다.

```text
src/stage3_operand_grouping/step3_operand_grouping.py
src/stage5_disassembly_validation/step5_disassemble_compare.py

data/stage3_operands/step3_operand_groups.csv
data/stage4_tests/test_all_instructions.s

docs/INTERIM_REPORT_2026-05-29.md
docs/stage5_equivalence_classification_rules.md
docs/stage5_disassembly_validation.md
experiments/run_operand_micro_tests.sh
```

## 삭제한 중간 덤프

아래 파일들은 스크립트 실행으로 언제든 다시 만들 수 있으므로 삭제했다.

```text
experiments/out_operand_micro_tests/

data/stage5_disassembly/step5_disasm_compare.csv
data/stage5_disassembly/step5_disasm_report.md
data/stage5_disassembly/step5_objdump_intel.txt
data/stage5_disassembly/test_all_stage5.o
```

삭제 이유:

- `experiments/out_operand_micro_tests/`는 micro test 실행 중 생성되는 `.s`, `.o`, `.log` 모음이다.
- `data/stage5_disassembly/*`는 `m -> QWORD PTR` 수정 전 결과라 현재 source와 맞지 않는다.
- Stage 5는 Ubuntu/WSL에서 다시 실행해 최신 결과로 재생성해야 한다.

## 재생성 방법

Micro experiment:

```bash
bash experiments/run_operand_micro_tests.sh
```

Stage 5 full comparison:

```bash
python src/stage5_disassembly_validation/step5_disassemble_compare.py
```

## git ignore 반영

다음 중간 산출물은 git에 포함하지 않는다.

```text
experiments/out_operand_micro_tests/
data/stage5_disassembly/*.o
data/stage5_disassembly/*objdump*.txt
```

Stage 5의 CSV/MD report는 재생성 후 검토하여 필요하면 commit 대상으로 삼는다.

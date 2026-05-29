# Intel Instruction Analysis

Intel SDM(Software Developer's Manual) Volume 2에서 instruction form을 추출하고, 이를 실제 Intel-syntax assembly test case로 변환한 뒤 assembler/disassembler 동작을 검증하는 연구 프로젝트입니다.

## 현재 목표

현재 프로젝트의 핵심 질문은 다음과 같습니다.

```text
Intel manual의 instruction form을 실제 assembly로 만들었을 때,
GNU as / GCC / Clang / objdump가 이를 어떻게 해석하는가?
```

일반 프로그램을 실행하는 프로젝트가 아니라, instruction 단위의 assembler/disassembler 처리 차이를 분석하는 프로젝트입니다.

## 파이프라인

```text
Intel SDM PDF
  -> Stage 1: instruction form 추출
  -> Stage 2: opcode / mnemonic / operand form 분리
  -> Stage 3: operand form별 concrete operand 후보 정의
  -> Stage 4: assembly test case 생성
  -> Stage 4 check: GNU as / GCC / Clang accept 여부 확인
  -> Stage 5: objdump 결과와 source assembly 비교
  -> mismatch category 분류
```

## 주요 디렉터리

```text
src/
  stage1_extraction/              PDF에서 instruction form 추출
  stage2_opcode_separation/       opcode / instruction form 분리
  stage3_operand_grouping/        operand 후보 정의
  stage4_test_generation/         assembly 생성 및 compile error triage
  stage5_disassembly_validation/  objdump 기반 source/disassembly 비교

data/
  stage1_extracted/               Stage 1 산출물
  stage2_opcode_split/            Stage 2 산출물
  stage3_operands/                operand 후보 및 coverage report
  stage4_tests/                   생성된 assembly와 compile/triage 결과
  stage5_disassembly/             Stage 5 재생성 대상 산출물

docs/
  INTERIM_REPORT_2026-05-29.md
  stage5_equivalence_classification_rules.md
  stage5_disassembly_validation.md
  MEETING_NOTES/

experiments/
  run_operand_micro_tests.sh      7회 미팅 피드백 재현용 소규모 실험
```

## 현재 반영된 핵심 수정

7회 미팅 피드백 이후, generic memory operand `m`을 무조건 `m64`로 해석하던 문제를 수정했습니다.

기존:

```text
m -> m64 -> QWORD PTR [rax]
```

수정 후:

```text
m -> [rax]
```

따라서 `INVLPG m`, `LEA r16/r32/r64,m` 계열은 다음처럼 생성됩니다.

```asm
invlpg [rax]
lea rax, [rbx]
```

## Stage 5 분류 방향

`source assembly`와 `objdump` 결과가 다르다고 바로 오류로 보지 않습니다. 다음과 같이 분류합니다.

| Category | 의미 |
|---|---|
| `exact_match` | 정규화 후 source와 objdump가 동일 |
| `alias` | 의미가 같은 다른 표기 |
| `generic_memory_size_inferred` | generic `m`에 대해 objdump가 PTR size를 출력 |
| `effective_address_size_directive_changed` | `LEA`에서 PTR size가 생략 또는 무시됨 |
| `moffset_size_inferred` | register 크기에서 memory size가 추론됨 |
| `far_pointer_size_repr_changed` | `TBYTE PTR`/`FWORD PTR` 등 far pointer 표기 차이 |
| `register_width_changed` | register width가 다르게 출력되어 확인 필요 |
| `bug_candidate` | encoding 또는 동작 의미가 달라졌을 가능성 |

자세한 기준은 `docs/stage5_equivalence_classification_rules.md`를 참고합니다.

## 실행 예시

Stage 4 test case 생성:

```bash
python src/stage4_test_generation/step4_test_generator.py
```

Stage 4 compile/error 분석:

```bash
python src/stage4_test_generation/step4_compile_and_analyze.py
python src/stage4_test_generation/step4_error_triage.py
```

Stage 5 disassembly 비교:

```bash
python src/stage5_disassembly_validation/step5_disassemble_compare.py
```

7회 미팅 피드백 재현용 소규모 실험:

```bash
bash experiments/run_operand_micro_tests.sh
```

## 현재 주의 사항

- `data/stage5_disassembly/`의 비교 결과는 Stage 4 assembly를 수정한 뒤 다시 생성해야 합니다.
- Ubuntu/WSL에서 `as`, `gcc`, `clang`, `objdump`가 설치되어 있어야 전체 검증이 가능합니다.
- `experiments/out_operand_micro_tests/`는 실험 실행 시 생기는 중간 출력이며 git에 포함하지 않습니다.

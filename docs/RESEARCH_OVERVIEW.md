# 연구 개요

## 연구 목적

Intel SDM Volume 2의 instruction form을 기반으로 assembly test case를 자동 생성하고, 실제 assembler/disassembler가 이를 어떻게 처리하는지 분석한다.

현재 관심사는 다음 두 가지다.

1. Manual operand form을 concrete assembly operand로 올바르게 매핑하는가?
2. Assembly source와 objdump 결과가 다를 때, 실제 encoding/동작 의미가 같은지 분류할 수 있는가?

## 전체 흐름

| Stage | 내용 | 주요 산출물 |
|---|---|---|
| Stage 1 | Intel SDM PDF에서 instruction form 추출 | `data/stage1_extracted/instruction_list_original.csv` |
| Stage 2 | opcode / mnemonic / operand form 분리 | `data/stage2_opcode_split/step2_final_instruction_opcode_split.csv` |
| Stage 3 | operand type별 concrete candidate 정의 | `data/stage3_operands/step3_operand_groups.csv` |
| Stage 4 | assembly test file 생성 | `data/stage4_tests/test_all_instructions.s` |
| Stage 4 check | GNU as / GCC / Clang accept 여부 확인 | `data/stage4_tests/step4_*` |
| Stage 5 | objdump 결과와 source assembly 비교 | `data/stage5_disassembly/step5_*` |

## 7회 미팅 이후 수정 사항

### Generic memory operand `m`

기존에는 `m`을 `m64`로 정규화했다.

```text
m -> m64 -> QWORD PTR [rax]
```

하지만 `m`은 generic memory operand이며, 항상 64-bit memory operand를 의미하지 않는다. 이로 인해 다음과 같은 부정확한 test case가 생성되었다.

```asm
invlpg QWORD PTR [rax]
lea rax, QWORD PTR [rbx]
```

수정 후에는 `m`을 bare memory operand로 생성한다.

```asm
invlpg [rax]
lea rax, [rbx]
```

관련 파일:

- `src/stage3_operand_grouping/step3_operand_grouping.py`
- `data/stage3_operands/step3_operand_groups.csv`
- `data/stage4_tests/test_all_instructions.s`

### Stage 5 분류 기준 보강

objdump는 원래 source text를 복원하는 도구가 아니라 machine code bytes를 다시 assembly 형태로 출력하는 도구다. 따라서 source와 objdump 결과가 다르더라도 곧바로 오류로 판단하지 않는다.

추가한 주요 분류:

| Category | 설명 |
|---|---|
| `generic_memory_size_inferred` | generic `m`에 대해 objdump가 PTR size를 출력 |
| `effective_address_size_directive_changed` | `LEA`에서 PTR size text가 사라짐 |
| `moffset_size_inferred` | register operand 크기에서 memory size가 추론됨 |
| `far_pointer_size_repr_changed` | `m16:64` 등 far pointer memory 표기 차이 |

자세한 내용은 `docs/stage5_equivalence_classification_rules.md`에 정리했다.

## 소규모 재현 실험

7회 미팅 피드백을 재현하기 위해 다음 스크립트를 추가했다.

```bash
bash experiments/run_operand_micro_tests.sh
```

실험 대상:

- `invlpg [rax]`
- `invlpg QWORD PTR [rax]`
- `lea rax, [rbx]`
- `lea rax, QWORD PTR [rbx]`
- `lss/lfs/lgs rax, TBYTE PTR [rax]`
- `lldt ax`, `lldt eax`
- `sal eax, 1`

대표 결과:

| Case | 결과 | 해석 |
|---|---|---|
| `invlpg [rax]` | as/gcc/clang 모두 성공 | generic `m`은 bare memory가 적절 |
| `invlpg QWORD PTR [rax]` | clang 실패 | `QWORD PTR`를 임의로 붙이면 assembler별 차이 발생 |
| `lea rax, QWORD PTR [rbx]` | encoding은 bare memory와 동일 | PTR size text는 semantic하지 않음 |
| `lss rax, TBYTE PTR [rax]` | objdump는 `FWORD PTR` 출력 | far pointer 표기 차이로 별도 분류 |
| `lldt ax` | objdump는 `lldt eax` 출력 | register width 출력 차이 확인 필요 |

## 현재 정리 상태

- Stage 3/4의 `m -> QWORD PTR` 단순 매핑 문제는 수정했다.
- Stage 5 기존 산출물은 수정 전 결과라 삭제했다. Ubuntu/WSL 환경에서 다시 생성해야 한다.
- `experiments/out_operand_micro_tests/`는 재생성 가능한 중간 덤프이므로 보존 대상이 아니다.

## 남은 작업

1. Stage 5 결과를 수정 후 assembly 기준으로 재생성한다.
2. `m16:64`, `TBYTE PTR`, `FWORD PTR` 관계를 Intel manual과 assembler별 결과로 정리한다.
3. `register_width_changed` 케이스를 instruction별로 묶고 opcode bytes 기준으로 확인한다.
4. `r/m16`, `r/m32`처럼 register/memory 양쪽이 가능한 operand의 coverage를 확장한다.

# 중간 보고: Stage 4 매핑 보정과 동등 동작 분류 준비

작성일: 2026-05-29

## 보고 범위

이번 중간 보고의 범위는 두 가지로 제한한다.

1. Intel manual의 operand form을 실제 assembly test case로 바꾸는 매핑 오류를 먼저 수정한다.
2. source assembly와 objdump disassembly가 다르게 보이더라도 machine code 해석상 같은 동작인 케이스를 분류할 기준 파일을 만든다.

실제 전체 objdump 수행과 대량 mismatch 분석은 다음 단계에서 진행한다.

## 1. 매핑 오류 수정 방향

가장 큰 문제는 manual의 operand token을 너무 단순하게 concrete assembly operand로 바꾼 것이다. 특히 `m`을 무조건 `m64`처럼 취급하면 `INVLPG m`, `LEA r64,m`처럼 memory 크기가 semantic하지 않은 instruction에도 `QWORD PTR`가 붙어서 잘못된 test case가 생성된다.

이번에 반영한 보정은 다음과 같다.

| 구분 | 기존 문제 | 수정 방향 |
|---|---|---|
| generic `m` | `m -> m64 -> QWORD PTR [rax]`처럼 과도하게 해석 | bare memory `[rax]` 계열로 생성 |
| composite `r/m` | `r16/m16`, `r32/m16`, `r64/m16`을 memory만 테스트 | register 후보와 memory 후보를 모두 생성 |
| FPU env memory | `m14/28byte`, `m94/108byte`, `m80bcd` 등이 unknown 처리 | 각 operand form에 맞는 후보 추가 |
| descriptor table memory | `m16&64`가 unknown 처리 | `LGDT/LIDT` 계열에 bare memory 후보 적용 |
| control/debug register | `CR0-CR7`, `CR8`, `DR0-DR7` 후보 부재 | `cr0`, `cr3`, `cr8`, `dr0` 등 후보 추가 |
| REP string form | `REP MOVS m8,m8`처럼 prefix가 mnemonic/operand로 분리되어 누락 | `rep movsb`, `repe cmpsb` 같은 실제 assembly alias로 생성 |
| relative target | `jz .`가 Clang에서 깨질 수 있음 | `0f` numeric local label 형태로 생성 |

관련 코드:

- `src/stage3_operand_grouping/step3_operand_grouping.py`
- `src/stage4_test_generation/step4_test_generator.py`
- `src/stage5_disassembly_validation/step5_disassemble_compare.py`

## 2. Stage 4 재수행 방법

Ubuntu/WSL에서 아래 명령으로 Stage 3/4 산출물을 다시 만든다.

```bash
bash scripts/run_stage4_mapping_pass.sh
```

이 스크립트는 다음 순서로 실행된다.

```text
Stage 3 operand grouping
-> Stage 4 assembly testcase generation
-> GNU as / GCC / Clang compile check
-> Stage 4 error triage
```

생성 또는 갱신되는 주요 파일:

- `data/stage3_operands/step3_operand_groups.csv`
- `data/stage3_operands/step3_coverage_report.csv`
- `data/stage4_tests/test_all_instructions.s`
- `data/stage4_tests/step4_error_lines.csv`
- `data/stage4_tests/step4_error_triage.csv`
- `data/stage4_tests/step4_triage_report.md`

실제 재수행 결과:

| 항목 | 결과 |
|---|---:|
| Stage 3 coverage | 1480/1480 mappable, 100.0% |
| Stage 3 operand types | 76 types |
| Stage 3 concrete candidates | 286 candidates |
| Stage 4 generated instruction forms | 1395 forms |
| Stage 4 skipped forms | 17 forms |
| Stage 4 generated test cases | 8817 cases |
| Stage 4 parsed error/warning rows | 28 rows |

Stage 4 잔여 error/warning triage:

| Category | Count | 해석 |
|---|---:|---|
| `unknown_instruction` | 15 | Clang이 `ERETS`, `ERETU`, `INT1`, `LKGS` 등 일부 mnemonic을 지원하지 않는 케이스 |
| `register_type_mismatch` | 12 | GNU as/GCC가 `LSL r64, r32/m16`의 register-source 조합을 거절하는 케이스 |
| `size_only_memory_warning` | 1 | `XLAT BYTE PTR [rbx]`에서 memory operand가 크기 판정용이라는 Clang warning |

즉, 기존의 `m -> QWORD PTR`식 단순 매핑 오류는 보정되었고, 남은 항목은 assembler별 지원 차이 또는 특정 instruction form의 추가 확인 대상으로 분리했다.

## 3. 동등 동작 분류 기준

source assembly와 objdump 결과가 문자 그대로 다르더라도, 바로 오류로 보지 않고 아래처럼 분류한다.

| Category | 판단 |
|---|---|
| `alias` | `sal`과 `shl`처럼 같은 의미의 다른 표기 |
| `generic_memory_size_inferred` | generic `m`에 대해 objdump가 PTR size를 추론해서 출력 |
| `effective_address_size_directive_changed` | `LEA`에서 PTR size가 사라지는 표현 차이 |
| `moffset_size_inferred` | `mov al,[0x1000]`처럼 register 크기로 memory size가 추론됨 |
| `far_pointer_size_repr_changed` | `m16:64` 계열에서 `TBYTE PTR`/`FWORD PTR` 표기가 달라짐 |
| `register_width_changed` | `lldt ax`와 `lldt eax`처럼 width 표현이 달라져 추가 확인 필요 |
| `bug_candidate` | opcode bytes 기준으로 실제 encoding 의미가 달라졌을 가능성 |

분류 seed 파일:

- `data/stage5_disassembly/equivalence_categories_seed.csv`

상세 설명:

- `docs/stage5_equivalence_classification_rules.md`

## 교수님께 보고할 핵심 문장

이번 주에는 objdump mismatch를 바로 오류로 주장하기 전에, test case 생성 단계의 operand 매핑 오류를 먼저 보정했습니다. 특히 generic memory `m`, composite `r/m`, REP string instruction, control/debug register, 특수 memory operand를 Stage 4 생성기에 반영했습니다. 또한 source와 disassembly가 다르게 출력되어도 machine code 기준으로 같은 동작인 케이스를 분류할 category seed 파일을 만들었고, 다음 단계에서 objdump를 돌려 실제 mismatch를 이 기준으로 분류할 예정입니다.

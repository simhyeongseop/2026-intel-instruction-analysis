# 중간 보고: 7회 미팅 피드백 반영 현황

작성일: 2026-05-29

## 1. 이번 주 확인한 핵심 문제

지난 회의에서 확인한 가장 큰 문제는 Intel manual의 operand form을 실제 assembly test case로 바꾸는 과정이 너무 단순했다는 점이다.

예를 들어 manual의 `m`은 generic memory operand를 의미하지만, 기존 테스트 생성 과정에서는 이를 `m64`로 정규화하여 `QWORD PTR [rax]` 형태로 생성했다.

기존 생성 예:

```asm
invlpg QWORD PTR [rax]
lea rax, QWORD PTR [rbx]
```

수정 후 생성 예:

```asm
invlpg [rax]
lea rax, [rbx]
```

이 수정은 `INVLPG m`, `LEA r16/r32/r64,m`처럼 memory operand의 크기를 명시하지 않는 instruction form에 대해 manual 의미에 더 맞는 테스트 케이스를 만들기 위한 것이다.

## 2. 수정 반영 사항

### 2.1 Generic memory operand `m` 처리 수정

기존:

```text
m -> m64 -> QWORD PTR [rax]
```

수정:

```text
m -> [rax]
```

관련 수정 파일:

- `src/stage3_operand_grouping/step3_operand_grouping.py`
- `data/stage3_operands/step3_operand_groups.csv`
- `data/stage4_tests/test_all_instructions.s`

## 3. 작은 실험 결과

`experiments/run_operand_micro_tests.sh`를 작성하여 Ubuntu 환경에서 GNU as, GCC, Clang을 대상으로 소규모 재현 실험을 수행했다.

### 3.1 `INVLPG m`

```asm
invlpg [rax]
```

결과:

- GNU as: 성공
- GCC: 성공
- Clang: 성공
- objdump: `invlpg BYTE PTR [rax]`

```asm
invlpg QWORD PTR [rax]
```

결과:

- GNU as: 성공
- GCC: 성공
- Clang: 실패
- objdump: `invlpg BYTE PTR [rax]`

해석:

`QWORD PTR`를 붙인 것은 manual의 generic `m` 의미와 맞지 않으며, assembler마다 허용 여부도 달라진다. 따라서 `INVLPG m`은 bare memory operand로 생성하는 것이 타당하다.

### 3.2 `LEA r64,m`

```asm
lea rax, [rbx]
lea rax, QWORD PTR [rbx]
```

결과:

- 두 경우 모두 같은 encoding: `48 8d 03`
- objdump: `lea rax,[rbx]`

해석:

`LEA`는 memory 값을 읽는 instruction이 아니라 effective address를 계산하는 instruction이다. 따라서 `QWORD PTR`는 semantic한 정보가 아니며, 테스트 생성 시 생략하는 것이 더 적절하다.

### 3.3 `LSS/LFS/LGS r64,m16:64`

```asm
lss rax, TBYTE PTR [rax]
```

결과:

- GNU as: 성공
- GCC: 성공
- Clang: 성공
- objdump: `lss rax,FWORD PTR [rax]`

해석:

`m16:64`는 단순 memory size 문제라기보다 far pointer memory operand의 source syntax와 objdump 출력 표기 차이로 보인다. 따라서 현재는 즉시 오류로 판단하지 않고 별도 분류 대상으로 둔다.

## 4. 역어셈블 결과 비교 분류 방향

`source assembly`와 `objdump disassembly`가 다르더라도 곧바로 오류로 보지 않는다. machine code encoding과 instruction 의미가 같은지 확인한 뒤 다음과 같이 분류한다.

| 분류 | 의미 | 예시 |
|---|---|---|
| `exact_match` | source와 objdump가 정규화 후 동일 | `add eax,ebx` |
| `alias` | 같은 의미의 다른 명령어 이름 | `sal` -> `shl` |
| `generic_memory_size_inferred` | generic `m`에 대해 objdump가 PTR size를 출력 | `invlpg [rax]` -> `invlpg BYTE PTR [rax]` |
| `effective_address_size_directive_changed` | `LEA`에서 PTR size가 생략됨 | `lea rax,QWORD PTR [rbx]` -> `lea rax,[rbx]` |
| `moffset_size_inferred` | register 크기에서 memory size가 추론됨 | `mov al,[0x1000]` -> `mov al,BYTE PTR ds:0x1000` |
| `far_pointer_size_repr_changed` | far pointer memory operand의 표기 차이 | `TBYTE PTR` -> `FWORD PTR` |
| `register_width_changed` | register width가 다르게 출력되어 확인 필요 | `lldt ax` -> `lldt eax` |
| `bug_candidate` | encoding 또는 동작 의미가 실제로 달라졌을 가능성 | 추가 검증 필요 |

## 5. 중간 결론

현재까지는 `source assembly`와 `objdump` 결과가 다른 케이스 중 상당수가 실제 오류라기보다 다음 원인으로 설명될 수 있음을 확인했다.

- 테스트 케이스 생성 시 operand 매핑이 부정확했던 경우
- assembler/disassembler의 표현 차이
- alias 관계
- size directive 생략 또는 추론
- far pointer memory operand의 표기 차이

따라서 중간 보고에서는 모든 mismatch를 오류로 주장하기보다, 우선 대표적인 operand 매핑 문제를 수정했고, 남은 mismatch는 machine code 기준으로 분류하는 방향으로 정리하고 있다고 보고한다.

## 6. 다음 작업

1. `m16:64`, `TBYTE PTR`, `FWORD PTR` 관계를 Intel manual과 assembler별 결과 기준으로 추가 정리한다.
2. `register_width_changed` 케이스를 instruction별로 묶어 opcode bytes 기준으로 확인한다.
3. Stage 5 보고서의 분류 결과를 재생성하여 교수님께 보여줄 수 있는 표 형태로 정리한다.
4. `r/m16`, `r/m32`처럼 register 또는 memory가 모두 가능한 operand는 양쪽 후보를 모두 테스트하도록 확장한다.

# Stage 5 동등 동작 분류 기준

목적: source assembly와 objdump 결과가 다를 때, 이를 즉시 오류로 판단하지 않고 machine code 해석상 같은 동작인지 분류한다.

분류 seed CSV는 `data/stage5_disassembly/equivalence_categories_seed.csv`에 둔다.

## 분류 기준

| Category | 정상/확인 | 판단 기준 |
|---|---|---|
| `exact_match` | 정상 | 정규화 후 source와 objdump 문자열이 동일하다. |
| `alias` | 정상 | 명령어 이름은 다르지만 같은 opcode/의미를 가진다. 예: `sal`과 `shl`, `je`와 `jz`. |
| `relative_target_resolved` | 정상 | source의 상대주소가 objdump에서 실제 주소로 출력된 경우다. |
| `generic_memory_size_inferred` | 정상 또는 표현 차이 | manual form이 generic `m`이고 objdump가 memory size를 추론해 출력했다. |
| `effective_address_size_directive_changed` | 정상 또는 표현 차이 | `LEA`처럼 memory 값을 읽지 않는 instruction에서 PTR size가 사라졌다. |
| `moffset_size_inferred` | 정상 또는 표현 차이 | register operand 크기에서 memory size가 추론되었다. |
| `far_pointer_size_repr_changed` | 별도 확인 | `m16:64` 등 far pointer memory operand에서 `TBYTE PTR`와 `FWORD PTR` 표기 차이가 나타났다. |
| `register_width_changed` | 확인 필요 | source와 objdump의 register width가 다르게 보인다. opcode bytes와 manual 확인이 필요하다. |
| `operand_size_changed` | 확인 필요 | 위 규칙으로 설명되지 않는 memory size 변화다. |
| `mnemonic_changed` | 확인 필요 | alias로 설명되지 않는 mnemonic 변화다. |
| `operand_changed` | 확인 필요 | mnemonic은 같지만 operand 구조가 바뀌었다. |
| `bug_candidate` | 우선 검토 | encoding 또는 instruction 의미가 실제로 달라졌을 가능성이 있다. |

## 대표 예시

### Alias

```asm
source:  sal eax, 1
objdump: shl eax,1
```

`SAL`과 `SHL`은 같은 의미의 alias이므로 오류로 보지 않는다.

### Generic memory size inferred

```asm
source:  invlpg [rax]
objdump: invlpg BYTE PTR [rax]
```

`INVLPG m`에서 `m`은 generic memory operand다. objdump가 `BYTE PTR`를 출력하더라도 실제 memory byte를 읽는다는 의미로 단정하지 않고 표현 차이로 분류한다.

### Effective address size directive changed

```asm
source:  lea rax, QWORD PTR [rbx]
objdump: lea rax,[rbx]
```

`LEA`는 effective address를 계산하므로 PTR size text가 semantic하지 않다. 테스트 생성 시에는 bare memory operand를 사용하는 것이 더 적절하다.

### Far pointer size representation changed

```asm
source:  lss rax, TBYTE PTR [rax]
objdump: lss rax,FWORD PTR [rax]
```

assembler는 source를 받아들이지만 objdump 표기는 다르게 나온다. 이 케이스는 오류 후보로 바로 넣지 않고 `far_pointer_size_repr_changed`로 따로 모아 분석한다.

### Register width changed

```asm
source:  lldt ax
objdump: lldt eax
```

source syntax와 objdump register width가 다르게 보인다. assembler별 허용 여부와 opcode bytes를 함께 확인해야 한다.

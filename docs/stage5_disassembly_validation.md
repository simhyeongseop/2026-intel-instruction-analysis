# Stage 5: objdump 기반 역어셈블 검증

## 목적

Stage 4에서 생성한 assembly source가 실제로 어떤 machine code로 조립되는지 확인하고, objdump 결과와 source assembly를 비교한다.

핵심 질문:

```text
assembler가 받아들인 source assembly가 의도한 instruction form으로 encoding되었는가?
```

## 파이프라인

```text
data/stage4_tests/test_all_instructions.s
  -> as --64 -mintel64
  -> data/stage5_disassembly/test_all_stage5.o
  -> objdump -d -M intel
  -> source instruction과 disassembled instruction 비교
  -> mismatch category 분류
```

## 실행

```bash
python src/stage5_disassembly_validation/step5_disassemble_compare.py
```

이미 생성된 object file을 재사용할 때:

```bash
python src/stage5_disassembly_validation/step5_disassemble_compare.py --reuse-object
```

## 출력

실행하면 다음 파일이 생성된다.

```text
data/stage5_disassembly/test_all_stage5.o
data/stage5_disassembly/step5_objdump_intel.txt
data/stage5_disassembly/step5_disasm_compare.csv
data/stage5_disassembly/step5_disasm_report.md
```

현재 repository에서는 수정 전 Stage 5 결과를 삭제했다. Stage 3/4의 operand mapping 수정 후 Ubuntu/WSL 환경에서 다시 생성해야 한다.

## 비교 시 주의점

objdump는 원래 source text를 복원하지 않는다. object file 안의 machine code bytes를 자신만의 assembly syntax로 다시 출력한다.

따라서 다음은 곧바로 오류가 아니다.

```asm
source:  invlpg [rax]
objdump: invlpg BYTE PTR [rax]
```

```asm
source:  sal eax, 1
objdump: shl eax,1
```

```asm
source:  lss rax, TBYTE PTR [rax]
objdump: lss rax,FWORD PTR [rax]
```

## 주요 분류

| Category | 판단 |
|---|---|
| `exact_match` | 정규화 후 동일 |
| `alias` | 의미가 같은 다른 표기 |
| `relative_target_resolved` | 상대주소가 실제 주소로 출력됨 |
| `generic_memory_size_inferred` | generic `m`에 대해 objdump가 PTR size를 출력 |
| `effective_address_size_directive_changed` | `LEA`에서 PTR size text가 사라짐 |
| `moffset_size_inferred` | register 크기에서 memory size가 추론됨 |
| `far_pointer_size_repr_changed` | far pointer memory operand의 표기 차이 |
| `register_width_changed` | register width가 다르게 보여 확인 필요 |
| `operand_size_changed` | 위 규칙으로 설명되지 않는 size 변화 |
| `bug_candidate` | 실제 encoding/동작 차이 가능성 |

분류 기준 상세는 `docs/stage5_equivalence_classification_rules.md`에 둔다.

## 재생성 전제

Ubuntu/WSL 환경에서 다음 도구가 필요하다.

```bash
sudo apt install build-essential clang binutils
```

Windows PowerShell에서 Python/WSL/as/objdump가 잡히지 않으면 Stage 5는 Ubuntu/WSL에서 실행한다.

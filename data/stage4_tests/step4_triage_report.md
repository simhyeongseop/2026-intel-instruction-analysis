# Step 4 에러 Triage 보고서

**대상 파일**: `test_all_instructions.s`
**총 에러 수**: 28개
**컴파일러**: GNU as (`-mintel64` 통과), GCC, Clang

---

## 1. 에러 카테고리별 분포

| 카테고리 | 설명 | 건수 | 비율 |
|----------|------|-----:|-----:|
| `unknown_instruction` | unknown instruction mnemonic | 15 | 53.6% |
| `register_type_mismatch` | register type/width mismatch | 12 | 42.9% |
| `size_only_memory_warning` | size-only memory operand warning | 1 | 3.6% |

---

## 2. 카테고리별 대표 예제 (다음 미팅 준비물)

### 2.1 `unknown_instruction` — unknown instruction mnemonic (15건)

**예제 1**: `ERETS` 블록
```asm
erets  # [ERROR] invalid instruction mnemonic 'erets'
```

**예제 2**: `ERETU` 블록
```asm
eretu  # [ERROR] invalid instruction mnemonic 'eretu'
```

**예제 3**: `INT1` 블록
```asm
int1  # [ERROR] invalid instruction mnemonic 'int1'
```


### 2.2 `register_type_mismatch` — register type/width mismatch (12건)

**예제 1**: `LSL r64, r32/m16` 블록
```asm
lsl rax, eax  # [ERROR] register type mismatch for `lsl'
```

**예제 2**: `LSL r64, r32/m16` 블록
```asm
lsl r13, ebx  # [ERROR] register type mismatch for `lsl'
```

**예제 3**: `LSL r64, r32/m16` 블록
```asm
lsl rbx, ecx  # [ERROR] register type mismatch for `lsl'
```


### 2.3 `size_only_memory_warning` — size-only memory operand warning (1건)

**예제 1**: `XLAT m8` 블록
```asm
xlat BYTE PTR [rbx]  # [ERROR] memory operand is only for determining the size, (R|E)BX will be used for the location
```


---

## 3. 주요 니모닉별 에러 발생 빈도 (TOP 20)

| 니모닉 | 에러 수 |
|--------|--------:|
| `lsl` | 12 |

---

## 4. 64비트 모드 미지원 명령어 목록


---

## 5. GCC vs Clang 비교

```
category  register_type_mismatch  size_only_memory_warning  unknown_instruction
compiler
as                             6                         0                    0
clang                          0                         1                   15
gcc                            6                         0                    0
```

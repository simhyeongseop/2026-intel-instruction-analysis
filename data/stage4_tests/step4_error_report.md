# Step 4 에러 Triage 보고서

**대상 파일**: `test_all_instructions.s`  
**총 에러 수**: 5523개  
**컴파일러**: GNU as (binutils)

---

## 1. 에러 카테고리별 분포

| 카테고리 | 설명 | 건수 | 비율 |
|----------|------|-----:|-----:|
| `operand_count_mismatch` | 오퍼랜드 개수 불일치 | 4626 | 83.8% |
| `unknown_instruction` | 알 수 없는 명령어 | 303 | 5.5% |
| `not_valid_here` | 해당 위치에서 유효하지 않음 | 238 | 4.3% |
| `not_supported_64bit` | 64비트 모드 미지원 | 110 | 2.0% |
| `suffix_error` | 접미어 오류 | 106 | 1.9% |
| `operand_type_mismatch` | 오퍼랜드 타입 불일치 | 64 | 1.2% |
| `conflicting_size` | 오퍼랜드 크기 충돌 | 36 | 0.7% |
| `operand_size_mismatch` | 오퍼랜드 크기 불일치 | 18 | 0.3% |
| `other` | 기타 에러 | 16 | 0.3% |
| `unsupported_instruction` | 지원되지 않는 명령어 | 4 | 0.1% |
| `not_allowed` | 허용되지 않는 조합 | 2 | 0.0% |

---

## 2. 카테고리별 대표 예제 (다음 미팅 준비물)

### 2.1 `operand_count_mismatch` — 오퍼랜드 개수 불일치 (4626건)

**예제 1**: `ADC AL` 블록
```asm
adc al  # [ERROR] number of operands mismatch for `adc'
```

**예제 2**: `ADC AX` 블록
```asm
adc ax  # [ERROR] number of operands mismatch for `adc'
```

**예제 3**: `ADC EAX` 블록
```asm
adc eax  # [ERROR] number of operands mismatch for `adc'
```


### 2.2 `unknown_instruction` — 알 수 없는 명령어 (303건)

**예제 1**: `AL AX` 블록
```asm
al ax  # [ERROR] no such instruction: `al ax'
```

**예제 2**: `F2 imm8` 블록
```asm
f2 0xff  # [ERROR] no such instruction: `f2 0xff'
```

**예제 3**: `F2 m512` 블록
```asm
f2 ZMMWORD PTR [rax + rbx*2 + 0x100]  # [ERROR] no such instruction: `f2 ZMMWORD PTR [rax+rbx*2+0x100]'
```


### 2.3 `not_valid_here` — 해당 위치에서 유효하지 않음 (238건)

**예제 1**: `CMPS m16` 블록
```asm
cmps WORD PTR [rbx]  # [ERROR] `WORD PTR [rbx]' is not valid here (expected `[rsi]')
```

**예제 2**: `CMPS m16` 블록
```asm
cmps WORD PTR [rax + rbx*2 + 0x100]  # [ERROR] `WORD PTR [rax+rbx*2+0x100]' is not valid here (expected `
```

**예제 3**: `CMPS m16` 블록
```asm
cmps WORD PTR [rax + rbx*8 + 0x1000]  # [ERROR] `WORD PTR [rax+rbx*8+0x1000]' is not valid here (expected
```


### 2.4 `not_supported_64bit` — 64비트 모드 미지원 (110건)

**예제 1**: `AAD imm8` 블록
```asm
aad 0xff  # [ERROR] `aad' is not supported in 64-bit mode
```

**예제 2**: `AAM imm8` 블록
```asm
aam 0xff  # [ERROR] `aam' is not supported in 64-bit mode
```

**예제 3**: `ARPL r16` 블록
```asm
arpl bp  # [ERROR] `arpl' is not supported in 64-bit mode
```


### 2.5 `suffix_error` — 접미어 오류 (106건)

**예제 1**: `SHLD CL` 블록
```asm
shld cl  # [ERROR] mnemonic suffix used with `shl'
```

**예제 2**: `SHLD r16` 블록
```asm
shld bp  # [ERROR] mnemonic suffix used with `shl'
```

**예제 3**: `SHLD r16` 블록
```asm
shld bp  # [ERROR] incorrect register `bp' used with `l' suffix
```


### 2.6 `operand_type_mismatch` — 오퍼랜드 타입 불일치 (64건)

**예제 1**: `CALL r32` 블록
```asm
call ecx  # [ERROR] operand type mismatch for `call'
```

**예제 2**: `CALL r32` 블록
```asm
call eax  # [ERROR] operand type mismatch for `call'
```

**예제 3**: `CALL r32` 블록
```asm
call ebp  # [ERROR] operand type mismatch for `call'
```


### 2.7 `conflicting_size` — 오퍼랜드 크기 충돌 (36건)

**예제 1**: `SHLD m16` 블록
```asm
shld WORD PTR [rax + rbx*1 + 0x10]  # [ERROR] conflicting operand size modifiers
```

**예제 2**: `SHLD m16` 블록
```asm
shld WORD PTR [rax]  # [ERROR] conflicting operand size modifiers
```

**예제 3**: `SHLD m16` 블록
```asm
shld WORD PTR [rip + 0x10]  # [ERROR] conflicting operand size modifiers
```


### 2.8 `operand_size_mismatch` — 오퍼랜드 크기 불일치 (18건)

**예제 1**: `LGDT m16` 블록
```asm
lgdt WORD PTR [rbx]  # [ERROR] operand size mismatch for `lgdt'
```

**예제 2**: `LGDT m16` 블록
```asm
lgdt WORD PTR [rax + rbx*8 + 0x1000]  # [ERROR] operand size mismatch for `lgdt'
```

**예제 3**: `LGDT m16` 블록
```asm
lgdt WORD PTR [rax + rbx*4 + 0x100]  # [ERROR] operand size mismatch for `lgdt'
```


### 2.9 `other` — 기타 에러 (16건)

**예제 1**: `IN DX` 블록
```asm
in dx  # [ERROR] ambiguous operand size for `in'
```

**예제 2**: `IN imm8` 블록
```asm
in 0xff  # [ERROR] ambiguous operand size for `in'
```

**예제 3**: `OUT DX` 블록
```asm
out dx  # [ERROR] ambiguous operand size for `out'
```


### 2.10 `unsupported_instruction` — 지원되지 않는 명령어 (4건)

**예제 1**: `CALL ptr16:16` 블록
```asm
call 0x0033:0x00001000  # [ERROR] unsupported instruction `call'
```

**예제 2**: `CALL ptr16:32` 블록
```asm
call 0x0033:0x00001000  # [ERROR] unsupported instruction `call'
```

**예제 3**: `JMP ptr16:16` 블록
```asm
jmp 0x0033:0x00001000  # [ERROR] unsupported instruction `jmp'
```


### 2.11 `not_allowed` — 허용되지 않는 조합 (2건)

**예제 1**: `SHLD CL` 블록
```asm
shld cl  # [ERROR] `cl' not allowed with `shll'
```

**예제 2**: `SHRD CL` 블록
```asm
shrd cl  # [ERROR] `cl' not allowed with `shrl'
```


---

## 3. 주요 니모닉별 에러 발생 빈도 (TOP 20)

| 니모닉 | 에러 수 |
|--------|--------:|
| `mov` | 82 |
| `xor` | 80 |
| `adc` | 72 |
| `add` | 72 |
| `cmp` | 72 |
| `or` | 72 |
| `sbb` | 72 |
| `sub` | 72 |
| `test` | 72 |
| `xchg` | 68 |
| `cmpxchg` | 65 |
| `xadd` | 65 |
| `and` | 60 |
| `bt` | 53 |
| `btc` | 53 |
| `btr` | 53 |
| `bts` | 53 |
| `bsf` | 52 |
| `bsr` | 52 |
| `cmova` | 52 |

---

## 4. 64비트 모드 미지원 명령어 목록

- `aad`
- `aam`
- `arpl`
- `bound`
- `jcxz`
- `lds`
- `les`
- `dword`

---

## 5. GCC vs Clang 비교

```
category  conflicting_size  not_allowed  not_supported_64bit  not_valid_here  operand_count_mismatch  operand_size_mismatch  operand_type_mismatch  other  suffix_error  unknown_instruction  unsupported_instruction
compiler                                                                                                                                                                                                             
as                      36            2                  110             238                    4626                     18                     64     16           106                  303                        4
```

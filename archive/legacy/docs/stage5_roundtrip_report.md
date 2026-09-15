# Stage 5 Roundtrip 검증 보고서

## 1. 목적

Assembly source를 assemble → disassemble(objdump) → reassemble 했을 때,
역어셈블 결과가 **유효한 assembly인지**, 그리고 **동일한 machine code로 다시 조립되는지** 검증한다.

## 2. 실험 환경

| 도구 | 버전 | 용도 |
|------|------|------|
| GNU as (Binutils) | 2.42 (Ubuntu 24.04) | Assembler (원본 조립) |
| GNU objdump | 2.42 | Disassembler (역어셈블) |
| GCC | 15.2 | Assembler (검증용) |
| Clang | 20.1 | Assembler (검증용) |
| Godbolt (Binutils 2.45, Clang trunk) | 온라인 | 교차 검증 |

Assembler 옵션: `--64 -mintel64`  
Disassembler 옵션: `objdump -d -M intel`

## 3. 전체 결과 요약

- 테스트 대상: 8810개 instruction (Stage 4 생성)
- Roundtrip encoding 일치: **8674건 (100% — branch 제외)**
- Branch/relative address (구조적으로 비교 불가): 136건
- **Reassemble 실패: 35건**

## 4. Roundtrip Failure 분류

### 4.1 LSS/LFS/LGS r64 + FWORD PTR (30건) — objdump 출력 오류

**Intel SDM 근거 (325383-090, "LDS/LES/LFS/LGS/LSS—Load Far Pointer"):**

Instruction table:
| Opcode | Instruction | 64-Bit Mode |
|--------|-------------|-------------|
| `REX.W + 0F B2 /r` | `LSS r64, m16:64` | Valid |
| `REX.W + 0F B4 /r` | `LFS r64, m16:64` | Valid |
| `REX.W + 0F B5 /r` | `LGS r64, m16:64` | Valid |

SDM Description 원문:
> "In 64-bit mode, the instruction's default operation size is 32 bits. Using a REX prefix in the form of REX.W promotes operation to specify a source operand referencing an **80-bit pointer (16-bit selector, 64-bit offset)** in memory."

따라서 `m16:64` = 16-bit selector + 64-bit offset = **80-bit = 10 bytes = TBYTE**.

**원본 assembly (assemble 성공):**
```asm
lss rax, TBYTE PTR [rax]
lfs r9, TBYTE PTR [rax]
lgs rdx, TBYTE PTR [rbx]
```

**Encoding:**
```
48 0f b2 00    lss rax, ... (REX.W + 0F B2 /r)
4c 0f b4 08    lfs r9, ...  (REX.W + 0F B4 /r)
48 0f b5 13    lgs rdx, ... (REX.W + 0F B5 /r)
```

**objdump 출력 (역어셈블 결과):**
```asm
lss rax, FWORD PTR [rax]
lfs r9, FWORD PTR [rax]
lgs rdx, FWORD PTR [rbx]
```

**Reassemble 결과:**

| Assembler | 원본 (TBYTE PTR) | 역어셈블 (FWORD PTR) |
|-----------|---|---|
| GAS `-mintel64` | ✅ 성공 | ❌ `incorrect register used with 'l' suffix` |
| Clang 20 | ✅ 성공 | ✅ 성공 (동일 encoding 출력) |

**테스트 케이스 정당성 검증:**

- Intel SDM이 명시적으로 80-bit pointer라고 기술 → `TBYTE PTR` (10 bytes) 사용이 정확
- `FWORD PTR` = 48-bit = 6 bytes → 이는 `m16:32` (32-bit 모드) 형태에 해당하는 크기
- 우리 테스트 케이스 (`TBYTE PTR`)는 **Intel manual spec에 정확히 부합하는 올바른 테스트 케이스**

**결론:**
- GNU objdump가 REX.W 존재 시에도 `FWORD PTR`(48-bit)로 출력하는 것은 **PTR size 표기 오류**
- Intel manual 기준 `TBYTE PTR`(80-bit)가 정확
- 이 잘못된 출력을 GAS에 다시 넣으면 reassemble 불가능
- Clang은 `FWORD PTR`도 accept하므로 Clang에서는 roundtrip 성공
- **GNU toolchain 내에서는 완전한 roundtrip failure**

---

### 4.2 MOV moffs (4건) — 파서 버그 (실제 roundtrip failure 아님)

**Intel SDM 근거 (325383-090, "MOV—Move"):**

| Opcode | Instruction | 설명 |
|--------|-------------|------|
| `A2` | `MOV moffs8, AL` | Move AL to (seg:offset) |
| `A3` | `MOV moffs32, EAX` | Move EAX to (seg:offset) |
| `REX.W + A3` | `MOV moffs64, RAX` | Move RAX to (offset) |

**원본 assembly:**
```asm
mov BYTE PTR [0x1000], al
mov QWORD PTR [0x1000], rax
```

**objdump 실제 출력:**
```asm
mov BYTE PTR ds:0x1000, al
mov QWORD PTR ds:0x1000, rax
```

**검증 결과:**
- objdump 출력 (`ds:0x1000` 형태)을 GAS에 다시 넣으면 **reassemble 성공**
- 재조립된 encoding도 원본과 동일
- 초기 roundtrip 테스트에서 실패한 이유: 우리 파서가 `ds:` segment prefix를 제거했기 때문

**결론: 실제 roundtrip failure가 아님. 파서의 segment prefix 처리 버그였음.**

### 4.3 lock + lods (1건) — GAS accept 일관성 문제

**원본 assembly (assemble 성공):**
```asm
lock
lods BYTE PTR [rsi]
```

**Encoding:**
```
f0 ac    lock lods al, BYTE PTR ds:[rsi]
```

**objdump 출력:**
```asm
lock lods al, BYTE PTR ds:[rsi]
```

**Reassemble 결과:**

| Assembler | 원본 (lock + lods 별도 행) | 역어셈블 (lock lods 한 행) |
|-----------|---|---|
| GAS `-mintel64` | ✅ 성공 | ❌ `expecting lockable instruction after 'lock'` |
| Clang 20 | ✅ 성공 | ✅ 성공 |

**분석:**

Intel SDM에 따르면 LODS는 lockable instruction이 아님.
- GAS는 `lock`과 `lods`를 **별도 행으로 넣으면** accept하지만, **한 행으로 넣으면** 거부
- objdump는 한 행으로 출력하므로 GAS에서 reassemble 불가
- Clang은 한 행 형태도 accept
- 엄밀히 말하면 GAS가 처음에 `lock` + `lods`를 accept한 것 자체가 이상

**결론:**
- GAS의 accept/reject 일관성 문제
- Intel manual 기준 LODS에 LOCK prefix는 invalid
- **GAS 내부 비일관성** (별도 행 OK, 한 행 NG)

### 4.4 jrcxz / loop / loope / loopne (4건) — 구조적 한계

**원본 assembly:**
```asm
jrcxz .
loop .
loope .
loopne .
```

**objdump 출력:**
```asm
jrcxz 0x532d
loop 0x57f2
loope 0x57f4
loopne 0x57f6
```

**분석:**

- 이 instruction들은 rel8 (8-bit signed offset) operand만 지원
- `.` (현재 주소) → offset = 0 또는 -2 → assemble 가능
- objdump는 절대주소로 출력 → 절대주소가 현재 위치에서 rel8 범위를 초과하면 reassemble 불가

**결론:**
- objdump의 설계상 한계 (relative address를 absolute로 표시)
- 모든 disassembler가 가지는 구조적 문제이므로, assembler bug라기보다 disassembler 표현 방식의 한계

## 5. Assembler 간 차이 요약

| 케이스 | GAS `-mintel64` | Clang 20 | 판정 |
|--------|---|---|---|
| 원본 `TBYTE PTR` | ✅ | ✅ | 일치 |
| 역어셈블 `FWORD PTR` | ❌ | ✅ | **GAS만 실패** |
| 원본 `lock` + `lods` (별도 행) | ✅ | ✅ | 일치 |
| 역어셈블 `lock lods` (한 행) | ❌ | ✅ | **GAS만 실패** |
| 원본 MOV moffs `[0x1000]` | ✅ | ✅ | 일치 |
| 역어셈블 MOV moffs `ds:0x1000` | ✅ | ✅ | 일치 (roundtrip 성공) |

## 6. 핵심 발견

### 발견 1: GNU objdump의 far pointer PTR size 출력 오류

### 발견 1: GNU objdump의 far pointer PTR size 출력 오류

- `REX.W + LSS/LFS/LGS` (m16:64 = 80-bit) encoding에 대해
- objdump가 `FWORD PTR` (48-bit, m16:32에 해당)로 출력
- Intel SDM 기준 정확한 출력은 `TBYTE PTR` (80-bit)
- 이 잘못된 출력은 **같은 GNU toolchain의 assembler에서 reassemble 불가**
- 30건 해당

- LODS는 Intel manual 기준 lockable이 아님
- GAS는 `lock`과 `lods`를 별도 행으로 넣으면 accept, 같은 행이면 reject
- objdump는 같은 행으로 출력하므로 roundtrip failure 발생
- 1건 해당

### 발견 3: Relative branch의 구조적 roundtrip 불가

- rel8 전용 instruction (jrcxz, loop, loope, loopne)
- objdump가 절대주소로 출력하면 재조립 시 range 초과
- 4건 해당 (disassembler 설계 한계)

## 7. Roundtrip 성공 통계

| 구분 | 건수 | 비율 |
|------|------|------|
| 완벽한 roundtrip (동일 encoding) | 8674 | 98.5% |
| Branch (address-dependent, 비교 제외) | 136 | 1.5% |
| **Roundtrip failure** | **35** | **0.4%** |
| 그 중 objdump PTR 오류 (LSS/LFS/LGS) | 30 | |
| 그 중 GAS lock 비일관성 | 1 | |
| 그 중 rel8 구조적 한계 | 4 | |

## 8. 참고: Encoding 검증

Reassemble 가능한 8674건에 대해 instruction 단위 encoding 비교 수행:
- 원본 `.o` 파일의 opcode bytes와, objdump 출력을 재조립한 opcode bytes를 비교
- **차이 발생 건수: 0건**
- 즉, reassemble 가능한 instruction은 전부 원본과 동일한 machine code를 생성함

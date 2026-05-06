# Step 4 에러 분석 보고서

**테스트 파일**: `test_all_instructions.s`  
**총 테스트 케이스**: 8,631개  
**어셈블러**: GNU as (GAS), GCC, Clang 

---

## 0. 테스트 환경

| 항목 | 버전 |
|------|------|
| GNU as | **2.42** (GNU Binutils for Ubuntu, 2024) |
| GCC | **13.3.0** (Ubuntu 13.3.0-6ubuntu2~24.04.1) |
| Clang | **18.1.3** (Ubuntu clang version 18.1.3) |
| Target | x86\_64-linux-gnu / x86\_64-pc-linux-gnu |
| OS | Ubuntu 24.04 (WSL) |
| GAS 실행 옵션 | `as --64 -mintel64` (Intel64 ISA 모드 — Intel SDM 대응 기준) |

---

## 1. 전체 진행 통계

| 항목 | 수치 |
|------|-----:|
| 추출된 instruction form (64비트 유효) | 987개 |
| r/m 확장 후 (Stage 2) | 1,480개 |
| 테스트 생성된 form | 1,338개 |
| 스킵된 form (미매핑 operand) | 72개 |
| 생성된 테스트 케이스 | 8,631개 |
| GNU as 에러 (`-mintel64`) | **0건** ✅ |
| GCC 에러 (`-Wa,-mintel64`) | **0건** ✅ |
| Clang 에러 (툴 특성) | 89건 |

---

## 2. 테스트 설계 원칙

- `.intel_syntax noprefix` 사용
- **매뉴얼의 instruction form 구조(operand 개수/타입) 그대로 유지**
- 각 operand 자리에 해당 타입의 후보값 랜덤 대입
- `imm32` 값:
  - r64/m64 대상 (sign-extend): `0x7fffffff`(양수 경계), `-1`(음수 경계) 모두 테스트
  - r32/m32 대상 (unsigned): `0xffffffff` (unsigned max)
  - PUSH imm32: 64비트 모드에서 sign-extend 대상이므로 r64와 동일하게 처리

---

## 3. GNU as / GCC 에러 최종 결과: 0건 ✅

Intel SDM 대응 모드로 실행한 결과, **테스트 케이스 8,631개 전부 통과**.

| 어셈블러 | 옵션 | 결과 |
|----------|------|------|
| GNU as | `--64 -mintel64` | **0건** ✅ |
| GCC | `-c -Wa,--64 -Wa,-mintel64` | **0건** ✅ |

> GCC는 내부적으로 GAS를 호출하므로 `-Wa,-mintel64`로 Intel64 모드를 전달하면 GAS와 동일하게 통과됩니다.

### 3-1. LSS/LFS/LGS r64, m16:64 — GAS AMD64/Intel64 모드 차이 (확정)

| 항목 | 내용 |
|------|------|
| **에러 메시지** | `operand size mismatch for 'lss'` 등 |
| **재현 코드** | `lss rdi, TBYTE PTR [rip + 0x100]` |

**매뉴얼 근거**:
- `REX.W + 0F B2 /r` = `LSS r64, m16:64`
- `m16:64` = 10바이트 far pointer, `TBYTE PTR` 표기

**실험으로 확인된 결론**:

| 실행 옵션 | 결과 | 설명 |
|-----------|------|------|
| `as --64` | ❌ 거부 | GAS 기본값 = AMD64 모드 |
| `as --64 -mamd64` | ❌ 거부 | AMD64 모드 명시 |
| `as --64 -mintel64` | ✅ 통과 | Intel64 모드, 올바른 인코딩 생성 |

```text
// -mintel64 objdump 결과
48 0f b2 38   lss (%rax), %rdi   ← Intel SDM과 일치
48 0f b4 38   lfs (%rax), %rdi
48 0f b5 38   lgs (%rax), %rdi
```

> **결론**: GAS 미지원이 아니라 **AMD64 vs Intel64 ISA 모드 선택**에 따른 동작 차이.  
> Intel SDM과 비교하는 본 연구의 기준은 `-mintel64` 모드이므로, 이 케이스는 에러가 아님.
> `-mintel64`로 재실행 결과 30건이 모두 **통과됨** (실험 확인).

---

## 4. imm32 sign-extension: Intel SDM vs GAS 의미론 차이 (교차검증 완료)

### 현상

```asm
adc rax, 0xffffffff   // Error: operand size mismatch
adc rax, -1           // OK  (동일한 비트패턴, 올바른 표현)
push 0xffffffff       // Error: operand size mismatch
push -1               // OK
```

### Intel SDM vs GAS 관점 차이

| 관점 | 해석 |
|------|------|
| **Intel SDM** | 기계어 인코딩 기준 — `imm32` 비트패턴 `ff ff ff ff`를 CPU가 sign-extend하여 사용 |
| **GAS/LLVM** | 소스 리터럴의 수학적 값 기준 — `0xffffffff` = `+4,294,967,295`, signed 32-bit 범위 초과로 거부 |

### Codex 교차검증 결론

> "Intel encoding permits the bit pattern, but GAS/LLVM reject the positive source literal because it is not representable as a sign-extended 32-bit value."

- GAS 버그가 아니라 **assembler expression semantics** 의 의도된 동작
- GAS는 `Imm32S` operand class에서 `isInt<32>(Value)` 검사 수행
- LLVM 동일: `isImmSExti64i32Value`에서 `isInt<32>(Value)` 검사

### objdump로 확인된 인코딩

```text
adc rax, -1  →  48 83 d0 ff   (REX.W + 83 /2 ib: imm8 sign-extended)
push -1      →  6a ff          (6a: PUSH imm8 sign-extended)
```

> **결론**: GAS는 `-1`을 의미상 올바르게 수용하지만, `imm32` form(`81`) 대신 더 짧은 `imm8 sign-extended` form(`83`)을 선택한다.  
> 따라서 `adc rax, -1`은 SDM expression semantics 관점에서 올바른 표현이지만, SDM의 `REX.W + 81 /2 id` opcode 자체를 검증한 것은 아니다.  
> 특정 `imm32` form을 테스트하려면 `.byte` 또는 `.insn` 등 저수준 인코딩 강제가 필요하다 — 본 연구 범위 밖.

### 영향 범위 (r/m64, imm32 sign-extend 형태를 가진 명령어)

ADC, ADD, SUB, OR, AND, XOR, CMP, SBB, TEST, IMUL, MOV, PUSH 등

---

## 5. Clang 에러 분류 (89건) — 파서 수정 후 재분석

| 건수 | 에러 메시지 | 원인 | 판단 |
|-----:|------------|------|------|
| 67건 | `unknown token in expression` | `call .`, `ja .` 등 — `.`(현재 주소 심볼)을 Clang Intel syntax 파서가 거부 | Clang-GAS 동작 차이 |
| 12건 | `invalid instruction mnemonic 'lkgs'` | LKGS — Clang 18.1.3 미지원 신규 명령어 | 툴 버전 한계 |
| 6건  | `invalid operand for instruction` | `invlpg QWORD PTR [rax]` — INVLPG는 size 미지정 메모리 오퍼랜드, QWORD PTR을 Clang이 거부 | 추가 확인 필요 |
| 1건  | `invalid instruction mnemonic 'erets'` | ERETS — FRED extension, Clang 18.1.3 미지원 | 툴 버전 한계 |
| 1건  | `invalid instruction mnemonic 'eretu'` | ERETU — 동일 | 툴 버전 한계 |
| 1건  | `invalid instruction mnemonic 'int1'` | INT1 (ICEBP) — Clang 18.1.3 미지원 | 툴 버전 한계 |
| 1건  | `memory operand is only for determining the size` | `xlat BYTE PTR [rbx]` — Clang의 XLAT 동작 경고 | 정상 동작 |

**`.` 심볼 문제 상세**:
- GAS에서 `.`은 현재 명령어 주소(program counter)를 의미
- Clang Intel syntax 파서는 `.`을 expression 심볼로 인식하지 못함
- `call .`, `ja .`, `jrcxz .` 등 모든 rel8/rel32 테스트 케이스에서 재현
- Clang에서 대안: `0` 또는 절대 라벨 사용

> 기존 `//` 주석이 Clang에서 에러를 낸다는 결론은 **파서 버그**로 인한 잘못된 분석이었습니다. 실제 원인은 `.` 심볼 처리 차이입니다.

---

## 6. 수정한 테스트 설계 문제 이력

| 문제 | 수정 내용 |
|------|-----------|
| `r/m81`, `r81` 등 각주 오염 | Stage 1 cleaning 함수 추가 |
| `IRET`, `IRETD` ambiguous size | 64비트 모드에서 skip, `IRETQ`만 테스트 |
| `MOVSXD r16, r16` 거부 | 64비트 모드 r64 형태만 테스트 |
| `XLAT BYTE PTR [rax+...]` 거부 | 항상 `BYTE PTR [rbx]` 고정 |
| `SGDT/SIDT QWORD PTR` 거부 | `[rax]` bare memory 형태로 수정 |
| `MOV Sreg, QWORD PTR` 거부 | Sreg 소스 메모리 → `WORD PTR` 고정 |
| `imm32 = 0xffffffff` for r64 | `dest_is_64` 감지 → `0x7fffffff`, `-1` 사용 |
| `push 0xffffffff` 거부 | PUSH를 sign-extend 명령어로 분류, `-1` 포함 |
| Clang `#` 주석 파싱 오류 | 주석 형식 `#` → `//` 변경 |
| `S30` garbage instruction | Stage 4 noise filter 추가 |
| Clang 에러 정규식 오류 | `file:line:column:` 형식 처리 추가 |
| GAS 모드 미명시 | `as --64 -mintel64` 옵션 추가 (Intel64 ISA 모드 명시) |

---

## 7. 후속 실험 목록

| 항목 | 상태 | 비고 |
|------|------|------|
| `-mintel64` 모드로 전체 재실험 | ✅ 완료 | GNU as 에러 0건 확인 |
| GCC `-Wa,-mintel64` 옵션 실험 | ✅ 완료 | 에러 0건 확인 — GCC도 Intel64 모드에서 완전 통과 |
| INVLPG `QWORD PTR` Clang 거부 | 미완료 | Clang 전용 이슈, 연구 범위 밖 |
| Clang `.` 심볼 대안 | 미완료 | rel8/rel32를 라벨로 변경 시 Clang 에러 줄어들 것 |

---

## 8. 결론

**확정된 사실**:

| 발견 | 결론 |
|------|------|
| `0xffffffff` 거부 (r64+imm32) | GAS 버그 아님 — expression semantics 차이 (소스 리터럴 수학적 값 기준) |
| LSS/LFS/LGS r64, TBYTE PTR 거부 | GAS 미지원 아님 — AMD64 기본 모드 한계, `-mintel64` 에서 정상 통과 |
| `adc rax, -1` → imm8 인코딩 | GAS가 `83` (imm8) form 선택, `81` (imm32) form 아님 |
| GCC `-Wa,-mintel64` → 에러 0건 | GCC도 Intel64 모드에서 완전 통과 — GCC는 GAS 래퍼임을 재확인 |
| Clang `unknown token` | `.` 심볼 미지원 (현재 주소 심볼), `//` 주석 문제 아님 |

**핵심 결과**:  
Intel SDM 대응 모드(`as --64 -mintel64`)에서 **GNU as 에러 0건**.  
8,631개 테스트 케이스를 GAS가 모두 올바르게 수용함.

**핵심 교훈**:  
Intel SDM과 비교하는 연구에서 GAS 실험 기준은 **`as --64 -mintel64`** (Intel64 ISA 모드)이어야 한다.  
기본값인 `-mamd64` 모드는 LSS/LFS/LGS r64 등 일부 Intel64 전용 형태를 거부한다.

# Stage 4 발표용 결과 보고서

## 1. 프로젝트 목적

이 미니프로젝트의 목적은 Intel x86-64 SDM(Software Developer's Manual)에 정의된 instruction form을 실제 assembler 테스트 케이스로 변환하고, assembler가 이를 수용하는지 확인하는 자동 테스트 기반을 만드는 것이다.

핵심은 단순히 "에러가 났다/안 났다"를 세는 것이 아니라, 에러가 발생했을 때 그 원인이 다음 중 어디에 해당하는지 분류하는 것이다.

- Intel SDM 명세와 assembler 구현의 실제 차이
- 테스트 생성 과정의 오류
- assembler 실행 옵션 차이
- assembler source syntax 의미론 차이
- assembler별 parser 또는 지원 버전 차이

## 2. 원래 교수님 지시와 현재 진행 내용의 연결

5회차 미팅에서 강조된 내용은 "완전 랜덤 조합"이 아니라, Intel SDM에서 추출한 syntax/form 안에서 operand type에 맞는 후보값을 넣어 테스트해야 한다는 점이었다.

따라서 현재 파이프라인은 다음 흐름으로 정리할 수 있다.

| 단계 | 수행 내용 | 산출물 |
|---|---|---|
| 1 | Intel SDM instruction form 추출 | parsed instruction CSV |
| 2 | 64비트 모드에서 유효한 form 필터링 | 64-bit valid form list |
| 3 | operand type 수집 및 그룹화 | r/m/imm/memory group |
| 4 | operand type별 candidate 정의 | register, memory, immediate 후보값 |
| 5 | SDM form 구조를 유지한 assembly 생성 | `test_all_instructions.s` |
| 6 | GAS/GCC/Clang으로 조립 테스트 | error log |
| 7 | 에러 메시지별 triage | error report |
| 8 | 원인 분석 | mode/literal/parser 차이 분류 |

## 3. 테스트 설계 원칙

- GAS Intel syntax 사용: `.intel_syntax noprefix`
- Intel SDM의 instruction form에서 operand 개수와 operand type을 유지
- 각 operand type에 맞는 candidate만 대입
- 완전 랜덤 조합은 사용하지 않음
- memory operand는 effective address와 RIP-relative address를 포함
- immediate operand는 크기와 signedness에 맞는 경계값을 사용

예시:

```asm
.intel_syntax noprefix
adc rax, 0x7fffffff
adc rax, -1
lss rdi, TBYTE PTR [rax]
```

## 4. 최종 실험 환경

| 항목 | 값 |
|---|---|
| OS | Ubuntu 24.04 (WSL) |
| GNU as | 2.42 |
| GCC | 13.3.0 |
| Clang | 18.1.3 |
| GAS 기준 옵션 | `as --64 -mintel64` |
| GCC 기준 옵션 | `gcc -c -Wa,--64 -Wa,-mintel64` |

Intel SDM과 직접 비교하는 기준은 GAS의 기본 AMD64 모드가 아니라 Intel64 ISA 모드인 `-mintel64`로 설정했다.

## 5. 최종 진행 통계

| 항목 | 수치 |
|---|---:|
| 추출된 64비트 유효 instruction form | 987개 |
| r/m 확장 후 form | 1,480개 |
| 테스트 생성 form | 1,338개 |
| 스킵된 form | 72개 |
| 최종 테스트 케이스 | 8,631개 |
| GNU as 에러 (`--64 -mintel64`) | 0건 |
| GCC 에러 (`-Wa,-mintel64`) | 0건 |
| Clang 에러/경고 | 89건 |

## 6. 핵심 결과 1: GAS/GCC는 Intel64 모드에서 0건 에러

GNU as를 Intel SDM 대응 모드로 실행하면 8,631개 테스트 케이스가 모두 통과했다.

```text
as --64 -mintel64 test_all_instructions.s -o test_all_as.o
```

GCC도 내부적으로 GAS를 호출하므로, assembler option을 넘겨주면 동일하게 통과한다.

```text
gcc -c -Wa,--64 -Wa,-mintel64 test_all_instructions.s -o test_all_gcc.o
```

따라서 이번 테스트 범위에서는 Intel SDM instruction form과 GNU as Intel64 mode 사이의 accept/reject 불일치는 발견되지 않았다.

## 7. 핵심 결과 2: LSS/LFS/LGS는 GAS 미지원이 아니라 모드 차이

초기에는 다음 instruction들이 GAS에서 에러를 냈다.

```asm
lss rdi, TBYTE PTR [rax]
lfs rdi, TBYTE PTR [rax]
lgs rdi, TBYTE PTR [rax]
```

하지만 재실험 결과 원인은 GAS 미지원이 아니라 AMD64/Intel64 ISA 모드 차이였다.

| 실행 옵션 | 결과 | 해석 |
|---|---|---|
| `as --64` | 거부 | GAS 기본값은 AMD64 모드 |
| `as --64 -mamd64` | 거부 | AMD64 모드 명시 |
| `as --64 -mintel64` | 통과 | Intel64 모드 |

`-mintel64`에서 생성된 기계어는 Intel SDM의 opcode와 일치했다.

```text
48 0f b2 38   lss (%rax), %rdi
48 0f b4 38   lfs (%rax), %rdi
48 0f b5 38   lgs (%rax), %rdi
```

결론: 이 사례는 Intel SDM 오류도 GAS 미지원도 아니며, GAS의 ISA mode 선택에 따른 차이다.

## 8. 핵심 결과 3: imm32 sign-extension은 source literal 의미론 문제

Intel SDM은 `imm32` 필드의 기계어 비트패턴이 64비트로 sign-extend된다고 설명한다.

예:

```asm
adc rax, 0xffffffff   # GAS rejects
adc rax, -1           # GAS accepts
```

기계어 비트패턴으로는 `0xffffffff`와 `-1`이 같은 32비트 패턴을 만들 수 있다. 그러나 GAS source expression에서 `0xffffffff`는 `+4294967295`라는 양수 값으로 해석된다. 이 값은 signed 32-bit 범위를 초과하므로 sign-extended imm32 operand로 사용할 수 없다.

따라서 GAS가 `0xffffffff`를 거부하는 것은 버그라기보다 assembler expression semantics의 결과로 볼 수 있다.

다만 `adc rax, -1`은 의미상 올바른 표현이지만 실제 인코딩은 `imm32`가 아니라 더 짧은 `imm8 sign-extended` form으로 선택된다.

```text
adc rax, -1  -> 48 83 d0 ff
push -1      -> 6a ff
```

따라서 특정 `imm32` opcode 자체를 검증하려면 `.byte` 또는 `.insn` 등 encoding-level 테스트가 추가로 필요하다.

## 9. Clang 결과 해석

Clang 18.1.3에서는 89건의 에러/경고가 남았다. 이는 Intel SDM 오류라기보다 Clang parser 또는 지원 범위 차이로 분류된다.

| 건수 | 원인 | 해석 |
|---:|---|---|
| 67 | `call .`, `ja .`, `loop .` 등에서 `.` symbol 거부 | Clang Intel syntax parser 차이 |
| 12 | `lkgs` 미지원 | Clang 18.1.3 지원 범위 문제 |
| 6 | `invlpg QWORD PTR [rax]` 거부 | size specifier 처리 차이 |
| 1 | `erets` 미지원 | FRED extension 지원 범위 문제 |
| 1 | `eretu` 미지원 | FRED extension 지원 범위 문제 |
| 1 | `int1` 미지원 | assembler mnemonic 지원 차이 |
| 1 | `xlat BYTE PTR [rbx]` warning | Clang의 XLAT 해석 차이 |

## 10. 결론

이번 단계의 결론은 다음과 같다.

1. Intel SDM 자체의 오류를 발견한 것은 아니다.
2. Intel SDM 대응 모드인 `as --64 -mintel64`에서 GNU as는 8,631개 테스트 케이스를 모두 수용했다.
3. GCC도 `-Wa,-mintel64`를 전달하면 동일하게 통과한다.
4. 초기 에러처럼 보였던 LSS/LFS/LGS 문제는 GAS의 AMD64/Intel64 모드 차이였다.
5. `0xffffffff` 문제는 SDM 오류나 GAS 버그가 아니라 source literal 의미론 차이다.
6. Clang 에러는 GAS와 다른 parser/지원 범위 차이로 별도 관리해야 한다.

한 문장으로 정리하면:

> 이 프로젝트는 Intel SDM instruction form을 실제 assembler 테스트로 변환하는 기반을 만들었고, 에러 발생 시 그것이 SDM 문제인지, 테스트 생성 문제인지, assembler 옵션/문법 차이인지 분류하는 체계를 구축했다.

## 11. 추후 과제

- operand type group과 candidate table을 문서화
- assembler별 실행 옵션을 config로 고정
- Clang 전용 candidate 조정 또는 별도 profile 작성
- objdump 기반으로 실제 opcode가 의도한 instruction form과 일치하는지 검증
- Ubuntu 26.04/GCC 15 등 최신 toolchain에서 재실험

---

# 예상 질의응답

## Q1. 이 프로젝트의 원래 목표가 무엇인가요?

Intel SDM에 적힌 x86-64 instruction form을 자동으로 assembly 테스트 케이스로 바꾸고, 실제 assembler가 이를 받아들이는지 확인하는 테스트 기반을 만드는 것이다.

단순히 명령어를 랜덤하게 조합하는 것이 아니라, SDM에서 추출한 syntax의 operand 개수와 operand type을 유지한 채 candidate 값을 넣어야 한다. 즉 "잘못된 assembly를 많이 만들어보는 fuzzing"이 아니라 "manual-defined form을 실제 assembler syntax로 변환하는 검증"에 가깝다.

## Q2. Intel SDM이 틀린 사례를 찾은 건가요?

현재 단계에서는 Intel SDM 자체가 틀렸다고 볼 만한 사례는 발견하지 못했다.

초기에 에러처럼 보였던 사례들은 대부분 다음 원인이었다.

- GAS 실행 모드 차이
- source literal 해석 차이
- Clang parser 차이
- 테스트 생성기의 operand 표현 문제

따라서 발표에서는 "Intel SDM 오류를 찾았다"가 아니라 "SDM form을 assembler 테스트로 변환하고, 발생한 에러의 원인을 분류했다"라고 말해야 한다.

## Q3. GAS가 무엇인가요?

GAS는 GNU Assembler의 약자다. 실제 실행 파일 이름은 보통 `as`이다.

보고서에서 다음 표현은 같은 대상을 가리킨다.

- GNU as
- GAS
- `as`

GCC가 `.s` 파일을 컴파일할 때도 보통 내부적으로 GAS를 호출한다. 그래서 GCC 결과는 독립 assembler 결과라기보다 GAS를 GCC 경로로 호출한 결과에 가깝다.

## Q4. 왜 GCC도 실험했나요?

실제 사용자는 assembly 파일을 직접 `as`로 조립하기도 하지만, `gcc -c file.s`처럼 GCC를 통해 조립하기도 한다. 따라서 GCC 경로에서 같은 문제가 발생하는지 확인할 필요가 있었다.

다만 `.s` 파일에 대한 GCC는 내부적으로 GAS를 호출한다. 그래서 GCC 에러가 독립적인 assembler 구현의 에러는 아니다.

이번 실험에서 GCC 기본 호출은 GAS 기본 AMD64 모드 때문에 LSS/LFS/LGS에서 에러가 났고, `-Wa,-mintel64`를 전달하자 0건으로 사라졌다.

## Q5. 왜 Clang도 실험했나요?

Clang은 GAS와 다른 assembler parser 또는 integrated assembler를 사용할 수 있다. 따라서 같은 Intel syntax assembly가 Clang에서는 어떻게 처리되는지 비교하기 위해 실험했다.

Clang 결과는 SDM과 GAS의 직접 비교라기보다, assembler별 compatibility 차이를 확인하는 보조 실험이다.

## Q6. 왜 `-mintel64`를 기준으로 삼았나요?

이 연구는 Intel SDM과의 대응성을 확인하는 것이 목적이다. GAS의 기본 x86-64 모드는 `-mamd64`인데, 이 모드는 일부 Intel64 form을 거부한다.

예를 들어 `LSS/LFS/LGS r64, m16:64`는 Intel SDM에는 정의되어 있고 `-mintel64`에서는 정상 조립되지만, `-mamd64`에서는 거부된다.

따라서 Intel SDM을 기준으로 한 실험에서는 `as --64 -mintel64`가 더 적절하다.

## Q7. `LSS/LFS/LGS` 에러는 무엇이었나요?

처음에는 다음 코드가 GAS에서 거부되었다.

```asm
lss rdi, TBYTE PTR [rax]
```

하지만 확인 결과:

```text
as --64           -> reject
as --64 -mamd64   -> reject
as --64 -mintel64 -> accept
```

따라서 이 에러는 GAS가 명령어를 지원하지 않아서가 아니라, 기본 AMD64 mode에서 해당 Intel64 form을 허용하지 않아서 발생한 것이다.

## Q8. 그러면 GAS 기본값은 왜 Intel SDM과 다르게 동작하나요?

GAS는 x86-64 안에서도 AMD64 ISA mode와 Intel64 ISA mode를 구분한다.

기본값은 `-mamd64`이다. AMD64 mode에서는 일부 Intel64-specific form을 거부할 수 있다. Intel SDM과 직접 비교하려면 `-mintel64`를 명시해야 한다.

따라서 "GAS가 틀렸다"라기보다 "GAS의 기본 ISA profile이 Intel SDM 전체와 1:1로 대응하지 않는다"라고 보는 것이 정확하다.

## Q9. `imm32`가 무엇인가요?

`imm32`는 instruction 안에 직접 들어가는 32비트 immediate 값을 뜻한다. immediate는 register나 memory에서 읽어오는 값이 아니라 instruction encoding 자체에 포함되는 상수 값이다.

예:

```asm
adc rax, -1
```

여기서 `-1`이 immediate operand이다.

## Q10. 왜 `imm32` 값이 대상에 따라 달라졌나요?

같은 `imm32`라도 instruction form에 따라 의미가 다를 수 있다.

32비트 register 대상:

```asm
mov eax, 0xffffffff
```

이 경우 `0xffffffff`는 32비트 값으로 자연스럽게 들어갈 수 있다.

64비트 register 대상 sign-extension form:

```asm
adc rax, imm32
```

이 경우 SDM은 `imm32 sign extended to 64 bits`라고 설명한다. assembler source에서는 signed 32-bit 범위에 들어가는 값이어야 하므로 `-1`은 가능하지만 `0xffffffff`는 `+4294967295`로 해석되어 거부된다.

## Q11. `0xffffffff`는 결국 `-1`과 같은 비트패턴 아닌가요?

기계어 비트패턴 관점에서는 맞다. 32비트 패턴 `ff ff ff ff`를 signed 32-bit로 해석하면 `-1`이다.

하지만 assembler source expression 관점에서는 `0xffffffff`가 `+4294967295`라는 양수 literal로 해석된다. GAS는 source expression의 수학적 값이 operand 범위에 맞는지를 검사한다.

따라서 CPU encoding 관점과 assembler source 관점이 다르다.

## Q12. 그러면 GAS가 `0xffffffff`를 거부하는 것은 버그인가요?

현재 판단으로는 버그라고 보기 어렵다.

GAS는 `imm32 sign-extended` operand에 대해 source expression 값이 signed 32-bit 범위 안에 있는지 검사한다. `0xffffffff`는 수학적 값으로 `4294967295`이므로 signed 32-bit 범위를 초과한다.

따라서 이 현상은 "GAS 버그"라기보다 "assembler expression semantics"의 결과로 설명하는 것이 더 정확하다.

## Q13. `adc rax, -1`이면 SDM의 `imm32` form을 테스트한 건가요?

아니다. 의미상으로는 sign-extended immediate를 표현하는 올바른 source code이지만, GAS는 더 짧은 encoding을 선택한다.

실제 objdump 결과:

```text
adc rax, -1 -> 48 83 d0 ff
```

이는 `REX.W + 83 /2 ib`, 즉 imm8 sign-extended form이다. SDM의 `REX.W + 81 /2 id` imm32 form을 직접 검증한 것은 아니다.

특정 opcode form까지 검증하려면 `.byte`, `.insn`, 또는 objdump 기반 encoding-level 테스트가 필요하다.

## Q14. 현재 테스트는 무엇을 검증하나요?

현재 테스트는 assembler가 source instruction을 accept하는지 reject하는지를 검증한다.

즉 다음을 확인한다.

- 이 syntax가 assembler에서 조립 가능한가?
- operand type 표현이 assembler 문법에 맞는가?
- immediate 값이 assembler 범위 검사에 맞는가?
- assembler별 parser 차이가 있는가?

하지만 다음은 아직 완전히 검증하지 않는다.

- 실제 CPU에서 실행 가능한가?
- privilege exception이 발생하는가?
- CPU feature bit가 필요한가?
- 조립된 opcode가 의도한 SDM form과 정확히 같은가?

## Q15. "컴파일은 됐지만 다른 명령어로 조립될 수 있다"는 말은 무슨 뜻인가요?

assembler가 source를 받아들였다고 해서 항상 우리가 의도한 opcode form이 선택되는 것은 아니다.

예:

```asm
adc rax, -1
```

이 코드는 조립에 성공하지만, `imm32` form이 아니라 `imm8` form으로 인코딩된다.

따라서 다음 단계에서는 objdump 결과를 분석해서 실제 opcode가 의도한 form과 일치하는지 확인해야 한다.

## Q16. `noprefix`는 무엇인가요?

GAS에서 Intel syntax를 사용할 때 register 앞에 `%` prefix를 붙이지 않도록 하는 설정이다.

AT&T syntax 예:

```asm
addq $1, %rax
```

Intel syntax noprefix 예:

```asm
.intel_syntax noprefix
add rax, 1
```

Intel SDM은 Intel syntax에 가까운 표기를 사용하므로, 이번 테스트도 `.intel_syntax noprefix`를 사용했다.

## Q17. 진행 통계는 무엇을 의미하나요?

진행 통계는 "수정한 테스트 개수"가 아니라, SDM에서 테스트 파일까지 변환되는 pipeline의 단계별 규모를 뜻한다.

예:

- 추출된 instruction form: SDM에서 읽어낸 원래 form
- 64비트 유효 form: x86-64 모드에서 사용할 수 있는 form
- r/m 확장 후 form: register/memory operand를 구체 케이스로 확장한 form
- 테스트 생성 form: 실제 assembly test를 만든 form
- 생성된 테스트 케이스: 최종 assembly line 수

## Q18. 스킵된 form은 실패인가요?

반드시 실패는 아니다. 스킵된 form은 아직 operand type mapping 또는 candidate generation이 정의되지 않은 경우다.

예를 들어 특수한 operand type이 아직 candidate table에 없으면 잘못된 테스트를 만들기보다 skip하는 것이 안전하다.

추후 과제는 이 skip된 operand type들을 분석해서 candidate를 추가하는 것이다.

## Q19. Clang 에러는 어떻게 해석해야 하나요?

Clang 에러는 Intel SDM 오류라고 바로 해석하면 안 된다.

이번 Clang 에러의 주요 원인은 다음과 같다.

- `.` current-location symbol 처리 차이
- `LKGS`, `ERETS`, `ERETU` 등 신규/특수 명령어 지원 범위 차이
- `INVLPG QWORD PTR [rax]` 같은 memory size specifier 처리 차이

따라서 Clang은 별도 assembler profile로 관리하는 것이 좋다.

## Q20. 최종적으로 "에러가 없다"고 말해도 되나요?

조건을 붙여서 말해야 한다.

정확한 표현:

> Intel SDM 대응 기준인 GNU as `--64 -mintel64`와 GCC `-Wa,-mintel64`에서는 이번 테스트 범위의 8,631개 케이스가 모두 조립되었다.

부정확한 표현:

> 모든 assembler에서 에러가 없다.

Clang에서는 여전히 89건이 남아 있으므로 assembler별로 구분해야 한다.

## Q21. 이 결과의 연구적 의미는 무엇인가요?

이 결과의 의미는 Intel SDM의 오류를 발견했다는 것이 아니라, SDM instruction form을 실제 assembler 테스트로 변환하는 과정에서 어떤 요소들이 결과에 영향을 주는지 확인했다는 점이다.

특히 다음이 중요하다.

- assembler ISA mode를 명시해야 한다.
- source literal과 기계어 비트패턴은 다르게 취급될 수 있다.
- assembler별 parser 차이를 따로 분류해야 한다.
- accept/reject 테스트 이후에는 encoding-level 검증이 필요하다.

## Q22. 다음 단계는 무엇인가요?

다음 단계는 네 가지다.

1. operand group/candidate table 문서화
2. Clang profile 별도 구성
3. objdump 기반 opcode 검증 추가
4. 최신 toolchain, 예를 들어 Ubuntu 26.04/GCC 15 환경에서 재실험

특히 담당 교수님이 언급한 "컴파일은 됐지만 다른 명령어로 조립되는 문제"를 확인하려면 objdump 기반 검증이 필요하다.

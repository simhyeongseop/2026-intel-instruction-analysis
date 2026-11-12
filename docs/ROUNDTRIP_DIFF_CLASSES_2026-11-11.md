# 왕복 세 비교의 '다름'·'미대조' 분류 (2026-11-11 라운드)

자료: `out/round2_20261111/roundtrip_chain/` — `diff_cases.csv`(케이스 × 경로 × 비교 한 줄, `class` 열),
`diff_summary.json`(집계), `manifest_diff.json`. 분류 코드 `scripts/classify_roundtrip_diffs.py`(도구 재실행 없음),
회귀 `tests/test_classify_roundtrip_diffs.py`.
원인 분석(매뉴얼 조회·바이트·CPU 관측)과 표기 차이의 의미 확인은 [ROUNDTRIP_ANALYSIS_2026-11-11.md](ROUNDTRIP_ANALYSIS_2026-11-11.md).

흐름: as0(원본 소스) → b0(조립) → as1(역어셈블) → b1(다시 조립) → as2(다시 역어셈블). 계열 gnu(as·objdump), llvm(clang·llvm-mc).
경로 AT&T/Intel은 as1·as2를 어느 문법으로 풀었는가. AT&T 경로의 as0는 3단계 AT&T 변환 소스.

## 1. 미대조 (세 비교 모두 비교하지 않음)

| 원인 | gnu AT&T | gnu Intel | llvm AT&T | llvm Intel |
|---|---|---|---|---|
| 같은 파일 라벨(`.Ltarget`) 상대 분기(rel8 36, rel16 34, rel32 34). 역어셈블 출력이 `ja 0x0`처럼 절대 주소라 다시 조립해도 원래 변위와 비교할 수 없음 | 104 | 104 | 104 | 104 |
| 재조립 거부: GNU objdump가 `LSS/LFS/LGS r64, m16:64`를 `lss rcx,FWORD PTR [rax]`로 출력 → GNU as `incorrect register 'rax' used with 'l' suffix` | – | 78 | – | – |
| 재조립 거부: GNU objdump가 먼 간접 `CALL/JMP m16:64`(확장 기준 레지스터)를 `rex.WB call FWORD PTR [r12]`로 출력 → GNU as `same type of prefix used twice` | – | 9 | – | – |

- 상대 분기는 외부 기호(`ext_target`) 변형으로 따로 비교하고 있다. `.Ltarget` 변형은 rel8/rel16 행에 닿기 위한 것이다.
- 추가 확인: `.Ltarget` 416건(4경로)을 출력 숫자 → 라벨로 되돌려 다시 조립하면 모두 b0–b1·as1–as2 같음(`scripts/check_ltarget_roundtrip.py`, `ltarget_check.csv`).
- 재조립 거부 87건은 11월 4일 사용자가 오류로 분류한 GNU LSS·LFS·LGS `FWORD` 출력과 같은 계열이다.

## 2. b0–b1, as1–as2 '다름'

| 원인 | b0–b1 (gnu AT&T / gnu Intel / llvm AT&T / llvm Intel) | as1–as2 (같은 순서) |
|---|---|---|
| VPCMP{B,W,D,Q} 술어 0: 역어셈블이 `vpcmpeqb`로 출력 → 다시 조립하면 VPCMPEQ* 전용 opcode(74/75/76/29). 명령은 같다 | 12 / 12 / 12 / 12 | 0 |
| LLVM 메모리 간접 CALL/JMP: 크기 표기 소스(`call word ptr [rax]`, `jmp dword ptr [rax]`, fword, tbyte)를 먼 간접 FF /3·/5로 조립, as1은 크기 없는 `call [rax]` → 다시 조립하면 가까운 간접 FF /2·/4 | 0 / 0 / 0 / 242 | 0 / 0 / 0 / 242 |
| LLVM Intel PUSHF/POPF 16비트: `66 9C/9D`를 폭 없는 `pushf/popf`로 출력 → 다시 조립하면 `9C/9D`(64비트) | 0 / 0 / 0 / 2 | 0 / 0 / 0 / 2 |
| LLVM AT&T `MOV Sreg, r16`: `66 8E C1`을 `movw %cx,%es`로 출력 → 다시 조립하면 접두어 없는 `8E C1`, as2 `movl %ecx,%es` | 0 / 0 / 2 / 0 | 0 / 0 / 2 / 0 |

LLVM CALL/JMP 242건의 3단계 판정: m16:32·JMP m16:32 SDM 일치 50, m16:16·m16:64 다른 인코딩 99,
r/m16 다른 행으로 수용 48, r/m32 시험 불가(별칭) 45. ModRM reg 칸은 b0에서 모두 3·5(먼), b1에서 2·4(가까운)로 확인.

## 3. as0–as2 '다름' (문자열 비교, 표기 규칙별)

규칙을 모두 적용하면 같아지는지 본 뒤, 하나씩 빼 보며 꼭 필요한 규칙만 남겼다. 한 케이스에 규칙이 여럿이면 각 규칙에
한 번씩 센다(행 합이 '다름' 수보다 크다). **표기 차이 설명이며 의미 판정이 아니다.** 바이트·명령 일치는 b0–b1·as1–as2가 본다.

| 표기 규칙 | 예 (as0 → as2) | gnu AT&T | gnu Intel | llvm AT&T | llvm Intel |
|---|---|---|---|---|---|
| 숫자 진법 | `adc al, 0x12` → `adc al, 18` | 1,613 | 8,709 | 65,398 | 65,428 |
| 주소 스케일 표기 | `[rax+rbx*8]` → `[rax + 8*rbx]`, `*1` 생략 | 0 | 160 | 4,157 | 23,122 |
| 생략 변위 0 | `[rbp]` → `[rbp+0x0]`, `(%r13)` → `0x0(%r13)` | 6,945 | 6,937 | 0 | 0 |
| 숫자 폭 감기(부호·2의 보수) | `adc al, -0x1` → `0xff`, `[rip-0x80]` → `[rip+0xffffffffffffff80]` | 967 | 8,099 | 1,818 | 1,818 |
| AT&T 크기 글자 | `bt $1,%ecx` → `btl` | 168 | 23 | 10,490 | 11 |
| 메모리 크기·브로드캐스트 표기 | `[0x10]` → `XMMWORD PTR ds:0x10`, `word ptr [..]{1to32}` → `WORD BCST [..]` | 0 | 6,870 | 0 | 1,122 |
| 조건 코드 별칭 | `cmovng` → `cmovle`, `jnb` → `jae`, `cmpzxadd` → `cmpexadd` | 1,875 | 1,875 | 1,875 | 1,875 |
| 암묵·생략 오퍼랜드 | `fmulp` → `fmulp st(1),st`, `shl $1,..` 생략 | 177 | 168 | 1,048 | 1,046 |
| 비교 술어 의사 명령 | `vcmpps ..,0x12` → `vcmple_oqps`, `vpcmpb ..,0` → `vpcmpeqb` | 604 | 604 | 604 | 604 |
| 니모닉 별칭 | `sal` → `shl`, `movabs`, `repne` → `repnz`, `fwait` → `wait` | 371 | 371 | 511 | 367 |
| 반올림·SAE 위치 | `zmm2, {ru-sae}` → `zmm2{ru-sae}` | 0 | 1,586 | 0 | 0 |
| XCHG 오퍼랜드 순서 | `xchg ecx,[r12]` → `xchg [r12],ecx` | 106 | 106 | 106 | 106 |
| GPR 폭 표기 | `pmovmskb rdx,..` → `edx`, `lldt cx` → `ecx` (도구가 REX.W·66 없이 조립, b0 확인) | 94 | 94 | 70 | 68 |
| FWAIT 분리 | `fstsw ..` → `wait` + `fnstsw ..` | 0 | 0 | 103 | 103 |
| x87 st(0) 표기 | `st(0)` → `st` | 26 | 26 | 26 | 26 |
| 소스 두 오퍼랜드 순서 바뀜 | `vandps ymm2,ymm4,ymm11` → `ymm2,ymm11,ymm4` (교환 가능 연산, LLVM VEX2 선택) | 0 | 0 | 47 | 47 |
| 인코딩 표시 | `{evex} vpermpd`, `rex.w jmp` | 25 | 66 | 0 | 0 |
| AT&T 포트 괄호 | `(%dx)` → `%dx` | 0 | 0 | 12 | 0 |
| LLVM 먼 간접 CALL/JMP(2절과 같은 문제가 AT&T as2 `ljmp/lcall`로 보임) | `jmpw *(%rsp)` → `ljmp *(%rsp)` | 0 | 0 | 48 | 0 |
| **기타(규칙으로 설명 안 됨)** | 아래 | 81 | 34 | 68 | 68 |
| '다름' 합계 | | 11,177 | 26,027 | 73,226 | 76,247 |

기타 251건(4경로 합)의 내용(직접 확인한 대표 예):
- AT&T 확장 이름: `cbw/cwde/cdqe/cwd/cdq/cqo` → `cbtw/cwtl/cltq/cwtd/cltd/cqto` (두 계열 AT&T)
- 문자열 명령 표기: `movs [rdi],[rsi]` → `movsb .. es:[rdi]`, `rep` ↔ `repe`, `insd` → `ins DWORD PTR [rdi],dx`
- 술어 의사 명령에 `{sae}`가 붙은 VCMP*, `pclmulqdq ..,0` → `pclmullqlqdq`
- GNU AT&T `{rn-sae}` 위치(`{rn-sae}, %rcx, ..` → `%rcx,{rn-sae}, ..`)
- `xacquire`/`xrelease` → `repnz`/`repz`(같은 F2/F3 바이트), `iretd` → `iret`, `%dr0` → `%db0`
- LLVM `vcmppd ..,-0x50`(술어 EQ_OS, 대칭)에서 소스 두 오퍼랜드 교환 + 숫자 감기
- LLVM Intel `pushfw/popfw` → `pushfq/popfq` (2절 PUSHF/POPF와 같은 바이트 문제)

## 4. 해석 주의

- as0–as2 규칙은 텍스트 표기만 맞춘다. 규칙이 설명했다고 의미가 같다고 확정하지 않는다. GPR 폭 표기는 b0가 REX.W 없이
  조립된 것을 확인한 경우(W 무시 명령, r/m16 시스템 명령)다.
- 우선 검토 대상은 2절의 LLVM CALL/JMP(242, 기존 오류 분류 계열)와 PUSHF/POPF(2), MOV Sreg(2), 1절의 GNU 재조립 거부(87)다.

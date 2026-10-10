# 새 생성기 첫 실행 (2026-10-11)

재현: `python3 pipeline/run.py generator --until check --execute` (실행 기록 `out/runs/20261010T160510248706Z.json`)
환경: GNU as 2.42, clang 18.1.3, Intel Core Ultra 5 226V(AVX-512 없음). SDM 093판.

## 생성 (2단계 `m2_generate.py`)

- 4,219행 → 19,425케이스. 모든 행에 케이스가 있다. 사양 신뢰 행(원문 확정·완화·예외 등록) 19,425개 전부다.
- SDM 기대: reach 19,271, reject 106, alias_no_test 48
  - alias_no_test: 64비트 무효 행인데 같은 문법의 유효 행이 있다(INC r16 `40+rw`, Jcc/JMP/CALL rel16, LGDT m16&32 등).
- 값은 `pipeline/case_rules.py` 표로만 고른다. 케이스의 `evidence` 칸에 오퍼랜드마다 근거(SYM 번호, 쪽, 규칙)가 있다.
  - 레지스터: SDM 목록 순서. 같은 표의 고정 레지스터와 주소 레지스터(rax, rbx)를 빼고, 행 안에서 물리 레지스터를 겹치지 않게 고른다.
  - 메모리: 64비트 기본 주소 크기(Vol.1 66쪽)로 base `[rax]`, SIB `[rax+rbx*4+0x10]`, RIP `[rip+0x10]`.
    다음은 원문이 정한 주소만 쓴다: 문자열 명령(rsi/rdi), XLAT(rbx), PREFETCHIT(RIP), sibmem(SIB).
    MPX의 BNDMK/BNDLDX/BNDSTX와 mib는 RIP 형태를 만들지 않는다(절 원문: RIP 상대면 #UD).
  - 즉시값: 그 폭에만 들어가는 값(imm8 0x12, imm32 0x12345678 …)과 부호 있는 최대값.
- 예전 생성기의 도달 실패 95행 중 해결된 것:
  - 시프트 1비트 별칭 32행(imm8 1 → 0x12)
  - far RET 2행(`retf`)
  - PUSH imm16(`data16 push`)
  - TCMM* 2행(서로 다른 tmm)
  - 음성 별칭 46행(alias_no_test로 분리, 또는 문법이 달라져 거부 시험이 됨)

## 판정 (3단계 `m3_check.py`, SDM 대 도구별)

| 판정 | GNU as | clang |
|---|---|---|
| SDM 일치 | 17,090 | 17,029 |
| SDM 일치(강제 접두어) | 2,145 | 1,985 |
| SDM 일치(거부) | 89 | 94 |
| **SDM 일치 합계** | **19,324** | **19,108** |
| 시험 불가(별칭) | 48 | 48 |
| 별칭 행 도달 | 24 | 178 |
| SDM과 다름(수용) | 17 | 12 |
| 모르는 명령 | 1 | 38 |
| 거부 | 9 | 37 |
| 도달 불가(등록) | 2 | 1 |
| 다른 인코딩 | 0 | 3 |

행 단위로 모든 케이스가 SDM과 일치한 행: GNU 4,197/4,219, clang 4,059/4,219.

### SDM과 맞지 않은 것 (GNU)

- **SDM과 다름(수용) 17**: 64비트 모드에서 N.E.인 행을 받아들인다.
  - MPX r/m32 형식: BNDCL·BNDCU·BNDCN r/m32, BNDMK m32 (11케이스)
  - CALL r/m32, JMP r/m32: `66 ff 18`처럼 66 접두어를 붙여 조립한다(6케이스).
- **거부 9**:
  - MOV Sreg, r/m64(REX.W 8E) 메모리: 사용자 확인 대기 사례
  - RDMSR·WRMSRNS imm32: 도구 미지원으로 등록됨
  - SYSEXIT·SYSRET(0F 35, 0F 07): GNU가 SDM 철자를 "ambiguous operand size"로 거부한다. `sysretd`는 GNU만 받는다.
- **별칭 행 도달 24**: MOVQ/VMOVQ 메모리 별칭 opcode(`unreachable_forms.csv`의 그 행들). VMOVQ EVEX 2행은 GNU `{evex}`로 다른 EVEX 행이 나온다.
- 도달 불가(등록) 2: LAR r32, r64와 LSL r64, r32 레지스터 문법. 모르는 명령 1: UDB.

### SDM과 맞지 않은 것 (clang)

- **모르는 명령 38**: MPX 전체, FRED(ERETS·ERETU), INT1, LKGS, UD0, UDB
- **거부 37**:
  - AVX512PF(VGATHERPF*/VSCATTERPF*) 16
  - MOVSXD r16·r32 8
  - CET CLRSSBSY·RSTORSSP의 `qword ptr` 6
  - MOV Sreg r/m64 3, RDMSR·WRMSRNS imm32 4
- **SDM과 다름(수용) 12**: CALL·JMP r/m16(N.S.)과 r/m32(N.E.)를 64비트 `ff 18`로 조립한다.
- **다른 인코딩 3**: `data16`을 받지만 꼬리를 4바이트로 낸다. PUSH imm16(`66 68 34 12 00 00`) 2케이스, XBEGIN rel16 1케이스. GNU는 둘 다 2바이트 꼬리로 SDM과 맞는다.
- **별칭 행 도달 178**: 방향 쌍(8A/88 등)과 PUSH r/m 대 50+r 등이다. clang은 `{load}`/`{store}`를 받지 않는다.

### CPU 실행 (`--execute`, GNU 바이트, 레지스터 전용·이 CPU 지원 기능만)

exit0 1,954, SIGSEGV 89, SIGFPE 8, SIGTRAP 2, SIGILL 10.
SIGILL 10개는 모두 CPUID 칸이 비어 있는 명령이다(UD0/UD1/UD2, RSM, MONITOR/MWAIT, ERETS/ERETU, LKGS, LOCK 단독).
이 CPU의 사용자 모드에서 #UD가 나는 것으로 보고 기록만 했다. 실행 결과는 ISA 의미 확정이 아니다.

## 확인 범위와 한계

- 인코딩 대조는 `encoding_audit`가 읽는 필드(접두어·맵·opcode·ModRM 조건·꼬리 길이)만 본다. 레지스터 번호와 실행 의미는 대조하지 않는다.
- "SDM 일치(강제 접두어)"는 그 도구의 문서화된 의사 접두어로 표 행에 도달했다는 뜻이다. 접두어 없는 소스가 그 행을 고른다는 뜻은 아니다.
- 예전 5~13단계(objdump 왕복, 재조립)는 아직 새 판정에 붙이지 않았다.

## 역어셈블 대조 (4단계 `m4_disasm.py`, 2026-10-11)

재현: `python3 pipeline/run.py --only disasm` (실행 기록 `out/runs/20261010T223758310990Z.json`)

- 대상: 3단계에서 SDM 행 바이트와 일치한 reach 케이스 19,244개. 같은 바이트를 두 역어셈블러로 따로 푼다.
  - GNU objdump 2.42
  - LLVM 18 MC 역어셈블러(`llvm-mc-18 --disassemble`)
- 판정 기준: 역어셈블러가 그 SDM 행의 명령을 생성 때 의도한 오퍼랜드로 이름 붙였는가. 두 역어셈블러는 서로 비교하지 않는다.
  - 니모닉: 같은 opcode 칸의 SDM 표 행 니모닉과 SDM 의사 니모닉 표(VCMPPD 289쪽, CMPPD Table 3-9, VPCMP Table 5-19, PCLMULQDQ Table 4-15)
  - 오퍼랜드: 레지스터 이름, 즉시값, 메모리 크기(원문 폭)·주소·브로드캐스트, 마스크 장식
  - SDM이 정한 것은 같게 본다: FWAIT 짝(9B 행 = FWAIT + FN*, 506쪽), F2·F3 접두어 이름(31쪽), 암묵 오퍼랜드(<XMM0>, 문자열 누산기, 리터럴 1)
- 다시 조립(참고, 판정에 쓰지 않음): 텍스트에는 {evex}나 방향 정보가 없어 같은 문법의 다른 인코딩이 나올 수 있다.
  - objdump → as: 같음 18,915, 다른 인코딩 200, 거부 13
  - LLVM → clang: 같음 16,953, 다른 인코딩 2,113, 거부 24

| 판정 | objdump | LLVM |
|---|---|---|
| SDM 일치 | 19,103 | 19,073 |
| SDM 일치(분기 대상 미대조) | 70 | 71 |
| SDM 일치(암묵 오퍼랜드 미대조) | 38 | 37 |
| SDM 일치(같은 opcode 표 행의 표기) | 0 | 1 |
| 니모닉 다름(도구 관례 철자) | 7 | 8 |
| 니모닉 다름 | 1 | 2 |
| 오퍼랜드 다름 | 25 | 17 |
| 디코드 실패 | 0 | 35 |

### SDM과 다른 것

- **두 역어셈블러 공통**
  - SDM이 r/m16이라 적은 레지스터 형식을 32비트 이름으로 출력한다: MOV Sreg, r/m16(`mov es, ecx`), MOVSXD r16, r/m16(`edx`). objdump는 LLDT·LTR·VERR·VERW·LKGS도 그렇다.
  - LAR·LSL: 표 문법 "LAR r32, r64/m16"(REX.W)의 목적지를 objdump·LLVM 모두 rcx로 출력한다(표 문법 자체가 기존 재심 D절 사례). LLVM은 LAR/LSL r32/m16 레지스터를 `dx`로 출력한다.
- **objdump**
  - m16:64(10바이트 먼 포인터)를 FWORD(6바이트)로 출력한다: LSS·LFS·LGS r64, m16:64, CALL·JMP m16:64.
  - XLATB(REX.W D7)를 `rex.W xlat`로 출력한다.
  - 도구 관례 철자: movabs(MOV r64, imm64), pushw, sysretd, sysexitd, xbeginw
- **LLVM**
  - 디코드 실패 35: MPX(BND*) 전부, LKGS, UD0, INT1
  - ERETS·ERETU(F2/F3 0F 01 CA)를 `clac`로 출력한다(접두어를 무시함).
  - CLRSSBSY·RSTORSSP m64를 `dword ptr`로 출력한다(clang은 같은 명령의 `qword ptr` 입력도 거부했다).
  - 도구 관례 철자: lcall·ljmp(먼 메모리 분기, 크기 표기 없음), fcompi·fucompi, movabs

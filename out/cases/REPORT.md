# 새 생성기 첫 실행 (2026-10-11)

재현: `python3 pipeline/run.py generator --until check --execute` (실행 기록 `out/runs/20261010T160510248706Z.json`)
환경: Intel Core Ultra 5 226V(AVX-512 없음), SDM 093판. 도구는 2026-10-12부터 GNU Binutils 2.47, LLVM 23.1.3(아래 첫 절). 그 아래 절의 수치는 GNU 2.42, clang 18.1.3 기록이다.

## 도구 갱신: GNU Binutils 2.47, LLVM 23.1.3 (2026-10-12)

사용자 결정으로 두 도구를 최신 판으로 바꿨다. 경로는 `pipeline/toolchain.py` 한곳에서 정하고, 실행 기록에 판이 남는다.
- GNU Binutils 2.47(2026-07-26 출시): `~/opt/binutils-2.47`, 소스 빌드. SHA256은 출시 공지 값과 같다.
- LLVM 23.1.3(2026-10-06 출시): `~/opt/llvm-23.1.3`, 공식 Linux-X64 바이너리. SHA256은 GitHub 릴리스 값과 같다.
- 재현: `python3 pipeline/run.py check --until disasm --execute`(실행 기록 `out/runs/20261011T163012324196Z.json`)
- 아래 다른 절의 수치는 이전 판(GNU 2.42, clang/LLVM 18.1.3) 기록이다.

| 항목 | 이전 (2.42 / 18.1.3) | 지금 (2.47 / 23.1.3) |
|---|---|---|
| 3단계 SDM 일치 GNU / clang | 19,323 / 19,108 | 19,313 / 19,118 |
| 행 전체 일치 GNU / clang (4,219행) | 4,196 / 4,059 | 4,195 / 4,064 |
| 4단계 대상 | 19,244 | 19,223 |
| 4단계 일치 계열 objdump / LLVM | 19,209 / 19,176 | 19,152 / 19,150 |
| LLVM 디코드 실패 | 35 | 6 (INT1, UD0, UDB) |
| CPU 관측 | exit0 1,954, SIGSEGV 88, SIGFPE 8, SIGILL 10, SIGTRAP 2 | SIGILL 11 (UDB 추가), 나머지 같음 |

판이 바뀌어 달라진 것
- **GNU는 기본 설정에서 MPX를 받지 않는다** (2.47에서 MPX 14행 31케이스가 SDM 일치 → 거부)
  - 오류: "`bndcl' is not supported on `x86_64'". 3단계 결과의 note 칸에 이유와 켜는 방법을 적었다.
  - 사용자 결정(2026-10-12): 도구 기본 설정 그대로 시험하고, 기본 설정에서 받지 않는다고 기록한다.
  - **쓰려면 `-march=generic64+mpx` 옵션 또는 소스의 `.arch .mpx` 지시어로 켠다.** 2.47에서 확인: `bndcl bnd0, rcx` → `f3 0f 1a c1`.
  - 이유: binutils 커밋 [57c526470](https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=57c526470bbf03220f928f0894a85c76a9659d35)(2024-12-02, Jan Beulich) "x86: default to not accepting MPX insns"
    - 커밋 설명: "Gcc9 had MPX support removed. While we don't want to remove support, require these deprecated insns (and registers) to be enabled explicitly."
    - 기본 아키텍처 정의(`opcodes/i386-gen.c`)를 `~IAMCU`에서 `~(IAMCU|MPX)`로 바꿨다. 커밋 당시 개발판 2.43.50이므로 **2.44부터** 적용됐다.
    - gas/NEWS와 사용 설명서에는 이 변경이 적혀 있지 않다(2.47 기준).
  - 같은 방식으로 이후 AMX-TRANSPOSE(05b24220b, 2025-10)와 AMX-TF32(ddd9b65d0, 2026-06)도 기본에서 뺐다.
    - 이유: "de-published"되었고 "will not show up on any Intel/AMD hardware"
    - SDM 093에는 이 두 기능의 행이 없어 영향이 없다.
  - clang은 원래 MPX를 모르므로, MPX는 두 도구 모두 바이트가 없어 4단계 대상에서 빠졌다.
- GNU 2.47이 UDB를 받는다(`d6`). CPU 실행은 SIGILL이고, 원문 "Raise invalid opcode exception"과 맞다.
- GNU 2.47·clang 23이 RDMSR·WRMSRNS imm32를 받는다(SDM 일치). `source_conflict_cases`의 "도구 미지원" 등록은 이전 판 관측이다. 3단계 note는 지금 도구가 실제로 거부할 때만 적는다(지금은 UDB-clang 1건).
- clang 23이 ERETS·ERETU·LKGS를 받는다(SDM 일치). LLVM 23 역어셈블러도 이것들과 MPX를 디코드한다.
  - 이전 판의 ERETS·ERETU → `clac`은 사라졌다.
- **CMPccXADD 역어셈블 이름**: objdump 2.47·LLVM 23이 같은 조건의 다른 이름으로 출력한다(36케이스).
  - 예: CMPNBEXADD → `cmpaxadd`, CMPZXADD → `cmpexadd`
  - CMPccXADD 절(Vol.2 281~285쪽)은 조건마다 이름 하나만 적는다. 같은 subcode의 동의어는 Vol.1 Table B-1(539쪽)에 있지만, 그 표의 적용 대상은 CMOVcc·FCMOVcc·Jcc·SETcc다.
  - 그래서 SDM 일치가 아니라 `니모닉 다름(도구 관례 철자)`로 센다.
- LLVM 23은 VGATHERPF0DPS 메모리를 `zmmword` 대신 `dword ptr`로 출력한다.

- REX.W 짝 행 대조 추가(2026-10-12): 같은 opcode 칸에 REX.W 행이 따로 있으면 REX.W 없는 행은 REX.W 바이트를 받지 않는다(Vol.1 Table 3-4). 예: `48 ff 18`은 CALL m16:64이고 CALL m16:32가 아니다. 3·4단계를 다시 돌렸고 판정 변화는 0건이다(실행 기록 `out/runs/20261011T180101901220Z.json`).

버그 후보 4개(아래 'LLVM 이슈 확인' 절)는 LLVM 23.1.3에서도 모두 그대로 재현된다.
- clang `call word/dword ptr [rax]` → `ff 18`
- llvm-mc `ff 18` → `call [rax]`
- clang CLRSSBSY·RSTORSSP `qword ptr` 거부
- clang Intel 문법 AVX512PF 16행 거부

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
| SDM 일치 | 17,089 | 17,029 |
| SDM 일치(강제 접두어) | 2,145 | 1,985 |
| SDM 일치(거부) | 89 | 94 |
| **SDM 일치 합계** | **19,323** | **19,108** |
| 시험 불가(별칭) | 48 | 48 |
| 별칭 행 도달 | 24 | 178 |
| 다른 행으로 수용 | 17 | 12 |
| 모르는 명령 | 1 | 38 |
| 거부 | 9 | 37 |
| 도달 불가(등록) | 2 | 1 |
| 다른 인코딩 | 1 | 3 |

행 단위로 모든 케이스가 SDM과 일치한 행: GNU 4,196/4,219, clang 4,059/4,219.
(2026-10-11 66H 대조 추가 후 수치. 아래 "66H 오퍼랜드 크기 접두어 대조" 절)

### SDM과 맞지 않은 것 (GNU)

- **다른 행으로 수용 17**: 64비트 모드에서 N.E.인 행의 문법을 받아, 같은 니모닉의 유효 행 바이트를 낸다(아래 '남은 불일치 확인').
  - MPX r/m32 형식 11케이스 → BNDCL·BNDCU·BNDCN·BNDMK r/m64(m64) 행
  - CALL·JMP r/m32 6케이스 → 먼 CALL·JMP m16:16(`66 FF /3`, `66 FF /5`)
- **거부 9**:
  - MOV Sreg, r/m64(REX.W 8E) 메모리: 사용자 확인 대기 사례
  - RDMSR·WRMSRNS imm32: 도구 미지원으로 등록됨
  - SYSEXIT·SYSRET(0F 35, 0F 07): GNU가 SDM 철자를 "ambiguous operand size"로 거부한다. `sysretd`는 GNU만 받는다.
- **별칭 행 도달 24**: MOVQ/VMOVQ 메모리 별칭 opcode(`unreachable_forms.csv`의 그 행들). VMOVQ EVEX 2행은 GNU `{evex}`로 다른 EVEX 행이 나온다.
- 도달 불가(등록) 2: LAR r32, r64와 LSL r64, r32 레지스터 문법. 모르는 명령 1: UDB.
- 다른 인코딩 1: IRET(CF, 16비트 행)의 `iret`을 `cf`(IRETD)로 조립한다. 원문은 "most assemblers use the IRET mnemonic interchangeably for both operand sizes"라고 적는다. clang은 `66 cf`로 낸다.

### SDM과 맞지 않은 것 (clang)

- **모르는 명령 38**: MPX 전체, FRED(ERETS·ERETU), INT1, LKGS, UD0, UDB
- **거부 37**:
  - AVX512PF(VGATHERPF*/VSCATTERPF*) 16
  - MOVSXD r16·r32 8
  - CET CLRSSBSY·RSTORSSP의 `qword ptr` 6
  - MOV Sreg r/m64 3, RDMSR·WRMSRNS imm32 4
- **다른 행으로 수용 12**: CALL r/m16·r/m32(N.E.)와 JMP r/m16·r/m32(N.S.)를 먼 CALL·JMP m16:32(`FF /3`, `FF /5`)로 조립한다. 크기가 맞지 않는다(아래).
- **다른 인코딩 3**: PUSH imm16(`66 68 34 12 00 00`) 2케이스, XBEGIN rel16 1케이스. clang의 `data16`은 GNU와 달리 오퍼랜드 크기 지정이 아니라 0x66 한 바이트다. 따라서 이 케이스는 clang에 그 행을 지정하지 못한 것이다(아래 재점검).
- **별칭 행 도달 178**: 방향 쌍(8A/88 등)과 PUSH r/m 대 50+r 등이다. clang은 `{load}`/`{store}`를 받지 않는다.

### CPU 실행 (`--execute`, GNU 바이트, 레지스터 전용·이 CPU 지원 기능만)

exit0 1,954, SIGSEGV 89, SIGFPE 8, SIGTRAP 2, SIGILL 10.
SIGILL 10개는 모두 CPUID 칸이 비어 있는 명령이다(UD0/UD1/UD2, RSM, MONITOR/MWAIT, ERETS/ERETU, LKGS, LOCK 단독).
이 CPU의 사용자 모드에서 #UD가 나는 것으로 보고 기록만 했다. 실행 결과는 ISA 의미 확정이 아니다.

## 확인 범위와 한계

- 인코딩 대조는 `encoding_audit`가 읽는 필드(접두어·맵·opcode·ModRM 조건·꼬리 길이)만 본다. 레지스터 번호와 실행 의미는 대조하지 않는다.
- "SDM 일치(강제 접두어)"는 그 도구의 문서화된 의사 접두어로 표 행에 도달했다는 뜻이다. 접두어 없는 소스가 그 행을 고른다는 뜻은 아니다.
- 역어셈블 대조는 아래 4단계로 붙였다. 예전 5~13단계는 2026-10-11에 삭제했다.

## 역어셈블 대조 (4단계 `m4_disasm.py`, 2026-10-11)

재현: `python3 pipeline/run.py --only disasm` (실행 기록 `out/runs/20261010T223758310990Z.json`, 규칙 추가 후 `out/runs/20261011T001957084196Z.json`)

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
| SDM 일치 | 19,101 | 19,067 |
| SDM 일치(분기 대상 미대조) | 70 | 71 |
| SDM 일치(암묵 오퍼랜드 미대조) | 38 | 37 |
| SDM 일치(같은 opcode 표 행의 표기) | 0 | 1 |
| 니모닉 다름(도구 관례 철자) | 9 | 8 |
| 니모닉 다름 | 1 | 2 |
| 오퍼랜드 다름 | 25 | 17 |
| 오퍼랜드 다름(먼 포인터 표시 없음) | 0 | 6 |
| 디코드 실패 | 0 | 35 |

### SDM과 다른 것

- **두 역어셈블러 공통**
  - SDM이 r/m16이라 적은 레지스터 형식을 32비트 이름으로 출력한다: MOV Sreg, r/m16(`mov es, ecx`), MOVSXD r16, r/m16(`edx`). objdump는 LLDT·LTR·VERR·VERW·LKGS도 그렇다.
  - LAR·LSL: 표 문법 "LAR r32, r64/m16"(REX.W)의 목적지를 objdump·LLVM 모두 rcx로 출력한다(표 문법 자체가 기존 재심 D절 사례). LLVM은 LAR/LSL r32/m16 레지스터를 `dx`로 출력한다.
- **objdump**
  - m16:64(10바이트 먼 포인터)를 FWORD(6바이트)로 출력한다: LSS·LFS·LGS r64, m16:64, CALL·JMP m16:64.
  - XLATB(REX.W D7)를 `rex.W xlat`로 출력한다.
  - 도구 관례 철자: movabs(MOV r64, imm64), pushw, sysretd, sysexitd, xbeginw, leavew, iretw
- **LLVM**
  - 디코드 실패 35: MPX(BND*) 전부, LKGS, UD0, INT1
  - ERETS·ERETU(F2/F3 0F 01 CA)를 `clac`로 출력한다(접두어를 무시함).
  - CLRSSBSY·RSTORSSP m64를 `dword ptr`로 출력한다(clang은 같은 명령의 `qword ptr` 입력도 거부했다).
  - 먼 CALL·JMP m16:32(`FF /3`, `FF /5`)를 `call [rax]`, `jmp [rax]`로 출력한다. 크기 표기도 l 접두 철자도 없어 가까운 분기 텍스트가 된다(clang으로 다시 조립하면 `ff 10`). 2026-10-11 규칙 추가로 잡았다.
  - 도구 관례 철자: lcall·ljmp(먼 메모리 분기, 크기 표기 없음), fcompi·fucompi, movabs

## 남은 불일치 확인 (2026-10-11)

3단계에서 SDM 일치가 아닌 케이스를 하나씩 다시 조립·역어셈블해 확인했다. 재현 명령은 GNU `as --64 -mintel64`(3단계와 같음), `clang --target=x86_64-linux-gnu`이다.
판정 규칙 두 가지를 고쳤다(3단계 `다른 행으로 수용`, 4단계 `먼 포인터 표시 없음`). 실행 기록 `out/runs/20261011T001957084196Z.json`(3·4단계), `out/runs/20261011T002944228373Z.json`(3단계 `--execute`, CPU 관측 수치는 이전과 같음).

### 버그 후보 원문 재점검 (2026-10-11)

후보마다 SDM 원문(Vol.1·Vol.2 093판, 쪽은 PDF 파일 쪽)으로 테스트 케이스가 맞게 만들어졌는지 다시 봤다.

| 후보 | 원문 근거 | 케이스 점검 | 결론 |
|---|---|---|---|
| clang `data16 push 0x1234` → `66 68 34 12 00 00` | PUSH 표 `68 iw PUSH imm16` Valid(1225쪽). Description: "Operand size ... may be overridden by instruction prefixes (66H or REX.W)". Vol.1 Table 3-4(83쪽, 인쇄 3-19): 64비트 모드에서 66H·REX.W=0이면 유효 오퍼랜드 크기 16. iw = 2바이트 즉시값(SYM008, 102쪽). 기대 바이트 `66 68 iw`는 원문과 맞다. | 소스 철자 `data16`은 SDM이 아니라 GNU 문서의 접두어다("data16 ... change 32-bit operands ... into 16-bit operands", binutils 2.42 i386-Prefixes). clang의 `data16`은 0x66 한 바이트를 따로 낸다: `data16 pushw $0x1234` → `66 66 68 34 12`(GNU는 "same type of prefix used twice"로 거부). | **후보 철회.** 케이스가 clang에 PUSH imm16을 지정하지 못했다. clang은 AT&T `pushw $0x1234` → `66 68 34 12`로 맞게 낸다. Intel 문법에서는 맞는 철자를 찾지 못했다(`pushw` 모름, `push word ptr 0x1234` → `68 34 12 00 00`). → 도구 철자 미지원. |
| clang `data16 xbegin` → `66 c7 f8` + 4바이트 | XBEGIN 표 `C7 F8 XBEGIN rel16` V/V(2276쪽). Operation: 64비트 모드에서 "IF OperandSize = 16 THEN fallbackRIP := RIP + SignExtend64(rel16)". rel16 = 오퍼랜드 크기 16(SYM024). 기대 바이트 `66 C7 F8 cw`는 원문과 맞다. | 위와 같은 `data16` 문제. clang은 Intel·AT&T 모두 rel16을 지정할 철자가 없다(`xbeginw` 모름). | **후보 철회.** clang 도구 미지원 형식으로 분류. |
| clang `call word ptr [rax]`·`call dword ptr [rax]` → `ff 18` | CALL 표: r/m16·r/m32 N.E., r/m64 Valid(239쪽). 240쪽: "When in 64-bit mode, the operand size for near call ... is forced to 64-bits". 먼 포인터는 "a 4-byte (16-bit operand size) or 6-byte (32-bit operand size) far address"(240쪽). | 케이스 `call word ptr [rax]`(r/m16, SYM036), `call dword ptr [rax]`(r/m32, SYM037)는 표 문법과 맞고 기대 결과 reject도 맞다. clang 바이트 `FF /3`(66 없음) = CALL m16:32, 6바이트 포인터를 읽는다. | **후보 유지.** 소스 크기(2·4바이트)와 원문의 m16:32 폭(6바이트)이 다르다. GNU의 `call dword ptr` → `66 FF /3`(m16:16, 4바이트)는 원문 크기와 맞는다. |
| LLVM 역어셈블러 `ff 18` → `call [rax]` | CALL m16:32 `FF /3`, 가까운 CALL r/m64 `FF /2`(239쪽). 두 행은 니모닉이 같고 오퍼랜드 종류로만 구별된다. | 케이스 `call fword ptr [rax]`(m16:32 = 6바이트, 240쪽)는 원문과 맞다. | **후보 유지(성격 정정).** SDM은 Intel 문법의 크기 키워드를 정하지 않으므로 SDM 위반이 아니다. LLVM 자신의 문법에서 가까운 호출 텍스트가 되는 것이 문제다(clang이 `ff 10`으로 다시 조립). 같은 LLVM이 m16:16·m16:64는 `lcall`로 출력해 m16:32만 구별이 없다. |
| clang CLRSSBSY·RSTORSSP `qword ptr` 거부 | CLRSSBSY `F3 0F AE /6 CLRSSBSY m64`(268쪽), Operation `shadow_stack_lock_cmpxchg8b`. RSTORSSP `RSTORSSP m64`(1301쪽), Operation "Locked shadow_stack_load 8 bytes". m64 = 메모리 쿼드워드(SYM044). | 케이스 `qword ptr [rax]`는 원문과 맞다. | **후보 유지.** clang은 `dword ptr`만 받고, LLVM 역어셈블러도 dword로 출력한다. 바이트는 같다. |
| clang Intel 문법 AVX512PF 거부 | `VGATHERPF0DPS vm32z {k1}` 등(2375쪽, Xeon Phi 전용 장). vm32z = ZMM 32비트 인덱스 VSIB(SYM075). | 케이스 `vgatherpf0dps [rax+zmm0] {k1}`는 원문 오퍼랜드 순서·인덱스 레지스터·마스크와 맞다. GNU는 이 문법을 받는다. | **후보 유지.** clang은 Intel 문법의 모든 철자를 거부하고 AT&T는 받는다. LLVM 역어셈블러 출력(`{k1}, zmmword ptr [...]`)도 clang이 읽지 못한다. |

점검 중 발견한 판정 기준의 한계는 아래 절에서 고쳤다.

### 남은 버그 후보의 LLVM 이슈 확인 (2026-10-12)

LLVM 이슈 트래커와 llvm-bugs 목록을 검색했다(GitHub API, 웹 검색). 상태는 2026-10-12에 확인한 것이다.

| 후보 | 기존 보고 | 상태 |
|---|---|---|
| clang `call/jmp word·dword ptr [rax]` → 먼 호출 `ff 18`/`ff 28` | [#88516](https://github.com/llvm/llvm-project/issues/88516) "[x86] Assembler syntax check bugs"(2024-04, clang 16): `call BYTE/WORD/DWORD/XMMWORD PTR [RAX]`가 모두 `FWORD PTR`로 조립됨. [#95232](https://github.com/llvm/llvm-project/issues/95232) Case 2: `call WORD PTR [RAX]` → `call FWORD PTR`. | 둘 다 열림, 담당자·수정 PR 없음. **알려진 문제** |
| clang CLRSSBSY·RSTORSSP `qword ptr` 거부, `dword ptr` 수용 | [#95232](https://github.com/llvm/llvm-project/issues/95232) "[Clang] Allows incorrect memory size directive."(2024-06) Case 1이 같은 두 명령. #88516 목록에도 있음. | 열림. **알려진 문제** |
| LLVM 역어셈블러 `ff 18` → Intel 문법 `call [rax]` | 찾지 못함. 관련: [#59038](https://github.com/llvm/llvm-project/issues/59038)(Intel 문법 간접 분기 조립 문제, 2023-08 닫힘, 역어셈블 출력은 다루지 않음), [D35846](https://marc.info/?l=llvm-commits&m=150211659720112&w=2)(FWORD로 먼 분기를 고르게 한 조립 쪽 수정) | **보고 없음(검색 범위 안)**. 같은 바이트를 AT&T 문법으로는 `lcalll *(%rax)`로 출력한다. Intel 문법 출력에서만 먼 호출 표시가 없다. |
| clang Intel 문법 AVX512PF 거부 | 찾지 못함. LLVM 19 릴리스 노트: AVX512PF 등 knl/knm 전용 내장 함수는 제거하고 "assembly encoding/decoding supports are kept". LLVM MC 시험에는 AT&T 시험(`llvm/test/MC/X86/avx512pf-64-att.s`)만 있고 Intel 문법 시험은 없다. | **보고 없음(검색 범위 안)**. Intel 문법 파서가 시험되지 않은 경로로 보인다(추정). |

- 시험한 도구는 clang/LLVM 18.1.3 하나다. 최신 LLVM에서 고쳐졌는지는 확인하지 않았다(로컬에 18만 있음).
- "보고 없음"은 위 검색어로 찾지 못했다는 뜻이다. 없다는 확인은 아니다.

### 66H 오퍼랜드 크기 접두어 대조 (2026-10-11 추가)

- 결함: 3단계 인코딩 대조가 레거시 16비트 행의 66H를 확인하지 않았다. 예: `01 d1`(ADD r/m32, r32)도 ADD r/m16, r16과 맞는 것으로 나왔다.
- 규칙(`pipeline/operand_size_prefix.py`, 485행):
  - 근거: Vol.1 Table 3-4(83쪽), Vol.2 2.2.1.7(42쪽)
  - 같은 opcode 칸(REX.W 없음)의 행들이 오퍼랜드 크기로만 갈리면, 16비트 행은 66H 필수, 32·64비트 행은 66H 없음이다.
  - 크기는 오퍼랜드 기호(r16↔r32, r/m16↔r/m32·r/m64, AX↔EAX, imm16↔imm32, m16:16↔m16:32 …)로 읽는다. 오퍼랜드 없는 행(CBW/CWDE, MOVSW/MOVSD, PUSHF/PUSHFQ, LEAVE)은 Description 칸에서 처음 나오는 크기 표현으로 읽는다.
  - 짝 행이 없는 고정 16비트 행(ENTER, RET imm16, LLDT, LTR, VERR 등)은 66이 인코딩 요소가 아니므로 대상이 아니다. opcode 칸에 66이 필수 접두어로 적힌 행도 대상이 아니다.
- 이전 수정본(66 미확인)과 비교한 결과:
  - 앞의 수동 점검에서 "숨은 오류 0건"이라고 적었는데, 그 점검은 오퍼랜드 없는 행을 빠뜨렸다.
  - 실제로는 PUSHF·POPF·LEAVE·IRET의 16비트 행 7케이스가 66 없이 SDM 일치로 세어져 있었다.
- 원인: 도구 잘못이 아니라 케이스 철자였다.
  - 원문이 니모닉만으로 16비트가 정해지지 않는다고 적는다. PUSHF·POPF "Others may treat these mnemonics as synonyms", IRET "most assemblers use the IRET mnemonic interchangeably", LEAVE는 세 행의 문법이 같다.
  - 생성 철자를 `pushfw`, `popfw`, `data16 leave`로 바꿨다(두 도구가 `66` 접두어로 조립, case_rules.OPERANDLESS_16BIT_SPELLINGS).
  - IRET은 SDM 니모닉 `iret`을 둔다. clang은 `66 cf`, GNU는 `cf`이고 GNU의 `iretw`는 clang이 모른다.
- 실행 기록: `out/runs/20261011T050433482798Z.json`(3·4단계, `--execute`), `out/runs/20261011T051430091154Z.json`(4단계 leavew·iretw 철자 추가)

### SDM과 맞게 설명되는 것

- **GNU CALL·JMP r/m32 → `66 FF /3`**: ModRM 18 = /3이므로 먼 호출이다. 66 접두어로 m16:16(2+2바이트 = dword)이 되어 소스 크기와 맞는다. 표 행 CALL m16:16(Valid, 239쪽)이다. 소스 문법이 무효 행(CALL r/m32, N.E.)과 유효 행 양쪽에 맞는다. `-mintel64`에서는 `call word ptr [rax]`를 거부하는데, 이것은 SDM(CALL r/m16 N.E., 239쪽)과 맞는다. 기본(AMD64) 모드에서는 `66 ff 10`으로 받는다.
- **GNU MPX r/m32 메모리**: `byte`·`word`·`dword`·`qword`·크기 없음을 모두 `F3 0F 1A /r`로 받는다. 64비트 모드에서 이 바이트는 BNDCL r/m64 행이다. BNDCL은 메모리 내용이 아니라 주소를 비교하므로(208쪽 "Compare the address in the second operand") 바이트에는 크기가 드러나지 않는다. 크기 키워드를 검사하지 않는 관대함이다. r32 레지스터 형식은 거부한다(SDM과 맞음).
- **GNU SYSRET·SYSEXIT(0F 07, 0F 35)**: SDM 철자 `sysret`을 "ambiguous operand size"로 거부하고 `sysretd`(SDM에 없는 철자)를 요구한다. clang은 `sysret`을 받고 `sysretd`를 모른다. 바이트 문제가 아니라 철자 요구다.

### 도구가 형식을 지원하지 않는 것

- clang: MPX 전체, ERETS·ERETU, INT1, LKGS, UD0, UDB(모르는 명령), MOVSXD r16·r32(GNU는 받음)
- clang: PUSH imm16의 Intel 문법 철자, XBEGIN rel16(두 문법 모두). 3단계의 `다른 인코딩` 3케이스는 clang의 `data16`이 0x66 한 바이트를 따로 내기 때문이다(위 재점검).
- 두 도구: RDMSR·WRMSRNS imm32, UDB(GNU), LAR r32, r64 / LSL r64, r32 표 문법(등록)

### 도구 문법으로 표 행을 고를 수 없는 것 (별칭 행 도달)

- clang 178: `{load}`/`{store}`/`rex64`가 없어 같은 문법의 다른 opcode(방향 쌍 02/00, 8A/88, MOVAPS 29/28, C6/B0, 8F/58, FF /6 대 50, PEXTRW 3A 15 대 C5)나
  의미 없는 REX.W(MOV r64/m16, Sreg 메모리, SMSW 메모리, XLATB)를 고를 수 없다. GNU는 의사 접두어로 모두 도달했다.
- 두 도구: MOVQ/VMOVQ 메모리 별칭 opcode 24(등록 사례)

### 아직 판단하지 않은 것

- MOV Sreg, r/m64 메모리(REX.W 8E): 원문은 "Move lower 16 bits of r/m64 to segment register"(731쪽)이다. 두 도구 모두 `qword ptr`를 거부한다. 메모리에서 읽는 폭의 근거가 없어 기존대로 미확인으로 둔다.

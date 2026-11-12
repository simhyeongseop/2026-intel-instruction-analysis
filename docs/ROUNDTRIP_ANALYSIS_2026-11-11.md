# 왕복 차이 원인 분석 — 매뉴얼 조회·바이트·CPU 관측 (2026-11-11 라운드)

분류표: [ROUNDTRIP_DIFF_CLASSES_2026-11-11.md](ROUNDTRIP_DIFF_CLASSES_2026-11-11.md). 이 문서는 그 표의 '왜'를 적는다.
매뉴얼 원문은 `scripts/manual_lookup.py`(SDM Vol.2 325383-093US, 색인 `out/manual_index/`)로 조회했고, 인용 쪽수는
'파일 쪽/인쇄 쪽'이다. 원문으로 정할 수 없는 것은 바이트를 직접 보고, 그래도 남으면 CPU에서 관측했다(관측 CPU 1종).

## 0. 미대조는 교수님 지시(외부 기호)를 적용하지 않은 것인가 — 아니다

- 교수님 지시 ①(상대 주소는 정의하지 않은 외부 라벨로 조립해 재배치 0 자리로 비교)은 적용되어 있다. 외부 기호(`ext_target`)
  분기 104건(경로마다)은 **모두 대조됐고 b0–b1·as1–as2가 전부 같다**(재배치 위치·종류·addend 포함). as0–as2 '다름' 44~46건은
  `jc` → `jb` 같은 조건 코드 별칭과 LLVM AT&T `call` → `callq` 크기 글자뿐이다.
- 미대조 104건은 그와 별도로 남긴 **같은 파일 라벨(`.Ltarget`) 변형**이다. 외부 기호는 어셈블러가 항상 rel32(`0F 8x cd`,
  `E8 cd`)로 조립하므로 `Jcc rel8`(`7x cb`) 행에 닿을 수 없어, rel8 행용으로 남겼다(2026-11-11 설계, `case_rules.py`).
  rel8 36, rel16 34, rel32 34. 5단계는 역어셈블 출력이 숫자 주소(`ja 0x0`, llvm-mc는 변위 `ja -2`)라 다시 조립하면
  다른 대상이 되므로 비교하지 않았다.
- 추가 확인(`scripts/check_ltarget_roundtrip.py`, 결과 `roundtrip_chain/ltarget_check.csv`): 출력의 숫자를 대상 주소로
  바꿔 `.Ltarget+주소`로 되돌린 뒤 같은 위치에서 다시 조립했다. **4경로 × 104 = 416건 모두 b0–b1 같음, as1–as2 같음.**
  즉 미대조였던 상대 분기에도 왕복 불일치는 없다. (반례 시험: 대상을 1 틀리게 되돌리면 '다름'이 나오는 것 확인.)
- 3단계에서 `rel16` 34건은 33건이 '시험 불가(별칭)', 1건이 '별칭 행 도달'이다. 64비트 모드에서 rel16은 N.S.라 rel32로
  조립된다(왕복 문제와 별개).

## 1. 바이트가 달라지는 사례(왕복 b0–b1 다름 + AT&T 소스가 다른 바이트)

### 1-1. LLVM 메모리 간접 CALL/JMP — 의미 다름(가까운↔먼 분기, 읽는 크기)

| 행(SDM) | Intel 소스 | GNU as | clang(b0) | llvm-mc Intel as1 | b1 | 건수 |
|---|---|---|---|---|---|---|
| CALL r/m16 `FF /2`, 64비트 **N.E.** | `call word ptr [rax]` | 거부 | `FF 18`(m16:32) | `call [rax]` | `FF 10` | 23 |
| CALL r/m32 `FF /2` N.E. / m16:16 `FF /3` | `call dword ptr [rax]` | `66 FF 18` | `FF 18` | `call [rax]` | `FF 10` | 22+24 |
| CALL m16:32 `FF /3` | `call fword ptr [rax]` | `FF 18` | `FF 18` ✓ | `call [rax]` | `FF 10` | 25 |
| CALL m16:64 `REX.W FF /3` | `call tbyte ptr [rax]` | `48 FF 18` | `FF 18` | `call [rax]` | `FF 10` | 25 |
| JMP 같은 5행(`/4`, `/5`) | `jmp ... ptr [rax]` | 같은 양상 | `FF 28` | `jmp [rax]` | `FF 20` | 121 |

매뉴얼(CALL, 파일 239쪽/인쇄 3-121 표, 3-124 "Near/(Far) Calls in 64-bit Mode"):
- r/m16·r/m32 가까운 간접은 64비트에서 N.E.이고 "the operand size for near call ... is forced to 64-bits".
- 먼 간접은 "memory location (m16:16, m16:32 or m16:64) ... The operand-size attribute determines the size of the offset
  (16, 32, or 64 bits)". 즉 크기 표기가 4/6/10바이트 포인터를 고르고, 66/REX.W가 그 차이를 인코딩한다.

원인이 두 군데다(도구 직접 실행으로 재현, LLVM 23.1.3):
1. **clang Intel 어셈블러(입력 쪽)**: 크기 표기와 무관하게 모두 `FF /3`·`/5`(m16:32)로 조립한다. `word ptr`(N.E. 행)도 받는다.
   같은 LLVM의 AT&T 파서는 `lcallw/lcalll/lcallq`를 `66 FF 18`/`FF 18`/`48 FF 18`로 구분하고 `callw *(%rax)`는
   "requires: Not 64-bit mode"로 거부한다(매뉴얼과 일치). → AT&T 경로 as0–as2의 'AT&T 소스는 다른 바이트' 144건,
   'AT&T 소스 거부' 48건이 이것이다.
2. **llvm-mc Intel 출력(역어셈블 쪽)**: `FF 18`을 크기·far 표시 없이 `call [rax]`로 쓴다(`66 FF 18`, `48 FF 18`은
   `lcall [rax]`). `call [rax]`는 가까운 간접 `FF /2`로 다시 조립된다. AT&T 출력 `lcalll *(%rax)`는 정상 왕복한다.
   → SDM과 일치하게 조립된 m16:32 50건(CALL·JMP)도 Intel 왕복에서 먼 분기가 가까운 분기로 바뀐다.

의미: b0는 먼 분기(메모리에서 6바이트 포인터를 읽어 CS까지 바꿈), b1은 가까운 분기(8바이트 주소, CS 그대로). 매뉴얼만으로
다른 명령임이 확정된다. 11월 4일 사용자 결정대로 오류 분류(기존 LLVM #88516 계열) 유지.

### 1-2. LLVM Intel PUSHF/POPF 16비트 — 의미 다름(스택 2바이트↔8바이트)

`pushfw` → b0 `66 9C` → llvm-mc Intel `pushf` → b1 `9C`(`pushfq`). POPF 같은 양상. 각 1건.

매뉴얼(PUSHF, Description): "The PUSHF ... is intended for use when the operand-size attribute is 16 ... Some assemblers may
force the operand size to 16 when PUSHF is used ... Others may treat these mnemonics as synonyms ... and use the current
setting of the operand-size attribute". 64비트 기본은 RSP를 8 감소, "16-bit operation is supported using ... 66H".
→ 매뉴얼 표의 `PUSHF` 행은 16비트 뜻인데, 어셈블러는 별칭으로 써도 된다고 매뉴얼이 허용한다. LLVM은 출력에서는 16비트
뜻으로 `pushf`를 쓰고, 입력에서는 별칭(기본 64비트)으로 받는다. 같은 도구 안의 해석이 어긋나서 생기는 문제다. GNU objdump는
`66 9C`를 `pushfw`로 출력해 왕복이 맞는다.
CPU 관측: `66 9C` RSP −2, `9C` RSP −8. 동작이 다르다.

### 1-3. VPCMP{B,W,D,Q} 술어 0 — 동작 같음, opcode만 다름

`vpcmpb k0, xmm0, xmm1, 0` → b0 `EVEX 0F3A 3F /r ib(00)` → 출력 `vpcmpeqb` → b1 `EVEX 0F 74 /r`. 두 계열·두 경로 모두 12건.

매뉴얼: VPCMPB 절 Table 5-19 "Pseudo-Op and VPCMP* Implementation: `VPCMPEQ* reg1, reg2, reg3` = `VPCMP* reg1, reg2,
reg3, 0`"(파일 1927쪽/5-457). 그런데 `VPCMPEQB`는 PCMPEQB 절에 자기 opcode(`EVEX 0F 74`, D/W/Q는 76/75/`0F38 29`)를 가진
별도 명령이기도 하다. 의사 명령 이름이 실제 명령 이름과 같아서, 역어셈블러가 의사 명령 이름으로 출력하면 다시 조립할 때
전용 opcode가 선택된다. 두 절의 Operation은 같은 식이다(`CMP := SRC1 == SRC2`, 쓰기 마스크 밖은 0, `DEST[MAX_KL-1:KL] := 0`).
부호 있음/없음은 '같음' 비교에 영향이 없다. → 동작 같음(매뉴얼 Operation 기준. 관측 CPU가 AVX-512 미지원이라 실행 확인 없음).

### 1-4. MOV Sreg와 세그먼트 PUSH/POP·IRET — LLVM Intel 파서와 AT&T 파서가 같은 소스를 다르게 조립

| 소스(Intel / AT&T) | GNU as(두 문법) | clang Intel | clang AT&T | 동작 차이 |
|---|---|---|---|---|
| `mov es, cx` / `mov %cx,%es` | `8E C1` | `66 8E C1` | `8E C1` | **같음** |
| `mov cx, es` / `mov %es,%cx` | `66 8C C1` | `8C C1` | `66 8C C1` | **다름**(RCX 상위 비트) |
| `push fs` / `push %fs` (gs 같음) | `0F A0` | `66 0F A0` | `0F A0` | **다름**(스택 2↔8) |
| `pop fs` / `pop %fs` (gs 같음) | `0F A1` | `66 0F A1` | `0F A1` | **다름**(스택 2↔8) |
| `iret` / `iret` | `CF` | `66 CF` | `CF` | **다름**(16↔32비트 프레임) |

이 표는 왕복(b0–b1) 차이가 아니라 AT&T 경로의 as0(AT&T 소스)가 b0와 다른 바이트로 조립되는 경우다(LLVM 14건: 8C 5, POP FS·GS 6, PUSH FS·GS 2, IRET 1).
LLVM AT&T 경로의 MOV Sreg 2건(`66 8E C1` → `movw %cx,%es` → `8E C1`)만 왕복 차이로 나타났다.

- `MOV Sreg, r/m16`(8E): 매뉴얼 행이 r/m16 하나이고 64비트 행은 "Move lower 16 bits of r/m64". 66이 있든 없든 하위 16비트를
  읽는다. CPU 관측: RCX = `0xdeadbeefcafe0000 | SS 선택자(0x2b)`로 `8E C1`/`66 8E C1` 실행 → 두 경우 모두 ES = 0x2b.
  **표기·접두어 차이, 동작 같음.**
- `MOV r, Sreg`(8C): 매뉴얼 표에 `8C /r MOV r/m16, Sreg`와 `8C /r MOV r16/r32/m16, Sreg`가 함께 있어 표만으로는 66 유무가
  구분되지 않는다. 본문은 "The upper bits of the destination register are zero for ... all Intel 64 processors"(파일 732쪽)라고
  적어 16비트 형식에도 적용되는지 모호하다. CPU 관측(RCX = −1에서 시작): `8C C1` 후 RCX = `0x0000000000000000`,
  `66 8C C1` 후 RCX = `0xffffffffffff0000`. **소스가 `cx`인데 clang Intel의 `8C C1`은 RCX 전체를 바꾼다. 동작 다름.**
  3단계는 처음에 'SDM 일치'(r16/r32 행)로 판정했다. 표 행만 보고 판정해 이 차이를 놓친 것이라 판정 규칙을 고쳤다(2-2절).
- `PUSH FS`/`POP FS`: 매뉴얼 PUSH 본문 "The operand size (16, 32, or 64 bits) determines the amount by which the stack pointer
  is decremented (2, 4 or 8)", 64비트 기본은 64. POP FS는 같은 opcode로 16/32/64비트 증가 세 행이다. Intel 문법 `push fs`에는
  크기가 없으므로 어느 쪽이든 매뉴얼 행과 맞지만, clang Intel만 기본이 아닌 16비트를 고른다. CPU 관측: `66 0F A0` RSP −2,
  `0F A0` RSP −8.
- `IRET`: 매뉴얼 표 `CF IRET (16-bit operand size)`, `CF IRETD (32-bit)`, 본문 "most assemblers use the IRET mnemonic
  interchangeably for both operand sizes", 64비트 기본 32. clang Intel은 표 그대로 16비트(`66 CF`), GNU와 clang AT&T는
  기본 크기(`CF`)다. 매뉴얼이 두 해석을 모두 인정하므로 도구 오류로 확정하지 않는다. Intel 철자 `iret` 자체가 도구마다 뜻이
  달라 AT&T 변환으로는 맞출 수 없다(GNU Intel `iret`은 `CF`). 위험 분석과 CPU 관측은 [SIZE_MNEMONIC_RISK_2026-11-11.md](SIZE_MNEMONIC_RISK_2026-11-11.md).

### 1-5. GNU Intel 재조립 거부 87건 — objdump가 m16:64를 FWORD로 출력

| 행 | b0 | objdump Intel as1 | GNU as |
|---|---|---|---|
| LSS/LFS/LGS r64, m16:64 (`REX.W 0F B2/B4/B5`) 78건 | `48 0F B2 08` | `lss rcx,FWORD PTR [rax]` | `incorrect register 'rcx' used with 'l' suffix` |
| CALL/JMP m16:64, 확장 기준 레지스터 9건 | `49 FF 1C 24` | `rex.WB call FWORD PTR [r12]` | `same type of prefix used twice` |

매뉴얼(LSS, Description): "Using a REX prefix in the form of REX.W promotes operation to specify a source operand referencing
an 80-bit pointer (16-bit selector, 64-bit offset)". FWORD는 48비트(m16:32)다. objdump가 m16:64를 FWORD로 표기하는 것이
매뉴얼과 다르고, GNU as가 r64 + FWORD를 거부하는 것은 매뉴얼에 맞다. `lss rcx, TBYTE PTR [rax]`는 `48 0F B2 08`로 조립된다
(직접 확인). 먼 CALL/JMP는 objdump가 같은 FWORD 표기에 `rex.W`를 접두어로 따로 붙여 바이트를 보존한다. 기준이 `[rax]`면
다시 조립되지만, `[r12]`처럼 REX.B가 필요하면 as가 붙이는 REX와 텍스트의 `rex.WB`가 겹쳐 거부된다. 의미 판정은 b0
그대로다(도구가 텍스트를 받지 못해 비교하지 못한 것). 11월 4일 사용자 결정대로 오류 분류 유지.

## 2. as0–as2 '다름'(표기 차이)의 의미 확인

판정 기준(`classify_roundtrip_diffs.py`의 `meaning` 열): as1 → b1 = b0이고 as2 = as1이면 as2도 그 도구에서 b0로 조립된다.
Intel 경로의 as0는 b0를 만든 소스이므로 **as0와 as2는 같은 도구에서 같은 바이트 = 같은 기계 동작**이다. AT&T 경로는 as0
(AT&T 변환 소스)를 같은 도구로 따로 조립한 결과가 b0와 같아야 한다(3단계 `syntax_*`). as0가 SDM이 뜻하는 행으로 조립됐는지는
3단계 판정(`sdm_verdict` 열)의 문제이고 여기서 다루지 않는다.

| 경로 | as0–as2 다름 | 같은 바이트(동작 같음) | 그 밖 | 그 밖의 내용 |
|---|---|---|---|---|
| gnu AT&T | 11,177 | 11,125 | 52 | VPCMP 12, AT&T 소스 거부 40(정수→실수 변환 `{rn-sae}` 위치) |
| gnu Intel | 26,027 | 26,015 | 12 | VPCMP 12 |
| llvm AT&T | 73,226 | 73,006 | 220 | 1-1 CALL/JMP 192, 1-4 세그먼트·IRET 14, MOV Sreg 2, VPCMP 12 |
| llvm Intel | 76,247 | 75,991 | 256 | 1-1 CALL/JMP 242, PUSHF/POPF 2, VPCMP 12 |

(llvm AT&T '그 밖' 220 = 'AT&T 소스는 다른 바이트' 158 + 'AT&T 소스 거부' 48 + 왕복 바이트 다름 14.)

**결론: 표기 규칙으로 설명된 차이 186,137건은 모두 같은 바이트로 확인됐다. 동작이 같은 표기 차이로 분류한다.** 의미가 다르거나
확인이 필요한 540건은 모두 1절의 사례(또는 우리 AT&T 변환 문제)다. GNU AT&T 40건은 `vcvtsi2sd {rn-sae}, %rcx, ...`를 GNU
AT&T가 "misplaced `{rn-sae}`"로 거부한 것으로, 두 도구 모두 `%rcx, {rn-sae}, ...` 순서만 받는다. 우리 변환 규칙을 고쳤다
([ROUNDING_POSITION_2026-11-11.md](ROUNDING_POSITION_2026-11-11.md)).

### 2-1. 표기 차이가 생기는 위치(모두 as0 소스 표기 ↔ 역어셈블러 출력 표기)

숫자는 '같은 바이트' 건수(gnu AT&T / gnu Intel / llvm AT&T / llvm Intel). 한 케이스가 규칙 여러 개에 걸리면 각 규칙에서 센다.

| 위치 | 규칙 | 예 (as0 → as2) | 같은 바이트 | 매뉴얼·도구 근거 |
|---|---|---|---|---|
| 즉값·변위 | 숫자 진법 | `0x12` → `18` | 1,601 / 8,697 / 65,291 / 65,257 | 값 같음 |
| 즉값·변위 | 폭 감기 | `-0x1` → `0xff`, `[rip-0x80]` → `[rip+0xff..80]` | 967 / 8,099 / 1,818 / 1,818 | 같은 비트열(2의 보수) |
| 메모리 오퍼랜드 | 생략 변위 0 | `[rbp]` → `[rbp+0x0]` | 6,945 / 6,937 / 0 / 0 | rbp·r13 기준은 disp8=0 필수(ModRM 규칙) |
| 메모리 오퍼랜드 | 스케일 표기 | `[rax+rbx*8]` → `[rax + 8*rbx]`, `*1` 생략 | 0 / 160 / 4,151 / 23,056 | SIB 같음 |
| 메모리 오퍼랜드 | 크기·브로드캐스트 표기 | `[0x10]` → `XMMWORD PTR ds:0x10`, `{1to32}` → `BCST` | 0 / 6,870 / 0 / 880 | 도구 출력 관례 |
| 니모닉 | 조건 코드 별칭 | `jnb` → `jae`, `cmovng` → `cmovle` | 1,875 ×4 | SDM 표에서 같은 opcode 행(예: `73 cb JAE/JNB/JNC`) |
| 니모닉 | 니모닉 별칭 | `sal` → `shl`, `repne` → `repnz`, `fwait` → `wait` | 371 / 371 / 367 / 367 | SDM `SAL`·`SHL` 같은 `/4` 행 |
| 니모닉 | AT&T 크기 글자 | `bt $1,%ecx` → `btl` | 168 / 23 / 10,330 / 11 | GNU·LLVM AT&T 관례 |
| 니모닉 | 비교 술어 의사 명령 | `vcmpps ..,0x12` → `vcmple_oqps`, `pclmulqdq ..,0` → `pclmullqlqdq` | 592 ×4 | SDM CMPPS·PCLMULQDQ 의사 명령 표(술어만 바이트로 감) |
| 니모닉 | FWAIT 분리 | `fstsw ..` → `wait` + `fnstsw ..` | 0 / 0 / 103 / 103 | SDM `9B DD /7 FSTSW` = FWAIT(9B) + FNSTSW |
| 오퍼랜드 | 암묵·생략 오퍼랜드 | `fmulp` → `fmulp st(1),st` | 177 / 168 / 1,048 / 1,046 | SDM `DE C9 FMULP` = ST(1), ST(0) |
| 오퍼랜드 | x87 표기 | `st(0)` → `st` | 26 ×4 | 같은 레지스터 |
| 오퍼랜드 | XCHG 순서 | `xchg ecx,[r12]` → `xchg [r12],ecx` | 106 ×4 | SDM `XCHG r/m32, r32`와 `r32, r/m32` 같은 `87 /r` |
| 오퍼랜드 | 소스 두 오퍼랜드 순서 | `vandps ymm2,ymm4,ymm11` → `ymm2,ymm11,ymm4` | 0 / 0 / 47 / 47 | LLVM이 VEX2(2바이트)를 쓰려고 교환 가능한 연산의 피연산자를 바꿔 조립, b0부터 바뀜 |
| 오퍼랜드 | GPR 폭 | `pmovmskb rdx` → `edx`, `lldt cx` → `ecx` | 94 / 94 / 63 / 68 | 도구가 REX.W·66 없이 조립(b0 확인). W 무시 명령·r/m16만 읽는 명령 |
| 오퍼랜드 | 반올림·SAE 위치 | `zmm2, {ru-sae}` → `zmm2{ru-sae}` | 0 / 1,586 / 0 / 0 | EVEX.b·RC 같음 |
| 접두어 | 인코딩 표시 | `{evex} vpermpd`, `rex.w jmp` | 25 / 66 / 0 / 0 | objdump가 선택된 인코딩을 텍스트로 남김 |
| 오퍼랜드 | AT&T 포트 괄호 | `(%dx)` → `%dx` | 0 / 0 / 12 / 0 | 같은 포트 |
| 기타 | 규칙 밖 | `cbw` → `cbtw`, `movs` → `movsb es:[rdi]`, `xacquire` → `repnz`, `%dr0` → `%db0` | 41 / 34 / 68 / 66 | AT&T 확장 이름·같은 F2/F3 바이트 등. 바이트 같음 확인 |

'소스 두 오퍼랜드 순서'와 GPR 폭은 as0 텍스트를 도구가 조립 단계에서 바꾼 것이다. 동작은 같다(교환 가능 연산, W 무시·16비트만 읽음).
다만 'SDM 의도 행과 같은 바이트인가'는 3단계 판정 열에서 따로 본다.

## 2-2. 3단계 판정 수정(2026-11-11, 사용자 지시)

동작이 다른데 'SDM 일치'였던 판정을 고쳤다. 수정 코드와 근거:
- `pipeline/encoding_audit.py` `sreg_store_width`: `MOV r, Sreg`(8C /r)의 목적지가 범용 레지스터면 그 폭이 오퍼랜드 크기여야
  한다(r16 → 66H 필요, r32 → 66H·REX.W 없음, r64 → REX.W). 근거 Vol.1 Table 3-4와 CPU 관측(1-4절). 메모리 목적지와 반대 방향
  (8E)은 대상이 아니다(동작 같음).
- `pipeline/operand_size_prefix.py`: 문법이 같은 형제 행(POP FS/GS 16/32/64비트)은 Description의 "stack pointer by N bits"로
  가른다. 크기 행이 없는 PUSH FS/GS는 64비트 기본 크기 행으로 본다(66H 없어야 함). 바뀐 규칙은 이 8개 행뿐임을 확인했다.
- `pipeline/m3_check.py`: 별칭 행 도달 검사에서 64비트 N.E.·Invalid 행을 건너뛴다(기존 `valid_rows_reached`와 같은 기준).
  이것이 없으면 POP FS 16비트 행의 GNU `0F A1`이 N.E. 32비트 행에 '도달'한 것으로 나왔다. 기존 LEAVE 2건도 같은 결함이었다.
- 회귀: `tests/test_operand_size_prefix.py::SegmentRegisterSizeTest`(손으로 정한 기대값). 고치기 전 코드에서 세 시험이 실패함을 확인.
- 이번 라운드 재판정: `scripts/rejudge_check.py --mnemonics MOV POP PUSH LEAVE`(해당 케이스만 도구 재조립, 저장 바이트와 같은지
  확인). 원본은 `check_results.before_rejudge_20261111.csv`, 기록은 `rejudge_manifest.json`. 바뀐 것 13건:

| 케이스 | 도구 | 소스 | 바이트 | 이전 → 이후 |
|---|---|---|---|---|
| 1095-0, 1096-0 | clang | `mov cx, es` | `8C C1` | SDM 일치 → 다른 인코딩 |
| 1095-4, 1096-5, 1095-24 | clang | `mov r15w/r9w, es` | `41 8C C7/C1` | SDM 일치 → 다른 인코딩 |
| 2320-0, 2321-0 | clang | `push fs/gs` | `66 0F A0/A8` | SDM 일치 → 다른 인코딩 |
| 1986-0, 1989-0 (16비트 행) | GNU | `pop fs/gs` | `0F A1/A9` | SDM 일치 → 별칭 행 도달(64비트 행) |
| 1988-0, 1991-0 (64비트 행) | clang | `pop fs/gs` | `66 0F A1/A9` | SDM 일치 → 별칭 행 도달(16비트 행) |
| 1015-0 LEAVE | 둘 다 | `leave` | `C9` | 별칭 행 도달 1016(N.E.) → 1017 |

5단계 `roundtrip_results.csv`의 `sdm_verdict`도 같은 값으로 맞췄다(11행, 원본 `roundtrip_results.before_rejudge_20261111.csv`).

## 3. 정리(교수님 보고용)

| 구분 | 건수(4경로 합) | 원인 위치 | 동작 |
|---|---|---|---|
| 미대조 → 라벨 되돌려 대조 | 416 | 비교 방법(출력이 숫자 주소) | 전부 같은 바이트 |
| GNU 재조립 거부 | 87 | objdump 출력(m16:64를 FWORD로) | 비교 불가, 매뉴얼상 출력 오류 |
| LLVM CALL/JMP | 242(+AT&T 소스 192) | clang Intel 입력 + llvm-mc Intel 출력 | **다름**(먼↔가까운) |
| LLVM PUSHF/POPF | 2 | llvm-mc Intel 출력(`pushf` 뜻 엇갈림) | **다름**(스택 2↔8) |
| LLVM MOV Sreg(8E) | 2 | LLVM AT&T 입력이 66 제거 | 같음(CPU 관측) |
| LLVM `mov cx, es`·`push/pop fs·gs`·`iret` | 14 | clang Intel과 AT&T 파서 해석 차이 | **다름**(CPU 관측·매뉴얼) |
| VPCMP 술어 0 | 48 | 의사 명령 이름 = 실제 명령 이름 | 같음(Operation 동일) |
| GNU AT&T `{rn-sae}` 위치 | 40 | 우리 AT&T 변환 규칙(수정함) | 해당 없음(변환 소스 거부) |
| 표기 차이 | 186,137 | 소스 표기 ↔ 역어셈블러 출력 관례 | 같음(같은 바이트) |

## 재현

```bash
python3 scripts/classify_roundtrip_diffs.py          # diff_cases.csv에 meaning·sdm_verdict·syntax_check 열
python3 scripts/check_ltarget_roundtrip.py           # ltarget_check.csv (도구 실행)
python3 scripts/manual_lookup.py show CALL --part Description
python3 scripts/manual_lookup.py show VPCMPB --part Description
```

CPU 관측: 사용자 모드 C 프로그램으로 위 바이트만 `.byte`로 실행했다(Intel Xeon E5-2650 v4, Linux 5.4). 소스·출력·바이트 확인은
`out/round2_20261111/roundtrip_chain/cpu_observe/`(`seg.c`, `output.txt`, `bytes_check.txt`). 한 CPU 모델의 관측이며 ISA 전체 의미를 확정하는 근거로 쓰지 않는다. 먼 CALL/JMP·IRET는
실행하지 않았다(매뉴얼로 판정).

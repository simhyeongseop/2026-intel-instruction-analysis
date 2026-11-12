# 니모닉이 크기를 정하지 못하는 명령 — IRET 중심 위험 분석 (2026-11-11)

질문: 매뉴얼이 IRET 해석을 둘 다 허용한다면(어셈블러마다 다른 바이트), 그것이 버그나 취약점이 생기는 지점이 아닌가.
결론: **그렇다. 다만 '도구 버그'라기보다 같은 소스 한 줄이 도구에 따라 다른 기계 동작이 되는 '해석 차이(differential)'
지점이다.** 64비트 코드에서 `iret`이라고 쓰면 어느 도구로도 IRETQ가 되지 않고, CPU는 복귀 프레임을 다른 크기로 읽는다.
아래는 매뉴얼 근거 → 도구 관측 → CPU 관측 → 위험 시나리오 순서다. 커널 경로에서 실제로 악용 가능한지는 검증하지 않았다.

자료: `out/round2_20261111/size_mnemonics/`
- `probe_assemble.csv`(철자 × 도구 × 문법, `scripts/probe_size_mnemonics.py`), `probe_disasm.csv`(바이트 × 역어셈블러 × 문법과 재조립)
- `cpu_iret/`(`iret_observe.c`, `output.txt`, `bytes_check.txt`: 사용자 모드, 같은 권한 복귀만, Xeon E5-2650 v4)

## 1. 매뉴얼 근거

- 표(파일 608쪽): `CF IRET (16-bit operand size)`, `CF IRETD (32-bit)`, `REX.W + CF IRETQ (64-bit)`. 같은 opcode.
- 본문: "IRET and IRETD are mnemonics for the same opcode ... **most assemblers use the IRET mnemonic interchangeably for
  both operand sizes**." 64비트 모드 기본 크기는 32, REX.W면 64.
- Operation(파일 614~615쪽, IA-32e 같은 권한): 오퍼랜드 크기 16/32/64에 따라 `(E/R)IP, CS, FLAGS, (E/R)SP, SS`를 2/4/8바이트씩
  꺼낸다. 즉 프레임 크기가 10/20/40바이트로 달라진다. 인터럽트·예외가 64비트 모드에서 쌓는 프레임은 8바이트 항목이다.
- 같은 문구("Some assemblers may force ... Others may treat these mnemonics as synonyms")가 CBW/CWDE, CWD/CDQ, PUSHF/PUSHFD,
  POPF/POPFD, PUSHA/POPA(64비트 Invalid)에 있다. 표에 크기 행이 없거나 같은 문법의 크기 행이 여럿인 PUSH/POP FS·GS,
  RETF, `MOV r, Sreg`도 같은 성격이라 함께 보았다.

## 2. 도구 관측 — 같은 철자, 다른 바이트

| 철자 | GNU Intel | GNU AT&T | clang Intel | clang AT&T | 비고 |
|---|---|---|---|---|---|
| `iret` | `CF`(32) | `CF`(32) | **`66 CF`(16)** | `CF`(32) | 어느 쪽도 64비트(IRETQ)가 아니다 |
| `iretw` | `66 CF` | `66 CF` | 거부(모르는 니모닉) | `66 CF` | clang Intel은 16비트를 `iret`로만 쓸 수 있다 |
| `iretd` / `iretl` | `CF` | `CF`(iretl) | `CF` | `CF`(iretl) | |
| `iretq` | `48 CF` | `48 CF` | `48 CF` | `48 CF` | 일치 |
| `push fs` / `push %fs` (gs 같음) | `0F A0`(64) | `0F A0` | **`66 0F A0`(16)** | `0F A0` | |
| `pop fs` / `pop %fs` (gs 같음) | `0F A1`(64) | `0F A1` | **`66 0F A1`(16)** | `0F A1` | |
| `mov cx, es` | `66 8C C1` | `66 8C C1` | **`8C C1`**(ECX 전체) | `66 8C C1` | 3단계 판정 수정(아래 4절) |
| `pushf`/`popf`, `cbw`/`cwde`, `cwd`/`cdq`, `retf`/`lret` | 일치 | 일치 | 일치 | 일치 | 두 도구 모두 PUSHF/POPF를 기본 크기(64) 별칭으로 처리 |

같은 소스 한 줄이 갈리는 것은 모두 **clang의 Intel 문법**에서다. clang AT&T와 GNU(두 문법)는 서로 같다.

역어셈블 쪽(`probe_disasm.csv`): **llvm-mc Intel 출력이 16비트 형식의 크기 표시를 빼서**, 서로 다른 바이트가 같은 텍스트가 된다.

| 바이트 | llvm-mc Intel 출력 | clang Intel 재조립 | 결과 |
|---|---|---|---|
| `66 9C` / `66 9D` | `pushf` / `popf` | `9C` / `9D` | 16 → 64비트 |
| `66 CB` | `retf` | `CB` | 16 → 32비트 먼 복귀 |
| `0F A0` / `0F A8` / `0F A1` / `0F A9` | `push fs` 등 | `66 0F A0` 등 | **64 → 16비트**(보통 코드가 깨진다) |
| `66 0F A0` 등 | `push fs` 등 | `66 0F A0` 등 | (같은 텍스트가 두 바이트를 뜻함) |
| `66 CF` / `CF` | `iret` / `iretd` | 같음 | LLVM 안에서는 왕복. 단 텍스트 `iret`을 GNU에 주면 `CF` |

GNU objdump는 `pushfw`, `retfw`, `iretw`, `pushw fs`처럼 크기를 적어 모든 경우 왕복한다.

## 3. CPU 관측 — 프레임 크기가 바뀌면 무엇을 읽는가

`cpu_iret/output.txt`(같은 권한 IRET만, 사용자 모드):

| 실행 | 결과 | 해석 |
|---|---|---|
| `48 CF` + 8바이트 항목 프레임 | 정상 복귀 | 기준 |
| `CF` + 4바이트 항목 프레임 | 정상 복귀 | 32비트 프레임으로 읽음 |
| `66 CF` + 2바이트 항목 프레임(IP=0x1234) | RIP=0x1234에서 페이지 결함 | 2바이트 칸의 값으로 실제 점프 |
| `CF` + **8바이트 항목 프레임** | #GP(0) at IRET | RIP 칸 상위 4바이트(0)를 CS로 읽음 |
| `66 CF` + **8바이트 항목 프레임** | #GP(0x40) at IRET | RIP 칸의 바이트 2~3(0x0040)을 CS 선택자로 읽음 |
| `CF` + RIP 칸에 `(0x33<<32)|EIP`를 넣은 8바이트 프레임 | **정상 복귀** | 같은 40바이트를 IRETQ로 읽으면 비정규 RIP(0x3300401259)인데 CF는 유효한 CS:EIP로 읽어 복귀 |

마지막 줄이 핵심이다. **프레임을 검증·작성한 쪽이 생각한 크기와 실제 IRET 크기가 다르면, 같은 스택 바이트에서 다른 CS·RIP·
RFLAGS·RSP·SS가 나온다.** 앞 칸의 상위 바이트가 다음 항목(CS 등)이 된다.

## 4. 위험 시나리오(분석, 실증 안 함)

1. **툴체인 이식**: 64비트 커널·하이퍼바이저·샌드박스 진입 코드가 Intel 문법으로 `iret`을 쓰면 GNU 빌드는 IRETD(20바이트
   프레임), clang Intel 빌드(`-masm=intel` 인라인 asm 등)는 16비트 IRET(10바이트)가 된다. 어느 쪽도 하드웨어가 쌓는 40바이트
   프레임과 맞지 않는다. 한 툴체인에서 '동작'(예: 우연히 결함 경로가 안 타짐)한 코드가 다른 툴체인에서 다른 프레임 해석이 된다.
   올바른 철자는 `iretq` 하나뿐이다(네 조합 모두 `48 CF`).
2. **프레임 값의 자리 이동**: 3절처럼 크기가 어긋나면 RIP 칸의 상위 비트가 CS가 되고, CS 칸이 FLAGS가 된다. 사용자 복귀 경로에서
   RIP 칸은 사용자 코드 주소(공격자가 정할 수 있는 값)다. 그러면 공격자가 정한 비트가 CS 선택자·FLAGS·RSP 자리로 들어가는 구조가
   된다. 실제로 권한 상승까지 이어지는지는 선택자 검사(RPL ≥ CPL), SS 검사, SMEP 등에 달려 있고, 여기서는 검증하지 않았다.
   IRET·SYSRET 복귀 경로는 과거에도 실제 취약점이 나온 곳이다(예: CVE-2012-0217 SYSRET 비정규 RIP, CVE-2014-9322 IRET 결함
   처리). 이번 관측은 그와 다른 원인(어셈블러 해석)으로 같은 경로의 프레임 해석이 바뀔 수 있음을 보인다.
3. **역어셈블 → 재조립(바이너리 패치·재작성·검증 도구)**: llvm-mc Intel 텍스트 `iret`(원래 `66 CF`)을 GNU로 다시 조립하면 `CF`,
   GNU 텍스트 `iret`(원래 `CF`)을 clang Intel로 다시 조립하면 `66 CF`가 된다. `push fs`는 LLVM 안에서도 `0F A0` → `66 0F A0`로
   바뀐다. 텍스트만 보면 같은 명령이라 사람이 검토해도 눈치채기 어렵다.
4. **스택 균형**: `push fs` … `pop fs`를 서로 다른 도구(또는 역어셈블 텍스트를 거친 코드)로 만들면 RSP가 6바이트 어긋나 복귀
   주소가 엉킨다. 같은 clang Intel로 둘 다 만들어도 RSP가 2바이트 단위로 움직여 ABI의 16바이트 정렬이 깨진다(CPU 관측: `66 0F A0`
   RSP −2, `0F A0` −8; `out/round2_20261111/roundtrip_chain/cpu_observe/`).

## 5. 이번 판정·분류 반영

- 3단계: 표 행 기준 판정만 하므로 `iret` 같은 철자의 '도구 간 차이'는 3단계 판정이 아니라 AT&T 대조(`syntax_*`)와 이 문서로 기록한다.
  IRET(16비트) 행에 대한 GNU `CF`는 이미 '다른 인코딩'이다. clang Intel의 `66 CF`는 그 행과 일치한다.
- `PUSH FS/GS`(표에 크기 행 없음)는 64비트 기본 크기 행으로 보고 66H를 받지 않게, `POP FS/GS`는 Description의 16/32/64비트로,
  `MOV r, Sreg`는 레지스터 목적지 폭으로 갈라 판정하게 고쳤다(`pipeline/operand_size_prefix.py`, `encoding_audit.py`). 결과는
  [ROUNDTRIP_ANALYSIS_2026-11-11.md](ROUNDTRIP_ANALYSIS_2026-11-11.md) 2-2절.
- 퍼징 도구용 제안(미구현): 이 절의 철자(`iret`, `push/pop fs·gs`, `pushf/popf`, `retf`, `mov r16, Sreg`)를 '도구 의존 크기'
  목록으로 두고, 검사 CLI가 경고를 내게 할 수 있다. 사용자 결정 필요.

## 6. 남은 것

- 커널 모드(CPL0) 복귀 경로에서의 영향은 실행하지 않았다. 가상 머신이 필요한데 현재 작업 환경은 컨테이너라 KVM이 없다
  (소프트웨어 에뮬레이션은 CPU 관측이 아니다). **다음 실험으로 넘긴다**(2026-11-11 사용자 결정). 다른 CPU 모델 관측 없음.
- AT&T 변환에서 `iret`을 `iretw`로 바꾸지 않는다(2026-11-11 사용자 결정). 매뉴얼이 두 해석을 허용하는 철자를 우리가 골라 주면
  실험 규칙에 어긋난다. 발표에는 '두 해석 허용 → 위험, 위험한 경우'로만 넣는다.
- LLVM 보고(Intel 문법 `iret`·`push fs`의 16비트 선택과 Intel 출력의 크기 표시 누락)는 교수님 보고 뒤에 정한다(사용자 결정).
  기존 이슈 검색 결과: 같은 내용의 열린 이슈는 찾지 못했다. `pushf/popf`의 같은 문제를 고친 선례 #31383이 있다. 원인(LLVM 정의에서
  크기 글자가 AT&T 문자열에만 있음)과 검색어는 [issues/llvm_existing_issue_search_2026-11-11.md](issues/llvm_existing_issue_search_2026-11-11.md).
- '도구 의존 크기' 경고(5절 제안)는 미결이다.

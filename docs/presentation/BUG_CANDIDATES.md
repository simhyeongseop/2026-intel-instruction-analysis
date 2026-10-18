# 버그 후보 3종 상세: SDM 표기, 관측, 버그로 본 이유 (2026-10-13)

대상 도구: clang/llvm-mc 23.1.3. 대조군: GNU as 2.47(`--64 -mintel64`), objdump 2.47.
근거 파일: `out/presentation_review_20261013/`(`probe_results.txt`, `llvm_23.1.3_bug_candidate_defs.txt`, XED 발췌), `out/avx512pf_review_20261012/`.
쪽 번호는 "PDF 파일 쪽 / 인쇄 쪽", SDM 093판 기준이다.

공통 전제: Intel 문법의 `byte/word/dword/qword ptr` 크기 표기는 SDM이 정한 문법이 아니라 도구 관례다.
SDM이 정하는 것은 기호(m64, r/m16, m16:32 등)의 크기와 의미다. 그래서 각 후보마다 "SDM 기호의 크기"와 "도구가 받는 크기 표기"가 어긋나는지를 본다.

---

## 1. CLRSSBSY · RSTORSSP: 64비트 메모리를 32비트로 정의 (clang 6케이스)

### SDM 표기

| 위치 | 원문 |
|---|---|
| 표 (Vol.2A 268 / 3-150) | `F3 0F AE /6` · `CLRSSBSY m64` · Op/En M · 64비트 모드 Valid |
| 표 (Vol.2B 1301 / 4-598) | `F3 0F 01 /5 (mod!=11, /5, memory only)` · `RSTORSSP m64` · Valid |
| 기호 정의 SYM044 (106 / 3-6) | "m64 — A memory quadword operand in memory." |
| Operand Encoding | `M: ModRM:r/m (r, w)` (메모리를 읽고 씀) |
| CLRSSBSY Description | "Clear busy flag in supervisor shadow stack token reference by m64." |
| CLRSSBSY Operation | "IF SSP_LA not aligned to 8 bytes THEN #GP(0)" (8바이트 토큰) |
| RSTORSSP Description | "Restores SSP from the shadow-stack-restore token pointed to by m64." |

Intel XED도 `MEM0:rw:q:u64`(64비트)로 정의한다.

### 관측

| 입력 | GNU as | clang |
|---|---|---|
| `clrssbsy qword ptr [rax]` | `f3 0f ae 30` | 거부 "invalid operand" |
| `clrssbsy dword ptr [rax]` | 거부 "operand size mismatch" | `f3 0f ae 30` |
| `rstorssp qword ptr [rax]` | `f3 0f 01 28` | 거부 |
| 역어셈블 `f3 0f ae 30` | objdump `QWORD PTR [rax]` | llvm-mc `dword ptr [rax]` |

### 버그로 본 이유

1. SDM 기호는 m64(쿼드워드)이고, 설명·동작(8바이트 정렬 토큰)도 64비트다.
2. clang은 64비트 표기를 거부하고 32비트 표기를 받는다. 역어셈블러도 32비트로 출력한다. 크기 판단이 SDM과 반대다.
3. 원인 위치: LLVM `X86InstrSystem.td` 556행 `RSTORSSP ... (ins i32mem:$src)`, 598행 `CLRSSBSY ... (ins i32mem:$src)`. 피연산자를 32비트 메모리로 정의했다.
4. 바이트 자체는 같다(크기 표기는 인코딩에 영향 없음). 잘못된 기계어를 만드는 버그가 아니라, 크기 검사와 출력이 틀린 버그다.

상태: LLVM #95232(2024-06)에 보고됨, 미해결. 수정 방향은 `i64mem`으로 바꾸는 것(빌드 검증 안 함).
근거 강도: **세 후보 중 가장 강함**. SDM 기호·설명·동작, XED가 모두 64비트다.

---

## 2. call · jmp `word ptr [m]`: 2바이트 메모리를 6바이트 먼 호출로 조립 (clang 6케이스)

### SDM 표기

| 위치 | 원문 |
|---|---|
| CALL 표 (Vol.2A 239 / 3-121) | `FF /2 CALL r/m16` **N.E.** · `FF /2 CALL r/m32` **N.E.** · `FF /2 CALL r/m64` Valid |
| | `FF /3 CALL m16:16` Valid · `FF /3 CALL m16:32` Valid · `REX.W FF /3 CALL m16:64` Valid |
| JMP 표 (Vol.2A 622 / 3-504) | `FF /4 JMP r/m16` **N.S.** ("Not supported in 64-bit mode") · `FF /5 JMP m16:16/m16:32` Valid |
| N.E. 정의 SYM094 (109 / 3-9) | "Indicates an instruction syntax is not encodable in 64-bit mode" |
| r/m16 정의 SYM036 | "A word general-purpose register or memory operand ... operand-size attribute is 16 bits" |
| m16:xx 정의 SYM046 | "A memory operand containing a far pointer composed of two numbers" (selector:offset) |
| CALL Description | "When in 64-bit mode, the operand size for near call (and all near branches) is forced to 64-bits." |
| CALL·JMP Description | 간접 먼 호출 메모리는 "a 4-byte (16-bit operand size) or 6-byte (32-bit operand size) far address" |

정리하면 64비트 모드에서 2바이트(word) 메모리를 쓰는 유효 형식은 없다.
- 가까운 호출 r/m16은 N.E.이다.
- 먼 호출은 4바이트(m16:16), 6바이트(m16:32), 10바이트(m16:64)뿐이다.

### 관측

| 입력 | GNU as(Intel64 모드) | clang |
|---|---|---|
| `call word ptr [rax]` | 거부 "operand type mismatch" | `ff 18` = CALL m16:32 (6바이트 먼 호출) |
| `jmp word ptr [rax]` | 거부 | `ff 28` = JMP m16:32 |
| `call dword ptr [rax]` | `66 ff 18` = m16:16 (4바이트) | `ff 18` = m16:32 (6바이트) |
| `call fword ptr [rax]` | `ff 18` | `ff 18` |

참고: GNU를 AMD64 모드(기본)로 돌리면 `call word ptr [rax]` → `66 ff 10`(16비트 가까운 호출)이다. AMD 매뉴얼은 이 형식을 허용하고 Intel은 N.E.로 적는다.
clang의 `ff 18`은 두 매뉴얼 어느 쪽 해석과도 맞지 않는다.

### 버그로 본 이유

1. SDM 기준으로 2바이트 메모리에 맞는 유효 형식이 없으니 거부가 맞다. GNU는 거부한다.
2. clang은 크기 표기를 무시하고 6바이트를 읽는 먼 호출로 조립한다. 사용자가 적은 2바이트와 실제로 읽는 6바이트가 다르다.
3. 원인 위치: LLVM `X86InstrControl.td` 274행 `FARCALL32m : (ins opaquemem:$dst), "{l}call{l}..."`(187행 `FARJMP32m`도 같음).
   - `opaquemem`은 크기를 검사하지 않는다.
   - Intel 철자가 `call`이라서, `qword`가 아닌 모든 크기의 `call [m]`이 이 정의에 걸린다.

`dword ptr`는 4바이트 먼 포인터(m16:16, 유효)와 같은 문법이므로 10월 13일 시험 불가로 뺐다. 버그 후보는 `word ptr` 6케이스뿐이다.

상태: LLVM #88516(2024-04), #95232에 보고됨, 미해결.
근거 강도: **중간**. 크기 표기(`PTR`)가 SDM 문법이 아니라는 반론이 가능하다. 같은 이유로 llvm-mc 출력 후보는 철회했다. 다만 "2바이트에 맞는 형식이 없다"는 점은 SDM 기호 크기만으로 말할 수 있다.

---

## 3. AVX512PF 16개: Intel 문법 입력이 하나도 조립되지 않음 (clang 16케이스)

### SDM 표기

| 위치 | 원문 |
|---|---|
| 표 (Vol.2D 2375 / 8-12) | `EVEX.512.66.0F38.W0 C6 /1 /vsib` · `VGATHERPF0DPS vm32z {k1}` · Valid · CPUID AVX512PF |
| Operand Encoding | `A: BaseReg (R): VSIB:base, VectorReg(R): VSIB:index` (피연산자는 메모리 하나) |
| {k1} 정의 SYM072 (107 / 3-7) | "a mask register used as instruction writemask ... (e.g., gather)" |
| Vol.1 §15.6.1.2 (394 / 15-10) | "An opmask register serving as a predicate operand is expressed as a curly-braces-enclosed decorator following the first operand in the Intel assembly syntax." |
| Description | "Elements will only be prefetched if their corresponding mask bit is one." |

SDM이 Intel 문법의 마스크 위치를 직접 말한다. 첫 피연산자(메모리) 바로 뒤다. Intel XED 정의도 `MEM0`, 마스크 순서다.

### 관측

| 입력 | GNU as | clang |
|---|---|---|
| Intel `vgatherpf0dps [rax+zmm0] {k1}`(SDM 순서) | `62 f2 7d 49 c6 0c 00` | 거부 "invalid operand" |
| Intel `vgatherpf0dps {k1}, dword ptr [rax+zmm0]`(LLVM 정의 순서) | – | 거부 "unknown token in expression" |
| AT&T `vgatherpf0dps (%rax,%zmm0) {%k1}` | – | `62 f2 7d 49 c6 0c 00`(GNU와 같음) |
| 역어셈블 | objdump `DWORD PTR [rax+zmm0*1]{k1}` | llvm-mc `{k1}, dword ptr [rax + zmm0]`(재조립 실패) |

### 버그로 본 이유

1. SDM 표, Vol.1 문법 설명, XED, GNU가 모두 "메모리 다음 `{k1}`" 순서다. 매뉴얼끼리 충돌하는 곳이 없다.
2. LLVM은 이 명령의 어셈블 지원을 유지한다고 밝혔다. LLVM 19 릴리스 노트: "...while assembly encoding/decoding supports are kept." 실제로 AT&T는 된다.
3. 원인 위치: `X86InstrAVX512.td` 10438행 `"\t{$src {${mask}}|{${mask}}, $src}"`.
   - Intel 쪽만 마스크를 앞에 둔다.
   - 그런데 Intel 파서는 맨 앞 `{k1}`을 반올림·SAE 장식으로 읽다가 거부한다.
   - 결과적으로 매뉴얼 순서는 정의와 충돌하고, 정의 순서는 파서와 충돌한다.
4. SDM 해석과 무관하게, LLVM이 출력한 자기 Intel 문장을 다시 조립하지 못한다.

상태: 보고 기록을 찾지 못함. PR #122051 본문에 "unusual k mask operand position ... unsure how to change" 언급만 있음.
수정 방향: Intel 쪽을 `$src {${mask}}`로 바꾸고 Intel 문법 MC 테스트를 추가한다(현재 `avx512pf-64-att.s`만 있음). 빌드 검증은 하지 않았다.
근거 강도: **강함**. 도구 자기 모순이라 SDM 해석 논쟁이 필요 없다. 영향: 단종된 Xeon Phi 전용이라 작음.

---

## 한눈에

| 후보 | SDM 기호 | clang 동작 | LLVM 원인 | 보고 | 근거 강도 |
|---|---|---|---|---|---|
| CLRSSBSY·RSTORSSP | m64 | 64비트 표기 거부, 32비트 수용 | `i32mem` 정의 | #95232 | 강함 |
| call·jmp `word ptr` | r/m16 N.E., m16:xx는 4·6·10바이트 | 6바이트 먼 호출로 조립 | `opaquemem` 크기 무검사 | #88516 | 중간 |
| AVX512PF | `vm32z {k1}`, Vol.1 위치 규칙 | Intel 입력 전부 거부 | Intel 문법 문자열 | 없음 | 강함 |

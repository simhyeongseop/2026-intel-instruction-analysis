# Clang vs GNU as 비교 — 원시 바이트 증거 (codex 3라운드 교차검증 반영, 2026-08-25)

`out/clang_compare_report.md`의 `both_ok_diff_bytes`/`as_only`/`clang_only` 표에 나온 대표
사례들을 `objdump -d -M intel <file>.o`로 직접 재실행해 바이트까지 확인한 원시 출력이다.
소스는 전부 `out/tests.s`의 해당 combo_id 줄(`.intel_syntax noprefix`, `.Ltarget:` 라벨만
앞에 붙인 한 줄). ModRM 바이트는 직접 비트 단위로 디코딩해서 확인했다(추측 아님).

## ⚠️ 중요: 기존 "진짜 버그 7건" 중 CALL/JMP 2건은 오판정이었다 (정정 완료)

`docs/MEETING_NOTES/8회_미팅_PPT_초안.md`와 `out/triage_report.md`에 이미 "진짜 버그"로
보고된 `CALL r/m32`/`JMP r/m32`(combo 419/1436) 항목이 **잘못된 ModRM 해석에 근거한
오판정**이었음을 이번 clang 비교 + codex 3라운드 교차검증으로 확인해 `pipeline/m7_triage.py`를
수정하고 `out/triage.csv`/`out/triage_report.md`를 재생성했다. **bug 카운트 7건 → 5건.**

### combo_419 — `call dword ptr [eax]` (원래 주장: SDM이 N.E.로 명시한 CALL r/m32를 as가 허용)
```
as:    67 66 ff 18   call   DWORD PTR [eax]
clang: 67 ff 18      call   FWORD PTR [eax]
```
ModRM 바이트 `0x18` = `0001 1000` = mod(00) **reg(011=3)** rm(000=eax).
`data/db/isa_db.csv`에서 CALL의 opcode 표를 직접 대조:
- `FF /2  CALL r/m32` → **N.E.**(64비트 모드 인코딩 불가) ← 원래 테스트가 노리던 폼
- `FF /3  CALL m16:32` → **Valid**(64비트 모드, far call)
- `FF /3  CALL m16:16` → **Valid**

reg=3이므로 as가 실제로 인코딩한 건 **FF /3(far call)**이지 FF /2(near call r/m32)가
아니다 — 다만 어느 far 크기인지는 66 프리픽스 유무로 갈린다: **m16:16**(2+2=4바이트,
"DWORD PTR"로 읽힘) vs **m16:32**(2+4=6바이트, "FWORD PTR"로 읽힘). as는 66 프리픽스를
붙여 **m16:16**(4바이트)을 만들었는데, 이게 소스의 "dword ptr"(4바이트 표기)과 **정확히
크기가 맞는다** — as는 이 모호한 문법을 합리적으로(크기 표기에 맞는 far 폼으로) 해석한
것이다. clang은 66 프리픽스 없이 **m16:32**(6바이트, FWORD)를 만드는데, 이건 소스가 쓴
"dword ptr"(4바이트)과 크기가 안 맞는다 — clang은 "dword ptr" 크기 지정을 far call에서
사실상 무시하고 자기 기본값(m16:32)으로 가는 것으로 보인다(추가 확인 필요, 아래 clang
결함 후보 참고).
(codex 4차 검증에서 "dword ptr가 어느 far 크기와 맞는지"를 내가 거꾸로 썼다고 지적받아
정정함 — m16:32는 6바이트라 FWORD이지 DWORD가 아니다.)

**결론:** as/clang 둘 다 근접(near) N.E. 폼은 만들지 않고 **둘 다 far call(FF /3)로
인코딩**했다는 점에서는 일치한다 — 즉 원래 버그 보고의 핵심 전제("as가 SDM이 금지한 근접
r/m32 폼을 만든다")가 틀렸다는 결론 자체는 그대로 유지된다. 원래 버그 보고는 objdump
텍스트("call DWORD PTR [eax]")만 보고 "근접 호출처럼 보인다"고 넘겨짚은 것 — ModRM reg
필드를 실제로 디코딩하지 않아서 생긴 오판정이었다(codex 3차 검증에서 지적받고 직접
재계산해 확인).

### combo_1436 — `jmp dword ptr [eax]` (JMP도 동일 패턴)
```
as:    67 66 ff 28   jmp    DWORD PTR [eax]
clang: 67 ff 28       jmp    FWORD PTR [eax]
```
ModRM `0x28` = `0010 1000` = mod(00) **reg(101=5)** rm(000). `isa_db.csv`: `FF /4 JMP r/m32`
→ **N.S.**(CALL의 `FF /2 r/m32`는 N.E.로 표기가 다르지만 "64비트 모드에서 인코딩 불가"라는
실질은 같다 — mode_support 컬럼 값이 다르다는 것만 정확히 구분해서 적어둔다, codex 4차
지적 반영), `FF /5 JMP m16:32`/`m16:16` → Valid. reg=5이므로 FF /5(far jmp) — CALL과
완전히 동일한 상황(66 프리픽스로 m16:16=DWORD 크기를 정확히 맞춘 것도 동일).

### combo_417/1434 — `call/jmp word ptr [eax]` (expected_valid=False, clang_only)
```
417:  as 거부(operand type mismatch) / clang: 67 ff 18  call FWORD PTR [eax]  (combo_419와 바이트 동일)
1434: as 거부(operand type mismatch) / clang: 67 ff 28  jmp  FWORD PTR [eax]
```
combo_419/1436과 정확히 같은 바이트 — clang한테는 `word ptr`/`dword ptr` 표기가 far
call/jmp 크기 선택에 영향을 안 준 것으로 보임(같은 far m16:32로 수렴). as는 이 표기를
아예 거부. 이것도 SDM 위반이 아니라 모호한 문법에 대한 어셈블러별 처리 차이.

## LAR/LSL — 남아있는 진짜 버그 (2건, codex가 3라운드 동안 계속 확인)

### combo_1516 — `lar ecx, rcx` (SDM p.651: LAR r32, r64/m16 — 64비트 모드 Valid)
```
as:    (컴파일 에러: register type mismatch for `lar')
clang: 0f 02 c9       lar    ecx,ecx   (REX 없음, 3바이트: opcode 2 + ModRM 1)
```
`isa_db.csv`가 SDM p.651에서 뽑은 형식 그대로 `LAR r32, r64/m16`을 Valid로 명시하는데, as는
소스 레지스터로 `rcx`(64비트 별칭)를 쓰는 걸 파서 단계에서 거부한다("register type
mismatch") — SDM이 명시적으로 허용하는 **문법 자체**를 as가 못 받아주는 것이다. clang은
받아주고 REX 없는 3바이트로 인코딩한다(LAR는 소스를 32비트로만 읽으므로 REX.W 유무는 실행
결과에 영향 없음 — 이 부분은 "인코딩까지 SDM과 정확히 일치"라고 말할 근거는 없고, "SDM이
허용한 문법을 clang은 받아주고 as는 거부한다"는 사실관계만 근거로 남긴다, codex 3차 지적
반영).

### combo_1571 — `lsl rcx, ecx` (SDM p.691: LSL r64, r32/m16 — 64비트 모드 Valid)
```
as:    (컴파일 에러: register type mismatch for `lsl')
clang: 48 0f 03 c9    lsl    rcx,rcx   (REX.W=1)
```
LAR와 대칭 관계(목적지가 r64라 REX.W 필요). as는 이 문법도 거부, clang은 받아준다. 관련
사례로 combo 1572(`lsl rcx, word ptr [eax]`)도 as는 `lsl ecx,...`(REX.W 없음), clang은
`lsl rcx,...`(REX.W 있음)로 동일 패턴 — as가 LSL 목적지 64비트 인코딩 경로를 메모리
오퍼랜드에서도 일관되게 안 씀을 시사.

**이 2건이 clang과의 비교로 살아남는 유일한 "진짜 버그"다.** SDM이 명시적으로 나열한
레지스터-폭 조합을 as의 Intel-syntax 파서가 타입 체크 단계에서 거부하는, 실행 의미론과
무관한 **문법 지원 결함**이라 CALL/JMP 사례와 달리 모호함의 여지가 없다.

## MOV Sreg — 레지스터 형태 3건은 "인코딩 표현 차이"로 격하 (실행 결과는 동일함)

```
combo_1678  mov rcx, ds     as: 8c d9 (mov ecx,ds)      clang: 48 8c d9 (mov rcx,ds)
combo_1680  mov ds, cx      as: 8e d9 (mov ds,ecx)      clang: 66 8e d9 (mov ds,cx)
combo_1682  mov ds, rcx     as: 8e d9 (mov ds,ecx)      clang: 48 8e d9 (mov ds,rcx)
```
codex 2~3차 검증에서 지적받은 대로, REX.W 유무가 **실행 결과를 바꾸지 않는다**:
- `mov r32/r64, Sreg`(8C /r, Sreg→GPR): 64비트 모드에서 32비트 레지스터에 쓰면 상위 32비트가
  자동 zero-extension되므로, `mov ecx,ds`와 `mov rcx,ds`는 **최종 RCX 값이 완전히 같다.**
- `mov Sreg, r32/r64`(8E /r, GPR→Sreg): SDM에 따르면 소스 레지스터의 **하위 16비트만** 읽는다.
  ecx와 rcx의 하위 16비트는 항상 같으므로 `mov ds,ecx`와 `mov ds,rcx`는 **실행 결과가 같다.**

따라서 이 3건은 "as가 버그"가 아니라 **"오퍼랜드 크기 프리픽스(REX.W 또는 66)를 붙이는
기준이 as/clang 사이에 다르지만, 어느 쪽이든 실행 결과는 동일한, 무해한 인코딩 표현
차이"**로 정리한다. 정확히는 combo 1678/1682(`rcx` 관련)는 REX.W 유무 차이, combo
1680(`mov ds, cx`, 16비트)은 REX.W가 아니라 **0x66 오퍼랜드 크기 프리픽스** 유무 차이다
(codex 4차 검증에서 이 둘을 뭉뚱그려 "REX.W"라고만 쓴 게 부정확하다고 지적받아 구분함).
원래 triage_report.md가 버그 근거로 든 **메모리 형태** `mov ds, qword ptr [eax]`(combo 1683)는
`out/clang_compare.csv`에서 `both_reject`(as: operand type mismatch, clang: invalid operand)
— clang도 그 문법을 지원하지 않아 교차 확인이 안 되고, 여전히 "as 단독 관찰"로 남는다.
(triage_report.md의 이 항목 자체는 이번 라운드에서 verdict를 바꾸지 않았다 — 별도로
"레지스터 폭이 실행상 무해하다"는 이유로 bug 판정을 낮출지는 향후 라운드에서 memory 형태
자체의 SDM 근거를 다시 검토해서 결정할 것.)

## 새로 발견된 clang 쪽 결함 후보 — `mov cx, ds`를 clang이 `mov ecx, ds`로 확장 (combo 1674/1676)
```
as:    66 8c d9   mov    cx,ds     (소스 그대로 16비트 유지)
clang: 8c d9      mov    ecx,ds    (16비트 요청을 32비트로 확장)
```
이건 위의 MOV Sreg 사례들과 달리 **실행 결과가 실제로 달라진다**: `mov cx,ds`(16비트 쓰기)는
목적지 레지스터의 상위 비트를 그대로 두지만, clang이 만든 `mov ecx,ds`(32비트 쓰기)는
RCX의 상위 32비트까지 0으로 zero-extension한다 — 프로그램이 RCX 상위 비트에 의미 있는 값을
갖고 있었다면 clang의 인코딩은 그 값을 지워버린다(codex 3차 검증에서 지적). 즉 이건
**as-vs-SDM 버그가 아니라 clang(LLVM 통합 어셈블러) 쪽의 잠재적 결함 후보**로 별도 기록한다
— 이번 프로젝트의 정답 기준은 SDM이므로 "as의 버그"로 집계하진 않지만, 8회 후속 과제
"Clang 확장 비교"의 목적(두 어셈블러 신뢰도 비교) 자체에 부합하는 발견이라 남겨둔다.

## POP/PUSH fs/gs, IRET — 66 프리픽스 유무 (combo 3293~3896, 1332) — SDM 위반 아님
```
pop fs   as: 0f a1        clang: 66 0f a1
push gs  as: 0f a8        clang: 66 0f a8
iret     as: cf           clang: 66 cf
```
모호한 bare mnemonic(오퍼랜드 크기를 소스가 명시 안 함)에 대해 as는 32/64비트 기본값을,
clang은 16비트 기본값(0x66)을 선택한 것 — 실행되는 폭은 실제로 다르지만 SDM은 두 인코딩
모두 Valid로 인정하므로 "어느 쪽이 틀렸다"고 볼 근거가 없다(codex 2차 검증 확인).

## REP INS/MOVS/OUTS/STOS — prefix 순서 차이 (combo 4048~4064, 30건) — 아키텍처적으로 동등
```
예) rep ins byte ptr [eax], dx     as: 67 f3 6c     clang: f3 67 6c
```
F3(REP)과 67(주소 크기 오버라이드)은 서로 다른 legacy prefix 그룹이라 그룹 간 순서는 실행
의미에 영향을 주지 않는다(codex 2차 검증 확인). 단순 프리픽스 표기 순서(관례) 차이.

## combo_337 등 — BND* (MPX) 니모닉을 clang이 아예 모름 (as_only 56건 중 다수)
```
as:    66 0f 1a c0   bndmov bnd0,bnd0
clang: (컴파일 에러: invalid instruction mnemonic 'bndmov')
```
BNDCL/BNDCU/BNDCN/BNDMK/BNDMOV/BNDLDX 전부 이 패턴 — clang 18.1.3의 통합 어셈블러가 MPX
니모닉 자체를 모른다(LLVM이 MPX 지원을 예전에 제거한 것으로 보임). SDM-vs-as 불일치가 아니라
어셈블러 기능 지원 범위(레거시/제거된 확장 명령어 집합) 차이.

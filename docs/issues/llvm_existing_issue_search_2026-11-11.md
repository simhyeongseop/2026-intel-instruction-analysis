# LLVM 기존 이슈 검색과 원인 확인 (2026-11-11)

대상: 11월 11일 라운드에서 나온 LLVM 쪽 발견 세 건.
① Intel 문법 `iret`·`push/pop fs·gs`의 16비트 선택, ② Intel 출력의 크기 표시 누락, ③ GPR 소스 `{rn-sae}` 위치.

**제출한 것은 없다.** 사용자 결정(2026-11-11): 교수님께 먼저 보고하고, LLVM 보고는 그 뒤에 정한다.

## 1. 검색 방법과 한계

- GitHub 검색 API(`search/issues`, `search/commits`)로 `llvm/llvm-project`를 검색했다(이슈와 PR 포함, 열림·닫힘 모두).
- 검색어: `iret intel syntax`, `iret in:title`, `iretw`, `push fs intel syntax 16-bit`, `"push fs"`, `"pop fs"`,
  `pushf in:title`, `popf in:title`, `pushfw intel`, `retf in:title`, `lret intel`, `retf intel syntax operand size`,
  `mov segment register intel syntax 16-bit operand size prefix`, `intel syntax disassembler operand size ambiguous`,
  `llvm-mc intel syntax round trip`, `rn-sae intel syntax`, `"rn-sae"`, `vcvtsi2sd in:title`, `vcvtusi2sd`,
  `vcvtsi2ss intel`, `embedded rounding intel syntax operand order`, `intel syntax far call disassembler`.
- 한계: 검색어에 걸린 것만 본 것이다. 결론은 "같은 이슈가 없다"가 아니라 **"찾지 못했다"**이다.
  옛 Bugzilla 건은 GitHub로 옮겨진 것만 보인다. 메일링 리스트·Phabricator 리뷰는 검색하지 않았다.

## 2. 찾은 것

| 발견 | 같은 내용의 열린 이슈 | 관련 선례 |
|---|---|---|
| ① `iret` 16비트 | 찾지 못함 | #12414(2012, 닫힘), #36224(2018, 닫힘) |
| ① `push/pop fs·gs` 16비트 | 찾지 못함 | #31383(2017, 닫힘) — 같은 종류의 문제를 `pushf/popf`에서 고침 |
| ② Intel 출력 크기 표시 누락 | 찾지 못함 | #12414, #48335(열림), #88941(닫힘), #156287(열린 PR) |
| ③ GPR 소스 `{rn-sae}` 위치 | 찾지 못함(이슈·커밋 모두 0건) | 우리가 보고한 #233852 → PR #233869(머지) |

선례 요지:

- **#12414** "[x86 disassembler] iret, sysret, sysexit displayed incorrectly with Intel syntax" (2012, 수정됨).
  당시 llvm-mc Intel 출력이 `66 CF`를 `iretw`로 썼는데, SDM 표 이름(`CF IRET` = 16비트)에 맞춰 **`iret`로 바꿨다.**
  즉 지금의 Intel 출력 `66 CF` → `iret`는 의도한 동작이다. 입력 쪽(`iret`을 16비트로 조립)도 같은 정의를 쓴 결과다.
- **#31383** "pushf/popf default to wrong operand size in 64-bit with Intel syntax" (2017, r314295로 수정).
  Intel 문법 `pushf`가 64비트 모드에서 `66 9C`로 조립되던 문제다. 보고자는 "32비트에서는 매뉴얼이 일부러 모호하게 두었지만
  64비트에서 크기 없는 `pushf`는 `pushfq`로 읽는 것이 맞다"고 썼고, GNU와 같게 고쳐졌다.
  **`push fs`·`iret`은 같은 구조인데 이 수정에 들어가지 않았다.** ① 보고의 가장 직접적인 근거다.
- **#36224** IRET 정의 이름 정리(IRET16/32/64). 동작 변경 아님.
- **#48335** "Possible bugs in X86_64 assembler" (2021, 열림). `lcall tbyte ptr [rcx+rdx]`가 `FF /3`(FWORD)로 조립되는 것 등.
  우리 CALL/JMP 크기 표기 문제(11월 4일 분류)와 같은 계열이다. ①·②와 직접 같지는 않다.
- **#88941** `retf` 철자를 clang이 모른다는 보고(2024, 닫힘). AT&T에서는 `lret`을 써야 한다는 답으로 끝났다. 크기 문제는 다루지 않았다.
- **#156287** Intel 문법 `data16`/`data32` 접두어 처리 PR(2025, 열림). 크기 접두어 쪽 주변 작업이다.
- **#33826** `movw %fs, (%rsi)`에 66H가 붙던 문제(2017, 수정). 메모리 목적지 건이라 `mov cx, es`(레지스터 목적지)와 다르다.

## 3. 원인 — LLVM 23.1.3 소스와 도구 출력

소스는 태그 `llvmorg-23.1.3`의 `llvm/lib/Target/X86/`에서 읽었다. 정의 선택은 `llvm-mc --show-inst`로 직접 확인했다.

### ①·② 크기 글자가 AT&T 문자열에만 있다

```
X86InstrControl.td:51  def IRET16 : I <0xcf, RawFrm, (outs), (ins), "iret{w}", []>, OpSize16
X86InstrControl.td:53  def IRET32 : I <0xcf, RawFrm, (outs), (ins), "iret{l|d}", []>, OpSize32;
X86InstrControl.td:54  def IRET64 : RI<0xcf, RawFrm, (outs), (ins), "iretq", []>, Requires<[In64BitMode]>;
X86InstrSystem.td:306  def PUSHFS16 : I<0xa0, RawFrm, (outs), (ins), "push{w}\t{%fs|fs}", []>
X86InstrSystem.td:308  def PUSHFS32 : I<0xa0, RawFrm, (outs), (ins), "push{l}\t{%fs|fs}", []>
X86InstrSystem.td:314  def PUSHFS64 : I<0xa0, RawFrm, (outs), (ins), "push{q}\t{%fs|fs}", []>
X86InstrControl.td:39  def LRET16 : I <0xCB, RawFrm, (outs), (ins), "{l}ret{w|f}", []>, OpSize16;
X86InstrMisc.td:150    def PUSHF16 : I<0x9C, RawFrm, (outs), (ins), "pushf{w}", []>, OpSize16;
```

`{A|B}`는 "AT&T 문자열|Intel 문자열"이다. `push{w}`처럼 한쪽만 있으면 그 글자는 AT&T에만 붙는다.
그래서 Intel 문자열은 PUSHFS16·32·64가 모두 `push fs`, IRET16이 `iret`, LRET16·LRET32가 모두 `retf`, PUSHF16이 `pushf`다.

크기를 고르는 별칭(`X86InstrAsmAlias.td`)은 대부분 AT&T용만 있다.

```
343  def : MnemonicAlias<"iret",  "iretw",  "att">,   Requires<[In16BitMode]>;
344  def : MnemonicAlias<"iret",  "iretl",  "att">,   Requires<[Not16BitMode]>;
286  def : MnemonicAlias<"push",  "pushq",  "att">,   Requires<[In64BitMode]>;
289  def : MnemonicAlias<"pushf", "pushfq", "att">,   Requires<[In64BitMode]>;
290  def : MnemonicAlias<"pushf", "pushfq", "intel">, Requires<[In64BitMode]>;   ← Intel용 별칭(#31383이 요구한 동작)
```

(290행이 #31383의 수정 커밋 r314295에서 들어온 것인지 커밋을 대조하지는 않았다. 동작이 그 이슈의 요구와 같다는 것까지만 확인했다.)

Intel용은 `pushf`/`popf`만 있다. `iret`·`push fs`·`pop fs`·`retf`에는 없다.

도구 확인(`llvm-mc -triple=x86_64 --show-encoding --show-inst`, LLVM 23.1.3):

| 입력 | 문법 | 바이트 | 선택된 정의 |
|---|---|---|---|
| `iret` | Intel | `66 CF` | IRET16 |
| `iret` | AT&T | `CF` | IRET32 |
| `push fs` | Intel | `66 0F A0` | PUSHFS16 |
| `push %fs` | AT&T | `0F A0` | PUSHFS64 |
| `pop fs` | Intel | `66 0F A1` | POPFS16 |
| `pushf` | Intel | `9C` | PUSHF64 (별칭이 있어서 정상) |
| `retf` | Intel | `CB` | LRET32 |
| `mov cx, es` | Intel | `8C C1` | MOV32rs (출력도 `mov ecx, es`) |
| `mov %es, %cx` | AT&T | `66 8C C1` | MOV16rs |

출력 쪽(`llvm-mc --disassemble -output-asm-variant=1`): `66 9C` → `pushf`, `66 CB`·`CB` → 둘 다 `retf`,
`0F A0`·`66 0F A0` → 둘 다 `push fs`. AT&T 출력은 `pushfw`, `lretw`/`lretl`, `pushq %fs`/`pushw %fs`로 구분한다.

정리: 입력에서 16비트 정의가 잡히는 것(①)과 출력에서 크기가 사라지는 것(②)은 **같은 정의 문자열에서 나온 두 증상**이다.
같은 Intel 문자열을 가진 정의 여럿 중 왜 16비트가 잡히는지(매처 표 순서)는 소스에서 확인하지 않았다. 관측은 위 표와 같다.
`mov cx, es`는 방향이 반대다(16비트로 썼는데 32비트 정의가 잡혀 66H가 빠진다). 정의 문자열까지는 추적하지 않았다.

### ③ Intel 문자열에 위치가 고정돼 있다

```
X86InstrAVX512.td:7316  multiclass avx512_vcvtsi_round<...>
  def rrb_Int : SI<opc, MRMSrcReg, (outs DstVT.RC:$dst), (ins DstVT.RC:$src1, SrcRC:$src2, AVX512RC:$rc),
      !strconcat(asm, "\t{$src2, $rc, $src1, $dst|$dst, $src1, $rc, $src2}"), ...
```

Intel 문자열이 `$dst, $src1, $rc, $src2`다. 장식(`$rc`)이 GPR 소스(`$src2`) **앞**에 온다.
다른 ER/SAE 명령은 장식이 맨 뒤(SDM 표에서 장식이 붙은 오퍼랜드 뒤)다. 이 묶음(VCVTSI2SD/SS/SH, VCVTUSI2SD/SS/SH)만 다르다.

| 입력(Intel) | clang 23.1.3 | GNU as 2.47 |
|---|---|---|
| `vcvtsi2sd xmm0, xmm1, {rn-sae}, rcx` | `62 F1 F7 18 2A C1` | 같은 바이트 |
| `vcvtsi2sd xmm0, xmm1, rcx, {rn-sae}` | **거부**(invalid operand) | 같은 바이트 |

GNU objdump Intel 출력은 `vcvtsi2sd xmm0,xmm1,rcx{rn-sae}`(SDM 표 모양)라서 clang이 받지 않는다.
AT&T는 두 도구 모두 `%rcx, {rn-sae}, %xmm1, %xmm0`만 받는다(Intel 문자열의 거울).

## 4. 보고할 때의 판단 재료(결정은 교수님 보고 뒤)

- ①: #31383이 선례다. 같은 논리(64비트에서 크기 없는 철자는 기본 크기)로 `push/pop fs·gs`는 보고 근거가 강하다.
  `iret`은 매뉴얼 표가 `IRET` = 16비트라고 적어 LLVM 선택도 표와 맞는다(3단계 'SDM 일치'). 버그라기보다 도구 간 해석 차이다.
- ②: 같은 텍스트가 두 바이트를 뜻하고 자기 왕복에서 바이트가 바뀐다(`0F A0` → `push fs` → `66 0F A0`). 매뉴얼과 무관하게
  도구 자기 일관성 문제라 근거가 가장 분명하다.
- ③: 매뉴얼이 문법 위치를 정하지 않는다. 받는 위치에서는 바이트가 맞다. 버그로 확정하지 않는다(문법 일관성·GNU 호환 문제).

관련 문서: [SIZE_MNEMONIC_RISK_2026-11-11.md](../SIZE_MNEMONIC_RISK_2026-11-11.md),
[ROUNDING_POSITION_2026-11-11.md](../ROUNDING_POSITION_2026-11-11.md),
[ROUNDTRIP_ANALYSIS_2026-11-11.md](../ROUNDTRIP_ANALYSIS_2026-11-11.md).

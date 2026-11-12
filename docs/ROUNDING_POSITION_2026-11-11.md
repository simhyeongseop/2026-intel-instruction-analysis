# 반올림·SAE 장식 위치(`{rn-sae}`, `{sae}`) 정리 (2026-11-11)

배경: 10월 13일 ER/SAE 지원 때 clang Intel이 `vcvtsi2sd xmm0, xmm1, rcx, {rn-sae}`를 거부하고 `{rn-sae}, rcx` 순서만 받는 것을
보았다(`docs/ER_SAE_SUPPORT.md`, '다른 표현 0/40'으로 분류). 11월 11일 라운드에서는 우리 AT&T 변환 `vcvtsi2sd {rn-sae}, %rcx,
%xmm1, %xmm0`을 GNU AT&T도 거부했다. LLVM에는 이전에 같은 계열(장식·마스크 위치를 Intel 파서가 잘못 읽음)로 AVX512PF `k1`
위치 문제를 보고해 PR #233869가 머지됐다(`docs/issues/llvm_pr_233869_status_20261021.md`). 그래서 위치 규칙을 전수로 확인했다.

자료: `out/round2_20261111/rounding_position/`(`positions.csv`, `summary.json`, `manifest.json`), 코드
`scripts/probe_rounding_position.py`. ER/SAE가 있는 SDM 행 288개마다 대표 레지스터 케이스 하나({rn-sae} 우선)를 골라, 장식을
가능한 모든 위치(맨 앞~맨 뒤)에 넣은 Intel·AT&T 소스를 GNU as 2.47·clang 23.1.3으로 조립했다(4,344회). 기준 바이트는 3단계에서
SDM 일치가 확인된 GNU 바이트다.

## 1. 매뉴얼이 정한 것과 정하지 않은 것

- 매뉴얼은 `{er}`·`{sae}`를 표 기호로 정의한다: "{er} — Indicates support for embedded rounding control, which is only applicable
  to the register-register form"(파일 108쪽). 표에서는 한 오퍼랜드에 붙여 쓴다: `VADDPD ..., zmm3/m512/m64bcst{er}`,
  `VCMPPD ..., zmm3/m512/m64bcst{sae}, imm8`, `VCVTSI2SD xmm1, xmm2, r/m64{er}`.
- 바이트는 EVEX.b와 L'L(RC)로 정해진다(Table 2-38).
- **어셈블러 문법에서 장식을 쉼표로 나눈 어느 자리에 쓰는지는 매뉴얼에 없다.** 매뉴얼 본문에 `{rn-sae}` 같은 철자도 나오지 않는다.
  즉 위치는 도구 문법(GNU·LLVM 각자)의 규칙이다.

## 2. 전수 결과

받았을 때 기준과 다른 바이트를 낸 경우(조용한 오조립)는 **0건**이다. 위치가 틀리면 거부하고, 받으면 같은 바이트다.

| 형식(Intel 오퍼랜드, 행 수) | Intel: GNU 받는 위치 | Intel: clang | AT&T: GNU | AT&T: clang |
|---|---|---|---|---|
| 벡터 3개 `vaddpd zmm0, zmm1, zmm2` (156) | 맨 뒤(`zmm2, {rn-sae}`) | 같음 | 맨 앞(`{rn-sae}, %zmm2, ...`) | 같음 |
| 벡터 2개 `vcomisd xmm0, xmm1` (65) | 맨 뒤 | 같음 | 맨 앞 | 같음 |
| 즉값 있음 `vcmppd k0, zmm0, zmm1, 0x12` 등 (33) | 즉값 바로 앞 | 같음 | 즉값 바로 뒤(`$0x12, {sae}, ...`) | 같음 |
| GPR 목적지 `vcvtsd2si ecx, xmm0` (24) | 맨 뒤 | 같음 | 맨 앞 | 같음 |
| **GPR 소스 `vcvtsi2sd xmm0, xmm1, rcx`** (10) | **GPR 뒤(`rcx, {rn-sae}`)와 GPR 앞(`{rn-sae}, rcx`) 둘 다** | **GPR 앞만** | **GPR 뒤만(`%rcx, {rn-sae}, %xmm1, %xmm0`)** | 같음 |

- 278개 행은 두 도구가 한 위치만, 같은 위치를 받는다. 규칙: Intel은 '장식이 붙은 SDM 오퍼랜드 바로 뒤', AT&T는 그 거울.
- 예외는 GPR 소스 변환 10행(VCVTSI2SD/SS/SH, VCVTUSI2SD/SS/SH의 r32/r64 형식)뿐이다. 이 형식만 두 도구 모두 '장식을 GPR과
  두 번째 벡터 소스 사이'에 두는 문법을 쓴다(Intel `xmm1, {rn-sae}, rcx` = AT&T `%rcx, {rn-sae}, %xmm1`). GNU Intel만 SDM 표
  모양(`rcx, {rn-sae}`, 장식이 붙은 오퍼랜드 뒤)도 함께 받는다.

## 3. 역어셈블 출력과 도구 간 호환

`62 F1 F7 18 2A C1`(VCVTSI2SD xmm0, xmm1, rcx, {rn-sae}):

| 출력 | 텍스트 | GNU as | clang |
|---|---|---|---|
| objdump Intel | `vcvtsi2sd xmm0,xmm1,rcx{rn-sae}` | 같은 바이트 | **거부** |
| objdump AT&T | `vcvtsi2sd %rcx,{rn-sae},%xmm1,%xmm0` | 같은 바이트 | 같은 바이트 |
| llvm-mc Intel | `vcvtsi2sd xmm0, xmm1, {rn-sae}, rcx` | 같은 바이트 | 같은 바이트 |
| llvm-mc AT&T | `vcvtsi2sd %rcx, {rn-sae}, %xmm1, %xmm0` | 같은 바이트 | 같은 바이트 |

GNU objdump의 Intel 출력(SDM 표 모양)을 clang이 받지 않는다. 각 도구 자기 왕복은 모두 같다(5단계 b0–b1 같음).

## 4. 판단

- **LLVM 버그로 확정하지 않는다.** 매뉴얼이 문법 위치를 정하지 않았고, clang은 받는 위치에서 정확한 바이트를 낸다. 다만 (1) clang
  Intel이 매뉴얼 표 모양(`r/m64{er}`처럼 장식이 그 오퍼랜드 뒤)을 이 10행에서만 거부하고 (2) 다른 278행에서는 같은 원칙(붙은
  오퍼랜드 뒤)을 받으므로, **LLVM Intel 문법의 내부 일관성 문제**로는 설명할 수 있다. GNU는 두 위치를 다 받는다. AVX512PF `k1`
  때와 같이 'Intel 파서가 장식 위치를 매뉴얼 표 모양과 다르게 정의한' 계열이다. 보고 여부는 사용자 결정.
- 보안 관점: 위치 차이는 거부로만 나타나고 다른 바이트로 조립되는 경우가 없어, 2절 범위에서는 의미가 바뀌는 위험은 관측되지 않았다.
  도구 간 텍스트 교환(GNU Intel 출력 → clang)이 실패하는 호환 문제다.

## 5. 우리 쪽 수정

- `pipeline/att_syntax.py`: AT&T 변환에서 장식 바로 뒤가 GPR이면 둘을 바꾼다(`rounding_after_gpr`). 생성 소스 전체에 적용하면
  바뀌는 AT&T 소스는 정확히 이 40건(10행 × 네 모드)이고, 새 소스는 GNU·clang 모두 받아 GNU 기준 바이트와 같다(직접 확인).
  회귀 `tests/test_att_syntax.py::test_rounding_after_gpr_source`.
- 11월 11일 라운드 결과 파일은 그대로 두었다(실험 기록). 다음 라운드부터 새 변환이 쓰인다. Intel 생성 소스는 SDM 표 모양
  (`rcx, {rn-sae}`)을 유지한다. clang 거부는 관측으로 남긴다.

## 6. 기존 이슈 검색과 원인(2026-11-11 추가)

- LLVM 이슈·커밋 검색에서 이 위치 문제를 다룬 것은 찾지 못했다(검색어는
  [issues/llvm_existing_issue_search_2026-11-11.md](issues/llvm_existing_issue_search_2026-11-11.md)).
- 원인: LLVM 23.1.3 `X86InstrAVX512.td`의 `avx512_vcvtsi_round`가 Intel 문자열을 `$dst, $src1, $rc, $src2`로 적어 두었다
  (장식이 GPR 소스 앞). 다른 ER/SAE 정의는 장식이 맨 뒤다.
- 보고 여부는 교수님 보고 뒤에 정한다(사용자 결정). 판단은 4절 그대로다(버그로 확정하지 않음).

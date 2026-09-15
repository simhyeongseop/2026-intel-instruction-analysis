# Stage 6 — 차등 클러스터 근본원인 규명 (타임박스 3건)

> 목적: harness의 값은 divergence 개수가 아니라 **설명 가능성**. (d)/(f)에서 3건을
> SDM 원문까지 파고들어 "왜 갈리는가"를 규명하고, 그 결과로 입력 다양화(#3)의 축을 결정한다.

## 재사용 가능한 근본원인 규명 절차
1. 대상 케이스의 source·as 바이트·llvm 바이트를 확보.
2. `iced-x86`로 양쪽 바이트를 디코드해 **의미**를 본다.
3. 피연산자를 변주(구별/겹침, 홀/짝, 크기)해 **어느 조건에서 갈리는지** 국소화.
4. SDM 해당 명령 페이지에서 **아키텍처 규칙 원문**을 인용해 판정.
5. 결론: (버그 / 비정규 인코딩 허용 / 동등 효과 / 도구 한계) 중 무엇인지 + 보안 함의 + 생성기 함의.

---

## 사례 1 — VGATHER 레지스터 aliasing: 어셈블러가 #UD 인코딩을 수용 (분류 f)
**source**: `vgatherdps xmm1, [rax+xmm2*1], xmm2`  (index=xmm2, mask=xmm2 → 겹침)

| | 바이트 | iced 디코드 |
|---|---|---|
| as | `c4 e2 69 92 0c 10` | **(invalid)** |
| llvm-mc | `c4 e2 69 92 0c 10` | **(invalid)** |

국소화 실험:
- distinct `vgatherdps xmm1,[rax+xmm2],xmm3` → `c4e261920c10` → iced **valid**
- dest==index `vgatherdps xmm2,[rax+xmm2],xmm3` → `c4e261921410` → iced **(invalid)**

**SDM 근거** (325383-090, VGATHERDPS/VGATHERDPD, Vol.2C):
> "If any pair of the index, mask, or destination registers are the same, this instruction results a UD fault." (p.1827)
> "The instruction will #UD fault if the destination vector zmm1 is the same as index vector VINDEX." (p.1824)

**판정**: 두 어셈블러(as·llvm) **모두** 아키텍처적으로 #UD인 인코딩을 아무 경고 없이 바이트로 방출한다. iced(독립 디코더)만 invalid로 판정. 즉 **as/llvm 사이 divergence가 아니라 "어셈블러 vs 아키텍처 유효성" divergence**.
- **보안 함의**: 이런 바이트가 실행되면 CPU는 #UD. 그러나 정적 디스어셈블러/디스assembler 기반 스캐너(ROP 갓짓 탐색, AV, 샌드박스 검증기)가 이를 "정상 gather"로 오독하면 실제 CPU 동작과 divergence → 오탐/우회의 온상. 이것이 이 연구가 찾던, **매뉴얼로 근거를 댈 수 있는 보안 관련 discrepancy**.
- **생성기 함의**: Stage 3가 index와 mask에 같은 xmm2를 재사용해 **의도치 않게 무효 인코딩**을 만들었다. → #3 다양화에 "레지스터 distinctness 제약"을 반드시 넣어야 하고, aliasing은 **의도적 음성 테스트**로 분리 생성해야 한다.

---

## 사례 2 — VP2INTERSECT 마스크쌍: 홀수 목적지 처리 divergence (분류 d, 그러나 효과는 동등)
**source**: `vp2intersectd k1, xmm2, xmm3`  (k1 = 홀수)

| | 바이트(끝 ModRM) | iced 디코드 |
|---|---|---|
| as | `…68 cb` (reg=001) | `vp2intersectd k1,…` |
| llvm-mc | `…68 c3` (reg=000) | `vp2intersectd k0,…` |

국소화: `vp2intersectd k2, …`(짝수) → 둘 다 `…68 d3`, iced 모두 `k2` → **일치**. 즉 divergence는 **홀수 목적지에서만** 발생.

**SDM 근거** (325383-090, VP2INTERSECTD/Q, Vol.2C p.1894):
> "The mask register destination indicated in the MODRM.REG field is used to form the basis of the register pair. **The low bit of that field is masked off (set to zero)** to create the first register of the pair."

**판정 (중요)**: CPU가 MODRM.REG의 **저비트를 무시**하므로, reg=001(k1)이든 reg=000(k0)이든 **실행 효과는 동일**(k0:k1 쌍). 따라서
- as는 요청한 k1을 **리터럴로**(reg=001) 인코딩, llvm은 **정규화**(reg=000)하여 인코딩.
- 바이트도 다르고 iced 디스어셈블 텍스트도 다르지만(**k1 vs k0**), **아키텍처적으로는 동등**.
- → 이것은 어셈블러 **버그가 아니라 "비정규 인코딩 허용 + 정규화 정책 차이"**.
- **방법론적 교훈**: Stage 6가 이 케이스를 `semantic_divergence(d)`로 올린 것은 **과분류**다. iced 텍스트 동일성만으로는 부족하고, SDM의 정규화 규칙(저비트 마스킹)을 알아야 "동등"임을 안다. → **(d) 하위에 "byte+disasm 다르나 아키텍처 효과 동일" 서브카테고리 필요**. (교수님 경고 "divergence≠bug"의 실증)
- **보안 함의**: 비정규 인코딩을 CPU는 수용하지만 디스어셈블러마다 다르게 표기 → 디스어셈블러 일관성/난독화 각도.
- **생성기 함의**: Stage 3가 마스크쌍 명령에 홀수 k1을 넣었다. → 마스크쌍 명령은 짝수 베이스로 생성하고, 홀수는 의도적 음성 테스트로 분리.

---

## 사례 3 — MOV r64, Sreg: operand-size 인코딩 divergence (분류 d, 동작 규명 완료)
**source**: `mov rax, ds`

| | 바이트 | iced 디코드 |
|---|---|---|
| as | `8c d8` (REX.W 없음) | `mov eax, ds` |
| llvm-mc | `48 8c d8` (REX.W) | `mov rax, ds` |

국소화: `mov eax, ds` → 둘 다 `8c d8` 일치. divergence는 **64비트 목적지 요청 시에만**.

**판정**: `MOV r/m16, Sreg`(opcode 8C)에서 세그먼트 셀렉터(16비트)를 GPR에 쓸 때, as는 REX.W 요청을 무시하고 32비트 형(8cd8, 결과적으로 eax→상위 zero-extend)으로, llvm은 REX.W(48)를 붙여 64비트 형으로 인코딩. 아키텍처적으로 두 경우 모두 16비트 셀렉터를 상위 zero-extend하므로 **결과 레지스터 값은 동일**하나, **인코딩과 디스어셈블 표기가 갈린다**. (SDM MOV의 세그먼트-레지스터 operand-size 규정으로 설명 가능 — 정확 인용은 후속 확보 대상.)
- **생성기/다양화 함의**: operand-size가 암묵/모호한 명령(seg mov, far 분기, IRET, push/pop seg)에서 **크기 변주**가 필요. #1 클러스터(66h/REX.W) 전체가 여기 해당.

---

## #3 입력 다양화 축 (근본원인이 결정한 것)
1. **레지스터 distinctness** (사례1) — gather류 dest/index/mask 구별 보장 + aliasing 음성 테스트.
2. **마스크쌍 parity** (사례2) — VP2INTERSECT류 짝수 베이스 + 홀수 음성 테스트.
3. **operand-size 변주** (사례3, #1 클러스터) — seg mov/far 분기/IRET/push-pop seg에서 16/32/64 강제.
4. (기존 계획) REX 확장비트 r8–15/xmm8–31, disp8/disp32/SIB/RIP, imm 경계, {er}/{sae}/{1toN}.

## Stage 6 taxonomy 보정 제안
- `semantic_divergence(d)`는 "iced 텍스트가 다름"까지만 본다. VP2INTERSECT처럼 **SDM 정규화 규칙으로 효과가 동등**한 경우가 섞인다.
- → (d)를 수동 근본원인 규명 후 `(d1) 진짜 의미 divergence` / `(d2) 비정규 인코딩·동등 효과`로 재분류. 현재 (d) 17건 중 6건(vp2intersect)은 (d2)로 강등, MOV류는 효과 동등이나 표기 divergence로 별도 표기.

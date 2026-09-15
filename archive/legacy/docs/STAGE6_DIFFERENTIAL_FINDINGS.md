# Stage 6 — 바이트 레벨 차등 인코딩 분석 (v1)

## 설계 (교수님 v1 요구 3가지 반영)
- **독립 오라클**: `as`(binutils) vs `llvm-mc`(LLVM 20) — 서로 다른 코드베이스. gcc는 as와 중복이라 제외.
- **의미 판정은 바이트가 아니라 디코드로**: `iced-x86`(독립 디코더)로 as 바이트와 llvm 바이트를 **양쪽 다 디코드**해 의미 동등성 판정. → (b)동등인코딩과 (d)의미불일치를 분리.
- **SDM opcode 열의 역할**: 템플릿이라 per-instance 정밀 오라클 아님 → 향후 구조적 sanity check로만 (v1 범위 밖).

지표는 통과율이 아니라 **(c)+(d)+(f) 불일치 수**.

## 분류 결과 (n=4,650, 현재 코퍼스)
| 코드 | 카테고리 | 건수 | 의미 |
|---|---|---:|---|
| a | byte_identical | 4,491 | 두 어셈블러 바이트 동일 |
| b | equiv_encoding | 11 | 바이트 다르나 iced 디코드 의미 동일(동등 인코딩) |
| c | support_diff | 105 | 한쪽만 accept (지원 범위 차이) |
| **d** | **semantic_divergence** | **17** | 둘 다 accept·바이트 다름·의미 다름 → **red flag** |
| f | decode_disagree | 19 | 어셈블러는 accept, iced는 invalid |
| e | both_reject | 7 | 둘 다 reject |

> ⚠️ 주의: 현재 입력은 여전히 퇴화(피연산자 최소)라 이 수치는 **불일치의 하한**이다.
> 입력 다양화(#3: r8–15/xmm8–31, disp/SIB/RIP, imm 경계, {er}/{sae}/{1toN}) 후 재측정 필요.

## (d) semantic_divergence 17건 — 근본원인별 (as vs llvm-mc)
### 클러스터 1: operand-size(66h)/REX.W 불일치 (11건)
피연산자 크기가 암묵/모호한 명령에서 두 어셈블러가 프리픽스를 다르게 붙임.
| source | as | llvm-mc |
|---|---|---|
| `call DWORD PTR [rax]` | `66 ff 18` | `ff 18` |
| `call TBYTE PTR [rax]` | `48 ff 18` (REX.W) | `ff 18` |
| `jmp DWORD/TBYTE PTR [rax]` | `66../48..` | `ff 28` |
| `iret` | `cf` (→iretd) | `66 cf` (→iret) |
| `mov ax, ds` | `66 8c d8` | `8c d8` |
| `mov rax, ds` | `8c d8` | `48 8c d8` (REX.W) |
| `push/pop fs/gs` | `0f a0..` | `66 0f a0..` |

→ far 간접 분기·세그먼트 레지스터 이동·IRET·PUSH/POP seg 에서 66h/REX.W 처리가 갈림.
   위협 모델(#5)의 "중복·모호 인코딩 → 도구 간 해석 불일치"에 직접 연결됨.

### 클러스터 2: VP2INTERSECTD/Q ModRM 불일치 (6건)
| source | as | llvm-mc |
|---|---|---|
| `vp2intersectd k1, xmm2, xmm3` | `62 f2 6f 08 68 cb` | `62 f2 6f 08 68 c3` |

→ 마지막 ModRM 바이트가 `cb` vs `c3`. 마스크쌍 목적지(k1:k1+1) 인코딩을 두 어셈블러가
   다르게 처리. EVEX 특유의 subtle 인코딩 divergence (검토·매뉴얼 대조 필요).

## (f) decode_disagree 19건 — 어셈블러 accept vs iced invalid
- **gather (vgatherdpd/…, vpgatherdd/…, 16건)**: 두 어셈블러가 **동일 바이트**를 내지만
  iced 는 invalid. 원인 후보: gather 는 dest/index/mask 레지스터가 서로 달라야 하는데
  (SDM 제약) 현재 테스트가 겹치는 레지스터를 씀 → CPU 는 #UD, 어셈블러는 수용.
  **어셈블러 vs 아키텍처 유효성 divergence** = 보안 각도(디스어셈블러/샌드박스 오판)로 가장 유망.
- 바레 프리픽스 `lock`, `xacquire`, `xrelease` (3건): 단독으로는 invalid — 생성기 의미 제약(#4) 부재의 증거.

## (c) support_diff 105건 — llvm-mc 가 reject (대표)
- MPX `bnd*` (11): LLVM 이 MPX 지원 제거 → as accept, llvm reject.
- KNL gather/scatter prefetch `vgatherpf*/vscatterpf*` (16): 동일하게 LLVM 미지원.
- 상대분기 `Jcc/jmp/loop/jecxz/xbegin` (다수): 타겟 `.` 처리 차이 추정 → 검토 필요.
- `movsxd`(4), `lsl`, `clrssbsy`, `int1`, `rstorssp` 등.

## 결론 및 다음 단계
- **"차등이 실제로 바이트로 나온다"를 확인**: (d)17 + (f)19 + (c)105 = 141 불일치.
- iced 양방향 디코드가 (b)11건(동등 인코딩)을 (d)에서 분리 → raw diff였다면 노이즈에 묻혔을 것.
- v1 하니스 자체 버그(llvm 다중 encoding 줄 중 첫 줄만 취함)도 이 과정에서 발견·수정 → 가짜 (d) 8건 제거.
- **다음**: (1) 입력 다양화(#3)로 이 하한을 확장, (2) (d)/(f) 각 클러스터를 SDM·XED로 근본원인 규명, (3) 그 분포를 보고 위협 모델(#5) 확정.

## 재현
```
python src/stage6_differential/diff_encode.py            # 전체
python src/stage6_differential/diff_encode.py --limit 200 # 샘플
# 필요: WSL, GNU as/objcopy/xxd, llvm-mc(LLVM), python iced-x86
# 산출물: data/stage6_differential/step6_diff.csv
```

---

## 입력 다양화 — 축 C (EVEX disp8*N) 재측정 결과 (2026-07-02)

STAGE3_DESIGN_GUIDELINES §3.3의 최우선 축. 각 EVEX 메모리 form에 disp 경계 3점(C1/C2/C3)을
생성해 "disp8*N 압축 경계에서 어셈블러 간 인코딩 길이가 갈리는지" 측정.
- **N 추정**: disp8 스케일 N = 메모리 오퍼랜드 접근 바이트 수(= 메모리 크기 토큰). full-vector
  m512/m256/m128 → 64/32/16, scalar m64/m32 → 8/4. 브로드캐스트는 축 D로 분리.
- **경계 3점**: C1 `[rax+N]`(N 배수 → disp8*N 1바이트), C2 `[rax+N/2]`(배수 아님 → disp32 강제),
  C3 `[rax+0x7F*N]`(disp8*N 상한).
- 생성: `data/stage3_operands/step3_generated_axisC.s` (4,810건), 측정 산출물
  `data/stage6_differential/step6_diff_axisC.csv`.

| 코드 | 카테고리 | 건수 |
|---|---|---:|
| a | byte_identical | 4,807 |
| e | both_reject | 3 |
| **c+d+f 불일치** | — | **0** |

**결론 (중요·음성 결과)**: as와 llvm-mc는 disp8*N 압축을 **완전히 동일하게** 구현한다.
C1(disp8*N)·C2(disp32 강제)·C3(상한) 모든 경계에서 바이트가 일치 → 이 축에서는
어셈블러 간 divergence가 **발생하지 않는다**. disp8*N은 tupletype이 N을 결정론적으로
고정하므로 재량의 여지가 없다는 SDM 규정(§2.7.5)과 정합.
- 방법론 함의: "측정 가치 최대"로 예상했으나 결과는 0 divergence. 이는 **하니스가 정상 동작할 때
  일치도 정확히 잡아낸다**는 음성 대조군(negative control) 역할 — divergence 지표의 신뢰도를 높인다.
- both_reject 3건: `vpmovqd XMMWORD PTR [rax+..]{k1}, xmm2` — VPMOVQD VL=128 "Half Mem" form은
  SDM 표기가 `xmm1/m128`이나 실제는 qword→dword 절단 저장(64비트, N=8)이라 토큰 크기≠실제 크기.
  토큰 기반 N 추정의 알려진 한계(0.06%)이며 축 C 결론에 영향 없음.
- 부수 수정: store form의 메모리 목적지에 붙은 `{z}`(SDM 슬래시 대안 공유 표기)는 #UD(Table 2-42)이므로
  축 C 생성 시 제거(merge만 유지). 이 `{z}`+store 조합 자체는 향후 음성셋 N3의 재료.

## 입력 다양화 — 축 A(주소지정 8종) · 축 D(broadcast) 재측정 (2026-07-02)

### 축 D — EVEX 브로드캐스트 D3 (§3.4)
bcst 슬래시 대안이 있는 EVEX form에 `[rax]{1toK}` (K=VL/element) 생성. 880건.
산출: `step3_generated_axisD.s`, `step6_diff_axisD.csv`.

| 카테고리 | 건수 |
|---|---:|
| byte_identical | 880 |
| **c+d+f 불일치** | **0** |

**결론**: 브로드캐스트 `{1toK}` 인코딩도 as·llvm-mc 완전 일치. disp8*N(축 C)과 마찬가지로
결정론적이라 divergence 없음. (D2 순수 메모리 형은 축 C에 포섭되어 별도 생성 생략.)

### 축 A — 메모리 주소지정 8종 A1–A8 (§3.1, 비-EVEX)
disp8/disp32/SIB/base-less SIB/RIP/절대/r13 강제 8종을 비-EVEX 메모리 form에 전개. 13,808건.
산출: `step3_generated_axisA.s`, `step6_diff_axisA.csv`.

| 코드 | 카테고리 | 건수 |
|---|---|---:|
| a | byte_identical | 13,587 |
| c | support_diff | 125 |
| d | semantic_divergence | 40 |
| e | both_reject | 56 |

**핵심 결론 (부분 음성 결과)**: 주소지정 형태 변주는 **새로운 인코딩 divergence를 만들지 않는다**.
- (d) 40건 = `call`/`jmp`(far, DWORD/TBYTE PTR) + `lsl`뿐이며 8개 주소형태에 **균등(각 5건)** 분포.
  → 이미 알려진 operand-size(66h/REX.W) 클러스터가 주소지정과 **직교하게** 재현될 뿐, 주소형태
  자체가 원인이 아님.
- (c) 125건 = as accept·llvm reject가 **65:1**. MPX(`bnd*`)·문자열 op(cmps/movs/…)·CET
  (clrssbsy/rstorssp)·`movsxd` 등 llvm-mc 미지원 명령. base-less SIB(A5)·절대(A7) 형태에서
  as의 관대한 파싱이 가장 크게 갈림(A5=36, A7=30 vs 기타 ~10).
- **구조적 인코딩 합의**: A4(SIB base+index)·A6(RIP-relative)·A7(절대)·A8(r13 mod=00 불가 → 강제
  disp8=0)의 특수 ModRM/SIB 인코딩은 대부분 byte_identical. 두 어셈블러가 완전 합의.

**종합**: 축 C(disp8*N)·축 D(broadcast)·축 A(주소지정)는 모두 as/llvm-mc가 인코딩에 합의 →
이들 축은 divergence 원천이 아니다(하니스 신뢰도 검증용 음성 대조군). 실질 divergence는 여전히
(1) operand-size 모호 명령(far call/jmp·seg mov·iret — ROOTCAUSE 사례 3 계열),
(2) 음성셋 N1(gather aliasing #UD)·N2(VP2INTERSECT 정규화)에 집중.
→ 다음 다양화 우선순위는 "주소/disp 축"이 아니라 **operand-size 강제 축**과 **음성셋 확장(N3–N8)**.


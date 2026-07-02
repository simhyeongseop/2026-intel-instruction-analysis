# Stage 3 설계 지침 — SDM Ch.1–3 기반 오퍼랜드 매핑·다양화 규칙

작성일: 2026-07-02
근거 문서: Intel SDM Vol.2 (325383-090US, 2026-02)
- Chapter 2 "Instruction Format" (Vol.2A 2-1 ~ 2-44)
- Chapter 3 도입부 §3.1.1 "Interpreting the Instruction Reference Pages" (Vol.2A 3-1 ~ 3-15)
- Chapter 1 은 매뉴얼 구성 안내라 본 지침에서 인용하지 않는다.

적용 대상 코드: `src/stage3_operand_processing/step3_operand_mapping.py`
후속 소비자: Stage 5 roundtrip (`step5_roundtrip.py`), Stage 6 differential (`diff_encode.py`)

---

## 0. 이 문서의 역할

Stage 3는 "SDM의 오퍼랜드 **타입 표기**를 구체 어셈블리 **값**으로 바꾸는" 단계다.
지금까지의 규칙은 경험적(어셈블 성공률 기반)으로 만들어졌다. 이 문서는 그 규칙을
**SDM 원문 규정으로 재정의**하고, 다음 3가지를 명세한다.

1. **매핑 사전의 규범화** — 각 타입 토큰의 의미를 §3.1.1.3 원문으로 고정 (§2)
2. **입력 다양화(#3)의 축** — Ch.2 인코딩 구조에서 도출한 변주 축 (§3)
3. **양성/음성 테스트 분리** — Ch.2 #UD 규정을 음성 테스트 오라클로 사용 (§4)

원칙: **"정답은 매뉴얼"** — 어셈블러가 받아주는지가 아니라 SDM이 정의하는지가 기준.
어셈블러 수용 여부는 Stage 6의 *측정 대상*이지 Stage 3의 *정당성 근거*가 아니다.

---

## 1. SDM 챕터 → Stage 3 활용 지도

| SDM 위치 | 내용 | Stage 3에서의 용도 |
|---|---|---|
| §2.1.1 (2-1) | 프리픽스 4그룹 (LOCK/REP, 세그먼트, 66h, 67h) | 프리픽스 변주 축 + REP 결합 제약 |
| §2.1.3 (2-3) | ModR/M·SIB 구조 (mod 32가지 조합) | 메모리 주소지정 형태 변주 축 |
| §2.1.5, §2.2.1 | 주소지정 인코딩 표, REX | disp8/disp32, RIP-relative, r8–r15 접근 |
| §2.3 | VEX 프리픽스 (2-byte C5 / 3-byte C4) | VEX 명령 다양화 시 W/L/pp 의미 |
| §2.7.1–2.7.2 (2-36~39) | EVEX 비트필드, 32-레지스터 인코딩 | xmm16–31, EVEX 전용 레지스터 축 |
| §2.7.3–2.7.4 (2-40) | opmask 인코딩, k0 제약, merging/zeroing | `{k}`/`{z}` 생성 규칙 |
| §2.7.5 (2-41) | disp8*N 압축 displacement, tupletype | **disp 경계값 변주 축 (최고 가치)** |
| §2.7.6–2.7.10 | broadcast / {er} / {sae} 적용 조건 | 데코레이터 생성 조건 |
| §2.7.11 (2-43~44) | **#UD 방정식** (opcode 독립/의존) | **음성 테스트 오라클** |
| §3.1.1.1–3.1.1.2 (3-2~7) | opcode 열 표기 (NP, /r, ib, +rb, VEX/EVEX 템플릿) | Stage 1 파서 사전과 향후 구조적 sanity check |
| §3.1.1.3 (3-7~12) | **오퍼랜드 심볼 사전** (r/m8, xmm/m128, {er}...) | **매핑 사전의 규범 원문** |
| §3.1.1.4 (3-13) | 64-bit mode 열 (V/I/N.E./N.P./N.I./N.S.) | Stage 1 필터 근거 (현행 유지) |

---

## 2. 오퍼랜드 매핑 사전의 규범화 (§3.1.1.3 기반)

### 2.1 GP 레지스터 — 대표값 + 변주 풀

SDM 정의 (3-8): r8 = {AL,CL,DL,BL,AH,CH,DH,BH,BPL,SPL,DIL,SIL} + R8B–R15B(REX).
현행 코드는 `r8→al, r16→ax, r32→eax, r64→rax` 고정. **대표값으로는 유지**하되,
변주 풀을 다음과 같이 정의한다.

| 타입 | 대표값(현행) | 변주 풀 (다양화 시) | SDM 근거 |
|---|---|---|---|
| r8 | al | cl, **sil**(REX 필요), **ah**(REX 불가), r8b–r15b | 3-8: AH~BH는 REX와 함께 인코딩 불가, SIL 등은 REX 필수 |
| r16 | ax | cx, di, r10w | 66h 프리픽스 유발 |
| r32 | eax | ecx, esp, r11d | — |
| r64 | rax | rcx, **rsp, rbp, r12, r13**, r15 | RSP/RBP/R12/R13은 ModRM/SIB 특수 인코딩 유발 (§2.1.5) |

**핵심 규칙 (r8)**: `ah`+REX 조합과 `sil`(REX 필수)은 **같은 form에서 배타적** —
이 경계 자체가 어셈블러 divergence 후보이므로 양쪽 모두 변주 풀에 포함한다.

### 2.2 벡터 레지스터 — 인코딩 계층별 3단 풀

SDM 근거: xmm0–7(base), xmm8–15(REX/VEX, 3-10), xmm16–31(EVEX 전용, Table 2-33).

- 대표값: 현행(타입 인덱스 그대로: xmm1→xmm1) 유지.
- 변주 풀: **{xmm2(저), xmm9(REX 대역), xmm25(EVEX 대역)}** 3단.
  - xmm16–31은 **EVEX로만 인코딩 가능** → VEX 명령에 xmm16+를 넣으면
    어셈블러가 (a)EVEX로 승격, (b)거부 중 하나를 택한다. **이 선택이 도구별로
    갈리는지가 Stage 6의 좋은 측정 지점** (as vs llvm-mc 승격 정책).
- ymm/zmm 동일 원칙. mm은 0–7, bnd는 0–3 (3-10).

### 2.3 opmask — k0 제약과 쌍 제약

SDM 규정:
- §2.7.4 (2-40): predicate 오퍼랜드(`{k1}`)로는 **k1–k7만** 가능. k0은 일반
  source/dest로는 가능하나 predicate로 인코딩 불가 (EVEX.aaa=000 = 마스크 없음).
- Table 2-35 각주: 마스크를 덮어쓰는 명령(gather/scatter)은 k0을 embedded mask로 불허.
- Table 2-42: `EVEX.aaa=000`인데 opmask 필수 명령이면 #UD, opmask 미사용 명령에 aaa≠000이면 #UD.

규칙:
- 현행 `k0→k1` 보정은 **SDM 근거 있음, 유지**.
- `{z}`는 **store/gather/scatter에 금지** (Table 2-42: EVEX.z≠0이면 #UD).
  → 생성기는 명령 클래스를 보고 `{z}` 부여 여부를 결정해야 한다. 현행처럼
  SDM form에 적힌 `{z}`를 그대로 유지하는 것은 안전(매뉴얼이 이미 클래스 반영).
- **VP2INTERSECT 계열**: 목적지 마스크쌍은 **짝수 k만 생성** (STAGE6_ROOTCAUSE 사례 2 —
  홀수 k는 저비트 마스킹으로 정규화 정책 divergence 유발). 홀수 k1은 음성/경계
  테스트로 분리 (§4).

### 2.4 메모리 오퍼랜드 — 타입별 PTR 규칙 (현행 확정 + 근거 보강)

SDM 정의 (3-8~9): `m` = "16/32/64-bit 메모리", `m8`/`m16`은 "string 명령 전용 명명",
`m128` 등은 크기 고정 블록.

- `m` → bare `[rax]` (7회 미팅 반영, 유지). **단** SDM이 "16/32/64-bit"로 정의하므로
  objdump가 크기를 추론 출력하는 것은 정상 (`generic_memory_size_inferred`) — 분류 유지.
- `m8/m16/m32/m64` → `BYTE/WORD/DWORD/QWORD PTR` (유지).
- `m16:16/m16:32/m16:64` far pointer → `DWORD/FWORD/TBYTE PTR` (유지).
  Stage 5의 LSS/LFS/LGS 30건 objdump 오류가 이 계열 — PTR 표기는 SDM 크기(2+2/2+4/2+8)와
  일치하므로 **소스가 옳다**는 근거 문서화.
- `mib`(BNDLDX), `sibmem`(AMX): **SIB 바이트 필수** (§2.1.3) → 반드시
  `[rax+rbx*1]` 형태로 생성해야 한다. 현행 bare `[rax]`는 as가 SIB 없는 형태로
  인코딩할 수 있어 **불충분 — 수정 필요**.
- `moffs8/16/32/64` (3-9): ModRM 없이 절대 오프셋 직접 인코딩 → `[0x1000]` 유지.
  단 moffs는 **64-bit 오프셋**이 기본이므로 8바이트 주소 경계도 변주 후보.

### 2.5 슬래시 대안 (r/m, xmm/m128/m64bcst)

- 현행 "레지스터 형 우선"은 v1로 유지. 단 **다양화 시 m-형과 bcst-형도 별도 인스턴스로
  전개**한다 (§3.4). SDM 3-12: `zmm/m512/m32bcst` = 3가지 서로 다른 인코딩
  (reg / 풀 메모리 / EVEX.b=1 브로드캐스트) — 각각 disp8*N 계수가 다르다 (Table 2-36).
- GP 크기 대안(r16/r32/r64)의 r64 선호: 유지. 단 r16 선택 시 66h가 붙는 것 자체가
  Stage 6 클러스터 1(66h/REX.W divergence)의 재료이므로 다양화 대상.

### 2.6 데코레이터 — 생성 조건을 SDM으로 제한

| 데코레이터 | SDM 조건 (원문 근거) | 생성 규칙 |
|---|---|---|
| `{k1}` | EVEX.aaa, k1–k7만 (§2.7.4) | form에 있으면 유지 (현행) |
| `{z}` | store/gather/scatter #UD (Table 2-42) | form에 있으면 유지, 임의 부여 금지 |
| `{er}` | **reg-reg 형 + rounding semantic + scalar/512-bit만** (§2.7.8, 3-12) | 현행 제거 → **다양화 시 reg-reg 형에 한해 재부여** (RN/RD/RU/RZ 4종, Table 2-38) |
| `{sae}` | reg-reg 형 + 비rounding FP 산술 (§2.7.9) | 동일 |
| `{1toN}` | load+op + 32/64-bit 요소만, 순수 load/store 불가 (§2.7.7) | 현행 제거 → 다양화 시 m-형 인스턴스에 재부여 |
| `<XMM0>` 등 | 인코딩에 미반영 암묵 오퍼랜드 (3-10) | 생략 (현행 유지) |

`{er}`을 메모리 형에 붙이거나 `{1toN}`을 pure-load에 붙이면 #UD (Table 2-38 "Other
Instructions: EVEX.b must be 0") → **음성 테스트 재료** (§4).

### 2.7 즉시값·상대주소

- `imm8/16/32/64` (3-9): 현행 `0x1` → 대표값 유지. 변주 풀: **경계값**
  `{0, 1, 0x7F, 0x80, 0xFF}` (imm8), `{0x7FFF, 0x8000}` (imm16),
  `{0x7FFFFFFF, 0x80000000}` (imm32) — 부호확장 vs 제로확장 해석,
  imm8 sign-extended 형(예: 83 /0 vs 81 /0) **인코딩 선택 divergence**의 재료.
- `rel8/rel16/rel32` (3-7): 현행 `.` 은 offset=0의 rel8만 검사. 변주:
  `.+0x7F`(rel8 최대), `.+0x80`(rel8 초과 → rel32 강제), `.-0x80`.
  rel16은 64-bit 모드에서 N.S. 계열이므로 생성하지 않는다.
- `ptr16:16/ptr16:32` far 직접호출: 64-bit 모드 N.E. — Stage 1에서 이미 필터됨, 생성 금지.

---

## 3. 입력 다양화(#3)의 축 — Chapter 2 인코딩 구조 기반

> 목표: "퇴화 입력(피연산자 최소)"이 만든 **불일치 하한**을 인코딩 공간의 대표점으로 확장.
> 축은 임의 조합이 아니라 **Ch.2가 정의한 인코딩 필드 단위**로 잡는다.

### 3.1 축 A — 메모리 주소지정 형태 (ModRM.mod × SIB, §2.1.3/§2.1.5)

mod 필드가 만드는 대표 형태 8종:

```
A1  [rax]              mod=00 직접
A2  [rax+0x7f]         mod=01 disp8
A3  [rax+0x80]         mod=10 disp32 (disp8 경계 초과)
A4  [rax+rbx*4]        SIB (base+index*scale)
A5  [rbx*8+0x10]       SIB base 없음 (mod=00, base=101)
A6  [rip+0x100]        RIP-relative (64-bit 신설, §2.2.1.6)
A7  [0x1000]           절대 (SIB, no base no index)
A8  [r13]              mod=00 불가 레지스터 → 강제 disp8=0 (특수 인코딩)
```

- A8 (rbp/r13 base, rsp/r12 SIB escape)은 **어셈블러가 자동으로 우회 인코딩을
  선택하는 지점** — 도구 간 선택 차이 후보.
- EVEX 명령이면 A2/A3의 disp 값을 **disp8*N 경계**로 잡는다 (§3.3).

### 3.2 축 B — 프리픽스 (§2.1.1, 4그룹)

- Group 1: `lock` — **쓰기 메모리 목적지 형에만** 부여 (SDM: 다른 사용은 #UD/reserved).
  `rep/repne` — **string/IO 명령에만** (SDM 2-2: "다른 명령과의 사용은 reserved,
  unpredictable"). 현행 bare `lock`/`xacquire` 단독 라인은 삭제하고 결합형으로 생성.
- Group 2: 세그먼트 오버라이드 `fs:`/`gs:` — 64-bit에서 유의미한 둘만. `cs:/ds:/es:/ss:`는
  64-bit에서 무시됨(널 오버라이드) → 무시 여부 표기가 디스어셈블러마다 다름, 변주 가치 있음.
- Group 3 (66h)·Group 4 (67h): 오퍼랜드 크기 대안 선택(r16 vs r32)과 주소 크기
  (`[eax]` vs `[rax]`)로 **간접 유발**한다. 명시적 프리픽스 바이트 주입은 Stage 3 범위 밖.

### 3.3 축 C — EVEX disp8*N 압축 displacement (§2.7.5) ★최우선

Table 2-36/37: EVEX 메모리 오퍼랜드의 disp8은 tupletype·VL·EVEX.b가 정하는 N의 배수로
압축된다. **disp가 N의 배수면 disp8*N 1바이트, 아니면 disp32 4바이트** — 이 선택은
어셈블러 재량이며 바이트 길이가 달라진다.

각 EVEX 메모리 form에 대해 3점 생성:
```
C1  [rax+N]      (N의 배수, disp8*N 인코딩 가능)     예: zmm full → [rax+0x40]
C2  [rax+N/2]    (배수 아님 → disp32 강제)           예: [rax+0x20]
C3  [rax+0x7F*N] (disp8*N 상한)                      예: [rax+0x1FC0]
```
N은 명령 페이지의 tupletype에서 결정된다(Full/Half/Scalar/Tuple1…, Table 2-36/37).
v1 근사: **요소크기×VL 기반 추정 N**으로 시작하고, 추정 오류 자체도 Stage 6이 잡아준다
(as와 llvm이 같은 N을 쓰는지가 바로 측정 대상).

### 3.4 축 D — reg/mem/bcst 대안 전개 (§2.7.7)

슬래시 대안 form은 최대 3 인스턴스로 전개:
```
D1  vaddpd zmm1, zmm2, zmm3            (reg 형, 현행)
D2  vaddpd zmm1, zmm2, [rax]           (m512 형)
D3  vaddpd zmm1, zmm2, [rax]{1to8}     (m64bcst 형, EVEX.b=1)
```
D3의 N은 요소 크기(8)로 바뀜에 유의 (Table 2-36 broadcast 행).

### 3.5 축 E — 레지스터 대역 (§2.7.2 Table 2-33)

§2.1(r8–r15=REX), §2.7.2(xmm16–31=EVEX 전용)에 따라 GP {저/REX}, 벡터 {저/REX/EVEX} 대역별
1개씩. VEX 명령 + xmm16 조합은 **의도적 경계 테스트**로 별도 표기 (§4).

### 3.6 축 F — {er}/{sae} 라운딩 (§2.7.8–2.7.10)

reg-reg + rounding semantic form에 한해 `{rn-sae}/{rd-sae}/{ru-sae}/{rz-sae}` 4종 부여.
EVEX.RC=L'L 재해석(Table 2-38)이라 **VL 정보가 사라지는** 지점 — 디스어셈블러 표기
차이(예: {rn-sae} 유무) 관찰 가치 높음.

### 3.7 조합 정책

전체 곱집합은 폭발한다. **1-축 변주 원칙**: 대표 인스턴스(현행 4,650) + 각 축에서
한 번에 하나만 변주. 예상 규모: 메모리 form ×(A 8종) + EVEX form ×(C 3종 + D 2종)
+ 전 form ×(E 2~3종) ≈ 3~5만 라인 — Stage 6 하니스(WSL 루프)로 처리 가능한 수준.
CSV에 `variant_axis`, `variant_value` 컬럼을 추가해 어느 축의 변주인지 기록한다.

---

## 4. 음성 테스트(negative set) — §2.7.11 #UD 방정식을 오라클로

지금까지 무효 인코딩이 **우연히**(레지스터 재사용) 생겼다. 이를 **의도적 음성 셋**으로
분리하고, 각 케이스에 SDM 근거를 태깅한다. 파일 분리: `step3_generated_negative.s`.

| ID | 케이스 | SDM 근거 | 기대 동작 |
|---|---|---|---|
| N1 | gather: dest=index 또는 dest=mask | VGATHER 페이지 "#UD if any pair … are the same" | CPU #UD. 어셈블러 수용 여부 측정 (사례 1 재현) |
| N2 | VP2INTERSECT 홀수 목적지 k1 | p.1894 저비트 마스킹 | 수용되나 정규화 divergence 측정 (사례 2) |
| N3 | `{z}` + store/scatter | Table 2-42 | #UD — 어셈블러가 거부하는가? |
| N4 | `{1toN}` + pure load (예: vmovaps) | §2.7.7, Table 2-38 | #UD (EVEX.b must be 0) |
| N5 | `{er}` + 메모리 오퍼랜드 | §2.7.8 (reg-reg only) | 어셈블러 거부 or 잘못 수용 |
| N6 | opmask 필수 명령에 마스크 생략 (gather) | Table 2-42 aaa=000 #UD | 측정 |
| N7 | `rep` + 비string 명령 (예: rep add) | §2.1.1 "reserved, unpredictable" | 어셈블러는 대개 수용 — 디코더 표기 차이 측정 |
| N8 | VEX 명령 + xmm16+ | Table 2-33 (EVEX 전용 대역) | EVEX 승격 vs 거부 divergence |

음성 셋의 Stage 6 지표는 "(어셈블러 수용) × (iced invalid/valid)" 2×2 매트릭스로
집계한다 — 연구의 핵심 스토리(어셈블러 vs 아키텍처 유효성 divergence)와 직결.

---

## 5. 현행 코드 대비 변경 목록 (우선순위순)

1. **[P0] 음성 셋 분리 + 레지스터 distinctness**: gather/scatter 계열에 dest≠index≠mask
   보장 (양성), aliasing은 N1으로 이동. VP2INTERSECT 짝수 k (양성) / 홀수 k (N2).
2. **[P0] `mib`/`sibmem` → SIB 강제 형태** `[rax+rbx*1]`로 수정 (§2.4).
3. **[P1] 축 C (disp8*N)** — EVEX 메모리 form에 C1–C3 3점 생성. 측정 가치 최대.
4. **[P1] 축 A (주소지정 8종)** — 전 메모리 form에 적용하되 대표 form당 1축 변주.
5. **[P1] 축 D (m-형/bcst-형 전개)** — 슬래시 대안의 메모리·브로드캐스트 인스턴스.
6. **[P2] 축 E (레지스터 대역)**, imm/rel 경계값 (§2.7), `{er}/{sae}` 재부여 (축 F).
7. **[P2] bare `lock/xacquire/xrelease` 라인 제거** → 결합형 생성 (§3.2).
8. **[P3] SDM opcode 열 구조적 sanity check** — Stage 6 v1 범위 밖 항목. 템플릿
   (VEX.128.66.0F.W0 등)과 실제 바이트의 프리픽스/W/L 일치 검사 (§3.1.1.2 표기 사전 활용).

## 6. 산출물 스키마 변경

`step3_coverage.csv` → 컬럼 추가:
```
variant_axis      (base | addr | disp8N | alt_form | regband | rounding | negative)
variant_value     (예: A4, C2, D3, N1)
expected_valid    (true | false | undefined)   ← 음성 셋 구분
sdm_basis         (예: "2.7.5 Table 2-36", "VGATHERDPS p.1827")
```
`expected_valid=false`인 행이 Stage 6에서 both-accept로 나오면 그것이 곧
"어셈블러 vs 아키텍처" divergence 발견이다.

---

## 7. Description(DB) 대조 검증 결과 (2026-07-02)

`scripts/verify_descriptions.py` — DB 설명문에서 아키텍처 제약을 추출하고 양성 base 세트를 대조.
산출: `data/stage3_operands/step3_constraint_inventory.csv`.

### 7.1 제약 인벤토리 (근거 문장 561건 / 제약 보유 명령 401개)
| 제약 유형 | 명령 수 | 용도 |
|---|---:|---|
| ud_generic (#UD/UD fault 언급) | 377 | N3–N8 확장 후보 풀 |
| evex_b (embedded rounding/broadcast) | 40 | N4/N5 (`{er}`/`{1toN}` 오용) 후보 |
| mask_lowbit (저비트 마스킹) | 6 | **N2 근거 재확인** (VP2INTERSECTD/Q 포함) |
| reg_distinct (레지스터 distinctness #UD) | **0** | ↓ DB 갭 참조 |

### 7.2 검증 결론
- **N2 corroborated**: `mask_lowbit`이 VP2INTERSECTD/Q를 정탐 → N2(홀수 k 정규화)의 근거가
  DB 설명문에 존재함을 확인.
- **N1은 DB에 없음 (DB 갭)**: gather의 "#UD if any pair of index/mask/destination are the same"은
  SDM 페이지의 **Operation/Exceptions 섹션**에 있는데, DB(`instruction_descriptions.csv`)는
  **도입부 문단만** 추출해 이 텍스트가 없다. 따라서 `reg_distinct`는 0건(도입부의 서술적
  "destination same as source" 등은 UD 신호 부재로 정상 배제됨). → N1의 권위는 SDM PDF
  p.1824/1827(ROOTCAUSE 사례 1)로 유지.
  - **후속 액션(Stage 1 개선)**: description 추출을 Operation/SIMD Exceptions/Other Exceptions
    섹션까지 확장하면 #UD 제약을 체계적으로 마이닝해 N-series를 자동 확장 가능.
- **양성 세트 무결성**: 양성 base 중 VSIB(gather) form 80건 전부 dest≠index≠mask 유지 →
  aliasing 0건. 즉 aliasing은 전량 음성셋 N1으로 정상 분리됐음을 독립 검증.

---

## 부록 — 표기 사전 원문 위치 빠른 참조

| 심볼 | SDM 위치 (Vol.2A) |
|---|---|
| rel8/16/32, ptr16:16 | 3-7 |
| r8/16/32/64, r/m8~64, reg | 3-8 |
| m, m8~m128, moffs, Sreg, m16:xx | 3-8~9 |
| ib/iw/id/io, +rb~+ro, /digit, /r, NP, NFx | 3-2~3 (§3.1.1.1) |
| VEX 템플릿 표기 | 3-4~6 (§3.1.1.2) |
| mm, xmm, ymm, zmm, bcst, <XMM0> | 3-9~12 |
| {er}, {sae}, SRC1–3, MODRM 표기(11:rrr:bbb) | 3-12~13 |
| V/I/N.E./N.P./N.I./N.S. | 3-13 (§3.1.1.4) |
| EVEX 비트필드 | Table 2-32 (2-38) |
| 32-레지스터 인코딩 | Table 2-33 (2-39) |
| opmask 인코딩/k0 제약 | Table 2-35, §2.7.4 (2-40) |
| disp8*N (tupletype) | Table 2-36/37 (2-41~42) |
| broadcast/RC/SAE 컨텍스트 | Table 2-38 (2-43) |
| #UD 방정식 | Table 2-40/41/42 (2-43~44) |

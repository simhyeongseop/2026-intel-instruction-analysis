# Sol part7 원문 추출 기록 (row_id 3166~3687)

- 범위: row_id 3166~3687 (522행), 파일 1725~2005쪽, 84개 절(s0597 VF[,N]MSUB[132,213,231]PH ~ s0680 VPEXPANDB/W).
- 근거: `out/sdm_evidence_2026-10-09/rows.jsonl`, `scripts/manual_lookup.py show/page`, `data/rules/sdm_symbols.csv`, 총론 50·51·66·69·70·72~74쪽.
- 보조 스크립트: `/tmp/claude-1000/sol_part7/`(build.py, cfg*.py). 반복 칸은 스크립트로 채웠고, 절마다 읽은 원문 인용은 cfg_a~d.py에 직접 적었다.
- 읽은 범위: 모든 절의 Instruction Operand Encoding, Description(NOTES 포함), SIMD Floating-Point Exceptions, Other Exceptions는 전부 읽었다.
  Operation은 오퍼랜드와 관련된 줄(64-bit, vvvv, #UD, imm8, EVEX.b, VSIB, mask 등)만 골라 읽었고, VMOVSH·VMOVW·VP2INTERSECT는 Operation 전체를 읽었다. Intrinsic은 읽지 않았다.
- 인용 표기: PDF 줄바꿈 하이픈("loca-tion")은 이어 붙였다. `...`는 같은 소제목 안에서 문장 사이를 생략한 것이다.

## 총계

| 항목 | 수 |
|---|---|
| 행 | 522 (누락 0, 중복 0; 행마다 operand_index 0..N이 빠짐없이 들어감) |
| 전체 줄 | 2,024 (operand_index=0 줄 522 + 오퍼랜드 줄 1,502) |
| 원문 확정 | 1,714 (0번 줄 519, 오퍼랜드 줄 1,195) |
| 원문 없음 | 256 (모두 오퍼랜드 줄) |
| 원문 충돌 | 53 (0번 줄 2, 오퍼랜드 줄 51) |
| 추출 불완전 | 1 (row 3359, 0번 줄) |

status 기준: kind와 data_width가 모두 원문으로 뒷받침되면 `원문 확정`, 한 부분이라도 근거가 없으면 `원문 없음`이다. 이때 근거가 있는 부분은 값으로 채우고, 근거가 없는 부분은 칸 안에 `원문 없음`으로 남겼다.
원문 둘이 서로 다르면 `원문 충돌`로 두고 두 원문을 함께 인용했다.

## 총론 정의(SYM)와 명령 절이 충돌한 사례

1. **m16 (SYM042)**: SYM042는 "This nomenclature is used only with the string instructions"라고 한다. 그런데 VMOVSH `m16`(3426, 3427)은 문자열 명령이 아니다. 그래서 두 줄 모두 `원문 충돌`로 두었다. 같은 이유로 xmm/m16, reg/m16의 m16 부분에도 SYM042를 근거로 쓰지 않았다.
2. **{k1}{z} (SYM071) vs VPBLENDMB/W/D/Q**: SYM071은 {k1}{z}를 "instruction writemask"로 정의한다. 반면 1899·1901쪽에는 "The mask is not used as a writemask for this instruction. Instead, the mask is used as an element selector"라고 적혀 있다. 해당 12행의 1번 오퍼랜드는 `원문 충돌`이다.
3. **VSIB 지원 범위(총론 내부)**: 2.3.12(50쪽)는 "VSIB memory addressing is supported only with VEX prefix"라고 하고, 2.7.2(69쪽)는 EVEX에서 VSIB를 지원한다고 한다. EVEX gather 절(s0620, s0622)은 EVEX VSIB를 쓴다. 행 note에만 기록했고 status는 바꾸지 않았다.
4. **SYM021(NDS 표기 폐지) vs VP2INTERSECT opcode `EVEX.NDS...`**: 옛 표기가 남아 있다는 기록만 했다(충돌 status 아님).
5. **SYM064 m256**: SYM064는 "used only with AVX instructions"라고 한다. EVEX 명령(VPCOMPRESSB m256, VBROADCASTI32X8 m256 등)에도 이 표기가 쓰인다. "AVX instructions"의 범위가 원문에서 정해지지 않아 충돌로 두지 않았다.

## 명령 절 안의 원문 충돌 (status=원문 충돌)

- row 3262 VFNMADD132PD: 표 구문은 `xmm0 {k1}{z}, xmm1, xmm2/m128/m64bcst`이다(1767쪽 PDF 원문 확인). 같은 칸 설명은 "values from xmm1 and xmm3/m128/m64bcst ... add to xmm2 and put result in xmm1"이다. 0~3번 줄 모두 충돌로 두었다.
- VMINSH(3425): 스칼라 명령인데 Description이 VMINPH 문장("ZMM/YMM/XMM register, a 512/256/128-bit memory location or ... broadcast from a 16-bit memory location")을 그대로 실었다. 표의 xmm3/m16과 맞지 않는다.
- VPBLENDMD/Q(3450~3455): Description은 "ZMM registers, ... 512-bit ... broadcasted from a 32-bit memory location"만 적는다. 그래서 128/256비트 행과 Q의 m64bcst 행이 맞지 않는다.
- VPCMPD/UD/Q/UQ 128·256비트 행: Description은 broadcast를 "a 512-bit vector broadcasted"로만 적는다.
- VPERMPD/VPERMQ/VPERMPS의 EVEX.256 벡터 제어 형식(3648, 3656, 3651): Description은 "The first and second operands are ZMM registers"라고만 적는다.
- VBROADCASTI32X4 ymm(3480): Description은 목적지를 "The destination operand is a ZMM register"라고 한다.
- VPBROADCASTQ VEX.128(3471): 표에는 V/V로 실려 있다. 그런데 예외 절은 "#UD If VEX.L = 0 for VPBROADCASTQ, VPBROADCASTI128"이라고 한다(0번 줄 충돌).
- VPEXPANDB/W 레지스터 원본 행(3677, 3679, 3681, 3683, 3685, 3687): Description은 원본을 "(memory operand)"라고 했다가 "load from an int8 vector register or memory location"이라고도 한다.

## isa_db/표 추출 오류로 보이는 행

- 3410~3417 VMASKMOV: isa_db op_en이 `RV M`/`MV R`이다. PDF Op/En은 `RVM`/`MVR`이다. 그 결과 rows.jsonl의 op_en_status가 not_found다. Op/En 줄은 1878쪽 원문으로 연결했다.
- 3596 VPERM2F128: isa_db op_en이 `RV MI`이고, PDF는 `RVMI`다(같은 문제).
- 3352~3371 VGATHER*: Op/En 표 2번 칸(BaseReg/VectorReg)이 여러 줄로 나뉘어 추출됐다. EVEX gather(s0620, s0622)는 rows.jsonl op_en_lines에서 이 칸이 아예 빠졌다(`A Tuple1 Scalar ModRM:reg (w) N/A N/A`). 1820·1824·1827·1831쪽 원문으로 복원했다.
- 3359 VGATHERDPD EVEX.128: CPUID 칸의 위첨자 각주 1("AVX10.11")은 본문을 찾지 못했다(footnotes_missing). "OR"도 "R"로 깨졌다. 그래서 `추출 불완전`으로 두었다.
- `manual_lookup show`가 s0597, s0600, s0637, s0650, s0652, s0661, s0666에 대해 "이 절에서 추출된 형식 표 행이 없다"고 표시한다. rows.jsonl에는 행이 정상으로 연결돼 있다(조회 도구 쪽 연결 문제로 보임).
- 원문 자체의 오기로 보이는 것(값으로 고치지 않고 note에만 남김):
  - 3687 VPEXPANDW 표 설명 "packed byte integer values"
  - VPERMQ Description "VPERMPQ"
  - VPBROADCAST Description의 VP-/V- 니모닉 혼용
  - VPBROADCAST 예외 절이 Type 6를 "EVEX-encoded"라고 적은 것
  - VGETMANTPS의 "VEX.L must be 0"
  - VGETEXPPH의 "Table 5-8" 참조
  - VPBLENDMB의 "512/256/128-bit memory location" 반복
  - VGETEXPSH Description의 "(the second operand)"(Op/En상 원본은 3번째)

## 원문 없음이 많은 표기와 이유

| 표기(숫자 제거) | 줄 수 | 이유 |
|---|---|---|
| zmm (단독) | 178 | 3.1.1.3 표기 목록에 `zmm` 단독 정의가 없다. 절 Description이 "ZMM/YMM/XMM register"라고 하면 kind=register는 확정이다. 하지만 ZMM 레지스터의 비트 폭을 적은 문장이 없어 data_width=원문 없음이다(표 설명이 "512-bit destination"/"up to 512 bits"라고 한 VPBROADCAST GPR·VPCOMPRESS·VPEXPAND는 확정). FP16 절은 종류 문장도 없다. |
| ymm/m256/m*bcst, xmm/m128/m*bcst | 40 | SYM에는 zmm/m512/m32bcst·m64bcst만 있다. xmm/ymm broadcast와 m16bcst 정의가 없고, 해당 절(FP16 FMA·VGETEXPPH·VMULPH·VPDPBUSD·VP2INTERSECT 등)도 broadcast 폭을 적지 않는다. |
| xmm/m16, xmm/m8 | 19 | 총론 정의가 없다(m16은 문자열 전용). FP16 스칼라 절과 VPBROADCASTB/W VEX.128·EVEX 행에는 종류 문장이 없다. |
| zmm/m512/m16bcst | 13 | m16bcst 정의가 없다(FP16 packed 절). |
| k1+1 | 6 | 총론 정의가 없다. 절은 짝/홀 마스크 쌍이라고만 하고 폭 문장이 없다. |

## 기타 기록

- EVEX 행의 XMM/YMM 레지스터 목록은 SYM058/SYM063의 0~15만 원문이다. 16~31의 이름은 원문에 없다. 총론 2.7은 "EVEX prefix can encode 32 vector registers (XMM/YMM/ZMM) in 64-bit mode"라고만 한다. 이 내용을 해당 줄 note와 mode_64_text에 적었다.
- address_size_text는 gather 4개 절(s0619~s0622)에만 원문이 있다(16비트 주소 크기/유효주소이면 #UD). 나머지 절은 빈칸이다.
- 64비트 모드 특유 원문은 VPBROADCASTQ r64 각주 1("EVEX.W in non-64 bit is ignored")과 64/32 열 `V/N.E.` 정도다. 나머지 행은 64/32 열 V/V와 SYM092/SYM099만 적었다.
- Op/En 표에 imm8 칸이 없는(N/A) 절: VFPCLASSPD/PS/SD/SS, VGETMANTSD/SS, VPCMPB/UB/W/UW, VPERMILPD/PS imm 형식(B/D). imm8 줄의 op_en_role은 `N/A`로 두고 note에 적었다.
- FP16(MAP5/MAP6) 절의 Op/En 표는 EVEX 명령인데도 `VEX.vvvv`로 적혀 있다. 원문 그대로 두었다.

## 확인하지 못한 것

- VGETMANTPD/PS/SD/SS의 Figure 5-15(1851쪽)는 그림이 텍스트로 깨졌다. 그래서 "Must Be Zero" 비트 범위를 텍스트로 확정하지 못했다(PH 절 Table 5-17은 imm8[7:4]). PDF 그림을 직접 보지는 않았다.
- 3359 CPUID 각주 1의 본문.
- 기호만 있는 줄로 표시된 쪽(1733, 1761, 1769, 1776, 1789, 1796, 1821, 1824, 1825, 1828, 1831, 1832, 1834, 1835, 1842, 1843, 1855, 1856, 1864, 1981)의 수식·그림은 PDF와 대조하지 않았다.
- 총론 2장 예외 분류표(Type 2/3/4/6/12, E2~E12)의 개별 조건은 열어 보지 않았다. 행에는 분류 이름만 인용했다.
- Operation은 키워드로 고른 줄만 읽었으므로(위 "읽은 범위"), Operation에만 있는 제약을 놓쳤을 수 있다.

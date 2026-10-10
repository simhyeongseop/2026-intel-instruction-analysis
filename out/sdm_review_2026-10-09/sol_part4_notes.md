# Sol part4 원문 추출 노트 (row_id 1579~2109, 파일 923~1157쪽, PAND ~ VPSLLQ)

작성 2026-10-09. 지침: `docs/SOL_EXTRACTION_GUIDE.md`. 입력은 `out/sdm_evidence_2026-10-09/rows.jsonl`,
`data/rules/sdm_symbols.csv`, `scripts/manual_lookup.py`(절·쪽 원문, 총론 2장 45~47·52~53·58~60·66·69·70쪽)이다.
보조 스크립트는 `/tmp/claude-1000/sol_part4/`(gen.py, manual.py)에만 두었다. 어셈블러·CPU 실행은 하지 않았다.

## 총계

- 행: 531 (row_id 1579~2109 전부, 누락 0, 중복 0). 절: 63개(s0319~s0381).
- CSV 줄: 1,901 (operand_index=0 행 단위 531줄 + 오퍼랜드 1,370줄).
- status별
  - 원문 확정 1,750 (행 단위 521, 오퍼랜드 1,229)
  - 원문 없음 115 (모두 오퍼랜드)
  - 원문 충돌 36 (행 단위 10, 오퍼랜드 26)
  - 추출 불완전 0
- kind별: register 756, register_or_memory 481, immediate 92, mask 24, literal 9, memory 7, implicit 1, none(행 단위) 531.

## 총론 정의(SYM)와 명령 절이 충돌한 사례

1. **m16 (SYM042)**: 3.1.1.3은 "This nomenclature is used only with the string instructions."라고 하는데 이 범위의 비문자열 명령이
   m16을 쓴다. PMOVSXBQ/PMOVZXBQ `xmm2/m16`(VEX/레거시 128), PEXTRW/VPEXTRW `reg/m16`, PINSRW/VPINSRW `r32/m16`.
   폭 16은 PEXTRW("a 16-bit memory address")·PINSRW("a 16-bit memory location") Description이 직접 적는다. PMOVSX/ZX는
   Description이 폭을 적지 않는다. 해당 오퍼랜드 줄은 `원문 충돌`.
2. **m8 (SYM041)**: "pointed to by the DS:(E)SI or ES:(E)DI registers. In 64-bit mode, it is pointed to by the RSI or RDI
   registers."라고 정의하는데 PREFETCHh/PREFETCHW `m8`, PEXTRB `reg/m8`, PINSRB `r32/m8`은 Op/En이 ModRM:r/m이다.
   절 Description은 "The source operand is a byte memory location." 등으로 바이트 메모리라고만 적는다. `원문 충돌`.
3. **VEX.L=1 #UD와 VEX.256 형식(행 단위 10행)**: PHADDSW, PHADDW/PHADDD, PHSUBSW, PHSUBW/PHSUBD, PSIGNB/W/D,
   PCLMULQDQ의 Other Exceptions는 "#UD If VEX.L = 1."인데 같은 절 표에 VEX.256 형식이 있다(AVX2 또는 VPCLMULQDQ).
   PBLENDW는 "#UD If VEX.L = 1 and AVX2 = 0."으로 조건이 붙어 충돌로 보지 않았다. VEX.256 행의 operand_index=0을 `원문 충돌`.
   (이것은 절 내부 충돌이며 총론과의 충돌은 아니다.)
4. 참고(충돌로 표시하지 않음): SYM071은 `{k1}{z}`의 k 레지스터를 "k1 through k7"이라 하고 SYM073 `k1`은 "k0 through k7"이다.
   `k1 {k2}`(PCMPEQ/PCMPGT EVEX, 24행)의 `{k2}`는 3.1.1.3에 그 표기 그대로의 정의가 없어 2.7.4 원문
   ("only k1 through k7 can be addressed as predicate operands")을 함께 인용했다.

## isa_db/표 추출 오류로 보이는 행

- **PMINSD/PMINSQ (1820~1828), PMINUD/PMINUQ (1842~1850)**: isa_db `op_en`이 빈칸이고 rows.jsonl `op_en_lines`가 없다.
  PDF 1040쪽·1049쪽 표에는 Op/En A(레거시)/B(VEX)/C(EVEX)가 있고 Operand Encoding 표도 있다(표 머리가 "Op/E n"으로 나뉘어 추출됨).
  CSV에는 PDF 원문 줄을 수동으로 붙이고 note에 적었다.
- **PMAXSW mm (1763)**: 표 opcode에 각주 ^1이 있으나 이 절에 NOTES 블록이 없다(footnotes_missing).
- 원문 자체의 표기 이상(isa_db가 그대로 옮김): `VPAND ymm3/.m256`(마침표), `66 0F E0, /r`(쉼표), `ymm3 /m256`·`xmm2/ m128`(공백),
  `EVEX.128.66.0F38 30.WIG /r`(VPMOVZXBW 순서 뒤섞임), `VEX.128.66.0F 38.WIG 35 /r`(VPMOVZXDQ), PCMPESTRI/M 표 opcode의 `imm8`과 `ib` 혼용.
- PCMPISTRI/PCMPISTRM: 표 Op/En 문자 "RM"인데 Operand Encoding의 RM 행은 세 번째 칸에 imm8이 있다(원문 그대로).
- POP r16(58+ rw): Operand Encoding O 행은 "opcode + rd (w)"로 rd만 적는다.
- 그림·표 텍스트가 Description 문장에 섞여 추출된 곳: PDEP/PEXT(Figure 4-8/4-9), PHADDW(4-10), PMULHUW(4-12), PMULLW(4-13), PSHUFD(4-16),
  POPF(Table 4-20 NOTES가 Operation 앞까지 이어짐). 인용문 일부에 이 잔여물이 남아 있다.

## 원문 없음이 많은 표기와 이유

- **zmm 단독 표기 (zmm1, zmm2, `zmm1 {k1}{z}`; 107줄)**: 3.1.1.3에는 `zmm/m512`, `zmm/m512/m32bcst`, `zmm/m512/m64bcst`만 있고
  zmm 단독 정의가 없다. 절 Description은 "ZMM register"라고만 하고 폭(512)이나 번호 범위를 적지 않는다. kind=register는 Description,
  폭·레지스터 목록은 `원문 없음`. 레지스터 수는 총론 2.7/2.7.2("32 vector registers in 64-bit mode")를 인용해 두었다.
- **r32a/r32b/r64a/r64b (PDEP/PEXT, 8줄)**: 3.1.1.3에 정의가 없다. Description은 "The operand size is always 32 bits if not in
  64-bit mode. In 64-bit mode operand size 64 requires VEX.W1."만 적는다.
- `xmm/m128/m32bcst` 같은 xmm·ymm broadcast 표기는 SYM에 없지만(SYM077/078은 zmm 형태만) 모든 해당 절 Description에
  "a 512/256/128-bit vector broadcasted from a 32/64-bit memory location" 류 문장이 있어 `원문 확정`으로 두었다.

## 판단 기준(이 part에서 적용한 규칙)

- kind/data_width/register_set은 SYM 원문 또는 절 Description 문장이 있을 때만 채웠다. 결합 표기(r32/m32, r64/m64, reg/m8 등)는
  구성 표기의 SYM 원문(SYM028/043 등)과 절 Description 문장을 함께 인용했다.
- 64-bit 열은 표 원문을 그대로 적고 V/N.E./I에 대응하는 SYM092~094를 붙였다.
- 레거시 SSE 128-bit 메모리(Type 4 절)에는 총론 Table 2-21 "Legacy SSE: Memory operand is not 16-byte aligned."(59쪽)를,
  PCMPESTRI/M·PCMPISTRI/M에는 같은 표 NOTES 1(정렬 #GP 없음)을 붙였다. MMX 행에는 2.5 NOTE(MMX는 이 예외 분류 밖)를 붙였다.
- address_size_text는 절이 주소 크기를 직접 말한 경우만 채웠다: POP(67H, stack-address size), PCONFIG("Addresses and operands are
  32 bits outside 64-bit mode and are 64 bits in 64-bit mode"), PBNDKB(RBX/RCX linear address). 나머지 행은 빈칸이다.
- 인용 쪽 번호는 생성 후 절 원문에서 문장을 다시 찾아 검증했다. 쪽 경계를 넘는 문장 1개(PMULUDQ 1098~1099쪽)는 시작 쪽으로 두었다.

## 확인하지 못한 것

- Operation은 대부분 키워드 검색(64-bit, REX, vvvv, imm8, 정렬, #UD 등)으로만 훑었다. 전문을 읽은 절: PBLENDVB, PEXTRB/D/Q, PEXTRW,
  PINSRB/D/Q, PINSRW, PMOVMSKB. 나머지 절 Operation 안에만 있는 오퍼랜드 제약이 있다면 빠졌을 수 있다.
- 총론 Type 5/7, E4/E4NF/E5/E9NF 예외 표의 정렬·#UD 세부는 읽지 않았다(Type 4 정렬 칸과 Table 2-21 NOTES만 확인).
- 자동 문장 분리로 붙인 인용 중 일부는 문장 앞에 그림/글머리표 잔여물이 섞여 있다(위 목록). 값 판단에는 쓰지 않았다.
- PREFETCHh의 "The address to prefetch is NextRIP + 32-bit displacement" 문장이 IT0/IT1에만 해당하는지 원문이 명확히 나누지 않아
  PREFETCHT0/T1/T2/NTA 행에도 함께 기록하고 note에 남겼다.
- PSHUFW(MMX 전용) 절의 "REX.R ... (XMM8-XMM15)" 문장은 원문 그대로 기록만 했다.

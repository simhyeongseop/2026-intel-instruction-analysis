# Sol part8 기록 (row_id 3688–4209, 파일 2006–2393쪽, VPEXPANDD ~ VSCATTERPF1QPD)

작성: 2026-10-10. 근거: `out/sdm_evidence_2026-10-09/rows.jsonl`, `scripts/manual_lookup.py show/page`, `data/rules/sdm_symbols.csv`, 총론 2.3.12·2.7 쪽.
보조 스크립트(`gen.py`, `spec.py`)는 `/tmp/claude-1000/sol_part8/`에만 있다. 반복 칸은 스크립트로 채웠고, 절별 인용은 136개 절의 Description·NOTES·예외 절을 읽은 뒤 손으로 넣었다. Operation은 키워드(#UD, #GP, 64-bit, AddressSize, OperandSize, align, is memory/register 등)로 훑어 피연산자 관련 줄을 확인했다.

## 총계

- 행 522개(3688–4209), 누락 0, 중복 0. 절 136개 모두 `sol_part8_sections.csv`에 들어 있다.
- 출력 줄 1,786개 = operand_index=0 줄 522개 + 오퍼랜드 줄 1,264개.
- status(전체): 원문 확정 1,443 / 원문 없음 326 / 원문 충돌 17 / 추출 불완전 0.
- status(오퍼랜드 줄만): 원문 확정 921 / 원문 없음 326 / 원문 충돌 17.
- status 규칙: 오퍼랜드 줄은 kind와 data_width가 **둘 다** 원문 문장으로 뒷받침될 때만 `원문 확정`으로 했다. 하나라도 없으면 `원문 없음`이다. operand_index=0 줄은 표 64/32 열 원문을 인용하므로 `원문 확정`이다. 그 행 전체 조건이 없으면 other_constraints를 빈칸으로 둔다.
- 쓰기 마스크·{er}·{sae} 장식은 별도 줄로 나누지 않았다. 표 원문 그대로 그 오퍼랜드의 table_symbol에 두고 other_constraints에 SYM071/072/080/081을 인용했다. operand_index는 Op/En 표의 Operand 번호와 같다.

## 원문 충돌 (17줄)

1. 3789 VPMOVQD EVEX.128: 표 칸 `xmm1/m128`(2054쪽) / Description "256/128/64-bit memory location"(2055쪽, EVEX.128이면 64비트) / 같은 VL의 VPMOVSQD·VPMOVUSQD는 `xmm1/m64`.
2. 3921–3923 VPSRAVW, 3927–3929 VPSRAVQ: Description(2104쪽)은 broadcast를 "VPSRAVD/W"에 주고 "VPSRAVQ"에는 주지 않는다. 표(2103쪽)는 반대다. VPSRAVW에는 bcst가 없고 VPSRAVQ에는 m64bcst가 있다.
3. 4002 VREDUCESD: 구문의 `imm8/r`가 Op/En 표 Operand 4 `N/A`와 다르다. opcode 칸에도 ib가 없다(`EVEX.LLIG.66.0F3A.W1 57`).
4. 4004 VREDUCESS, 4016 VRNDSCALESS: 구문의 imm8이 Op/En 표 Operand 4 `N/A`와 다르다. VSHUFF/I(s0753)도 Operand 4가 N/A다. 다만 그 행은 충돌 대신 note에 기록했다.
5. 4023 VRSQRT14SD: 표는 `xmm3/m64`이다. Description(2180쪽)은 "an XMM register or a 32-bit memory location"이다.
6. 4099 WRSSQ, 4101 WRUSSQ: Operation은 64비트 연산 크기에서 "Destination not 8B aligned"(DEST_LA[2:0])다. 예외 절은 "not 4 byte aligned"만 적는다.
7. 4186/4190/4204/4208 V(GATHER|SCATTER)PF[01]DPD: 표 기호는 `vm32y`(SYM075: YMM 인덱스)다. Description은 "the index register is an zmm"이다.

## 총론(SYM)과 명령 절이 다른 사례

- XLAT m8(4127): SYM041 m8은 "pointed to by the DS:(E)SI or ES:(E)DI registers"(문자열 명령용)다. 이 절은 DS:(E)BX/RBX이고, 기호는 문서화용일 뿐이다. PREFETCHWT1 m8(4177)도 SYM041 문장이 맞지 않는다. 이 행은 절의 "byte memory location"을 근거로 썼다.
- 벡터 레지스터 범위: SYM058/063은 XMM/YMM 0–15이다. 총론 2.7(66쪽)은 "EVEX prefix can encode 32 vector registers (XMM/YMM/ZMM) in 64-bit mode"라고 한다. EVEX 행 register_set에는 둘 다 적었다.
- VSIB: 총론 2.3.12(50쪽)는 "VSIB memory addressing is supported only with VEX prefix"라고 한다. 반면 2.7.2 Table 2-33과 EVEX gather/scatter 절은 EVEX VSIB를 쓴다. 총론 내부가 서로 다르다. 행 값에는 영향을 주지 않았고 여기에만 기록한다.
- {k2}(VPSHUFBITQMB) 장식은 총론 SYM에 정의가 없다(SYM072는 {k1}).

## isa_db/표 추출 오류로 보이는 행

- 4041–4052 VSCATTERDPS/DPD/QPS/QPD: isa_db op_en이 빈칸이지만 PDF 2202쪽 표의 Op/En 칸은 `A`다. 머리글 "Op/E n" 분리로 추출에 실패한 것으로 보인다. Op/En 줄도 not_found이다.
- 4105 XADD r/m8: 각주 ^1의 본문이 누락됐다(footnotes_missing). PDF 2265쪽에는 "NOTES: 1. With a REX prefix ..."와 별도 "* In 64-bit mode, r/m8 can not be encoded ... AH, BH, CH, DH."가 모두 있다.
- 3839 VPROLVD, 3851 VPRORVD, 4076/4077 VSUBPH: CPUID 칸 "AVX10.11"의 끝 1이 각주 ^1로 추출됐다. 해당 쪽에 각주 본문은 없다(위첨자인지 오타인지 미확인).
- 4103/4104 XACQUIRE/XRELEASE의 op_en 빈칸은 추출 오류가 아니다. PDF 표 자체에 Op/En 열이 없다.
- XCHG 4111–4116: Op/En 표에 "O" 정의 줄이 두 개다(원문). 구문의 첫 오퍼랜드가 AX/EAX/RAX인지에 따라 줄을 대응시켰다. 원문이 행별로 구분해 주지는 않는다.
- PDF 원문 표기 자체의 문제(추출 오류 아님): VSHUFF32X4/x4 대소문자 혼용, VPMOVQD 절 Description의 니모닉(VPMOVQW로 적힘), VSM4RNDS4 절의 "SM4RNDS4", WRMSRNS의 "WRMSRMS", WRUSS의 "pag", VTESTPD 문단의 "VTESTPS with VEX.W=1".
- 깨진 텍스트: WRMSRLIST 64-Bit Mode Exceptions에서 "RSI [2:0] ≠ 0"의 ≠가 줄 앞으로 분리됐다(2250쪽). XABORT/XBEGIN/XEND 예외의 "#UDCPUID..."는 공백이 빠졌다.
- Op/En 표가 EVEX 명령을 "VEX.vvvv"로 적은 곳: VPROLD/VPRORD Op/En A("VEX.vvvv (w)"), FP16 스칼라·VSCALEFPH·VSUBPH·VRSQRT14SS 등이다.

## 원문 없음이 많은 표기와 이유

| 표기 | 줄 수 | 이유 |
|---|---|---|
| zmm 단독 레지스터 | 117(폭) + 46(종류·폭) | 총론에 `zmm` 단독 정의가 없다(SYM070/077/078은 zmm/m512 복합형만). 절 문장 "ZMM register"로 종류는 채웠지만 레지스터 비트 폭은 어디에도 없다. 종류 문장도 없는 절(FP16, VPSHLD/VPSHRD 등)은 종류도 원문 없음이다. |
| vm32x/y/z, vm64x/y/z | 56 | SYM075/076은 인덱스 원소 크기만 정의한다. 메모리 피연산자 폭은 정하지 않는다. |
| xmm/m128/m32bcst, ymm/m256/m64bcst 등(128/256 bcst) | 약 70 | 총론은 zmm/m512/m32bcst·m64bcst만 정의한다. 절 Description이 VL별로 말한 경우만 채웠다. VPOPCNT·VPSHLD/VPSHRD·VRCP14PD/PS(512만 서술)·VRNDSCALEPS·VPROL/VPROR 128/256 등은 원문이 없다. |
| m16bcst, xmm/m16 (FP16) | 약 35 | 총론 정의가 없고 FP16 절 Description도 피연산자 종류·폭을 쓰지 않는다. VUCOMISH만 "16-bit memory location"이 있다. |
| mem (XSAVE/XRSTOR 계열 12줄) | 12 | 종류(memory)는 절 문장으로 확정했다. 크기는 Vol.1 13장 참조만 있다. |
| zmm2+3 / xmm2+3 | 6 | "+3"은 절 문장으로 정의됐지만 레지스터 폭은 정의되지 않았다. |

## 확인하지 못한 것

- Operation 의사코드는 키워드 검색으로 훑었고 한 줄씩 전부 읽지는 않았다. 피연산자 관련 분기(정렬, AddressSize, OperandSize, EVEX.b와 메모리/레지스터 조건)는 확인해서 반영했다.
- "AVX10.11"의 1이 각주 위첨자인지 오타인지는 PDF 원본 글꼴로 확인하지 않았다.
- 예외 유형 표(Type E4, E12 등, 총론 2.5/2.8)의 세부 #UD 조건은 행에 펼치지 않았다. 절이 직접 쓴 "Additionally:" 조건만 넣었다.
- PDF 원본(`intel_manual.pdf`)을 시각적으로 대조하지는 않았다. 추출 텍스트(page/show)만 근거로 썼다.

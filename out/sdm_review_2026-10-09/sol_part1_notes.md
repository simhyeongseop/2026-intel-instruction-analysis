# Sol part1 원문 추출 노트 (row_id 0~529, 파일 119~374쪽, AAA ~ CVTTSS2SI)

작성: 2026-10-09~10. 지침: `docs/SOL_EXTRACTION_GUIDE.md`. 원문 문장이 근거이며, 원문으로 뒷받침되지 않는 값은 `원문 없음`으로 두었다.

## 작업 방식과 이어 쓴 경위

- 반복 칸은 보조 스크립트 `/tmp/claude-1000/sol_part1/gen.py`(총론 SYM 정의)로 채웠다. 절별 수기 주석은 `annot.py`에 있고 108개 절 모두에 들어 있다. 어셈블러·CPU 실행은 하지 않았다.
- part1 에이전트는 2026-10-10 09:39:58에 마지막 수정(장식 정규식, zmm register_set)을 반영해 CSV 두 개를 만들었다. 그 직후 09:41에 사용량 한도로 멈췄고, notes는 쓰지 못했다. 이 notes는 다음 세션의 주 에이전트가 다음을 확인한 뒤 추가했다.
  - 현재 `gen.py`/`annot.py`를 별도 폴더로 다시 실행했고, 결과가 저장된 `sol_part1.csv`, `sol_part1_sections.csv`와 바이트 단위로 같았다.
  - `verify.py`로 확인했다. 표와 NOTES를 뺀 인용 664개가 모두 해당 쪽(또는 다음 쪽) 원문에 있었다(공백 정규화 후 대조).
  - 이어 쓸 때 notes의 형식을 맞추려고 part2 notes 앞부분을 열어 보았다. 아래 수치와 인용은 모두 part1 산출물과 원문에서만 가져왔다.

## 총계

| 항목 | 수 |
|---|---|
| 맡은 행(row_id 0~529) | 530 (누락 0, 중복 0, 모든 행에 operand_index=0 줄 있음) |
| 전체 줄 | 1,693 |
| 오퍼랜드 줄(operand_index ≥ 1) | 1,163 |
| 행 전체 줄(operand_index = 0) | 530 |
| status: 원문 확정 | 1,675 |
| status: 원문 충돌 | 16 |
| status: 원문 없음 | 2 |
| status: 추출 불완전 | 0 |
| source_level: 총론 / 명령 절+총론 / 명령 절 | 628 / 538 / 527 |
| 오퍼랜드 kind: register / register_or_memory / immediate / memory / mask / implicit / relative / far_pointer | 570 / 427 / 84 / 64 / 8 / 6 / 2 / 2 |
| address_size_text가 있는 행 | 22 |
| 절(sections.csv) | 108 (s0005~s0112, 맡은 범위의 모든 절) |

## 원문 충돌 (16줄, 8개 절)

1. **ADDSS (rows 61~63, 원본 xmm/m32)**: 표 기호 `xmm/m32`(SYM059 "32-bit memory operand")인데 Description(142쪽)은 "The second source operand can be an XMM register or a 64-bit memory location."이라고 한다. 같은 Description은 단정밀도 절인데도 "stores the double precision floating-point result"라고 쓴다.
2. **ADDSUBPD/ADDSUBPS VEX.128 (rows 65, 68, 오퍼랜드 2)**: 표 `xmm2`이고 Op/En RVM에서는 VEX.vvvv이다. Description(144, 146쪽)은 "the first source operand is an XMM register or 128-bit memory location"이라고 한다.
3. **BEXTR W1 (row 155)**: 표에 `VEX.LZ.0F38.W1 F7 /r` 행이 있고 Description은 "In 64-bit mode operand size 64 requires VEX.W1"이라고 한다. Other Exceptions는 "#UD If VEX.W = 1."이라고 한다.
4. **VCVTPD2DQ EVEX (rows 449~451)**: 표는 목적지가 `xmm1`(128·256), `ymm1`(512)이고 원본은 `m128`/`m256`이다. EVEX Description(332쪽)은 목적지를 "ZMM/YMM/XMM register", 원본을 "a 512-bit memory location"으로 적는다.
5. **VCVTPS2DQ EVEX.128/256 (rows 464~465)**: EVEX Description(343쪽)은 "The source operand is a ZMM register, a 512-bit memory location ..."과 "The destination operand is a ZMM register"처럼 512비트 형식만 적어서, 표의 xmm/ymm 행과 맞지 않는다.
6. **CVTPS2PI (row 473, 원본 xmm/m64)**: 표 `xmm/m64`(SYM060 64-bit)인데 Description(349쪽)은 "The source operand can be an XMM register or a 128-bit memory location."이라고 한다.

## 원문 없음 (2줄)

- **BNDLDX(row 180, 오퍼랜드 2)와 BNDSTX(row 187, 오퍼랜드 1)의 `mib`**: SYM068은 주소 형식만 정의한다("index register is not used in address calculation, Scale is ignored"). 메모리 폭은 정의하지 않는다. 절 원문도 "mib 주소에는 메모리 접근 없음"이라는 취지로, 폭은 적지 않는다. kind=memory와 주소 제약은 원문대로 적었고, data_width는 `원문 없음`이다.

## 다른 part와 기준이 다른 것: 단독 zmm 폭

- part1은 단독 `zmm` 27줄을 `512`·원문 확정으로 적었다. 근거는 SYM070 "zmm/m512 — A ZMM register or 512-bit memory operand."와 SYM019 벡터 길이 512다.
- 직전 세션에서 part5가 같은 방식으로 적었고, 주 에이전트는 이것을 폭 추론으로 보고 원문 없음으로 고치게 했다. "ZMM register"는 종류만 말하고 512비트 문장은 메모리 쪽 폭이라는 이유다. part1은 그 지시를 받기 전에 멈췄다.
- 이 파일의 CSV는 고치지 않았다. 대조 단계의 공통 기준(`compare/REPORT.md`)에서는 이 27줄을 `결정 대기: zmm 폭`으로 둔다.

## 총론(SYM) 정의와 명령 절이 다르게 쓰는 사례

- **SYM041 m8 / SYM042 m16**("pointed to by the DS:(E)SI or ES:(E)DI", m16은 "used only with the string instructions"): 문자열 명령이 아닌 행에도 쓰인다(note 7개 행). Op/En은 `ModRM:r/m`이고, 일부 행에서는 Op/En이 `(w)`인데 Description은 source operand라고 쓴다.
- **총론 정의가 없는 표기**: `zmm` 단독(27개 행, SYM070 "A ZMM register"와 SYM019 벡터 길이로 채움), `r32/m32`(CVTSI2SD 레거시 행, Description 문장으로 채움), `<XMM0-7>`(4개 행, SYM062는 `<XMM0>`만 정의), `bnd/m64`·`bnd/m128`(4개 행, SYM067은 `bnd`만 정의), r32/r64 외 오퍼랜드 크기가 Description으로 정해지는 12개 행.
- **{k1}{z}**: SYM071은 "k1 through k7"이다. 총론 2.7.4(70쪽)도 "only k1 through k7 can be addressed as predicate operands"라고 하며 서로 일치한다.

## isa_db / 표 추출 오류로 보이는 것

- **rows.jsonl op_en_lines 없음 34개 행**: CLDEMOTE, CLWB, CMPccXADD(32행)는 소제목이 "Instruction Operand Encoding1"(각주 번호 붙음)이라 찾지 못했다. 원문 행은 sections.csv에 옮겨 적었다.
- **BNDLDX/BNDSTX**: Operand 2 칸("SIB.base (r): Address of pointer / SIB.index(r)")이 여러 줄로 나뉘어 op_en_lines에서 빠졌다.
- **AESDECWIDE/AESENCWIDE 128·256KL**: 표 니모닉 칸이 "AES- DECWIDE..."로 줄바꿈 분리됐다. row 86은 CPUID 칸이 비어 있다.
- **AND row 112(80 /4 ib)**: PDF가 imm8에도 각주 1을 붙여 인쇄한다("imm81"). 각주 내용(AH 등)은 즉치와 무관해 보이지만 원문대로 두었다.
- **CMOVcc row 269(CMOVG r64)**: 64-Bit Mode 칸이 "V/N.E.", Compat/Leg 칸이 "N/A"로 인쇄돼 다른 REX.W 행과 형식이 다르다.
- **기호·공백 손실**: CMOVcc/CMPccXADD의 `≠`가 깨졌다(`SF OF`). CMPS·CMPXCHG Operation의 `=`가 따로 떨어진 줄로 추출됐다. `REX.w` 소문자(ADCX, ADOX), `VEX.LZ. 0F38.W1`(ANDN), `N. E.`(ARPL), `0F B0/r`(CMPXCHG)에서도 같은 문제가 있다.
- 이 범위의 rows.jsonl에는 `footnotes_missing`이 없다.

## 원문 내부 불일치 (충돌로 올리지 않고 sections.csv/note에만 기록)

- AAD/AAM: Op/En ZO 행은 모든 오퍼랜드 칸이 N/A인데, 표에는 `imm8` 형식이 있다.
- BNDCL/BNDCU/BNDCN: 예외 절은 "ModRM.r/m encodes BND4-BND7"이라고 쓰지만, Op/En에서 bnd는 ModRM:reg 칸이다.
- COMISD/COMISS: Op/En Operand 1이 `ModRM:reg (w)`인데 Description은 EFLAGS만 설정한다고 한다. COMISS Description은 단정밀도 값이 "low quadwords"에 있다고 쓴다.
- CMPSD/CMPSS: imm8 비트 4:0 문장은 VEX만 언급하는데, 표 설명칸은 EVEX 행에도 bits 4:0을 쓴다.
- CVTDQ2PD EVEX.128: 표 설명칸은 "to eight packed double precision"이라고 한다(행 폭과 맞지 않음).
- AESDECWIDE128KL/256KL, AESENCWIDE128KL/256KL(rows 86, 87, 102, 103): Description은 핸들을 "second operand"라고 적지만, 표 문법에서 m384/m512은 첫 오퍼랜드다.

## 확인하지 못한 것

- Intrinsic 소제목은 훑어보기만 했다(오퍼랜드 제약 근거로 쓰지 않음).
- CALL은 Operation 앞부분(OperandSize 분기)과 Near/Far Call 단락만 읽었다. 긴 의사코드 전체를 오퍼랜드 관점에서 다 대조하지는 않았다.
- 표·각주 인용(`[쪽 표]`, `[쪽 NOTES/각주]`)은 `verify.py` 대조 대상에서 빠졌다. rows.jsonl 셀을 그대로 옮긴 것이다.
- 원문 충돌 16줄은 PDF 원문의 불일치로 기록만 했다. 어느 쪽이 맞는지는 판단하지 않았다(정오표 미확인).

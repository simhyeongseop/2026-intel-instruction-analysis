# Sol part2 원문 추출 노트 (row_id 530~1054, 파일 375~710쪽, CWD ~ VMAXPD)

작성: 2026-10-10. 지침: `docs/SOL_EXTRACTION_GUIDE.md`. 원문 문장이 근거이며, 원문으로 뒷받침되지 않는 값은 `원문 없음`으로 두었다.

## 작업 방식

- 1단계(기초값): `rows.jsonl`의 표 칸·각주·Op/En 줄과 총론 기호 정의(`data/rules/sdm_symbols.csv`, SYMxxx)로 행·오퍼랜드별 값을 채웠다. kind/data_width/register_set은 SYM 문장이 말하는 경우에만 채웠다.
- 2단계(절별 검토): 134개 절의 원문(`manual_lookup.py show <절> --text`)에서 표, NOTES/각주, Instruction Operand Encoding, Description, Operation, 예외 절을 직접 읽었다. 그 절에만 있는 제약을 행별로 덧붙이거나 기초값을 바로잡았다.
- Operation이 아주 긴 절(INT, IRET, Jcc, JMP, LDS 계열, ERETU)은 오퍼랜드와 관련된 줄만 확인했다. 해당 절의 `read_subsections`/`extraction_problems`에 그 사실을 적었다.
- 보조 스크립트와 중간 파일은 `/tmp/claude-1000/sol_part2/`에만 두었다. 저장소의 다른 파일은 고치지 않았다.

## 총계

| 항목 | 수 |
|---|---|
| 맡은 행(row_id 530~1054) | 525 (누락 0, 중복 0, 모든 행에 operand_index=0 줄 있음) |
| 전체 줄 | 1,308 |
| 오퍼랜드 줄(operand_index ≥ 1) | 783 |
| 행 전체 줄(operand_index = 0) | 525 |
| status: 원문 확정 | 1,215 |
| status: 원문 없음 | 88 |
| status: 원문 충돌 | 5 |
| status: 추출 불완전 | 0 |
| source_level: 명령 절+총론 / 명령 절 / 총론 | 715 / 541 / 52 |
| 절(sections.csv) | 134 (맡은 범위의 모든 절) |

## 원문 충돌 (5줄)

1. **ERETU (row 579)**: 표의 Compat/Leg 열은 `Valid`인데, Description은 "ERETU can be executed only in 64-bit mode"라고 하고 Compatibility Mode Exceptions는 "not recognized in compatibility mode"라고 한다. ERETS는 같은 열이 `Invalid`다.
2. **VEXTRACTPS (rows 581, 582)**: Description은 "VEX.L= 1 ... will cause an #UD"라고 하는데 Other Exceptions는 "#UD IF VEX.L = 0."라고 한다. EVEX 행(582)에 이 조건이 걸리는지도 원문 배치상 분명하지 않다.
3. **VINSERTPS VEX (row 801)**: 위와 같은 유형이다. Description은 VEX.L=1이면 #UD라고 하고, Other Exceptions(Non-EVEX)는 "#UD If VEX.L = 0."라고 한다. EVEX 행 802는 Non-EVEX 항목에 해당하지 않아 충돌로 보지 않았다.
4. **HRESET (row 762, 오퍼랜드 1 imm8)**: Op/En A의 Operand 1은 `ModRM:r/m (r)`이다. 표의 Instruction 칸 첫 오퍼랜드는 imm8이고, opcode는 `F3 0F 3A F0 C0 /ib`로 ModRM을 C0로 고정한다. 둘이 서로 맞지 않는다.

## 총론(SYM) 정의와 명령 절이 다르게 쓰는 사례

- **SYM042 m16 / SYM041 m8** ("used only with the string instructions", DS:(E)SI/ES:(E)DI): KMOVW `m16`(row 942)처럼 문자열 명령이 아닌 행에도 쓰인다. 해당 행에서는 총론의 주소 레지스터 문구를 memory_constraints에 넣지 않고 note에 남겼다.
- **SYM097 N.S.** ("requires an address override prefix in 64-bit mode"): Jcc rel16(31행), JMP rel16·r/m16·r/m32에 쓰인다. 표 설명칸은 "Not supported in 64-bit mode"라고 하며, 이 행들은 operand-size 관련 형식이어서 총론 문구와 정확히 맞지 않는다.
- **SYM036 r/m16** ("operand-size attribute is 16 bits"): LLDT, LMSW, LTR은 "The operand-size attribute has no effect on this instruction"이라고 한다.
- **SYM027 r16은 "R8-R15", SYM036 r/m16은 "R8W - R15W"**: 총론 안에서 레지스터 이름 표기가 다르다(기록만 함).
- **SYM071 {k1}{z}는 "k1 through k7", SYM073 k1은 "k0 through k7"**: 둘은 쓰임새가 다르므로 원문 그대로 적었다.
- **SYM040 m** ("A 16-, 32- or 64-bit operand in memory"): LEA와 INVLPG는 메모리를 읽지 않고 주소만 쓴다. 폭은 총론값을 그대로 두고 note에 기록했다.

## isa_db / 표 추출 오류로 보이는 행

- **row 992 LAR**: isa_db 값은 `LAR r32, r64/m161`이고 PDF 추출 텍스트는 `REX.W + 0F 02/r LAR r32, r64/m16`이다. 끝의 `1`은 앞 행(991) 각주 위첨자가 붙은 잡음으로 보인다(앞 행 다음 줄에 `1`이 단독으로 있음).
- **rows 737~754 GF2P8\***: rows.jsonl이 표 설명칸 `GF(2^8)`의 `^8`을 각주 8로 잘못 인식했다(footnotes_missing=8). 실제 각주가 아니다.
- **rows 803~808 INS**: 표 Description 칸의 각주 1 위첨자("RDI.1")가 rows.jsonl footnote_numbers에 잡히지 않았다. 이 각주는 64비트 모드에서 주소 크기를 64/32만 허용한다는 규정이다. 노트에 원문을 인용해 반영했다.
- **rows 1046~1047 MASKMOVDQU**: Op/En 머리말의 각주 1("ModRM.MOD = 011B required")이 rows.jsonl에 없다. 2비트 MOD 필드인데 원문이 `011B`로 적었다.
- **rows 569~570 ENCODEKEY128/256**: Op/En 머리말이 "Operands 4—5", "Operands 6—7"처럼 묶인 열이어서 기계적 위치 대응이 맞지 않는다. 수동으로 바로잡았다. 570의 `r32, r32 <XMM0-6>`은 PDF에도 쉼표가 없다.
- **rows 786~788 IN**: Op/En `I imm8`의 Operand 1은 표의 두 번째 오퍼랜드(imm8)에 해당한다. 기초 대응이 AL에 imm8 역할을 붙여 바로잡았다.
- **rows 966~973 KSHIFT**: 표 opcode 칸에 `ib`가 없다(Op/En RRI에는 imm8이 있음).
- **row 931 KANDNB**: 표 설명칸은 "masks k1 and k2"라고 하는데 Instruction과 Description은 k2, k3이다.
- **기타 추출 잡음**: 각주 위첨자가 숫자로 붙음(`r/m81`, `FNSTSW1`, `40+ rw2`), 위첨자 지수 손실(`−263 to +263`, `232 − 1`), `≠`·`√` 기호 손실(FYL2XP1 범위식), log 아래첨자 줄 분리(FLDL2T 등), EXTRACTPS 레거시 행의 `VV`(슬래시 누락).
- x87 절(F2XM1~FYL2XP1, 단 FXRSTOR/FXSAVE 제외)은 원문 표에 Op/En 열과 Instruction Operand Encoding 표가 원래 없다. `op_en_status=not_found`는 추출 오류가 아니다.

## 원문 내부 불일치 (충돌로 올리지 않고 note에만 기록)

- DIV(rows 541~544): Op/En `ModRM:r/m (w)`인데 Description은 이 오퍼랜드를 source(divisor)라고 한다.
- KORTEST(rows 958~961): Op/En Operand 1이 `(w)`인데 Description은 두 오퍼랜드 모두 원천이라고 한다.
- DPPD, DPPS, HADD*, HSUB*의 VEX.128 Description: "the first source operand is an XMM register or 128-bit memory location"이라고 하여 표(xmm2=VEX.vvvv)와 맞지 않는다.
- GF2P8AFFINE*의 Description: "operand 1/operand 2" 번호가 VEX/EVEX 표 순서와 다르다.
- FPATAN: 결과를 ST(1)에 저장한다고 한 뒤 "The result in register ST(0) has the same sign…"이라고 한다.
- Jcc: Description은 인코딩을 "8-bit or 32-bit"라고 하는데 표에는 rel16(cw) 행이 있다.
- LSL REX.W 행(1041): Compat/Leg 열이 `Valid`다(LAR REX.W 행은 `N.E.`).
- LOCK(1027): 원문 목록에 `CMPXCH8B`로 적혀 있다(판단 보류, 원문 그대로 인용).

## 원문 없음이 많은 표기와 이유 (88줄)

| 표기 | 줄 수 | 이유 |
|---|---|---|
| `ST(i)`, `ST(0)`, `ST` | 69 | SYM053/054는 FPU 스택 요소라고만 하고 비트 폭을 적지 않는다. kind=register는 확정, data_width가 원문 없음이다. |
| `zmm2`, `zmm1 {k1}{z}` | 12 | 총론에 zmm 단독 정의가 없다. Description의 "ZMM register"로 kind는 채웠지만 비트 폭 문장은 없다. GF2P8 행(742/748/754)의 zmm1은 Description이 레지스터 종류를 말하지 않아 kind도 원문 없음이다. |
| `xmm3/m128/m64bcst`, `ymm3/m256/m64bcst` (GF2P8AFFINE*) | 4 | bcst 표기는 zmm형(SYM077/078)만 정의돼 있고, 이 절 Description은 메모리 크기를 숫자로 말하지 않는다. Operation의 qword[0] broadcast만 인용했다. |
| `m2byte` (FSTCW/FNSTCW) | 2 | 이 절 Description은 "destination in memory"라고만 한다. FLDCW 절의 "16-bit"는 다른 절이라 근거로 쓰지 않았다. |
| `<XMM4-6>` (ENCODEKEY128) | 1 | 암시 오퍼랜드의 폭 문장이 없다. |

같은 계열의 다른 표기(`m14/28byte`, `m94/108byte`, `m512byte`, `mem`, `reg/m32`, `r16/m16`, `k2/m16`, `<EAX>`, DIVPD/DIVPS/MAXPD의 bcst 등)는 해당 절 Description, 표 설명칸 또는 각주가 크기를 말하므로 채우고 인용했다.

## 확인하지 못한 것

- 원본 PDF(`intel_manual.pdf`)를 이미지로 대조하지 않았다. 추출 텍스트만 읽었다. 특히 FYL2XP1 범위식, LAR row 992의 REX.W 행 목적 표기(`r32`), MASKMOVDQU 각주의 `011B`는 PDF로 확인해야 한다.
- 위첨자 손실로 보이는 값(`263`, `232`)은 추출 텍스트 그대로 인용하고 해석값을 괄호로 덧붙였다. 확정하지 않았다.
- 총론 2장(VEX/EVEX 규정)은 2.7.2 레지스터 수 문장과 3.1.1.3 SYM087(`11:rrr:bbb`, `!(11)`)만 인용했다. VSIB, disp8*N, 2장 예외 표(Type 2/4/5, E2, K20/K21 등)는 읽지 않았다. 해당 행의 정렬·예외 조건은 명령 절이 직접 말한 것만 적었다.
- FXSAVE(732~733)의 인용 쪽 번호(531/533)는 절 원문 파일의 줄 위치로 정한 것이다(본문 연속 확인).

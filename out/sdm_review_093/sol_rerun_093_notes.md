# Sol 재추출 메모 (SDM 093판, 변경·신규 143행)

작성: 2026-10-10, 검토자 Sol. 기준: `docs/SOL_EXTRACTION_GUIDE.md` + 093판 차이(대상 `out/sdm_review_093/sol_rerun_targets.csv`, 근거 `out/sdm_evidence_093/rows.jsonl`, `intel_manual.pdf` 093판, `data/rules/sdm_symbols.csv`).
기존 sol_part*/main_*/compare 파일은 열지 않았다. 어셈블러·CPU는 실행하지 않았다. `lost_quotes_090`은 무엇이 바뀌었는지 찾는 데만 썼고, 근거로는 093판 원문만 인용했다.

## 총계

- 대상 143행, 21개 절: 모두 들어갔다(누락 0, 추가 0, (row_id, operand_index) 중복 0, 모든 행에 operand_index=0 줄 있음).
- 출력 줄 460개 = 행 전체 조건 143줄 + 오퍼랜드 317줄.
- status: 원문 확정 361 / 원문 충돌 87 / 원문 없음 12 / 추출 불완전 0.
- 형식 표가 아닌 인용문은 `manual_lookup.py page` 텍스트(공백·하이픈 정규화)와 스크립트로 대조했다. 형식 표 인용은 rows.jsonl `table_cells` 값이다.

| 절 | 행 | 확정 | 충돌 | 없음 |
|---|---|---|---|---|
| s0127 ENDBR32, s0128 ENDBR64 | 571, 572 | 2 | 0 | 0 |
| s0235 LLDT, s0242 LTR | 1024, 1042 | 4 | 0 | 0 |
| s0262 MOVBE | 1152-1157 | 16 | 2 | 0 |
| s0302 MWAIT, s0325 PBNDKB | 1410, 1620 | 2 | 0 | 0 |
| s0357 PMOVSX | 1855-1890 | 105 | 0 | 3 |
| s0358 PMOVZX | 1891-1926 | 105 | 0 | 3 |
| s0382 PSRAW/D/Q (EVEX) | 2126-2143 | 39 | 33 | 0 |
| s0384 PSRLW/D/Q (EVEX) | 2174-2191 | 39 | 33 | 0 |
| s0401 RDMSR | 2394-2395 | 2 | 2 | 0 |
| s0415 RORX | 2449-2450 | 8 | 0 | 0 |
| s0426 SALC | 2517 | 1 | 0 | 0 |
| s0474 TCMMIMFP16PS/TCMMRLFP16PS | 2702-2703 | 2 | 0 | 6 |
| s0488 UD(UDB) | 2741 | 0 | 1 | 0 |
| s0496 URDMSR | 2769-2770 | 2 | 4 | 0 |
| s0497 UWRMSR | 2771-2772 | 4 | 2 | 0 |
| s0653 VPBLENDMD/Q | 3458-3463 | 18 | 6 | 0 |
| s0712 VPSHUFBITQMB | 3911-3913 | 9 | 3 | 0 |
| s0778 WRMSRNS | 4104-4105 | 3 | 1 | 0 |

## 090판과 비교해 093판 원문의 의미가 바뀐 곳

1. **VPBLENDMD/Q (1909쪽)**: 090판 "The destination and first source operands are ZMM registers"와 "second source ... ZMM register, a 512-bit memory location ..."가 093판에서 "ZMM/YMM/XMM registers", "512/256/128-bit memory location", 16/8/4·8/4/2개 브로드캐스트로 바뀌었다. 그래서 128/256비트 행의 종류·폭이 명령 절 원문으로 확정된다. VPSHUFBITQMB(2104쪽)도 같은 방식으로 "ZMM/YMM/XMM", "destination operand is mask register k1", "writemask k2 (zeroing only)"로 바뀌었다.
2. **PMOVSX/PMOVZX (1057/1067쪽)**: 093판 Description에는 오퍼랜드 종류 문장이 없다(090판 EVEX의 "The destination register is XMM, YMM or ZMM Register." 같은 문장이 사라짐). 남은 문장은 "starting from the low bytes of the source operand (second operand)"뿐이다. 그래서 종류·폭은 형식 표("in the low N bytes of xmm2/mM")와 총론 SYM, Operation의 SRC 비트 범위로만 정했다. `xmm2/m16`은 총론 정의가 없어 6행 × 1줄 = 원문 없음이다.
3. **MSR 즉시값 형식(신규: RDMSR r64, imm32 / URDMSR r64, imm32 / UWRMSR imm32, r64 / WRMSRNS imm32, r64)**: opcode가 `VEX.128.F2|F3.MAP7:W0.F6|F8 11:000:bbb`이다. 그런데 총론 3.1.1.2(SYM014/015 "Only three encoded values of VEX.mmmmm are defined as valid")와 2.3.6.1 Table 2-10(00100-11111B Reserved)에는 MAP7이 없다. Vol.2 본문 검색에서도 MAP7은 이 4개 표 칸에만 나온다. 그래서 4행의 행 전체 줄을 원문 충돌로 두었다. 즉시값 형식은 64비트 모드 전용이고, 보호·실주소 모드 예외에 "#UD If the immediate form is used."가 있다. RDMSR/URDMSR에서는 목적지 GPR(operand 1)이 Operand Encoding에 `ModRM:r/m (r)`로 적혀 있지만 Operation은 `DEST := MSR[SRC]`로 그 오퍼랜드에 쓴다(원문 충돌).
4. **PSRA/PSRL EVEX 예외 분류**: 093판은 E(즉시값 VPSRAW/VPSRLW, Full Mem)를 "Exceptions Type E4.nb in Table 2-51"로, G(Mem128)를 E4NF.nb로 적는다. 090판 인용은 "VPSRAW (E in the operand encoding table) ... E4NF.nb"였다.
5. **MOVBE / MWAIT**: MOVBE opcode에 `NFx`(SYM003: F2/F3 금지)가 붙었고, 090판 예외 절의 "#UD If REP (F3H) prefix is used."는 사라졌다. MWAIT은 #GP 조건이 ECX[31:1] ≠ 0에서 ECX[31:3] ≠ 0 or ECX[1] = 1(64비트에서는 RCX[63:3]/RCX[1])로 바뀌었다. ECX[2] monitorless MWAIT가 추가되었고 CPL 0 전용으로 바뀌었다.
   그 밖의 변경: LLDT/LTR은 표 설명이 "Load LDTR/TR using segment selector in r/m16"으로 바뀌었고, "cannot be executed in real-address mode or in virtual-8086 mode"가 들어갔다. ENDBR32/64는 "on processors that do not support CET, and in/outside 64-bit mode"이 NOP 조건에 들어갔다. RORX는 "second operand"가 "source operand"로 바뀌었다. SALC 절, UDB 각주 2, TCMM* 2행은 새로 생겼다.

## 총론 정의(SYM)와 명령 절이 충돌한 사례

- **SYM042 m16** ("pointed to by the DS:(E)SI or ES:(E)DI registers. This nomenclature is used only with the string instructions.") 대 MOVBE m16(ModRM:r/m 메모리): 행 1152, 1155의 m16 줄은 원문 충돌이다. 폭 16은 명령 절에서 확정된다.
- **SYM071 {k1}{z}** ("A mask register used as instruction writemask") 대 VPBLENDMD/Q "The opmask register is not used as a writemask for this instruction. Instead, the mask is used as an element selector": 6행의 operand 1이 원문 충돌이다.
- **SYM072 {k1}** (z 없음 = zeroing을 허용하지 않고 merging만 지원) 대 VPSHUFBITQMB "write masking according to the writemask k2 (zeroing only)" 및 Operation(마스크 0이면 k1 비트 0): 3행의 operand 1이 원문 충돌이다.
- **SYM015/SYM014, Table 2-10** 대 MAP7 opcode 4행(위 3번).
- 충돌로 두지 않고 note에만 적은 것:
  - SYM029/SYM036/SYM037/SYM038은 R8 이상 레지스터를 REX.R로 설명한다. 그러나 해당 행은 r/m 필드이거나 VEX 인코딩이다(RORX, MSR 즉시값 형식, LLDT/LTR).
  - SYM038은 r/m64를 "when using REX.W"로 정의하지만, RORX는 "operand size 64 requires VEX.W1"이다.
  - SYM032 imm32는 부호 있는 범위로 정의되지만, MSR 주소 imm32의 부호 해석은 명령 절에 원문이 없다.

## 명령 절 안의 원문 충돌

- **PSRA/PSRL EVEX (66줄)**:
  - Description "EVEX encoded versions: The destination operand is a ZMM register"와 즉시값 형식 원본 "can be a ZMM register, a 512-bit memory location or a 512-bit vector broadcasted"는 벡터 길이를 구분하지 않는다. 그래서 EVEX.128/256 행의 xmm/ymm 목적지·원본과 맞지 않는다(24행의 operand 1·2).
  - 가변 카운트 xmm3/m128의 폭은 원문 안에서 세 가지로 갈린다: SYM061 128비트, Description "8-bit variable count", "only the first/low 64-bits of a 128-bit count operand are checked"와 Operation `COUNT := COUNT_SRC[63:0]`(18행의 operand 3).
- **URDMSR/UWRMSR 레지스터 형식**: URDMSR operand 1(목적지)은 `ModRM:r/m (r)`로, UWRMSR operand 1(주소, 읽기만)은 `ModRM:reg (r, w)`로 적혀 있어 Operation과 맞지 않는다.
- **UDB**: Description "This instruction’s operation is the same in non-64-bit modes and 64-bit mode."가 각주 2 "Outside 64-bit mode, D6H encodes SALC." 및 예외 절 "(UDB does so only in 64-bit mode.)"와 충돌한다.

## isa_db/표 추출 오류로 보이는 행

isa_db 값과 PDF 원문이 다른 행은 찾지 못했다. 다음은 원문 자체의 표기 이상이며, isa_db도 원문과 같다.
- 1858 `66 0f 38 23/r`(공백 없음), 1902 `VEX.128.66.0F 38.WIG 35 /r`, 1909 `EVEX.128.66.0F38 30.WIG /r`(WIG 위치).
- 2517 SALC, 2741 UDB의 Op/En은 `Z0`(숫자 0)이다. UD 절 Operand Encoding 표에는 `ZO`·`RM` 행만 있어 UDB의 `Z0` 행이 없다(rows.jsonl op_en_status=not_found).
- 2129 VPSRAW EVEX.128 imm8의 CPUID 칸 `AVX10.12`는 각주 ^2로 추출되었다. 그러나 이 쪽 NOTES에는 1번만 있어 각주 2 본문이 없다(PDF 위첨자 여부는 확인하지 못함).
- 2703 `VEX.128.NP.0F38`: VEX 표기 형식(SYM014)에 NP 자리가 없다(SYM002 NP는 비VEX 절의 정의).

## 원문 없음이 많은 표기와 그 이유

- `xmm2/m16`(PMOVSXBQ/PMOVZXBQ 계열 6행): 총론 SYM에 정의가 없다. 폭 2바이트는 표 설명과 Operation `SRC[15:0]`으로 확인되지만, 레지스터/메모리 종류를 정하는 문장은 없다.
- `tmm1/tmm2/tmm3`(TCMM* 2행 × 3): 레지스터 목록·폭의 정의를 sdm_symbols.csv와 총론 2.4에서 찾지 못했다. 종류(타일 레지스터)는 Description "input tiles tmm2 and tmm3"와 11:rrr:bbb에서 정했다.
- zmm 단독 표기, `xmm/m128/m32bcst`·`ymm/m256/mXXbcst`도 SYM 정의가 없다. 다만 명령 절 Description이나 Operation (KL, VL)이 폭을 말하는 경우에는 확정으로 두었다(VPBLENDM, PMOVSX/ZX zmm). PSRA/PSRL에서는 Description과 맞지 않아 충돌로 두었다.

## 확인하지 못한 것

- URDMSR/UWRMSR 64비트 예외 절 텍스트는 비트맵 범위를 "0 3FFH"로 보여 준다(− 기호가 앞줄로 밀림). Description은 "0H–3FFFH"이다. PDF 그림으로 3FFH/3FFFH를 확인하지 않았다(해당 줄 note에 기록).
- 행 2129의 각주 2 존재 여부(PDF 위첨자).
- 예외 Type 5/E5/E4/E4NF/AMX-E4 표는 오퍼랜드 관련 줄(정렬 #AC, 타일 서로 다름 등)만 읽었고, 각 표의 모든 조건을 행에 옮기지는 않았다.
- Tuple Type별 disp8*N의 N 값(Table 2-36/2-37)은 옮기지 않았다(SYM088 참조만 적음).
- `address_size_text`는 모든 행에서 빈칸이다. 대상 21개 절에 64비트 모드 주소 크기 문장이 없었다(PBNDKB의 RBX/RCX 선형 주소는 memory_constraints에 적음).

---
## 주 에이전트 검증 덧붙임 (2026-10-10)
- 범위: 143행, 460줄, 누락·중복 0, 모든 행에 0번 줄 있음, 원문 확정 줄은 모두 인용이 있음.
- `scripts/verify_sol_quotes.py`(093판)로 대조했다. 고유 인용 383개 중 66개를 그대로는 찾지 못했다.
  - 62개는 Operation 인용이다. Sol이 원문의 두 줄(`PMOVSXBW` / `Packed_Sign_Extend_...`)을 `PMOVSXBW: ...`처럼 콜론으로 이었다. 콜론을 떼면 모두 원문에 있다.
  - 4개는 표 인용이다. 명령어 칸을 빼고 나머지 칸을 이었다. 모든 낱말이 해당 쪽 원문에 있다.
  - 지어낸 인용은 없다. 다만 위 66개는 원문 그대로의 인용이 아니라 표기를 가공한 것이다.

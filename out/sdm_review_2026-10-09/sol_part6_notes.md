# Sol part6 원문 추출 노트 (row_id 2633 ~ 3165)

작성: Sol(part6), 2026-10-09~10. 근거: `out/sdm_evidence_2026-10-09/rows.jsonl`, `scripts/manual_lookup.py` 절 원문, `data/rules/sdm_symbols.csv`, 총론 2장 쪽(파일 51-52, 69, 72, 99-100).
보조 스크립트는 `/tmp/claude-1000/sol_part6/`에만 두었다. 모든 절 인용문은 스크립트가 절 원문에 실제로 있는지 대조한 뒤 넣었다(줄 끝 하이픈 분철은 원문 그대로 `corre- sponding`처럼 두거나 이어 붙인 형태로 대조).

## 총계

- 행: 533 (2633~3165, 누락 0, 중복 0), 절: 144 (s0452~s0596)
- CSV 줄: 1,820 = 행 전체(operand_index=0) 533 + 오퍼랜드 1,287
- status (전체 줄): 원문 확정 1,678 / 원문 없음 95 / 원문 충돌 47 / 추출 불완전 0
- status (오퍼랜드 줄만): 원문 확정 1,145 / 원문 없음 95 / 원문 충돌 47
- source_level: 명령 절+총론 1,122 / 명령 절 527 / 총론 171
- index 0 줄은 형식 표 64-bit 열 값과 절 원문 제약을 담으므로 모두 `원문 확정`으로 두었다.

## status 판정 방식

- kind·data_width는 (1) 기호 전체가 SYM 정의와 일치하거나 (2) 그 절의 문장이 종류를 말할 때만 채웠다.
- `xmm3/m128/m32bcst`처럼 기호 전체 정의가 없는 경우: `xmm/m128` 부분은 SYM061 등으로, broadcast 부분은 총론 2.7.7(32/64비트 요소) 또는 절 원문(Description 문장 또는 Operation의 `EVEX.b = 1` → 요소 [0] 사용)으로 뒷받침될 때만 확정.
- `{k1}{z}`, `{er}`, `{sae}`, `k1`은 SYM071/080/081/073, EVEX 벡터 레지스터 32개는 총론 2.7.2(파일 69쪽)를 register_set에 덧붙였다.
- 한 구성 요소라도 근거가 없으면 `원문 없음`, 절 원문끼리 또는 표와 Description이 다르면 `원문 충돌`.

## 총론 정의(SYM)와 명령 절이 다른 사례

1. **m16 (SYM042)**: "This nomenclature is used only with the string instructions"라고 하나, VBCSTNEBF162PS/VBCSTNESH2PS(`m16`)와 FP16 스칼라 명령(`xmm/m16`)이 문자열 명령이 아닌데 m16을 쓴다. VBCSTNE*는 절 Description("loads one BF16/FP16 element from memory")로 memory를 확정하고 note에 SYM042 문제를 적었다.
2. **m16bcst**: 총론 2.7.7은 broadcast를 "32-bit ... and 64-bit data elements"에 대해서만 설명하고, 3.1.1.3 표기 목록에는 `zmm/m512/m32bcst`, `zmm/m512/m64bcst`만 있다. FP16 명령 84개 오퍼랜드의 m16bcst는 각 절 Operation의 `IF EVEX.b = 1: ... SRC.fp16[0]` 줄로만 뒷받침된다(Description에는 broadcast 언급 없음).
3. **xmm (SYM058)**: XMM0-XMM15만 나열. EVEX의 32개 벡터 레지스터는 총론 2.7.2에서만 나온다(충돌은 아니고 보충).
4. **tmm, sibmem, r16/r32/r64, `<edx>`/`<eax>`, k1{k2}의 {k2}, zmm(단독)**: 3.1.1.3 표기 목록에 정의가 없다. sibmem은 총론 2.4와 절 Description, r16/r32/r64(UMONITOR)·`<edx>`/`<eax>`는 절 Description으로 확정. tmm은 어디에도 레지스터라는 문장이 없어 `원문 없음`.

## 절 원문 내부 충돌 (원문 충돌 47줄)

- VFMADD132/213/231PD·PS(s0587, s0589) EVEX.128/256 행 36줄: "EVEX encoded versions: ... is a ZMM register ..., a 512-bit memory location"만 적어 xmm/ymm 형식과 다름.
- VBROADCASTSS/SD ymm1, xmm2 (2790, 2791): Description "VEX256-encoded versions: ... Register source encodings are reserved and will #UD."인데 형식 표는 AVX2 레지스터 원본 행을 싣는다.
- VBLENDMPS (2782-2784), VFIXUPIMMPS (3041-3043) 세 번째 오퍼랜드: Description이 broadcast를 "from a 64-bit memory location"으로 적어 m32bcst와 다름(PD 절 문장을 공유한 것으로 보임).
- VCVTNE2PS2BF16 (2819-2821, s0508): Description은 "Converts two SIMD registers"인데 Operation은 `IF src2 is memory and evex.b == 1`.

## isa_db/표 추출 문제로 보이는 행

- 2675~2686 (SUBPD/SUBPS): isa_db `op_en` 빈칸, rows.jsonl `op_en_status=not_found`. 절 표 머리가 "Op/E n"으로 쪼개져 있다. PDF 표 줄에서 A/B/C를 확인해 Op/En 칸을 채우고 note에 적었다.
- 2724, 2739, 2740 (TPAUSE/UMONITOR/UMWAIT): 표 제목이 "Instruction Operand Encoding1"(각주 1: "The Mod field of the ModR/M byte must have value 11B.")로 추출돼 Op/En 줄을 못 찾음. 절 원문에서 직접 확인.
- 2737 (UDB): 형식 표 Op/En 칸이 PDF 원문 자체에서 "Z0"(숫자 0). Operand Encoding 표에는 ZO만 있어 Op/En 줄 없음으로 둠.
- PDF 원문 자체의 이상(isa_db는 원문을 그대로 옮김): 2920 opcode "EVEX.256.0F.W1 78 02 /r", 3084 "VEX.256.66.0F38.0 B8 /r"(W0의 W 누락), 3041-3042 VFIXUPIMMPS "54 /r"(ib 없음, 형식에는 imm8), VEXTRACTF32x4/F64x4/I32x4/I64x4 니모닉 대소문자 혼용.
- 그 밖의 원문 오기: SUBSS 절 VEX.L 문장의 "VSUBSD", UCOMISD/UCOMISS 절 VEX.L 문장의 "VCOMISD/VCOMISS", VCVTPD2PH 512 행 Description 칸 "ymm1", VCVTPH2PS Figure 5-6 표기의 imm8, VFMADDSUB*PH Description의 "Table 5-10"(실제 Table 5-7), "destination operation" 오기 다수.
- Op/En 표가 EVEX 전용 명령인데 두 번째 오퍼랜드를 "VEX.vvvv (r)"로 적음: VADDPH, VADDSH, VCMPPH/SH, VCVTSD2SH, VCVTSH2SD/SS, VCVTSI2SH, VCVTSS2SH, VCVTUSI2SH/SS, VDIVPH/SH, VFCMADDC*, VFCMULC*, VF[N]MADD*PH/SH, VFMADDSUB*PH. 원문 그대로 op_en_role에 옮겼다.
- UCOMISD/UCOMISS EVEX Op/En B는 operand 1을 "ModRM:reg (w)"로 적어 A의 "(r)"과 다름.
- VALIGND/Q: 형식에는 imm8이 있으나 Op/En 표 Operand 4가 N/A.

## 원문 없음이 많은 표기와 이유 (95줄)

- `zmm1{k1}{z}` 29, `zmm2`/`zmm3` 단독 25: zmm 단독 기호의 총론 정의가 없고, 해당 FP16 절(VADDPH, VCVTPH2*, VCVTTPH2*, VCVTW/UW2PH, VDIVPH, VF*PH 등)의 Description은 "source/destination operand"라고만 하고 종류를 말하지 않는다.
- `tmm1/2/3` 22: tmm 표기 정의 없음, 절은 "tile"이라고만 함.
- `xmm*/m16 {er}` 12, `{sae}` 7: xmm/m16 기호 전체 정의가 없고 SYM042(m16)는 문자열 명령 전용; FP16 스칼라 절 Description이 원본 종류·폭을 말하지 않음(VCOMISH만 "16-bit memory location"으로 확정).

## 확인하지 못한 것

- Operation 소제목은 9개 절(s0452, s0461, s0473, s0482, s0483, s0486, s0488, s0489, s0497)만 전부 읽었다. 나머지 135개 절은 EVEX.b, `*is register/memory*`, 64-bit Mode, OperandSize, #UD, must를 키워드로 찾아 해당 줄을 확인했다(sections.csv read_subsections에 구분해 적음). 키워드에 걸리지 않는 Operation 내부 제약은 놓쳤을 수 있다.
- Other Exceptions가 참조하는 2장 예외 유형표(Type 2/3/4/5/6/11, E2~E11 등)는 AMX 표(2-67)만 읽었다. 그 표 안의 VEX.L/vvvv/정렬 조건은 이 CSV에 반영하지 않았다.
- 2.10 표 2-67과 일부 절 예외의 `≠` 기호는 추출 텍스트에서 앞 줄로 분리돼 있어 PDF 그림으로 확인하지 않았다(note에 그대로 표시).
- address_size_text는 STOS(67H)와 UMONITOR(67 prefix)만 원문이 있어 채웠다. 나머지 빈칸은 해당 절에 64비트 주소 크기 문장이 없다는 뜻이다.
- 어셈블러·CPU 실행은 하지 않았다(지침).

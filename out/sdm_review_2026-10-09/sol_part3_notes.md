# Sol part3 원문 추출 노트 (row_id 1055–1578, 파일 711–922쪽, MAXPS ~ PALIGNR)

작성: 2026-10-09~10. 지침: `docs/SOL_EXTRACTION_GUIDE.md`. 다른 part와 main_* 파일은 열지 않았다.
보조 스크립트: `/tmp/claude-1000/sol_part3/` (common.py, classify.py, sections.py, gen.py). 어셈블러·CPU 실행 없음.

## 총계

- 맡은 행 524개, 모두 들어감(누락 0, 중복 0). 행마다 operand_index=0 줄 1개(524줄).
- 전체 1,682줄 = 행 전체 조건 524줄 + 오퍼랜드 1,158줄.
- status별(전체): 원문 확정 1,529 / 원문 충돌 82 / 원문 없음 71 / 추출 불완전 0.
- status별(오퍼랜드 줄만): 원문 확정 1,008 / 원문 충돌 79 / 원문 없음 71.
- 절 71개 모두 sections.csv에 한 줄씩 있음. 모든 절은 표·Operand Encoding·Description·Operation·예외를 읽었다
  (Intrinsic 목록은 오퍼랜드와 관계가 없어 건너뜀).

## status 판정 규칙(이 part에서 쓴 것)

- 원문 확정: kind와 data_width가 둘 다 원문 문장(명령 절 또는 SYM)으로 뒷받침됨.
- 원문 없음: kind 또는 data_width를 적은 원문 문장이 없음.
- 원문 충돌: 어느 칸에든 서로 다른 원문 두 개가 있음. 두 원문을 모두 인용했고 값은 정하지 않았다.
- `xmm1`, `ymm2`, `mm1`, `r32a` 같은 접미사 기호에는 접미사 없는 기호의 SYM 정의를 적용하고 note에 그 사실을 적었다.
  접미사의 뜻은 총론에서 xmm1/xmm2만 설명한다(SYM062). 이 적용은 해석이 섞인 부분이다.
- EVEX 오퍼랜드에 쓸 수 있는 레지스터 수는 총론 2.7과 2.7.2(66·69쪽)를 인용했다. SYM058은 XMM0–15만 적는다.

## 총론 정의(SYM)와 명령 절이 충돌한 사례

1. **moffs 숫자의 뜻**(MOV 1100–1109, 10줄): SYM049는 숫자가 주소 크기 속성으로 정해지는 크기라고 하고,
   MOV NOTES 3은 숫자가 데이터 크기이며 오프셋 크기는 주소 크기 속성으로 정해진다고 한다. data_width는 정하지 않았다.
2. **REX.R과 REX.B**: SYM028/029/037/038은 R8–R15를 REX.R로 쓴다고 한다. MOV CR(1118–1123), MOV DR(1124–1127),
   MOVD/MOVQ(1167–1182의 GPR 오퍼랜드)는 REX.B로 쓴다고 한다. MOV DR은 REX.R을 쓰면 #UD라고 적는다.
3. **m16**(MOVBE 1152·1155): SYM042는 m16을 string 명령에만 쓰는 표기라고 하는데 MOVBE도 m16을 쓴다.
4. **EVEX store 형식의 `{k1}{z}`**(VMOVAPD/APS/DQA32/64/DQU8/16/32/64/UPD/UPS의 29 /r, 7F /r, 11 /r EVEX 행, 30줄):
   표는 `{k1}{z}`로 적는데 Operation "Store-Form"은 병합 마스킹만 적는다. SYM072도 store형은 병합 마스킹만이라고 한다.

## 명령 절 안의 충돌과 오기로 보이는 원문

- VMOVNTDQ·VMOVNTPD: Description의 "VEX.L must be 0"과 표의 VEX.256 형식이 다르다(1270, 1284).
- VMPSADBW: Note는 "VEX.L=1이면 #UD"라고 하는데 표에는 VEX.256(AVX2) 형식이 있다(1385).
- VORPD EVEX: 표는 m64bcst, Description은 "32-bit memory location"에서 브로드캐스트한다고 적는다(1444–1446).
- VPACKUSDW EVEX: Description은 목적지를 "a ZMM register"라고만 적는데 표에는 xmm1/ymm1 형식도 있다(1506, 1507).
- MOVMSKPD/PS: Description "128-bit versions: The source operand is a YMM register"가 표의 xmm/xmm2와 다르다.
- VMOVLPD VEX(1251): Op/En B의 Operand 1이 "ModRM:r/m (r)"이고, Description은 목적지가 XMM 레지스터(first operand)라고 한다.
- VMOVDQU32 EVEX.128 6F(1220): 표 기호가 `xmm2/mm128`이다. 설명 칸은 xmm2/m128이다.
- MOVDQ2Q: 원문은 REX.R로 XMM8–15를 쓴다고 하는데 xmm은 ModRM:r/m 오퍼랜드다. 기록만 하고 판단은 보류했다.
- MOV 각주 2: 각주가 가리키는 Description 안에 66 접두어 설명이 없다.
- MOV REX.W+A2(1106)은 `moffs8^1`이고 다른 moffs 행은 ^3이다. A2(1105)에는 각주가 없다.
- PALIGNR: Description은 128비트 메모리 소스에 16바이트 정렬이 필요하다고 하고(#GP), 예외 분류는 Type 4/E4NF다. 관계 판단은 보류했다.

## isa_db/표 추출 오류로 보이는 행

- 1175 `VEX.128.66.0F.W0 6E /`: PDF 원문 자체가 잘려 있다("/r"의 r 누락). isa_db 값도 같다.
- 1560 `VEX.128.660F.WIG DC /r`: PDF 원문 오기("66.0F"). isa_db 값도 같다.
- 1220 `xmm2/mm128`: PDF 원문 오기. isa_db 값도 같다.
- 1442/1443, 1448/1449, 1504/1505: VEX opcode에 WIG가 없다. PDF 원문과 같다.
- evidence(rows.jsonl) 누락
  - op_en_status=not_found 36행: MOVDIR64B, MOVDIRI, MOVHLPS, MOVLHPS, MOVMSKPS, MOVNTDQ, MOVNTDQA, MOVNTPD, MOVNTPS.
    표 제목의 각주 번호나 줄 분리 때문이다. 이 행들은 절 원문에서 Op/En을 직접 옮겼고 note에 적었다.
  - Operand Encoding 표 제목의 각주 1(Mod≠11B, MOD=011B 필수)이 footnotes에 없다.
  - MOV CR 각주 1(1120, 1122), OUTS 각주 2("DX2")도 footnotes에 없다.
  - MULX: Op/En 표가 줄로 나뉘어 Operand 4(RDX/EDX 암묵)가 op_en_lines에서 빠졌다.
  - MOVHLPS/MOVLHPS RVM 행: 세 줄로 나뉜 것을 줄 배치에 따라 Operand2=VEX.vvvv/EVEX.vvvv로 읽었다. 해석이 섞인 부분이다.

## 원문 없음이 많은 표기와 이유

- `zmm1`, `zmm2` 단독 레지스터 71줄이 전부다. 총론 기호 목록에는 zmm 단독 정의가 없다(SYM070/077/078은 zmm/m512 복합형만).
  ZMM 레지스터 폭을 적은 문장도 찾지 못했다. kind=register는 각 절 Description("ZMM/YMM/XMM register")을 근거로 적었다.
  zmm/m512 복합형은 메모리 폭 512만 원문 확정으로 두고, 레지스터 폭은 data_width에 '원문 없음'으로 따로 적었다.
- `xmm3/m128/m32bcst`, `ymm3/m256/m64bcst` 등은 총론 정의가 없다. 각 절 Description의 브로드캐스트 문장으로 확정했다.
- 고정 레지스터(AL/AX/EAX/RAX/DX)의 폭은 Table 3-1(SYM011)의 열 이름(byte/word/dword/quadword register)에서 가져왔다.
- CR0–CR7, DR0–DR7, r16/r32/r64, r16/r32/m16, r64/m16, r32/m32, r64/m64는 총론 정의가 없어 명령 절 원문만 근거로 썼다.

## 확인하지 못한 것

- 총론 2장은 2.2.1.4(moffs, 41쪽), 2.7, 2.7.2(66·69쪽)와 SYM만 인용했다. 2.3(VEX.vvvv 등) 본문은 대조하지 않았다.
- 예외 분류표(Type 1/2/4/5/7, E1–E10)의 정렬·#UD 조건은 각 절이 표 이름만 참조하므로 펼쳐 읽지 않았다.
  그래서 VEX/EVEX 비정렬 형식(MOVDQU/MOVUPD/MOVUPS)의 memory_constraints는 '원문 없음'으로 두었다.
- PDF 이미지와 직접 대조하지 않았다. 추출 텍스트 기준이다. 수식과 ≠ 기호가 깨진 곳은 sections.csv extraction_problems에 적었다.
- EVEX `{er}`/`{sae}`는 SYM080/081만 인용했다. 2.7.6–2.7.9 본문은 대조하지 않았다.

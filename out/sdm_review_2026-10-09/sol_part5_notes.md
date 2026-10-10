# Sol part5 메모 (row_id 2110~2632, 파일 1158~1368쪽, PSRAW ~ VSQRTPS)

작성: 2026-10-10. 지침: `docs/SOL_EXTRACTION_GUIDE.md`. 근거는 `out/sdm_evidence_2026-10-09/rows.jsonl`, `scripts/manual_lookup.py show/page`, `data/rules/sdm_symbols.csv`, 그리고 총론 쪽(46~47, 52~59, 64, 66~72쪽)이다.
반복 칸은 보조 스크립트(`/tmp/claude-1000/sol_part5/`)로 채웠다. 70개 절은 모두 표, NOTES, Instruction Operand Encoding, Description, 예외 절을 읽었다. Operation은 오퍼랜드 크기, 64비트 모드, 레지스터/메모리 조건이 있는 곳만 확인했다(절별 범위는 sections.csv의 read_subsections에 적었다).

## 총계

- 맡은 행: 523행(2110~2632). 누락 0, 중복 0. operand_index=0 줄은 523개다.
- 전체 줄 1,639개: operand_index=0 줄 523개, 오퍼랜드 줄 1,116개.
- status별 집계(전체): 원문 확정 1,554, 원문 없음 63, 원문 충돌 22, 추출 불완전 0.
- 오퍼랜드 줄만 보면: 원문 확정 1,032, 원문 없음 63, 원문 충돌 21.
- 2026-10-10 재검토: 단독 zmm 오퍼랜드 61줄(zmm1/zmm2, `zmm1 {k1}{z}`)은 data_width와 status를 원문 없음으로 바꿨다. ZMM 레지스터 폭을 직접 말하는 문장이 없기 때문이다(아래 표 참고). 폭 근거만 보강한 줄은 33개로, status는 그대로 원문 확정이다. xmm/ymm bcst 32줄에는 SYM058("The 128-bit XMM registers")과 SYM063("The 256-bit YMM registers")을, `<XMM0>` 1줄에는 SYM058을 추가했다. 바뀐 줄은 모두 94개다.
- 오퍼랜드 kind별: register 508, register_or_memory 401, immediate 123, memory 49, literal 32(상수 `1`), implicit 1(`<XMM0>`), 원문 없음 2.

## 원문 충돌로 둔 사례 (값을 정하지 않았다)

1. PSRAW/PSRAD/PSRAQ와 PSRLW/PSRLD/PSRLQ의 EVEX 가변 카운트 오퍼랜드 `xmm3/m128`(18줄: row 2126~2128, 2132~2134, 2138~2140, 2174~2176, 2180~2182, 2186~2188의 3번 오퍼랜드).
   - 표기와 SYM061은 128비트다. 같은 절 Description 앞부분에는 "If the second source operand is a memory address, 128 bits are loaded."라고 쓰여 있다.
   - 그런데 EVEX 문단은 이 오퍼랜드를 "the third operand, 8-bit variable count"라고 부른다.
2. SGDT `m`(2584)과 SIDT `m`(2616).
   - SYM040은 "m — A 16-, 32- or 64-bit operand in memory."라고 정의한다.
   - 명령 절은 6바이트 메모리 위치라고 하고, 64비트 모드에서는 "fixed at 8+2 bytes"라고 한다.
   - SIDT는 첫 문장이 모드를 한정하지 않고 "6-byte memory location"이라고 쓴다.
3. SMSW `r64/m16`(2620). 표 Description 칸은 "high-order 16 bits of r32 are undefined"라고 쓰고, Description은 "SMSW r64 ... zero-extend CR0[63:0]"이라고 쓴다.
4. SAHF(2467, 0번 줄).
   - 표 64-Bit Mode 열은 "Invalid*"이다(각주 1: "Valid in specific steppings").
   - Description은 "valid in 64-bit mode only if CPUID.80000001H:ECX.LAHF_SAHF_64[0] = 1"이라고 쓴다.

## 총론 정의(SYM)와 명령 절이 다르게 기술한 사례 (충돌로 판정하지 않고 note에 적음)

- 64비트 모드에서 R8 이상 레지스터에 접근하는 REX 비트가 다르게 적혀 있다.
  - SYM026~SYM029와 SYM035~SYM038은 REX.R이라고 적는다.
  - RDRAND/RDSEED Description은 "REX prefix in the form of REX.B permits access to additional registers (R8-R15)"라고 적는다(ModRM:r/m 칸).
  - 레지스터 목록은 같고 인코딩 비트 이름만 다르다.
- SENDUIPI `reg`: SYM039는 "r16, r32, or r64"라고 정의하지만, 절은 "The operand always has 64 bits"라고 쓴다. 폭은 절의 문장을 따랐다.
- EVEX 벡터 레지스터 범위가 다르게 적혀 있다.
  - SYM058/SYM063은 XMM/YMM 0~15만 나열한다.
  - 총론 2.7/2.7.2는 "32 vector registers (XMM/YMM/ZMM) in 64-bit mode"라고 쓴다. register_set에는 두 문장을 모두 적었다.
- SLDT: 표에는 `r/m16` 행만 있지만, Description은 32비트와 64비트 레지스터 목적지 동작(0 확장)도 기술한다.

## isa_db / 표 추출과 원문이 다른 점, 깨진 텍스트

- row 2129(EVEX.128 VPSRAW 71 /4 ib): CPUID 칸에 위첨자 `^2`가 있지만 2번 각주의 본문이 없다(footnotes_missing, 추출 텍스트 "AVX10.12"). PDF 원본은 pdfplumber가 설치되어 있지 않아 확인하지 못했다.
- RDPID(2396, 2397): `op_en_lines`가 비어 있다(not_found). 표 머리 "Instruction Operand Encoding1"의 각주 때문으로 보인다. 원문 "R ModRM:r/m (w) N/A N/A N/A"와 각주 "1.ModRM.MOD = 011B required"를 직접 넣었다.
- ROL `r/m8,^2 1`(2361): 각주 위치가 쉼표 뒤로 추출되었다. 오퍼랜드 분리에서는 앞 오퍼랜드에 붙였다.
- REP/REPE/REPNE 행: isa_db operands 칸에 문자열 명령 니모닉이 들어 있다(예: "INS m8, DX", "CMPS m8, m8"). 오퍼랜드 줄은 m8, DX처럼 니모닉을 빼고 나눴다.
- 머리글 각주가 행별 footnotes에 없다. 해당하는 열 머리와 칸은 다음과 같다.
  - Opcode 열 머리 "Opcode1": PUSH, RCL, RDMSR, SAL, SGDT, SIDT.
  - Description 칸 위첨자: REP, SCAS(주소 크기 각주), SAR("Signed divide3").
  - 이들 각주는 절 원문에서 직접 인용했다.
- 별표가 있지만 설명 문장을 찾지 못했다: RET, RSM, SFENCE, SHLD, SHRD, SLDT, SMSW의 "Opcode*", RSQRTPS/RSQRTSS의 "Opcode*/".
- s0432(SETcc): `manual_lookup show`가 "추출된 형식 표 행이 없다"고 표시한다. rows.jsonl은 2552~2581을 이 절에 연결한다(조회 도구의 니모닉 대응 문제로 보인다).
- 원문 자체의 오기와 불일치(값은 원문 그대로 두었다):
  - RCL/ROR 표: "C0 /1 ib ROR r/m8, imm8 ... Rotate 8 bits r/m16"과 "D1 /3 RCR r/m32, 1 ... Uses a 6 bit count".
  - SHUFPD VEX.256 설명 "stored in xmm1"이 있다. SHUFPS Legacy는 Instruction 칸이 "xmm3/m128"인데 Description 칸은 "xmm2/m128"이다.
  - SMSW REX.W 행 설명이 "r32"를 언급한다.
  - PUNPCKH Other Exceptions에 "VPUNPCKHQDQ/QDQ"라고 쓰여 있다.
  - SARX Description은 카운트를 "first source operand"라고 부른다.
  - SETcc Description에 "IA-64 mode"라는 표기가 있다.
- 기호와 수식 추출 문제: "≠" 줄이 분리된 곳(1239, 1250, 1254, 1308쪽), RCPPS/RSQRTPS 상대 오차 수식, ROUNDxx Figure 4-24 비트 위치. 모두 오퍼랜드 판정에는 쓰지 않았다.

## 3.1.1.3에 정의가 없는 표기와 처리

| 표기 | 처리 | 근거 |
|---|---|---|
| zmm1, zmm2, `zmm1 {k1}{z}` | kind는 register로 둠. data_width와 status는 원문 없음(61줄) | kind는 명령 절 EVEX 문단의 "ZMM/YMM/XMM register" 문장. 레지스터 폭을 직접 말하는 문장은 없음(SYM019 벡터 길이, "512/256/128-bit memory location"은 레지스터 폭 근거로 쓰지 않음) |
| xmm/ymm `…/m32bcst`, `…/m64bcst` | 32줄을 원문 확정으로 둠 | 레지스터 폭은 SYM058/SYM063. 메모리와 브로드캐스트 폭은 명령 절의 "512/256/128-bit memory location or ... vector broadcasted from a 32/64-bit memory location" 문장과 2.7.7. VPSUBB/W, PUNPCK*BW/WD처럼 브로드캐스트 문장이 없는 니모닉에는 bcst 표기가 없다 |
| r32a/r64a, r32b/r64b(SARX/SHLX/SHRX) | kind는 register로 둠. a 계열 register_set은 "원문 없음"(목록 문장 없음) | a 계열은 Op/En ModRM:reg와 SYM006. b 계열은 VEX.vvvv와 Table 2-8 |
| `r32/m16`, `r64/m16`(SMSW) | 폭 "레지스터 32·64 / 메모리 16"; register_set은 원문 없음 | 절 Description |
| `r64/m64`, `r32/m32`(PTWRITE) | 이 2줄만 kind "원문 없음". 데이터 크기(64/32)만 확정 | Description은 "source operand"라고만 하고 레지스터·메모리 문장이 없음. 예외 절만 메모리 피연산자를 언급 |
| CS/SS/DS/ES/FS/GS, AL/AX/EAX/RAX, DX, CL | 개별 표기 정의는 없음. 폭은 총론 레지스터 목록(SYM026~029)이나 절 문장으로 정함 | 세그먼트 레지스터는 PUSH 절의 "segment register (16 bits)" |
| 상수 `1` | kind literal, 폭 빈칸 | 폭 문장 없음 |
| `zmm/m512`, `zmm/m512/m32bcst`, `zmm/m512/m64bcst` | 기존대로 512, 원문 확정 | SYM070/077/078의 표기 정의 문장("512-bit memory operand", "512-bit vector")이 폭을 직접 말함. 이번 재검토에서 바꾸지 않음 |

## 메모리 정렬 근거

- Legacy SSE 128비트 메모리 피연산자: 절이 Type 4나 Type 2를 가리키는 경우, 총론 Table 2-21/2-19의 "Legacy SSE: Memory operand is not 16-byte aligned." 행을 인용했다.
- PUNPCKH/PUNPCKL: 절 고유 문장 "alignment to a 16-byte boundary ... will still be enforced"를 인용했다.
- RSTORSSP: "#GP(0) If linear address of memory operand not 8 byte aligned"를 인용했다.
- VEX/EVEX 형식의 정렬은 절 문장이 없어 비워 두었다. 예외 분류 참조만 0번 줄에 적었다.

## 확인하지 못한 것

- PDF 원본 대조(pdfplumber 미설치): 2129행의 각주 2, 각 "Opcode*" 별표의 의미.
- MMX 형식(각주 1)의 예외 조건(Vol.3B 25.25.3)은 이 매뉴얼 파일 범위 밖이라 읽지 않았다.
- EVEX 예외 분류(E2/E4/E4NF) 표의 세부 정렬·#UD 조건은 총론 2.8 표를 읽지 않았다.
- PSRAW/PSRLW 절의 Other Exceptions에 Legacy SSE(66 접두 128비트, MMX) 형식의 예외 분류 문장이 없다. 이 형식의 정렬 요구는 정하지 않았다.
- 각 Operation 의사코드 전체는 정독하지 않았다. 오퍼랜드 관련 부분만 확인했다.

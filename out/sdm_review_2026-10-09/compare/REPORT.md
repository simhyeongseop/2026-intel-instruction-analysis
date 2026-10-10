# 주 에이전트 독립 판정 ↔ Sol 원문 추출 대조 (2026-10-10)

재현: `python3 scripts/compare_sdm_review.py` (분류 규칙 `pipeline/sdm_review_compare.py`, 회귀 `tests/test_sdm_review_compare.py`).
자료: `operands.csv`(오퍼랜드 줄 9,643개), `row_conditions_review.csv`(행 전체 조건 22개), `summary.json`(분류 개수, 입력 sha256).
이 대조는 두 기록이 같은지만 분류한다. 어느 쪽이 원문에 맞는지는 정하지 않았다. 생성 코드와 Sol/main 파일은 수정하지 않았다.

## 입력 확인

- 4,210행 모두 양쪽에 있다. 오퍼랜드 줄은 main 9,642개(9,820 − 오퍼랜드 없음 178)이고 Sol은 9,643개다. 차이 1개는 ENCODEKEY256(row 570)이다. PDF에 쉼표가 빠진 `r32 <XMM0-6>`를 main은 한 오퍼랜드, Sol은 두 오퍼랜드로 나눴다.
- **main 기록 해시 불일치**: `main_symbol_spec_record.txt`의 sha256(`3d9d2edb…`)과 현재 파일(`86db53f0…`)이 다르다.
  - 두 파일의 수정 시각은 모두 2026-10-09 17:02:00이다(기록 파일이 18ms 먼저). 이는 Sol 결과가 처음 생긴 시각(20:25)보다 앞선다.
  - 현재 `pipeline/sdm_symbol_spec.py`(17:00)로 다시 계산한 결과는 정의된 9,452줄의 모든 열과 같았다.
  - 따라서 사후 수정의 흔적은 없다. 기록할 때 해시를 잘못 적은 것으로 보이지만, 처음 해시의 대상이 무엇이었는지는 확인하지 못했다.

## 결과 요약

| 항목 | 줄 수 |
|---|---|
| 종류 일치 | 7,307 |
| 종류 불일치 | 502 |
| main 총론 정의 없음 · Sol만 값 있음(교차 확인 없음) | 1,410 |
| 둘 다 값 없음 | 276 |
| main 고정 표기(AL 등) · Sol은 register/implicit | 147 |
| 폭: 일치 / Sol 서술형(자동 비교 안 함) / Sol 원문 없음 / main 빈칸·Sol 숫자 / 둘 다 빈칸 | 6,645 / 1,544 / 774 / 444 / 235 |
| 폭 숫자끼리 서로 다름 | **0** |
| Sol status: 원문 확정 / 원문 없음 / 원문 충돌 (오퍼랜드 줄) | 8,370 / 1,016 / 257 |
| 공통 기준 status: 원문 확정 / 원문 없음 / 원문 충돌 / 결정 대기(zmm 폭) | 8,127 / 1,220 / 257 / 39 |
| 확인 필요 줄(아래 이유 중 하나 이상) | 2,116 |

## 공통 기준 재판정 (2026-10-10 직전 세션에서 정한 기준)

Sol part마다 '원문 확정'의 기준이 달랐다. 예를 들어 part6은 종류만 근거가 있어도 확정으로 두었고, part3·4·8은 종류와 폭이 모두 있어야 확정으로 두었다.
그래서 `uniform_status`를 기계적으로 다시 매겼다. Sol이 붙인 원래 status는 `sol_status`에 그대로 있다.

- 원문 충돌·추출 불완전은 그대로 둔다.
- 종류나 폭 칸이 비었거나 '원문 없음'을 포함하면 원문 없음이다.
- 단독 `zmm`의 폭이 채워진 줄은 `결정 대기: zmm 폭`이다. 근거가 SYM070 "A ZMM register or 512-bit memory operand"의 512를 레지스터에도 적용하는 읽기이거나, 종류만 말하는 Description이다. 이 읽기는 사용자 결정 항목이다.

| part | 바뀐 줄 | 내용 |
|---|---|---|
| part1 | 27 | 확정 → 결정 대기(zmm 폭). part1은 part5에 보낸 zmm 기준 수정 지시를 받기 전에 사용량 한도로 멈췄다 |
| part3 | 36 | 확정 → 원문 없음(폭 일부 원문 없음) |
| part4 | 37 | 확정 → 원문 없음(복합 표기 폭 일부, literal/implicit 폭 빈칸 10) |
| part5 | 32 | 확정 → 원문 없음(literal 폭 빈칸) |
| part6 | 103 | 확정 → 원문 없음 99(대부분 단독 zmm 폭 빈칸), 결정 대기 4 |
| part7 | 8 | 확정 → 결정 대기(zmm 폭) |

이 기준은 고정 레지스터 표기(AL, `<XMM0>` 등)에도 폭을 요구한다. 그래서 literal/implicit 46줄이 원문 없음이 됐다. 고정 표기에 폭을 요구할지는 사용자 확인 항목 4와 함께 정한다.

## Sol 보고와 파일의 알려진 오류

- part3 보고는 "1560행 opcode `660F` 오기"라고 했다. 실제로는 1562행(VPADDUSB)이다. 메모가 바로 앞 행에 붙었다(직전 세션에서 isa_db로 확인). Sol 파일은 고치지 않았다.

## 차이 유형

1. **종류 불일치 502줄**은 세 가지 경우다.
   - main 문구 규칙 결함 478줄(SYM065 366, SYM070 112): SYM065 "A YMM register or 256-bit memory operand", SYM070 "A ZMM register or 512-bit memory operand"는 main 규칙의 "register or memory operand"·"register or a " 문구에 맞지 않는다. 그래서 다음 문구 "memory operand"에 걸려 `memory`가 됐다. 원문은 레지스터 또는 메모리를 말하므로 Sol의 `register_or_memory`가 문장과 맞는다. main 파일은 독립 판정 보존을 위해 고치지 않았다.
   - 분류 이름 차이 19줄(SYM046 `m16:16` 등): 원문은 "A memory operand containing a far pointer"다. main은 `far_pointer`, Sol은 `memory`로 적었다.
   - 분류 이름 차이 5줄(SYM062 `<XMM0>`): main은 `register`, Sol은 `implicit`이다(원문 "implied use of the XMM0 register").
2. **표기 다름 35줄**:
   - REP/REPE/REPNE 34행(rows 2410~2443): main은 `INS m8`처럼 문자열 니모닉을 오퍼랜드에 남겼고, Sol은 `m8`만 적었다.
   - row 570: 위 입력 확인 항목과 같다.
   - 9줄은 `^1` 각주 위치나 공백만 다르다.
3. **고정 표기 147줄**: main은 표에 글자 그대로 나온 레지스터(AL, AX, DX, `<XMM0-7>` 등)를 `literal`로 두었다. Sol은 135줄을 `register`, 12줄을 `implicit`으로 적었다. 원문 충돌이 아니라 분류 기준이 다른 것이다.

## Sol 원문 없음 (1,016줄, 714행)

| 표기 묶음 | 줄 수 | Sol이 적은 이유 요지 |
|---|---|---|
| `zmm` 단독(마스크 장식 포함) | 650 | 3.1.1.3에 `zmm` 단독 정의가 없고, ZMM 레지스터 폭을 적은 문장이 없다 |
| xmm/ymm/zmm + bcst, `/m16`, `/m8` 복합 | 184 | 총론은 zmm/m512/m32bcst 등 일부 조합만 정의한다 |
| x87 `ST(i)`, `ST(0)`, `ST` | 69 | 3.1.1.3에 정의가 없다 |
| VSIB `vm32x/y/z`, `vm64x/y/z` | 56 | SYM075/076은 인덱스 원소 크기만 정의하고 메모리 원소 크기는 정하지 않는다 |
| `tmm` | 22 | 총론 정의가 없다. 절 원문은 "tile"로만 부른다 |
| 기타 | 35 | `mem`(12), `k1+1`(6), `r32a/b`·`r64a/b`(8), `mib`(2), `m2byte`(2), `xmm2+3`(2), `<XMM4-6>`, `r32/m32`, `r64/m64` |

## Sol 원문 충돌 (오퍼랜드 257줄 + 행 조건 21개, 212행·100개 니모닉)

- **EVEX Description이 ZMM/512비트만 말하는데 행은 EVEX.128/256**: 약 54줄(note 기준으로 센 하한)이다. 예: VCVTPD2DQ, VCVTPS2DQ.
- **번호 접미사(xmm1·xmm2 외 a/b/3 등)**: 36줄. 총론 SYM062가 xmm1, xmm2의 뜻만 설명한다.
- **`{k1}{z}`가 writemask가 아니라는 절 문장**: 35줄. SYM071 정의와 다르다.
- **행 조건 21개**:
  - VEX.L 조건 충돌 12개: VPHADD/VPHSUB/VPSIGN, VPCLMULQDQ, VEXTRACTPS, VINSERTPS.
  - 기타: BEXTR W1, ERETU 호환 모드, SAHF 64비트 유효성, VMPSADBW 표 설명칸 오기 등.
- 추출 불완전 1개: VGATHERDPD(row 3359)의 Op/En 2번 칸이 rows.jsonl에서 빠졌다.

## Sol part 사이의 기준 차이

- **`zmm` 단독 폭**: part1은 27줄을 512로 확정했다. part5는 처음에 같은 방식이었으나 직전 세션 지시로 61줄을 원문 없음으로 고쳤다. part2~4·7·8은 대부분 원문 없음이고, part6은 84줄을 확정·폭 빈칸으로 두었다. 위 공통 기준 재판정으로 맞췄다.

## 사용자 확인 항목

1. `zmm` 단독 폭(직전 세션에서 part5가 제기한 질문): SYM070 "A ZMM register or 512-bit memory operand"의 512가 레지스터 쪽에도 걸리는지 정한다. 걸린다고 보면 결정 대기 39줄과 단독 zmm 원문 없음 약 650줄이 512가 된다. 메모리 쪽에만 걸린다고 보면 모두 원문 없음이다.
2. EVEX Description이 ZMM만 말하는 EVEX.128/256 행: 계획 원칙(충돌이면 값을 만들지 않음)을 그대로 적용하면 이 행들은 생성되지 않는다. 표 칸을 우선할지 정한다.
3. VEX.L 조건 충돌 행 12개(표에 VEX.256 형식이 있는데 예외 절은 VEX.L=1이면 #UD라고 함): 생성 대상에 넣을지 정한다.
4. 분류 이름 통일: far pointer 메모리(`memory`/`far_pointer`), `<XMM0>`(`register`/`implicit`), 표 고정 레지스터(`literal`/`register`). 원문 차이가 아니라 생성기에서 쓸 이름을 고르는 일이다. 고정 표기 줄에도 폭을 요구할지(공통 기준에서 46줄이 원문 없음)도 함께 정한다.
5. main 문구 규칙 결함 478줄: 새 생성기에서는 Sol 쪽 값을 쓰는 것이 원문 문장과 맞는다. main 파일 자체는 보존한다.
6. Sol만 값을 낸 1,410줄은 교차 확인이 없다. 새 생성기에서 근거를 자동 추적할 때 이 줄의 인용문을 다시 대조해야 한다.

## 추가 1: Sol 인용의 원문 존재 확인 (전 part)

재현: `python3 scripts/verify_sol_quotes.py`. 결과는 `quote_check.csv`, `quote_check_summary.json`, 수동 분류 `quote_not_found_review.csv`에 있다.

- 고유 인용 7,658개(사용 43,052회)를 확인했다. 쪽 인용은 적힌 쪽의 앞 1쪽부터 뒤 2쪽까지에서 찾았다. 표 인용은 그 쪽들의 표 셀 원문(`table_cells.jsonl`)에서도 찾았다. SYM 인용은 `sdm_symbols.csv` 원문에서 찾았다.
- 결과:
  - exact 7,258
  - nospace 63(공백·줄바꿈 차이)
  - nohyphen 156(줄 끝 하이픈 분철)
  - table_label 147(part8이 "64/32 bit Mode: Valid/Valid"처럼 열 이름을 붙이고 값을 합친 표 인용)
  - 못 찾음 34
- 못 찾은 34개는 모두 낱말 단위로 원문과 비교해 수동 분류했다. 원문에 없는 내용을 만든 인용은 없었다.
  - A 추출 흔적 21: 문장 사이에 쪽 꼬리말, 각주 숫자, 분리된 `≠`가 끼거나 Op/En 표가 여러 줄로 섞였다. 내용은 같다.
  - B Sol 가공 표기 7: Operation의 `i+63`을 `i+..`로 일반화하고 "Store-Form:" 머리말을 붙였다(6). PACKSSDW 머리말(1).
  - C 원문 오타·구두점을 고쳐 적음 6: 인용한 절의 원문에는 오타가 있다("written into vector a register", "based that operand"). 고친 문장은 이웃 절에 그대로 있다.
- 한계:
  - 조각('...', ' | ', ' / ')으로 나눈 인용은 조각마다 찾으므로, 짧은 조각은 우연히 맞을 수 있다.
  - nospace·nohyphen 단계는 공백·하이픈 차이를 허용한다.
  - 인용이 있다는 것은 그 문장이 원문에 있다는 뜻일 뿐이다. 그 문장이 Sol이 적은 값을 뒷받침하는지는 이 확인 범위가 아니다.

## 추가 2: 최신 생성 케이스에 미치는 영향

재현: `python3 scripts/map_review_to_combos.py`. 결과는 `combo_impact.csv`(케이스별), `rows_status.csv`(행별), `combo_impact_summary.json`에 있다.
대상은 `out/generator_audit_2026-10-09_mode_address/combos.csv`(23,199개)다. 케이스의 row_id는 isa_db와 모두 대응한다(불일치 0).

행 상태는 공통 기준 오퍼랜드 상태와 행 전체 조건(충돌·추출 불완전) 중 가장 나쁜 것으로 정했다.

| 행 상태 | isa 행 | 생성 케이스 | 그중 checked / unverified / invalid |
|---|---|---|---|
| 원문 확정 | 3,156 | 16,200 | 9,186 / 6,942 / 72 |
| 원문 없음 | 796 | 5,399 | 261 / 5,138 / 0 |
| 원문 충돌 | 232 | 1,429 | 335 / 1,094 / 0 |
| 결정 대기: zmm 폭 | 25 | 170 | 24 / 146 / 0 |
| 추출 불완전 | 1 | 1 | 0 / 1 / 0 |

- 1단계 추출 결함이 있는 행은 91개이고, 케이스로는 332개다. 기계 판정 결과는 다음과 같다.
  - op_en 빈칸 46: PMINSD/PMINUD 18, VSCATTER 12, SUBPD/PS 12, KORTEST 4.
  - REP 계열 operands에 니모닉이 섞임 34.
  - op_en 공백 분리 9: `RV M`.
  - LAR `r64/m161` 1, VMOVD opcode `6E /` 1.
  - x87과 XACQUIRE/XRELEASE는 원문 표에 Op/En 열이 없어 빈칸이 정상이므로 제외했다.
  - isa_db와 `table_cells.jsonl`은 같은 1단계 표 추출에서 나와 서로 독립 근거가 아니다. 그래서 위 결함은 Sol·직전 세션이 PDF 쪽에서 확인한 유형을 isa_db에서 찾은 것이다.
- 원문 확정 행이면서 추출 결함이 없는 행에서 나온 케이스는 15,938개(69%)다. 나머지 7,261개는 원문이 정하지 않았거나 충돌하는 행, 결정 대기 행, 추출 결함이 있는 행에서 나왔다.
- "원문 확정 행에서 나왔다"는 것은 그 행의 오퍼랜드 종류·폭이 원문으로 정해졌다는 뜻이다. 생성기가 고른 대표 레지스터·메모리 표현·주소 크기가 그 행의 원문 제약(레지스터 목록, 정렬, 마스크, 64비트 모드 조건)을 지키는지는 확인하지 않았다. 이것은 생성기 재작성 단계의 근거 추적으로 확인해야 한다.

## 추가 3: 사용자 결정 반영 (2026-10-10)

| 항목 | 결정 | 반영 |
|---|---|---|
| 1 zmm 단독 폭 | 원문 없음 유지 | `uniform_status`에서 단독 zmm은 폭이 있어도 원문 없음이다. 결정 대기 상태는 없앴다. |
| 2 EVEX 문단 | 3번과 같은 방식 | 예외 목록에 21행(51줄)을 등록했다. GNU/Clang 바이트 동일, EVEX L'L이 표 벡터 길이와 일치해 형식 62개가 모두 통과했다. CPU에 avx512f가 없어 실행은 하지 않았다. |
| 3 VEX.L 충돌 | 원칙(표) 우선. 어긋나는 행은 예외 목록에 하드코딩해 대조한 뒤 넣는다 | `data/rules/source_conflict_cases.csv` 13행, `scripts/check_source_conflicts.py` 실측. 통과한 13행은 `예외 등록·실측 확인` |
| 4 고정 레지스터·상수 | 표에 이름·값이 적힌 고정 레지스터와 상수는 폭 문장 없이 확정 | AL, DX, ST(0), `<XMM0>`, `<eax>`, 상수 `1` |
| 6 Sol 단독 1,410줄 | 생성기 재작성 때 인용에서 값을 기계적으로 다시 읽어 대조 | 미착수 |
| 5 main 규칙 오류 | Sol 값 사용, 수정 규칙은 별도로 기록 | `KIND_PHRASES_FIXED`, `scripts/build_main_rulefix.py` → `main_symbol_spec_rulefix.csv`. 바뀐 줄은 정확히 478개이고 원본 해시는 그대로다. 수정 규칙 기준 종류 불일치는 502에서 24로 줄었다(이름 차이: far pointer 19, `<XMM0>` 5). |

### 2번 재확인: PDF 쪽 그림으로 대조

- 확인한 쪽: CVTPD2DQ 332, CVTPS2DQ 343, VFMADD132PD 1670, VPBLENDMD 1901, VMINSH 1887. 문장은 텍스트 추출본과 같다.
- 처음 보고한 '약 54줄'은 다음과 같이 바로잡는다.
  - 실제로 표와 다른 줄: 51개. Description의 "EVEX encoded versions" 문단이 512비트 형식(ZMM, 512-bit memory)만 설명한다. VFMADD 계열은 같은 Description 앞부분이 "two, four or eight"로 128/256 형식도 말한다.
  - 충돌이 아닌 줄: 3개. CVTPD2DQ 목적지는 원문 "ZMM/YMM/XMM register"라서 표의 xmm1, ymm1이 이 범위 안에 든다. Sol이 충돌로 잘못 분류했다.
  - 다른 유형 1개: PCLMULQDQ는 VEX.L 유형이다.

### 3번 실측: `conflict_tests/results.csv`

- 환경: Intel Core Ultra 5 226V, GNU as 2.42, clang 18.1.3.
- 대조군: ud2는 SIGILL, AVX2 vpaddw ymm은 정상 종료.
- VEX.256 11행(VPHADD·VPHSUB·VPSIGN·VPCLMULQDQ·VMPSADBW): 두 어셈블러의 바이트가 같고 VEX.L=1이다. 정상 종료했다. 예외 목록의 "#UD If VEX.L = 1"과 반대이고 표와 맞는다. L을 0으로 뒤집은 형식도 정상 종료했다.
- VEXTRACTPS·VINSERTPS(VEX.128): 표 형식(L=0)은 정상 종료했고, L을 1로 뒤집으면 SIGILL이다. Description("L=1이면 #UD")과 맞고, 예외 목록("#UD If VEX.L = 0")과 반대다.
- 한 CPU 모델의 관측이다. 다른 세대 CPU의 동작이나 ISA 전체 의미의 증거는 아니다.

### 결정 반영 뒤 최신 생성 케이스 (23,199개, 결정 1~6과 예외 목록 34행 반영)

| 행 상태 | isa 행 | 케이스 |
|---|---|---|
| 원문 확정 | 3,209 | 16,362 |
| 예외 등록·실측 확인 | 34 | 267 |
| 원문 없음 | 768 | 5,407 |
| 원문 충돌 | 198 | 1,162 |
| 추출 불완전 | 1 | 1 |

원문 확정이거나 예외 등록·실측 확인이면서 추출 결함이 없는 케이스는 16,367개다.
남은 원문 충돌 198행은 예외 목록에 아직 등록하지 않은 다른 유형이다. 예를 들어 `{k1}{z}`를 writemask가 아니라고 한 절, 총론 m8/m16의 문자열 명령 문구, 번호 접미사, moffs 숫자의 뜻, EVEX 시프트 count 폭 등이 있다.

## 추가 4: 남은 원문 충돌 198행에 같은 원칙 적용 (2026-10-10 사용자 결정)

재현: `python3 scripts/check_conflict_rows.py --execute`. 결과는 `conflict_tests/row_results.csv`(케이스 1,162개), `row_cases.csv`(행 198개)에 있다.
하드코딩한 파일:
- `data/rules/encoding_check_overrides.csv` 16행: 대조용 opcode 보정과 MAP5 바이트 패턴
- `data/rules/unreachable_forms.csv` 6행: 별칭 opcode 쌍
- `data/rules/source_conflict_cases.csv`: SAHF 예외(MODE-01)

방법:
- 시험 형식은 기존 생성기가 표 기준으로 만든 최신 snapshot 케이스를 그대로 쓴다.
- GNU as와 clang으로 조립하고, `encoding_audit.check_encoding`으로 표 opcode 칸과 대조한다.
- 표 행에 도달하지 못하면 의사 접두어(`{evex}`, `{vex3}`, `{store}`, `{load}`, `rex64`)로 강제해 다시 시험한다(293개 케이스).
- 레지스터만 쓰는 형식은 이 CPU가 지원하는 기능일 때 실행한다.

| 충돌 유형(Sol 메모 기준 분류) | 행 | 결과 |
|---|---|---|
| description_width(표 폭과 Description 폭이 다름) | 46 | 통과 41, GNU 단독 포함 5 |
| store_zeroing(표 `{k1}{z}` vs Operation·SYM072 병합만) | 30 | 30행 모두 표 형식 도달. 표가 말하는 '메모리 목적지 + `{k1}{z}`'는 GNU("unsupported masking")·clang("invalid operand") 모두 거부 → 예외: 메모리 목적지는 `{k1}`만 |
| broadcast_description | 23 | 통과 23 |
| evex_description(이번 대상 중 앞의 51줄에 없던 것) | 8 | 통과 8 |
| moffs_meaning(NOTES 3 데이터 크기 vs SYM049 주소 크기) | 8 | GNU는 표대로 `A0`+8바이트 오프셋(숫자 = 데이터 크기, 오프셋 폭 = 주소 크기). clang은 `3E 8A 04 25`+4바이트로 다른 인코딩을 냄(64비트 주소가 잘림, 관측만) |
| mask_not_writemask | 8 | 통과 8 |
| op_en_mismatch | 7 | 통과 7. VREDUCESD·VFIXUPIMMPS는 PDF 표 opcode에 `ib`가 없어 대조용 opcode를 보정함(PDF 그림으로 확인) |
| vex_l / string_memory_symbol / table_typo | 5 / 5 / 2 | 모두 통과 |
| mode_validity | 2 | ERETU: GNU만 수용(clang 거부), 이 CPU에 FRED가 없어 SIGILL은 판정에 쓰지 않음. SAHF: 표 "Invalid*"인데 두 도구가 수용했고 CPU(lahf_lm)에서 정상 실행 → 예외 MODE-01(Description의 CPUID 조건부 유효) |
| other | 54 | 통과 37, GNU 단독·도달 불가 포함 13, 음성 확인 4(MOV CR/DR r32: 표 N.E., 두 도구 거부) |

- 케이스 판정: 통과 1,021, GNU 단독 118, 도달 불가(별칭) 18, 음성 5.
- GNU 단독 118개에서 clang이 다른 이유: 의사 접두어 미지원 96, moffs 다른 인코딩 10, 거부 5, 기타 다른 바이트 7.
  - 기타 7개 중 하나는 `rex64 smsw word ptr [eax]`다. clang이 `48 67 0f 01 20`처럼 REX를 67 앞에 놓아 REX.W가 무효가 된다. 관측만 했고 결함으로 확정하지 않았다.
- 도달 불가(별칭) 18개: MOVQ/VMOVQ 6행의 메모리 형식이다. 두 도구 모두 같은 뜻의 다른 opcode(`0F 6F`, `F3 0F 7E`, `66 0F D6`)를 고르고, 니모닉 문법으로 표 행을 지정할 수 없다. 레지스터 형식은 도달한다.
- CPU 실행: 정상 종료 61. SIGSEGV 16은 MOV CR/DR 특권 명령과 매핑되지 않은 moffs 주소라 판정에 쓰지 않았다. SIGILL 1은 ERETU다.
- 한계:
  - AVX-512 행은 CPU 실행을 하지 못했다.
  - '통과'는 조립과 인코딩 필드가 표와 맞는다는 뜻이다. 충돌한 원문 중 어느 쪽 의미가 맞는지(예: Description의 메모리 폭)는 조립으로 판정할 수 없다.

### 남은 충돌까지 반영한 최신 생성 케이스 (23,199개)

| 행 상태 | isa 행 | 케이스 |
|---|---|---|
| 원문 확정 | 3,209 | 16,362 |
| 예외 등록·실측 확인 | 204 | 1,206 |
| 원문 없음 | 796 | 5,630 |
| 원문 충돌 | 0 | 0 |
| 추출 불완전 | 1 | 1 |

- 충돌 232행 가운데 204행은 예외 등록·실측 확인이다. 28행은 충돌은 해소됐지만 다른 오퍼랜드가 원문 없음이라 원문 없음으로 옮겼다.
- 사양을 신뢰할 수 있고 추출 결함도 없는 케이스는 17,302개(75%)다.

## 추가 5: 추출 결함 보정, 대조 도구 표기 확장, 전체 도달 지도 (2026-10-10)

### 1단계 추출 결함 91행
- 보정값은 `scripts/build_extraction_corrections.py`가 PDF 쪽 텍스트에서 기계적으로 찾아 `data/rules/extraction_corrections.csv`에 기록한다.
  - op_en 55행: PDF 표 줄에서 opcode 바로 뒤 칸을 읽고, 그 글자가 같은 절 Operand Encoding 표에 있는지 확인한다.
  - REP 계열 34행: Instruction 칸 전체가 PDF 줄에 있는지 확인한다.
  - LAR 1행: `^1`은 실제 각주다(CASE_REVIEW D절).
  - 90행 모두 확인했다. isa_db는 고치지 않았다.
- VMOVD 1175행의 `6E /`는 추출 결함이 아니라 **PDF 원문 오기**다(758쪽 그림 확인). 앞선 기록의 '추출 결함'을 정정한다.
- 결함 행의 기존 케이스 332개를 대조했다. LAR·LSL 레지스터 형식은 재심 D절의 '동등 표현, REX.W 행 미선택'과 같아 도달 불가(문법)로 하드코딩했다. 나머지는 모두 통과했다.

### `pipeline/encoding_audit.py` 표기 확장 (총론 정의 근거)
| 표기 | 근거 |
|---|---|
| `NP`(pp=00), `NFx` | SYM002, SYM003 |
| `MAP5`, `MAP6` | 총론 2.7(68쪽) "decoding maps ... 1, 2, 3, 5, and 6" |
| `NDS`/`NDD`/`DDS` 무시 | SYM021 |
| `/is4`, `/ib`, `imm8` | SYM014·SYM017, SYM030 |
| `11:rrr:bbb`, `!(11)`, `mm:101:bbb`, 고정 RM, `(mod=11)`, `(mod!=11 ...)` | SYM087 |
| `+i`, `+rb/+rw/+rd/+ro` | SYM010, SYM009 |
| 소문자 hex·`REX.w`·`0F38` 붙임·`, /r`·`C8 iw 00` | 표기 차이 정규화 |

- 회귀 `tests/test_encoding_notation.py` 14개를 추가했다. 손 계산 바이트와 반례(MOD 조건 위반, 범위 밖 `+i`, 다른 map·pp, is4 누락)로 만들었다.
- 이전 snapshot의 `encoding_audit.csv`는 옛 도구로 만든 것이며 다시 만들지 않았다.

### 행별 하드코딩 `data/rules/encoding_check_overrides.csv` (85행)
- PDF 원문 오기(텍스트 층에 같은 글자): `660F`, `0F38 30.WIG`, `78 02 /r`, `.0`(W0)
- PDF 표에 `ib` 없음: KSHIFT 8, VFPCLASSSS, VRANGESD/SS
- SETcc 30행: ModRM 표기 생략(Op/En M = ModRM:r/m)
- 기타: FWAIT+x87 두 명령 4행, 접두어만 있는 LOCK/XACQUIRE/XRELEASE, TILERELEASE 고정 ModRM, 앞선 VEX.L·EVEX·충돌 행 보정
- 예외 MODE-02(LAHF): SAHF와 같다. 표 "Invalid^1", Description "valid in 64-bit mode only if CPUID...LAHF_SAHF_64", CPU 실행 정상.

### 전체 도달 지도 `conflict_tests/all_results.csv`, `all_cases.csv` (`check_conflict_rows.py --target all --execute`)
- 케이스 23,199개: 통과 22,489, GNU 단독 397, 도달 불가 20, 음성 149, 불일치 144
- 행 4,210개: 통과 3,870, GNU 단독 등 포함 203, 음성 확인 44, 미통과 39, 음성 불일치 54
- 미통과·음성 불일치 91행(예외 LAHF·SAHF 제외)은 `compare/generator_issues.csv`에 모았다(`scripts/build_generator_issues.py`). 모두 원인 유형이 정해졌고 '기타'는 0이다.

| 유형 | 행 | 생성기에서 고칠 것 |
|---|---|---|
| imm1_shift_alias | 32 | C0/C1 시프트·회전 행에 imm8=1을 쓰지 않는다(두 도구 모두 D0/D1을 고름) |
| negative_source_alias | 52 | 64비트 무효 인코딩(rel16, 40+rw INC/DEC, POP FS 16/32 등)의 음성 케이스가 유효 행으로 조립된다. 니모닉 소스로는 음성 시험을 만들 수 없다 |
| evex_not_forced | 2 | EVEX VMOVQ: `{evex}`로도 표 행에 도달하지 못함 |
| far_return | 2 | far RET은 `retf`/`lret` |
| operand_size_prefix | 1 | `push imm16`은 66 접두어가 필요 |
| known_tool_case | 2 | MOV Sreg REX.W 메모리(사용자 확인 대기), UDB(GNU 거부) |

### 최신 생성 케이스 요약 (23,199개)
| 항목 | 케이스 |
|---|---|
| 사양 신뢰(원문 확정 또는 예외 실측 확인, 추출 결함 없음 또는 보정·대조 확인) | 17,568 |
| 표 행 도달(통과·GNU 단독·하드코딩한 도달 불가·두 도구가 거부한 음성) | 22,987 |
| 둘 다 | **17,356 (75%)** |
| 원문 없음 행의 케이스 | 5,630(결정 1에 따라 원문 없음 유지) |

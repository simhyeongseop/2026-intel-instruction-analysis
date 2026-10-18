# 093판 이전 보고 (2026-10-10)

090판(325383-090US, 2026-02) 기준 검토를 093판(Vol.2 325383-093US, Vol.1 253665-093US, 2026-09)으로 옮겼다.
090판 결과는 커밋 dbf3732와 `out/sdm_review_2026-10-09`, `out/sdm_evidence_2026-10-09`, `out/manual_index_090`에 남아 있다.
경로는 `pipeline/sdm_paths.py`에 모았다.

## 기준 파일
- `intel_manual.pdf` = 093판 Vol.2(2,574쪽). 090판은 `manuals/vol2_090/`로 옮겨 보존했다.
- `intel_manual_vol1.pdf` = 093판 Vol.1(600쪽). 색인은 `out/manual_index_vol1`.
- `data/db/isa_db.csv` = 093판 1단계 추출 4,219행(명령어 표 119~2402쪽). 고친 m1으로 090판을 다시 추출하면 기존 isa_db와 바이트가 같다.

## 090 → 093 비교 (`out/sdm_093/edition_diff.csv`, `scripts/compare_isa_editions.py`)
| 상태 | 행 |
|---|---|
| 같음 | 4,169 |
| 바뀜 | 41 (표 설명칸 32, MOVBE opcode에 NFx 6, LAHF·SAHF 64비트 Invalid→Valid, PADDQ mm CPUID MMX→SSE2) |
| 신규 | 9 (RDMSR/URDMSR/UWRMSR/WRMSRNS imm32 형식 `MAP7`, AMX TCMMIMFP16PS·TCMMRLFP16PS, SALC) |
| 없어짐 | 0 |

- 093판에서 Intel이 고친 것 가운데 우리 검토와 겹치는 것:
  - LAHF·SAHF 64비트 칸이 Valid가 됐다. 앞서 실측으로 예외 MODE-01/02로 등록한 것과 같은 결론이다.
  - VPBLENDMD/Q의 EVEX 문단이 "ZMM/YMM/XMM", "512/256/128-bit"로 바뀌었다. EVEX 문단 충돌로 등록한 행 중 일부의 원인이 사라졌다.
- 093판에도 그대로 남은 원문 문제: VMOVD `6E /`, `660F`, `.0`, `78 02`, KSHIFT·VFIXUPIMMPS·VREDUCESD `ib` 누락, SETcc ModRM 생략, PHADDSW·VEXTRACTPS·BEXTR 예외 문장, CVTPS2DQ ZMM 전용 문장.

## 옮긴 것 (`scripts/migrate_review_to_093.py`, `out/sdm_093/migration_report.json`)
- 쪽 대응(`out/sdm_093/page_map.csv`):
  - 기준점은 두 가지다. 본문이 같은 쪽 2,347개(주변과 offset이 5쪽 넘게 튀는 우연 일치는 버림)와 isa 행 표 쪽 33개다.
  - isa 행 쪽 검증: 4,210개 중 4,209개가 맞았다. 1개는 090판 1056쪽 표가 093판 1055~1056쪽으로 나뉜 경우다.
- Sol 13,853줄, 주 판정, 하드코딩 129행(`source_conflict_cases`, `encoding_check_overrides`, `unreachable_forms`)의 row_id와 쪽 번호를 옮겼다. 인용 5,536개의 쪽 번호가 바뀌었다.
- `unreachable_forms.csv`는 처음 만들 때부터 따옴표 없는 쉼표 때문에 뒤쪽 열이 한 칸 밀려 있었다. 판정에 쓰는 row_id·form 열은 영향이 없었다. 이전하면서 바로잡았다.
- 093판으로 다시 만든 것: 매뉴얼 색인, 총론 기호 정의(내용 101개 동일, PDF 해시만 다름), 표 셀·행별 근거, 추출 결함 보정 91행(모두 확인), 생성 snapshot `out/generator_audit_2026-10-10_093`(23,216 케이스).
- 생성 소스: 090판 케이스 23,199개는 093판에서 같은 행·같은 소스로 다시 나왔다. 093 신규 9행에서 17개가 더 나왔다.
  - 케이스 ID는 근거 쪽 번호가 바뀌어 새로 매겨졌다(설계대로). 대응표는 `out/sdm_093/combo_id_map.csv`다.

## 093판 원문으로 재확인 (`data/rules/edition_093_review.csv`, `scripts/build_edition_review.py`)
- Sol 인용 7,658개를 093판 쪽에서 다시 대조했다. 090판에서 찾던 인용 32개를 093판에서 찾지 못했다. 093판에서 명령 절 본문이 실제로 바뀐 곳이다(ENDBR, LLDT, LTR, MWAIT, PBNDKB, PMOVSX/ZX, VPSRA/VPSRL 예외 유형, RDMSR, WRMSRNS, RORX, VPBLENDM, VPSHUFBITQMB, UDB 표, MOVBE).
- 재확인 대상 143행:
  - 재확인 완료(인용 093 원문 확인) 7행
  - 재확인 완료(LAHF·SAHF, 093 표 Valid^1) 2행
  - **재확인 필요 134행**: 그 행의 Sol 인용이 093판에서 사라졌다. 같은 절 문장을 여러 행이 함께 인용하므로 PMOVSX/ZX 61행, VPSRA/VPSRL 36행, MOVBE 6, VPBLENDM 6 등으로 묶인다.

## 093판 기준 현재 상태 (`compare/combo_impact_summary.json`)
| 행 상태 | isa 행 | 케이스 |
|---|---|---|
| 원문 확정 | 3,126 | 15,901 |
| 예외 등록·실측 확인 | 180 | 1,034 |
| 원문 없음 | 769 | 5,427 |
| 093 변경·재확인 필요 | 134 | 836 |
| 미검토(093 신규) | 9 | 17 |
| 추출 불완전 | 1 | 1 |

- 사양 신뢰 16,935, 표 행 도달 22,996, 둘 다 16,726(23,216 중).
- 090판 결과(17,356)보다 줄어든 것은 재확인 필요·신규 행을 신뢰 범위에서 뺐기 때문이다.
- 생성기 문제 목록(`generator_issues.csv`)은 97행이다. 093 신규 MAP7 행 등 6행은 '기타'로, 대조 도구가 `MAP7:W0` 표기를 아직 읽지 못한다.

## 원문 없음 기준 완화 A·B·C 적용 (사용자 결정 2026-10-10)

규칙은 `pipeline/sdm_relaxation.py`, 회귀는 `tests/test_sdm_relaxation.py`(근거 문장이 Vol.1·Vol.2 색인과 총론 기호 원문에 실제로 있는지 검사)다.
Sol 기록은 고치지 않고 공통 기준(`uniform_status`)에서 원문 없음인 줄에만 적용한다.

| 규칙 | 근거 | 대상 |
|---|---|---|
| A Vol.1 | Vol.1 332쪽 "32 512-bit vector registers called ZMM0–ZMM31", 207쪽 "consist of eight 80-bit registers" | 단독 zmm, x87 ST(i) |
| B 결합 | 부분별 총론 정의(SYM058/063/073/028/029/041~045/064/069), broadcast 원소는 2.7.7(72쪽) "32-bit ... and 64-bit data elements" | xmm/m128/m32bcst, zmm/m512, xmm/m16, r32a/b, k1+1 등 |
| C 원문상 가변 | Vol.1 425쪽 tile "programmer can configure each tile to smaller dimensions", SYM075/076(VSIB), SYM068(mib), 2.4 sibmem | tmm, vm32/vm64, mib, sibmem |

- 이름의 숫자만으로 정하지 않았다. 부분 정의가 하나라도 없으면 결합하지 않는다.
- 결과(오퍼랜드 줄): 원문 없음 1,174에서 74로 줄었다. 완화 A 875, 완화 B 142, 원문상 가변 83이다.
- 남은 74줄: FP16 `m16bcst`(xmm/ymm/zmm 각 20, 2.7.7은 32/64비트 원소만 정의), `mem`(LDDQU 등 12), `m2byte`(2). 셋 다 SDM에 폭 정의가 없다.
- 행 상태(4,219행): 원문 확정 3,126, 완화 A 497, 완화 B 130, 원문상 가변 68, 예외 실측 180, 원문 없음 74, 093 재확인 필요 134, 093 신규 9, 추출 불완전 1.
- 케이스(23,216): 사양 신뢰 21,783, 표 행 도달 22,996, 둘 다 **21,574(93%)**.

## Sol 093판 재추출 반영 (143행)

- Sol 에이전트 1개가 093판 원문으로 독립 재추출했다. 대상은 재확인 필요 134행과 093 신규 9행이다. 결과 파일은 `out/sdm_review_093/sol_rerun_093.csv`(460줄), `_sections.csv`(21절), `_notes.md`다.
  - `load_sol`은 재추출된 행의 기존 part 기록을 통째로 재추출 기록으로 바꾼다(회귀 있음).
- 주 에이전트 검증:
  - 143행, 누락·중복 0.
  - 인용 383개 중 66개는 Sol이 표기를 가공했다(Operation 두 줄을 콜론으로 이음 62, 표 칸 생략 4). 원래 형태로 되돌리면 모두 원문에 있다. 지어낸 인용은 없다(notes에 덧붙임).
- Sol이 보고한 093판 의미 변화:
  - VPBLENDMD/Q·VPSHUFBITQMB의 EVEX 문단이 ZMM/YMM/XMM, 512/256/128로 정정됐다.
  - PMOVSX/ZX Description에서 오퍼랜드 종류 문장이 빠졌다.
  - RDMSR/URDMSR/UWRMSR/WRMSRNS 즉시값 형식의 `MAP7`은 Vol.2 어디에도 정의가 없다. 총론 Table 2-10은 VEX.mmmmm 00100B 이상을 Reserved로 둔다. 그래서 원문 충돌이다.
  - PSRA/PSRL EVEX 예외 유형이 바뀌었다. MWAIT #GP 조건과 CPL 0 전용 조건도 바뀌었다.
- 재확인 목록 143행은 모두 '재확인 완료'다(Sol 재추출 134, 인용 확인 7, LAHF·SAHF 2). 신규 9행도 Sol 기록이 생겼다.
- 충돌 행 대조(`check_conflict_rows.py`)를 다시 실행했다. 214행 중 통과 147, GNU 단독 등 58, 음성 확인 4, 미통과 5다.
  - 미통과 5행: MAP7 4행(RDMSR·WRMSRNS imm32는 GNU 2.42·clang 18 모두 거부, URDMSR·UWRMSR imm32는 두 도구가 같은 `C4 E7 ...` 바이트) + UDB(두 도구 거부).
- 최종(093판, 23,216 케이스):

| 행 상태 | isa 행 | 케이스 |
|---|---|---|
| 원문 확정 | 3,195 | 16,232 |
| 원문 확정(완화 A: Vol.1) | 524 | 3,889 |
| 예외 등록·실측 확인 | 214 | 1,306 |
| 원문 확정(완화 B: 결합) | 136 | 1,125 |
| 원문상 가변(완화 C) | 70 | 75 |
| 원문 없음 | 74 | 579 |
| 원문 충돌 | 5 | 9 |
| 추출 불완전 | 1 | 1 |

사양 신뢰 22,627, 표 행 도달 22,996, 둘 다 **22,416(96.6%)**.

## XSAVE 계열 `mem`을 원문상 가변(C)으로 (사용자 결정 2026-10-10)

- 근거:
  - Vol.1 323쪽 "EBX enumerates the size (in bytes) required by the XSAVE instruction for an XSAVE area containing all the user state components corresponding to bits currently set in XCR0."
  - 압축 형식(XSAVEC·XSAVES·XRSTORS)은 324쪽 "...corresponding to bits currently set in XCR0 | IA32_XSS."
  - Vol.2 2305쪽 XSAVE Description "...RFBM, which is the logical-AND of EDX:EAX and XCR0."
- `mem` 표기 자체에는 총론 정의가 없으므로 XSAVE 계열 12개 니모닉에만 적용했다(LDDQU 등 다른 'mem'은 반례 테스트로 막음).
- 결과: 원문 없음 74행 → 62행(FP16 m16bcst 60, m2byte 2). 원문상 가변 82행. 사양 신뢰+도달 **22,452/23,216(96.7%)**.

## m16bcst(완화 D)·x87 제어 워드 m2byte(완화 A) (사용자 결정 2026-10-10)

- 사용자가 두 표기가 원문 PDF에 있는지 확인을 요청했다. pdfplumber로 원본 줄을 다시 뽑아 둘 다 원문 표기임을 확인했다(파싱 오류 아님).
  - VMULPH 1900쪽(Vol. 2C 5-430), FSTCW 506쪽(Vol. 2A 3-388)
- m16bcst: 총론 2.7.5(71쪽)와 2.7.7(72쪽)은 broadcast를 dword·qword로만 정의한다. 기호 목록(108쪽)에도 m32bcst와 m64bcst만 있다.
  - FP16 명령 절의 정의 문장을 같은 표기 전체에 쓴다. 근거는 VMAXPH 1889쪽 "a 512/256/128-bit vector broadcast from a 16-bit memory location"이다(1893·1895쪽에도 같은 문장이 있다).
  - 다른 명령 절에서 가져온 근거이므로 상태를 `원문 확정(완화 D: 타 명령 절 정의)`로 따로 둔다.
- m2byte(FSTCW·FNSTCW): 절 원문은 506쪽 "Stores the current value of the FPU control word at the specified destination in memory."이고, 폭은 Vol.1 213쪽 "The 16-bit x87 FPU control word"에서 가져온다(완화 A).
  - 대상은 제어 워드 명령(FLDCW·FSTCW·FNSTCW)뿐이다. FSTSW와 FNSTSW는 자기 절(510쪽 "two-byte memory location")로 이미 확정이다.
- 사용자가 찾은 웹 설명(16비트 값 하나를 모든 슬롯에 복사한다, m2byte는 2바이트 제어·상태 워드다)은 위 SDM 문장과 일치한다. 근거로는 SDM 문장만 적었다.
- 결과: 원문 없음 62행 → **0행**. 완화 D 60행(537케이스). 사양 신뢰 23,206, 도달 22,996, 둘 다 **22,995/23,216(99.0%)**.
  - 신뢰 밖에 남은 것은 원문 충돌 5행(9케이스)과 추출 불완전 1행(1케이스)이다.

## 남은 원문 충돌 5행·추출 불완전 1행 (사용자 PDF 확인 2026-10-10)

사용자가 PDF 쪽을 직접 보고 확인한 내용을 원칙(표 우선) + 예외 하드코딩 + 도구 대조로 반영했다.

| 행 | 명령 | PDF 쪽(인쇄 쪽) | 사용자 확인 | 처리 | 결과 |
|---|---|---|---|---|---|
| 2770 | URDMSR r64, imm32 | 1463(4-760) | MAP7은 새로 연 맵 7(외부 자료) | MAP7-02 표 기준, 바이트 패턴 대조 | 통과(GNU·clang `c4 e7 7b f8 c1 imm32`) |
| 2772 | UWRMSR imm32, r64 | 1465(4-762) | 같음 | MAP7-03 | 통과(`c4 e7 7a f8 c1 imm32`) |
| 2395 | RDMSR r64, imm32 | 1247(4-544) | 표 Operand 1은 `ModRM:r/m (r)`이 맞음 | MAP7-01 표 기준(도구 미지원) | 두 도구 모두 거부: 예외 등록·도구 미지원 |
| 4105 | WRMSRNS imm32, r64 | 2259(6-12) | 같음 | MAP7-04 표 기준(도구 미지원) | 같음 |
| 2741 | UDB | 1440(4-737) | Op/En은 화면상 `ZO` | ZO-01, `pdf_confirmed_corrections.csv` | 두 도구 모두 `udb` 거부: 도구 미지원 |
| 3367 | VGATHERDPD xmm1 {k1}, vm32x | 1832(5-362) | CPUID `R`은 `OR` 오타, Operand 2는 `BaseReg (R): VSIB:base, VectorReg(R): VSIB:index` | `pdf_confirmed_corrections.csv` | 통과 |

- MAP7: 093판 Vol.2 총론에는 VEX 맵 7 정의가 없다. 3.1.1.2절(PDF 103쪽)은 0F/0F3A/0F38만 들고, Table 2-10(PDF 48쪽)은 00100-11111B를 Reserved로 둔다. EVEX도 68쪽에서 맵 1, 2, 3, 5, 6만 정의한다.
  - 사용자가 찾은 외부 설명(APX 등으로 확장된 맵 7, USER_MSR 명령에 배정)과 도구 바이트(map 필드 00111)가 표 표기와 맞는다.
  - `encoding_audit`가 `MAP7:W0.F8` 표기를 읽게 했다. 표 칸에 imm32 꼬리가 없어서 4행은 `encoding_check_overrides.csv`의 손 해석 바이트 패턴으로 대조한다(패턴이 서로 겹치지 않음을 테스트로 확인).
  - RDMSR·URDMSR의 operand 1은 표가 `(r)`, Operation이 쓰기(`DEST := MSR[SRC]`)다. 조립 입력에는 접근 표기를 쓰지 않으므로 생성에 영향이 없고, 기록만 남겼다.
- 새 행 상태 `예외 등록·도구 미지원`: 표 기준으로 정했지만 GNU as 2.42와 clang 18.1.3이 그 명령을 모르는 행이다. 사양 신뢰로 세지만 도달로는 세지 않는다. `generator_issues.csv`에서는 `tool_unsupported`로 따로 둔다(생성기 문제 아님).
- VGATHERDPD의 각주 표시 `AVX10.11`의 `1`은 그 쪽에 각주 본문이 없어 표기 오류로 봤다.
- 결과: 원문 충돌 0행, 추출 불완전 0행. 사양 신뢰 **23,216/23,216**, 도달 23,000, 둘 다 **23,000/23,216(99.1%)**.
  - 도달하지 못한 216개 중 음성 케이스는 66개, 불일치는 150개다. 생성기 문제 95행(`generator_issues.csv`)은 이 불일치를 행 단위로 묶은 것이다.
  - 그중 도구 미지원은 3행(5케이스)이다. `other` 2행은 TCMMIMFP16PS와 TCMMRLFP16PS이며, 생성기가 `tmm0, tmm0, tmm0`처럼 같은 레지스터를 써서 거부됐다.

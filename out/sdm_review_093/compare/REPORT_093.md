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

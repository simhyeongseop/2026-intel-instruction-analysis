# 현재 작업 인계

갱신: 2026-10-10. 시작할 때 이 문서를 읽고, 작업 대상의 코드와 근거만 추가로 읽는다.

## 목적과 현재 작업

Intel SDM 행에서 생성한 x86-64 입력의 정확도를 높이고, 의도한 인코딩과 실제 도구 관측을 구분한다.
지금은 생성 입력 검증을 보완한다. 전체 ISA 의미 검증을 완료한 상태가 아니다.

## 현재 기준

- 최신 생성·제약 검사: `out/generator_audit_2026-10-09_mode_address/`.
  23,199개: checked 9,806 / unverified 13,321 / invalid 72.
  이번 snapshot은 조립을 재실행하지 않았다. manifest의 도구 관측 0건은 미실행을 뜻한다.
- 최신 전량 GNU/Clang 조립: `out/generator_audit_2026-09-29_description_fix/`.
  양쪽 수용 23,034개, 한쪽 이상 거부 165개. 회귀 97개 통과 기록.
- 10월 9일에는 전체 회귀 98개 통과. 소스·SDM 행 대응 전량 보존,
  검증 근거가 변경된 39개만 새 ID, 나머지 23,160개 ID 보존 확인.
  이전 개별 검토의 주소 문제 31개를 전부 포함하는 것도 확인했다.
- 기본 `data/db/combos.csv`와 기본 `out/` 결과는 과거 결과다. 최신 결과로 혼용하지 않는다.
- 9월 28일부터의 변경은 미커밋 상태이며 main은 origin/main보다 22커밋 앞선다(10월 9일 확인).

## 확인된 수정

- 9월 28일: CR8, r8 타입, 분기 폭, 문자열 주소, gather 충돌, moffs,
  PREFETCHIT/XLAT, 성공 시 경고 보존과 입력/인코딩 메타데이터.
- 9월 29일: Description 불일치 13개 교정 및 전량 조립·독립 검증.
- 10월 9일: 64비트 모드에서 사용할 수 없는 SDM 행의 RAX/RIP 등 64비트
  메모리 주소 39개를 입력 위반으로 표시. 소스는 부정 테스트로 유지.
  33개 rel16 문제와 합쳐 invalid 72개다. 거부 입력 검토의 주소 문제 31개는 일부 집합이다.

## 진행 중: SDM 기반 검토와 검사 도구 (10월 9일 시작)

순서(10월 9일 변경): 원문 근거 자료 → 전체 4,210행 원문 추출(Sol 8개, 완료)과 주 에이전트 독립 판정 → 대조(10월 10일 완료) → 사용자 확인(10월 10일 완료) → 조합 생성기 재작성 → 어셈블러 분리 → 최종 검사 도구.
- 대조 결과와 사용자 확인 항목 6개: `out/sdm_review_2026-10-09/compare/REPORT.md`(재현 `python3 scripts/compare_sdm_review.py`). 다음 단계는 조합 생성기 재작성이다.
- 사용자 결정(10월 10일, 6개 모두 확정):
  - 1: zmm 단독 폭은 원문 없음이다.
  - 2·3: 원문 충돌은 표(원칙) 기준으로 생성하고, 예외 목록(`data/rules/source_conflict_cases.csv` 36행: VEX.L 13·EVEX 21·SAHF·LAHF)과 `encoding_check_overrides.csv`·`unreachable_forms.csv`에 하드코딩해 대조한다.
  - 4: 표에 적힌 고정 레지스터·상수는 폭 문장 없이 확정이다.
  - 5: Sol 값을 쓰고, main 수정 규칙은 별도 파일로 기록한다.
  - 6: Sol 단독 1,410줄은 생성기 재작성 때 대조한다.
- 최신 케이스 23,199개(10월 10일 기준, `compare/combo_impact_summary.json`):
  - 사양 신뢰 17,568, 표 행 도달 22,987, 둘 다 17,356(75%)이다.
  - 원문 충돌은 0행이다. 추출 결함 91행은 보정·대조를 확인했다(`data/rules/extraction_corrections.csv`).
  - 재현 순서:
    1. `scripts/check_source_conflicts.py --execute`
    2. `scripts/check_conflict_rows.py --execute [--target defects|all]`
    3. `scripts/build_generator_issues.py`
    4. `scripts/map_review_to_combos.py`
  - 하드코딩: `data/rules/source_conflict_cases.csv`(36), `encoding_check_overrides.csv`(85), `unreachable_forms.csv`(8).
  - 생성기 재작성 입력은 `compare/generator_issues.csv`(91행, 유형별 고칠 것)다. 남은 것은 원문 없음 796행(결정 1 유지)이다. 대표값이 원문 제약(레지스터 목록·정렬·마스크)을 지키는지는 아직 확인하지 않았다.
- 주의: main 판정 기록의 sha256이 현재 파일과 다르다. 내용은 재계산으로 확인했다(DEVLOG 10월 10일).
- 원칙: 원문 최우선, 에이전트 해석 배제. 계획과 결정은 `docs/SDM_REGENERATION_PLAN.md`, Sol 지침은 `docs/SOL_EXTRACTION_GUIDE.md`에 있다.
- `data/rules/common_rules.csv`와 `out/mov_review_2026-10-09/`는 폐기된 해석 기반 결과이며 이력으로만 둔다.
- 화면 방식(10월 9일 사용자 결정): 매뉴얼 조회와 최종 검사 도구 모두 **터미널**로 한다. 브라우저·로컬 서버는 쓰지 않는다.
  최종 도구의 기능 요구(어셈블러 선택, 코드 블록 입력, 예상·실측·차이 분석·왕복 검사, 줄별/블록 결과 구분)는 그대로이고 출력만 터미널이다.
- 조회(터미널): `python3 scripts/manual_lookup.py show MOV [--part Description|--text]`, `search`, `page`, `general`, `symbols`, `cases`. 색인 생성: `~/pdftools_venv/bin/python scripts/build_manual_index.py`.
- 원문 근거: `data/rules/sdm_symbols.csv`, `out/sdm_evidence_2026-10-09/`. 검토: `out/sdm_review_2026-10-09/`.
- 사용자 확인 전에는 생성 코드를 고치지 않는다. 확인 결과에 따라 같은 근거를 쓴 사례 전체를 재검토한다.

## 다음 작업과 한계

1. 추가 8개(CALL/JMP r/m32 각 2개, LGDT/LIDT m16&32 각 2개)의
   저장된 도구 관측과 목표 인코딩 차이를 개별 검토한다.
   ID와 원문 행 정보는 최신 snapshot의 `independent_validation.json`에 있다.
2. MOV Sreg 메모리 폭 미확인 3개는 근거를 확보한 뒤 판단한다.
3. 더 넓은 주소·마스크·VEX/EVEX 제약은 개별 근거와 반례를 갖춘 단위로 보완한다.

`checked`는 구현된 일부 검사 통과이며 정상 실행이나 전체 ISA 적합성을 뜻하지 않는다.
모드 무효 행은 오퍼랜드 형태 검사를 통과해도 정상적인 64비트 입력이 아니다.
어셈블러 수용, 입력 적합성, 목표 인코딩, CPU 의미를 각각 기록한다.

## 필요한 파일만 읽기

- 입력 검사: `pipeline/generation_contract.py`, `tests/test_generation_contract.py`.
- 생성 규칙·ID: `pipeline/m3_combine.py`; 소스 출력: `pipeline/m4_generate.py`.
- 감사 실행: `scripts/audit_generator.py`; 인코딩: `pipeline/encoding_audit.py`.
- 원문 데이터: `data/db/isa_db.csv`; 최신 생성 데이터: 위 snapshot의 `combos.csv`.
- Description 교정 근거: `docs/DESCRIPTION_FIX_2026-09-29.md`.
- 178개 개별 검토: `out/rejected_input_review_2026-09-28/cases.csv`와 `sdm_pages.json`.

과거 경과는 `docs/DEVLOG.md`, 과거 코드·문서는 `archive/`에서 필요할 때 확인한다.

```bash
python3 -m unittest discover -s tests -p 'test_*.py' -q
python3 scripts/audit_generator.py --output-dir out/새로운_실행명 --previous-combos out/generator_audit_2026-10-09_mode_address/combos.csv --assemble none
```

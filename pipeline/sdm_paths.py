"""SDM 판에 따라 바뀌는 입력·검토 경로를 한곳에 모은다.

판을 바꿀 때는 이 파일과 docs/HANDOFF.md만 고친다.
- 093판(2026-09, 현재): Vol.2 325383-093US, Vol.1 253665-093US
- 090판 검토 기록과 090→093 이관 스크립트는 2026-10-12에 지웠다(git 기록 b24bb9c 이전). 결과는 093 폴더에 옮겨져 있다.
"""

EDITION = "093"
VOL2_PDF = "intel_manual.pdf"
VOL1_PDF = "intel_manual_vol1.pdf"
VOL1_INDEX_DIR = "out/manual_index_vol1"
EVIDENCE_DIR = "out/sdm_evidence_093"
REVIEW_DIR = "out/sdm_review_093"
EDITION_DIFF = "out/sdm_093/edition_diff.csv"   # 090 -> 093 행 대응. 093 신규 행 표시에 쓴다(build_rows_status)

# 명령어 표 쪽 범위(1부터, 포함). m1_extract 기본값은 현재 판.
INSTR_REF_FIRST_PAGE = 119
INSTR_REF_LAST_PAGE = 2402

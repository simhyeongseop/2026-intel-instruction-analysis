"""SDM 판에 따라 바뀌는 입력·검토 경로를 한곳에 모은다.

판을 바꿀 때는 이 파일과 docs/HANDOFF.md만 고친다. 이전 판 결과는 지우지 않고 기록으로 남긴다.
- 093판(2026-09, 현재): Vol.2 325383-093US, Vol.1 253665-093US
- 090판(2026-02, 기록): Vol.2 325383-090US -> manuals/vol2_090/, 결과 out/sdm_evidence_2026-10-09, out/sdm_review_2026-10-09
"""

EDITION = "093"
VOL2_PDF = "intel_manual.pdf"
VOL1_PDF = "intel_manual_vol1.pdf"
VOL1_INDEX_DIR = "out/manual_index_vol1"
EVIDENCE_DIR = "out/sdm_evidence_093"
REVIEW_DIR = "out/sdm_review_093"
COMBOS = "out/generator_audit_2026-10-10_093/combos.csv"

# 090판 기록(이전 근거와 대조할 때만 쓴다)
EDITION_090_VOL2_PDF = "manuals/vol2_090/325383-090-sdm-vol-2abcd.pdf"
EDITION_090_INDEX_DIR = "out/manual_index_090"
EDITION_090_EVIDENCE_DIR = "out/sdm_evidence_2026-10-09"
EDITION_090_REVIEW_DIR = "out/sdm_review_2026-10-09"
EDITION_090_COMBOS = "out/generator_audit_2026-10-09_mode_address/combos.csv"
EDITION_DIFF = "out/sdm_093/edition_diff.csv"

# 명령어 표 쪽 범위(1부터, 포함). m1_extract 기본값은 현재 판.
INSTR_REF_FIRST_PAGE = 119
INSTR_REF_LAST_PAGE = 2402
EDITION_090_INSTR_REF_END = 2393

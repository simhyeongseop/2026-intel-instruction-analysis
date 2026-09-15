# 과거 자료 보관

이 폴더는 연구 경과를 보존한다. 여기 있는 지침·판정·실행 경로는 현재 프로젝트의 기준이 아니다.
현재 상태는 [README](../README.md), [단계별 안내](../docs/PIPELINE.md), [재심 결과](../docs/CASE_REVIEW_2026-09-14.md)를 따른다.

- `legacy/`: 2026년 7월 파이프라인 재구성 이전 코드·데이터·설계·실험. 원래 상대 디렉터리 구조를 유지했다.
- `prototypes/`: 2026-09-14 최신화 직전의 린터·PoC·실행기·문서.
- `MOVED_FILES.csv`: legacy로 옮긴 63개 파일의 원래 경로·보관 경로·SHA-256. 이동 전후 해시를 검사했다.
- `organize_2026-09-14.ps1`: 이번 이동 목록과 검증 절차.

옛 문서의 경로는 당시 저장소 구조를 가리킨다. 재현 시 원래 기준 디렉터리와 도구 버전을 확인해야 한다.
`legacy/data/stage6_differential/step6_diff_base_backup.csv`는 현재 diff와 내용이 달라 보존했다.


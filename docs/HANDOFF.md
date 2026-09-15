# 현재 인계 사항

갱신: 2026-09-15.

사용자 요청은 미결 연구 작업을 이어 도구 제작까지 완료하고, 단계별 파일을 정리·최신화하는 것이다.
이해도를 진단하던 질의응답은 사용자 요청으로 잠시 중단했다.

최신 Ubuntu 전체 실행은 [최신 검증 기록](LATEST_TEST_RUN.md)에서 확인할 수 있으며 `failures=0`이다. 원시 `summary.txt`와 단계별 로그는 로컬 `../out/ubuntu-tests/20260914T150211Z/`에 있다. 이 실행은 회귀 테스트, CLI, 재심 CPU, 11~12단계 실행, 13단계 lint와 manifest 검사를 모두 통과했다.

퍼징 연구 관점의 현재 한계와 우선순위는 [비판적 검토와 보완 계획](FUZZING_RESEARCH_REVIEW_2026-09-15.md)에 정리했다. 보고서의 감사 원시 결과는 `../out/review/fuzzing_audit_2026-09-15.json`, 재현 스크립트는 `review_artifacts/fuzzing_audit_2026-09-15.py`다.

## 구현

- `scripts/asm_linter.py`: 독립 명령어용 CLI. `.s`/stdin, JSON/JSONL, 종료 코드, DB 경로, 제한·타임아웃 지원.
- `pipeline/instruction_check.py`: GNU/Clang 수용, 전체 `.text` 바이트, 역어셈블, 재배치, 바이트 왕복, 옵션 차이.
- `pipeline/operand_forms.py`: 오퍼랜드 타입·크기·개수 후보 및 제한된 legacy opcode 필드 비교.
- `pipeline/m13_lint.py`: 기반 테스트 전량 및 `data/cases.csv`의 7개 추가 사례 검사.
- `pipeline/run.py`: 1~13단계 등록, 단계 선택/범위 실행, CPU 단계 선택, 실행별 환경·해시 기록.
- `scripts/run_ubuntu_tests.sh`: Ubuntu에서 회귀·CLI·재심·CPU 11~12단계·13단계 lint를 한 번에 실행하고 로그/요약을 저장.
- `tests/`: 기존 수용 정답지 23개, 독립 바이트 기대값, 오류/문맥/미지원 입력 회귀 테스트.

## 이번 재심의 결론

근거와 정확한 제한은 [재심 보고서](CASE_REVIEW_2026-09-14.md)에서 확인한다.

- LSS/LFS/LGS: objdump 2.42의 표시 결함 한 유형, 세 사례. CPU 오동작 주장이 아니다.
- UDB: SDM의 D6 명령 정의는 존재한다. 현재 as/Clang 미지원은 지원 차이이며 구현 버그로 합산하지 않는다.
- MOV Sreg: 해당 환경의 페이지 경계 실험에서 REX.W 포함 2바이트 접근 관측. 기존 구현 버그 주장을 철회하되 매뉴얼 표기의 모든 쟁점을 해결했다고 하지 않는다.
- LAR/LSL: SDM 본문은 32/64비트 동작이 같다고 명시. REX.W 생략을 실행 의미 결함으로 보는 주장은 기각하고 별도 인코딩 선택 사례로 등록했다.

triage는 `bug=3 / false_alarm=1558 / unsure=24`. 기존 판정은 `legacy_*` 열에 남겼다.
재심하지 않은 행은 `review_status=not_reassessed`다. 전체 ISA 또는 전체 결과의 의미 검증을 완료한 것은 아니다.

## 파일 정리

구 `src/`, `data/stage1~6`, 옛 분석 스크립트·설계 문서·실험은 `archive/legacy/`에 모았다.
63개 파일의 이전 경로와 내용 해시는 `archive/MOVED_FILES.csv`에 있다. 다른 내용의 backup CSV도 보존했다.
기존 린터/PoC와 최신화 전 README·지침·인계 문서는 `archive/prototypes/`에 보관했다.
루트의 `test.s`는 `examples/far_pointer.s`로 정리했다.

## 범위와 확장 과제

도구는 명시된 범위에서 사용할 수 있다. 전체 GAS 파서/CPU 의미 검사기라고 부르지 않는다.
VEX/EVEX 필드, 모든 마스크·주소·즉시값 의미, 프로그램 전체 링크 문맥, CPU 기능/OS 상태의 일반 검증은 남아 있다.
미지원 구문은 미완료로 표시하며, 이를 구현 버그나 성공으로 취급하지 않는다.
AT&T 전량 비교, 16/32비트 모드, 명시적 PIE/non-PIE 컴파일 비교는 후속 확장이다.

다음 작업은 새로운 기능을 추가하기 전에 [도구 안내](TOOL_GUIDE.md)의 범위와 [단계별 안내](PIPELINE.md)의 입력/산출물 관계를 읽고 시작한다.

# Intel Instruction Analysis

작업 재개: [짧은 최신 인계](docs/HANDOFF.md). 최신 생성 검사와 조립 결과의 기준 경로를 먼저 확인한다.

Intel 매뉴얼의 오퍼랜드 표에서 만든 x86-64 Intel-syntax 명령어를 조립하고, 생성된 기계어와 역어셈블 결과를 다시 확인하는 프로젝트다. 목적은 퍼징 입력이 **어떤 명령어로 수용되었는지, 어떤 바이트가 만들어졌는지, 도구 간 해석이 달라지는지**를 재현 가능한 기록으로 남기는 것이다.

검사 도구는 한 줄 또는 파일의 명령어를 GNU `as`와 Clang에 각각 전달하고, `.text`의 실제 바이트, `objdump` 출력, 재조립 결과, 재배치 정보를 함께 수집한다. 선택한 경계 사례에는 Linux x86-64 CPU 실행 대조도 제공한다.

## 최신 상태 (2026-10-11, SDM 093판)

현재 파이프라인은 SDM 표 행마다 케이스를 만들고, SDM을 각 도구와 따로 대조한다(도구끼리는 비교하지 않는다). 상세는 [보고서](out/cases/REPORT.md).

- 생성: 4,219행 → 19,425케이스(행마다 근거 기록)
- 판정: SDM 일치 GNU as 19,324, clang 19,108
- 역어셈블 대조: SDM 일치 바이트 19,244개 중 SDM 일치 objdump 19,211, LLVM 19,182
- 환경: WSL2 Ubuntu, GNU binutils 2.42, Clang/LLVM 18.1.3, Intel Core Ultra 5 226V

이 수치는 전체 ISA 의미 검증 완료율이 아니다. 2026-09-14 예전 13단계 전체 실행 기록은 [최신 검증 기록](docs/LATEST_TEST_RUN.md)에 남아 있다(당시 기준).

## 결과를 읽는 방법

| 확인 대상 | 답하는 질문 |
|---|---|
| 원본 입력 | 생성기나 퍼저가 실제로 어떤 Intel-syntax 문장을 냈는가? |
| SDM 후보 행 | 그 문장이 어떤 매뉴얼 오퍼랜드·opcode 후보에서 나왔는가? |
| assembler 수용 | GNU `as`와 Clang이 문장을 받아들였는가? 거부는 곧 버그가 아니다. |
| 기계어 바이트 | 실제 `.text`에 어떤 바이트가 들어갔는가? 소스 니모닉과 일대일 대응을 가정하지 않는다. |
| `objdump` | 바이트를 사람이 읽는 니모닉으로 어떻게 표시했는가? 표기 결함과 CPU 동작을 분리한다. |
| roundtrip | 표시된 바이트를 다시 조립했을 때 같은 바이트가 나오는가? 이는 표기·인코딩 점검이지 의미 증명은 아니다. |
| CPU 대조 | 권한·메모리·기능 상태를 갖춘 선택 사례가 예상대로 실행되는가? 전체 입력을 CPU에서 실행하지 않는다. |

도구 결과의 상태는 `accepted`, `rejected`, `needs_review`, `incomplete`, `tool_error`로 나뉜다. 종료 코드는 0=제한 검사 통과, 1=거부 또는 검토 항목, 2=미완료·설정·도구 오류다. `accepted`와 종료 코드 0도 매뉴얼 전체 적합성이나 CPU 실행 성공을 보증하지 않는다.

## 명령어 검사 도구

```bash
python3 scripts/asm_linter.py "mov eax, ebx"
python3 scripts/asm_linter.py --file examples/fuzz_inputs.s
python3 scripts/asm_linter.py --stdin --format jsonl < input.s
python3 scripts/asm_linter.py --demo --format json --output out/demo.json
```

Windows에서는 각 명령 앞에 `wsl -d Ubuntu --`를 붙인다. 상세 옵션과 JSON 스키마는 [도구 안내](docs/TOOL_GUIDE.md)를 본다. 이 도구는 한 문장 단위 검사를 위한 것이며 프로그램 전체의 링크·실행 의미를 판정하지 않는다.

## 파이프라인

현행 단계는 PDF 추출(1) → SDM 행별 케이스 생성(2) → 도구별 판정(3, SDM 대 GNU as / SDM 대 clang) → 역어셈블러별 대조(4, SDM 대 objdump / LLVM)이다.

```bash
python3 pipeline/run.py --list
python3 pipeline/run.py generator --until check
python3 pipeline/run.py --only check --execute   # SDM 일치한 레지스터 전용 케이스를 이 CPU에서 격리 실행
python3 pipeline/run.py --only disasm
```

입력·출력·재실행 순서는 [파이프라인 안내](docs/PIPELINE.md)에 정리했다. 실행별 도구 버전, 해시, 명령행, 성공 여부는 `out/runs/`에 기록된다.
예전 5~13단계(조립·왕복·triage·clang 비교·재조립·CPU 실행·lint)는 2026-10-11에 삭제했다. 그 과거 결과 파일은 `out/`에 남아 있다.

## 주요 결과 파일

- [생성·판정·역어셈블 대조 보고서](out/cases/REPORT.md) · [케이스](out/cases/cases.csv) · [판정](out/cases/check_results.csv) · [역어셈블 대조](out/cases/disasm_results.csv)
- [재심 원시 기록](out/review/cases.json) · [재심 해설](docs/CASE_REVIEW_2026-09-14.md) · [유효 범위와 버그 판정 기준](docs/RESULT_VALIDITY_AND_BUG_CRITERIA.md)
- [퍼징 연구 관점의 비판적 검토와 보완 계획](docs/FUZZING_RESEARCH_REVIEW_2026-09-15.md) · [검토 감사 원시 결과](out/review/fuzzing_audit_2026-09-15.json)

원본 PDF는 루트의 `intel_manual.pdf`를 사용하지만 용량과 배포 문제로 Git에는 포함하지 않는다. 모든 입력의 CPU 의미 검증은 이 저장소의 현재 자동 검사 범위가 아니다. VEX/EVEX 필드, 모든 마스크·주소·즉시값 제약, 링크 문맥, CPU 기능·OS 상태는 제한적으로만 다룬다.

## 폴더 구성

- `pipeline/`: 현행 1~4단계, CPU 실행 관측(`cpu_run.py`), 공통 검사 API
- `scripts/`: CLI, 재심, SDM 검토 스크립트
- `data/db/`: 현재 ISA DB
- `data/cases.csv`: 사람이 지정한 추가 경계 사례
- `tests/`: 회귀 테스트와 CPU 재심 소스
- `out/`: 재현 결과와 실행 기록
- `examples/`: 도구 사용 예제
- `archive/`: 이전 코드·산출물. 이동 목록과 해시는 [MOVED_FILES.csv](archive/MOVED_FILES.csv)에 있다.
- `docs/MEETING_NOTES/`: 과거 회의록. 현재 문서와 읽는 방법은 [회의록 안내](docs/MEETING_NOTES/README.md)를 따른다.

## 필요한 환경과 기본 검증

Python 3.10 이상, GNU binutils의 `as`·`objdump`·`objcopy`·`readelf`, Clang이 필요하다. CPU 단계에는 Linux x86-64의 `ld`와 C 빌드 환경이 추가로 필요하며, PDF 추출에는 `pdfplumber`, 페이지 렌더링에는 `pypdfium2`가 필요하다.

```bash
python3 -m unittest discover -s tests -p 'test_*.py' -v
python3 scripts/review_cases.py
```

현재 인계 내용은 [HANDOFF](docs/HANDOFF.md), 개발 이력은 [DEVLOG](docs/DEVLOG.md)에서 확인한다.

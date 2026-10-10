# Intel Instruction Study — 현재 프로젝트 지침

갱신: 2026-10-09. 시작할 때 [현재 인계](docs/HANDOFF.md)와 [공통 작업 기준](AGENTS.md)을 읽는다.
이후에는 작업 대상의 코드·데이터·근거만 읽고 과거 기록은 필요한 경우 확인한다.

## 목적

Intel SDM의 형식에서 만든 입력과 실제 어셈블러/역어셈블러 처리를 대조하고,
다른 퍼징 실험에서 명령어 입력을 검사할 수 있는 도구를 제공한다.

## 작업 기준

- 사용자가 이해하고 설명할 수 있게 쉬운 Python과 작은 함수를 사용한다.
- ISA 의미는 Intel 매뉴얼, 도구 입력 문법·지원 범위는 해당 버전의 도구 문서를 확인한다.
- 소스 문자열, 의도한 SDM 행, 실제 바이트, 역어셈블 출력, CPU 관측을 구분한다.
- 수용 성공·바이트 동일·정상 종료만으로 실행 의미나 전체 ISA 적합성을 확정하지 않는다.
- 발견 유형과 확정 상태는 별도 기록한다. 기준은 [판정 기준](docs/RESULT_VALIDITY_AND_BUG_CRITERIA.md),
  개별 재심 근거는 [재심 보고서](docs/CASE_REVIEW_2026-09-14.md), 최신 생성 상태는 인계 문서를 따른다.
- 근거가 부족한 것은 미확인 상태로 둔다. `not_reassessed`를 확정이라고 보고하지 않는다.
- 기존 사용자 변경과 실험 근거를 보존한다. 과거 자료는 `archive/`에 있으며 현재 실행 지침이 아니다.
- 새 코드에는 그 코드와 독립적인 기대값·반례로 검증을 수행한다. 검증하지 않은 사실을 통과했다고 쓰지 않는다.
- 작업 범위를 바꿀 때 생성물·판정·문서를 함께 점검하고, 변경 이유와 검증 범위를 `docs/DEVLOG.md`에 남긴다.

## 현재 구조

| 위치 | 역할 |
|---|---|
| `pipeline/m1_*.py` ~ `m13_*.py` | 현재 단계별 모듈 |
| `pipeline/run.py` | 단계 선택 실행, 실행 기록 |
| `pipeline/instruction_check.py`, `operand_forms.py` | 검사 도구의 공통 API와 부분 오퍼랜드/opcode 대조 |
| `pipeline/review_verdicts.py` | 날짜와 근거를 가진 재심 판정; 기존 판정 보존 |
| `scripts/asm_linter.py` | 사용자용 CLI |
| `scripts/review_cases.py` | 고정 재심 사례 및 제한된 CPU 대조 실험 |
| `data/db/` | 기준 추출 DB·토큰·조합 |
| `data/cases.csv` | 이름이 고정된 추가 사례. 기존 combo ID와 구분 |
| `tests/`, `examples/` | 회귀 검증·사용 예제 |
| `out/` | 단계별 결과; `docs/PIPELINE.md`에서 매핑 |
| `archive/legacy/`, `archive/prototypes/` | 구 파이프라인과 이전 문서/프로토타입 |

## 실행·검증

Windows에서는 WSL Ubuntu를 사용한다. 1단계만 `pdfplumber`가 추가로 필요하다.
일반 검사 도구는 입력 명령어를 실행하지 않는다. 11·12단계 CPU 실험은 `--execute`로 선택한다.
임의의 사용자 입력을 CPU 실험 목록으로 자동 승격하지 않는다.

```bash
python3 pipeline/run.py --list
python3 -m unittest discover -s tests -p 'test_*.py' -v
python3 scripts/asm_linter.py --demo
```

전체 개발·현재 데이터 기준은 [단계별 안내](docs/PIPELINE.md), [인계 문서](docs/HANDOFF.md)를 참고한다.
`.claude/agents/`의 오래된 모듈 지침과 충돌하면 현재 코드와 위 문서의 기준을 적용한다.

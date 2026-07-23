# Intel Instruction Study — 프로젝트 지침

<!-- 이 파일은 형섭이 소유하는 마스터 설계 문서입니다. Claude Code는 매 세션 이 파일을 먼저 읽습니다.
     원칙: 형섭이 이해·설명할 수 있는 수준으로만 유지한다. 이해 안 되는 내용은 넣지 않는다. -->

## 0. 한 줄 목적

인텔 매뉴얼(Intel SDM Vol.2)의 명령어 문법(**Intel syntax**)을 어셈블러가 얼마나 정확히 지원하는지 검사한다.
찾고 싶은 것: **"매뉴얼대로 작성했는데 어셈블러/디스어셈블러가 제대로 처리하지 못하는 경우"**.

## 1. 핵심 원칙 (반드시 지킬 것)

- **정답 = 인텔 매뉴얼.** 어셈블러가 받아주는지가 아니라, 매뉴얼이 그렇게 정의하는지가 기준이다.
- **어셈블러는 하나부터.** 기본은 GNU `as` (Intel syntax). `clang`/`llvm-mc`는 옵션 스위치로만.
  정답지가 있으므로 여러 어셈블러 다수결(differential testing)은 지금 하지 않는다.
- **심플 우선.** 형섭이 구조를 이해하고 교수님께 설명할 수 있어야 한다. 어려우면 모듈을 합쳐도 된다.
- **쉬운 파이썬.** 최신 문법·과한 추상화 금지. 함수는 짧게, 주석은 한국어로.
- **설계는 형섭이 소유한다.** LLM은 보조. 판정은 도구(as/objdump)가 하고, 설명·그룹핑은 사람이 주도한다.
- **차이 ≠ 버그.** 원본과 역어셈블 결과가 달라도 alias/동등표현일 수 있다. triage로 반드시 구분한다.
- **재현 가능.** DB·산출물은 git에 기록하고, 바꾼 이유는 `docs/DEVLOG.md`에 남긴다.
- (참고) 에이전트별 모델을 바꾸려면 각 `.claude/agents/*.md` frontmatter에 `model: sonnet|opus|haiku` 추가.

## 2. 하이레벨 설계 (교수님 미팅 기반)

```
Intel SDM PDF
  │
  ▼
[1 extractor]  매뉴얼 → ISA DB (opcode / instruction / mnemonic / description 등 테이블 전체)
  ▼
[2 tokenizer]  mnemonic·operand form을 토큰으로 분해
  ▼
[3 combiner]   토큰으로 가능한 operand 조합 생성
  ▼
[4 generator]  조합에서 하나(또는 몇 개) 선택 → 구체 Intel-syntax 어셈블리 생성
  ▼
[5 assembler]  어셈블리 → 기계어 (GNU as)   ──컴파일 에러──▶ [7 triage]
  ▼ (성공)
[6 roundtrip]  기계어 → objdump 역어셈블 → 원본과 비교   ──차이 발견──▶ [7 triage]
  ▼
[7 triage]     에러·차이를 유형별로 그룹핑, 원인 분석, false alarm(오탐) 구분
```

검증: `[verifier]`가 각 모듈의 산출물을 **소규모 정답지**로 대조한다 (파이프라인과 직교하는 별도 역할).

## 3. 모듈 = 에이전트 (per-module)

| 에이전트 | 입력 | 출력 | 한 줄 책임 |
|---|---|---|---|
| `extractor` | `325383-090-sdm-vol-2abcd.pdf` | `data/db/isa_db.csv` | 테이블 전체 컬럼 추출 (2가지 레이아웃 자동판별) |
| `tokenizer` | `isa_db.csv` | `data/db/tokens.csv` | mnemonic/operand를 토큰으로 분해 |
| `combiner` | `tokens.csv` | `data/db/combos.csv` | operand 타입 → 가능한 조합 생성 |
| `generator` | `combos.csv` | `out/tests.s` | 조합 선택 + Intel-syntax 어셈블리 생성 |
| `assembler` | `out/tests.s` | `out/asm_result.csv` | GNU as 어셈블 + 에러 수집 |
| `roundtrip` | 기계어(.o) | `out/roundtrip.csv` | objdump 역어셈블 + 원본 비교 |
| `triage` | 에러·차이 | `out/triage.csv` + 리포트 | 그룹핑·원인분석·false alarm |
| `verifier` | 각 산출물 | pass/fail + 피드백 | 정답지 대조·회귀 검증 (수정은 안 함) |

각 에이전트의 상세 지침은 `.claude/agents/<name>.md` 에 있다.

## 4. 개발 루프 (하네스) — 교수님 지시 "개발하는 애 + 검증하는 애"

1. 오케스트레이터(= 형섭이 대화하는 메인 세션)가 이번에 작업할 **모듈 하나**를 정한다.
2. 그 모듈의 에이전트(`@agent-<name>`)가 코드를 작성/수정한다.
3. **끝나면 항상 `@agent-verifier`를 거친다.** 정답지·회귀 테스트를 돌린다.
4. 실패하면 verifier의 피드백을 그 모듈 에이전트에게 돌려 고친다. (2~4 반복)
5. 통과하면 `docs/DEVLOG.md`에 "무엇을·왜" 바꿨는지 적고 git commit.

- **한 번에 한 모듈만.** 검증을 통과하지 않으면 다음 모듈로 넘어가지 않는다.
- 전체를 순서대로 돌리려면 `/run-pipeline` 커맨드를 쓴다.

## 5. 디렉터리 (새로 시작 — 기존 코드는 참고만)

```
pipeline/    m1_extract.py … m7_triage.py, run.py     (쉬운 파이썬으로 새로 작성)
tests/       answer_keys/ (형섭이 손으로 만든 정답지), test_modules.py
data/db/     ISA DB 등 (git에 등록)
out/         생성 어셈블리·결과 CSV (재생성 가능, git 제외 가능)
docs/DEVLOG.md
.claude/agents/    모듈별 에이전트 지침
.claude/commands/  /run-pipeline
```

- 기존 `src/`, 옛 `data/`, 고도화 문서(`docs/STAGE*`, llvm-mc·iced-x86·변주축 A~F·음성셋 N1~N8)는
  **참고용 read-only**. 재사용하지 말고, 위 구조로 **심플하게 새로** 작성한다.

## 6. 스코프

- **v1 (지금):** extractor → triage, GNU as 1개, Intel syntax, 소규모 정답지 검증.
- **나중:** `clang` 옵션 추가 → AT&T syntax 변환/비교(특허·시멘틱 갭 이슈) → 실행 시 SIGILL 탐색.
- **참고:** 교수님 이전 연구 **as-fuzzer**(GitHub 공개, 구조 유사). 실제 링크는 교수님께 요청해서 이 자리에 채운다.

## 7. 검증·정답지 규칙

- 형섭이 이해하는 간단한 명령어(예: `mov`, `add`, `push`)로 **소규모 정답지**를 손으로 만든다.
- `verifier`는 그 정답지로 generator/assembler 출력이 맞는지 확인 → 회귀(기존 통과 케이스가 깨짐) 방지.
- **LLM 판단만으로 "버그"라고 결론짓지 않는다.** 근거는 항상 도구(as/objdump) 결과다.

<!-- 다음 미팅: 약 2주 후, 비대면 가능(Slack). 미팅 전 DEVLOG에 진행상황을 형섭 본인 말로 정리해 둘 것. -->

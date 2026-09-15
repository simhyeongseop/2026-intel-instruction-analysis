# Intel Instruction Analysis (2026-09-14 도구 완성 전 기록)

Intel SDM(Software Developer's Manual) Volume 2에서 명령어 인코딩 표를 추출하고, 이를
실제 Intel-syntax assembly test case로 변환한 뒤 어셈블러(GNU as)/역어셈블러(objdump)의
동작을 검증하는 연구 프로젝트입니다.

## 연구 질문

```text
Intel SDM이 정의한 명령어 문법(Intel syntax)을 그대로 지켜서 작성했는데도
어셈블러(as)/디스어셈블러(objdump)가 매뉴얼과 다르게 처리하는 경우가 있는가?
```

## 설계 원칙 (CLAUDE.md)

- **ISA 동작의 기준 = 인텔 매뉴얼.** 문법 지원·옵션은 해당 도구의 문서도 함께 확인한다. 매뉴얼과의 차이를 바로 구현 버그로 간주하지 않는다.
- **판정은 도구가 한다.** LLM 추정만으로 "버그"라고 결론짓지 않는다 — `as`/`objdump` 직접
  실행 + SDM 원문 대조를 거친 것만 확정.
- **차이 ≠ 버그.** 원본과 역어셈블 결과가 텍스트로 달라도 alias·표기 관례일 수 있다 —
  반드시 triage로 원인을 구분한다.
- **개발 + 검증 분리.** 모듈 하나를 구현하면 반드시 별도 검증(현재는 OpenAI Codex를
  독립 검증자로 사용)을 거친 뒤 다음 단계로 넘어간다.

상세 설계는 [`CLAUDE.md`](CLAUDE.md), 진행 기록은 [`docs/DEVLOG.md`](docs/DEVLOG.md) 참고.
**현재 결과의 유효 범위와 버그 판정·보고 기준은
[`docs/RESULT_VALIDITY_AND_BUG_CRITERIA.md`](docs/RESULT_VALIDITY_AND_BUG_CRITERIA.md)를 따른다.**
과거 보고서와 CSV의 `bug` 레이블은 새 기준의 최종 확정 수와 구분한다.

## 파이프라인 (12단계)

```text
Intel SDM PDF
  │
  ▼
[1 extractor]     매뉴얼 -> ISA DB (opcode/instruction/mnemonic/operands/mode_support 등)
  ▼
[2 tokenizer]     mnemonic·operand form을 토큰으로 분해
  ▼
[3 combiner]      토큰 -> 가능한 operand 조합 생성 (대표값, 조합 폭발 방지)
  ▼
[4 generator]     조합 -> 구체 Intel-syntax 어셈블리 (out/tests.s)
  ▼
[5 assembler]     GNU as로 한 줄씩 개별 어셈블   ──컴파일 에러──▶ [7 triage]
  ▼ (성공)
[6 roundtrip]     objdump 역어셈블 후 원본과 텍스트 비교   ──차이 발견──▶ [7 triage]
  ▼
[7 triage]        에러·차이를 유형별로 그룹핑, false alarm과 진짜 버그 구분
  │
  ├─ [8 clang_assemble] / [9 clang_compare]   — GNU as vs clang 독립 어셈블러 교차검증
  ├─ [10 reassemble_check]                     — objdump 텍스트를 다시 어셈블해 바이트 단위 재검증
  ├─ [11 execute]                              — 고정 주소 실행파일 + 격리 프로세스로 실제 실행(주소/권한 시나리오)
  └─ [12 execute_edge_cases]                   — N.E./Invalid로 표시됐는데 assemble된 케이스를 자동 실행
```

## 현재 결과 (2026-09-14 저장 데이터 재집계)

아래는 저장된 산출물을 다시 집계한 값이다. 전체 실험을 새로 실행한 결과가 아니다.

| 단계 | 산출물 | 수치 |
|---|---|---|
| 1 extractor | `data/db/isa_db.csv` | SDM 명령어 폼 4,210건 |
| 2 tokenizer | `data/db/tokens.csv` | 오퍼랜드 토큰 9,820건 |
| 3 combiner | `data/db/combos.csv` | 구체 조합 7,277건 (추출 DB 4,210행 모두에 조합 생성) |
| 4 generator | `out/tests.s` | 테스트 7,276개, 포함 DB 행 4,209개, 고유 소스 문자열 6,024개 |
| 5 assembler | `out/asm_result.csv` | 성공 7,162 / 실패 114 |
| 6 roundtrip | `out/roundtrip.csv` | same 5,706 / different 1,456 |
| 7 triage | `out/triage.csv` | **기존 레이블: bug 4 / false_alarm 1,557 / unsure 24** |
| 8~9 clang 비교 | `out/clang_compare.csv` | 바이트까지 동일 7,058 / 다름 48 / as만 성공 56 / clang만 성공 18 / 둘 다 거부 96 |
| 10 재어셈블 검증 | `out/reassemble_check.csv` | 바이트 동일 1,326 / 다름 5 / 검증 한계 99 / 재어셈블 불가 26 |
| 11 절대주소 실행 | `out/address_test_result.csv` | 손으로 설계한 6개 시나리오 전부 예측과 일치 |
| 12 N.E. 케이스 실행 | `out/edge_case_execution.csv` | 19건 실제 실행 (exit0 14 / SIGSEGV 5) |

### 현재 보고할 발견과 확정 수준

| 사례 | 기존 레이블 | 현재 보고 기준 |
|---|---|---|
| LSS/LFS/LGS의 REX.W r64 형태 | bug 3행 | 메모리 크기 표시 결함 한 유형의 세 사례. 기존 증거가 원인을 지지하나 재심 중. CPU 오동작이나 as 인코딩 결함으로 합산하지 않음 |
| UDB | bug 1행 | 니모닉 미지원 관측. 해당 버전의 지원 범위·명세 해석을 확인하기 전까지 구현 버그 여부 보류 |
| MOV Sreg 메모리형 | unsure | 표기의 폭과 실제 접근 폭의 관계 미결 |
| LAR/LSL 기존 비대칭 폼, VPMOVQD | false_alarm | 9월 3일 기존 버그 주장 기각. LAR/LSL의 대칭 r64 소스는 별도 인코딩 결함 후보 |

**새 기준에 따른 최종 확정 버그 수는 아직 산정하지 않는다.** 기존 CSV의 4행을
독립적으로 확정된 버그 네 개라고 설명하지 않는다. 상세 근거와 필요한 후속 검증은
[판정 기준 문서](docs/RESULT_VALIDITY_AND_BUG_CRITERIA.md)에 정리했다.

### 수치 해석의 범위

- DB 행 전체에 조합을 만들었다는 것은 ISA 전체·모든 오퍼랜드·의도한 opcode 행을 검증했다는 뜻이 아니다.
  `ENCODEKEY256` 한 건은 토큰화 문제로 생성에서 제외됐다.
- 두 어셈블러의 바이트 동일성은 구현 간 일치다. SDM 적합성을 독립적으로 증명하지 않는다.
- 재어셈블 바이트 동일 1,326개는 기존 판정과 연결하면 **false_alarm 1,313 + unsure 13**이다.
  바이트 보존만으로 원래 소스의 의미까지 맞았다고 판단하지 않는다.
- 실행 결과 6개 시나리오와 19개 선별 사례는 해당 환경·초기 상태에서의 관측이다.
  전체 테스트의 실행 정확성이나 CPU 전체로 일반화하지 않는다.

### 중요한 방법론적 발견

`CALL`/`JMP`, `DEC`/`INC`, `LEAVE` 등에서 확인된 문제는 **매뉴얼 표 행을
소스로 옮겼다고 해서 실제로 그 인코딩 행을 테스트한 것은 아니라는 점**이다.
모드·접두어·실제 opcode를 확인해야 한다. 또한 CPU 기능·권한 조건 때문에 실행 결과가
달라지는 경우도 별도로 구분해야 한다. 모든 오탐을 같은 원인으로 묶지 않는다. 상세 근거는
`out/clang_compare_evidence_raw.md`, `out/edge_case_execution_evidence.md` 참고.

## 주요 디렉터리

```text
pipeline/    m1_extract.py ~ m12_execute_edge_cases.py, run.py   (실행 파이프라인)
data/db/     isa_db.csv / tokens.csv / combos.csv (git에 기록됨)
out/         생성 어셈블리·결과 CSV·리포트 (재생성 가능, 대용량 .o 오브젝트는 git 제외)
tests/       answer_keys/ (손으로 만든 정답지), manual_bug_check.py
docs/        설계 문서(CLAUDE.md), DEVLOG.md, MEETING_NOTES/
src/, data/stage1~6, docs/STAGE*, llvm-mc·iced-x86 관련 문서   — 예전(v1 이전) 설계, 참고용
```

## 실행 (WSL Ubuntu 필요 — Windows엔 as/objdump/clang 없음)

```bash
# 전체 파이프라인 (1단계부터)
python3 pipeline/run.py

# 특정 단계부터 (이전 산출물이 이미 있다고 가정)
python3 pipeline/run.py generator        # 4단계부터
python3 pipeline/run.py clang_assemble   # 8단계부터
```

## 환경 요구사항

- Python 3.10+ (표준 라이브러리만 사용, 외부 패키지 불필요)
- WSL(Ubuntu) 또는 Linux: GNU `as`/`objdump`/`ld`(binutils), `clang`
- 입력 PDF: `325383-090-sdm-vol-2abcd.pdf` (git 미포함, 별도 준비)

## 스코프

- **v1 (완료):** extractor → triage, GNU as 1개, Intel syntax, 소규모 정답지 검증
- **v2 (완료):** clang 비교, objdump 바이트 재검증, 절대주소 실행 검증, N.E. 케이스 실제 실행
- **다음:** 커버리지 세분화, `-fno-pie` 명시적 비교, AT&T syntax 변환/비교

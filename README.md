# Intel Instruction Analysis

Intel SDM(Software Developer's Manual) Volume 2에서 명령어 인코딩 표를 추출하고, 이를
실제 Intel-syntax assembly test case로 변환한 뒤 어셈블러(GNU as)/역어셈블러(objdump)의
동작을 검증하는 연구 프로젝트입니다.

## 연구 질문

```text
Intel SDM이 정의한 명령어 문법(Intel syntax)을 그대로 지켜서 작성했는데도
어셈블러(as)/디스어셈블러(objdump)가 매뉴얼과 다르게 처리하는 경우가 있는가?
```

## 설계 원칙 (CLAUDE.md)

- **정답 = 인텔 매뉴얼.** 어셈블러가 받아주는지가 아니라, 매뉴얼이 그렇게 정의하는지가 기준.
- **판정은 도구가 한다.** LLM 추정만으로 "버그"라고 결론짓지 않는다 — `as`/`objdump` 직접
  실행 + SDM 원문 대조를 거친 것만 확정.
- **차이 ≠ 버그.** 원본과 역어셈블 결과가 텍스트로 달라도 alias·표기 관례일 수 있다 —
  반드시 triage로 원인을 구분한다.
- **개발 + 검증 분리.** 모듈 하나를 구현하면 반드시 별도 검증(현재는 OpenAI Codex를
  독립 검증자로 사용)을 거친 뒤 다음 단계로 넘어간다.

상세 설계는 [`CLAUDE.md`](CLAUDE.md), 진행 기록은 [`docs/DEVLOG.md`](docs/DEVLOG.md) 참고.

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

## 현재 결과 (2026-08-25 기준)

| 단계 | 산출물 | 수치 |
|---|---|---|
| 1 extractor | `data/db/isa_db.csv` | SDM 명령어 폼 4,210건 |
| 2 tokenizer | `data/db/tokens.csv` | 오퍼랜드 토큰 9,820건 |
| 3 combiner | `data/db/combos.csv` | 구체 조합 7,277건 (**SDM 4,210건 전량 커버, 100%**) |
| 4 generator | `out/tests.s` | 어셈블리 테스트 라인 7,276줄 |
| 5 assembler | `out/asm_result.csv` | 성공 7,162 / 실패 114 |
| 6 roundtrip | `out/roundtrip.csv` | same 5,706 / different 1,456 |
| 7 triage | `out/triage.csv` | **bug 8 / false_alarm 1,554 / unsure 23** |
| 8~9 clang 비교 | `out/clang_compare.csv` | 바이트까지 동일 7,058 / 다름 48 / as만 성공 56 / clang만 성공 18 / 둘 다 거부 96 |
| 10 재어셈블 검증 | `out/reassemble_check.csv` | 바이트 동일 1,326 / 다름 5 / 검증 한계 99 / 재어셈블 불가 26 |
| 11 절대주소 실행 | `out/address_test_result.csv` | 손으로 설계한 6개 시나리오 전부 예측과 일치 |
| 12 N.E. 케이스 실행 | `out/edge_case_execution.csv` | 19건 실제 실행 (exit0 14 / SIGSEGV 5) |

### 확정된 버그 8건 (도구 재현 + SDM 원문 대조 완료)

**GNU as vs SDM 불일치 (5건):**
- `LAR r32, r64` / `LSL r64, r32` — SDM이 명시적으로 허용하는 레지스터 폭 조합을 `as`가 파서 단계에서 거부 (clang은 받아줌, 독립 어셈블러로 교차 확인)
- `MOV Sreg, r/m64` (메모리 형태) — `as`가 REX.W + 8E /r의 메모리 오퍼랜드 경로를 구현하지 않음
- `UDB` — SDM에 정의된 니모닉을 `as`가 아예 모름
- `VPMOVQD xmm1/m128, ...` — SDM은 m128을 허용하는데 `as`는 m64(qword ptr)만 허용

**objdump 디스어셈블 표시 결함 (3건, `as`의 문제 아님):**
- `LSS`/`LFS`/`LGS` 의 REX.W(64비트) 형태 — `as`는 SDM 그대로 정확히 인코딩하지만 `objdump`가
  메모리 오퍼랜드 크기를 항상 `FWORD PTR`(6바이트)로 표시함 (m16:64는 `TBYTE PTR` 10바이트가 맞음)

### 중요한 방법론적 발견

`CALL`/`JMP r/m32`, `DEC`/`INC r16·r32`, `LEAVE`, `LGDT`/`LIDT`, `BNDCL` 계열 등 **6개
니모닉 그룹**에서 반복 확인된 패턴: SDM이 같은 Intel-syntax 문법 텍스트를 레지스터/주소
폭이 다른 여러 표 행으로 나눠 문서화하는데, 그 폭 차이가 문법만으로는 구분되지 않아
테스트 생성기가 의도한 N.E.(인코딩 불가) 행이 아니라 다른 유효한 행을 실수로 테스트해
버리는 경우가 있다. 이 6건은 전부 ModRM 바이트를 직접 디코딩해 확인했고, 애초에 "진짜
버그"가 아니라 자동 생성 파이프라인 자체의 한계로 재분류했다. 상세 근거는
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

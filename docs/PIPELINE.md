# 현재 파이프라인과 파일 안내

기준: 2026-09-15. 이 표의 단계 번호가 현행 기준이다. `archive/legacy/`의 옛 1~6단계와 구분한다.

| 단계 | 하는 일 | 구현 | 입력 | 결과 |
|---|---|---|---|---|
| 1 extractor | PDF 인코딩 표 추출 | `pipeline/m1_extract.py` | `intel_manual.pdf` | `data/db/isa_db.csv`, `data/db/coverage_report.md` |
| 2 tokenizer | 오퍼랜드 표기 분해 | `pipeline/m2_tokenize.py` | `isa_db.csv` | `data/db/tokens.csv` |
| 3 combiner | 대표 오퍼랜드 조합 | `pipeline/m3_combine.py` | `tokens.csv` | `data/db/combos.csv` |
| 4 generator | 조합을 소스로 작성 | `pipeline/m4_generate.py` | `combos.csv` | `out/tests.s`, `out/generator_skipped.csv` |
| 5 assembler | GNU as 수용 여부 | `pipeline/m5_assemble.py` | `tests.s` | `out/asm_result.csv`, `out/objects/*.o` |
| 6 roundtrip | objdump 텍스트 비교 | `pipeline/m6_roundtrip.py` | 5단계 CSV·오브젝트 | `out/roundtrip.csv` |
| 7 triage | 차이 분류와 재심 반영 | `pipeline/m7_triage.py` | 5·6단계 CSV | `out/triage.csv`, `out/triage_report.md` |
| 8 clang_assemble | Clang 수용 여부 | `pipeline/m8_clang_assemble.py` | `tests.s` | `out/clang_result.csv`, `out/clang_objects/*.o` |
| 9 clang_compare | GNU/Clang 바이트 비교 | `pipeline/m9_clang_compare.py` | 5·8단계 CSV·오브젝트 | `out/clang_compare.csv`, `out/clang_compare_report.md` |
| 10 reassemble_check | objdump 출력 바이트 왕복 | `pipeline/m10_reassemble_check.py` | 6단계 CSV·오브젝트 | `out/reassemble_check.csv`, `out/reassemble_check_report.md` |
| 11 execute | 고정 주소 6개 CPU 시나리오 | `pipeline/m11_execute.py` | 코드 내 고정 시나리오 | `out/address_test_result.csv` |
| 12 execute_edge_cases | 선별된 경계 사례 실행 | `pipeline/m12_execute_edge_cases.py` | 5단계 CSV | `out/edge_case_execution.csv`, `out/edge_case_execution_report.md` |
| 13 lint | 새 도구로 입력 전량 재검사 | `pipeline/m13_lint.py` | 5단계 CSV·ISA DB·`data/cases.csv` | `out/lint/results.csv`, `report.md`, `manifest.json`, `observations.jsonl` |

11·12단계는 CPU에서 실제 실행한다. 실행기는 `--execute`가 있을 때 이 단계를 포함한다.
13단계는 오브젝트를 다시 만들어 조사하므로 기존 `.o`가 없어도 실행할 수 있다.
5·8단계 오브젝트는 Git에 저장하지 않는다. 6·9·10단계를 다시 실행하려면 해당 오브젝트부터 재생성해야 한다.

## 단계 선택

```bash
python3 pipeline/run.py --list
python3 pipeline/run.py --only triage
python3 pipeline/run.py --only lint
python3 pipeline/run.py generator --until reassemble_check
python3 pipeline/run.py execute --until execute_edge_cases --execute
bash scripts/run_ubuntu_tests.sh
```

Ubuntu에서 남은 검증을 한 번에 실행하려면 `run_ubuntu_tests.sh`를 사용한다. 각 단계 로그와
최종 요약은 `out/ubuntu-tests/<UTC timestamp>/`에 저장된다. 시간이 오래 걸리는 CPU·lint를
생략하려면 `--skip-execute`, `--skip-lint`를 붙인다.

현재 저장된 마지막 전체 실행은 [최신 검증 기록](LATEST_TEST_RUN.md)에 요약돼 있다.

입력 누락 또는 단계 실패 시 중단한다. 어느 단계가 실행/생략/실패했는지는 `out/runs/*.json`을 본다.
외부 디렉터리에서 실행기를 절대 경로로 호출해도 단계의 작업 디렉터리는 프로젝트 루트로 고정된다.
단계를 직접 호출할 때는 프로젝트 루트에서 실행한다(13단계는 자체 경로 해석을 지원).

## 추가 사례와 재심

`data/cases.csv`는 사람이 이름을 붙인 추가 사례다. 기존 `combo_id`를 밀거나 바꾸지 않고 13단계에서 함께 검사한다.
LAR/LSL 대칭 r64 사례도 여기에 포함한다. 원래 생성기 사례 수와 추가 사례 수를 따로 집계한다.

재심용 `scripts/review_cases.py`는 고정된 27개 소스의 as/Clang 결과와 20개 CPU 대조 관측을 남긴다.
`--skip-cpu`를 주면 어셈블·역어셈블만 수행한다. CPU 테스트 소스는 `tests/review_cpu_cases.c`다.
이 실험은 11·12단계의 일반 실행과 독립적인, 가설을 구분하기 위한 대조 실험이다.

`out/*_evidence*.md`는 과거 분석의 원시 기록이며 작성 당시 결론이 포함돼 있다.
현재 결론은 [재심 보고서](CASE_REVIEW_2026-09-14.md)와 `pipeline/review_verdicts.py`를 따른다.
`triage.csv`의 `legacy_category`, `legacy_verdict`, `legacy_diff_cause`는 이전 기록을 보존한다.

## 역할 블록 (2026-09-19 정리)

13단계는 그대로 두고, 역할이 다른 네 블록으로 나눠 본다. 블록 사이에 "무엇을 넘기고 무엇은 넘기지
않는가"를 정해 두지 않으면, 생성 단계의 결함이 뒤 단계에서 어셈블러 결함처럼 보인다.

| 블록 | 단계 | 넘기는 것 | 넘기지 않는 것 |
|---|---|---|---|
| A 입력 구축 | 1~4 | 소스, 의도한 SDM 행, 매뉴얼 기대(mode_support), 생성 근거(note) | 맞다/틀리다는 판단 |
| B 관측 | 5·6·8~12 | 수용/거부, 에러 원문, `.text` 바이트, objdump 출력, 도구 버전 | 버그 여부 |
| C 판정 | 7·13 | 분류와 근거, 확정 상태 | 근거 없는 확정 |
| D 점검 | 도구 4종 | 절차상 오류, 사람이 확인할 목록 | 자동 판정 |

A의 원칙: **한 줄은 자기가 겨냥한 인코딩 행을 실제로 때려야 한다.** 예를 들어 `mov al, [0x1000]`은
as가 받아주지만 `8a 04 25`(ModRM)로 가서 moffs 행(A0)을 시험하지 못한다. 수용 성공은 검증이 아니다.

B의 원칙: 진단 거부와 도구 사건을 섞지 않는다. 5단계 `actual_result`는 `ok / error / crashed / timeout`
네 값이며, `crashed`·`timeout`은 7단계에서 `tool_process_failure`·`unsure`로 남고 false_alarm이 되지 않는다.

## 점검 도구 (D 블록)

판정을 자동화하지 않는다. 사람이 확인해야 할 것을 모아 주거나, 사람이 세기 어려운 절차상 오류를 잡는다.

| 도구 | 무엇을 보나 | 출력 |
|---|---|---|
| `scripts/check_pipeline_health.py` | 결과 파일이 같은 입력에서 나왔는지, ID가 이동했는지, 미판정이 얼마나 남았는지 | `out/review/health_report.md` (FAIL 있으면 종료 코드 1) |
| `scripts/review_generated_input.py` | 생성된 줄을 매뉴얼 원문·PDF 쪽·바이트·재현 명령과 함께 | `out/review/input_review.md` (판단 기입란 포함) |
| `scripts/audit_verdicts.py` | 기록된 판정 근거가 지금도 재현되는지 (강한 판정은 전수) | `out/review/verdict_audit.md` |
| `scripts/compare_round.py` | 수정 전후 수용 상태 변화, 특히 수용→거부 | `out/review/round_diff.md` |

```bash
python3 scripts/check_pipeline_health.py
python3 scripts/review_generated_input.py --changed
python3 scripts/audit_verdicts.py --sample 40
python3 scripts/compare_round.py
```

## 수치와 재현 범위

DB 4,210행 전부가 생성 입력에 포함된다(2026-09-20 기준). 생성 입력은 23,323줄이며 19,984개의
고유 소스를 포함한다. 같은 소스가 여러 매뉴얼 행에 대응할 수 있다.
23,323줄 중 7,278줄은 기존 대표 조합이고 16,045줄은 변형이다:
distinct_regs 4,203 / memory_sib 3,435 / memory_rip 3,432 / avx512_mask 2,993 /
imm_max 1,101 / avx512_bcst 881.

`distinct_regs`는 자리마다 다른 레지스터를 쓰는 변형이다. 기본 조합은 모든 자리에 같은 대표값을
써서 `vaddpd zmm0, zmm0, zmm0` 같은 줄이 2,175개 나오는데, 이러면 도구가 오퍼랜드 순서를 바꿔
처리해도 결과가 같아 순서 오류를 구분할 수 없다. 매뉴얼이 지정한 고정 레지스터(AL, CL, DX,
ST(0), CR0 등)는 바꾸지 않는다. 바꾸면 다른 인코딩 행을 시험하게 되기 때문이다
(`add al, 1`은 04 ib 행, `add cl, 1`은 80 /0 ib 행).
DB 행 생성률, 바이트 필드 일치율, 실제 의미 검증 범위를 같은 커버리지 수치로 합치지 않는다.

현재 전체 의미 검증 커버리지는 산출하지 않는다. 13단계는 검사한 필드와 미지원 템플릿을 명시한다.
1단계 PDF 전체 재추출은 이번 도구 검증에서 수행하지 않았다. 기반 CSV와 기존 실험 결과의 수치·관계를 검증했다.

## 정리한 파일

현재 실행 코드가 참조하지 않는 구 `src/`, `data/stage1~6`, `data/instruction_db`, 옛 scripts/experiments 및 설계 문서는
`archive/legacy/`로 옮겼다. 63개 파일의 이동 내역과 해시는 `archive/MOVED_FILES.csv`에 있다.
이전 지침·린터·PoC는 `archive/prototypes/`, 루트 `test.s`의 사례는 `examples/far_pointer.s`에 있다.
회의록과 DEVLOG는 이력 자료로 남긴다. 회의록의 읽는 순서와 현재 문서 링크는 [회의록 안내](MEETING_NOTES/README.md)를 따른다.

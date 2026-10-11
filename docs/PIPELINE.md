# 파이프라인과 파일 안내

기준: 2026-10-12. SDM 093판(Vol.1·Vol.2), GNU Binutils 2.47, LLVM 23.1.3.

## 단계

실행기 `pipeline/run.py`가 아래 네 단계를 차례로 돈다. 단계마다 입력이 없거나 실패하면 멈춘다.

| 단계 | 하는 일 | 구현 | 입력 | 결과 |
|---|---|---|---|---|
| 1 extractor | SDM Vol.2 PDF의 인코딩 표 추출 | `pipeline/m1_extract.py` | `intel_manual.pdf` | `data/db/isa_db.csv`, `coverage_report.md` |
| 2 generator | 표 행마다 소스 케이스 생성(값마다 원문 근거) | `pipeline/m2_generate.py`, 규칙 `case_rules.py` | `isa_db.csv`, `out/sdm_review_093/compare/rows_status.csv` | `out/cases/cases.csv`, `cases.s` |
| 3 check | GNU as·clang으로 따로 조립해 SDM 기대와 비교 | `pipeline/m3_check.py` | `cases.csv` | `out/cases/check_results.csv`, `check_rows.csv` |
| 4 disasm | SDM 일치 바이트를 objdump·llvm-mc로 따로 풀어 SDM 행과 비교 | `pipeline/m4_disasm.py`, 규칙 `disasm_rules.py` | `check_results.csv` | `out/cases/disasm_results.csv` |

```bash
python3 pipeline/run.py --list
python3 pipeline/run.py generator --until disasm      # 생성 + 판정 + 역어셈블 대조
python3 pipeline/run.py --only check --execute        # 판정 + CPU 격리 실행(선택)
```

실행마다 `out/runs/<UTC>.json`에 단계, 코드 해시, 도구 경로·판 번호·해시가 남는다.

## 판정 원칙

- 기준은 SDM 원문이다. 도구끼리는 비교하지 않는다(2026-10-11 사용자 결정).
  - 3단계는 SDM 대 GNU, SDM 대 clang을 본다.
  - 4단계는 SDM 대 objdump, SDM 대 llvm-mc를 본다.
- 2단계 기대 결과:
  - `reach`: 이 표 행의 인코딩이 나와야 함
  - `reject`: 64비트 모드 무효
  - `alias_no_test`: 무효 행인데 유효 행과 문법이 같아 소스로 구별할 수 없음
- 3단계 인코딩 대조(`pipeline/encoding_audit.py`):
  - 접두어, 66H 오퍼랜드 크기·REX.W 짝 행(`operand_size_prefix.py`), 맵, opcode, ModRM 조건, 꼬리 길이를 본다.
  - 레지스터 번호와 실행 의미는 보지 않는다.
- 3단계의 거부·수용 해석:
  - 무효 행을 받아들였으면 바이트가 어느 유효 행인지 찾아 `다른 행으로 수용`으로 적는다.
  - 도구가 기본 설정에서 끈 기능(GNU MPX)은 거부 이유와 켜는 방법을 note에 적는다.
- `--execute`: SDM 일치한 레지스터 전용 케이스를 이 CPU에서 격리 실행한다(`pipeline/cpu_run.py`).
  - 결과는 관측일 뿐 ISA 의미 확정이 아니다.

## 규칙과 근거 파일

| 파일 | 내용 |
|---|---|
| `pipeline/case_rules.py` | 레지스터 목록 순서, 주소 형태, 즉시값, 메모리 폭, 행 지정 철자. 값마다 총론 SYM 번호·쪽 |
| `pipeline/disasm_rules.py` | 의사 니모닉 표(VCMPPD·CMPPD·VPCMP·PCLMULQDQ), FWAIT 짝, 도구 관례 철자 |
| `pipeline/operand_size_prefix.py` | 같은 opcode 칸이 오퍼랜드 크기로만 갈리는 행의 66H 요구, REX.W 짝 행이 있는 행의 REX.W 금지(Vol.1 Table 3-4) |
| `pipeline/sdm_judge.py` | 검사 CLI 판정: 입력 줄의 후보 SDM 행 + 3·4단계와 같은 판정 |
| `pipeline/toolchain.py` | 도구 경로(`~/opt/binutils-2.47`, `~/opt/llvm-23.1.3`). 환경 변수 `BINUTILS_BIN`·`LLVM_BIN` |
| `data/rules/` | 총론 기호(`sdm_symbols.csv`), 원문 충돌 예외, 인코딩 대조 보정, 도달 불가 형식, 추출 보정, PDF 확인 보정 |
| `out/sdm_review_093/` | Sol 원문 추출 8 part, 주 에이전트 독립 판정, 대조 결과(`compare/`), 예외 대조 기록(`conflict_tests/`) |
| `out/sdm_evidence_093/` | 행별 원문 근거와 인코딩 표 셀(각주 보존) |
| `out/manual_index/`, `out/manual_index_vol1/` | Vol.2·Vol.1 쪽 색인(매뉴얼 조회 도구용) |

## 행 상태(2단계 입력) 다시 만들기

SDM 원문 검토 결과가 바뀌면 다음 순서로 행 상태를 다시 만든다.

```bash
python3 scripts/compare_sdm_review.py          # Sol 추출과 독립 판정 대조 -> compare/
python3 scripts/check_source_conflicts.py --execute   # 원문 충돌 예외 대조 -> conflict_tests/results.csv
python3 scripts/build_rows_status.py           # 행 상태 -> compare/rows_status.csv
```

`conflict_tests/`의 `row_cases.csv`, `all_cases.csv`, `all_results.csv`, `defect_cases.csv`는 예전 생성기(2026-10-10) 때 대조한 기록이다.
그 대조 스크립트는 지웠고, 기록은 행 상태의 근거로 남긴다.

## 도구

- 매뉴얼 조회(터미널): `python3 scripts/manual_lookup.py show MOV [--part Description|--text]`
  - 다른 하위 명령: `search`, `page`, `general`, `symbols`, `cases`
- 명령어 검사 CLI: `python3 scripts/asm_linter.py "mov eax, ebx"`([도구 안내](TOOL_GUIDE.md))
  - 줄마다 후보 SDM 행을 찾고 3·4단계와 같은 판정(SDM 대 각 어셈블러, SDM 대 각 역어셈블러)을 낸다(`pipeline/sdm_judge.py`).
  - CLI 판정과 3단계가 같은지: `python3 scripts/check_cli_consistency.py [--sample N]`
- 고정 재심 사례: `python3 scripts/review_cases.py [--skip-cpu]`(CPU 소스 `tests/review_cpu_cases.c`)

## 지운 것

정리 기록은 `docs/DEVLOG.md`에 있다. 지운 파일은 git 기록에서 되살릴 수 있다.
- 2026-10-11: 예전 2~13단계 코드
- 2026-10-12: 예전 단계 결과, 090판 이관 사슬, archive, 과거 검토 문서

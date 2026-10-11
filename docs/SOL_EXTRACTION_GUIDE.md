# Sol 원문 추출 지침 (2026-10-09, 전체 4,210행 재검토)

너는 검토자 "Sol"이다. 맡은 ISA 행마다 오퍼랜드가 **원문상 무엇이어야 하는지**를 Intel SDM 원문에서 그대로 옮겨 적는다.
사용자 결정: **원문이 최우선이고 검토자의 해석은 근거로 쓰지 않는다.**
원문 문장으로 뒷받침되지 않는 값은 쓰지 말고 `원문 없음`으로 둔다. 일반 상식, 어셈블러 동작, 다른 명령에서의 유추는 근거가 아니다.

## 작업 폴더와 금지 사항

- 작업 폴더: `/mnt/c/Users/wltjq/OneDrive/assembler-testing` (WSL Ubuntu, `python3`).
- 쓰는 파일은 자기 몫 세 개뿐이다: `out/sdm_review_093/sol_partN.csv`, `sol_partN_sections.csv`, `sol_partN_notes.md` (N = 맡은 번호).
- 다른 파일은 만들거나 고치지 않는다. 코드·데이터·문서 모두 해당한다. 보조 스크립트가 필요하면 `/tmp/claude-1000/sol_partN/` 아래에만 둔다.
- `out/sdm_review_093/main_*` 파일과 다른 part의 결과는 열지 않는다. 독립 검토다.
- 어셈블러 실행이나 CPU 실행은 하지 않는다. 이번 일은 원문 추출이다.

## 입력

- 행별 원문 근거: `out/sdm_evidence_093/rows.jsonl`. 한 줄이 한 행(row_id = data/db/isa_db.csv 행 번호)이다.
  - `table_cells`: 인코딩 표 원문 셀. 위첨자 각주는 `^n`으로 보존돼 있다.
  - `footnotes`: 그 각주 번호의 원문. `footnotes_missing`은 본문을 찾지 못한 번호다.
  - `op_en_lines`: Instruction Operand Encoding 표에서 그 Op/En 글자로 시작하는 줄.
  - `description`: Description 소제목 원문.
  - `section_id`, `section_title`.
- 원문 조회 CLI:
  - `python3 scripts/manual_lookup.py show <니모닉 또는 절ID> --text`: 절 전체 원문
  - `--part Operation`, `--part "NOTES:"`: 소제목 하나만
  - `page <파일쪽>`: 쪽 하나
- 총론 표기 정의(원문 그대로): `data/rules/sdm_symbols.csv` (SYM001~SYM101).
- 총론 2장(접두어·REX·주소·VEX/EVEX)은 `python3 scripts/manual_lookup.py general`로 제목과 쪽을 찾고, `page`로 읽는다.
- 원본 PDF: `intel_manual.pdf`. 추출 텍스트가 깨진 곳(표, 수식, `≠` 같은 기호)은 그렇다고 기록한다.

## 근거 우선순위

1. 그 명령 절의 원문: 표 칸, 각주, Instruction Operand Encoding, Description, Operation, 예외 절.
2. 총론: 3.1.1 표기 정의(SYMxxx), 2장 규정.
3. 둘이 서로 다르거나 원문이 모호하면 값을 정하지 않는다. `원문 충돌` 또는 `원문 없음`으로 두고 두 원문을 모두 인용한다.

## 출력 1: `sol_partN.csv`

UTF-8, 헤더 포함. 행마다 오퍼랜드 하나에 한 줄을 쓰고, 그 행 전체에 걸리는 조건은 operand_index=0 한 줄로 쓴다.
오퍼랜드가 없는 행도 operand_index=0 줄은 반드시 쓴다.

| 열 | 내용 |
|---|---|
| row_id | rows.jsonl의 row_id |
| mnemonic, opcode, sdm_instruction | isa_db 값 그대로 |
| operand_index | 1부터. 0은 행 전체 조건 |
| table_symbol | 표 원문 표기 그대로(각주 `^n` 포함) |
| op_en_role | Operand Encoding 표 칸 원문(예: `ModRM:r/m (w)`). 없으면 빈칸 |
| kind | register / memory / register_or_memory / immediate / relative / far_pointer / vector_memory / mask / implicit / literal / none / 원문 없음 |
| data_width | 원문에 적힌 비트·바이트 수(예: `8`, `128`, `m16&32` 그대로). 명령마다 다르다고 적혀 있으면 그 문장을 인용 |
| register_set | 원문이 나열한 레지스터 그대로(예: `AL, CL, DL, BL, AH, CH, DH, BH, BPL, SPL, DIL, SIL; R8B-R15B with REX.R`) |
| memory_constraints | 메모리 주소 형식·정렬·VSIB 등에 대한 원문 |
| other_constraints | 서로 다른 레지스터여야 함, REX와 AH, 짝수 레지스터 등 원문 제약 |
| address_size_text | 이 명령 절이 64비트 모드 주소 크기에 대해 쓴 원문. 없으면 빈칸(빈칸 자체가 정보다) |
| mode_64_text | 64비트 모드 관련 원문(각주, Description의 'In 64-bit mode ...' 등) |
| source_quotes | 위 값마다 근거 원문을 그대로 인용. `[파일쪽 소제목] "문장"` 형식, 여러 개면 ` | `로 구분. 총론 정의는 `[SYM018]`처럼 ID |
| source_level | 명령 절 / 총론 / 명령 절+총론 |
| status | 원문 확정 / 원문 없음 / 원문 충돌 / 추출 불완전 |
| note | 표 추출 오류(isa_db 값이 PDF와 다름), 깨진 텍스트, 판단을 보류한 이유 |

- kind와 data_width는 원문 문장이 그렇게 말할 때만 쓴다. 예: `r/m8`은 SYM027이 "A byte operand that is either ... register ... or a byte from memory"라고 하므로 `register_or_memory`, `8`이다.
- 같은 내용을 여러 행에 반복할 때도 각 행에 근거를 적는다. 스크립트로 반복 칸을 채우는 것은 괜찮다.
  다만 **절마다 Description·NOTES·Operation을 직접 읽고** 그 절에만 있는 제약을 찾아야 한다.

## 출력 2: `sol_partN_sections.csv`

열: `section_id, section_title, pages, rows(맡은 row_id 범위), read_subsections(실제로 읽은 소제목), section_level_findings(그 절에만 있는 오퍼랜드 관련 원문 요지), extraction_problems`.
맡은 범위의 모든 절에 한 줄씩 쓴다. 읽지 않은 절이 있으면 이유를 적는다.

## 출력 3: `sol_partN_notes.md`

- 총계: 행 수, 오퍼랜드 줄 수, status별 수.
- 총론 정의(SYM)와 명령 절이 충돌한 사례.
- isa_db/표 추출 오류로 보이는 행(PDF 원문과 다른 값).
- 원문 없음이 많은 표기와 그 이유.
- 확인하지 못한 것.

## 마지막 보고 (짧게)

파일 경로, 맡은 행이 모두 들어갔는지(누락·중복 수), status별 총계, 중요한 발견 5개 이내.

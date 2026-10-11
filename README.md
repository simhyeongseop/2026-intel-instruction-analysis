# Intel Instruction Analysis

작업 재개: [현재 인계](docs/HANDOFF.md).

Intel SDM(093판)의 인코딩 표 행마다 x86-64 Intel 문법 명령어를 만들고, 어셈블러와 역어셈블러가 그 행을 SDM대로 처리하는지 대조하는 프로젝트다.
기준은 언제나 SDM 원문이고, 도구끼리는 비교하지 않는다. 다른 퍼징 실험에서 명령어 입력을 검사할 수 있는 CLI도 함께 제공한다.

## 최신 상태 (2026-10-12)

- 환경: WSL2 Ubuntu, GNU Binutils 2.47, LLVM 23.1.3(`pipeline/toolchain.py`), Intel Core Ultra 5 226V
- 생성: 4,219행 → 19,425케이스(값마다 원문 근거 기록)
- 판정: SDM 일치 GNU as 19,313, clang 19,118
- 역어셈블 대조: SDM 일치 바이트 19,223개 중 SDM 일치 objdump 19,152, LLVM 19,150
- 상세와 차이 목록: [보고서](out/cases/REPORT.md)

이 수치는 인코딩 필드 대조 결과이며 전체 ISA 의미 검증 완료율이 아니다.

## 파이프라인

PDF 추출(1) → SDM 행별 케이스 생성(2) → 도구별 판정(3: SDM 대 GNU as / SDM 대 clang) → 역어셈블러별 대조(4: SDM 대 objdump / llvm-mc)

```bash
python3 pipeline/run.py --list
python3 pipeline/run.py generator --until disasm
python3 pipeline/run.py --only check --execute   # SDM 일치한 레지스터 전용 케이스를 이 CPU에서 격리 실행(선택)
```

입력·출력·규칙 파일은 [파이프라인 안내](docs/PIPELINE.md)에 있다. 실행별 도구 판·해시·성공 여부는 `out/runs/`에 남는다.

## 도구

```bash
python3 scripts/asm_linter.py "mov eax, ebx"                # 명령어 검사 CLI
python3 scripts/asm_linter.py --file examples/fuzz_inputs.s
python3 scripts/manual_lookup.py show MOV --part Description # SDM 원문 조회
python3 scripts/manual_lookup.py cases MOV --opcode "8A /r"  # 저장된 케이스와 판정 조회
```

검사 CLI의 옵션과 JSON 형식은 [도구 안내](docs/TOOL_GUIDE.md)에 있다.
- 상태: `accepted`, `rejected`, `needs_review`, `incomplete`, `tool_error`
- 종료 코드: 0 = 제한 검사 통과, 1 = 거부 또는 검토 항목, 2 = 미완료·설정·도구 오류
- `accepted`와 종료 코드 0도 매뉴얼 전체 적합성이나 CPU 실행 성공을 보증하지 않는다.

Windows에서는 명령 앞에 `wsl -d Ubuntu --`를 붙인다.

## 폴더 구성

- `pipeline/`: 1~4단계, 규칙(`case_rules`, `disasm_rules`, `operand_size_prefix`), 도구 경로(`toolchain`), 검사 API, SDM 검토 모듈
- `scripts/`: 검사 CLI, 매뉴얼 조회, 재심 사례, SDM 원문 검토·행 상태 생성
- `data/db/isa_db.csv`: 1단계 추출 결과. `data/rules/`: 원문 기호·예외·보정 규칙. `data/cases.csv`: 이름 붙인 추가 사례
- `out/cases/`: 생성·판정·역어셈블 결과와 보고서. `out/sdm_review_093/`, `out/sdm_evidence_093/`: SDM 원문 검토와 근거
- `tests/`: 회귀 테스트. `examples/`: 입력 예제. `docs/`: 인계·안내·판정 기준·DEVLOG·회의록

원본 PDF(`intel_manual.pdf`, `intel_manual_vol1.pdf`)는 용량과 배포 문제로 Git에 넣지 않는다.

## 필요한 환경

- Python 3.10 이상
- GNU Binutils(as·ld·objdump·objcopy·readelf), Clang과 llvm-mc. 경로는 `pipeline/toolchain.py`
- PDF 추출에 `pdfplumber`, 매뉴얼 색인 생성에 `pypdfium2`

```bash
python3 -m unittest discover -s tests -p 'test_*.py' -v
```

현재 인계는 [HANDOFF](docs/HANDOFF.md), 개발 이력은 [DEVLOG](docs/DEVLOG.md)에 있다.

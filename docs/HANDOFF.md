# 현재 작업 인계

갱신: 2026-10-12(최종 정리 후). 시작할 때 이 문서를 읽고, 작업 대상의 코드와 근거만 추가로 읽는다.

## 목적

Intel SDM 표 행에서 만든 x86-64 입력을 어셈블러·역어셈블러가 SDM대로 처리하는지 대조한다.
다른 퍼징 실험에서 명령어 입력을 검사할 수 있는 도구도 제공한다. 전체 ISA 의미 검증을 완료한 상태가 아니다.

## 현재 기준

- SDM 093판: `intel_manual.pdf`(Vol.2 325383-093US), `intel_manual_vol1.pdf`(Vol.1 253665-093US). 경로는 `pipeline/sdm_paths.py`.
- 도구: GNU Binutils 2.47, LLVM 23.1.3. `~/opt`에 sudo 없이 설치했고, 경로는 `pipeline/toolchain.py`에 있다.
  - binutils는 소스 빌드, LLVM은 공식 바이너리다. 설치 절차는 DEVLOG 2026-10-12.
- 파이프라인: 추출 → 생성 → 도구별 판정 → 역어셈블러별 대조([안내](PIPELINE.md))
- 결과: `out/cases/REPORT.md`(첫 절이 최신 판 기준)
- 검사 CLI(`scripts/asm_linter.py`): 줄마다 후보 SDM 행을 찾고 3·4단계와 같은 판정을 낸다(`pipeline/sdm_judge.py`, 10월 12일).
  - 전체 19,425케이스 대조: 생성 행이 모두 후보에 있고, 3단계 SDM 일치 34,108건이 CLI에서도 같은 행으로 SDM 일치(`scripts/check_cli_consistency.py`).

## 수치(2026-10-12, 2.47 / 23.1.3)

- 4,219행 → 19,425케이스. 모든 행이 사양 신뢰 상태다(원문 확정·완화 A~D·예외 등록).
- 3단계 SDM 일치: GNU 19,313, clang 19,118. 행 전체 일치: GNU 4,195, clang 4,064.
- 4단계(SDM 일치 바이트 19,223개) 일치 계열: objdump 19,152, LLVM 19,150.
- CPU 관측: exit0 1,954, SIGSEGV 88, SIGFPE 8, SIGILL 11, SIGTRAP 2.

## 열린 항목

- 버그 후보 4개. LLVM 23.1.3에서도 재현된다. 새 보고 여부는 사용자 결정이다.
  - clang `call/jmp word·dword ptr [rax]` → 먼 호출 m16:32(`ff 18`): 이미 보고됨(#88516, #95232, 열림)
  - clang CLRSSBSY·RSTORSSP `qword ptr` 거부: 이미 보고됨(#95232, 열림)
  - llvm-mc가 먼 호출 `ff 18`을 Intel 문법 `call [rax]`로 출력함(AT&T는 `lcalll`): 보고를 찾지 못함
  - clang Intel 문법 AVX512PF 16행 거부(AT&T는 받음): 보고를 찾지 못함
- GNU는 2.44부터 기본 설정에서 MPX를 받지 않는다(binutils 57c526470).
  - 사용자 결정: 기본 설정 그대로 기록한다. 쓰려면 `-march=generic64+mpx`
- MOV Sreg, r/m64 메모리 폭: 원문 근거가 없어 미확인이다.
- 결정 6(Sol 단독 값 1,410줄)을 생성 값과 대조하는 일이 남았다.
- GNU IRET `iret` → `cf`(IRETD): 원문이 허용하는 동의어 처리로 기록했다.

## 사용자 결정(유지)

- 원문 최우선, 에이전트 해석 배제. 근거를 찾을 수 있으면 사용자가 PDF로 확인한 내용을 적용한다.
- 원문 충돌은 표 기준으로 생성하고 예외로 등록해 대조한다(`data/rules/source_conflict_cases.csv`).
- 도구끼리는 비교하지 않고, SDM 대 각 도구로 판정한다.
- 매뉴얼 조회와 검사 도구는 터미널로 한다.
- 커밋은 브랜치 `sdm-review-093`에, 사용자 승인 후에 한다. PDF와 `out/manual_index*`는 커밋하지 않는다.

## 필요한 파일만 읽기

- 생성: `pipeline/m2_generate.py`, `pipeline/case_rules.py`, `tests/test_m2_generate.py`
- 판정: `pipeline/m3_check.py`, `pipeline/encoding_audit.py`, `pipeline/operand_size_prefix.py`
- 검사 CLI: `scripts/asm_linter.py`, `pipeline/instruction_check.py`, `pipeline/sdm_judge.py`, `tests/test_sdm_judge.py`
- 역어셈블: `pipeline/m4_disasm.py`, `pipeline/disasm_rules.py`
- 원문 검토: `out/sdm_review_093/`, `pipeline/sdm_review_compare.py`, `pipeline/sdm_relaxation.py`, `scripts/build_rows_status.py`
- 판정 기준 문서: [판정 기준](RESULT_VALIDITY_AND_BUG_CRITERIA.md), [재심 보고서](CASE_REVIEW_2026-09-14.md)

과거 경과는 `docs/DEVLOG.md`에 있다. 지운 코드·문서는 git 기록(`b24bb9c` 이전)에서 찾는다.

```bash
python3 -m unittest discover -s tests -p 'test_*.py' -q
python3 pipeline/run.py generator --until disasm
```

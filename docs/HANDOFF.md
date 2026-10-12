# 현재 작업 인계

갱신: 2026-10-12(AVX512PF 독립 재검증 후). 시작할 때 이 문서를 읽고, 작업 대상의 코드와 근거만 추가로 읽는다.

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
- reg 칸 r64 변형 추가(10월 12일): 기존 케이스 판정 변화 0. 4단계 새 판정 `SDM 일치(reg 칸 레지스터 폭 표기)`.
- 결정 6 완료(10월 12일): Sol만 값을 붙였던 1,410줄이 생성 값과 모두 맞는다(일치 786, Sol 폭 없음·완화 근거 620, REP LODS 철자 선택 4). `scripts/check_sol_only_values.py`

## 수치(2026-10-12, 2.47 / 23.1.3)

- 4,219행 → 19,462케이스(reg 칸 r64 변형 37개 포함). 모든 행이 사양 신뢰 상태다(원문 확정·완화 A~D·예외 등록).
- 3단계 SDM 일치: GNU 19,336, clang 19,140. 행 전체 일치: GNU 4,187, clang 4,058.
- 4단계(SDM 일치 바이트 19,248개) 일치 계열: objdump 19,177, LLVM 19,181(먼 호출 6 철회 반영).
- CPU 관측: exit0 1,973, SIGSEGV 88, SIGFPE 8, SIGILL 11, SIGTRAP 2.

## 열린 항목

- 버그 후보 3개. LLVM 23.1.3에서도 재현된다. 새 보고 여부는 사용자 결정이다.
  - clang `call/jmp word·dword ptr [rax]` → 먼 호출 m16:32(`ff 18`): 이미 보고됨(#88516, #95232, 열림)
  - clang CLRSSBSY·RSTORSSP `qword ptr` 거부: 이미 보고됨(#95232, 열림)
  - clang Intel 문법 AVX512PF 16행 거부(AT&T는 받음): 보고를 찾지 못함. LLVM Intel 정의 `{${mask}}, $src`가 메모리 뒤 마스크의 파싱 순서와 불일치하고, 맨 앞 `{k1}`도 거부됨
    - 이슈 초안: `docs/issues/llvm_avx512pf_intel_mask_draft.md`(제출 전). 관련 언급: PR #122051 본문(별도 이슈는 검색에서 못 찾음)
    - 독립 재검증: `docs/issues/llvm_avx512pf_intel_mask_verification.md`, 별도 snapshot `out/avx512pf_review_20261012/`. LLVM 23.1.3에서 올바른 VSIB 폭의 16개 Intel 거부·AT&T 성공·Intel 출력 재조립 거부를 직접 확인. DPD 4개는 YMM, 나머지는 ZMM. 제안 패치는 빌드 미검증이며 중복 이슈 부재를 단정하지 않는다.
  - 철회(10월 12일): llvm-mc `ff 18` → Intel `call [rax]`. SDM에 크기 표기 문법이 없어 원문 근거가 없다.
- GNU는 2.44부터 기본 설정에서 MPX를 받지 않는다(binutils 57c526470).
  - 사용자 결정: 기본 설정 그대로 기록한다. 쓰려면 `-march=generic64+mpx`
- MOV Sreg, r/m64 메모리(10월 12일 정리): 원문 기호는 m64(표·SYM038·Description), 도구와 CPU 관측(쪽 경계 실험)은 2바이트 읽기. 버그 후보 아님, 3단계 거부에 note.
- VMOVW·VPBROADCASTB/W r64: 명령 절이 폭을 적지 않아 SYM039만 근거다. GNU는 모두 거부, clang은 VMOVW만 받는다. 버그 후보로 올리지 않았다.
- GNU IRET `iret` → `cf`(IRETD): 원문이 허용하는 동의어 처리로 기록했다.

## 사용자 결정(유지)

- 원문 최우선, 에이전트 해석 배제. 근거를 찾을 수 있으면 사용자가 PDF로 확인한 내용을 적용한다.
- 원문 충돌은 표 기준으로 생성하고 예외로 등록해 대조한다(`data/rules/source_conflict_cases.csv`).
- 도구끼리는 비교하지 않고, SDM 대 각 도구로 판정한다.
- 매뉴얼 조회와 검사 도구는 터미널로 한다.
- reg 칸(SYM039 "r16, r32, or r64")의 r16 케이스는 만들지 않는다(2026-10-12). 명령 절에 r16이 없고 16비트 크기를 나타낼 인코딩이 없다.
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

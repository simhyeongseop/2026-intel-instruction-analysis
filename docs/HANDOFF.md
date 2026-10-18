# 현재 작업 인계

갱신: 2026-10-19(사용자 요청으로 현재 작업 커밋·push 준비, 회귀 156개 재확인). 시작할 때 이 문서를 읽고, 작업 대상의 코드와 근거만 추가로 읽는다.

## 목적

Intel SDM 표 행에서 만든 x86-64 입력을 어셈블러·역어셈블러가 SDM대로 처리하는지 대조한다.
다른 퍼징 실험에서 명령어 입력을 검사할 수 있는 도구도 제공한다. 전체 ISA 의미 검증을 완료한 상태가 아니다.

## 현재 기준

- SDM 093판: `intel_manual.pdf`(Vol.2 325383-093US), `intel_manual_vol1.pdf`(Vol.1 253665-093US). 경로는 `pipeline/sdm_paths.py`.
- 도구: GNU Binutils 2.47, LLVM 23.1.3. `~/opt`에 sudo 없이 설치했고, 경로는 `pipeline/toolchain.py`에 있다.
  - binutils는 소스 빌드, LLVM은 공식 바이너리다. 설치 절차는 DEVLOG 2026-10-12.
- 파이프라인: 추출 → 생성 → 도구별 판정 → 역어셈블러별 대조([안내](PIPELINE.md))
- 전체 조립의 기준: `out/cases/`(10월 13일 전체 재실행, ER/SAE 포함, 실행 기록 `out/runs/20261013T025438835844Z.json`). 10월 12일 결과는 git `3813bf2`에 있다.
- 검사 CLI(`scripts/asm_linter.py`): 줄마다 후보 SDM 행을 찾고 3·4단계와 같은 판정을 낸다(`pipeline/sdm_judge.py`, 10월 12일).
  - 보존된 19,462케이스: 생성 행이 모두 후보에 있고, 3단계 SDM 일치 34,144건이 CLI에서도 같은 행으로 SDM 일치. 새 ER/SAE 1,598개도 모두 후보에 있고, 3,156건 같은 행 SDM 일치(`scripts/check_cli_consistency.py`).
- reg 칸 r64 변형 추가(10월 12일): 기존 케이스 판정 변화 0. 4단계 새 판정 `SDM 일치(reg 칸 레지스터 폭 표기)`.
- 결정 6 완료(10월 12일): Sol만 값을 붙였던 1,410줄이 생성 값과 모두 맞는다(일치 786, Sol 폭 없음·완화 근거 620, REP LODS 철자 선택 4). `scripts/check_sol_only_values.py`

## ER/SAE 최신 snapshot(2026-10-13)

- `out/er_sae_support_20261013/`: `generated/`는 4,219행·21,060케이스 전체 생성, `added/`는 새 288행·1,598개만 실제 조립·역어셈블한 결과다. 기본 out/cases의 과거 CPU 관측을 새 결과로 설명하지 않는다.
- 구현: `pipeline/fp_controls.py`의 조건을 생성기·CLI·인코딩 대조가 공유한다. ER 네 모드, SAE, 장식 중복·위치·메모리 조건, EVEX.b/RC, 역어셈블 장식 누락·변경을 검사한다. LLVM의 RC-before-GPR 철자도 처리한다.
- 추가 케이스: GNU 1,598 SDM 일치, clang 1,558 일치·40 거부. 두 역어셈블러는 1,598 모두 일치. clang 거부 40개는 정수→실수 변환에서 RC를 GPR 뒤에 적은 입력이다. GPR 앞에 적은 LLVM 출력 40개는 두 어셈블러·CLI 모두 SDM 일치(`layout_observations.json`). 이를 명령 미지원이나 새 버그로 분류하지 않았다.
- 최종 코드 검증: `final_validation_v2/manifest.json`, 회귀 153개 통과(건너뜀 없음). 기존 입력 19,462개 변경 0. 저장된 기존 인코딩 일치 38,282건·역어셈블 오퍼랜드 일치 38,115건 유지. 이는 저장된 관측 재판정이며 기존 전체를 다시 조립한 것은 아니다.
- 자세한 범위·원문 근거·실행 기록: `docs/ER_SAE_SUPPORT.md`. CPU 실행·이슈 제출·커밋은 하지 않았다.

## 발표 전 재점검(2026-10-13)

- `docs/PRESENTATION_REVIEW_2026-10-13.md`: SDM 일치가 아닌 GNU 78·clang 274케이스 재분류. 근거 `out/presentation_review_20261013/`.
- 우리 쪽 문제 후보 3가지: CALL·JMP `dword ptr` 기대값(m16:16과 같은 문법이므로 alias), VMOVW·VPBROADCASTB/W r64 변형(XED는 GPR32), `data16` 철자(clang용 아님). 코드 수정은 사용자 결정 대기.
- 사용자 결정(10월 13일): 세 가지 모두 코드에서 고친다. `case_rules.FAR_POINTER_MEMORY_ALIASES`+`m2_generate.mark_far_pointer_aliases`, `REG_R64`에서 세 니모닉 제외, `unreachable_forms.csv`에 PUSH imm16(2314)·XBEGIN rel16(4118) 등록.
- AVX512PF 의견: `docs/AVX512PF_OPINION_2026-10-13.md`(매뉴얼 오류 근거 없음, 가장 강한 근거는 LLVM 자기 출력 재조립 실패).
- 발표 원고: `docs/presentation/SLIDES.md`(10장, 대본 포함, 생성 AI 입력용), 터미널 캡처 `docs/presentation/captures/`(`render.py`로 PNG), 원문·Godbolt 이미지 `docs/presentation/images/`.

## 수치(2026-10-13 전체 재실행, 2.47 / 23.1.3)

- 4,219행(니모닉 1,617) → 21,046케이스(ER/SAE 1,598 포함, r64 변형 14개 제거). 기대: reach 20,892, reject 100, alias_no_test 54.
- 3단계 SDM 일치: GNU 20,934, clang 20,696. 10월 12일 대비 판정 변화는 의도한 15케이스뿐(CALL·JMP dword 12 → 시험 불가, PUSH·XBEGIN 3 → 도달 불가(등록)), 나머지는 바이트까지 같음.
- 4단계(대상 20,844) 일치 계열: objdump 20,763, LLVM 20,767.
- CPU 관측: exit0 1,973, SIGSEGV 88, SIGFPE 8, SIGILL 11, SIGTRAP 2.
- 회귀 156개 통과, CLI 일치 대조: 21,046 후보, 37,298건 같은 행 SDM 일치.

## 열린 항목

- 버그 후보 3종(clang 28케이스: CLRSSBSY·RSTORSSP 6, call·jmp `word ptr` 6, AVX512PF 16). `dword ptr` 먼 호출은 m16:16과 같은 문법이라 10월 13일 시험 불가로 바꿨다. 새 보고 여부는 사용자 결정이다.
  - clang `call/jmp word·dword ptr [rax]` → 먼 호출 m16:32(`ff 18`): 이미 보고됨(#88516, #95232, 열림)
  - clang CLRSSBSY·RSTORSSP `qword ptr` 거부: 이미 보고됨(#95232, 열림)
  - clang Intel 문법 AVX512PF 16행 거부(AT&T는 받음): 보고를 찾지 못함. LLVM Intel 정의 `{${mask}}, $src`가 메모리 뒤 마스크의 파싱 순서와 불일치하고, 맨 앞 `{k1}`도 거부됨
    - 이슈 초안: `docs/issues/llvm_avx512pf_intel_mask_draft.md`(제출 전). 관련 언급: PR #122051 본문(별도 이슈는 검색에서 못 찾음)
    - 명시적 문법 근거: Vol.1 §15.6.1.2, 15-10쪽(PDF 394)은 predicate opmask를 Intel 문법의 첫 피연산자 뒤에 중괄호로 표시한다고 명시한다. 초안에 개별 명령 표와 함께 추가했다.
    - 독립 재검증: `docs/issues/llvm_avx512pf_intel_mask_verification.md`, 별도 snapshot `out/avx512pf_review_20261012/`. LLVM 23.1.3에서 올바른 VSIB 폭의 16개 Intel 거부·AT&T 성공·Intel 출력 재조립 거부를 직접 확인. DPD 4개는 YMM, 나머지는 ZMM. 제안 패치는 빌드 미검증이며 중복 이슈 부재를 단정하지 않는다.
    - Godbolt 대표 1개 재현(Clang 23.1.0): Intel 실패 https://godbolt.org/z/of1hfozfa / AT&T 성공 https://godbolt.org/z/Goo8f9jvd . 로컬 23.1.3 전체 검사와 구분한다. 원문 PDF 2375쪽(8-12) 이미지와 화면은 같은 별도 snapshot에 저장했다.
  - 철회(10월 12일): llvm-mc `ff 18` → Intel `call [rax]`. SDM에 크기 표기 문법이 없어 원문 근거가 없다.
- `{er}`·`{sae}` 공백은 10월 13일 수정했다(위 snapshot). 이전 후보 0개 관측은 `out/operand_review_20261013/`에 보존한다. 원문 조건과 실제 도구 수용·바이트를 구분한다.
- AVX512PF 10월 13일 별도 snapshot 재실행: 16개 모두 LLVM Intel 거부·AT&T 성공·자체 Intel 출력 재조립 거부. 시험한 버전의 Intel 문법 결함 판단 유지. 패치 빌드·CPU 실행·이슈 제출은 하지 않았다.
- GNU는 2.44부터 기본 설정에서 MPX를 받지 않는다(binutils 57c526470).
  - 사용자 결정: 기본 설정 그대로 기록한다. 쓰려면 `-march=generic64+mpx`
- MOV Sreg, r/m64 메모리(10월 12일 정리): 원문 기호는 m64(표·SYM038·Description), 도구와 CPU 관측(쪽 경계 실험)은 2바이트 읽기. 버그 후보 아님, 3단계 거부에 note.
- VMOVW·VPBROADCASTB/W r64: 10월 13일 생성에서 뺐다(SYM039만 근거, Intel XED는 GPR32).
- GNU IRET `iret` → `cf`(IRETD): 원문이 허용하는 동의어 처리로 기록했다.

## 사용자 결정(유지)

- 원문 최우선, 에이전트 해석 배제. 근거를 찾을 수 있으면 사용자가 PDF로 확인한 내용을 적용한다.
- 원문 충돌은 표 기준으로 생성하고 예외로 등록해 대조한다(`data/rules/source_conflict_cases.csv`).
- 도구끼리는 비교하지 않고, SDM 대 각 도구로 판정한다.
- 매뉴얼 조회와 검사 도구는 터미널로 한다.
- reg 칸(SYM039 "r16, r32, or r64")의 r16 케이스는 만들지 않는다(2026-10-12). 명령 절에 r16이 없고 16비트 크기를 나타낼 인코딩이 없다.
- 커밋은 브랜치 `sdm-review-093`에, 사용자 승인 후에 한다. PDF와 `out/manual_index*`는 커밋하지 않는다.

## 필요한 파일만 읽기

- 10월 19일 저장 작업: 사용자 요청으로 `sdm-review-093`의 코드·문서·실험 snapshot·발표 자료를 함께 커밋하고 origin에 push한다. PDF와 `out/manual_index*`는 제외한다. WSL 회귀 156개 통과; 조립·CPU 실험을 새로 실행한 것은 아니다. 다음 작업은 위 열린 항목의 사용자 결정에 따른다.

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

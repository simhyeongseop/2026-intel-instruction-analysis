# 현재 작업 인계

갱신: 2026-10-19(PR #1 main 머지 완료, 인터뷰에 따라 README 설명·그림 확장). 시작할 때 이 문서를 읽고, 작업 대상의 코드와 근거만 추가로 읽는다.

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
- 4단계(대상 20,844) 일치 계열: objdump 20,767(11월 3일 `-M intel64` 재실행, MOVSXD r16 4건 오퍼랜드 다름 → SDM 일치), LLVM 20,767.
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

- 10월 19일 저장 작업: `852a3ed`로 코드·문서·실험 snapshot·발표 자료를 커밋하고 push했다. [PR #1](https://github.com/simhyeongseop/2026-intel-instruction-analysis/pull/1)은 `bb9025a`로 main에 머지됐다. PDF와 `out/manual_index*`는 제외했다. WSL 회귀 156개 통과; 조립·CPU 실험을 새로 실행한 것은 아니다.
- README 확장: 연구실 교수·동료 연구자를 독자로, 파이프라인 동작과 결과 해석을 중심으로 다시 썼다. 전체 흐름·CLI 흐름 Mermaid 그림, 단계별 설명, 저장된 ADC 사례, 데이터 역할과 실행 전 검사 범위를 추가했다. 현재 CLI는 명세 DB와 판정 규칙을 공유하고 조립·역어셈블 도구를 실제 호출한다. 이 설명을 결과 CSV 조회만으로 CPU 의미를 예측하는 기능으로 확대하지 않는다. 사용자가 이번 문서 변경의 커밋·push·main 머지를 승인했다. README 로컬 링크 25개와 diff 공백 검사를 확인했다. 후속 연구 작업은 위 열린 항목의 사용자 결정에 따른다.

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

## 2026-10-20 AVX512PF 이슈 등록 위임
- 사용자가 등록을 승인했다. 초안 docs/issues/llvm_avx512pf_intel_mask_draft.md에 PR #122051 수정 제안 댓글·Godbolt·최신 main 미시험 범위를 반영했다.
- GitHub CLI 인증 만료, 앱 브라우저 미로그인으로 아직 등록하지 못했다. 로그인 완료 후 중복 확인 및 등록을 이어간다.


## 2026-10-20 AVX512PF 이슈 등록 완료
- 사용자 위임으로 simhyeongseop 계정에서 LLVM #233852 등록: https://github.com/llvm/llvm-project/issues/233852 (Open 화면 확인).
- 본문: 23.1.3 Intel 거부·AT&T 성공·자체 Intel 출력 재조립 실패, 16개 범위, SDM·PR #122051 댓글·Godbolt 근거. 최신 main 미시험 및 패치 빌드 미검증 명시.
- 완료 화면: docs/issues/llvm-avx512pf-233852.png. 위 로그인 대기 상태는 해소됐다.


## 2026-10-20 AVX512PF 수정 패치 검증 완료
- 사용자 요청으로 최신 LLVM main 74a120bff99f527087d231e14844b384a7dc1131 소스의 Intel 마스크 순서만 수정했다. patches/llvm-avx512pf-intel-mask/에 적용 가능한 패치·정상/오류 테스트·설명·PR 본문 준비.
- WSL ~/opt/build/llvm-avx512pf-fix-20261020/에서 X86 LLVM 도구 직접 빌드(Release, assertions ON). Intel 32개 기존 기대 바이트 일치·출력 재조립 성공, AT&T 32개 유지, 잘못된 입력 6개 거부. lit 8/8 통과, 건너뜀 없음.
- 별도 snapshot out/avx512pf_fix_20261020/manifest.json 및 validation_final.json, lit_results.json. 이전 문자열 시도 실패는 별도 파일로 보존. CPU 실행·전체 LLVM 테스트·PR 제출·커밋 없음.
- LLVM #233852는 Andarwinux가 backend:X86 / rejects-valid / Bug로 분류. 봇 댓글6292995073은 X86 구독자 자동 알림이고 추가 요청 없음.

## 2026-10-20 LLVM PR 제출 완료
- 사용자 승인으로 https://github.com/llvm/llvm-project/pull/233869 생성(Open). 대상 llvm/llvm-project:main, 사용자 fork simhyeongseop/llvm-project의 codex/fix-avx512pf-intel-mask 브랜치.
- 커밋 b836e813e18e475bb9472762b994a97675654103: 검증한 소스1개·테스트2개, 총3파일 164추가/1삭제. Fixes #233852와 Assisted-by: Codex를 커밋·PR에 표기했다.
- PR 생성 화면에서 내용·이슈 연결·병합 충돌 없음 확인. 자동 검사는 제출 직후 대기 상태이며 로컬 lit8/8과 구분한다. PR을 이 작업 첨부에 연결했고 docs/issues/llvm-avx512pf-pr-233869.png에 화면 보존.

## 2026-10-21 PR 중간 점검 및 로컬 후속 수정 대기
- docs/issues/llvm_pr_233869_status_20261021.md에 현재 브랜치·리뷰·CI·봇 요청 정리. out-of-date 안내는 main 후속 변경이며 충돌 없음. Update branch 미실행.
- CI Linux/Windows는 기존 MC/Disassembler/X86/apx/evex-format.txt의 옛 Intel 마스크 위치 기대값 한 곳 때문에 실패했다. 최초 패치의 기존 테스트 갱신 누락이다.
- 로컬 후속 수정: 그 기대값 갱신과 MC/X86/apx/evex-format-intel.s의 비활성화된 같은 명령 예제 복구. 별도 out/avx512pf_ci_followup_20261021/에 diff·검증 기록. 관련 lit10/10 통과, 아직 커밋·push하지 않았다.
- 신규 기여 봇6293732114는 정책 읽기와 AI표시 확인 답글을 요구한다. AI표시는 이미 있으나 사용자가 정책을 읽고 변경을 직접 검토했다고 확인하지 않아 답글을 대신 게시하지 않았다. 검토 가능한 후속 diff를 준비한 상태.

## 2026-10-21 PR 후속 수정 업로드 완료
- 사용자 지시에 따라 로컬 검증한 APX 조립/역어셈블 테스트 수정 두 파일을 커밋95243a87ae24d35a27a4cf2c46824bbd999bb645으로 기존 PR #233869에 push했다. 현재2커밋·5파일. PR 본문도 테스트10/10 및 기존 APX 테스트 수정 내용을 반영했다.
- 새 CI는 3 workflows awaiting approval 표시로 관리자 실행 승인 대기. 성공이라고 설명하지 않는다. 정책 읽기 확인 답글은 게시하지 않았다. 화면 docs/issues/llvm-avx512pf-pr-233869-updated-20261021.png.

## 2026-10-22 LLVM PR 검토 의견 대응
- 사용자 승인으로 phoebewang의 리뷰 세 항목에 대응. 커밋 8befa263cfba37949adca405471af0b1f327d56c를 기존 PR #233869에 push했다.
- avx512pf-64-intel.s: llvm-objdump RUN 제거, 출력 재조립 시험 목적 주석 추가. 핵심 TD 정의는 유지.
- 제안된 간소화 문자열을 실제 llvm-mc로 다시 빌드한 결과 Intel/AT&T 대표 입력 모두 invalid operand로 실패. FlattenAsmStringVariants가 마스크 중괄호를 문법 선택 그룹으로 처리하는 소스 근거와 재현 입력을 해당 리뷰 답글에 게시했다.
- 최종 복원 빌드에서 관련 lit 10/10 통과. 증거는 out/avx512pf_review_20261022/ (suggested_results.json, 빌드 로그, lit_results.json, revision.patch). CPU 실행 및 전체 LLVM 시험은 하지 않았다.
- 세 리뷰 스레드에 각각 답글 게시 확인. PR 본문에서 제거된 object disassembly 검사 설명 정리. 리뷰 스레드를 임의 해결 처리하지 않았다. 새 커밋 CI는 대기/진행 단계이며 이전 커밋의 성공과 구분한다.
- 정책 읽기 확인 답글은 여전히 게시하지 않았다. 다음은 검토자의 응답 및 새 CI 결과 확인.

## 2026-11-03 연구실 미팅 후속: 5단계 Intel·AT&T 왕복 대조(snapshot)
- 미팅 지시: Intel 소스 → 조립 → AT&T로 역어셈블 → 다시 조립 → 다시 역어셈블 → 원래 바이트·어셈블리와 비교. 두 구문 경로 결과가 같아야 하고 다른 케이스를 추린다. 목적은 어셈블러·역어셈블러 결함 탐지.
- 사용자와 합의한 설계: 같은 계열끼리만(GNU objdump+as, LLVM llvm-mc+clang), B0는 계열별 자기 바이트(3단계 bytes_as/bytes_clang, 수용 케이스 전부·SDM 불일치 포함), 결과는 별도 snapshot. run.py에는 넣지 않았다.
- 구현 `pipeline/m5_roundtrip.py`, 회귀 `tests/test_m5_roundtrip.py`(8개). 판정: 바이트 같음 / 바이트 다름·명령 같음 / 바이트 다름·명령 다름 / 재조립 거부, 비교 불가(분기 대상 미대조·재배치 생김·역어셈블 실패). AT&T·Intel 두 경로 각각 판정, `route`는 두 경로 바이트 비교. objdump `.byte`는 역어셈블 실패로 본다(시험 중 발견).
- 결과 `out/roundtrip_20261103/`(manifest, results, summary). GNU 20,911 / LLVM 20,845.
  - GNU AT&T: 같음 20,611, 명령 같음 187, 명령 다름 8, 거부 1, rel 104. Intel: 같음 20,599, 명령 같음 187, 명령 다름 8, 거부 13.
  - LLVM AT&T: 같음 18,805, 명령 같음 1,935, 명령 다름 1, rel 104. Intel: 같음 18,781, 명령 같음 1,935, 명령 다름 25.
- 검토 대상(미확정, 버그로 단정하지 않음):
  - GNU LAR·LSL r64, m16 / MOV r64↔Sreg(REX.W): objdump 출력 `lar (%rax),%rcx` 등을 as가 REX.W 없이 조립해 다시 풀면 ecx. 6+2케이스, 모두 3단계 '강제 접두어' 케이스.
  - GNU LSS·LFS·LGS r64(m16:64): objdump Intel이 `FWORD PTR`로 출력하고 as가 그 출력을 거부(AT&T 경로는 같음). 4단계 objdump '오퍼랜드 다름'과 같은 케이스 9개.
  - GNU MOVSXD r16(66 63): objdump가 `movsxd cx,edx`/`DWORD PTR`로 출력, as가 거부. 4케이스.
  - LLVM 먼 간접 CALL·JMP(FF /3, /5): Intel 출력 `call [rax]`를 clang이 가까운 호출(ff 10)로 조립. 4단계는 SDM에 크기 표기 문법이 없어 '미대조'였으나, 왕복은 SDM 문법과 무관하게 자기 출력이 다른 명령이 됨을 보인다. 기존 보고 #88516·#95232와의 관계 확인 필요. 21케이스(data16·rex64 변형 포함).
  - LLVM POPFW·PUSHFW(66 9D/9C): Intel 출력 `popf`/`pushf`가 64비트 형식으로 재조립. MOV Sreg, r16(66 8E): AT&T `movw %cx,%es`가 66 없이 조립(낮은 우선순위). PUSH imm16 2개는 등록된 도달 불가 케이스.
- 바이트 다름·명령 같음은 주로 VEX/EVEX 이동·시프트 명령의 대체 인코딩. 사용자 결정대로 별도 그룹으로 둔다.
- 다음: 위 검토 대상의 원문·도구 문서 확인과 기존 보고 검색. 커밋은 사용자 승인 후.

### 2026-11-03 왕복 검토 대상 1차 확인
- GNU LAR·LSL r64 / MOV r64↔Sreg: binutils 2.47 `opcodes/i386-opc.tbl` 642·643·651·652·204·206행이 `NoRex64`. as가 64비트 레지스터에도 REX.W를 내지 않는 의도된 설계로 보인다. 버그 후보에서 내리고 '도구 설계(REX.W 생략)'로 기록.
- GNU MOVSXD r16: 우리 설정 불일치. as는 `-mintel64`, objdump는 기본(AMD64)으로 풀었다. `-M intel,intel64`면 `movsxd cx,dx`/`WORD PTR`로 나와 as와 맞는다(i386-dis.c movsxd_mode가 intel64에서만 WORD). 사용자 결정(11월 3일): Intel SDM 기준이므로 4·5단계 objdump를 `-M intel64`로 맞춘다(아래 절).
- GNU LSS·LFS·LGS r64(REX.W 0F B2/B4/B5, m16:64): 후보 유지. objdump는 intel64에서도 `FWORD PTR`(i386-dis.c `Mp`=f_mode가 REX.W를 보지 않음, 2.47과 master 0aeb555 동일). as -mintel64는 `tbyte ptr`만 받고 `fword ptr`는 거부(직접 확인). Sourceware Bugzilla는 자동 접근 차단으로 중복 검색 못 함.
- LLVM 먼 간접 CALL·JMP: 후보 유지(강함). llvm-mc Intel 출력과 다시 조립 결과(23.1.3, main 24.0.0git 74a120b 동일):
  `ff18`→`call [rax]`→`ff10`(가까운 호출), `66ff18`→`lcall [rax]`→`ff18`, `48ff18`→`lcall [rax]`→`ff18`, `ff28`→`jmp [rax]`→`ff20`, `66ff28`→`ljmp [rax]`→`48ff28`, `48ff28`→같음. 6개 중 5개가 자기 출력에서 다른 바이트(첫·넷째는 가까운 분기로 바뀜). AT&T 출력(`lcalll *(%rax)` 등)은 모두 같다.
  - 기존 #88516·#95232는 어셈블러가 크기 표기를 무시하는 문제, #48335 [1]은 `lcall tbyte ptr`가 REX.W 없이 조립되는 문제. 역어셈블 Intel 출력의 왕복 문제는 GitHub 검색(lcall/ljmp/far call)에서 찾지 못함(중복 부재를 단정하지 않음).
  - 10월 12일 '철회'(SDM에 크기 표기 문법 없음)와 근거가 다르다: 이번 근거는 SDM 문법이 아니라 도구 자기 출력의 재조립 불일치.

### 2026-11-03 objdump Intel64 해석 적용(사용자 결정)
- 이유: 실험 기준이 Intel SDM이고 as는 이미 `-mintel64`. objdump 기본값(AMD64)과 어긋나 MOVSXD r16을 r/m32로 풀었다.
- 4단계 `m4_disasm.disassemble_objdump`, 5단계 `m5_roundtrip.objdump_text`에 `-M ...,intel64`. `instruction_check.assemble`은 11월 4일에 맞췄다(아래 절).
- 4단계 재실행(`out/runs/20261103T051843490346Z.json`): 바뀐 케이스는 MOVSXD 1351-0~3 네 개뿐(objdump 오퍼랜드 다름 25 → 21, SDM 일치 20,632 → 20,636), 다른 열·케이스 변화 0. 사전 읽기 전용 재판정(전체 20,844)도 같은 4건.
- 5단계 재실행 `out/roundtrip_20261103_intel64/`(이전 `out/roundtrip_20261103/`은 보존): 바뀐 판정은 MOVSXD 같은 4케이스의 재조립 거부 5건 → 바이트 같음뿐. GNU Intel 경로 재조립 거부 13 → 9(남은 9는 LSS·LFS·LGS r64 FWORD). LLVM 결과 동일.
- 회귀 166개 통과(m4 intel64 1개, m5 MOVSXD 1개 추가).

## 2026-11-04 instruction_check Intel64, 버그 후보 결정, LLVM PR 머지 확인
- 사용자 지시로 `instruction_check.assemble`의 objdump도 `-M <syntax>,intel64`. 3단계 판정은 objdump 텍스트를 쓰지 않아(바이트·상태·재배치만) 재실행 불필요. 영향은 검사 CLI 표시·참고 왕복. 회귀 `test_objdump_uses_intel64_like_as`(MOVSXD r16 → `movsxd cx,dx`) 추가, 167개 통과.
- 사용자 결정: LLVM 먼 간접 CALL·JMP 왕복 불일치와 GNU LSS·LFS·LGS r64 `FWORD PTR` 출력은 오류(이슈 대상)로 본다. 제출 여부·시점은 사용자 결정.
- PR #233869 머지 확인(gh): 2026-10-27T02:59:15Z, 머지 커밋 7b9c6d7c19f40b8a693e5810e21d32e4a08778ec, phoebewang 승인, 이슈 #233852 closed. 머지 커밋의 `.td` 변경은 로컬 패치(`patches/llvm-avx512pf-intel-mask/`)와 같다.
- 머지 커밋 소스로 llvm-mc 직접 빌드(`~/opt/build/llvm-main-7b9c6d7/`, 24.0.0git, Release+assertions, X86; 기존 증거 빌드는 건드리지 않음). snapshot `out/avx512pf_main_merge_20261104/`:
  - 3단계 AVX512PF 16케이스(clang Intel 거부였던 것): 머지 llvm-mc가 16/16 수용, 바이트 = GNU as SDM 일치 바이트, Intel 출력 재조립도 16/16 같음. 대조군 LLVM 23.1.3은 16/16 거부.
  - PR 관련 lit 5개(avx512pf-64-intel, avx512pf-intel-errors, apx evex-format-intel/att, Disassembler apx evex-format) 5/5 통과.
  - 수정은 main(24.0.0git)에만 있다. 우리 파이프라인 기준 도구 LLVM 23.1.3 결과는 그대로다.
- 같은 머지 빌드에서 LLVM 먼 간접 CALL·JMP 재확인: 6개 중 5개가 여전히 Intel 출력 재조립 시 다른 바이트(11월 3일과 동일).

## 2026-11-05 5단계 원본 소스 대 마지막 출력 비교
- 기존 5단계는 B0 대 재조립 바이트, 최초 대 재역어셈블 명령(AT&T·Intel), 두 문법 경로의 바이트를 비교했다. 교수님 그림의 원본 Intel 소스 `as0`와 마지막 Intel 출력 `as2` 직접 비교는 빠져 있었다.
- `scripts/compare_source_roundtrip.py`가 저장된 `out/roundtrip_20261103_intel64/roundtrip_results.csv`를 재분석해 별도 `out/roundtrip_source_compare_20261105/`에 `source_match_att/intel`, `final_intel_att/intel`을 기록했다. 도구 재실행·원래 snapshot 수정 없음.
- 이 열은 대소문자·구두점 주변 공백만 흡수한 문자열 비교다. 숫자 진법·별칭·접두어 등 때문에 문자열이 다를 수 있어 도구 오류 또는 실행 의미 차이로 세지 않는다. 정확한 범위·수치·해시는 새 manifest와 DEVLOG 11월 5일 절 참조.

## 2026-11-11 실험 설계 수정(교수님 미팅 4가지, 진행 중)
- 사용자가 전달한 미팅 지적: ① 상대 주소는 정의하지 않은 외부 라벨로 조립해 재배치(0 자리)로 비교, ② 왕복이 어긋날 때 역어셈블 문제인지 재조립 문제인지 가르기 위해 원본 Intel 소스를 AT&T로 직접 바꿔 같은 도구로 조립·비교, ③ 매뉴얼 문법에 없는 접두어(REX.W 등) 강제 주입은 연구 일관성을 해침 → 매뉴얼 문법만, ④ 문법마다 1개가 아니라 경계값·랜덤으로 케이스를 늘려 트리아지.
- 사용자 결정(11월 11일): 강제 접두어 모두 제거(생성기의 data16·rex64 철자와 3단계 자동 재시도 `{evex}`·`{vex3}`·`{vex}`·`{load}`·`{store}`·`rex64` 둘 다), 경계값 + 시드 랜덤, 2~5단계 새 라운드 전체 재실행(기존 out/cases·roundtrip 보존).
- 구현:
  - 2단계 `m2_generate.py --values --seed --random`: `hi`(번호가 가장 큰 레지스터, EVEX는 xmm/ymm/zmm31·k7), `h8`(ah~bh, REX 없는 행), `imm:값`(case_rules.IMMEDIATE_BOUNDARY), `addr:이름`(rsp·rbp·r12·r13 기준, disp8/disp32 경계, scale 1/2/8, REX 레지스터, 기준 없는 SIB, 절대 disp32, RIP 경계, EVEX disp8*N 경계, VSIB 3종), `randN`(행 번호·순번 시드). 상대 분기 기본값 `ext_target`(외부 기호), 이전 `.Ltarget` 라벨은 alt 변형으로 남김(rel8 행 도달용). 별칭 비교는 숫자를 값으로 비교. movabs·data16·rex64 철자 삭제(64비트 절대 주소 `mov al, byte ptr [..]`는 두 도구 모두 A0로 조립, 직접 확인).
  - `pipeline/att_syntax.py`: GNU as 매뉴얼 규칙(순서 반대, `%`/`$`, `disp(base,index,scale)`, `*` 간접, lcall/ljmp/lret, movs/movz 글자, x87 s/l/t·s/l/ll, AT&T Syntax bugs의 fsub/fdiv 반전, 오퍼랜드 없는 d→l 이름). 크기 글자는 같은 니모닉·오퍼랜드 종류에서 메모리 폭이 둘 이상일 때만(`ambiguous_keys`, 생성 소스 전체에서 셈), `{1toN}`이면 글자 없음. 모르는 철자는 변환 안 함+이유.
  - 3단계: 강제 접두어 재시도 삭제. `source_att`를 같은 도구로 조립해 `syntax_<도구>`(같은 바이트/바이트 다름/AT&T만 거부/Intel만 거부/둘 다 거부/변환 없음), 재배치 목록 `reloc_<도구>`. `encoding_audit`은 외부 기호 재배치(위치=변위 시작, addend=-꼬리 폭, PC8 또는 PC32·PLT32, 변위 0)를 대조.
  - 5단계: 외부 기호 분기는 역어셈블 출력의 대상 숫자를 기호로 바꿔(`target_rewrite`) 바이트+재배치 비교. `localize_att/intel`: 원본 Intel·AT&T가 같은 바이트면 '역어셈블 출력 쪽 의심', 다르면 '어셈블러 문법 해석 쪽 의심'.
  - 실행기 `scripts/run_round.py --out out/round2_20261111`(manifest에 코드·입력 해시, 도구 판).
- 검증: 새 회귀 `tests/test_att_syntax.py`(매뉴얼 예에서 손으로 쓴 기대값), `tests/test_round2_design.py`(SYM026 순서, 재배치 손계산, readelf 형식). 일부러 고장 낸 코드(x87 반전 삭제, 외부 기호 이름 바꿈)를 잡는 것 확인. 기존 167개 포함 전체 통과.
- 시험 실행(2,889케이스 표본) 관찰, 미확정: clang Intel `push fs`/`pop fs` → 66 접두어(16비트), AT&T `push %fs` → 없음; clang Intel `mov cx, es` → 8cc1, AT&T → 668cc1; clang Intel `call/jmp dword·tbyte ptr [rax]` → 크기 표기와 무관하게 `ff18`/`ff28`(먼 m16:32, 기존 #88516 계열) vs AT&T `lcallw`/`lcallq` → `66ff18`/`48ff18`. GNU AT&T는 정수→실수 변환의 `{rn-sae}`를 GPR 앞에 두면 거부(Intel 문법은 GPR 뒤를 받음) — 변환 규칙 미확정으로 기록.
- 전체 실행 1차(11월 11일 13:06): 2단계 완료(`out/round2_20261111/cases/`, 106,601케이스), 3단계 도중 시스템 메모리 부족으로 Claude Code가 백그라운드 작업을 중단. 3단계 결과 없음, manifest 없음. 사용자 지시 전 재실행하지 않음.
- 2차 실행(작업자 4)은 사용자 지시로 중단: 사용자 서버로 옮겨 실행한다. 사용자 지시로 브랜치 `sdm-review-093`에 커밋(부분 결과 `out/round2_20261111/`, `artifacts/`, `out/manual_index*` 제외).
- 서버 실행: Binutils 2.47·LLVM 23.1.3 같은 판(경로 다르면 `BINUTILS_BIN`·`LLVM_BIN`), `python3 scripts/run_round.py --out out/round2_20261111 --workers N`. 메모리: 3단계가 조립 결과를 모두 메모리에 둔다.
- 다음: 서버 결과 수치·트리아지, 약식 보고서, PIPELINE 갱신.

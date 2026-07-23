# DEVLOG — 진행 기록

<!-- 교수님 지시: CLI에 다 맡기지 말고, 무엇을 왜 바꿨는지 여기에 남긴다.
     미팅 전, 형섭이 본인 말로 진행상황을 설명할 수 있게 정리하는 용도. -->

기록 형식(한 줄~몇 줄):

```
## YYYY-MM-DD  [모듈]  제목
- 무엇을: (바꾼 내용)
- 왜: (이유 / 어떤 문제 때문에)
- verifier: pass / fail→수정 후 pass
- 남은 것: (다음에 할 일)
```

---

## 2026-07-14  [setup]  파이프라인 재정렬 · 에이전트 하네스 구성
- 무엇을: 교수님 10회 미팅 반영해 CLAUDE.md(마스터 설계) + 모듈별 에이전트 7개 + verifier + `/run-pipeline` 커맨드 작성.
- 왜: 기존 파이프라인이 과도하게 복잡(llvm-mc·iced-x86·변주축·음성셋)해 형섭이 관리 못 함 → 심플 설계로 새로 시작.
- verifier: (아직 코드 없음 — 다음 단계에서 extractor부터 구현하며 정답지 만들기)
- 남은 것: `pipeline/` 에 m1_extract.py 부터 구현. `tests/answer_keys/` 에 mov/add/push 정답지 손으로 작성.

<!-- 다음 미팅: 약 2주 후, 비대면(Slack). 위 형식으로 진행상황 정리해 둘 것. -->

## 2026-07-23  [extractor]  Stage 1 구현 — 헤더 역할 분류 + 폰트 크기 기반 각주 제거
- 무엇을: `pipeline/m1_extract.py` 작성. SDM 118~2392페이지를 pdfplumber로 파싱해 `data/db/isa_db.csv`(4,210행, opcode/instruction/mnemonic/operands/op_en/mode_support/cpuid_flag/description/source_page) 생성. TOC 대조 커버리지 리포트(`data/db/coverage_report.md`)도 같이 생성.
- 왜: SDM 인코딩 표가 실제로는 문서에 적힌 "2가지 레이아웃"이 아니라 7가지 헤더 모양이 있어서, 컬럼 개수로 레이아웃을 나누는 방식 대신 헤더 텍스트로 컬럼 역할(opcode/instruction 병합 여부, op_en/mode/compat/cpuid/description 위치)을 판별하는 분류기로 구현. 각주 숫자 제거도 처음엔 화이트리스트(`FIXED_OPERAND_WORDS`) 방식으로 했다가 verifier가 반복적으로 같은 버그 클래스(Sreg, m16, m64, UD0 등에서 재발)를 잡아내서, 최종적으로 pdfplumber 문자 단위 폰트 크기(본문 대비 작은 폰트=각주)로 판별하는 방식으로 근본 수정. Description 컬럼의 아래첨자(log₂ 등)가 문장 끝으로 밀리는 별개 버그도 `chars_to_text`의 `y_tolerance`를 3→5로 조정해 해결.
- verifier: fail(mnemonic/operands 잔재, coverage 문구 오류) → fail(화이트리스트 방식 재발+회귀) → fail(Description 아래첨자 버그 신규 발견) → **pass** (총 5차 시도)
- 남은 것: tokenizer(`pipeline/m2_tokenize.py`) 구현 시작.

## 2026-07-23  [tokenizer]  Stage 2 구현 — operand 단위로 펼쳐 토큰화
- 무엇을: `pipeline/m2_tokenize.py` 작성. `data/db/isa_db.csv`(4,210행)의 mnemonic/operands를 오퍼랜드 단위로 펼쳐 `data/db/tokens.csv`(9,820행) 생성. 스키마: `row_id, mnemonic, operand_index, operand_count, operand_token, operand_kind, raw_instruction, op_en, mode_support, cpuid_flag, source_page`. operand_token은 SDM 원문 표기(`r/m16` 등)를 그대로 보존하고, operand_kind로 register/memory/reg_or_mem/immediate/relative/moffs/far_ptr/implicit/none/other 힌트만 붙임.
- 왜: extractor가 `REP MOVS m8, m8` 같은 문자열 반복 명령어를 mnemonic="REP", operands="MOVS m8, m8"로 1차 분리해둔 걸 그대로 콤마 분리하면 서브니모닉이 오퍼랜드에 섞이는 문제가 있어, x86 문자열 명령어 7개(INS/OUTS/LODS/MOVS/CMPS/SCAS/STOS)에 한정한 고정 목록으로 mnemonic을 복원(`fix_repeat_prefix_mnemonic`). 이건 extractor 때 문제였던 "화이트리스트로 각주숫자 잡기"(무한히 늘어나는 집합이라 계속 놓침)와 달리 ISA 상 고정된 유한 집합이라 안전하다고 판단.
- verifier: **pass** (1차 통과 — 정답지 대조, REP 병합 34행, row_id 무결성 4,210건, operand_kind 스팟체크, other 14행 PDF 대조, 회귀 검사 전부 실측 확인)
- 남은 것: `tests/answer_keys/*.csv`의 `intel_asm`/`expect_bytes`/`expect_disasm` 칸이 아직 비어 있음 — generator/assembler 단계 검증부터는 이 칸을 형섭이 직접 채워야 바이트 단위 정밀 대조가 가능함. combiner(`pipeline/m3_combine.py`) 구현 시작.

## 2026-07-23  [combiner]  Stage 3 구현 — operand 타입을 구체값으로 전개
- 무엇을: `pipeline/m3_combine.py` 작성. `data/db/tokens.csv`(9,820행)의 오퍼랜드 타입(`r32`, `r/m32`, `imm8`, `xmm` 등)을 대표 구체값(`ecx`, `dword ptr [eax]`/`ecx`, `1`, `xmm0` 등)으로 전개해 `data/db/combos.csv`(7,277행) 생성. `r/m32` 같은 reg_or_mem 슬래시 표기는 정확히 레지스터 후보 1개+메모리 후보 1개로만 쪼개고, 여러 오퍼랜드가 있어도 zip 방식(cartesian product 아님)으로 묶어 조합 폭발을 막음. `expected_valid`는 `mode_support=="Valid"` 여부로 결정(Invalid/N.E./N.S.도 생성하되 플래그만 다르게 표시).
- 왜: CLAUDE.4 "심플 우선" 원칙에 따라 타입별 전수 조합 대신 대표값 1~2개씩만 뽑아 폭발을 피함. generator(다음 단계)가 조합 후보 중 실제로 쓸 것을 고르게 하기 위해 combos.csv에 여러 대표 조합을 남겨둠.
- verifier: **pass** (1차 통과 — 정답지 mov/add/push 전체 대조, reg_or_mem 폭발 없음 확인(1~2개 조합만), 메모리 사이즈 매핑 스팟체크, expected_valid/mode_support 7,277행 전수 일관성, 회귀 검사 전부 실측 확인)
- 알려진 이슈: ENCODEKEY256(row_id 570) 1건 — tokenizer 입력 자체에 콤마 누락(`"r32, r32 <XMM0-6>"`)이 있어 combiner가 구체값을 만들어도 SDM 기준으로는 틀린 조합(`ecx, xmm0`)이 나옴. 전체 9,820개 토큰 중 이 패턴은 이 1건뿐이라 국소적 이슈로 기록만 하고 넘어감 — generator 단계에서 이 row는 스킵하거나 예외 처리 권장.
- 남은 것: `tests/answer_keys/*.csv`의 `intel_asm`/`expect_bytes`/`expect_disasm` 칸을 형섭이 채워야 generator/assembler 단계부터 바이트 단위 정밀 검증 가능. generator(`pipeline/m4_generate.py`) 구현 시작.

## 2026-07-23  [generator]  Stage 4 구현 — combos.csv를 Intel-syntax .s 파일로
- 무엇을: `pipeline/m4_generate.py` 작성. `data/db/combos.csv`(7,277행, row_id 570 ENCODEKEY256은 알려진 이슈로 스킵)를 순서대로 전부 어셈블리 줄로 변환해 `out/tests.s`(7,284줄) 생성. 각 줄에 `combo_id/row_id/mnemonic/expected_valid/mode_support` 등을 주석으로 붙여 이후 단계(assembler/roundtrip/triage)가 원본으로 역추적 가능하게 함. 파일 맨 위 `.intel_syntax noprefix` 지시어, `rel8/16/32` 오퍼랜드가 참조할 `.Ltarget:` 라벨 선언. `expected_valid=False`(Invalid/N.E./N.S.) 조합도 버리지 않고 그대로 생성(매뉴얼상 무효인 form을 어셈블러가 실제로 거부하는지 확인하는 게 이 프로젝트의 핵심 목적이므로).
- 왜: combos.csv에 이미 완성된 대표 조합이 있으니 generator는 "조립 + 역추적 주석"이 핵심 작업. 조합을 하나만 고르지 않고 전량 채택한 이유는 "다양하게 커버하는 게 낫다"는 프로젝트 취지(v1 스코프) 때문.
- verifier: **pass** (1차 통과 — `.intel_syntax noprefix`/`.Ltarget` 라벨 위치, 정답지 대조, row_id 570 스킵, 줄 수 정합성 7,276건, 주석 역추적 15건 스팟체크, 회귀 검사 전부 실측 확인)
- 추가: `tests/answer_keys/mov.csv`, `add.csv`, `push.csv`의 `intel_asm`/`expect_assemble` 칸을 LLM이 SDM 기준 초안으로 채움(형섭 요청, 검토 후 확정 필요 — `note`에 "LLM 초안 — 검토 필요"로 표시해둠). `expect_bytes`/`expect_disasm`은 비워둠(README 규칙대로 이후 objdump로 채울 수 있음).
- 남은 것: assembler(`pipeline/m5_assemble.py`) 구현 시작. 이 환경(Windows)엔 GNU as/objdump가 없어서 실행 환경을 WSL Ubuntu로 옮길지 검토 필요.

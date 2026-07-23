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

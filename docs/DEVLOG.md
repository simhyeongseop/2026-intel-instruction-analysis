# DEVLOG — 진행 기록

## 2026-10-09 [입력 검사·인계] 지원 모드와 64비트 주소 충돌 표시

- 모드가 Invalid/N.E./N.S.인 SDM 행의 64비트 메모리 주소를 입력 위반으로 표시한다.
  소스는 부정 테스트로 보존하며 지원 모드의 정상 예제로 간주하지 않는다.
- 전체 생성 결과에서 해당 입력 39개 확인. 기존 rel16 위반 33개와 합쳐 invalid 72개.
  거부 입력 178개 검토에서 발견한 주소 문제 31개는 전체 생성 집합의 일부다.
- 회귀 98개 PASS. 새 snapshot과 이전 snapshot의 소스/행 대응 전량 보존,
  검증 근거 변경 39개만 새 ID, 나머지 23,160개 ID 보존을 별도 대조했다.
- 새 결과: `out/generator_audit_2026-10-09_mode_address/`.
  생성·정적 검사만 재실행했으며 새 조립 관측과 CPU 실행은 없다.
  최신 전량 조립 관측은 9월 29일 snapshot에 있다.
- HANDOFF를 짧은 최신 상태로 갱신하고 AGENTS/CLAUDE/README에서 진입 경로를 통일했다.
  개별 검토 31개가 새 39개에 전부 포함되는 것도 확인했다. 추가 8개는
  CALL/JMP r/m32와 LGDT/LIDT m16&32 각 2개이며, 다음 작업은 해당 도구 관측 검토다.

## 2026-09-29 [독립 검증·재실행] Description 교정 13개

- Sol 구현을 검토한 뒤 생성→GNU/Clang 조립·비교를 캐시 재사용 없이 전량 재실행했다.
- 23,199개 중 예정한 13개만 소스 변경, 모두 양 도구 수용 및 의도한 폭 확인. 나머지 23,186개 소스/ID 보존.
- 회귀 97개 PASS, 독립 검증 PASS. 한쪽 이상 거부 178→165개, GNU 104→95개, Clang 166→155개.
- 원문 DB/기본 결과/이전 감사 결과의 해시 보존. 주소 문제 31개와 미확정 MOV 3개는 이번 수정 제외.
- 상세 변경·재현·새 snapshot: [Description 교정 보고서](DESCRIPTION_FIX_2026-09-29.md).

## 2026-09-28 [생성기·검증] SDM 입력 제약과 목표 인코딩 구분

- CR8, SDM r8 타입 해석, 분기 폭, 문자열 고정 주소, gather 레지스터 충돌, moffs 인코딩 지정,
  PREFETCHIT/XLAT 주소를 수정했다. XBEGIN rel16은 long mode에서도 유효하므로 일반 분기와 구분했다.
- opcode/description/form hash와 구조화 오퍼랜드, 입력 검사 상태, test kind를 전달한다.
  소스·검증 근거가 바뀌면 새 ID를 배정하고 기존 관측·판정을 보존한다. 성공 경고도 저장한다.
- 전체 23,199 combo·39,852개 고유 도구/소스 관측을 별도 snapshot에서 검증했다.
  회귀 92개와 독립 바이트·ID·과거 파일 해시 검증이 통과했다. 임의 CPU 실행은 하지 않았다.
- Sol 구현을 독립 검토한 뒤 사용량 한도로 중단된 마지막 테스트·수정을 주 에이전트가 마무리했다.
- 기본 DB/과거 out 결과는 미교체. 검증 범위·원시 결과·남은 경고·재현 방법은
  [검증 보고서](GENERATOR_VALIDATION_2026-09-28.md)에 기록했다. 전체 ISA 적합성 완료를 주장하지 않는다.

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

## 2026-07-23  [assembler]  Stage 5 구현 — GNU as로 한 줄씩 개별 어셈블
- 무엇을: `pipeline/m5_assemble.py` 작성. 실행 환경을 WSL Ubuntu로 옮겨 GNU `as`/`objdump` 확보. `out/tests.s`(7,276개 명령어 줄)를 통째로 어셈블하지 않고 한 줄씩 임시 `.s`로 잘라 개별적으로 `as --64 -mintel64`에 넘겨, 어떤 줄이 되고 안 되는지 정확히 기록. 결과를 `out/asm_result.csv`에 저장하고 성공한 줄은 `out/objects/combo_<id>.o`로 보존, `expected_valid`(매뉴얼 기대) vs `actual_result`(as 실제 결과)가 다른 `mismatch` 컬럼도 계산.
- 왜: CLAUDE.md 1절 "매뉴얼대로 작성했는데 어셈블러가 처리 못 하는 경우"를 찾으려면 실패한 줄 하나 때문에 나머지 7,000여 줄이 전부 실패로 뜨면 안 됨 → 줄 단위 개별 어셈블로 설계.
- verifier: fail(1차 — mismatch 재계산 검증 중 상위 단계 데이터 문제 발견) → assembler 모듈 자체는 **pass**, 단 **extractor(1단계)의 신규 버그 발견**: `mode_support`가 `V/N.E.`처럼 슬래시로 결합된 SDM 원문 표기에서 `tidy_mode_text()`가 약어 `V`를 인식하지 못해 앞쪽 64비트 모드 값(`V`=Valid)을 통째로 날리고 뒤쪽 `N.E.`만 남기는 버그(ADCX/MOVBE 등 REX.W·VEX.W1 64비트 확장 레지스터 폭 변형 92개 후보 니모닉 영향, PDF p.130/p.748 직접 대조로 확인) → mismatch 416건 중 상당수가 실제 버그가 아니라 이 상위 단계 오류 때문으로 판명.
- 남은 것: extractor로 피드백을 돌려 `tidy_mode_text` 수정 (아래 항목).

## 2026-07-23  [extractor]  Stage 1 버그 수정 — mode_support 슬래시 결합 표기 파싱
- 무엇을: `pipeline/m1_extract.py`의 `tidy_mode_text()`를 `re.search`(문자열에서 첫 매치 하나만 찾아 그 조각만 반환) 방식에서 `re.sub` + 헬퍼 `_tidy_one_mode_value()`(문자열 안의 모든 모드 표기 조각을 제자리에서 통일, 슬래시 구조는 보존) 방식으로 재작성. `data/db/isa_db.csv` 재생성.
- 왜: 위 assembler(5단계) 검증에서 발견된 버그 그대로 — 약어 `V`가 정규식에 안 걸려서 `V/N.E.` 같은 결합 표기의 앞쪽이 사라지는 문제. 최종적으로 슬래시 중 어느 쪽(64비트 모드)을 쓸지는 `normalize_mode()`가 이미 `token.split("/")[0]`으로 담당하므로 `tidy_mode_text`는 원문 구조 보존까지만 책임지도록 역할을 명확히 함.
- verifier: **pass** — `tidy_mode_text('V/N.E.')`가 이제 `'V/N.E.'`를 보존하고 `normalize_mode(...)`가 최종 `'Valid'`를 반환함을 도구로 직접 실행 확인. 수정 전 REX.W/.W1+N.E. 패턴 92건이 수정 후 0건(전부 정정)으로 재계산. `git diff` 전수 파싱 결과 총 131건 변경 중 92건 외 39건(BNDCL/RDPID/INVPCID 등 F3/F2/66/VEX.W0 계열)도 동일 버그 클래스로 추가 발견·정정되어 92+39=131이 diff와 정확히 일치. PDF 원문 대조 2건(RDPID p.1251, BNDCL p.208) 완전 일치. 131개 변경 행 전부 `mode_support` 컬럼만 바뀌었고 방향은 전부 `N.E.→Valid`(반대 방향 0건), 변경된 mnemonic 99종에 MOV/ADD/PUSH 없어 정답지 무영향 확인.
- 남은 것: 이 수정이 `tokens.csv`/`combos.csv`/`out/tests.s`/`out/asm_result.csv`에 아직 반영 안 됨(전부 수정 이전 시각에 생성) — tokenizer부터 재실행해 하위 단계에 전파 필요.

## 2026-07-23  [tokenizer/combiner/generator/assembler]  Stage 1 수정 하위 전파 — 코드 변경 없이 데이터만 재생성
- 무엇을: `m1_extract.py` 수정 후 코드는 그대로 두고 `m2_tokenize.py`→`m3_combine.py`→`m4_generate.py`→`m5_assemble.py`를 순서대로 재실행. `tokens.csv`(9,820행)/`combos.csv`(7,277행)/`out/tests.s`(7,276줄)는 행 수 동일 유지, `out/asm_result.csv`의 mismatch가 **416건 → 248건**으로 감소(순감소 168 = True→False 182건 - False→True 14건, 전수 재계산으로 정확히 일치 확인).
- 왜: mode_support 값만 바뀌었으니 tokens.csv/combos.csv의 구조(operand 조합)는 안 바뀌어야 정상 — 그걸 확인하는 게 이번 검증의 핵심.
- verifier: **pass** — tokens.csv는 `mode_support` 컬럼 309행, combos.csv는 `expected_valid`+`mode_support` 2개 컬럼 196행만 변경(다른 컬럼 변경 0건, 구조적 회귀 없음) 확인. ADCX/MOVBE REX.W 폼이 실제로 `mismatch=False`로 바뀜을 직접 확인. mov/add/push 정답지 범위는 이번 라운드에 변경 0건(회귀 없음, 기존 무관한 이슈 6건은 그대로 존재). row_id 570 스킵 유지.
- 새로 드러난 것: mode_support가 정확해지면서 새로 mismatch로 잡힌 14건(BNDCL/BNDCU/BNDCN/BNDMK/BNDMOV×2/LDTILECFG/STTILECFG/TDPB*류) — 회귀가 아니라 combiner가 "같은 레지스터를 여러 슬롯에 재사용"하거나 addr32 프리픽스를 안 넣는 기존 한계가 데이터 정확도가 올라가면서 드러난 것. triage 단계에서 combiner 개선 후보로 다룰 것.
- 남은 것: roundtrip(`pipeline/m6_roundtrip.py`) 구현 시작.

## 2026-07-24  [roundtrip]  Stage 6 구현 — objdump 역어셈블 후 원본과 same/different 비교
- 무엇을: `pipeline/m6_roundtrip.py` 작성. `.claude/agents/roundtrip.md`의 "입력은 단일 out/tests.o" 설명은 낡은 것이라 무시하고, 실제 assembler(5단계) 출력 구조(`out/asm_result.csv`의 `actual_result=="ok"` 7,010행 + `out/objects/combo_<id>.o` 개별 파일)에 맞춰 구현. objdump를 7,010번 개별 실행하지 않고 여러 파일을 한 번에 인자로 넘겨 배치 실행한 뒤 `"파일: file format"` 헤더로 출력을 블록 분리해서 파싱(약 1분). EVEX+immediate 등 인코딩이 길어 헥스 바이트 덤프가 다음 줄로 줄바꿈되는 경우(니모닉 없는 줄) 명령어로 오인하지 않게 필터링. 정규화는 공백/대소문자만 흡수하고 숫자 표기(`1` vs `0x1`)나 라벨/주소는 의도적으로 안 흡수. 결과를 `out/roundtrip.csv`(same/different)로 저장.
- 왜: CLAUDE.md 6절 "objdump는 원본을 복원하는 도구가 아니다, 차이≠버그" 원칙에 따라 이 단계는 "같다/다르다"만 정확히 내고 원인분석은 triage(7단계)로 넘기도록 역할을 분리.
- verifier: **pass** — objdump 배치 파싱 재현 확인(combo_id 6692 등), roundtrip.csv 7,010행이 asm_result.csv의 ok 집합과 완전히 1:1(missing/extra 0), same/different 스팟체크 20건 전부 objdump 재실행과 일치, mov/add/push 정답지 대조, different 사례(조건부 분기 alias jc→jb, decimal→hex, 문자열 명령어 암묵 오퍼랜드, imm8이 니모닉 접미사로 흡수되는 vpclmulqdq 계열, mov→movabs) 전부 objdump로 재현해 "코드 버그가 아닌 표기 차이"임을 확인.
- 결과: 대상 7,010건 중 same 5,659건 / different 1,351건.
- 새로 드러난 이슈(generator 4단계 개선 후보, 이번 라운드에서는 안 고침): `combo_id=1684`(`mov al, 0x1000`) 등 imm 즉시값을 목적지 오퍼랜드 크기(8/16/32/64비트)에 맞추지 않고 고정값을 그대로 써서 `as`가 조용히 잘라 인코딩(truncate)하는 케이스 다수(`0x1000` 패턴만 75건) — roundtrip은 이를 정확히 different로 잡아내지만, 원래 의도한 "정상 크기 imm 테스트"가 안 되고 있는 것. triage 단계에서 다룰 것.
- 남은 것: triage(`pipeline/m7_triage.py`) 구현 시작 — roundtrip의 different 1,351건 + assembler의 mismatch 248건을 유형별로 그룹핑하고 alias/false alarm과 실제 버그 후보를 구분.

## 2026-07-24  [triage]  Stage 7 구현 — 컴파일 에러·roundtrip 차이 유형별 그룹핑
- 무엇을: `pipeline/m7_triage.py` 작성. `out/asm_result.csv`(컴파일 에러 266건 + mismatch 46건) + `out/roundtrip.csv`(different 1,351건)를 combo_id 기준 합집합(중복 제거)으로 모아 총 1,630건을 대상으로 패턴 매칭 기반 카테고리로 분류하고 `out/triage.csv` + `out/triage_report.md` 생성. 각 카테고리마다 verdict(bug/false_alarm/unsure)를 부여하되, LLM 추측이 아니라 `as`/`objdump` 직접 재실행 + SDM PDF 원문 대조로 근거를 확인한 것만 `bug`로 표시(CLAUDE.md 7절 원칙).
- 왜: numeric_repr(10진→16진 표기 차이), mnemonic_alias(jc/jnz 등 동일 opcode의 다른 이름), implicit_operand_display(문자열 명령어 암묵 오퍼랜드), fpu_stack_register_display 등 roundtrip/assembler가 잡아낸 "차이"의 대부분은 alias·표기 관례일 뿐 버그가 아니므로, 사람이 이해할 수 있게 유형별로 묶어 진짜 버그 후보만 걸러내는 게 이 단계의 목적.
- verifier: fail(1차 — `classify_compile_error()`의 최종 fallback이 `is_mismatch`를 확인 안 해서, SDM도 이미 Invalid/N.E.로 규정해 `as`가 정상 거부한 케이스 41건이 근거 없이 `unsure`로 오분류됨) → 수정 후 **pass**(2차 — fallback에 `is_mismatch` 분기 추가, 카운트/재현/회귀 전부 도구로 재확인).
- 1차 검증에서 새로 발견된 근본 원인 3가지도 반영:
  - `combiner_farptr_collapse`(6건, CALL/JMP m16:16/32/64): `m3_combine.py`의 `MEM_SIZE_RE` 정규식이 `:`를 무시하고 매치해 far-ptr을 `word ptr`로 뭉갠 combiner 버그 — false_alarm 처리, combiner 개선 후보로 문서화(이번 라운드엔 m3 코드 미수정).
  - `generator_moffs_missing_brackets`(5건, MOV moffs): generator가 괄호 없이 `mov 0x1000, al` 형태로 생성해 `as`가 거부하는 포맷팅 버그 — false_alarm 처리, generator 개선 후보로 문서화(이번 라운드엔 m4 코드 미수정).
  - `MOV Sreg, r/m64`(combo 1683): SDM은 `REX.W + 8E /r`을 64비트 모드 Valid로 명시하는데 `as`가 메모리 r/m64 인코딩 경로를 구현 안 함(LAR/LSL과 같은 유형) — 진짜 버그로 `ERROR_COMBO_OVERRIDES`에 추가해 bug 승격.
- 결과: 전체 1,630건 중 verdict 분포 `bug=7, false_alarm=1608, unsure=15`. bug 7건: CALL(N.E. 인코딩인데 as 허용), JMP(동일), LAR/LSL(SDM은 r64/r32 소스 허용하는데 as 거부), MOV Sreg,r/m64(신규), UDB(SDM엔 있는데 as가 니모닉 자체를 모름), VPMOVQD(매뉴얼은 xmm1/m128인데 as는 qword ptr만 허용).
- 남은 것: v1 스코프(CLAUDE.md 6절)의 마지막 파이프라인 단계 완료. 이번 triage에서 문서화만 하고 안 고친 combiner/generator 개선 후보(far-ptr collapse, moffs 괄호, register reuse, imm truncation 등)를 실제로 고칠지는 형섭이 판단해 다음 라운드로 넘길 것. `tests/test_modules.py`(정식 회귀 테스트 하네스)는 여전히 부재 — verifier가 매번 CSV 직접 비교로 대체 검증 중.

## 2026-07-24  [tests]  형섭 직접 확인용 수동 검증 스크립트 작성
- 무엇을: `tests/manual_bug_check.py` 작성. triage가 찾은 13건(진짜 버그 후보 7건 + combiner 코드 한계 6건)을 각각 실제 `as --64 -mintel64`에 넣어 그 자리에서 성공/실패를 확인하고, SDM 근거·대조군(정상 형태)까지 나란히 출력한다. combiner 쪽 2건(far-ptr collapse, moffs 괄호)은 `pipeline/m3_combine.py`를 직접 import해서 `MEM_SIZE_RE`/`expand_token`이 실제로 잘못 매치·반환하는 것도 코드 레벨로 보여준다.
- 왜: CLAUDE.md 1절 "판정은 도구가 한다" 원칙대로, 형섭이 LLM 설명만 보고 믿는 게 아니라 직접 `python3 tests/manual_bug_check.py` 한 번으로 13건을 눈으로 확인할 수 있게 하기 위함. pipeline/ 소속이 아니라 파이프라인과 독립된 수동 확인 도구라 tests/ 밑에 둠.
- 확인: 13/13건 전부 보고된 그대로 재현됨(직접 실행 확인).
- 발견: `generator_moffs_missing_brackets`(1689-1693)로 분류했던 moffs 괄호 누락 버그는 실제로는 `pipeline/m4_generate.py`가 아니라 **`pipeline/m3_combine.py`의 `expand_token`(moffs 분기, 169행)이 combos.csv에 이미 괄호 없는 `"0x1000"`을 써넣는 것**이 원인이었다(generator는 combos.csv 값을 그대로 옮기기만 함). 카테고리 이름의 "generator" 귀책은 오분류이며, 다음 combiner 수정 라운드에서 바로잡을 것.

## 2026-07-24  [combiner]  triage가 찾은 combiner 코드 한계 6가지 수정 + 하위 전파
- 무엇을: `pipeline/m3_combine.py`에 남아있던 combiner 한계 6가지를 수정했다.
  1. far-ptr collapse: `MEM_SIZE_RE`보다 먼저 매치하는 `FAR_PTR_ATOM_RE`(m16:16/32/64 전용)를 추가해 CALL/JMP는 `far ptr [eax]`, LSS/LFS/LGS는 크기별(dword/fword/tbyte ptr)로 분기. 같은 정규식 버그의 피해자였던 LGDT/LIDT(`m16&64`, `DESCRIPTOR_ATOM_RE`)도 함께 수정.
  2. moffs 괄호 누락: `expand_token`의 moffs 분기를 `"0x1000"` → `"[0x1000]"`로 수정.
  3. 레지스터 재사용: `register_candidate(atom, occurrence)` + `bump_counter`를 추가해 슬롯 순서대로 순번(`tmm0,tmm1,tmm2` 등)을 매기되, `as` 에러로 실제 확인된 `DISTINCT_REG_MNEMONICS` 집합(TDPB*/TDPFP16PS, VF*CADDCPH/VF*MULCPH 계열)에만 적용(BNDMOV는 distinct 제약이 실제로 없어 as가 `bnd0,bnd0`도 받아줘서 제외).
  4. VSIB 인덱스 누락: `memory_candidate`에 `VSIB_ATOM_RE`(vm32x/y/z, vm64x/y/z)를 추가해 `[eax + xmm1]`/`[eax + ymm1]`/`[eax + zmm1]`을 붙임.
  5. MPX addr32 누락: `MPX_MNEMONICS` 집합(BNDCL/BNDCN/BNDCU/BNDMK/BNDMOV/BNDLDX/BNDSTX)일 때 대표 주소를 `[rax]`(64비트)로 전환.
  6. AVX512 gather/scatter 기본 마스크: `is_gather_scatter(mnemonic)`일 때만 `{k1}`~`{k7}` 마스크를 살려서 붙임(`{z}`/`{er}`/`{sae}`는 계속 제거).
  수정 후 `combos.csv`(7277행, 폭발 없음) 중 165개 combo의 operands 값이 바뀌었고, 이어서 코드 변경 없이 `pipeline/run.py generator`로 4~7단계를 재실행해 `out/tests.s`/`out/asm_result.csv`/`out/roundtrip.csv`/`out/triage.csv`를 갱신했다.
- 왜: 이 6가지는 SDM vs GNU as의 진짜 불일치가 아니라 **우리 자신의 테스트 생성기(combiner)가 대표값을 잘못 골라서** 매뉴얼상 멀쩡한 명령어를 실패로 만들던 것들이다. 고쳐서 이 명령어들이 실제로 제대로 테스트되게 하는 게 목적이며, 어떤 것도 "새로 찾은 버그"가 아니다(형섭이 이 구분을 확인함 — 진짜 버그 7건은 이미 `out/triage_report.md`에 보고 완료된 상태로 그대로 둠).
- verifier: **조건부 pass**(1차 — combiner 코드 6가지 전부 타당, combos.csv 165건 변경 diff 정확, 6개 카테고리 대표 케이스 `as`로 재현 성공, 회귀 없음. 단 combiner 에이전트가 VSCATTERDPD ymm/zmm 2건(combo 7035/7036) 잔여 실패를 "tokens.csv 추출 오류"로 잘못 진단한 것을 verifier가 SDM PDF(p.2202 vs p.1824) 직접 대조로 반박 — 실제로는 SDM 원문 자체가 GATHER/SCATTER 사이에 vm32x/vm32y로 비대칭 표기돼 있어서 combiner 스코프 문제가 아니라 진짜 SDM-vs-as 불일치 후보) → triage 에이전트가 이 2건을 `ERROR_COMBO_OVERRIDES`에 추가해 새 카테고리 `sdm_gather_scatter_vsib_width_asymmetry`(verdict=unsure, 오탈자인지 의도인지는 형섭이 SDM 정오표로 직접 확인 필요)로 재분류 → **최종 pass**(bug 7건 회귀 없음, 옛 combiner 카테고리 6개 전부 0건으로 소멸, mov/add/push 정답지 21줄 전수 재확인, m1/m2/m4/m5/m6 코드 미변경, 전체 수치 정합성 재계산 일치).
- 결과: triage 전체 대상 1630건 → **1585건**(combiner가 고친 만큼 대상에서 빠짐). verdict 분포 `bug=7(그대로), false_alarm=1552, unsure=26`(구 unsure 중 41건 오분류 수정분은 이전 라운드에 이미 반영됐고, 이번엔 VSCATTERDPD 2건이 새로 unsure에 추가).
- 남은 것: VSCATTERDPD ymm/zmm 표기가 SDM 오탈자인지 GNU as 미구현인지 Intel 공식 정오표로 형섭이 직접 확인. `tests/test_modules.py`(정식 회귀 테스트 하네스)는 여전히 부재.

## 2026-07-24  [tests]  manual_bug_check.py를 combiner 수정 이후 상태로 갱신
- 무엇을: `tests/manual_bug_check.py`의 [A] combiner 6건 케이스를 "수정 전(`broken_line`, 역사적 기록) vs 수정 후(`fixed_line`, `data/db/combos.csv`에서 다시 조회한 실제 현재 값)"를 나란히 어셈블해서 비교하도록 갱신했다. `show_code_evidence()`도 `FAR_PTR_ATOM_RE`가 `MEM_SIZE_RE`보다 먼저 가로채는 것과 moffs가 이제 괄호를 붙이는 것을 보여주도록 갱신. 요약 출력도 [B](진짜 버그, 아직 재현되는지)와 [A](combiner 수정, fixed_line이 성공하는지)를 분리해서 표시.
- 왜: combiner를 고친 뒤 스크립트를 그대로 재실행하면 예전에 하드코딩해둔 `broken_line`만 여전히 실패로 보여서, 마치 아무것도 안 고쳐진 것처럼 오해할 수 있었다. 지금 combiner가 실제로 무엇을 만들어내는지(`fixed_line`)까지 같이 보여줘야 "수정이 실제로 반영됐다"를 형섭이 직접 확인할 수 있다.
- 확인: 재실행 결과 [B] 진짜 버그 후보 7/7건 여전히 재현(안 고침, 의도된 상태), [A] combiner 수정 6/6건 `fixed_line`이 전부 `as` 성공(수정 확인).

## 2026-08-24  [setup]  로컬 파일 유실 후 GitHub에서 재클론 + 8회 미팅 후속 과제 착수
- 무엇을: 로컬 파일이 날아가서 `https://github.com/simhyeongseop/2026-intel-instruction-analysis`에서 재클론. 커밋된 `pipeline/`, `data/db/*.csv`, `tests/`, `docs/`는 전부 정상 복구됨. 단 `.gitignore`에 걸려 한 번도 커밋 안 됐던 두 가지는 복구가 안 됨: (1) `.claude/agents/*.md`(모듈별 에이전트 지침) + `/run-pipeline` 커맨드 — CLAUDE.md 3절 설계와 이전 DEVLOG 기록(특히 roundtrip.md의 낡은 설명을 바로잡은 기록 등)을 근거로 8개 파일을 다시 작성. (2) `out/`(4~7단계 산출물) — WSL Ubuntu(as 2.42/objdump/clang 18.1.3/gcc 설치되어 있음)에서 `python3 pipeline/run.py generator` 재실행으로 복구.
- 왜: 형섭이 이어서 작업할 수 있어야 하는데 두 디렉터리가 로컬에만 있었어서 유실됨. `.claude/agents`는 원문 내용을 기억할 방법이 없어 CLAUDE.md/DEVLOG 근거로 재작성했고(형섭의 검토가 필요), `out/`은 재생성 가능한 산출물이라 코드 그대로 다시 돌렸다.
- verifier: **pass** — 재생성된 `out/roundtrip.csv`(same 5,706 / different 1,456), `out/triage.csv`(bug 7 / false_alarm 1,552 / unsure 26)가 8회 미팅 PPT 초안(`docs/MEETING_NOTES/8회_미팅_PPT_초안.md`)에 기록된 수치와 정확히 일치함을 확인.
- 8회 미팅(교수님) 후속 과제 5가지를 확인함 — Clang 확장 비교, objdump 디스어셈블 결과가 의도한 대로인지 검증(단순 컴파일 성공 여부 이상), 절대주소/주소체계 테스트(`-fno-pie`, 고정주소, 32비트 vs 64비트 reg/mem, 함수주소+garbage value), N.E. 등 이상 케이스의 실제 CPU 동작 검증, 테스트 커버리지 수치 + GitHub 정리(8월 중 마무리). 최종적으로 학회/스터디 활동보고서(활동 내용 400자 + 활동 성과 400자)도 작성 필요.
- 이번 라운드부터 검증 방식 변경: 형섭 지시로 verifier 역할을 codex(OpenAI Codex CLI, 로그인 확인됨)가 대신한다 — Claude가 구현, codex가 독립적으로 재검증(코드 리뷰+재현+모순 지적)하는 구조로 CLAUDE.md 4절 "개발하는 애 + 검증하는 애"를 갱신.
- 남은 것: 위 5가지 후속 과제를 순서대로 진행(1. Clang 비교부터). `.claude/agents/*.md`는 재작성본이라 형섭이 한 번 검토할 것.

## 2026-08-25  [clang_assemble/clang_compare]  Stage 8~9 구현 — Clang 비교(8회 후속 과제 1번) + 기존 버그 2건 오판정 발견·정정
- 무엇을: `pipeline/m8_clang_assemble.py`(8단계, `out/tests.s`를 clang 통합 어셈블러로 한 줄씩 개별 어셈블 → `out/clang_result.csv`)와 `pipeline/m9_clang_compare.py`(9단계, as vs clang을 combo_id로 대조 → `out/clang_compare.csv`/`out/clang_compare_report.md`)를 새로 작성. `.claude/agents/clang_assemble.md`/`clang_compare.md`도 추가. `pipeline/run.py`의 STAGES에 두 단계 등록.
- 왜: 8회 미팅 후속 과제 1번(Clang 확장 비교) 착수. as 단독 판정으로는 "as의 버그인지 SDM 해석의 문제인지" 구분이 안 되던 것을, 독립된 두 번째 어셈블러(clang)와 대조해서 교차검증하기 위함.
- verifier(codex, 5라운드): 1차 fail(m9가 objdump 텍스트만 비교해서 같은 텍스트인데 바이트가 다른 경우를 놓침 — 바이트 비교로 재작성, both_ok_diff_bytes 18건→48건으로 증가) → 2차 fail(MOV Sreg 3건을 "REX.W 누락 버그"로 과장 — 실제로는 Sreg→GPR은 zero-extension, GPR→Sreg는 하위16비트만 사용이라 실행 결과 동일, "인코딩 표현 차이"로 격하) → 3차 fail(**CALL/JMP dword ptr [eax] 재해석 필요성 지적** — ModRM 직접 디코딩 결과 reg=3/5로 far call/jmp이지 근접 N.E./N.S. 폼이 아님을 codex가 지적) → 4차 fail(정밀도: dword=far m16:16(4바이트) 대응 관계가 거꾸로 적힘, JMP는 N.E.가 아니라 N.S., mov ds,cx 차이는 REX.W 아니라 0x66 프리픽스) → **5차 pass**.
- **중요한 발견(기존 결과 정정):** codex 3차 검증에서 지적받아 ModRM 바이트(0x18, 0x28)를 직접 비트 단위로 디코딩하고 `data/db/isa_db.csv`의 CALL/JMP 오피코드 표(FF /2·/4=근접, N.E./N.S. / FF /3·/5=원거리, Valid)와 대조한 결과, **2026-07-24에 "진짜 버그 7건" 중 하나로 이미 확정해 8회 미팅 PPT까지 작성했던 `CALL r/m32`/`JMP r/m32`(combo 419/1436) 항목이 오판정이었음을 확인**. `as`가 실제로 인코딩한 건 SDM이 금지한 근접 호출이 아니라 SDM이 명시적으로 허용하는 원거리 호출(FF /3, m16:16 — 소스의 "dword ptr" 크기 표기와 정확히 일치)이었다. objdump 역어셈블 텍스트("call DWORD PTR [eax]")만 보고 "근접 호출처럼 보인다"고 넘겨짚은 게 원래 오판정의 원인 — ModRM reg 필드를 실제로 디코딩하지 않았던 것. `pipeline/m7_triage.py`의 해당 override를 `bug`→`false_alarm`(카테고리명 `ambiguous_syntax_resolved_to_valid_far_form`)으로 수정, `docs/MEETING_NOTES/8회_미팅_PPT_초안.md`에도 정정 안내를 추가.
- 결과: `out/clang_compare.csv`(7,276건) — `both_ok_same_bytes` 7,058 / `both_ok_diff_bytes` 48 / `as_only` 56(대부분 clang이 MPX bnd* 니모닉 자체를 모름) / `clang_only` 18 / `both_reject` 96 / `parse_error` 0. `out/triage.csv` 재생성 후 **verdict 분포 bug=5(7에서 감소)**, false_alarm=1554, unsure=26. 남은 진짜 버그 5건: LAR r32,r64 / LSL r64,r32(as가 SDM이 명시한 문법 자체를 거부, clang은 받아줌 — clang으로 교차 확인됨), MOV Sreg,r/m64 메모리형(as/clang 둘 다 거부라 교차 확인은 안 됨, as 단독 관찰로 유지), UDB, VPMOVQD.
- 부수 발견(clang 쪽 결함 후보, as 버그 집계엔 미포함): `mov cx, ds`를 clang이 `mov ecx, ds`로 확대 인코딩 — 이건 zero-extension 무해 케이스와 달리 RCX 상위 32비트를 실제로 지워버리는 실행 의미 차이가 있음(`out/clang_compare_evidence_raw.md`에 기록).
- 근거 파일: `out/clang_compare_evidence_raw.md`(ModRM 디코딩 등 원시 증거 전체, codex 5라운드 지적사항 전부 반영해 정정됨).
- 남은 것: 8회 후속 과제 2번(objdump 검증 심화)으로 진행. `out/`이 OneDrive 동기화 폴더 안에 있어 objdump가 수천 개 파일을 읽을 때 I/O 경합으로 심하게 느려짐(이번 라운드에서 fork 에이전트가 10시간 멈춘 원인으로 추정) — 형섭에게 저장소를 OneDrive 밖(예: WSL 홈)으로 옮길지 문의함, 아직 답 없음.

## 2026-08-25  [reassemble_check]  Stage 10 구현 — 바이트 라운드트립 검증(8회 후속 과제 2번) + objdump 자체 표시 결함 3건 신규 발견
- 무엇을: `pipeline/m10_reassemble_check.py`(10단계) 작성. `out/roundtrip.csv`의 `different` 1,456건 전부에 대해 objdump가 보여준 역어셈블 텍스트를 다시 GNU as로 어셈블해서 원본과 바이트가 실제로 같은지 확인 → `out/reassemble_check.csv`/`out/reassemble_check_report.md`. `.claude/agents/reassemble_check.md` 추가, `pipeline/run.py`에 `reassemble_check` 단계 등록.
- 왜: 8회 미팅 후속 과제 2번(교수님 피드백: "컴파일 성공 여부만 보지 말고 실제로 의도한 대로 변환됐는지 검증하라"). 기존 triage(7단계)는 "different"를 텍스트 패턴 매칭 + 사람 판단으로 false_alarm/bug/unsure를 나눴는데, 이걸 "다시 어셈블해서 바이트가 같은가"라는 도구 기반 잣대로 1,456건 전체에 자동으로 재확인하는 게 목적. Stage 8/9(clang 비교)에서 텍스트만 보고 판단하다 CALL/JMP를 오판정했던 전례가 이 단계를 만든 직접적 동기.
- verifier(codex, 8라운드): 1차 fail(카테고리 판정 조건 자체는 맞으나, PREFETCHIT0/1을 "objdump가 니모닉을 못 알아본다"는 새 버그로 잘못 주장 — SDM은 PREFETCHIT0/1이 RIP-relative 주소가 아니면 NOP로 동작한다고 명시하고, 이미 `out/triage_report.md`에 정확히 그 이유로 false_alarm 기록까지 돼 있었음. 실수를 인정하고 완전히 철회) → 이후 4라운드는 정밀도 문제(relative-target 재어셈블 실패 원인이 "short/near 선택"이 아니라 "relocation" 문제라는 정정, VGATHER "undefined behavior"를 "#UD 예외"로 정정, LSS/LFS/LGS가 실제로는 이미 `unsure`로 기록돼 있었다는 사실관계 정정, 실제 에러 메시지 인용 정확도, 코드 주석에 남아있던 옛 표현 등) → 도중에 `pipeline/m7_triage.py`에 추가한 override 튜플 순서를 `(category,verdict,cause)`로 잘못 써서 verdict 집계가 깨지는 코드 버그를 직접 냄 → `(category,cause,verdict)`로 수정 후 재확인 → **8차 pass**.
- 결과: `out/reassemble_check.csv`(1,456건) — `byte_roundtrip_same` 1,326(triage의 false_alarm 판정을 도구로 재확인) / `byte_roundtrip_diff` 5(개별 확인함) / `relative_target_reassembly_artifact` 99(라벨→절대주소 재어셈블 시 relocation 발생, 이 검증 방법 자체의 한계로 별도 분류) / `reassemble_failed` 26(objdump 텍스트를 그대로 재어셈블 못 함 — JECXZ/LOOP 계열은 위와 같은 이유, VGATHER 계열은 combiner의 기존 레지스터 재사용 한계, 그 외는 원인 미상으로 기록).
- **신규 발견(objdump 자체의 디스어셈블 표시 결함, `as`의 버그 아님):** `LSS/LFS/LGS`의 REX.W(64비트, r64 목적지) 형태를 `as`는 SDM 그대로 정확히 인코딩(`67 48 0f b2 08` 등)하는데, `objdump`가 메모리 오퍼랜드 크기를 REX.W 유무와 무관하게 항상 `FWORD PTR`(6바이트, m16:32 크기)로 표시한다 — SDM상 m16:64는 10바이트라 `TBYTE PTR`이어야 한다. 그 표시 텍스트를 그대로 재어셈블하면 `as`가 `"incorrect register 'rcx' used with 'l' suffix"`로 거부하는 게 간접 증거(`as` 자신은 rcx엔 FWORD가 아니라 TBYTE가 맞다는 걸 알고 있음). combo 1527/1532/1535는 원래 `register_width/name_changed` 카테고리에 `verdict=unsure`(판단보류)로 올라가 있었는데, 이번에 원인을 확정해 `pipeline/m7_triage.py`에 전용 override(`objdump_farptr_size_ignores_rexw`)를 추가하고 `unsure`→`bug`로 갱신했다.
- 결과 반영: `out/triage.csv`/`out/triage_report.md` 재생성 후 **verdict 분포 bug=8(5에서 증가), false_alarm=1554, unsure=23(26에서 감소)**. 단, 이 3건은 "SDM vs `as`" 불일치가 아니라 "SDM vs `objdump`" 불일치라 성격이 다르다는 걸 `out/reassemble_check_evidence.md`와 triage 근거 텍스트에 명시해뒀다 — 8회 PPT의 "진짜 버그 7→5건"과는 별도 집계로 볼 것(향후 최종 보고서 작성 시 "as 버그"와 "objdump 버그"를 구분해서 제시할 것).
- 교훈: 이번에도(Stage 8/9의 CALL/JMP처럼) "겉보기에 이상한 것"을 새 버그로 성급히 주장하기 전에 `out/triage_report.md`를 먼저 검색해야 한다는 게 재확인됨(PREFETCHIT0/1 삽질). codex 교차검증이 없었으면 이 오류가 그대로 보고서에 남았을 것.
- 근거 파일: `out/reassemble_check_evidence.md`(전체 검증 과정과 정정 이력 포함).
- 남은 것: 8회 후속 과제 3번(절대주소/주소체계 테스트)으로 진행. 이게 가장 큰 작업이 될 것으로 예상(-fno-pie 링크, 32비트 vs 64비트 reg/mem 뮤테이션, 함수주소+garbage value 테스트 - 새 생성 축과 실제 실행 인프라 필요). OneDrive 이전 여부 형섭 답변 대기 중 — 답 없으면 이대로 진행.

## 2026-08-25  [execute]  Stage 11 구현 — 절대주소/주소체계 실행 검증(8회 후속 과제 3번) 첫 배치
- 무엇을: `pipeline/m11_execute.py`(11단계) 작성. 형섭 승인(격리된 자식 프로세스 + 타임아웃)에 따라, GNU as/ld로 고정 주소(`-Ttext=0x400000`)에 실제 ELF 실행파일을 만들고 `subprocess.run(..., timeout=N)`으로 격리 실행해서 종료코드/시그널을 관찰하는 방식. POSIX에서 `returncode`가 음수면 그 절댓값이 시그널 번호라는 성질만으로 정상종료/크래시를 구분(ptrace 등 불필요). `.claude/agents/execute.md` 추가, `pipeline/run.py`에 `execute` 단계 등록. 손으로 설계한 6개 시나리오(combos.csv 자동생성 아님, CLAUDE.md "소규모 정답지" 정신):
  1. `call_valid_function_ptr_64bit` (대조군, exit0)
  2. `call_garbage_upper32_64bit` (주소 상위32비트에 쓰레기 값 → SIGSEGV)
  3. `call_via_32bit_register_truncated` (32비트 레지스터로 저주소를 다뤄도 exit0 — 이 로드주소 배치에서는 결정적)
  4. `truncate_high_stack_address_to_32bit` (스택의 고주소를 32비트로 자르면 → SIGSEGV, 진짜 32비트 vs 64비트 truncation 위험 시연)
  5. `jmp_null_address` (널 주소 → SIGSEGV)
  6. `call_misaligned_valid_range_address` (유효 함수 끝+1바이트로 call → SIGSEGV)
- 왜: 8회 후속 과제 3번. 지금까지(1~10단계)는 "어셈블/역어셈블이 되는가"만 봤는데, 교수님 요청은 "레지스터에 실제 함수 주소를 넣고 호출 + 주소 일부에 쓰레기 값을 넣어 동작 변화 확인", "32비트 vs 64비트 표현이 스펙대로 뮤테이션·테스트되는지" — 실제 실행이 필요.
- verifier(codex, **7라운드**, 이번 태스크 중 가장 많은 라운드): 매 라운드 "실행 결과는 맞는데 설명(메커니즘)이 부정확"하다는 지적이 반복됨 — 이 프로젝트 검증 기준이 "결과가 맞다"가 아니라 "왜 그런지 설명까지 정확해야 한다"는 걸 보여주는 사례.
  - 1차 fail: 2번 케이스 결과는 맞지만 근본 메커니즘 오류(단순 "매핑 안 된 주소"가 아니라 non-canonical address → #GP fault, #PF 아님). 3번은 "우연히" exit0이 아니라 이 로드주소 배치에선 결정적. 5번은 "objdump -s로 확인, W^X 보호"가 과장(objdump -s는 런타임 zero-fill을 증명 못 함, "W^X"도 잘못된 용어 - 그냥 세그먼트에 W 플래그가 없는 것뿐).
  - 2~3차 fail: canonical 경계가 4-level(47비트)/5-level(56비트) paging에 따라 다름을 명시 안 함. truncate 케이스 추가했으나 ASLR 때문에 "결정적"이라는 표현이 과장 → `setarch x86_64 -R`로 ASLR을 꺼서 재현 가능하게 수정.
  - 4~5차 fail: 예시로 든 구체적 주소(0xDEADBEEF00000015)가 실제 이 케이스의 주소와 안 맞음(단순 오타/불일치) → 구체적 숫자 제거. "이 실행파일만 매핑돼 있다"는 표현도 부정확(스택 자신, vdso/vvar도 매핑됨) → 정정.
  - 6차 fail: 매핑 공백이 있다는 주장 자체를 추측이 아니라 **실측**하라는 요구 → 별도 테스트 바이너리를 만들어 `open+read+write` 시스템콜로 자기 자신의 `/proc/self/maps`를 직접 찍어서 확인(`setarch x86_64 -R` 적용 상태) - 실제로 낮은 주소엔 `0x3ff000-0x402000`(ELF헤더+.text+.bss)만 있고 다음 매핑은 `0x7ffff7ff7000`대(vvar/vdso)와 `0x7ffffffde000-0x7ffffffff000`(스택)로 건너뛰는 거대한 미매핑 공백을 확인. 이 실측 중 16진수 자릿수를 잘못 계산(`0xffffde00`이라고 썼는데 실제론 `0xfffde000`)한 걸 또 지적받아 정정.
  - 7차: **pass**.
- 결과: `out/address_test_result.csv` — 6/6 케이스 전부 예측과 일치. 실제로 실행해서 관찰한 결과이므로 "SDM/OS 메모리 모델대로 동작하는지"를 도구(커널의 시그널 전달)로 직접 확인한 것.
- 남은 것: 이번 라운드는 첫 배치(6개 시나리오)만 다뤘다. 교수님이 요청한 것 중 아직 다루지 않은 부분: (1) 32비트 vs 64비트 **레지스터/메모리 표현**을 SDM 오퍼랜드 형식 표대로 폭넓게 대조하는 체계적 테스트(지금은 6개 손으로 만든 시나리오뿐), (2) `-fno-pie`를 명시적으로 켠 컴파일 비교(지금은 링커 옵션으로 고정 주소만 흉내냄, 실제 `-fno-pie`/`-fpie` 차이 비교는 아직 안 함). 다음 라운드에서 확장할지, 8회 후속 과제 4번(N.E. 케이스 실제 CPU 실행)으로 먼저 넘어갈지는 형섭과 상의.
- 근거 파일: `pipeline/m11_execute.py`(note 필드에 각 케이스의 검증 과정과 정정 이력 전부 기록됨).

## 2026-08-25  [execute_edge_cases]  Stage 12 구현 — N.E./N.S./Invalid 케이스 자동 실행 도구(8회 후속 과제 4번) + 이 프로젝트의 핵심 방법론적 결함 재확인
- 무엇을: `pipeline/m12_execute_edge_cases.py`(12단계) 작성. 11단계와 달리 손으로 만든 시나리오가 아니라 **파이프라인이 이미 만든 데이터에서 자동으로 대상을 고르는 도구**다 — `out/asm_result.csv`에서 `expected_valid=False`(SDM: Invalid/N.E./N.S.)인데 `actual_result=ok`(`as`가 실제로 어셈블 성공)인 케이스 중 상대분기(`.Ltarget`) 계열(실행해봐야 정보가 없음, 10단계에서 이미 확인)을 뺀 19건을 골라, 11단계와 같은 안전 원칙(고정주소 링크 + 격리된 자식 프로세스 + 타임아웃)으로 실제 실행해서 종료코드/시그널을 관찰한다.
- 왜: 형섭 요청("계속 진행하고 최종적으로는 이걸 확인하는 도구를 만들어야해") — 손으로 만든 몇 개 시나리오가 아니라, 파이프라인이 자동으로 찾아낸 "SDM이 안 된다는데 as가 받아준" 모든 케이스를 체계적으로 실행 검증하는 재사용 가능한 도구가 필요했다.
- verifier(codex, **9라운드**): 결과(exit0 14건, SIGSEGV 5건) 자체는 1차부터 안 바뀌었지만, "왜 그런 결과가 나왔는지"에 대한 설명이 계속 지적받음 — 이 프로젝트에서 가장 많은 라운드가 걸린 검증.
  - 핵심 지적(1차): BNDCL의 r/m32 vs r/m64를 "주소 계산에 쓴 레지스터 폭 차이(rax를 써서 r/m64가 됐다)"로 잘못 설명 → 정정: 이건 LEAVE(사례2)와 같은 유형으로, MPX가 활성화된 64비트 모드에서는 애초에 r/m32 폼을 실행할 방법 자체가 없다. exit0의 진짜 원인도 "BND0 초기값이라 경계위반 안 남"이 아니라 직접 `/proc/cpuinfo`를 확인해서 **이 WSL 커널/CPU가 MPX를 아예 지원 안 함**(mpx 플래그 0건)을 실측 확인 → SDM 명시대로 MPX 미지원 시 모든 BND* 명령은 오퍼랜드 무관 무조건 NOP.
  - 이후 7라운드는 정밀도 문제 반복: 초기화 안 된 레지스터 값(eax/rbp)을 "0이다"/"유효하지 않다"로 단정하지 말고 매번 "레지스터 덤프를 안 해서 정확한 값은 모름, 유효하다고 보장되지 않을 뿐"으로 표현할 것(레지스터를 직접 안 찍어봤으면서 단정하면 안 된다는 원칙이 6~7차례 반복 지적됨 — 이 프로젝트가 "판정은 도구로 재현"을 얼마나 엄격하게 요구하는지 보여주는 사례), 필터 설명 과장 정정, 출처 오기(POP fs/gs 설명이 triage_report.md가 아니라 clang_compare_evidence_raw.md에 있음) 정정, `as`/`ld` 자체의 타임아웃 미처리 코드 버그 수정.
  - 9차: **pass**.
- **핵심 발견 — 이 프로젝트 전체에 적용되는 방법론적 결함 재확인**: DEC/INC r16·r32, LEAVE, LGDT/LIDT, BNDCL/BNDMOV까지 **5개 니모닉 그룹**에서 Stage 8/9(Task 1)의 CALL/JMP와 **동일한 근본 원인**을 재확인했다 — SDM이 같은 니모닉+오퍼랜드 텍스트를 레지스터/주소 폭이 다른 여러 표 행으로 나눠 문서화하는데, 그 폭 차이가 Intel 문법만으로는 구분이 안 돼서 combiner가 "N.E. 행을 테스트하려 했는데 `as`가 다른 유효한 행으로 인코딩해버리는" 상황이 반복된다. 실제 인코딩(objdump 확인): DEC cx/ecx는 단일바이트 N.E. 폼이 아니라 `FF /1` Valid 폼, LEAVE는 32비트 N.E. 행 자체가 어떤 Intel 문법으로도 선택 불가능한 표 행, LGDT/LIDT의 SIGSEGV는 N.E.와 무관하게 특권 명령어라서(ring 3에서 #GP), BNDCL/BNDMOV는 MPX 자체가 이 하드웨어에서 미지원이라 무조건 NOP.
- 결과: CALL/JMP(Task 1)까지 포함해 **총 6개 니모닉 그룹**이 같은 유형의 오탐으로 확인됨 — 8회 미팅에서 확정 보고했던 "진짜 버그 7건" 중 2건(CALL/JMP)이 정확히 이 문제였다는 게 다시 한번 뒷받침됨. 남은 5건(LAR/LSL/MOV Sreg-메모리형/UDB/VPMOVQD)은 방향이 반대(SDM이 **허용**하는 문법을 `as`가 **거부**)라 이 편향의 영향을 받지 않으므로 그대로 유지.
- 근거 파일: `out/edge_case_execution.csv`, `out/edge_case_execution_report.md`, `out/edge_case_execution_evidence.md`(정정 이력 전부 포함).
- 남은 것: 8회 후속 과제 5번(커버리지 수치 + GitHub 정리, 8월 중 마무리)만 남음. Task 3(절대주소)도 32/64비트 레지스터 표현의 체계적 대조나 명시적 `-fno-pie` 컴파일 비교까지는 아직 확장 안 함 — 필요성은 형섭과 상의.

## 2026-09-03  [triage]  9회 보고서 "확정 버그 8건" 재검토 — codex + 최신 clang 19/20 교차검증으로 4건 하향(bug 8→4)
- 무엇을: 형섭 요청("테스트 케이스를 만들 때 메모리·레지스터가 매뉴얼 기준에 안 맞는 경우가 있는 것 같다, codex 동원해서 재검토해달라, 검증 환경은 최신 우분투/clang, 병렬 에이전트로")로 9회 보고서(`docs/MEETING_NOTES/9회_미팅_보고서.md`)의 "확정 버그 8건"을 전부 재검토했다. 시스템 clang은 18.1.3 고정(WSL에 sudo 비밀번호가 없어 apt install 불가)이라, `apt-get download`(root 불필요)로 clang-19(19.1.1)/clang-20(20.1.2) .deb를 받아 `dpkg-deb -x`로 스크래치 디렉터리에 풀고 `LD_LIBRARY_PATH`만 맞춰서 시스템 설치 없이 최신 clang 2종을 추가로 확보했다(llvm-objdump-20도 같은 방식으로 확보했으나 Intel 크기 접두어를 표시 안 해서 LSS/LFS/LGS 건의 교차검증에는 못 씀). PDF 원문 직접 대조용으로 `python3 -m venv`+`pip install pdfplumber`도 스크래치에 재구성.
- 왜: 8월 중단됐던 재검토 세션(이전 세션 13241098...)을 이어받아 진행. CLAUDE.md 7절 "LLM 판단만으로 버그라고 결론짓지 않는다"는 원칙을 따라, codex 교차검증 + PDF 문자 단위(폰트크기) 재추출 + as/clang 4종 바이트 레벨 재현으로 기존 판정을 다시 검증했다.
- 재검토 결과(4건 verdict 변경, `pipeline/m7_triage.py`의 `ERROR_COMBO_OVERRIDES` 수정 후 `python3 pipeline/m7_triage.py` 재실행):
  - **VPMOVQD(combo 6540): bug→false_alarm.** SDM p.2054 오피코드 표에서 VPMOVQD EVEX.128 행만 'xmm1/m128'로 잘못 적혀있음(형제 명령어 VPMOVSQD/VPMOVUSQD의 EVEX.128 행은 둘 다 정확히 'xmm1/m64', Description·Operation pseudocode도 64비트). as/clang 18/19/20 넷 다 qword ptr만 성공 — SDM 표 오탈자.
  - **LAR(combo 1516)/LSL(combo 1571): bug→false_alarm.** PDF 문자 단위 폰트크기 분석으로 각주 위치를 정밀 확인한 결과 LAR의 각주 '1'은 실제로 2번째 행(r32,r32/m16)에 붙어있고 3번째 행(REX.W 행)엔 원래 각주가 없었다(isa_db.csv가 각주를 3번째 행 끝에 잘못 붙여 'r64/m161'로 저장한 추출 오류). 더 결정적으로, `lar ecx,rcx`(SDM 문자 그대로 dest=r32/source=r64)를 clang에 줘도 실제 인코딩은 REX.W 없는 `0f 02 c9`(`lar ecx,ecx`로 조용히 축소) — clang도 SDM 표 그대로의 비대칭 폼을 만들지 않는다. 대칭 폼(`lar rcx,rcx`)은 clang이 REX.W로 정확히 인코딩하는데 as는 AT&T `larq %rcx,%rcx`까지 포함해 어떤 문법으로도 REX.W를 안 만든다. REX.W 하나로 두 GPR 오퍼랜드 폭을 독립 지정할 수 없다는 인코딩 구조상, SDM 표의 비대칭 표기(LAR r32,r64/m16 / LSL r64,r32/m16)는 CALL/JMP·DEC/INC·LEAVE·LGDT/LIDT·BNDCL에 이은 **7번째 "문법으로 구분 안 되는 SDM 표 행" 오탐 사례**로 판단.
  - **MOV Sreg,r/m64 메모리형(combo 1683): bug→unsure.** clang 18/19/20도 as와 동일하게 `mov ds, qword ptr [eax]`를 거부함을 새로 확인(word ptr만 성공, 4개 어셈블러 일치) — "as만 매뉴얼보다 엄격하다"는 원래 근거가 약해졌다. 다만 LAR/LSL/VPMOVQD처럼 SDM 내부 모순(각주 오귀속, 형제행 비교 등)의 결정적 증거는 없고 codex도 "clang 3버전은 전부 LLVM이라 독립성이 약하다, 실기 페이지경계 실험 전까진 unsure가 안전"이라고 권고해 false_alarm까지는 안 내리고 unsure로만 낮췄다.
  - **유지(CONFIRMED)**: UDB(codex도 SDM 원문 재확인 후 동의), LSS/LFS/LGS의 objdump FWORD/TBYTE 표시 결함 3건(SDM p.658 Description이 "80-bit pointer"라고 숫자로 명시해 해석 여지 없음, codex도 동의).
- **신규 발견(별도 combo 없음, 다음 라운드 후보)**: `as`는 LAR/LSL에 REX.W 폼 자체를(대칭 `lar rcx,rcx`/`lsl rcx,rcx`까지 포함, AT&T `larq`/`lslq` 접미사로도) 전혀 구현하지 않는다 — clang은 대칭 폼에서 REX.W를 정확히 만들어서, 이건 as만의 진짜 한계일 가능성이 있다. 지금 combos.csv엔 이 대칭 폼을 테스트하는 combo가 없어서 이번 라운드에선 판정하지 않고 기록만 남김 — combiner에 `lar rcx,rcx`/`lsl rcx,rcx` 케이스를 추가해서 다음 라운드에 정식 판정할 것.
- verdict 분포 변화: **bug 8→4**(UDB + LSS/LFS/LGS만 남음), false_alarm 1554→1557, unsure 23→24.
- verifier: codex(과제별 1~3라운드, VPMOVQD/LAR·LSL/MOV Sreg/LSS·LFS·LGS/UDB 총 5개 사안마다 개별 실행) + `@agent-verifier`(pipeline/m7_triage.py 문법·override 일관성·CSV 재생성 결과 검증) 병행 확인.
- 남은 것: LAR/LSL 대칭 REX.W 폼(`lar rcx,rcx` 등)을 combiner/generator에 추가해서 "as가 REX.W LAR/LSL을 아예 구현 안 함" 신규 발견을 정식 combo로 확정. 9회 보고서(`docs/MEETING_NOTES/9회_미팅_보고서.md`) section 5의 "최종 확정 버그 8건" 표도 4건 기준으로 갱신 필요.

### 후속: LAR/LSL 판정을 두고 fork 2개가 정반대로 결론 — 형섭(오케스트레이터)이 직접 재현해서 해소
위 재검토는 4개 영역(LAR/LSL, MOV Sreg, VPMOVQD, LSS/LFS/LGS)을 각각 독립 fork에 병렬로 맡겨 진행했는데, LAR/LSL을 맡은 fork는 "bug 유지"(as의 LAR opcode 테이블에 REX.W 인코딩 템플릿 자체가 통째로 빠짐)로, VPMOVQD를 맡은 fork는 (원래 맡은 범위를 넘어 LAR/LSL까지 재검토하며) "false_alarm"(SDM 표의 비대칭 폭 표기 자체가 REX.W 구조상 실현 불가능한 형태)으로 정반대 결론을 냈다. 두 fork의 원시 실험 데이터(as/clang 바이트 결과)는 실제로 일치했고 해석만 갈렸음을 확인한 뒤, 직접 5×3 매트릭스(lar/lsl × {ecx,cx}/{ecx,ecx}/{ecx,rcx}/{rcx,cx}/{rcx,ecx}/{rcx,rcx} × as-2.42/as-2.47(신규 소스빌드)/clang-20)로 재현했다:
- `as`(2.42, 2.47 둘 다 동일)는 어떤 레지스터 이름 조합으로도 `REX.W+0F02(LAR)`/`REX.W+0F03(LSL)` 바이트를 만들지 못한다 — 대칭 폼(`lar rcx,rcx`)조차 `0f 02 c9`(REX 없음)로 조용히 32비트로 축소.
- `clang`은 목적지 레지스터 이름(rcx/ecx)만 보고 REX.W 여부를 결정하고 소스 쪽 이름은 사실상 무시한다(`lar ecx,rcx` → REX 없음 `0f 02 c9`, `lar rcx,ecx` → REX.W 있음 `48 0f 02 c9`) — 즉 ModRM.reg/rm이 레지스터 직접 지정일 때 REX.W 하나로 둘 다 폭이 결정되는 x86 인코딩 구조상, "목적지 r32 + 소스 r64"라는 SDM 표기 자체가 애초에 어떤 어셈블러로도 REX.W 유무만으로 구별되게 인코딩할 수 없다.
- p.651 Description("operand is 64 bits ... zero-extended to 64 bits and loaded into the destination operand")도 실제로는 목적지가 64비트임을 암시해서, 표의 "LAR r32, r64/m16"은 LSL처럼 "LAR r64, r32/m16"이어야 할 SDM 오탈자일 가능성이 높다.
결론: **VPMOVQD 담당 fork의 판정(false_alarm)이 맞았다.** 로컬로 소스 빌드한 최신 binutils **2.47**(`scratchpad/binutils_build`, root 불필요, `./configure --prefix=... && make -j8 && make install`)로도 동일하게 재현해, "구버전 as에서만 나는 문제"가 아님도 함께 확인했다.
- 교훈: fork를 병렬로 돌릴 때 서로 겹치는 영역(LAR/LSL)을 다른 fork가 임의로 재검토하면 상충하는 결론이 나올 수 있다 — 최종 판정은 오케스트레이터가 원시 데이터를 직접 재현해서 확정해야 한다. 또한 fork에게 "파일 수정 금지, 검증만"이라고 명시해도 그 지시를 어기고 triage.csv 등을 직접 고칠 수 있으므로, fork 종료 후 `git diff`로 실제 변경 범위를 항상 확인할 것.
- 부가 조치: LSS/LFS/LGS 담당 fork가 권고한 정밀도 수정("REX.W 유무와 무관하게 항상 FWORD로 오표시" → "REX.W로 승격된 r64 폼에서만 오표시", r16/r32 폼은 정상 표시됨)과 llvm-objdump 비교 증거(같은 바이트를 llvm-objdump는 이 오표기 없이 보여줌 → GNU objdump만의 결함이라는 근거 보강)를 `pipeline/m7_triage.py`/9회 보고서에 반영, `python3 pipeline/m7_triage.py` 재실행(verdict 분포는 bug=4로 불변, 문구만 정밀화).

## 2026-09-14 [연구 기준] 결과의 유효 범위와 버그 판정 기준 정리

- 무엇을: `docs/RESULT_VALIDITY_AND_BUG_CRITERIA.md`에 실험 범위, 수치의 의미, 도구 결함과 지원 차이의 구분, 확정 근거, 현재 사례별 보고 표현을 정리했다. README의 bug 8건을 실제 CSV의 기존 레이블 4건으로 바로잡고 새 보고 기준을 연결했다. CLAUDE.md에도 기준을 연결하고 HANDOFF의 오래된 미커밋 상태에 보충을 달았다.
- 왜: 사용자 요청("이미 얻은 결과가 어떤 범위에서 유효한지와 무엇을 버그로 부를지를 명확히 정리하자"). 매뉴얼 행 생성 비율을 ISA 검증 커버리지로, 바이트 왕복을 원본 의미의 정확성으로, 미지원을 곧바로 구현 버그로 확대하는 일을 막기 위한 정리다.
- 확인: CSV 재집계 결과 조합은 DB 4,210행을 포함하지만 실제 어셈블 입력은 4,209행·7,276개이며, 고유 소스는 6,024개다. 재어셈블 바이트 동일 1,326개를 기존 triage와 연결하면 false_alarm 1,313개와 unsure 13개다. 예상과 실제 수용 여부가 다른 108개는 True/error 56개와 False/ok 52개다.
- 판정: 기존 `bug` 4행은 표시 결함 한 유형의 세 사례(LSS/LFS/LGS, 근거 있음·재심 중)와 니모닉 미지원 한 사례(UDB, 구현 버그 여부 보류)로 나눠 보고한다. 새 기준의 최종 확정 수는 전량 재심 전까지 산정하지 않는다. MOV Sreg와 LAR/LSL의 별도 인코딩 후보도 미결 범위를 명시했다.
- 검증 범위: 저장된 CSV·코드·증거 문서 대조, 수치·파일 해시 재계산, Markdown 로컬 링크와 diff 검사. 전체 파이프라인·CPU 실험·SDM 개별 사안 재검증은 하지 않았다. 별도 verifier 에이전트를 실행한 작업이 아니다.
- 남은 것: `spec.md`의 세 사안 재심, LAR/LSL 명확한 r64 소스의 별도 사례화, 새 기준의 판정 필드 반영. 이번에는 판정 코드·CSV·린터를 수정하지 않았다.

## 2026-09-14 [도구·정리] 현재 파이프라인과 입력 검사 도구 완성

- `pipeline/instruction_check.py`, `pipeline/operand_forms.py`, `scripts/asm_linter.py`를 추가해 한 줄 또는 파일 단위로 매뉴얼 후보, GNU/Clang 조립, 실제 바이트, `objdump` 표기, 재조립 결과를 한 번에 확인하도록 했다. 검사 결과는 text/JSON/JSONL로 출력하며, 분석하지 못한 입력은 `incomplete`로 보존한다.
- `pipeline/m13_lint.py`를 13번째 단계로 등록해 기존 조합 7,276개와 보충 사례 7개를 일괄 검사했다. 현재 결과는 `accepted` 4,401, `needs_review` 2,763, `rejected` 116, `incomplete` 3이며 상세 원본은 `out/lint/`에 있다.
- `pipeline/review_verdicts.py`와 `m7_triage.py`에 재심 필드(`legacy_*`, `review_status`, `evidence`)를 추가했다. 현재 triage 분포는 `bug` 3, `false_alarm` 1,558, `unsure` 24다. 세 bug 행은 LSS/LFS/LGS의 GNU `objdump` far-pointer 표시 결함 한 유형이다.
- `scripts/review_cases.py`와 `tests/review_cpu_cases.c`로 MOV Sreg, LAR/LSL 등 경계 사례를 재현하고 `out/review/cases.json`에 환경·바이트·실행 결과를 저장했다. WSL에서 CPU 사례는 모두 기대한 결과를 보였다.
- `pipeline/run.py`를 13단계 실행기와 실행 기록(`out/runs/*.json`)을 남기는 형태로 정리했다. 오래된 중간 산출물과 실험 스크립트 63개는 삭제하지 않고 `archive/`에 원본 해시와 함께 이동했다. 현재 사용 순서는 `README.md`와 `docs/PIPELINE.md`를 따른다.
- Ubuntu에서 남은 검증을 재현할 수 있도록 `scripts/run_ubuntu_tests.sh`를 추가했다. 필수 도구·입력 확인, 회귀 테스트, CLI smoke, 재심 CPU, 11~12단계 실행, 13단계 lint와 산출물 검사를 순서대로 수행하고 `out/ubuntu-tests/<UTC timestamp>/summary.txt`에 종료 상태를 기록한다.
- 검증: Windows 테스트 20개 통과·도구 미설치 7개 건너뜀, WSL 테스트 20개 통과. 다음 변경부터는 새 입력을 `data/cases.csv`에 등록하고 13단계 lint와 triage를 함께 재실행한다.
- 최신 Ubuntu 전체 실행(2026-09-14 15:02:11 UTC): `out/ubuntu-tests/20260914T150211Z/summary.txt`의 `failures=0`을 확인했다. 회귀·CLI·재심·CPU 11~12단계·13단계 lint와 manifest 검사가 모두 통과했다.

## 2026-09-15 [문서·정리] 현재 기준 문서 재정렬

- README를 목적, 결과 해석 순서(원본·SDM 행·수용·바이트·objdump·roundtrip·CPU), Ubuntu 실행법, 1~13단계, 주요 산출물, 범위 제한 중심으로 다시 작성했다.
- 실행 기록을 재생성할 때 사용하는 현재 PDF 이름을 활성 `pipeline/m7_triage.py`의 문서·근거 문자열에도 반영했다. triage를 재실행해 분포 `bug=3 / false_alarm=1558 / unsure=24`를 확인했다.
- 회의록은 과거 스냅샷으로 보존하고 [회의록 안내](MEETING_NOTES/README.md)를 추가했다. 마지막 Ubuntu 전체 검증은 [최신 검증 기록](LATEST_TEST_RUN.md)으로 고정해 무시되는 실행 로그에 의존하지 않도록 했다.
- 확인: Markdown 로컬 링크, `git diff --check`, Python compileall, Windows 회귀 테스트 20개를 통과했다. Windows에서는 Linux 도구가 없어 live 테스트 7개를 건너뛰며, 전체 Linux 검증은 2026-09-14 Ubuntu 실행 기록을 기준으로 한다.

## 2026-09-15 [퍼징 연구 감사] 도구의 연구 사용성 비판 검토

- 무엇을: 현재 코드·산출물·회의록·재심 기록을 퍼징 연구에 사용하는 관점에서 다시 검토하고, [비판적 검토와 보완 계획](FUZZING_RESEARCH_REVIEW_2026-09-15.md)과 [감사 원시 결과](../out/review/fuzzing_audit_2026-09-15.json)를 남겼다.
- 핵심 판정: 현재 도구는 명령어·인코딩·역어셈블러 차이를 조사하고 결과를 주석화하는 연구용 프로토타입으로는 유용하다. 자동 통과·폐기 필터 또는 퍼징 효과를 입증하는 도구로 설명하기에는 판정 신뢰성과 연구 효과 측정이 부족하다.
- 확인한 우선 결함: 신호 종료가 일반 `rejected`로 축약됨, 지정 opcode 불일치가 전량 lint의 최종 상태에 반영되지 않음, 검사기 실패를 주입해도 배치가 성공할 수 있음. 대표값 중심 생성, 단일 디코더 의존, 버전·증거 연결, 실행 격리, throughput/precision/recall 측정도 보완 대상으로 분류했다.
- 근거 수치: lint 7,283건 중 `accepted` 4,401·`needs_review` 2,763·`rejected` 116·`incomplete` 3; 생성 입력의 opcode 필드 미검사 5,002건; accepted 중 지정 opcode 불일치 118건; SDM 형태 비교 incomplete 2,688건; triage 미재심 1,578/1,585건.
- 검토 한계: 실제 대상 도구의 새 크래시를 주장한 것이 아니며, 실패 주입은 판정 전달 경로를 확인하기 위한 인위적 실험이다. 전체 PDF 재추출·모든 기존 판정 재심·최신 upstream 버전 비교는 후속 과제다.
- 재현: Ubuntu 루트에서 `python3 docs/review_artifacts/fuzzing_audit_2026-09-15.py`를 실행하면 동일한 감사 항목을 다시 계산할 수 있다.

## 2026-09-19 [생성기 수정 준비] 조합 규칙 수정 범위 확정과 회귀 기대값 고정

- 무엇을: 11회 보고 준비(9/16)에서 진단만 하고 멈춰 있던 생성기 결함을 실제로 고치기 전에,
  수정 범위와 회귀 기대값을 먼저 고정했다. 범위는 [생성기 수정 범위](GENERATOR_FIX_SCOPE_2026-09-19.md)에 있다.
- 범위 결정: `m3_combine.py`·`m4_generate.py`만 수정한다(`m1`/`m2` 제외). 결함 수정에 더해
  고정 시드 변형(SIB·rip 상대·즉시값·마스크·브로드캐스트)을 기존 `combo_index` 뒤에 덧붙인다.
  랜덤 다중 생성은 다음 라운드로 둔다. 예상 규모는 7,278 → 약 20,300행.
- 불변조건 확인: `pipeline/review_verdicts.py`가 combo `1516/1527/1532/1535/1571/1683/4597`의 소스
  문자열까지 고정하고 있어, 값이 바뀌면 `build_triage_rows()`가 `ValueError`로 중단한다.
  해당 행을 수정 대상에서 제외하고, `combo_id`↔`(row_id, combo_index)` 대응 유지를 테스트로 묶었다.
- 기대값 근거: 29개 사례의 before/after를 그 자리에서 as 2.42·Clang 18.1.3에 넣어 수용 여부와
  `.text` 바이트를 기록했다(`scripts/build_fix_expectations.py` → `tests/expectations/generator_fix_expectations.csv`).
  사람이 적은 추측값은 넣지 않았다.
- 조사에서 나온 사실 두 가지:
  - `mov al, [0x1000]`은 as가 **수용**하지만 `8a 04 25`(ModRM)로 가서 moffs 행(A0)을 시험하지 못한다.
    `mov al, ds:0x123456789abcdef0`이라야 `a0 …`가 나온다. 수용 성공이 검증이 아니라는 구체적 사례다.
  - "해당 크기의 최대값"을 그대로 쓰면 의도한 인코딩을 못 때린다. `adc eax, 0xffffffff` → `83 d0 ff`로
    부호확장 imm8 형식으로 줄고, `adc rax, 0xffffffff`는 거부된다. 최대값 변형은 `0x7fffffff`,
    인코딩 타격용은 `0x12345678`로 나눈다.
  - rel16 행 33건은 64비트 모드에서 표현할 수 없다. `data16 call .Ltarget`을 넣어도 as는
    `66 e8 fa ff ff ff`로 4바이트 변위를 낸다. 관측만 기록하고 버그로 주장하지 않는다.
- 검증: `tests/test_generator_fix.py` 11개 중 9개 통과, 2개는 수정 전이라 건너뜀(`FIX_LANDED=False`).
  반례로 combos.csv를 4가지 방식으로 망가뜨려 각각 1~3건씩 실패하는 것을 확인했다(정상 상태 0건).
- 남은 것: 실제 `m3`/`m4` 수정 → `FIX_LANDED=True` → 5~10단계 재실행(현재 `asm_result.csv`는 8/24,
  `tests.s`는 9/15로 버전이 어긋나 있다) → 체크리스트 B그룹 120행 판정 → 결과 수치를 쓰는 문서 갱신.

## 2026-09-19 [생성기 수정] 조합 규칙 결함 수정 + 변형 생성 + 5~10단계 재실행

- 무엇을: 9/16 자체 점검에서 진단만 해두었던 생성 입력 결함을 실제로 고치고, 요청된 생성 규칙
  (rip 상대·SIB·즉시값·마스크·브로드캐스트)을 변형으로 추가한 뒤 5~10단계를 재실행했다.
  범위와 기대값은 [생성기 수정 범위](GENERATOR_FIX_SCOPE_2026-09-19.md)에 고정해 두고 시작했다.
- 코드: `m3_combine.py`(결함 5유형 + 변형 5종), `m4_generate.py`(확인만), `m7_triage.py`(moffs
  오버라이드 제거, 새 표기 분류, 도구 사건 분리), `m5_assemble.py`(crashed/timeout 분리).
- 결과: 생성 입력 7,276 → 19,120줄. as 수용 19,020 / 거부 100. **매뉴얼 Valid 행인데 거부가
  56 → 16건**으로 줄었고, 남은 16건은 전부 기존에 판정·보류된 사례다(우리 입력 결함 0건).
  as·clang 바이트 동일 18,843 / 다름 111. triage `false_alarm 9,449 / unsure 44 / bug 3`.
  rip 상대 0 → 3,432줄, 마스크 사용 64 → 2,993줄.
- 불변조건 유지: 기존 combo_id 7,278개의 `(row_id, combo_index)` 대응이 그대로이고,
  재심 판정이 고정한 7개 사례의 소스 문자열도 그대로다. 새 변형은 전부 기존 인덱스 뒤에 붙였다.
- 검증: 회귀 테스트 57개 통과. 기대값 30건은 사람이 적은 값이 아니라 as·Clang 실행 결과로 채웠고
  (`scripts/build_fix_expectations.py`), 수정 전 스냅샷(`tests/baseline/`)과 대조했다.
  반례 주입(combo_id 이동·재심 사례 변경·무관한 행 변경·행 삭제·변형이 index 0 침범)으로 테스트의
  검출력을 확인했고, 수정 전후 비교에서 **수용 → 거부로 바뀐 줄은 0건**이었다.
- 도중에 발견해 함께 고친 것:
  - 7단계가 새 표기(objdump의 `# 0x17` 주석, 마스크 앞 공백, `QWORD BCST`)를 못 읽어
    `unsure`가 7,046건까지 늘었다. 분류 보완 후 44건. 반례 테스트를 함께 넣었다.
  - 5단계가 `subprocess` 타임아웃 예외를 잡지 않아 한 줄 때문에 단계 전체가 중단될 수 있었다.
    이제 `crashed`/`timeout`을 거부와 구분해 기록하고, 7단계는 이를 `unsure`로 남긴다.
  - 표본 게이트(변형 600건)에서 브로드캐스트 개수 계산과 메모리 목적지 `{z}` 규칙 오류를 잡아
    전체 실행 전에 고쳤다. 브로드캐스트 개수는 목적지 폭이 아니라 매뉴얼 표기에서 계산한다
    (`xmm3/m64/m16bcst` → 64/16 = `{1to4}`). 변환 계열은 목적지 폭으로 계산하면 틀린다.
- 점검 도구 4종을 새로 만들었다(사용자 요청: 과정에 오류가 있는지 직접 확인하고 싶다).
  `scripts/check_pipeline_health.py`(절차·버전 정합), `review_generated_input.py`(생성 입력 확인표),
  `audit_verdicts.py`(판정 근거 재현), `compare_round.py`(수정 전후 차이). 관측만 모아 주고
  판정은 하지 않는다. 실제로 옛 결과 파일 사용과 SENDUIPI 판정의 근거 상실을 이 도구들이 잡았다.
- 확인 범위: 이번 실행은 5~10단계다. `run_ubuntu_tests.sh` 전체 검증(11~13단계·CPU)은 다시 돌리지
  않았다. 수용 성공·바이트 동일을 실행 의미의 확정으로 쓰지 않으며, `unsure 44`와 미재심 행은
  확정으로 보고하지 않는다.
- 남은 것: 전 오퍼랜드 동일 줄 2,179개(오퍼랜드 순서 오류 구분 불가), 체크리스트 1,558행의
  사람 판정, 전체 Ubuntu 재검증.

## 2026-09-20 [생성기 수정 2차] 슬롯별 레지스터 변형 + 전체 Ubuntu 재검증

- 무엇을: 9/19 라운드에서 남겨둔 "전 오퍼랜드 동일 줄 2,175건" 문제를 `distinct_regs` 변형으로
  처리하고, 5~10단계를 재실행한 뒤 `run_ubuntu_tests.sh` 전체 검증(11~13단계·CPU 포함)까지 돌렸다.
  근거와 관측은 [생성기 수정 범위](GENERATOR_FIX_SCOPE_2026-09-19.md) 9절에 있다.
- 슬롯별 레지스터 변형: 기본 조합은 그대로 두고 자리마다 다른 레지스터를 쓰는 줄을 뒤에 덧붙인다.
  매뉴얼이 지정한 고정 레지스터(AL, CL, DX, ST(0), CR0)는 바꾸지 않는다 - 바꾸면 다른 인코딩
  행을 시험하게 되기 때문이다(`add al, 1`은 04 ib, `add cl, 1`은 80 /0 ib). 고정 자리가 있으면
  일반 자리가 피해 간다(`rcl cl, cl` -> `rcl dl, cl`). x87 `ST(i)`는 st(1)부터 쓴다. 이 자리는
  순서가 실제로 인코딩을 바꾼다(as 확인: `fadd st(0), st(1)`=d8 c1, `fadd st(1), st(0)`=dc c1).
- 결과: 19,120 -> 23,323 combo(+4,203). 전 오퍼랜드 동일 조합 2,175건 중 2,155건(99.1%)에
  구분용 변형이 생겼다. 남은 20건은 CMPS/MOVS 계열인데, as가 이 명령어들의 명시 오퍼랜드를
  인코딩에 반영하지 않아(`cmps byte ptr [eax], byte ptr [ebx]` -> 67 a6) 이 입력 형태로는
  순서를 구분할 수 없다. 기존 19,120행은 ID·값 모두 그대로다.
- 함께 고친 것: 8단계가 오브젝트 23,157개를 막 쓴 직후 9단계 objdump 배치 하나가 180초 제한을
  넘겨 단계 전체가 실패했다. 같은 배치를 나중에 재보니 2.8초였다(파일시스템 일시 지연).
  제한을 600초로 올리고, 넘기면 배치를 반으로 갈라 재시도하도록 6·9·10단계를 고쳤다.
  파일 하나가 끝내 안 끝나면 그때는 실패시킨다(반례 테스트 포함).
- 전체 검증: `failures=0`. 회귀 59개, CLI, 재심 사례·CPU 대조, 11단계 6건(기대값 일치),
  12단계 29건(도구 오류 없음), 13단계 lint 23,330건 + manifest 검사 통과.
  수치는 [최신 검증 기록](LATEST_TEST_RUN.md)에 있다.
- 확인 범위: 13단계 `needs_review` 18,926건은 버그 수가 아니다. 17,847건은 지정 SDM 행의 legacy
  opcode 필드를 대조할 수 없어 `not_checked`로 남은 것이고, 349건이 `different_encoding`,
  344건이 `target_encoding_not_exercised`다. 매뉴얼 Valid 행인데 as가 거부하는 17건은 전부
  기존에 판정·보류된 사례다. `unsure 47`과 미재심 행은 확정으로 보고하지 않는다.

## 2026-09-20 [보고 자료] 11회 발표자료를 재실행 결과 기준으로 다시 씀 + 수치 대조 도구

- 무엇을: 9/16에 만든 11회 발표 자료 6종(`Claude outputs/`)이 그때의 산출물(입력 7,276줄) 기준이라
  9/19·9/20 재실행 결과(23,323줄)와 어긋나 있었다. 발표가 9/21이라 현재 산출물 기준으로 다시 썼다.
  새 자료는 `docs/MEETING_NOTES/11회_{발표자료,발표_요약_1페이지,LSS_시연_가이드,발표_전_체크리스트}.md`다.
  9/16 자료는 지우지 않고 정정 이력으로 두고, 그 폴더에 무엇이 왜 바뀌었는지 적은 안내를 넣었다.
- 왜 숫자만 고치면 안 됐나: 9/16판이 "한계"로 보고하려던 세 가지(rip 상대 주소 0개, 생성기 오류 40건
  미수정, 결과 파일 버전 불일치)가 9/19·9/20 라운드에서 모두 해결됐다. 그대로 두면 이미 고친 문제를
  미해결로 보고하게 된다. 그래서 4·5절을 "지적 → 수정 → 재실행"으로 다시 쓰고, 5절 한계는 지금 실제로
  남은 것(미재심 10,109행, unsure 47, VEX/EVEX not_checked 17,847, different_encoding 347,
  체크리스트 내_판단 0건 기입, 평가 집합 없음, 퍼징 대상 미연결)으로 교체했다.
- 수치 대조 도구: `scripts/check_report_numbers.py`. 문서에 `<!-- num:키 -->숫자` 표기를 두면
  `out/`·`data/db/`에서 그 값을 다시 계산해 대조한다. 세 문서 58건 대조, 불일치 0건.
  반례로 확인했다 — 틀린 숫자(종료코드 1), 없는 키(FAIL), 산출물 1줄 조작(문서 23,219 vs 산출물 23,218 검출),
  맞는 숫자(종료코드 0).
- binutils 재빌드로 확인한 것: 자료가 "2.42~2.47 재현", "UDB는 2.46부터 지원"이라고 주장하는데
  이 환경에는 2.42만 있었다. 2.45 / 2.46.1 / 2.47.20260726을 소스로 빌드해(시스템 도구는 그대로)
  같은 명령으로 관측했다. **LSS 오표시와 재조립 거부는 네 버전 모두에서 재현**되고,
  **UDB는 2.45 거부 / 2.46.1·2.47 수용**으로 지원 시작 지점이 구간으로 고정됐다.
- 자료의 기술 오류 3건을 정정했다.
  1. `asm_linter` 시연 출력이 실제 출력이 아니었다(박스 UI). 실제 실행 출력으로 교체했다.
  2. "llvm-objdump는 올바르게 표시" → llvm-objdump는 크기를 **생략**한다(`lss rcx, [rax]`).
     틀린 크기를 적는 쪽이 objdump다.
  3. MOVDIR64B "64비트 레지스터로 바꾸면 된다" → `movdir64b rcx, zmmword ptr [rax]`도 거부된다.
     맞는 형태는 `movdir64b ecx, [eax]`이고 `67 66 0f 38 f8 08`을 낸다(9/19 수정으로 현재 수용됨).
- 새로 관측한 것: `-mintel64`가 없으면 as 2.42는 SDM 표기 그대로인 `lss rcx, tbyte ptr [rax]`도
  `operand size mismatch`로 거부한다. 같은 입력이 옵션에 따라 갈리므로 "어셈블러가 거부했다"는 진술에는
  옵션을 함께 적어야 한다. 파이프라인은 `--64 -mintel64` 고정이다.
- 검증 범위: 파이프라인은 다시 돌리지 않았다(9/20 결과를 그대로 쓴다). 코드도 고치지 않았다.
  회귀 테스트 59개 통과를 재확인했다. 밀린 판정(체크리스트 1,558행의 내_판단, unsure 47,
  not_reassessed 10,109)은 이번에 처리하지 않았고 자료에 "남은 일"로만 적었다.

## 2026-09-21 [보고 자료] 교수님 결정 반영 + 인코딩 미타격 349건을 원인별로 분해

- 무엇을: 형섭이 발표 질문 6개에 답을 주면서 방향이 정해졌다. (1) 최종 산출물은 **도구**다.
  (2) 퍼징 대상은 아직 미정. (3) 환경 확대는 지금 하지 않는다. (4) 인코딩 미타격은 "시험 못 함"으로
  세지 말고 **왜 못 때렸는지 분석하라**. 자료의 10절을 "정해진 것 3 / 여쭐 것 3"으로 다시 썼다.
- 인코딩 미타격 분해: `check_report_numbers.py`에 `count_encoding_causes()`를 넣어
  `out/lint/observations.jsonl`의 `target_encoding_not_exercised` 349건을 원인별로 나눴다.
  - **264건 같은 문법에 SDM 행이 둘** — `adc cl, cl`은 `10 /r`(r/m8,r8)도 `12 /r`(r8,r/m8)도 된다.
    오퍼랜드가 대칭이라 Intel 문법으로 두 행을 구분할 수단이 없다. **구조적 한계**로 문서화할 것.
  - **64건 분기 변위 축약** — `ja .Ltarget`에 `0F 87 cd`(rel32)를 지정했는데 as가 `77 fe`(rel8)를 고른다.
    타깃을 rel8 범위 밖에 두면 긴 형식을 강제할 수 있다. **고칠 수 있다.**
  - **21건 REX.W 미부착** — `lar ecx, word ptr [eax]` → `67 0f 02 08`. mov 7 / lar 4 / lsl 4 / smsw 3 /
    call·jmp·xlatb 각 1. LAR/LSL은 재심에서 정리된 건이고 나머지는 입력 형태 교정 대상.
  - 분류 근거는 관측 바이트와 지정 opcode 문자열뿐이다. 의미 동등성은 판정하지 않았다.
    REX.W 판정은 `67`·`66`·`f2`·`f3` 프리픽스를 걷어낸 뒤 `48~4F`를 본다(처음엔 프리픽스를 안 걷어내
    21건을 29건으로 잘못 셌다).
- 숫자 두 개가 다른 이유를 확인해 각주로 남겼다: 13단계 manifest의 `different_encoding` 347은
  **생성 입력만** 센 것이고, findings 기준 349는 거기에 `data/cases.csv` 보충 사례 2건
  (`lar rcx, rcx`, `lsl rcx, rcx`)이 더해진 값이다.
- 다음 단계 표를 재배치했다. **1순위를 "인코딩 미타격 85건을 실제로 때리기"로 올렸다** —
  독립 디코더 없이 지금 할 수 있고 연구 질문에 가장 직결되기 때문이다. 퍼징 대상 확정이 2순위다.
- 검증: 세 문서 71건 수치 대조 불일치 0, 회귀 테스트 59개 통과. 파이프라인은 다시 돌리지 않았다.

## 2026-09-21 [보고 자료] 발표 대본 추가 — 예외 사항을 원인까지 풀어 씀

- 무엇을: 자료가 용어와 분류 이름 위주라 읽기 어렵다는 지적을 받았다. `11회_발표_대본.md`를 새로 쓰고
  발표자료 본문도 **예외 사항(뜻대로 안 된 것) 중심**으로 재구성했다. 어셈블/역어셈블/왕복 검사를
  먼저 풀어 놓고 시작한다.
- 예외를 여섯 가지로 나눠 각각 원인을 붙였다.
  1. 거부 104건 = 매뉴얼도 무효라 한 87건(정상 동작) + 매뉴얼은 Valid인데 거부 17건.
     17건은 오류 메시지까지 확인해 6종류로 갈랐다 — VPMOVQD 5(매뉴얼 표 오탈자 추정),
     SYSEXIT/SYSRET 4(표기 관례), MOV Sreg 3·LAR/LSL 2(재심 완료), VSCATTERDPD 2(보류), UDB 1(버전).
     **어셈블러가 잘못한 것은 0건.**
  2. 왕복 차이 9,991건 = 표기 차이. 숫자 표기 7,736 / 브로드캐스트 860 / 별명 729 / 숨은 오퍼랜드 210 등.
     사람 판단이 아니라 재조립 바이트 동일 9,834건으로 뒷받침한다.
  3. as·clang 갈림 211건 = 바이트 다름 125(clang이 66 프리픽스를 안 붙임) + as만 수용 74(폐기된 MPX를
     clang이 지움) + clang만 수용 12(64비트 2바이트 간접 호출을 as가 막음).
  4. 지정 행 미타격 349건 = 원리상 불가 264 + 고칠 수 있는 85.
  5. 미판정 47건. 6. objdump LSS/LFS/LGS 결함 3사례.
- 고친 오류: `as_only`를 "as만 거부"로 적고 있었는데 **"as만 수용(clang 거부)"이 맞다**
  (`m9_clang_compare.py`). 9/16 자료에서 넘어온 오류다. 교차 검증도 맞는다 —
  as 수용 23,219 − clang 수용 23,157 = 62 = 74 − 12. 스크립트 키 이름도 함께 고쳤다.
- `check_report_numbers.py`에 `expected_rejected`(87), false_alarm 유형별 집계, 왕복 same/different,
  재조립 동일 건수를 추가했다. 네 문서 114건 대조 불일치 0.
- 검증: 회귀 테스트 59개 통과. 파이프라인은 다시 돌리지 않았다.

## 2026-09-21 [예외 검증] 예외 사례를 도구 9종에서 재확인 — MPX 미스터리 해소, clang 새 관측

- 무엇을: 형섭 요청으로 발표자료를 "목표 / 필요성 / 파이프라인 설계도 / 결과 / 예외 ①~⑥ / 예외 분석"
  구조로 다시 쓰고, 예외 사례를 **직접 빌드한 binutils 4종(2.42·2.45·2.46.1·2.47) + Godbolt의
  gas 2종 + clang 3종(18·23.1·24-trunk)** 에서 같은 입력으로 다시 관측했다.
  관측 원본은 `docs/review_artifacts/verify_cases_2026-09-21.json`,
  재현 스크립트는 같은 폴더의 `verify_cases_2026-09-21.py`·`godbolt_api_2026-09-21.py`다.
- **예외 ⑤의 MPX 미스터리가 풀렸다.** `bndcl bnd0, dword ptr [rax]`는 as 2.42가 받아주고
  (`f3 0f 1a 00`) **2.45·2.46.1·2.47은 거부한다**(`` `bndcl' is not supported on `x86_64' ``).
  Godbolt도 2.42 수용 / 2.44 거부로 같다. clang은 세 버전 모두 거부.
  Intel이 MPX를 폐기하면서 binutils가 지원을 뺀 것이다. "as가 매뉴얼 무효 행을 이상하게 관대하게
  받아준다"고 unsure로 남겼던 16건 중 MPX 계열은 **도구 결함이 아니라 우리가 낡은 버전을 쓴 탓**이다.
- **예외 ⑥이 더 정확해졌다.** objdump가 낸 `lss rcx,FWORD PTR [rax]`를 **clang은 받아준다**
  (같은 바이트 `48 0f b2 08`). 문법적으로 불가능한 글자가 아니라 as가 FWORD+rcx 조합을 막는 것이다.
  → "objdump가 틀렸다"보다 **"같은 binutils 안에서 objdump와 as가 서로 안 맞는다"**가 정확한 진술이다.
- **새 관측(미확정): clang이 레지스터를 조용히 바꾼다.** as가 거부하는 `lar ecx, rcx`를 clang은
  받아주는데 결과가 `lar ecx,ecx`(clang 18·24) / `lar ecx,cx`(clang 23.1)로 **버전마다 다르다.**
  `lsl rcx, ecx`도 clang 18이 `lsl rcx,rcx`로 바꾼다. 경고가 없다.
  근거가 더 필요해 예외 ⑤의 추적 항목으로 남긴다.
- **Godbolt 라벨 주의사항을 기록했다.** Compiler Explorer의 "x86-64 binutils 2.45"와 "(trunk)"는
  `api/compilers`가 보고하는 실제 버전이 **둘 다 2.44**다. 2.45 이상은 소스 빌드로만 확인했다.
  또 Godbolt의 assembly 뷰는 어떤 어셈블러를 쓰든 출력을 objdump 형식으로 보여주므로,
  "조립되는가"는 확인되지만 "어느 디스어셈블러가 뭐라고 쓰는가"는 로컬 도구로 봐야 한다.
- 그 밖에 확인된 것: SYSEXIT은 as가 `ambiguous operand size`로 거부하는데 **clang은 `sysexitd`
  (`0f 35`)로 조립한다**(32비트를 기본값으로 고름). VPMOVQD·MOV Sreg·VSCATTERDPD는 **도구 7종이
  전부 같은 이유로 거부**해 매뉴얼 쪽 문제라는 근거가 강해졌다.
- 검증: 발표자료 43건·대본 27건·요약 21건 수치 대조 불일치 0. 회귀 테스트 59개 통과.
  파이프라인은 다시 돌리지 않았다.

## 2026-09-21 [예외 재검토] VPMOVQD 5건 — 매뉴얼 표기 오류 확정 + 우리 입력도 고칠 수 있음

- 계기: 형섭이 "매뉴얼에 `VPMOVQD xmm1/m128 {k1}{z}, xmm2`라고 적혀 있는데 왜 우리가
  `vpmovqd xmmword ptr [eax], xmm0`으로 써서 거부됐다고 하느냐"고 물었다. 확인해 보니
  **추출·생성은 매뉴얼대로 한 것이 맞았고, 매뉴얼 줄 자체가 같은 페이지의 다른 정보와 모순됐다.**
- PDF 원문 확인(p.2054, pdfplumber를 별도 venv에 설치해 직접 추출): DB의 세 행이 원문과 일치한다.
  추출 오류가 아니다.
- 매뉴얼 내부 모순 근거 3가지:
  1. 같은 줄 설명 — "Converts 2 packed quad-word integers from xmm2 into 2 packed double-word
     integers" → 2 × 32비트 = 64비트(m64)
  2. 같은 페이지 Instruction Operand Encoding 표 — Tuple Type이 `Half Mem`(벡터 길이의 절반)
     → EVEX.128이면 64비트
  3. 형제 행 — VPMOVDB m32 / VPMOVDW m64 / VPMOVQB m16 / VPMOVQW m32 / VPMOVWB m64.
     전부 줄어든 크기인데 VPMOVQD EVEX.128만 m128이다.
- 도구 관측: `vpmovqd qword ptr [eax], xmm0` → `62 f2 7e 08 35 00`(EVEX.128, 노렸던 행 그대로),
  `vpmovqd xmmword ptr [eax], ymm0` → `62 f2 7e 28 35 00`(EVEX.256). 즉 m128은 ymm 소스와 짝이다.
  VPMOV* 계열 메모리 입력 450건 중 이 행에서 나온 5건만 거부됐다.
- 판정 변경: "매뉴얼 표 오탈자 추정" → **"매뉴얼 표기 오류 확정"**. 동시에 **우리 입력도 개선 가능**으로
  바뀐다. 오퍼랜드 열의 m128 대신 Tuple Type을 읽어 메모리 크기를 정하면 이 행을 실제로 시험할 수 있다.
  거부 17건 중 5건이 다음 라운드에서 해소 가능하다.
- 다음 단계 표에 1-b "1단계 추출에 Tuple Type 열 추가"를 넣었다.
- 교훈: "매뉴얼대로 했는데 거부됐다"에서 멈추면 안 된다. **매뉴얼의 다른 열(Tuple Type)과 형제 행을
  함께 보면 어느 쪽이 틀렸는지 판정할 수 있다.** 다른 EVEX 행에도 같은 점검을 적용해야 한다.

## 2026-09-21 [예외 재검토 2] VSCATTERDPD 2건도 매뉴얼 표기 오류로 확정

- VPMOVQD에 썼던 방법(매뉴얼의 다른 열·형제 행과 대조)을 "판단 보류"로 남아 있던 VSCATTERDPD에
  적용했더니 같은 결론이 나왔다.
- 원리: VSIB 명령어는 **인덱스 레지스터 개수 = 데이터 원소 개수**다. 인덱스가 dword(32비트)이고
  원소가 qword(64비트)면 인덱스 레지스터는 데이터 레지스터의 **절반** 크기여야 한다.
- 쌍둥이 비교 (둘 다 dword 인덱스 + qword 원소, PDF p.2080·p.2202에서 직접 확인):

  | EVEX | VPSCATTERDQ | VSCATTERDPD |
  |---|---|---|
  | 128 | vm32x, xmm1 | vm32x, xmm1 (일치) |
  | 256 | vm32x, ymm1 | **vm32y, ymm1** (어긋남) |
  | 512 | vm32y, zmm1 | **vm32z, zmm1** (어긋남) |

- 도구 관측: `vscatterdpd [eax + ymm1] {k1}, ymm0` 거부 / `[eax + xmm1] {k1}, ymm0` →
  `67 62 f2 fd 29 a2 04`(EVEX.256, 노렸던 행) / `[eax + ymm1] {k1}, zmm0` →
  `67 62 f2 fd 49 a2 04`(EVEX.512). 쌍둥이 `vpscatterdq [eax + xmm1] {k1}, ymm0`은
  `67 62 f2 fd 29 a0 04`로 EVEX 바이트가 같고 opcode만 a2↔a0으로 다르다.
  scatter 계열 입력 32건 중 거부는 VSCATTERDPD 2건뿐이고 VPSCATTERDQ는 전부 수용됐다.
- 판정 변경: 판단 보류 → **매뉴얼 표기 오류 확정**. 매뉴얼 Valid 거부 17건 중 **7건
  (VPMOVQD 5 + VSCATTERDPD 2)이 매뉴얼 오류로 확정**됐고, 같은 7건은 우리 입력을 고치면
  다음 라운드에서 실제로 시험할 수 있다.
- 다음 단계 1-b를 "매뉴얼의 다른 열로 오퍼랜드 크기를 정한다"로 넓혔다 — EVEX 메모리는 Tuple Type,
  VSIB 인덱스는 인덱스·원소 폭 비율.
- 방법론으로 남길 것: **오퍼랜드 열 하나만 보고 "매뉴얼대로 했는데 거부됐다"고 멈추면 안 된다.**
  같은 페이지의 Tuple Type·설명문, 그리고 같은 모양의 형제 행과 대조하면 어느 쪽이 틀렸는지
  판정할 수 있다. 남은 EVEX/VSIB 행 전체에 이 점검을 돌리는 것이 과제다.

## 2026-09-21 [예외 재검토 3] SYSEXIT/SYSRET 4건 — 매뉴얼 오류가 아니라 표기의 구조적 한계

- 마지막 판단 보류였던 SYSEXIT/SYSRET을 확인했다. **매뉴얼 오류도 도구 결함도 아니다.**
- SDM에 니모닉 글자가 **완전히 같은 두 행**이 있다(행 2696·2697, 2698·2699).
  `0F 35 SYSEXIT`(32비트 복귀)와 `REX.W + 0F 35 SYSEXIT`(64비트 복귀). 오퍼랜드가 없으니
  Intel 문법으로 REX.W를 표현할 수단이 없다. 그래서 as가 `ambiguous operand size`로 거부한다.
- 도구가 쓰는 크기 접미사를 붙이면 **두 행 모두 시험된다.**

  | 입력 | as | 맞는 행 |
  |---|---|---|
  | `sysexit` | 거부 `ambiguous operand size` | — |
  | `sysexitl` | 거부 `no such instruction` | — |
  | `sysexitd` | 수용 `0f 35` | REX.W 없는 행 |
  | `sysexitq` | 수용 `48 0f 35` | REX.W 행 |
  | `sysretd` / `sysretq` | 수용 `0f 07` / `48 0f 07` | 각각 |

- **as와 clang의 태도가 갈리고, as 쪽이 안전하다.** clang은 `sysexit`을 받아들여 **경고 없이**
  `sysexitd`(`0f 35`)를 고른다. 매뉴얼 글자를 그대로 clang에 넣으면 `REX.W + 0F 35` 행은
  **한 번도 시험되지 않은 채 "성공"으로 넘어간다.** as의 거부는 "어느 행인지 모르겠다"는 정확한 신호다.
- **이 4건은 뿌리가 예외 ④(지정 행 미타격 349건)와 같다.** 같은 니모닉 글자를 여러 SDM 행이
  공유하는 문제다. 다만 예외 ④는 어셈블러가 조용히 하나를 골라 안 보이고, SYSEXIT은 as가 거부해서
  눈에 띄었을 뿐이다. **"거부"와 "조용한 오선택"이 같은 원인의 두 얼굴**이라는 것이 이번 정리의 핵심이다.
- 거부 17건 최종 정리: 매뉴얼 표기 오류 7(VPMOVQD 5 + VSCATTERDPD 2) / 표기 한계 4(SYSEXIT·SYSRET) /
  재심 완료 5(MOV Sreg 3 + LAR·LSL 2) / 버전 차이 1(UDB). **이 중 11건은 입력을 고치면
  다음 라운드에서 시험 가능하다.**
- 다음 단계 1-b를 "매뉴얼 표기만으로 정해지지 않는 크기를 보완한다"로 다시 넓혔다 —
  EVEX 메모리는 Tuple Type, VSIB 인덱스는 폭 비율, REX.W만 다른 무오퍼랜드 행은 크기 접미사.

## 2026-09-21 [신규 관측] LAR/LSL의 REX.W 행을 as가 만들지 못한다 — 왕복 실패 2번째 유형

- 계기: 예외 ⑤에 하나 남아 있던 미확정("clang이 레지스터를 조용히 바꾼다")을 파고들었다.
  clang의 치환은 곁가지였고 **GNU as 쪽에 더 큰 것**이 있었다.
- 매뉴얼부터: PDF 원문(p.651·p.691)의 REX.W 행이 서로 반대다.
  `LAR r32, r64/m16`(목적지 r32) vs `LSL r64, r32/m16`(목적지 r64). REX.W 비트 하나로 두 자리의
  폭을 따로 정할 수 없다. 각주 1이 "원본은 하위 16비트만 쓴다"고 하므로 원본 폭은 의미가 없는데
  표기는 그것을 폭으로 적어 두 행이 어긋나 보인다. 우리 생성기는 이 표기를 그대로 옮겨
  `lar ecx, rcx`/`lsl rcx, ecx`를 만들었고 as가 거부했다(예외 ①-B의 2건).
- **대칭으로 써 보니 진짜 문제가 나왔다.** `lar rcx, rcx` → as는 `0f 02 c9`를 낸다.
  **REX.W가 조용히 사라진다.** clang은 `48 0f 02 c9`를 낸다. AT&T로도, 크기 접미사를 붙여도 같다 —
  `lar %rcx,%rcx`·`larq %rcx,%rcx` 전부 `0f 02 c9`.
  **GNU as는 SDM이 Valid라고 적은 `REX.W + 0F 02 /r` 행을 어떤 문법으로도 만들 수 없다.**
- **왕복 실패:** `48 0f 02 c9` → objdump `lar rcx,rcx`(올바른 표시) → as `0f 02 c9`(다른 바이트,
  오류도 경고도 없음). **2.42·2.45·2.46.1·2.47 전부 동일.** LSL도 같다(`48 0f 03 c9` → `0f 03 c9`).
- **예외 ⑥(LSS)과 성격이 다르다.** LSS는 objdump 표시가 틀리고 재조립이 **거부**돼 시끄럽게 실패한다.
  이쪽은 objdump 표시가 맞는데 재조립이 **수용되면서 바이트가 달라진다** — 조용한 실패다.
  역어셈블 → 수정 → 재조립 흐름에서는 이런 손실이 그대로 통과한다. **더 위험한 유형이다.**
- **확정/미확정 구분:** 바이트가 달라지는 것과 as에 생성 문법이 없다는 것은 확정(4개 버전 재현).
  두 인코딩의 **실행 의미가 다른지는 확인하지 않았다** — 32비트 쓰기는 상위 32비트를 0으로 채우므로
  결과가 같을 수 있다. **그래서 버그 수를 3→4로 올리지 않았다.** 올리려면 CPU 실행 대조가 필요하다.
- **우리 파이프라인이 놓친 이유:** 매뉴얼 행이 비대칭이라 `lar ecx, rcx`를 만들었고 as가 거부해
  REX.W 경로에 도달하지 못했다. 대칭형 `lar rcx, rcx`를 만들었다면 잡혔다. 예외 ④의
  "REX.W 미부착 21건"에 lar 4·lsl 4가 들어 있던 것이 같은 뿌리다.
- 다음 과제: (1) `data/cases.csv`에 `lar rcx, rcx`·`lsl rcx, rcx`를 등록해 파이프라인이 상시
  감시하게 한다 (2) 두 인코딩의 실행 결과를 11단계 CPU 실험으로 대조한다
  (3) 대칭형 변형을 생성기에 추가한다.

## 2026-09-21 [사례 등록] 오늘 확정한 형태를 cases.csv에 등록 + 왕복 관측 회귀 테스트

- 형섭 요청으로 대칭형을 `data/cases.csv`에 등록하려다 **이미 등록돼 있는 것을 확인했다.**
  `lar_r64_symmetric`(`lar rcx, rcx`)·`lsl_r64_symmetric`(`lsl rcx, rcx`)는 처음부터 있었고,
  13단계가 이미 `as=0f02c9 / clang=480f02c9 / different_encoding`으로 보고하고 있었다.
  `instruction_check.py:197`에 `lar_lsl_rex_selection` 판정까지 있어 "REX.W 형식 자체를 시험하려
  했다면 검사되지 않았다"고 적고 있었다. **도구는 이미 잡고 있었고 우리가 해석하지 않았을 뿐이다.**
- 새로 등록한 7건: `vpmovqd_evex128_half_mem`, `vpmovqd_evex256_manual_form`,
  `vscatterdpd_evex256_half_index`, `vpscatterdq_evex256_control`, `sysexit_rexw_suffix`,
  `sysexit_no_rexw_suffix`, `sysret_rexw_suffix`. 오늘 확정한 "매뉴얼의 다른 열로 고쳐 쓴 형태"와
  그 대조군이다. 보충 사례 7 → 14건.
- 등록하면서 나온 관측: **비REX.W SYSEXIT 행에는 두 도구가 공통으로 받는 표기가 없다.**
  `sysexit`은 as 거부·clang 수용(`0f 35`), `sysexitd`는 as 수용(`0f 35`)·clang 거부.
  REX.W 행은 `sysexitq`로 공통이다. SYSRET도 같다. 차등 테스트의 "같은 입력을 두 도구에" 전제가
  이 행에서는 성립하지 않는다.
- `tests/test_manual_notation_cases.py`(10개) 추가. 오늘 관측을 바이트 단위로 고정한다 —
  VPMOVQD Half Mem, 형제 행, VSCATTERDPD 절반 인덱스, SYSEXIT 접미사와 이식성,
  as의 REX.W 소실(Intel·AT&T·접미사 모두), **`48 0f 02 c9` → objdump → as 왕복에서 바이트가
  달라지는 것**, 그리고 대비군으로 LSS의 시끄러운 왕복 실패. 이 테스트가 깨지면 버그가 아니라
  도구 동작이 바뀐 것이므로 관측을 다시 기록하라고 파일 상단에 적었다.
- 반례 확인: 왕복이 성공한다고 기대를 바꾸면 2건 실패, as가 REX.W를 낸다고 바꾸면 1건 실패,
  VPMOVQD가 m128로도 된다고 바꾸면 1건 실패. 정상 상태에서는 0건.
- 13단계는 cases.csv 변경 후 재실행 중이다. 완료되면 보충 사례 수와 상태 분포가 7건만큼 바뀌므로
  문서 수치를 다시 대조해야 한다.

## 2026-09-21 [13단계 재실행] cases.csv 추가 반영 + Codex 재검증 요청서 작성

- cases.csv에 7건을 추가한 뒤 13단계를 다시 돌렸다. 실행 기록 `out/runs/20260920T233325021698Z.json`.
- 바뀐 수치는 하나뿐이다: `needs_review` 18,926 → **18,933**(추가한 보충 사례 7건이 모두
  needs_review로 들어감). `accepted` 4,295 · `rejected` 106 · `incomplete` 3 · `tool_error` false는
  그대로다. 생성 입력 기준 수치(23,323 / 23,219 / 349 / 264·64·21)도 변동 없다.
  보충 사례 7 → 14건, 고유 소스 19,986 → 19,991.
- `scripts/check_report_numbers.py`가 문서 4종에서 이 한 건을 잡아냈다. 사람이 옮겨 적은 숫자와
  산출물을 대조하는 장치가 실제로 작동한 사례다. 발표자료·체크리스트·LATEST_TEST_RUN을 갱신했다.
- **주의로 기록:** 13단계가 도는 동안 `check_report_numbers.py`를 돌리면 쓰다 만
  `observations.jsonl`을 읽어 잘못된 수치가 나온다(실제로 한 번 겪었다). 재실행 중에는 대조하지 않는다.
- Codex 재검증 요청서 `docs/review_artifacts/codex_reverify_2026-09-21.md`(377줄)를 썼다.
  형섭 지시로 **내가 매긴 중요도 순위와 "특히 이걸 봐 달라"는 표현을 전부 제거**하고,
  항목을 파이프라인 단계·사례 수 순서로만 배열했다. 구성은 세 축이다 —
  (2장) 예외 사항 전면 재검토: 거부 104건(87+17 전체 목록), 왕복 차이 9,991건 유형별,
  as·clang 갈림 211건, 지정 행 미타격 349건, 미판정 47건, 확정 3건과 관련 관측 4종.
  판정 선택지를 6개로 고정했다(매뉴얼 표기 오류 / 매뉴얼 표기의 한계 / 도구 구현 결함 /
  ISA 제약 / 입력 생성 오류 / 버전 차이).
  (3장) 파이프라인 설계가 표방한 의도대로인지 13단계 모듈별 점검 + R1~R3 실패 주입 재확인.
  (4장) 실험 방법론 9개 질문 — 오라클 타당성, 커버리지 주장의 간극, 차등 테스트 전제,
  평가 지표 부재, 선행 연구 대비, 결론 범위, 실행 의미, threats to validity, 보안 연구로서의 의의.
- 요청서에 검증 환경 두 경로를 넣었다. 로컬(binutils 2.47 소스 빌드, apt clang-20)과
  Godbolt API. Godbolt 함정 2가지를 명시했다 — 라벨 "2.45"·"(trunk)"가 실제로는 둘 다 2.44인 것,
  그리고 assembly 뷰가 어떤 어셈블러를 쓰든 objdump로 렌더링하므로 **디스어셈블러 표시 검증에는
  쓸 수 없다**는 것.

## 2026-09-21 [외부 검토 반영] Codex 재검증 결과로 판정 4건 정정

외부 검토(Codex)가 우리 결론 여러 개를 반박했고, **직접 돌려 본 결과 반박이 맞았다.**

### 정정 1 — "349건 중 264건은 원리상 구분 불가능"은 틀렸다

GAS에는 인코딩을 강제하는 의사 프리픽스가 있고, 세 유형 전부 강제된다(as 2.42에서 직접 확인).

```
adc cl, dl            -> 10 d1              {load} adc cl, dl   -> 12 ca
ja .Ltarget           -> 77 fe              {disp32} ja .Ltarget -> 0f 87 fa ff ff ff
lar rcx, rcx          -> 0f 02 c9           rex64 lar rcx, rcx  -> 48 0f 02 c9
```

349건은 ISA 커버리지 실패가 아니라 **생성기가 GAS 인코딩 제어 문법을 쓰지 않은 결과**다.
현재 이 지표는 "기본 렌더러가 지정 opcode를 우연히 맞췄는가"를 재고 있다.
회귀 테스트 `EncodingControlPrefixTests` 추가.

### 정정 2 — "as는 어떤 문법으로도 REX.W LAR/LSL을 만들 수 없다"는 내 주장이 틀렸다

`rex64 lar rcx, rcx` -> `48 0f 02 c9`. Intel 기본 렌더링·AT&T·크기 접미사에서만 빠진다.
**이 사실은 결론을 강화한다** - ISA 표현력의 한계가 아니라 **기본 인코딩 선택 문제**임이 확정된다.
또한 **이미 보고된 결함**이다: binutils bug gas/32813 "Missing REX prefix for LSL"
(보고자: 이전 gas 버전은 REX를 붙였고 nasm·XED도 붙인다). 원인은 2022년 커밋
"x86: correct handling of LAR and LSL"이 만든 회귀다. 우리가 처음 찾은 것이 아니라,
**우리 파이프라인이 알려진 결함을 독립적으로 재현한 사례**로 기술해야 한다.
테스트 파일의 잘못된 기대(`test_att_syntax_and_suffix_also_drop_rex_w`)를 고치고
`test_rex64_prefix_does_produce_rex_w`를 추가했다.

### 정정 3 — "왕복 차이 9,991건은 전부 표기 차이"는 과장

재조립 결과가 이미 저장돼 있다: 동일 9,834 / 다름 7 / 실패 51 / 라벨 artifact 99.
정확한 진술은 **"9,834건은 바이트를 보존하는 표기 변환, 나머지 157건은 별도 판정 필요"**.
실패 51건에는 LSS/LFS/LGS 9건, MOVSXD 5건이 들어 있다.

### 정정 4 — "as·clang 바이트 차이 125건은 프리픽스 정책 차이"는 틀렸다

의미가 같은 것과 다른 것이 섞여 있다. 직접 확인한 의미 차이:

| 입력 | as | clang |
|---|---|---|
| `mov al, ds:0x123456789abcdef0` | `movabs`, 주소 유지 | **`0xffffffff9abcdef0`으로 잘림. 경고 없음, 종료코드 0** |
| `iret` | `cf` = IRETD(32비트) | `66 cf` = IRETW(16비트) |
| `push fs` | `0f a0`(64비트 스택) | `66 0f a0` = pushw(16비트) |
| `mov rcx, ds` | `8c d9`(REX.W 없음) | `48 8c d9` |

**clang이 64비트 절대주소를 조용히 잘라 다른 주소를 만든다**는 것이 이번 검토에서 가장 큰 발견이다.
우리는 이 데이터를 갖고 있었으면서 "프리픽스 차이"로 묶어 놓쳤다.

### 정정 5 — "확정 어셈블러 버그 0건" 진술 철회

말할 수 있는 것은 "기존 triage가 확정 표시한 어셈블러 버그가 0건"까지다.
GNU as LAR/LSL REX.W 누락이 반례이고, 미재심 10,109건·unsure 47건이 남아 있다.

### 검토가 지적한 코드 결함(확인함, 미수정)

- `m6_roundtrip.py`: objdump returncode를 검사하지 않는다. 출력 누락이 도구 실패가 아니라
  빈 문자열 -> different로 전달된다.
- `m8_clang_assemble.py`: `returncode == 0`만 본다. TimeoutExpired·시그널 종료를 구분하지 않아
  R1이 clang 경로에서 미해결이다.
- `m7_triage.py`: 10,109건이 `not_reassessed`인데 10,066건을 false_alarm으로 집계한다.
- 11·12단계의 "격리"는 timeout을 둔 자식 프로세스일 뿐이다. namespace/seccomp/권한 강등이 없다.

### 내 관측 스크립트 오류

`verify_cases_2026-09-21.py`가 LLVM에 GNU 전용 옵션 `-mintel64`를 넘겨
"clang trunk 전부 거부"라는 잘못된 원시 관측을 만들었다. JSON과 스크립트 상단에 정정 주석을 넣었다.
clang 관측은 `verify_clang_2026-09-21.json`을 쓴다.

## 2026-09-21 [신규 결함] 5단계가 as의 경고를 기록하지 않고 버린다

- 계기: 발표자료에서 예외 ②의 157건(바이트 다름 7 / 재조립 실패 51 / 라벨 artifact 99)을
  하나씩 갈라 보라는 요청을 받아 `out/reassemble_check.csv`를 원인별로 집계했다.
- **재조립 실패 51건의 내역** (오류 메시지 기준):
  - 32건 `invalid use of register` — gather 계열 8종(vgatherdpd/qpd/dps/qps, vpgatherdd/qd/dq/qq) × 4
  - 9건 `incorrect register 'rcx' used with 'l' suffix` — LSS/LFS/LGS 각 3개 주소 변형 (예외 ⑥)
  - 5건 `operand size mismatch for 'movsxd'` — objdump가 `movsxd cx,ecx`라는 비대칭 폭을 출력
  - 5건 jecxz/jrcxz/loop/loope/loopne
- **바이트 다름 7건**: PREFETCHIT0/1 4건(구 objdump가 `nop DWORD PTR`로 해독) + AMX tile 계열 3건
  (재조립 시 불필요한 disp32 추가).
- **라벨 artifact 99건**: 상대분기 `call/jcc .Ltarget`. 라벨 이름이 바이트에 남지 않아 objdump가
  `0x0`으로 표시한다. 구조적 한계이지 도구 결함이 아니다.
- **여기서 파이프라인 결함을 찾았다.** gather 32건을 직접 돌려 보니
  `vgatherdpd xmm0, [eax + xmm1], xmm0`에 as가 경고를 낸다 —
  `Warning: mask, index, and destination registers should be distinct`.
  목적지와 마스크에 같은 레지스터를 쓴 **우리 입력 오류**이고, objdump가 `xmm0/(bad)`를 출력하는 것은
  그 인코딩이 실제로 무효라는 표시다(objdump 2.42·2.45·2.46.1·2.47 동일, llvm-objdump는 그냥 출력한다).
  문제는 그 다음이다 — **`m5_assemble.py`는 returncode가 0이 아닐 때만 stderr를 기록한다**(101행).
  경고만 나고 성공한 경우 메시지를 버린다. 실제로 `asm_result.csv`에서 `actual_result=ok`이면서
  `error_message`가 있는 행은 **0건**이다. **as가 경고한 입력이 전부 깨끗한 성공으로 집계돼 왔다.**
- 영향: 슬롯별 레지스터 변형(9/20)이 "자리마다 다른 레지스터"를 넣었지만 gather 계열의
  "목적지·인덱스·마스크가 서로 달라야 한다"는 제약은 반영하지 못했다. 경고를 버리고 있었으므로
  이 결함이 드러나지 않았다.
- 후속 과제(미수정): (1) 5·8단계가 성공 시에도 stderr를 보존하고 `ok_with_warning` 같은 상태로
  구분한다 (2) gather/scatter 계열의 레지스터 상이 제약을 3단계 조합 규칙에 넣는다
  (3) 경고가 난 입력이 전체에서 몇 건인지 재실행으로 센다.

## 2026-09-21 [판정 확정] 예외 ⑥ LSS/LFS/LGS는 objdump 표시 결함이며, 집계를 둘로 나눈다

- 형섭 판정: **LSS/LFS/LGS는 GNU objdump의 재생성(표시) 결함일 뿐 명령어 자체나 어셈블러의 오류가 아니다.**
  외부 검토(Codex)도 같은 결론이었다 — "GNU objdump 표시 결함이 정확한 명칭이고
  'objdump와 as 불일치'는 증상일 뿐이다".
- 이 판정을 발표자료·대본·요약에 반영했다. 내가 앞서 "같은 binutils 안에서 objdump와 as가 서로
  안 맞는다가 가장 정확한 표현"이라고 적었던 것은 **부정확했다.** 그건 증상이고, 결함의 이름은
  objdump 표시 결함이다.

| 항목 | 판정 |
|---|---|
| 결함 대상 | GNU objdump |
| 결함 유형 | 80비트 포인터를 `FWORD PTR`(48비트)로 잘못 표시 |
| 최초 어셈블 결과 | **정상** — 의도한 기계어 `48 0f b2 08`이 생성된다 |
| 재조립 실패 | 잘못된 **표시 문자열** 때문에 발생 |
| 실행 의미 오류·보안 취약점 | **이 사례로 입증되지 않음** |

- 보고 문장을 고정했다: "LSS/LFS/LGS에서 GNU objdump의 포인터 크기 표시 결함을 확인했다.
  최초 생성된 기계어는 정상이나, 역어셈블 출력의 잘못된 크기 지정으로 GNU as 재조립이 실패한다.
  공통된 표시 결함 유형 1개가 세 명령어에서 관측된 것으로, 어셈블러 코드 생성 버그 3개를 발견한
  것은 아니다."
- **집계 분리:** `far_pointer_display`·`disassembly_defect` 분류와 `verdict=bug`는 그대로 둔다.
  다만 보고할 때 **역어셈블러 표시 결함(objdump — LSS/LFS/LGS)** 과
  **어셈블러 결함(GNU as — LAR/LSL REX.W 누락, bug gas/32813)** 을 합산하지 않는다. 성격이 다르다.
- 함께 기록: 예외 ④ 349건의 성격을 다시 쟀다. **오퍼랜드가 같은 것은 50건뿐이고 299건은 서로 다르다**
  (`adc cl, dl` → 지정 `12 /r`, 실제 `10 d1`). 원인은 "글자로 구분이 안 돼서"가 아니라
  **as가 두 방향 중 늘 한쪽(10/11 /r)을 고르기 때문**이다. 그래서 `13 /r` 계열 행은 기본 렌더링으로는
  영영 나오지 않는다. 슬라이드 설명에서 "자기 자신 대상 형태라서"라고 적었던 것을 정정했다.

## 2026-09-29 [검토] 9월 28일 snapshot의 거부 입력 178개 SDM 오퍼랜드 대조

- 사용자 요청에 따라 한 어셈블러라도 거부한 178개 고유 combo(ISA 104행)의 operand를
  SDM Description, 표, 필요한 Operation과 대조했다. 생성 pipeline과 원본 snapshot은 수정하지 않았다.
- [보고서](REJECTED_INPUT_REVIEW_2026-09-28.md)와
  [개별 CSV](../out/rejected_input_review_2026-09-28/cases.csv)에 모드, literal 표기,
  Description, register/memory/mask, 지원 모드와 주소의 관계를 나누어 기록했다.
- 상호 배타적 결과: 정적 operand 형태 합치 129개(그중 62개는 64비트 모드 무효),
  Description/주소 문제 44개(13+31), BOUND의 tool별 크기 표기 차이 2개,
  MOV Sreg memory 폭 표기 미확인 3개. BOUND 전체 6개 중 주소 문제 4개는 44개에 포함된다.
- BOUND의 GNU 전체 pair 폭/Clang 개별 경계값 폭 관례, far branch target 폭 지정,
  CET m64 directive, MPX index 생략에 대해 조립만 하는 문법 대조 36개를 보존했다.
  CPU 실행은 하지 않았고 assembler 수용을 ISA 증거로 대체하지 않았다.
- 검증 범위: 178개 누락/중복 없음, 모든 원본 source/SDM metadata/양 tool 상태·진단 일치,
  판정 총계 합계, 필요한 SDM page 원문 보존, 원본 파일 SHA-256 불변.
  전체 ISA DB의 의미 검증이나 도구 구현 버그 확정은 이 검토 범위가 아니다.

## 2026-09-29 [수정] 확인된 Description 불일치 13개 생성 교정

- VPMOVQD EVEX.128의 memory destination 5개를 m64로, VSCATTERDPD YMM/ZMM의
  index 2개를 XMM/YMM으로 교정했다. 정확한 mnemonic/opcode/operand form에만 규칙을 적용한다.
- far CALL/JMP의 16비트 offset 2개는 `data16 ... fword ptr [eax]`, 64비트 offset 2개는
  `rex64 ... fword ptr [rax]`로 생성한다. 후자의 주소 변경은 Clang이 EAX의 addr32를
  REX.W 뒤에 놓는 문제를 피한다. 64비트 SYSEXIT/SYSRET 2개는 q suffix를 명시한다.
- SDM 원문 `operand_types`/Description/opcode/form hash와 token 입력은 보존한다.
  `effective_operand_types`, `generation_corrections`, structured memory의 실제 data/address 폭을
  별도로 기록하며 far pointer 폭은 explicit operand-size prefix 문맥에서 검사한다.
- 직전 snapshot을 ID/lineage 기준으로 지정하는 audit의 `--previous-combos` 옵션을 추가했다.
  기본 경로는 유지하고 manifest revision은 실제 generation contract의 revision을 사용한다.
- 검증: 새 회귀 5개 및 기존 generation contract 회귀 20개 PASS. 새 회귀는 13개 source의
  GNU/Clang 실제 바이트 26개, REX.W의 opcode 직전 위치, 원문/유효 타입/폭 메타데이터,
  인접 form 미교정, 기존 잘못된 폭과 prefix 누락 및 far64 EAX 표기의 반례를 확인한다.
- ISA DB와 이전 snapshot은 수정하지 않았고 31개 주소 문제와 3개 미확정 MOV 입력의
  교정 규칙은 추가하지 않았다. 전체 재실행 집계는 별도 새 snapshot에서 검증한다. CPU 실행 없음.

## 2026-10-09 [도구·검토] 매뉴얼 조회 화면, 공통 규칙 초안, MOV 44개 검토

- 작업 중 WSL이 멈춰 색인 생성이 중단됐다. pdfplumber가 2,565쪽의 페이지 캐시를 쌓는 것을 막으려고 페이지마다 `page.close()`를 호출한다.
  재생성 중 메모리 사용량은 약 2GB를 유지했다. 저장된 원문으로 절 구분만 다시 하는 `--reuse-pages`를 추가했다.
- 색인(`pipeline/manual_index.py`, `out/manual_index/`, manual-index-v2)은 PDF sha256과 규칙 버전으로 무효화를 판단한다.
  제목 없는 꼬리말(장 시작·총론·부록) 쪽을 앞 명령 절에 붙이던 결함을 고쳤다(LZCNT가 698~703쪽, VSCATTERPF가 부록 전체를 흡수하던 문제).
  꼬리말이 아예 없는 63쪽만 앞 절에 이어 붙이고 화면에 표시한다.
- 조회 서버 `scripts/manual_server.py`(127.0.0.1:8787)와 `web/manual/`: 검색, 절 원문, isa_db 행, 생성 사례와 저장 관측(새 실행 아님),
  총론 제목, 규칙표, 원본 PDF 쪽을 연결한다.
- 공통 규칙 초안 `data/rules/common_rules.csv` 19개(초안 16, 미확인 3: OPEN-02, ADDR-01, MOFFS-01). 인용문이 해당 쪽에 실제로 있는지 테스트로 검사한다.
  이 PDF판(2026-02)에는 `REX + 88 /r` 행이 없고 각주 1로만 처리되어 있다. isa_db와 일치한다.
- MOV 88/89/8A/8B 44개: 주 에이전트 독립 판정을 먼저 저장했다(`main_independent_record.txt`에 시각과 해시).
  그다음 Sol(Opus 에이전트)이 초안을 썼고, 둘을 대조해 `out/mov_review_2026-10-09/mov_review.csv`를 만들었다.
  - 결과: 정적 판정은 합치 32, 미확인 12(`[eax]`). 인코딩 판정은 합치 36, 불일치 8(8A/8B reg-reg가 88/89로 조립됨).
  - 두 검토자는 인코딩 44개에서 일치했다. 이견은 `[eax]` 12개의 정적 판정뿐이며, 사용자 결정 항목으로 넘겼다.
  - Sol 이견 중 원문으로 확인한 것을 OPEN-02, ADDR-01, REX-01, PFX-01에 반영했다.
  - 새 실측: as 2.42는 `{load}`로 8A/8B를 낸다. clang 18.1.3은 `{load}`를 거부한다. CPU 실행은 없다.
- 생성 코드는 수정하지 않았다. 사용자 확인 목록은 `USER_CHECK_LIST.md`이며 어떤 사례도 확인 완료가 아니다. 회귀 108개 통과(새 매뉴얼 색인 검사 10개 포함).

## 2026-10-09 [변경] 매뉴얼 조회를 브라우저에서 터미널로 바꿈

- 사용자 지시: 조회 화면은 브라우저를 쓰지 않고 터미널에서 수행한다.
  `scripts/manual_server.py`와 `web/manual/`(같은 날 만들었고 커밋하지 않음)을 지우고 `scripts/manual_lookup.py`로 대체했다.
- 조회 로직은 `pipeline/manual_lookup.py`(값 생성)로, 출력은 CLI로 나눴다.
  - 명령: status, search, show(--part 소제목, --text 전체), page, general, rules, cases.
  - 원본 확인은 출력된 'PDF 파일 쪽'을 각자 PDF 뷰어에서 연다.
- `--part`는 소제목 하나의 원문만 다음 소제목 직전까지 자른다. 빈 쪽 머리말이 끼던 결함을 고치고, 그 결함을 반례로 하는 회귀를 넣었다.
- 검증: 회귀 112개 통과(터미널 조회 4개 추가). 이 항목 이전 기록의 '조회 서버'는 이 변경으로 대체됐다.
- 같은 날 사용자 결정: 최종 검사 도구(원래 계획 4절의 브라우저 GUI)도 터미널로 한다. 기능 요구는 유지하고 출력 방식만 바꾼다.

## 2026-10-09 [방향 전환] 원문 최우선, 전체 4,210행 재검토, 조합 생성기 재작성

- 사용자 결정:
  - 원문이 최우선이고 에이전트 해석은 배제한다. 이전 해석 규칙 `data/rules/common_rules.csv`는 폐기한다(이력으로만 보존).
  - MOV만이 아니라 전체 행을 재검토하고, 총론을 처음 본 기준으로 조합 생성기를 새로 쓴다.
  - 결정 1: 명령 절 표·Description이 주소 크기를 말하면 그것을, 말하지 않으면 총론 2.2.1.4의 64비트 기본 주소를 쓴다.
  - 결정 2: 방향 쌍 레지스터-레지스터는 도달 불가로 표시하고, GNU 소스에만 `{load}`/`{store}`를 붙인다.
  - 대표값: 원문 목록 순서대로 고르되, 같은 절 표에 고정 오퍼랜드로 나온 레지스터는 뺀다.
  - Sol(Opus) 8개로 전체를 나눠 원문을 추출한다.
- 원문 근거 자료:
  - `data/rules/sdm_symbols.csv`(`scripts/build_sdm_symbols.py`): 총론 3.1.1.1~3.1.1.5 표기 정의 101항목. 원문 345줄 전부 한 번씩 포함, 해석 열 없음.
  - `scripts/extract_table_footnotes.py`: 1단계와 같은 표 추출에서 위첨자 각주를 `^n`으로 보존한다. 4,210행이 isa_db와 순서·값 모두 일치했다. 각주 있는 행은 281개이고, 각주 본문을 못 찾은 26개는 대부분 GF2P8 니모닉 숫자를 각주로 잘못 잡은 것이다.
  - `pipeline/sdm_evidence.py` → `out/sdm_evidence_2026-10-09/rows.jsonl`: 행별 표 원문 셀, 각주, Op/En 줄, Description.
  - 매뉴얼 색인 v3: 제목이 묶음 표기(`VF[,N]MADD[132,213,231]PH` 등)인 절도 그 쪽 표 행의 니모닉으로 연결한다. 소속 절이 없던 120행이 0행이 됐다.
- "정의 없는 표기" 점검: 1,999건 중 1,821건은 원문 쪽에 글자 그대로 있어 파싱 오류가 아니다. 178건은 오퍼랜드가 없는 행의 빈 값이다.
- 주 에이전트 독립 판정 `out/sdm_review_2026-10-09/main_symbol_spec.csv`: 총론 정의 문구만 기계적으로 읽었고, Sol 결과를 보기 전에 시각·해시를 기록했다.
  - 오퍼랜드 9,820개 중 7,766개는 총론 정의, 190개는 고정 표기, 178개는 오퍼랜드 없음, 1,686개는 총론 정의 없음(zmm, xmm/ymm bcst, tmm, mem 등).
- 터미널 조회의 `rules`를 `symbols`(원문 정의)로 바꿨다. 회귀 112개 통과.

## 2026-10-10 [검토] Sol 8개 part 완료, 주 에이전트 판정과 대조

- part1은 CSV 두 개만 있고 notes가 없었다. 보조 스크립트를 다시 실행해 저장본과 바이트 동일함을, `verify.py`로 인용 664개가 원문에 있음을 확인했다. 그 뒤 `sol_part1_notes.md`를 썼다. 이어 쓸 때 형식 참고로 part2 notes를 열었고, 이 경위를 notes에 적었다.
- `main_symbol_spec_record.txt`의 sha256과 현재 파일 해시가 다르다.
  - 두 파일의 수정 시각은 17:02:00으로 같고, Sol 결과(20:25~)보다 앞선다.
  - 현재 모듈로 재계산한 9,452줄이 모두 같았다. 사후 수정 흔적은 없고 기록 결함으로 본다. 처음 해시의 대상은 확인하지 못했다.
- 대조 도구 `pipeline/sdm_review_compare.py`, `scripts/compare_sdm_review.py`를 추가했다. 결과는 `out/sdm_review_2026-10-09/compare/`(REPORT.md, operands.csv, row_conditions_review.csv, summary.json)에 있다.
  - 오퍼랜드 9,643줄 중 종류 일치 7,307, 불일치 502, Sol만 값 1,410, 둘 다 없음 276, 고정 표기 분류 차이 147이다. 폭 숫자끼리 다른 줄은 0이다.
  - 불일치 478줄은 main 문구 규칙 결함이다(SYM065/070의 "register or 256/512-bit memory operand"를 memory로 분류). main 파일은 보존했다.
  - Sol 원문 없음은 1,016줄이고 그중 zmm 단독 폭이 650줄이다. 원문 충돌은 257줄과 행 조건 21개다.
  - part 사이 기준 차이: zmm 단독 폭을 part1은 512로 확정했고, 다른 part는 대부분 원문 없음이나 빈칸으로 두었다.
- 검증: 새 회귀 8개(손으로 만든 반례)를 포함해 전체 127개가 통과했다. 줄 수(9,642+1)와 행 조건 수(21+1)를 독립 집계로 확인했다. 생성 코드, Sol 파일, main 파일은 수정하지 않았다. 사용자 확인 항목 6개는 REPORT.md에 있다.

- 보충(같은 날, 직전 세션 기록 `c42d9a2f` 확인 후):
  - 직전 세션에서 정한 "전 part 같은 기계적 기준으로 status 재판정"을 처음 대조에서 빠뜨렸다. 이를 `uniform_status`로 추가했다.
    - 기준: 종류·폭이 모두 원문으로 채워져야 확정이다. 단독 zmm에 폭이 있으면 결정 대기다. Sol 원래 status는 보존한다.
    - 결과: 원문 확정 8,127 / 원문 없음 1,220 / 원문 충돌 257 / 결정 대기 39. 바뀐 243줄의 part별 내역은 REPORT.md에 있다.
  - part1은 10-10 09:41에 한도로 멈췄고, part5에 보낸 zmm 폭 기준 지시를 받지 못했다. part1 notes에 이 사실과 27줄의 차이를 적었다.
  - 직전 세션의 미기록 변경:
    - `pipeline/manual_lookup.py`: 묶음 제목 절(SETcc 등)의 표 행을 `table_mnemonics`로 찾게 했다.
    - part5 단독 zmm 61줄을 원문 없음으로 수정했다(Sol이 수정, 94줄 변경).
    - part3 보고의 "1560행 660F 오기"는 실제로 1562행이다.
  - 회귀: 대조 테스트 10개.

## 2026-10-10 [검토] Sol 인용 원문 확인, 재검토 결과를 최신 생성 케이스에 연결

- `pipeline/quote_check.py`, `scripts/verify_sol_quotes.py`로 전 part의 고유 인용 7,658개를 쪽 원문·표 셀·SYM 원문과 대조했다.
  - exact 7,258, nospace 63, nohyphen 156, table_label 147, 못 찾음 34.
  - 34개는 낱말 단위 비교로 수동 분류했다(`quote_not_found_review.csv`): 추출 흔적 21, Sol 가공 표기 7, 원문 오타·구두점 수정 6. 지어낸 인용은 없었다.
  - 첫 실행은 표 인용 2,068개를 못 찾았다. 원인은 표 인용이 쪽 텍스트가 아니라 표 셀 원문을 옮긴 것이기 때문이었다. 표 인용은 표 셀과도 대조하도록 고쳤다.
- `scripts/map_review_to_combos.py`로 행 상태(공통 기준과 행 조건)와 1단계 추출 결함을 `generator_audit_2026-10-09_mode_address/combos.csv`에 연결했다.
  - 원문 확정 행에서 나왔고 추출 결함도 없는 케이스는 15,938/23,199다. 나머지는 원문 없음 5,399, 원문 충돌 1,429, 결정 대기 170, 추출 불완전 1이고, 원문 확정 행이지만 추출 결함이 있는 케이스가 262다.
  - 추출 결함 91행(332 케이스)은 기계 판정이다. x87·XACQUIRE의 op_en 빈칸은 원문에 열이 없어 제외했다.
  - isa_db와 table_cells는 같은 추출에서 나와 독립 근거가 아님을 확인했다(차이는 하이픈 분철 4행뿐).
- 원문 확정 행이라도 생성기가 고른 대표값이 원문 제약을 지키는지는 확인하지 않았다(REPORT.md 추가 2).
- 검증: 손으로 만든 반례 회귀를 추가했다(인용 대조 10, 행 상태·추출 결함 2). 행·케이스 합계, row_id 대응, 충돌 행 수(212∪22=233)는 독립 집계로 검산했다. 전체 회귀 통과. 생성 코드, isa_db, Sol/main 파일은 수정하지 않았다.

## 2026-10-10 [결정 반영] 사용자 결정 1·3·4·5, VEX.L 충돌 실측

- 결정 1(zmm 단독 폭은 원문 없음), 결정 4(표에 이름이 적힌 고정 레지스터는 폭 문장 없이 확정)를 `uniform_status`에 반영했다. 반례 회귀를 추가했다.
  - 상수 `1`, `r8`, `Sreg`, `sibmem`은 고정 레지스터가 아니다. `<eax>`, `<edx>`는 고정 레지스터다.
- 결정 5: `sdm_symbol_spec.KIND_PHRASES_FIXED`와 `scripts/build_main_rulefix.py`를 추가했다.
  - 원본 규칙 재계산이 원본 파일과 다르면 멈추도록 했다. 바뀐 칸은 SYM065 366줄과 SYM070 112줄의 종류뿐이다. 원본 해시는 그대로다.
- 결정 3: 원문 충돌 예외 목록 `data/rules/source_conflict_cases.csv`(VEX.L 13행)와 `scripts/check_source_conflicts.py`(GNU/Clang 조립, VEX.L 비트, `--execute` 시 CPU 실행)를 추가했다.
  - 실측(Core Ultra 5 226V): 대조군 정상. VEX.256 11행은 정상 실행돼 예외 목록과 반대다. VEXTRACTPS·VINSERTPS는 L=0 정상, L=1 SIGILL이다.
  - 통과한 13행은 영향 연결에서 `예외 등록·실측 확인`으로 둔다.
- 결정 2 재확인: PDF 쪽 그림으로 확인했다. 실제 차이는 51줄, Sol 오분류 3줄, 유형 오분류 1줄(PCLMULQDQ)이다. EVEX 용어 설명과 함께 재질문 중이다.
- 반영 뒤 최신 케이스 23,199개 중 사양을 신뢰할 수 있는 것은 16,056개다. 전체 회귀 통과.
- 같은 날 추가 결정:
  - 2: EVEX 문단 51줄은 3번과 같은 방식으로 처리한다. 예외 목록에 21행(`EVEXD-01~21`)을 등록했다. 레지스터·메모리·broadcast 형식 62개가 GNU/Clang 바이트 동일, EVEX L'L 일치로 통과했다. avx512f가 없어 CPU 실행은 하지 않았다.
  - 4 추가: 고정 상수 `1`도 확정이다.
  - 6: Sol 단독 1,410줄은 생성기 재작성 때 대조한다.
- 대조 스크립트: 형식 여러 개, EVEX L'L, CPU 플래그 확인, verdict를 추가했다. 결과 파일 이름은 `conflict_tests/results.csv`다. 바이트 해석 회귀 4개는 손 계산 바이트로 만들었다.
  - 영향 연결은 모든 형식이 통과한 등록 행만 충돌 해소로 본다.
- 결과: 신뢰 가능 케이스 16,367/23,199. 남은 원문 충돌 198행(1,162 케이스)은 아직 등록하지 않은 다른 유형이다. 전체 회귀 통과.

## 2026-10-10 [검토] 남은 원문 충돌 198행에 '표 기준 + 예외 하드코딩 + 대조' 적용

- 사용자 결정: 남은 충돌도 같은 원칙으로 처리한다.
- `scripts/check_conflict_rows.py`:
  - 대상: Sol 상태로 계산한 충돌 행에서 VEX.L·EVEX 34행을 뺀 198행이다.
  - 최신 snapshot 케이스 1,162개를 GNU/Clang으로 조립하고 `check_encoding`으로 표 opcode와 대조한다.
  - 도달하지 못한 케이스는 의사 접두어로 강제하고, 지원 CPU에서는 실행한다.
- 하드코딩 추가:
  - `encoding_check_overrides.csv`(16행): 대조 도구가 읽지 못하는 표기(`/ib`, `!(11)`, `/vsib`, 소문자 opcode, MAP5)와 원문 누락을 근거와 함께 보정했다. VFIXUPIMMPS 128/256 `ib`, VREDUCESD `/r ib`는 PDF 그림으로 확인했다.
  - `unreachable_forms.csv`(MOVQ/VMOVQ 별칭 6행).
  - SAHF 예외 MODE-01.
- 결과:
  - 198행 = 통과 136 + GNU 단독·도달 불가 포함 57 + 음성 확인 4 + SAHF 예외 1.
  - 저장형 `{k1}{z}` 메모리 목적지는 두 도구 모두 거부했다(Operation·SYM072 쪽).
  - 영향 연결 후 원문 충돌 0행이다. 신뢰 가능 케이스는 17,302/23,199다.
- 관측(확정 아님):
  - clang은 moffs 64비트 주소를 ModRM disp32로 바꾸어 냈다.
  - clang은 `rex64`를 받지만 REX.W를 내지 않거나 67 앞에 놓았다.
  - 9월 29일 기록과 같은 계열로 보인다.
- 수정:
  - 대조 스크립트 이름을 `scripts/check_source_conflicts.py`, `scripts/check_conflict_rows.py`로 바꿨다. tests의 동명 모듈과 충돌했기 때문이다.
  - 대상 행을 영향 연결 결과에서 읽어 재실행 시 0행이 되며 결과 파일을 비우던 결함을 고쳤다. 대상은 Sol 상태에서 직접 계산하고, 0행이면 쓰지 않는다.
- 검증: 판정·하드코딩 반례 회귀 5개를 추가했다(MAP5 패턴 반례 4개, 보정 opcode 반례 포함). 전체 회귀 통과, 처음부터 재실행해 같은 수치를 확인했다.

## 2026-10-10 [검토·도구] 추출 결함 보정, 대조 도구 표기 확장, 전체 도달 지도

- 추출 결함 91행:
  - `scripts/build_extraction_corrections.py`가 PDF 텍스트에서 보정값과 근거를 찾아 `data/rules/extraction_corrections.csv`에 기록했다. 90행을 확인했다.
  - VMOVD `6E /`는 PDF 원문 오기다(그림 확인). 앞선 '추출 결함' 기록을 정정했다.
  - 결함 행 케이스 332개를 대조했다. LAR·LSL 레지스터 형식은 재심 D절에 따라 도달 불가(문법)로 하드코딩했다.
- `pipeline/encoding_audit.py`: 총론에 정의된 표기를 해석하도록 확장했다.
  - NP, NFx, MAP5/6, NDS, /is4, /ib, imm8, SYM087 ModRM 표기, +i, +r, 철자 차이.
  - 회귀 14개(반례 포함)를 추가했다. 이전 snapshot의 encoding_audit.csv는 다시 만들지 않았다.
- `check_conflict_rows.py --target all`: 전체 23,199 케이스 도달 지도를 만들었다(약 6분).
  - 행별 하드코딩 85행(PDF 오기, ib 누락, SETcc, FWAIT 쌍, 접두어 행)을 근거와 함께 추가했다.
  - LAHF 예외 MODE-02를 추가했다.
- `scripts/build_generator_issues.py`: 남은 91행을 유형별로 분류했다(기타 0). 생성기 재작성 입력이다.
- 영향 연결에 도달 판정을 넣었다. 사양 신뢰 17,568, 도달 22,987, 둘 다 17,356(75%).
- 검증: 전체 회귀 통과. 대조 스크립트 세 대상(conflicts, defects, all)을 처음부터 다시 실행했다.

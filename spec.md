# 수정·보완 구현 계획 — 승인 대기

## 1. 결정 필요

[제안] 아래 D1~D5는 형섭이 결정한다. 선택된 값과 수락 기준을 이 문서에 기록하고 **형섭이 spec.md를 승인하기 전에는 실제 코드 수정에 착수하지 않는다.** 선택지가 나열된 것은 선택·승인을 의미하지 않는다. 보고서 9절의 질문과 8절의 작업 순서를 그대로 전제로 한다.

### D1. 실제 퍼징 대상

[제안] 대상에 따라 입력 채널과 실패의 주체가 달라지므로 프레임워크 형태도 달라진다. 다음 중 대상과 도구의 역할을 선택한다.

| 선택지 | R1에 미치는 영향 | R2에 미치는 영향 | R3에 미치는 영향 |
|---|---|---|---|
| [제안] 어셈블러 파서 | 텍스트 입력과 정상 거부(`diagnostic_rejection`)도 반드시 보존. 파서 크래시·timeout을 폐기 대상에 섞지 않음 | SDM 행이 없는 입력도 허용하고 `expected_form=null`로 기록. 인코딩 판정은 조립된 입력에만 적용 | 대상 어셈블러의 사건과 관측용 objcopy/objdump/readelf 장애를 구분. 수집 완료와 검증 완료를 분리 |
| [제안] 디코더 | 입력 채널이 raw bytes. 어셈블러가 생성하지 못하는 바이트도 보존 | 소스·SDM 기대 행은 선택 항목. 바이트·모드가 입력 식별의 기준이 됨 | 디코더가 대상인지 보조 검사기인지 역할을 명시. 해독 거부, 디코더 크래시, 하네스 실패를 구분 |
| [제안] 에뮬레이터·JIT | 코드와 초기 상태·관측된 예외가 한 사례의 입력/결과가 됨 | 인코딩 일치만으로 의미 일치를 판정할 수 없음. 정의된 초기 상태·실행 의미의 비교가 추가로 필요 | 필수 검사의 목록에 상태 설정·실행·결과 수집이 추가됨. 실행 하네스 오류와 대상 오류를 분리 |
| [제안] CPU | 바이트·초기 레지스터/메모리·CPU/OS 조건·예외를 함께 보존 | 특정 인코딩을 실제 실행했는지와 정상적인 예외인지 확인하는 계약이 필요 | R9 실행 제한이 선행 조건. 실행기 실패와 명령어의 예상 예외를 분리 |

[제안] 디코더·에뮬레이터·CPU용 실제 입력/실행 어댑터를 지금 선행 구현하지 않는다. 선택 후 P0의 데이터 계약을 확정한다. CPU를 선택해도 실행은 형섭이 수행한다.

[사용자 결정] 다음 프로젝트의 실제 퍼징 대상은 아직 정하지 않는다. 현재 구현은 특정 대상에 종속되지 않는 관측·판정 프레임워크로 진행하고, 대상별 어댑터와 실행 의미 검증은 후속 결정 뒤에 붙인다. 따라서 D1은 현재 P0 구현을 막지 않으며, 대상이 정해지기 전까지 어셈블러 경로의 관측을 기본 예시로 유지한다.

### D2. 연구의 성공 기준

| 선택지 | R1~R3 설계에 반영할 차이 |
|---|---|
| [제안] 도구 결함 발견 | R1 사건 보존·재현 횟수를 중심으로 하고, R2 차이는 조사 단서로 보존. R3는 대상에서 관측한 실패와 실험을 못 한 실패를 구분해야 함 |
| [제안] 입력 의도 보존 | R2의 기대 행·정책·실제 인코딩 연결을 필수로 함. R1 실패 시 의도 판정은 미완료. R3는 기대 행 검사 누락을 완료로 세면 안 됨 |
| [제안] 조사 비용 감소 | R1 원시 기록과 R2 설명 가능한 차이를 보존. R3 수집/검사별 시간·미완료 이유가 후속 평가에 연결되어야 함 |

[제안] 복수 목표라면 주 지표와 보조 지표를 형섭이 지정한다. 어떤 선택도 크래시 보존이나 필수 검사 실패 전달을 제거하지 않는다.

[사용자 결정] 현재 단계의 주 성공 기준은 퍼징 효과가 아니다. 파이프라인 설계 오류를 수정하고, 도구가 입력 의도·실제 바이트·검사 실패를 정확하게 기록하며, R1~R3의 수락 조건을 만족하는 것이 우선이다. 퍼징 대상별 효과·조사 비용·검출률은 D1과 함께 후속 논의한다.

### D3. 의미가 같은 다른 인코딩 허용 / 특정 SDM 행 필수

[재집계—기존 감사] 감사 JSON의 `counts.accepted_opcode_fields.different_encoding=118`과 `accepted_different_encoding`은 **현재 비교기가 불일치로 표시한 accepted 행**의 기록이다. 이 118건 전체의 의미 동등성을 입증한 결과는 아니다.

| 선택지 | R2의 처리 | R1·R3와의 관계 |
|---|---|---|
| [제안] A: 의미가 같은 다른 인코딩 허용 | `encoding_policy=allow_equivalent`. 검증된 동등성 근거가 있는 다른 인코딩은 통과 가능. `target_encoding_not_exercised` 관측은 보존하되 그것만으로 정책상 탈락시키지 않음. 동등성이 미확인이면 `equivalence=unknown`, 검토 대상으로 보존 | 크래시·timeout·검사 장애는 허용 근거가 될 수 없음. 동등성 판단에 필요한 검사가 실패하면 통과 불가 |
| [제안] B: 특정 SDM 행을 반드시 시험 | `encoding_policy=require_target`. 지정 행 불일치는 입력을 수용했어도 해당 목표 시험에 실패한 것으로 처리. 의미가 같은 다른 인코딩이어도 정책상 통과시키지 않음 | R1의 조립 수용 관측은 보존. R3에서 기대 행 검사를 필수로 취급하고 미검사는 목표 시험 완료에서 제외 |

[제안] 동일한 불일치 행은 A에서 동등성이 확인되면 `policy_decision=pass`, B에서는 `policy_decision=review`가 된다. 두 경우 모두 `as.status=accepted`라는 관측을 거짓으로 바꾸지 않는다. 보고서 R2의 `target_encoding_not_exercised` 기록 요구도 양쪽에서 유지한다. CLI·API·배치에 같은 정책을 전달하고 정책을 판정 키에 넣는다. 무인 기본값으로 A나 B를 선택하지 않는다.

[사용자 결정] 정책은 A(의미가 동일한 인코딩 허용)로 정한다. 단, 의미 동일성의 근거가 없는 불일치는 자동 허용하지 않고 `equivalence=unknown` 또는 검토로 남긴다. 그러므로 118건을 일괄 accepted로 확정하거나 bug로 승격하지 않는다.

### D4. 우선 명령군·실행 모드·정의되지 않은 동작 제외 기준

| 선택지 | R1~R3 설계에 반영할 차이 |
|---|---|
| [제안] 기존 재심 명령군부터 제한 | R2의 기대 행과 검증 근거를 제한된 명령군으로 묶고 R3의 필수 검사 목록을 그 범위에 맞춤. R1은 범위 밖 입력도 보존하되 범위 밖임을 기록 |
| [제안] 기존 생성 입력 중 형섭이 정한 명령군부터 제한 | 같은 구조에 선택 명령군 목록·버전을 기록. 선택되지 않은 행을 오류/성공으로 자동 변환하지 않음 |
| [제안] 정의된 전제조건이 충족된 사례만 의미 평가 | R1 예외는 기록하고 R2 의미 비교는 정의된 사례에 한정. R3는 전제조건 미확인을 `context_required`로 남김 |
| [제안] 정의되지 않은 경우도 견고성 관측에 보존 | R1 사건 수집에는 포함하지만 의미 정확성 지표에서는 제외. R2에 의미 정답을 부여하지 않고 R3는 수집 완료만 인정 |

[제안—확정된 범위의 이행] 이번 구현의 입력 문법은 Intel, 실행 모드는 기존 x86-64 범위다. 형섭이 이 안에서 우선 명령군·필요한 CPU/OS 조건을 정한다. 16/32비트 모드 확장은 이번 선택지에 포함하지 않는다. R1~R3 키에는 실제 모드·옵션을 보존한다.

[사용자 결정] 지금 특정 명령군을 별도로 고정하지 않는다. 우선 현재 Intel x86-64 파이프라인에서 이미 생성된 범위의 설계 오류를 대상으로 R1~R3를 보완하고, 후속 명령군·정의되지 않은 동작·CPU 조건은 결과를 보며 정한다. 이 결정은 새 니모닉이나 사례를 추가한다는 뜻이 아니다.

### D5. 도구를 붙이지 않은 기존 방식보다 나아졌다는 인정 기준

| 선택지 | R1~R3 설계에 반영할 차이 |
|---|---|
| [제안] 동일 시간·CPU 예산의 오류 검출 개선 | R1 재현 가능한 사건·시간, R2 분류와 R3 실패/비용을 실행별로 연결. 근본 원인별 집계는 R10 이후 |
| [제안] 의도 불일치 검출의 정확도·놓침 감소 | R2 결과를 독립 기대값과 대조할 식별자 보존. R1/R3로 검사하지 못한 사례를 분모에서 숨기지 않음 |
| [제안] 조사 시간·잘못된 폐기 감소 | R1 원시 입력 보관 위치, R2 정책 결정 사유, R3 완료/미완료 내역을 함께 저장해 사후 추적 가능하게 함 |

[제안] 지표·예산·허용 오경보/미탐·반복 횟수·성공 문턱은 형섭이 승인할 실험 계약에 남긴다. 이번 spec에서 수치 목표를 대신 결정하지 않는다.

[사용자 결정] 이번 단계에서 비교 기준은 “기존 파이프라인 설계 오류의 수정과 재현 가능한 판정”으로 한정한다. 도구를 붙이지 않은 퍼징과의 우열, precision/recall, 검토 시간은 추가 협의 후 D5의 후속 실험 계약으로 정한다.

### 문서의 근거와 적용 규칙

[제안] 아래 표기를 모든 현재 사실과 계획에 적용한다. `[실측]`, `[재집계]`, `[실패 주입]`은 별도 표시가 없으면 **지정된 기존 감사 기록의 인용**이며 이번에 실행했다는 뜻이 아니다. `[코드 검토]`는 읽은 분기·필드의 존재만을 뜻한다. 실행으로 검증하지 않은 예상 동작·테스트·예상치는 모두 `[제안]`이다.

[코드 검토] 참조 문서는 [CLAUDE.md](CLAUDE.md), [PIPELINE](docs/PIPELINE.md), [판정 기준](docs/RESULT_VALIDITY_AND_BUG_CRITERIA.md), [HANDOFF](docs/HANDOFF.md), [검토 보고서](docs/FUZZING_RESEARCH_REVIEW_2026-09-15.md), [감사 JSON](out/review/fuzzing_audit_2026-09-15.json)이다. 아래 `R1`~`R10`은 보고서 5절, 순서 번호는 보고서 8절을 가리킨다. 현재 CLAUDE.md는 번호가 붙은 7절 대신 「작업 기준」에서 근거 없는 버그 확정을 금지하고 있다.

[제안—확정된 범위의 이행] 이번 산출물은 spec.md 한 개다. 코드·CSV·결과, 다른 문서, 파일명과 폴더 구조는 수정하지 않는다. 스크립트도 이번에는 만들지 않는다. 뒤의 파일/함수/명령은 승인 후 구현할 명세이며 현재 제공되는 실행 기능이라는 뜻이 아니다. Ubuntu/WSL 실행과 결과 전달은 형섭이 담당한다.

## 기존 미결 사안

[코드 검토] 편집 전 378바이트 문서의 내용은 아래에 보존한다. 세 사안의 과거 계획과 재심 근거를 연결하는 메모이며, 이번 계획이 이를 재판정하지 않는다.

### 재심 작업 상태

2026-09-03의 재심 작업 지시서는 [과거 계획](archive/prototypes/spec_2026-09-03.md)으로 보관했다.
현재 결론·원시 실험·미검증 범위는 [2026-09-14 재심 보고서](docs/CASE_REVIEW_2026-09-14.md)에 있다.

현재 도구 사용법: [TOOL_GUIDE](docs/TOOL_GUIDE.md).
현재 단계별 구조: [PIPELINE](docs/PIPELINE.md).

## 2. 상태값 분류 재설계 — R1 + R5

### 2.1 현재 경로 → 분리할 기록

| 구분 | 현재 기록과 근거 | 분리할 기록·판정 조건 |
|---|---|---|
| 입력 생성 오류 / 기대 SDM 행 선택 실패 | [실측] `live_expected_row_probe`: `add ecx, ecx`, 기대 `03 /r`, 실제 `01c9`; 배치 `accepted`, 기대 행 지정 API `needs_review`. [코드 검토] 일반 `sdm.form_match`는 입력이 DB 후보와 맞는지만 확인하며 생성자가 지정한 행 선택과 다름 | [제안] `intent.encoding_target_match={fields_match,different_encoding,unknown}`와 진단 `target_encoding_not_exercised`를 별도 기록. 생성기 귀책은 재심 근거가 있을 때만 `finding_type=input_generation_error`. 문자열 불일치나 어셈블러의 다른 인코딩 선택만으로 생성기 버그 확정 금지 |
| 문법 거부 | [실패 주입] `injected_assembler_results`: 반환값 `1`, `-11`, `-6` 모두 최종 `rejected` | [제안] 문법 진단과 함께 종료한 관측은 `diagnostic_rejection`. 정상적인 잘못된 입력 거부임을 평가하는 기대값은 별도. 내부 오류·신호·timeout은 여기에 포함하지 않음 |
| 대상 도구의 기능 미지원 | [코드 검토] UDB는 `static_findings()`의 `support_gap`과 as 거부로 표현. 모든 거부를 미지원으로 분류하는 일반 필드는 없음 | [제안] `support.subject=<도구/버전>`, `support.status=unsupported`와 근거를 기록하되 실행 관측은 `diagnostic_rejection` 유지. 모르는 니모닉·DB 부재만으로 대상 미지원을 확정하지 않으며 근거 없으면 `unknown` |
| 우리 검사기의 미지원 | [재집계] `counts.lint_sdm_form.incomplete=2688`, 이들의 최종 상태는 `needs_review=2635`, `rejected=53`. [코드 검토] CLI `source_records()`의 `unsupported`는 최종 `incomplete`로 바뀜 | [제안] `validation_scope.<check>.status=unsupported`, `subject=checker`, 사유·미검사 필드 보존. 실제 도구 장애와 별도 집계 |
| 검사 도구 실패 | [실패 주입] `injected_batch_inspection_failure`: 전량 `incomplete`, 배치 종료 0, `tool_error=false`. [코드 검토] 현재 원인은 as/Clang의 조립 `status`만 검사하는 배치 집계 | [제안] `validation_scope.<check>.status=tool_failed`, 원인 사건 참조, `required` 여부. 조립 수용은 유지하고 필수 검사 실패를 `validation_complete=false`와 배치 비정상 종료에 반영 |
| 프로세스 크래시 / timeout | [실패 주입] `-11/-6 → rejected`; timeout은 `failure=timeout`, 부분 출력은 비어 있음. [코드 검토] `assemble()`에서 `failure`가 있으면 모두 `tool_error`로 축약 | [제안] 관측 `process_crash` / `timeout` 분리. `returncode`, `signal`, 부분 출력, 원본 입력, 도구 역할, 재현 횟수 보존. 신호 종료 자체로 버그나 OOM을 확정하지 않음 |
| 실행 파일 부재 / 자원·실행 장애 | [코드 검토] `command()`는 모든 `OSError`를 `failure=unavailable`로 기록 | [제안] 파일 부재는 `unavailable`, 증명된 자원 오류는 `resource_failure`, 권한 등 나머지 실행 장애는 `tool_failed`와 errno로 구분. 추정으로 SIGKILL을 자원 부족으로 바꾸지 않음 |
| as의 인코딩 버그 | [코드 검토] 현재 lint의 최종 `status`에는 버그 귀책 종류가 없고, `findings`에 종류를 남기는 구조. `triage.verdict=bug` 단독도 도구를 구분하지 않음 | [제안] 재심이 확정한 경우에만 `finding_type=assembly_encoding_defect`, `component=gnu_as`, `review_status=confirmed`, `verdict=bug`, 증거 참조. 바이트 차이는 자동 승격 근거가 아님 |
| objdump의 표시 버그 | [재집계] 감사의 `triage_verdict.bug=3`. [코드 검토] 현재 세 행 및 `review_verdicts.REVIEW`는 `finding_type=disassembly_defect`, `review_status=confirmed`, `case_id=far_pointer_display` | [제안] 기존 `disassembly_defect`를 유지하고 `component=objdump`, `display_syntax=intel`, 버전·증거를 함께 기록. as 결함과 별도 집계. 기존 세 행의 등급·귀책을 바꾸지 않음 |

[코드 검토] 따라서 현재 bug=3의 **표시 결함 여부는 `finding_type`까지 읽으면 구분된다.** 최종 `verdict=bug` 또는 lint `status`만 읽으면 구분되지 않는다. `observed_findings()`는 원본 입력의 r64, REX.W·opcode·메모리형과 출력의 `FWORD PTR`를 함께 검사한다. 단순 니모닉 목록으로 결함을 붙이는 함수는 아니다.

### 2.2 P0에서 함께 전달할 최소 필드

| 계층 | 기록 계약 |
|---|---|
| [제안] 관측 `observations` | 실제 실행마다 `stage`, `tool`, `role`(대상/보조), `status`, 명령·소스/바이트, `returncode`, `signal`, stdout/stderr, timeout·errno·사건 ID를 기록. `status`는 `accepted`, `diagnostic_rejection`, `process_crash`, `timeout`, `unavailable`, `resource_failure`, `tool_failed`, `skipped`. 보조 명령의 정상 종료에는 `completed`를 사용하며 이를 명령어 수용으로 해석하지 않음 |
| [제안] 검증 범위 `validation_scope` | 입력 `syntax=intel`, 별도 `display_syntax`, 실제 모드, 검사별 `required`, `status`, `checked_fields`, `unchecked_fields`, 이유·관측 ID. 상태는 `checked`, `unsupported`, `tool_failed`, `context_required`, `not_requested`, `not_applicable`, 예약값 `not_expressible_in_this_syntax` |
| [제안] 의도 `intent` | `expected_form_ref`, `encoding_target_match`, `representation_match`, `equivalence={verified,unknown}`와 근거. `fields_match`는 검사한 필드만의 일치이고 전체 행/의미 확인은 아님. `representation_match`도 다른 표시 문법의 문자열을 정규화해 같다고 만드는 필드가 아님 |
| [제안] 사용 정책 `policy` | 형섭이 승인한 `policy_id/version`, 필수 검사 목록, `decision={pass,reject,review,incomplete}`, 결정 이유. 대상 어셈블러가 거부한 사실과 후속 프로그램에 전달할지의 결정은 독립적 |
| [제안] 발견·재심 `findings` | 종류, 귀책 도구, 관측/확정 상태, 근거 실행. 사건 발생과 결함 확정을 분리하고 기존 `legacy_*`·`not_reassessed` 보존 |

[제안] 상위 `status`와 CLI 종료 코드는 위 필드에서 한 함수로 계산한다. 기존 소비자를 위해 `accepted/rejected/needs_review/incomplete/tool_error`의 호환 표시는 남기되 관측을 덮어쓰지 않는다. 코드 0은 승인된 제한 정책 통과, 1은 정책상 거부/검토, 2는 미완료/필수 실행 장애로 매핑한다. 사건 종류의 구별은 상세 필드에 있으며 `process_crash`와 `timeout`을 1의 일반 문법 거부로 축약하지 않는다.

[제안] 배치 종료 코드는 개별 입력 적합성의 합이 아닌 **승인된 수집·검사 계약의 완료 여부**로 정한다. 일반 거부가 있어도 정상 수집은 가능하지만, 필수 검사 실패는 배치 실패다. 대상 크래시를 연구 사건으로 정상 수집한 경우에도 `collection_complete`와 `validation_complete`를 별도 기록한다. D1에서 해당 경로를 확정하며, 전량 필수 역어셈블 실패를 검증 성공으로 표시하는 경로는 두지 않는다.

## 3. P0 작업 — R1, R2, R3

[제안] 착수 조건은 D1~D5 결정·spec 승인, 이어서 3.4의 **수정 전 기준선 수령·대조 완료**다. 구현은 R1 → R2 → R3 순서로 진행한다. 2절의 상태 분리와 4절의 축·키를 같은 데이터 계약으로 사용한다. 아래 함수 중 `신설`은 아직 없는 제안 이름이다.

### 3.1 R1 — 프로세스 실패를 일반 거부에서 분리

#### (a) 수정 위치와 작업

| 파일·함수 | 구현 작업 |
|---|---|
| [제안] `pipeline/instruction_check.py:command()` | 음수 returncode, timeout 예외, FileNotFoundError, 그 외 OSError를 구분. 원시 코드/신호/errno와 부분 출력 보존. timeout 예외의 bytes/str 출력을 구분하고 bytes는 원본을 보존하는 표현도 저장. `failure` 호환 필드를 유지하더라도 사건 정보를 잃지 않음 |
| [제안] 같은 파일 `assemble()` | `classify_process_result()`(신설)를 통해 조립 성공·문법 진단·비정상 종료를 구분. 정상 종료인데 input.o가 없으면 조립 성공 관측과 산출물 검사의 실패를 별도 기록. 확정되지 않은 양수 오류는 문법 오류로 단정하지 않고 진단 분류 미확인을 표시 |
| [제안] 같은 파일 `roundtrip()`, `check_instruction()` | 재조립 크래시를 `reassembly_rejected`로 만들지 않음. GNU/Clang/왕복/옵션 경로의 사건과 입력 `syntax`를 상위 결과까지 전달 |
| [제안] `scripts/asm_linter.py:exit_code()`, `print_text()`, `main()` | 세부 상태와 정책 결정 사유를 JSON/JSONL/text에서 보존. 신호 종료·timeout은 일반 거부와 다른 종료/표시 경로. 상세 결과를 출력 전에 필터링하지 않음 |
| [제안] `pipeline/m13_lint.py:main()` | 고유 소스 관측과 행별 사건 참조를 저장. 새 실행 폴더의 `events/<status>/<observation_id>.json`으로 사건별 보존 위치를 구분. parser 대상이면 정상 거부도 보존 |
| [제안] `tests/test_instruction_check.py`, `tests/test_pipeline.py` | 아래 실패 주입 검증을 추가. 기존 수용 여부·바이트 기대값은 의미가 유지되는지 대조하고 예상 상태 변경만 명시적으로 갱신 |

#### (b) 보고서의 수락 조건 원문

[제안—R1 완료 기준을 그대로 적용]

> 정상 거부, 신호 종료, timeout, 실행 파일 부재를 주입했을 때 서로 다른 상태와 저장 경로로 전달되어야 한다. 크래시·timeout 입력은 일반 거부 필터로 폐기되지 않아야 한다.

#### (c) 실패 주입 테스트 명세

| 제안 테스트 이름 | 주입할 값·위치 | 확인할 값 |
|---|---|---|
| [제안] `test_r1_signal_is_not_diagnostic_rejection` | `subprocess.run`에 `CompletedProcess(returncode=-11/-6, stdout='', stderr='injected SIGSEGV/SIGABRT')`; as/Clang 각각 | `status=process_crash`, signal 11/6, 원본 returncode·입력·syntax 보존. `diagnostic_rejection`으로 저장하지 않음 |
| [제안] `test_r1_normal_rejection_is_preserved` | 조립 호출에 `returncode=1`, 통제된 문법 진단 stderr | `diagnostic_rejection`; parser 정책의 거부 저장 경로에 원본 존재, 자동 bug 없음 |
| [제안] `test_r1_timeout_preserves_partial_output` | `TimeoutExpired(['as'], 1, output=b'partial output', stderr=b'partial diagnostic')`; str 변형도 검사 | `timeout`, 부분 stdout/stderr 보존, timeout 사건 파일·상위 종료 2 |
| [제안] `test_r1_missing_tool_and_oserror_are_distinct` | `FileNotFoundError(2, ...)`, `PermissionError(13, ...)`, `OSError(12, ...)` 각각 | `unavailable` / `tool_failed` / `resource_failure`; errno·실행 파일·입력 식별 보존. 단순 OSError 전부 unavailable 금지 |
| [제안] `test_r1_sigkill_does_not_prove_oom` | `returncode=-9`, 추가 원인 증거 없음 | 신호 9 보존, 원인은 미확인. OOM·도구 bug 자동 확정 없음 |
| [제안] `test_r1_internal_error_is_not_syntax_error` | `returncode=1`, 명시적 내부 오류/sanitizer 진단 fixture | 문법 정상 거부에서 분리하여 비정상 진단 보존. 신호가 없는 경우 signal을 만들어내지 않음 |
| [제안] `test_r1_roundtrip_crash_reaches_cli_and_batch` | 최초 조립·검사는 정상 fixture, 재조립 프로세스만 `-11` | GNU 입력 수용 사실 유지, 왕복 사건은 크래시, 최종 미완료와 비정상 종료 전달. 일반 재조립 거부로 변환되지 않음 |
| [제안] `test_r1_event_retention_by_outcome` | 같은 소스에 정상 거부/-11/timeout/파일 부재를 각각 주입, 임시 실행 폴더 사용 | 각 사건의 저장 경로가 달라지고 CLI·API·배치의 상세 상태가 일치. 사건별 보존 여부를 실제 파일로 확인 |

#### (d) 회귀 위험과 예상 집계

[재집계—기존 감사] 비교 기준은 7,283행, `accepted=4401 / needs_review=2763 / rejected=116 / incomplete=3`이다. 감사 JSON은 실제 저장 결과에서 신호 종료 건수를 따로 집계하지 않았다. 주입한 -11/-6은 실제 대상 크래시 발견 수가 아니다.

[제안] 같은 도구 결과에서 신호 종료·timeout·실행 장애가 없다면 R1만의 상위 호환 집계 변화 예상은 0건이다. 기존 rejected 116건 중 실제 신호 종료가 있는지는 아직 미확인이다. 있다고 가정할 때 그 해당 행만 일반 거부 집계에서 빠지고 사건/미완료로 이동한다. GNU 외 보조 경로에서도 발생할 수 있어 전체 변화의 상한을 116으로 단정하지 않는다. 숫자는 새 기준선을 받고 원시 returncode로 확인한다.

[제안] 회귀 위험은 양수 문법 진단을 내부 오류로 잘못 분류하거나 정상적으로 거부된 사례에서 후속 검사를 필수 실패로 세는 것이다. 거부 뒤에 바이트가 없는 것은 `not_applicable`이고 검사기 장애가 아니다. 기존 `test_missing_tool_and_timeout`, `test_exit_codes`를 위 반례와 함께 검증한다.

### 3.2 R2 — 관측 캐시와 기대 행별 판정 분리

#### (a) 수정 위치와 작업

[실측—기존 감사] `live_expected_row_probe.saved_batch`는 combo_74/row_44의 `01c9`와 기대 `03 /r`를 보존한다. 같은 입력의 `without_expected_row.status=accepted`, `with_expected_row.status=needs_review`다.

[코드 검토] `m13_lint.main()`은 소스 문자열로 **판정까지 포함한 결과**를 캐시한 뒤 GNU 바이트의 `opcode_fields`만 별도로 계산한다. `check_instruction()`에 기대 행을 단순 추가하면, 현재 `expected_encoding.status != fields_match` 분기가 `different_encoding`뿐 아니라 `not_checked`도 `needs_review`로 바꾼다. 따라서 118건만의 수정으로 끝난다고 가정할 수 없다.

| 파일·함수 | 구현 작업 |
|---|---|
| [제안] `pipeline/instruction_check.py:check_instruction()` | `collect_observations()`와 `evaluate_observations()`(신설)로 관측과 판정을 분리. 외부 도구를 호출하지 않는 판정 함수에 기대 행·검사 정책·syntax를 전달. 기존 공개 API는 이 두 단계를 조합 |
| [제안] 같은 파일 `evaluate_observations()` | GNU와 활성화된 Clang 각각의 기대 필드를 비교. 목표 불일치·미검사·동등성 미확인을 별도 이유로 남기고 D3 정책을 적용. 어떤 도구의 목표 행 일치가 필수인지는 D1/D2의 도구 역할 계약에 포함 |
| [제안] `pipeline/m13_lint.py:main()` | 소스의 원시 관측만 캐시하고 매 행의 실제 `expected_form_ref`로 별도 평가. 추가 사례의 `expected_opcode`도 누락하지 않음. `observations.jsonl`과 `results.csv`를 관측 ID·판정 키로 연결하고 행 수와 고유 관측 수를 따로 집계 |
| [제안] `scripts/asm_linter.py:main()`, `exit_code()` | 기존 `--expect-row`에 승인된 정책·syntax를 함께 전달. API·배치와 같은 평가 함수를 사용. 지정 행이 없는 입력을 row 0 등으로 대체하지 않음 |
| [제안] `pipeline/operand_forms.py:check_opcode_template()` | 기존 부분 비교 범위를 확대하지 않고 checked/unchecked·reason을 보존. 비교기가 해석하지 못하는 구조를 target 불일치의 확정 근거로 사용하지 않는 보호 조건 추가 |
| [제안] `tests/test_instruction_check.py`, `tests/test_pipeline.py` | 행·정책·syntax에 따른 캐시 분리와 세 진입점 일관성 검증. 기존 opcode 부분 검사 테스트의 `meaning_verified=False` 유지 |

[제안] 판정 키는 `(source_hash, syntax, display_syntax, manual_hash, db_hash, expected_form_ref, policy_hash, observation_id)`로 한다. `syntax`는 원본 입력 문법이며 값은 `intel` 하나다. `display_syntax`는 별도 표시 경로의 값이다. 관측 ID는 도구·버전·옵션·모드까지 묶은 관측을 가리킨다. 세부 증거 연결은 4절의 R8 이음새를 따른다.

[제안] 관측 캐시 키는 `(source_hash, syntax, mode, toolchain_hashes, effective_options, display_syntax, observer_version)`로 한다. 기대 행과 정책은 관측 캐시 키에서 제외하고 판정 키에만 넣는다. `effective_options`에는 실제 헤더/타깃 설정도 포함한다. 동일 캐시 객체를 기대 행 평가 중 수정하지 않아야 여러 행에 판정이 섞이지 않는다.

#### (b) 보고서의 수락 조건 원문

[제안—R2 완료 기준을 그대로 적용]

> 같은 입력·기대 행·정책을 주었을 때 세 진입점의 판정이 같아야 한다. 위 118건은 정상 동작 가능성을 유지하면서도 `target_encoding_not_exercised` 등으로 명시해야 한다.

[제안] 위 진단의 근거가 기존 비교기 결과인지, 바이트를 독립 확인한 결과인지도 기록한다. 118건을 모두 동등성 확인 또는 생성기/어셈블러 버그로 변환하지 않는다. `target_encoding_not_exercised`는 비교기 근거가 충분한 경우의 관측명이며, 비교기 자체 미지원이면 `target_encoding_unverified`와 기존 불일치 관측을 함께 보존한다.

#### (c) 실패 주입·진입점 테스트 명세

| 제안 테스트 이름 | 주입할 값·위치 | 확인할 값 |
|---|---|---|
| [제안] `test_r2_expected_row_reaches_all_entrypoints` | 원시 조립 바이트 `01c9`; 실제 기준선 row_44 `03 /r`; 원본 `add ecx, ecx`. CLI/API/배치에 동일 정책·syntax | 세 결과의 `encoding_target_match`·정책 판단·이유가 일치. 상위 집계도 세부 이유를 보존 |
| [제안] `test_r2_one_source_two_expected_rows` | 한 관측 `01c9`, fixture 기대 행 A=`01 /r`, B=`03 /r` | 관측 수 1, 서로 다른 판정 키 2, A 필드 일치/B 불일치. 먼저 평가한 행의 판정이 다른 행에 섞이지 않음 |
| [제안] `test_r2_policy_changes_decision_not_observation` | 불일치 관측 하나, 통제된 동등성 근거 fixture 유/무 × `allow_equivalent/require_target` | 근거 있음: 허용 정책 pass, 행 필수 정책 review. 근거 없음: 허용 정책도 의미 확인으로 승격하지 않음. 바이트·조립 status 불변 |
| [제안] `test_r2_unchecked_template_is_not_match` | `check_opcode_template` 결과 `not_checked`, reason=`지원하지 않는 opcode 템플릿` | `encoding_target_match=unknown`, scope unsupported. 자동 fields_match/target 불일치/bug 없음 |
| [제안] `test_r2_template_layout_is_not_opcode_prefix` | 감사 combo_1034의 입력 `enter 0x100, 1`, 기대 `C8 iw 01`, 저장 바이트 `c8000101`를 fixture로 사용 | 중간 `iw` 뒤의 상수 01을 연속 opcode 바이트로 가정하지 않음. 이 구조를 아직 해석하지 못하면 unknown으로 남기고 근거 미확인을 표시. 전체 immediate 디코더 구현은 하지 않음 |
| [제안] `test_r2_semantic_equivalence_is_not_assumed` | 감사에 저장된 combo_4083의 기대 `CB`, 실제 `c3`를 고정 fixture로 사용 | 두 도구의 바이트 일치만으로 기대 인코딩과의 동등성 근거를 만들어내지 않음. 새 ISA 결론/등급 부여 없이 unknown 보존 |
| [제안] `test_r2_cache_key_includes_syntax_and_display` | 같은 소스/바이트/기대 행, `syntax=intel`, `display_syntax=intel/att`; 정책 ID도 변경 | 관측·판정의 표시 경로가 충돌하지 않음. 지원하지 않는 입력 `syntax=att`는 초기 unsupported로 차단하고 Intel 캐시를 사용하지 않음 |
| [제안] `test_r2_supplemental_expectation_and_no_row` | 추가 사례형 `{case_id, expected_opcode}`와 기대 행 없는 입력 각각 | 추가 사례는 독립 기대값을 전달하고, 기대 행 없는 경우 `not_requested`; 다른 행의 기대값 재사용 금지 |

[코드 검토] ENTER 보호 테스트의 이유는 `check_opcode_template()`가 모든 2자리 hex 토큰을 모은 뒤 연속 opcode로 비교하는 구현에 있다. 감사 JSON은 combo_1034를 실제로 불일치 목록에 포함한다. [제안] 이 구조의 현재 판정이 올바른지 독립 기대값으로 확인하기 전에는 118건 전부가 실제 목표 인코딩 실패라고 확정하지 않는다.

#### (d) 회귀 위험과 예상 집계

[재집계—기존 감사] accepted 4,401건의 opcode 필드는 `fields_match=1768`, `different_encoding=118`, `not_checked=2515`다. 이 값은 기존 JSON 인용이고 이번 문서 작성 중 CSV를 새로 집계한 값이 아니다.

| 조건부 시나리오 | 예상 변화 — 실제 실행 결과 아님 |
|---|---|
| [제안] A 정책, 118건 모두 동등성 근거가 있고 다른 판정 변화 없음 | 118건을 정책 통과로 유지: 기존 호환 accepted 4,401 유지. 불일치 진단은 삭제하지 않음 |
| [제안] B 정책, 118건 모두 비교기 근거가 유효하고 다른 판정 변화 없음 | accepted `4401-118=4283`, needs_review `2763+118=2881`, rejected 116, incomplete 3. 118건은 목표 시험 실패이지 버그 수가 아님 |
| [제안] 기대 행을 현재 API에 그대로 전달하는 단순 수정 | `not_checked` 2,515건까지 accepted에서 이동할 수 있어 위 118건 계산과 달라짐. 단순 전달로 수정 완료 처리하지 않음 |
| [제안] 비교기 보호 조건·검증 범위 분리를 함께 적용 | 일부 불일치는 unknown으로, 필수 미검사는 incomplete로 이동 가능. 정확한 수는 새 before/after 행별 결과 없이 산정하지 않음 |

[제안] 위 A/B 계산은 두 정책의 차이를 보이는 가정이다. 동등성 확인·ENTER 등 비교기 한계·Clang 기대값 비교·필수 검사 범위가 실제 분포를 바꿀 수 있으므로 `4283/2881`을 테스트의 고정 정답으로 넣지 않는다. 7,283행 보존, 행별 변경 사유, 관측 바이트 보존을 우선 검증한다.

### 3.3 R3 — 필수 하위 검사 실패를 배치까지 전달

#### (a) 수정 위치와 작업

[실패 주입—기존 감사] `injected_batch_inspection_failure`는 감사 스크립트가 `m13_lint.check_instruction`의 반환값을 가짜 전량 미완료 결과로 대체한 실험이다. 기록은 `exit_code=0`, `manifest.status_counts.incomplete=7283`, `manifest.tool_error=false`, `current_shell_checks_pass=true`다. 실제 objdump가 7,283번 실패했다는 관측이 아니다.

[코드 검토] `current_shell_checks_pass`는 감사 스크립트 안에서 현재 shell 조건을 재현해 계산한 값이다. shell 실행기 자체를 실행한 증거는 아니다. `injected_option_inspection`도 실제 assemble 결과를 받은 뒤 옵션 경로의 `inspection_complete=False`와 objdump 반환값을 덮어쓴 실패 주입이다.

| 파일·함수 | 구현 작업 |
|---|---|
| [제안] `pipeline/instruction_check.py:assemble()` | objcopy/objdump/readelf 각각의 종료·파일 생성·해독 연속성/바이트 일치 검사를 별도 체크로 기록. 검사 프로세스 실패와 복수 명령어/미해독 입력/재배치 문맥을 같은 `tool_failed`로 만들지 않음 |
| [제안] 같은 파일 `roundtrip()`, `evaluate_observations()`, `check_instruction()` | 원조립, Clang, 왕복, 옵션 경로의 필수 체크 실패를 수집. 정상 재조립 거부는 관측 차이이고 도구 장애와 별도. 옵션 검사를 required/optional로 정한 정책을 기록하고 양쪽 모두 실패 사실 보존 |
| [제안] `pipeline/m13_lint.py:main()` | `required_check_failures`, `optional_check_failures`, `unsupported_checks`, `context_required_checks`, 사건 수·행 수·고유 관측 수를 구분. `collection_complete`, `validation_complete`, `truncated`, `policy_id`, 출력 존재·해시를 manifest에 기록. 필수 장애가 있으면 종료 2 |
| [제안] 같은 파일 `validate_manifest()`(신설) | 완료 계약 검증을 공통 함수로 분리. 단순히 상태 이름이 allowed에 있는지 검사하는 것으로 성공을 결정하지 않음. 사례 수는 입력 manifest와 연결하며 변경 후 상태 수치 자체를 고정하지 않음 |
| [제안] `scripts/run_ubuntu_tests.sh`의 lint/`lint_manifest_check` 블록 | 출력 루트를 새 실행 디렉터리로 전달하고 공통 manifest 검사 호출. 종료 2·검사 실패·잘린 결과를 검증 성공으로 출력하지 않음. 기존 경로에 실행 결과를 덮어쓰는 명령으로 승인 후 probe를 수행하지 않음 |
| [제안] `pipeline/run.py:main()`, `scripts/asm_linter.py:exit_code()` | 하위 검사의 미완료·실패를 상위에 전달. run.py에서 단계 프로세스 정상 종료와 의미 검증 성공을 같은 이름으로 보고하지 않음 |
| [제안] `tests/test_instruction_check.py`, `tests/test_pipeline.py` | 하위 도구별 실패부터 manifest/CLI까지 연결되는 테스트 추가. 왕복·옵션 경로 포함 |

#### (b) 보고서의 수락 조건 원문

[제안—R3 완료 기준을 그대로 적용]

> 각 하위 도구 실패를 하나씩 주입하는 검증을 통과해야 한다. 전량 역어셈블 실패 배치는 실패로 종료하고, 알려진 미지원 사례를 포함한 정상 수집 배치는 지정한 정책에 따라 성공할 수 있어야 한다.

#### (c) 실패 주입 테스트 명세

| 제안 테스트 이름 | 주입할 값·위치 | 확인할 값 |
|---|---|---|
| [제안] `test_r3_each_inspector_failure_propagates` | 정상 조립 뒤 objcopy/objdump/readelf 중 하나만 `returncode=1`, stderr=`injected <tool> failure`; GNU/Clang/왕복/옵션 경로를 매개변수로 반복 | 해당 필수 check만 tool_failed, 조립 accepted는 유지, 최종 validation_complete=false·종료 2. optional이면 optional 실패 기록 존재 |
| [제안] `test_r3_success_without_output_is_failure` | 조립 rc=0이지만 input.o 없음; objcopy rc=0이지만 text.bin 없음 | 누락 산출물 체크 실패. 오래된 파일·빈 기본값을 성공으로 사용하지 않음 |
| [제안] `test_r3_decoder_output_integrity_failure` | objcopy 바이트 `89d8`; objdump rc=0인데 파싱 불가능한 출력 또는 연속성 깨진 offset/바이트를 주입 | 출력 파서/무결성 실패를 별도 reason으로 기록. 유효한 바이트 디코딩 거부와 구분 |
| [제안] `test_r3_full_batch_inspection_failure_fails` | 기존 감사와 동일하게 배치의 관측 반환에 필수 objdump 실패를 전량 주입; 원래 사례 목록은 그대로 읽음 | 사례 7,283건 수집, 모든 해당 행의 필수 검사 실패, 배치 rc=2·manifest 검증 실패. 이 테스트 자체는 의도한 실패를 확인했을 때 성공 |
| [제안] `test_r3_optional_inspection_is_not_silent` | `options=['--64']` 경로만 조립 accepted, `inspection_complete=False`, objdump rc=1 | required 정책이면 배치 실패. optional 정책이면 수집 가능하되 optional_check_failures>0와 이유가 결과에 존재 |
| [제안] `test_r3_unsupported_is_not_tool_failure` | `scope.status=unsupported`, reason=`unsupported opcode template`, 도구들은 정상 fixture | tool_failed로 집계하지 않음. 미지원 허용 수집 정책이면 배치 0 가능, 목표 검사 필수 정책이면 미완료. 어느 쪽도 checked로 변환 금지 |
| [제안] `test_r3_context_and_rejection_are_not_infrastructure_errors` | 정상 문법 거부 / relocation 있음 / 정상 재조립 거부 각각 | `not_applicable` / `context_required` / 차이 관측으로 보존. 필수 검사 프로세스 장애와 혼합 금지 |
| [제안] `test_r3_shell_rejects_failed_manifest` | `required_check_failures=1`인데 기존 호환 `tool_error=false`, 또는 결과 누락·truncated=true인 fixture | 공통 검증 및 실제 shell 검사 경로가 비정상 종료. allowed 상태 집합에 맞는다는 이유로 통과하지 않음 |

[제안] 마지막 shell 검증은 3.4의 격리 루트에서 형섭이 실행한다. 이번 감사처럼 조건식만 복제한 테스트와 구분해 실행 명령·실제 종료값을 남긴다. 모든 필수 하위 명령은 R1의 신호/timeout도 같은 경로로 전파되는지 확인한다.

#### (d) 회귀 위험과 예상 집계

[제안] 기존 결과의 필수 검사 실패가 없다면 R3만으로 7,283건의 호환 상태가 바뀌는 예상치는 0이다. 기존 최종 incomplete 3건이 전부 장애라는 근거는 없으므로 이를 tool_failed 3건으로 예약하지 않는다. 옵션 경로의 숨은 실패 여부도 새 기준선으로 확인한다.

[제안] 전량 실패 주입에서는 7,283건 모두 필수 검사 미완료로 남고 batch 종료값이 기존 0에서 2로 바뀌어야 한다. 원시 조립 관측까지 rejected로 바꾸면 회귀다. 검증 범위 분리 후 SDM 미지원 2,688건이 어떤 정책 상태로 이동하는지는 정책·다른 관측에 달리므로 변경 예상치를 고정하지 않는다.

[제안] 집계 단위는 사례 행/고유 관측/하위 호출 세 가지를 명시한다. 한 소스의 실패가 여러 SDM 행에 연결되어도 호출 실패 건수를 행 수만큼 부풀리지 않는다. 실패를 무시하는 회귀와 정상 거부·문맥 의존을 인프라 장애로 오인하는 회귀를 함께 막는다.

### 3.4 Ubuntu 실행 분담과 before/after 증거 계약

[제안—확정된 분담의 이행] 에이전트는 Ubuntu/WSL에서 실행하지 않는다. 승인 후 필요한 실행은 `scripts/run_spec_probe.py` **한 개의 제안 스크립트**로 제공하고 형섭이 직접 실행한다. 지금 이 파일은 만들지 않는다. 실제로 제공할 때도 실행 명령·생성 파일·확인 값을 다시 안내한다.

[코드 검토] 기준선 스크립트 `docs/review_artifacts/fuzzing_audit_2026-09-15.py`는 `__file__.parents[2]`로 ROOT를 정하고 끝에서 `ROOT/out/review/fuzzing_audit_2026-09-15.json`을 쓴다. 또한 `m13_lint`를 import하며 그 모듈에도 독립 ROOT가 있다. 작업 디렉터리만 바꾸거나 stdout만 리다이렉트해서는 기존 JSON 덮어쓰기를 막을 수 없다.

[제안] before 수집은 아래 방식으로 한다. 이것은 보고서 R8 전체 구현을 앞당기는 작업이 아니라 승인 후 검증에서 기존 증거를 보존하기 위한 실행 경계다.

1. [제안] `out/spec_probe/<UTC>/`를 새로 생성하고 이미 있으면 덮어쓰지 않고 중단한다. 원본 코드·입력·보호 경로의 파일 목록과 해시를 먼저 기록한다.
2. [제안] 이 안의 `before/workspace/`에 감사 스크립트의 **수정 전 원본**, 필요한 pipeline/scripts와 DB·기존 lint/triage/assembly/manifest를 복사한다. 복사본도 원본과 해시를 대조한다. 연결/심볼릭 링크로 기존 out 디렉터리를 공유하지 않는다. Git HEAD 조회가 가능한지 확인하고 HEAD와 미커밋 코드 해시를 함께 기록한다.
3. [제안] 복사본 루트에서 정확히 `python3 docs/review_artifacts/fuzzing_audit_2026-09-15.py`를 실행한다. 원본 감사 코드·mock·집계 로직을 변경하지 않는다. `PYTHONDONTWRITEBYTECODE=1`, 임시 작업 폴더도 `<UTC>/tmp/`로 지정한다. 생성 JSON은 복사본의 `out/review/` 아래, 즉 전체 경로상 `out/spec_probe/<UTC>/...`에만 생긴다.
4. [제안] 완료 JSON을 `before/audit.json`으로 보존하고 wrapper의 `run_manifest.json`에 원본/복사본 경로와 해시를 대응시킨다. 원본 `out/lint/`, `out/review/`, `out/ubuntu-tests/` 등의 파일 목록·해시가 동일한지 재검사한다.
5. [제안] 형섭이 before 결과를 전달하면 감사 원본·검토 대상 코드 해시와 환경을 비교한다. 코드/데이터가 다르면 기존 숫자를 새 기준선에 맞춰 임의 수정하지 않고 차이를 기록한 뒤 진행 범위를 확인한다. **before 결과를 받기 전에는 R1~R3 제품 코드 수정을 시작하지 않는다.**

[제안] before 실행 명령 제안: `python3 scripts/run_spec_probe.py --phase before`. 스크립트 승인·제공 전에는 실행하지 않는다.

[제안] after는 제품 코드 수정 후 별도의 새 `<UTC>` 폴더에서 `python3 scripts/run_spec_probe.py --phase after --baseline out/spec_probe/<BEFORE_UTC>`로 실행한다. before의 소스·DB·사례 ID·정책과 연결하고 수정본 전체 결과, 실패 주입, 4.3의 표시 문법 probe를 기록한다. 기존 감사 스크립트는 accepted 불일치 행을 `next()`로 찾는 등 수정 전 상태에 의존하므로 after 검증기로 그대로 재사용하지 않는다. after 집계·검증은 단일 wrapper에서 새 결과를 읽어 수행하고 원래 감사 스크립트는 기준선으로 보존한다.

| 새 실행 폴더 안의 제안 파일 | 형섭이 확인할 값 |
|---|---|
| [제안] `run_manifest.json`, `protection.json` | `phase`, UTC, 정책, 환경·도구 해시, 기준선 참조, 전체 명령/종료값, 원본 보호 경로의 `changed_files=[]`, 모든 출력의 경로가 이번 실행 루트 안인지 |
| [제안] `before/audit.json`, `before/audit.stdout.txt`, `before/audit.stderr.txt` | 감사 프로세스 종료 0과 `counts`, `live_expected_row_probe`, 실패 주입 상세. 기존 환경과 같을 때 비교 대상은 7,283행·118건, -11/-6의 rejected, 주입 batch exit 0 등. 다르면 파일을 전달하고 차이 확인까지 대기 |
| [제안] `before/workspace/…`, `tmp/…` | 변경 전 코드/입력 스냅샷·감사 코드 해시와 wrapper manifest의 일치. 임시 파일도 원본 out에 남기지 않음 |
| [제안] `after/intel/{results.csv,observations.jsonl,manifest.json,report.md}` | 7,283행과 기존 case_id의 보존, syntax·정책·필수 실패 이유, counts와 행별 상태의 일치. accepted 수의 변화만으로 실패/성공을 단정하지 않음 |
| [제안] `after/events/<status>/*.json`, `injections.json`, `tests.stdout.txt`, `tests.stderr.txt` | R1~R3 테스트별 주입값·실제값·assertion 결과. 크래시/timeout 사건 보존. 주입 batch는 실패 종료가 기대값임 |
| [제안] `delta.json`, `delta.csv` | before→after 상태 전이, 원시 바이트 변화 여부, 각 변화의 규칙/정책 사유. 118건·미지원 건을 근거 없이 일괄 bug로 승격하지 않았는지 |
| [제안] `display/{intel,att}/{observations.jsonl,results.csv,manifest.json}`, `display/comparison.json` | 4.3의 완료·syntax 분리·비덮어쓰기·far-pointer 표시 범위 관측. `display_syntax`와 입력 `syntax`를 혼동하지 않았는지 |

[제안] shell·이전 단계의 고정 출력 경로를 사용하는 검증은 after의 격리 workspace에서 실행해 원본 경로를 보호한다. `pipeline/run.py execute`나 기존 Ubuntu 전체 실행을 원본 폴더에서 호출하지 않는다. probe는 CPU 입력 실행을 포함하지 않는다. 형섭이 after 파일을 돌려준 뒤에만 통과/미완료를 판정하고 다음 작업으로 진행한다.

## 4. 프레임워크 준비도 — syntax·키·이음새까지

### 4.1 네 가지 준비 계약

| 요구 | 이번에 설계할 최소 변경 | 검증 및 범위 제한 |
|---|---|---|
| [제안] ① R2 판정 키에 syntax | 3.2의 판정 키와 캐시 입력에 `syntax=intel` 추가. 기본 생략을 저장 단계까지 전달하지 않음. 표시 결과를 사용한 판정에는 별도 `display_syntax`도 포함 | Intel 원본 재실행 없이 과거 결과가 어느 문법인지 식별 가능해야 함. source의 공백 제거 등 손실 정규화로 키를 합치지 않음 |
| [제안] ② R8 증거 튜플에 syntax | `(manual_hash, form_id, generator_version, source_hash, tool_hash, options, syntax, display_syntax)`를 증거 연결 계약으로 예약. mode, db_hash, 코드·검사 정책 버전도 실제 실행 manifest/관측 참조에서 식별 | 현재 모르는 manual_hash나 안정 form_id를 추정해서 채우지 않음. 당장은 `(db_hash,row_id,row_content_hash)` 참조와 `manual_binding=unverified`를 명시할 수 있음. 내용 기반 form_id·버전 혼합 차단의 본 구현은 보고서 순서 3의 R8 |
| [제안] ③ R5 검증 범위에 문법 | `validation_scope.syntax=intel`은 **원본 입력** 문법. `display_syntax=intel/att`는 디코더의 표시 문법. `not_expressible_in_this_syntax` 상태를 예약하되 현재 해당 행은 만들지 않음 | CLI `.att_syntax` 입력은 계속 미지원. 표시 문법 att 확인만으로 AT&T 입력 지원으로 표시하지 않음 |
| [제안] ④ m4 이음새 | `combo → combo_to_ir() → render_intel() → build_line()/write_asm()`로 분리. 주석·추적 ID·기존 값 보존. AT&T 렌더러/입력 파서는 작성하지 않음 | 같은 combo의 Intel 출력과 기존 생성기의 출력이 일치해야 함. 이음새를 만들기 위해 새 후보·새 의미 규칙을 생성하지 않음 |

[제안—확정된 범위의 이행] `not_expressible_in_this_syntax`는 사용자가 지칭한 오탐 그룹(CALL/JMP, DEC/INC r16·r32, LEAVE, LGDT/LIDT, BNDCL/BNDMOV, LAR/LSL)을 다음 프로젝트에서 검토할 자리다. 이번에는 어느 행도 그 값으로 재분류하지 않는다. `unknown`, opcode 필드 미지원, 현재 문법에서 표현 불가능함은 서로 다른 상태다.

[코드 검토] m4의 `build_line()`은 이미 Intel 형태인 `row['operands']`를 붙인다. Intel 표현은 m3의 `MEM_SIZE_TO_PTR`, `memory_candidate()`, `expand_token()` 등에서 만들어진다. [제안] m4에 이름만 IR인 문자열 래퍼를 추가하는 것으로 중립 이음새가 완성되었다고 판정하지 않는다.

[제안] `combo_to_ir()`는 현재 combo 입력을 읽는 어댑터로 한정한다. 중간 표현은 mnemonic, 원래 슬롯 순서, 레지스터 식별/폭, 즉시값, 메모리의 선언 크기와 주소 구성요소, 접두어·장식, 원본 combo/DB 참조를 보존한다. Intel `ptr` 표기를 의미 필드의 값으로 쓰지 않는다. 디스플레이 선언 폭을 실제 메모리 접근 폭이라고 이름 붙이지 않으며, 목적지/소스 의미를 슬롯 순서만으로 추정하지 않는다.

[제안] 범위 밖 표현은 원문과 `source_syntax=intel`, `ir_status=partial`을 가진 명시적 opaque 항목으로 보존한다. 이를 문법 중립 해석 완료로 주장하지 않는다. Intel 렌더러는 이 경우 원문을 유지한다. 전체 GAS 표현식 파서나 AT&T 변환기는 만들지 않는다. 아직 해석하지 못한 생성 선택도 원문·원본 토큰·조합 참조가 남아 다음 프로젝트에서 **기존 실험 재실행 없이** 해석할 수 있도록 한다.

[제안] `test_intel_renderer_preserves_generated_sources`는 before의 같은 combo를 새 이음새로 렌더링해 소스·피연산자 순서·헤더·추적 ID를 대조한다. `test_ir_preserves_unparsed_operands`는 해석하지 못한 입력을 통제해서 원문·syntax·기대 행 참조가 소실되지 않는지 확인한다. 생성기 출력 변경이나 unknown의 해석 완료 승격이 있으면 준비도 검증을 통과시키지 않는다.

[제안] 판단 기준은 “나중에 AT&T를 쓰기 시작할 때 기존 Intel 데이터를 다시 실행/재키잉해야 하는가”다. 입력/표시 문법·정책·근거 식별 누락과 원문 유실은 지금 막는다. 다음 프로젝트의 AT&T 사례 생성·지원 판정·의미 동등성·대량 비교는 지금 설계하지 않는다. 오래된 결과의 문법을 보충할 때는 당시 코드/명령 근거와 이관 출처를 남기고, 확인할 수 없으면 unknown으로 보존한다.

### 4.2 Intel 하드코딩 위치 목록

| 읽은 위치 | 현재 가정 | 승인 후 이음새 작업 |
|---|---|---|
| [코드 검토] `pipeline/m4_generate.py:write_asm()`, `build_line()` | `.intel_syntax noprefix` 헤더, 소문자 mnemonic과 완성 operands 문자열 결합 | [제안] 헤더와 문장 렌더링을 Intel 렌더러에 모으고 중립 IR·추적 태그 조합은 분리 |
| [코드 검토] `pipeline/m3_combine.py:MEM_SIZE_TO_PTR`, `MEM_DEFAULT`, `FAR_PTR_SIZE_TO_PTR`, `memory_candidate()`, `expand_token()` | `dword ptr`/`far ptr`, `[eax]`, VSIB·moffs 주소 문자열을 생성 단계에서 결정 | [제안] 현재 출력과 선택 규칙은 보존. m4의 combo 어댑터 입력이 이미 Intel 문자열이라는 사실을 명시하고 원문·선택 근거를 함께 보존 |
| [코드 검토] `pipeline/operand_forms.py:PTR_BITS`, `operand()`, `parse_instruction()`, `match_token()` | `word/dword/... ptr`, 대괄호, `%` 없는 레지스터명, 콤마 분할과 원문 문자열 비교 | [제안] 입력 문법 경계 안에 두고 `syntax=intel` 확인 후만 호출. 이후 비교 함수는 파싱된 필드를 받음. att 표시 텍스트에는 호출하지 않음 |
| [코드 검토] `pipeline/instruction_check.py:HEADER`, `assemble()` | Intel 헤더, objdump `-M intel` | [제안] 입력 헤더와 `display_syntax` 인자를 분리. `AS_OPTIONS`의 `-mintel64`를 AT&T/Intel 소스 문법 스위치로 취급하지 않음 |
| [코드 검토] 같은 파일 `observed_findings()`, `roundtrip()` | 대문자 `FWORD PTR` 검사, objdump 문장을 HEADER 아래 재조립 | [제안] 표시 규칙에 적용 가능한 문법 표시. att 출력은 opaque로 전달하고 Intel HEADER 아래 넣지 않음. 왕복의 미지원 이유 보존 |
| [코드 검토] `scripts/asm_linter.py:source_records()`, `main()`, `STATUS_TEXT` | Intel 입력 가정, `.intel_syntax noprefix`만 허용 헤더, `.att_syntax` 차단, scope 이름에 intel 고정 | [제안] `--syntax`의 허용 값은 intel 하나. `--display-syntax`는 별도 실험 옵션. 입력 가정·결과 키·검증 범위에 실제 선택 기록 |
| [코드 검토] `pipeline/m5_assemble.py:ASM_HEADER`, `assemble_one()`; `m8_clang_assemble.py` 동일 지점 | 각 줄을 Intel 헤더와 함께 조립 | [제안] 입력 syntax 메타데이터를 전달하고 헤더 이음새 사용. AT&T 입력 구현 없음 |
| [코드 검토] `pipeline/m6_roundtrip.py:run_objdump()`, `normalize()`; `m9_clang_compare.py:run_objdump()`, `normalize()` | objdump `-M intel` 기본값, 텍스트 정규화 비교 | [제안] 표시 문법 인자를 전달. 서로 다른 문법의 텍스트 비교에는 `not_comparable`을 기록하고 GNU/Clang 바이트 비교는 계속 수행 |
| [코드 검토] `pipeline/m10_reassemble_check.py:ASM_HEADER`, `reassemble_one()`, `run_objdump()` | Intel 출력문 재조립·Intel objdump 기본값 | [제안] 문법 메타데이터로 경로를 검사하고 미지원 표시 왕복을 명시적 완료 레코드로 남김. att→Intel 변환 금지 |
| [코드 검토] `pipeline/m7_triage.py:_roundtrip_category()`, `classify_roundtrip_diff()`, `build_triage_rows()`; `review_verdicts.py:apply_review()` | 표시 문자열 규칙과 source/combo 기반 기존 재심 적용 | [제안] 다른 표시 문법에 Intel 규칙·confirmed를 자동 전이하지 않음. 새 표시 관측과 역사적 재심 참조를 분리하고 기존 triage는 보존 |
| [코드 검토] `scripts/review_cases.py`의 HEADER 사용, `m11_execute.py:ASM_HEADER`, `m12_execute_edge_cases.py`의 헤더 import | CPU/재심 소스의 Intel 가정 | [제안] 참조 위치만 목록화. 이번 표시 probe는 CPU 실행하지 않으며 실행 범위 확장은 R9 이후 |

### 4.3 AT&T 구현 없이 표시 문법 준비도를 검증하는 계획

[제안] 입력 `syntax`는 두 실행 모두 **intel**로 고정하고 `display_syntax`만 `intel`과 `att`로 바꾼다. `objdump -M att` 사용 가능성은 사용자가 준 실행 전제이며, 이번에 실행해 검증한 사실로 기록하지 않는다. 두 표시 경로를 구별하는 판정 키의 문법 축은 `(syntax, display_syntax)`다. 입력을 AT&T로 시험했다고 허위 기록하지 않는다.

[제안] 형섭이 실행할 단일 probe의 after 단계에서, 동일 Intel 입력·기대 행·정책·모드·도구 버전으로 두 표시 경로를 돌린다. 가능한 경우 한 번 만든 같은 오브젝트를 두 번 해독하고 오브젝트·text 바이트 해시로 동일성을 확인한다. 선택한 기존 사례 및 전량 입력의 실행 범위는 manifest에 명시하고 사례를 새로 대량 추가하지 않는다.

| 처리 경로 | att 표시 실행에서 수행할 일 |
|---|---|
| [제안] 생성·조립(4/5/8), 공통 API | 기존 combo → IR → Intel 렌더러 → GNU/Clang 조립. `syntax=intel`로 기록. 1~3단계 DB 재생성과 CPU 11~12단계는 이 probe 범위 밖 |
| [제안] 바이트 추출·표시(6/9와 공통 API) | 같은 바이트에 `objdump -d -w --insn-width=16 -M att` 적용. `decode_lines()` 등은 주소/바이트/나머지 텍스트를 분리하고 나머지는 opaque로 보존. 바이트·길이·연속성과 도구 종료를 검사 |
| [제안] 비교·triage(6/7/9) | 원본 Intel 소스 파싱은 계속 가능. att 문장의 operand를 Intel 파서로 읽지 않음. 다른 문법의 문자열 일치는 `not_comparable`; 바이트 비교 결과와 원시 표시를 계속 전달. 기존 오탐 그룹/triage를 재분류하지 않음 |
| [제안] 재조립 단계(10 및 공통 `roundtrip()`) | att 표시문에 대한 왕복은 `status=not_checked`, `scope.status=unsupported`, reason=`display_roundtrip_renderer_not_implemented`로 명시. 선택 정책상 필수라면 최종 incomplete, 표시 수집용 선택 검사라면 수집 완료 가능. 이 분기는 반드시 실제로 도달해 레코드를 남김 |
| [제안] 최종 판정·저장(13/CLI) | 키·행·manifest에 `syntax=intel`, 각 `display_syntax`를 저장하고 끝까지 직렬화. 검사 미지원과 프로그램 중단/도구 장애를 구분. 별도 `display/intel/`, `display/att/`에 저장 |

[제안] 여기서 “끝까지”는 생성→조립→추출→선택 문법 표시→비교→왕복 단계의 명시적 결과→판정·manifest 저장까지의 도달이다. att 문장을 직접 조립하는 기능의 통과를 뜻하지 않는다. Intel 표시의 왕복 결과를 att 왕복 성공으로 복사하지 않는다. 구조적 완료와 필수 검증 미완료를 함께 기록한다. 입력 AT&T 구현 없이 이 구분을 지키는 것이 probe의 검증 대상이다.

| 사용자 지정 통과 조건 | 제안 테스트와 수락 값 |
|---|---|
| [제안] (1) Intel 문자열 파싱 가정에 걸려 깨지지 않고 끝까지 돌아감 | `test_display_att_reaches_final_manifest`: 실제 att 출력·종료·길이/바이트를 기록하고 마지막 행과 manifest 존재, 예상치 못한 예외 0, 요청 사례 수와 저장 행 수 일치. 미지원 텍스트 검사는 이유와 함께 남아야 함 |
| [제안] (2) 판정이 syntax 축으로 갈라져 기록됨 | `test_display_syntax_keys_are_distinct`: 같은 관측 입력의 두 판정 키는 `(intel,intel)` / `(intel,att)`로 다름. 모든 행에 input/display 문법이 있고 한쪽 판단/캐시가 다른 쪽을 덮지 않음 |
| [제안] (3) 기존 intel 실행 결과를 덮어쓰지 않음 | `test_display_probe_preserves_existing_artifacts`: 보호 경로 및 이번 Intel 표시 결과의 전후 해시 일치. att 결과 경로는 별개, 실행 디렉터리 재사용 시 거부 |

[제안] LSS/LFS/LGS의 기존 세 bug 사례는 원본 `lss/lfs/lgs rcx, tbyte ptr [eax]`와 같은 바이트를 두 표시 문법으로 해독해 확인한다. 이미 있는 r16/r32 사례도 표시 규칙의 대조군으로 사용한다. `far_pointer_display` 결과에는 아래 필드를 남긴다.

| 제안 기록/검증 | 판독 규칙 |
|---|---|
| [제안] `object_hash`, `text_bytes`, opcode·REX.W, 두 `display_syntax`, 원시 stdout, 도구 버전/해시 | 동일 기계어에 대한 두 표시인지 먼저 확인. 다른 바이트·버전을 섞으면 문법 비교 근거로 사용하지 않음 |
| [제안] `displayed_memory_bits`, `width_evidence`, `rule_applicability` | 숫자 폭을 출력에서 확인하지 못하면 null. `FWORD PTR`가 att 출력에 없다는 것만으로 80비트를 정확히 표현했다고 판정하지 않음. 접미사만으로 포인터 전체 폭을 추정하지 않음 |
| [제안] `intel_fword_observed`, `att_observation`, `syntax_scope_conclusion` | Intel에서 동일 결함 재현 + att에서 폭이 불명시되면 “Intel 경로 오표기 재현, att는 해당 폭 표기 미확인”. att가 실제 올바른 폭을 표현한 근거가 있으면 “시험한 버전의 Intel 표시 경로로 차이 한정”. att에도 잘못된 폭 표시가 확인되면 그 관측을 보존하고 재심 대상으로 남김 |

[제안] 새 버전에서 Intel의 `FWORD PTR` 현상이 재현되지 않아도 과거 세 행을 자동 정정하지 않는다. R8의 새 실행 근거로 연결한 후 재심한다. 이 probe는 `bug=3`을 as 인코딩 결함으로 바꾸거나 AT&T 경로를 근거 없이 정상 확정하는 도구가 아니다. 실행 결과가 전달되기 전에는 위 세 경우 중 어느 결론도 선택하지 않는다.

## 5. P1 이후 — R4~R10의 순서와 선행 조건

[제안] 보고서 8절의 순서를 유지한다. R5의 상태 전달과 syntax 축은 P0 계약에 필요한 부분만 2·4절에 포함했다. 아래는 후속 작업의 순서와 진입 조건이며 상세 구현 설계는 아니다.

| 보고서 순서 | 관련 항목 | 다음 작업과 선행 조건 |
|---|---|---|
| [제안] 1 | D1~D5 | 형섭의 대상·입력 채널·역할·정책 결정 및 spec 승인. 모든 코드 작업의 선행 조건 |
| [제안] 2 | R1~R3 | before 수령 → 판정 전달 수정 → after 수령 및 수락 조건 확인. 실패/미완료가 남으면 다음 순서로 완료 처리하지 않음 |
| [제안] 3 | R8 | R1~R3 데이터 계약과 syntax 필드가 확정된 뒤 안정 form ID, 증거/버전 연결·혼합 탐지·실행 묶음 보존을 완성 |
| [제안] 4 | R5 → R6 → R7 | R8의 식별 가능한 근거와 D4 명령군을 전제로 검증 범위 정밀화, 독립 디코더 비교, 구별 가능한 레지스터·경계값 생성 순으로 보강. syntax 이음새는 4절 범위까지만 사용 |
| [제안] 5 | R4, R10의 평가 준비 | 앞선 결과·근거가 안정화된 뒤 수집 완료/기대값 일치/재현/확정을 분리하고 알려진 사례와 별도인 평가 집합을 확보. P0의 실패 주입 테스트를 독립 성능 평가 집합으로 재사용하지 않음 |
| [제안] 6 | R10 | 평가 집합·D5 성공 기준·예산 확정 후 실제 대상에 연결해 보고서 A~D 비교 실험. 처리량/지연·정확도·검출·조사 비용을 선택 지표에 맞춰 측정 |
| [제안] 7 | R4·R8·R10 | 재현 환경과 새 평가 결과가 확보된 사례의 최소 재현·근본 원인별 집계·공개 가능한 근거 정리. 공개/외부 보고는 별도 승인 대상 |
| [제안] 조건부 선행 | R9 | 임의 입력 CPU 실행으로 확장하기 **전**에 실행 대상 제한·격리·자원 제한을 갖춤. D1에서 CPU를 선택하면 실행 실험의 선행 조건으로 적용하며 이번 표시 probe에서는 실행하지 않음 |

[제안—확정된 범위의 이행] AT&T 렌더러/입력 지원, 새 니모닉·사례 대량 추가, VEX/EVEX·16/32비트 확장, 파일 정리/리네임, 사용자 지정 오탐 그룹 재분류는 이번 수정 계획의 실행 범위에 넣지 않는다. 기존 수치는 새 결과의 재집계 근거 없이 고치지 않으며 `needs_review=2763`을 버그 후보 수로 사용하지 않는다.
## 6. 새 계획: R0 입력 품질 게이트와 P0 실행 순서

이 절은 앞의 `기존 미결 사안`을 보존한 뒤 추가하는 실행 명세다. R1~R10의 우선순위와 설계를 다시 정하지 않고, R0를 그보다 앞선 입력 품질 게이트로 추가한다. 아래 수치는 이 문서 작성 시점에 저장된 CSV를 다시 읽어 확인한 값이며, 실행하지 않은 항목은 모두 `[제안]`으로 표시한다.

### 6.1 결정 필요

| 질문 | 선택지 | R0~R3에 미치는 변화 |
|---|---|---|
| 의미가 같은 다른 인코딩을 허용할 것인가 | A. 동등성 증거가 있을 때 허용 / B. 특정 SDM 행을 반드시 시험 | A는 R2에 `encoding_target_match=different_encoding`, `equivalence=unknown`을 보존하고 증거가 없으면 review로 둔다. B는 같은 118건을 목표 행 미시험 실패로 처리한다. `[제안]` |
| 퍼징 대상은 무엇인가 | 어셈블러 파서 / 디코더 / 에뮬레이터·JIT / CPU | 파서면 rejected와 진단을 보존해야 한다. 디코더면 입력 채널을 raw bytes로 바꾸고 텍스트 조립 단계를 선택 사항으로 만든다. 실행 대상이면 R3에 CPU·OS·권한·신호를 필수 키로 넣는다. 현재 대상은 미결정이다. `[제안]` |
| 주 성공 기준은 무엇인가 | 도구 제작 완료 / 입력 품질 / 오탐 감소 / 퍼징 유효성 | 도구 제작을 1차 기준으로 두면 R0~R3의 스키마·실패 전파·재현성이 통과 기준이 된다. 나머지 기준은 별도 합의 전까지 측정하지 않는다. `[제안]` |
| 시험 범위는 무엇인가 | 현재 Intel x86-64 생성 범위 / 특정 명령 그룹 | 전자는 기존 행·combo ID를 유지한다. 후자는 범위 필터와 별도 집계를 추가해야 한다. 현재 특정 그룹을 고정하지 않는다. `[제안]` |
| 개선 효과는 무엇으로 측정할 것인가 | 파이프라인 오류 제거 / precision·recall / 실행 커버리지 | 파이프라인 오류 제거를 먼저 측정하고 precision·recall·CPU 커버리지는 후속 합의 후 추가한다. `[제안]` |

이 질문들이 확정되기 전에는 실제 퍼징 대상용 코드 변경을 시작하지 않는다. R0는 입력 CSV의 오염을 차단하는 품질 게이트이므로 대상 결정과 무관하게 먼저 수행할 수 있다. `[제안]`

### 6.2 R0 — 1·2단계 입력 품질 게이트

#### 재집계 기준선

`data/db/isa_db.csv`는 4,210행, `data/db/tokens.csv`는 9,820행이다. `[재집계]` `isa_db.csv`에서 row 992는 `LAR / r32, r64/m161`, row 1582는 `VPAND / ymm1, ymm2, ymm3/.m256`, row 570은 `ENCODEKEY256 / r32, r32 <XMM0-6>`이다. row 1118~1127에는 CR/DR 범위에 U+2013 en-dash가 8행 존재한다. `[재집계]`

폭 검사는 레지스터 번호가 아니라 `/mNN`·`r/mNN`의 메모리 폭만 검사한다. 초기 폭 숫자 규칙은 `m14/28byte`를 포함한 4행을 위반으로 올리며, 특수 폭을 화이트리스트에 넣은 뒤 실제 의심 행은 `/m161` 한 행으로 남아야 한다. `[재집계]` 실존 폭 화이트리스트는 `{8,16,32,64,80,128,256,512}`이고, `m14/28byte`, `m94/108byte`, `m384` 같은 독립 메모리 표기는 이 규칙의 대상에서 명시적으로 제외한다. `[제안]` 허용 문자 규칙은 en-dash 8행과 `ymm3/.m256` 1행, 총 9행을 검출한다. `[재집계]`

토큰을 공백 제거로 정규화해 같은 raw 변형을 묶으면 20개 그룹, 2,474행이다. 예시는 `xmm1 {k1}{z}`와 `xmm1{k1}{z}`, `xmm3 /m128`과 `xmm3/m128`이다. `[재집계]` `op_en`은 A 1,352행, B 678행, C 442행, D 225행이며 한 글자 라벨 합계는 2,987행, 빈값은 198행이다. `[재집계]` opcode의 `/r`는 공백 유무가 없는 48행, 공백이 있는 3,034행으로 기록된다. `[재집계]` 접미사 규칙은 `ib→imm8` 519/0, `iw→imm16` 27/0, `id→imm32` 42/0, `io→imm64` 1/0(대상/불일치)이다. `[재집계]` `/r` 전체는 3,082행이며, 보고서의 단순 교차 대조 39건은 BOUND·INVPCID 등 메모리 전용 형식의 알려진 오탐으로 남겨 검증 후에만 게이트 승격한다. `[재집계·제안]`

`data/db/coverage_report.md`의 Stage 1 기준선(추출 4,210행, 고유 mnemonic 1,606개, TOC 대조 미표현 30개)은 PDF 전체 재추출의 범위와 별도 수동 확인 목록을 보여준다. 이 보고서의 TOC·placeholder 차이를 곧바로 DB 결함으로 판정하지 않고, R0 이중 추출 diff와 P1 독립 테이블 대조의 입력으로 보존한다. `[재집계·제안]`

#### 게이트 동작

1. `pipeline/m1_extract.py` 출력 직후, `pipeline/m2_tokenize.py` 입력 직전에 공백 축약과 en-dash→ASCII 하이픈 같은 정규화를 적용한다. 원문은 `raw_*` 필드로 보존한다. `[제안]`
2. `tokens.csv`에 `validation_status`, `validation_codes`, `normalized_operand_token`을 추가한다. 화이트리스트 밖 토큰은 통과시키지 않고 `extraction_suspect`로 기록한다. `[제안]`
3. `data/db/extraction_issues.csv`에 `row_id`, `token_row_id`, `rule`, `raw_value`, `normalized_value`, `reason`, `disposition`을 기록한다. 파일이 비어 있지 않으면 파이프라인을 실패시킨다. 허용 방법은 추출 수정, 근거가 있는 화이트리스트 등록, `known_issue` 예외 등록 세 가지뿐이다. `[제안]`
4. 구분자 누락 규칙은 양쪽 토큰이 유효 오퍼랜드일 때만 의심으로 올린다. `REP LODS AL` 등 명령어 표기 자체가 두 단어인 정상 행을 예외 목록에 둔다. row 570은 반드시 `extraction_suspect`로 검출되어야 한다. `[제안]`
5. PDF 재추출 시 같은 페이지를 pdfplumber 표 모드와 문자 단위 모드로 추출하고 diff한다. 어긋난 행은 `extraction_suspect`로 올리며 자동 수정하지 않는다. `[제안]`
6. 독립 ISA 테이블 대조와 Instruction Operand Encoding 표 추출은 P1로 미룬다. Intel XED/LLVM/NASM/Zydis/Capstone 중 하나를 선택하는 결정도 그때 한다. `[제안]`

#### R0 수락 조건과 실패 주입

| 수락 조건 | 실패 주입 테스트 | 주입값 |
|---|---|---|
| 정상 데이터에서 규칙의 오탐이 0이고 의도한 오염을 모두 검출한다 | `test_extraction_width_gate_detects_m161` | `row_id=992`, operand `r32, r64/m161` |
| 정상적인 특수 메모리 폭을 거부하지 않는다 | `test_extraction_width_gate_allows_special_memory_sizes` | `FLDENV m14/28byte`, `FRSTOR m94/108byte`, `AESDEC128KL m384` |
| 허용 문자 밖 문자를 통과시키지 않는다 | `test_extraction_character_gate_detects_unicode_and_dot` | rows 1118~1127의 U+2013, row 1582의 `.` |
| 쉼표 누락을 정확히 의심으로 올린다 | `test_extraction_delimiter_gate_detects_row570` | `ENCODEKEY256 r32, r32 <XMM0-6>` |
| issues 파일이 비어 있지 않으면 실행이 실패한다 | `test_extraction_gate_fails_on_nonempty_issues` | `disposition=extraction_suspect` 1행 |
| tokens의 파싱 상태가 누락되지 않는다 | `test_token_validation_status_is_required` | `operand_token=r64/m161`, `validation_status` 삭제 |
| 두 추출 모드의 불일치가 보존된다 | `test_dual_extraction_diff_is_suspect` | 표 모드 `xmm3/m128`, 문자 모드 `xmm3 /m128` |

### 6.3 상태값 분류 재설계(R1 + R5)

| 현재 뭉개지는 상태 | 새 상태값 | 판정 규칙 |
|---|---|---|
| 생성기가 의도한 SDM 행을 선택하지 못함 | `input_generation_error` | combo의 `row_id`·형식·원문 연결이 끊겼을 때. 문법 거부로 세지 않는다. `[제안]` |
| R0 추출 오염 | `extraction_suspect` | 게이트 규칙 위반 또는 이중 추출 diff. `[제안]` |
| 정상적인 문법 거부 | `diagnostic_rejection` / 외부 CSV 호환값 `rejected` | 도구가 진단을 내고 프로세스가 정상 종료했을 때. `[코드 검토·제안]` |
| 도구 미지원 | `unsupported` | syntax, opcode 계열, 옵션 자체를 도구가 지원하지 않을 때. `[제안]` |
| 검사 도구 실패 | `tool_failed` | objcopy/objdump/readelf 등 검사가 완료되지 않았을 때. `[제안]` |
| 신호 종료 | `process_crash` | return code가 음수일 때. `[코드 검토]` |
| 시간 초과 | `timeout` | timeout과 partial stdout/stderr를 함께 보존할 때. `[코드 검토]` |
| GNU as 인코딩 결함 후보 | `assembler_encoding_bug_candidate` | raw bytes가 해당 SDM 행과 다르고 재현·독립 근거가 있을 때만 후보. `[제안]` |
| objdump 표시 결함 후보 | `disassembler_display_bug_candidate` | raw bytes가 동일하고 표시 텍스트만 SDM 의미와 다를 때. 현재 bug=3은 이 경로를 가리킨다. `[코드 검토·제안]` |
| 문법으로 표현할 수 없음 | `not_expressible_in_this_syntax` | syntax별 검증 범위에 기록하며 현재 Intel 행은 재분류하지 않는다. `[제안]` |

현재 `bug=3`이 위 두 결함 상태 중 표시 결함으로 구분되는지는 raw bytes·Intel 표시·AT&T 표시를 동일 튜플로 묶는 R8 증거가 완성되어야 확정한다. 보고서의 `needs_review=2,763`은 버그 후보 수가 아니다. `[코드 검토·제안]`

### 6.4 P0 작업: R1~R3

| 항목 | 수정 위치와 수락 조건 | 실패 주입 | 회귀 위험 |
|---|---|---|---|
| R1 입력·실행 상태 보존 | `pipeline/instruction_check.py:command, assemble`, `scripts/asm_linter.py:exit_code`. 보고서 완료 기준인 “문법 거부·도구 실패·신호 종료·timeout을 서로 다른 상태로 보존하고 partial output과 종료 원인을 잃지 않는다”를 만족한다. `[제안]` | `test_command_signal_exit`=`returncode=-11`; `test_command_timeout_partial`=`TimeoutExpired(output=b'partial', stderr=b'err')`; `test_command_unavailable`=`FileNotFoundError`; `test_command_tool_failed`=`PermissionError` | 정상 rejected의 기존 집계는 유지한다. 프로세스·검사 실패가 기존 rejected/accepted에 섞여 있던 수만 상태가 이동한다. 정확한 수는 before/after 재실행 후에만 기록한다. `[제안]` |
| R2 판정 키와 기대 인코딩 | `pipeline/instruction_check.py:evaluate_expected`, `pipeline/m13_lint.py`의 cache·manifest/results. 보고서 완료 기준인 “판정 키에 syntax와 기대 행을 포함하고, accepted라도 목표 인코딩 불일치를 별도 보존하며, 동등성 미검증을 unknown/review로 남긴다”를 만족한다. `[제안]` | `test_expected_encoding_mismatch_is_review`=`bytes=670fb208`, expected=`REX.W + 0F B2 /r`; `test_syntax_key_distinct`=`(intel,intel)` 대 `(intel,att)` | 기존 7,283건 중 목표 인코딩 불일치·SDM 미매칭이 needs_review로 이동할 수 있다. 118건은 최소 이동 후보지만 전체 변화는 재실행 결과로만 확정한다. `[재집계·제안]` |
| R3 검사 경계와 실패 전파 | `pipeline/instruction_check.py:roundtrip/check_instruction`, `pipeline/m13_lint.py`, `scripts/review_cases.py`. 보고서 완료 기준인 “검사 도구 실패를 정상 거부나 accepted로 숨기지 않고 최종 manifest와 종료 코드까지 전달한다”를 만족한다. `[제안]` | `test_roundtrip_objdump_failure`=`returncode=-11`; `test_lint_manifest_tool_error`=`validation_status=tool_failed`; `test_option_inspection_failure`=`objdump stdout 불완전` | 기존 결과 행 수는 유지하되 status와 종료 코드가 바뀔 수 있다. 도구 실패를 버그 후보 집계에 합산하지 않는다. `[제안]` |

### 6.5 재실행·이력 연결

현재 `isa_db.csv`와 `tokens.csv`의 수정 시각은 2026-08-24이고, R0 수정 후 3~13단계 산출물은 재생성 대상이다. `[재집계]` 순서는 `m1_extract → m2_tokenize → R0 gate → m3_combine → m4_generate → m5_assemble → m6_roundtrip → m7_triage → m8_clang_assemble → m9_clang_compare → m10_reassemble_check → m11/m12 execute → m13 lint`로 고정한다. `[제안]`

before는 `python3 docs/review_artifacts/fuzzing_audit_2026-09-15.py` 결과와 해당 파일 해시로 고정한다. after에는 구 경로와 새 경로를 분리하고 `row_id`, `combo_id`, `source_hash`, `syntax`, `generator_version`을 연결 키로 보존한다. 기존 triage 1,585행과 lint 7,283건은 삭제하지 않고 `legacy_*` 또는 before 결과로 남긴다. `[제안]` R0에서 row가 삭제·분할되면 자동 병합하지 말고 `lineage_status=unmatched`로 올려 수동 연결한다. `[제안]`

### 6.6 문법 프레임워크 준비

R2 판정 키와 R8 증거 튜플은 `syntax`를 포함하고, R5의 검증 범위는 `syntax=intel`을 기록한다. `display_syntax`는 역어셈블 표기 축이며 `intel`·`att`를 별도로 기록한다. `not_expressible_in_this_syntax`는 예약만 하고 현재 6개 그룹(CALL/JMP, DEC/INC r16·r32, LEAVE, LGDT/LIDT, BNDCL/BNDMOV, LAR/LSL)은 재분류하지 않는다. `[제안]`

`m4_generate`는 combo→문법 중립 IR→문법별 renderer 이음새만 유지한다. Intel 하드코딩 지점은 `.intel_syntax noprefix` 헤더, `operand_forms.py`의 `dword ptr`류 비교, objdump `-M intel` 기본값, `asm_linter.py`의 Intel 입력 가정이다. AT&T 입력 renderer는 작성하지 않는다. `[코드 검토·제안]`

AT&T probe의 통과 조건은 (1) Intel 문자열 파싱 가정으로 중단되지 않음, (2) 결과 키에 `(syntax, display_syntax)`가 기록됨, (3) 기존 Intel 결과를 덮어쓰지 않음이다. LSS/LFS/LGS의 `FWORD PTR`는 Intel 표시 경로의 관측으로만 기록하고, AT&T 결과가 없다는 이유로 정상 판정을 내리지 않는다. `[제안]`

### 6.7 P1 이후(R4~R10) 선행 조건만

R4는 R0 게이트와 R1 상태 스키마가 고정된 뒤, R5는 R2/R3의 검증 범위와 실패 전파가 고정된 뒤, R6~R7은 R4~R5의 증거가 고정된 뒤 진행한다. R8은 before/after 산출물과 syntax 포함 증거 튜플이 안정된 뒤, R9는 퍼징 대상과 CPU 실행 조건이 결정된 뒤, R10은 R8의 재현 가능한 증거 연결이 완료된 뒤 진행한다. `[제안]`

독립 ISA 테이블 대조와 Instruction Operand Encoding 표 추출은 R0의 P1 후속 작업이다. R0 수락 전에는 3~13단계 수치를 갱신하거나 bug 등급을 올리지 않는다. `[제안]`

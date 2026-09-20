# 명령어 검사 결과 (13단계)

생성 테스트 23323개 + 추가 사례 14개, 고유 소스 19991개.

## 검사 상태

| 상태 | 수 |
|---|---:|
| accepted | 4295 |
| incomplete | 3 |
| needs_review | 18933 |
| rejected | 106 |

accepted는 지정 도구가 수용하고 수행한 제한 검사에서 검토 항목이 없다는 뜻이다.
needs_review는 버그 수가 아니며 incomplete/tool_error는 검사 완료로 세지 않는다.
syntax는 입력 문법, display_syntax는 역어셈블 표시 문법이다. 현재 입력 syntax는 intel만 지원한다.
encoding_policy=allow_equivalent여도 의미 동등성 근거가 없으면 target_encoding_not_exercised로 검토한다.

## 지정한 SDM 행의 legacy opcode 필드 대조

| 결과 | 수 |
|---|---:|
| different_encoding | 347 |
| fields_match | 5022 |
| not_applicable | 107 |
| not_checked | 17847 |

fields_match도 전체 인코딩 행/실행 의미 일치가 아니다. VEX/EVEX, +r, CPUID,
오퍼랜드 제약 및 모드 해석 등은 부분 검사 범위 밖이다. 의미 검증 커버리지는 아직 산출하지 않는다.

## 추가 사례

| 사례 | 상태 | opcode 필드 | 관측 |
|---|---|---|---|
| lar_r64_symmetric | needs_review | different_encoding | lar_lsl_rex_selection;target_encoding_not_exercised |
| lsl_r64_symmetric | needs_review | different_encoding | lar_lsl_rex_selection;target_encoding_not_exercised |
| far_pointer_display_lss | needs_review | fields_match | far_pointer_display |
| far_pointer_display_lfs | needs_review | fields_match | far_pointer_display |
| far_pointer_display_lgs | needs_review | fields_match | far_pointer_display |
| udb_mnemonic | rejected | not_applicable | udb_support |
| mov_sreg_memory | rejected | not_applicable | mov_sreg_memory_notation |
| vpmovqd_evex128_half_mem | needs_review | not_checked |  |
| vpmovqd_evex256_manual_form | needs_review | not_checked |  |
| vscatterdpd_evex256_half_index | needs_review | not_checked |  |
| vpscatterdq_evex256_control | needs_review | not_checked |  |
| sysexit_rexw_suffix | needs_review | fields_match |  |
| sysexit_no_rexw_suffix | needs_review | fields_match |  |
| sysret_rexw_suffix | needs_review | fields_match |  |

원시 명령행/표준출력/에러는 observations.jsonl, 버전/해시는 manifest.json, 행별 요약은 results.csv.
기존 5~10단계 저장 결과를 덮어쓰지 않고 이 실행의 관측을 별도로 보존한다.
입력 명령어를 CPU에서 실행하지 않았다.

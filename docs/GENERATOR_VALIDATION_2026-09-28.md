# 생성 입력·목표 인코딩 검증 (2026-09-28)

코드 수정과 전체 생성·조립 검증을 완료했다. **기존 `data/db/tokens.csv`, `combos.csv`와
`out/`의 과거 단계별 결과는 이번에 덮어쓰지 않았다.** 수정 결과는
[`out/generator_audit_2026-09-28/`](../out/generator_audit_2026-09-28/)에 있다.
기존 README의 과거 실행 수치와 이 실행 수치를 섞어 해석하면 안 된다.

## 바뀐 내용

| 대상 | 수정 |
|---|---|
| 고정 레지스터 | `CR8`을 `cr0`으로 바꾸던 규칙 수정. 범위 `CR0-CR7`과 단일 `CR8` 구분 |
| SDM `r8` | 실제 64비트 레지스터 이름 `r8`보다 SDM의 8비트 레지스터 타입을 먼저 해석 |
| 상대 분기 | rel8은 가까운 라벨, rel32는 4096 위치의 라벨을 사용하고 실제 변위 길이·목적지 검사 |
| XBEGIN | 일반 분기와 달리 rel16도 64비트 모드에서 유효. `data16` 지정 후 실제 바이트로 판단 |
| 문자열 명령 | RSI/RDI 고정 주소로 생성. 의미 없는 SIB/RIP 변형 제거 |
| gather | 목적지·벡터 마스크뿐 아니라 VSIB 인덱스의 물리 레지스터 번호도 함께 고려 |
| moffs | 기존 주소 해석 사례 10개는 edge로 보존. 정규 주소 `0x100000000`의 `movabs` 입력 10개 추가 |
| REX.W | AL moffs의 REX.W 행은 `rex64` 지정. RAX가 이미 요구하는 REX.W는 중복 지정하지 않음 |
| PREFETCHIT·XLAT | PREFETCHIT0/1은 RIP 상대 주소, XLAT 명시 메모리는 RBX로 생성 |
| 경고 | GNU/Clang 성공 시 stderr도 보존. 감사 보고서에서 경고는 `needs_review`, 정상 커버리지 제외 |

2단계가 opcode·description·form hash를 전달한다. 3단계는 데이터 폭과 주소 폭,
base/index/scale/displacement, 고정 레지스터 등 제한된 구조 정보를 기록하고 생성 제약을 검사한다.
일반 입력·인코딩 지정 입력·edge·모드 부정 테스트를 구분한다. 모드가 Valid인데 생성 제약을
위반한 것은 `generation_error`이며, 의도적인 부정 테스트로 숨기지 않는다.

`expected_valid`는 하위 단계 호환성을 위해 종전의 **모드 유효성** 의미를 유지한다.
새 `input_status`와 `row_reach`가 입력 검사와 실제 바이트 검사를 각각 나타낸다.

## 결과와 의미

환경: GNU binutils 2.42, Clang 18.1.3, x86-64. 임의 생성 명령의 CPU 실행은 하지 않았다.
정확한 도구 버전, 입력·코드 해시는 [manifest](../out/generator_audit_2026-09-28/manifest.json)에 있다.

| 항목 | 결과 |
|---|---:|
| SDM 행 / 토큰 | 4,210 / 9,820 |
| combo 전 → 후 | 23,323 → 23,199 |
| 검사한 입력 제약 통과 `checked` | 9,830 |
| 입력 제약 미검증 `unverified` | 13,336 |
| 입력 제약 위반 `invalid` | 33 |
| 고유 소스 / GNU·Clang 도구별 관측 | 19,926 / 39,852 |
| combo별 도구 관측 (중복 소스 재연결 포함) | 46,398 |
| GNU 수용 / 거부 | 23,095 / 104 |
| Clang 수용 / 거부 | 23,033 / 166 |
| 성공 경고 | GNU 25 / Clang 25 |

33개 invalid는 모드에서 지원하지 않는 일반 분기의 rel16 입력이다.
초기 검토에서 rel16 34개 전체를 무효로 분류했던 것은 잘못이었다. SDM의 XBEGIN rel16 행은
Valid이며 이번 구현에서 예외를 반영했다. [Intel SDM XBEGIN 정의](https://cdrdv2-public.intel.com/671110/325383-sdm-vol-2abcd.pdf)

실제 목표 인코딩 검사 결과는 다음과 같다. **different는 도구 버그 수가 아니다.** 다른 허용
인코딩 선택, 생성기의 목표 행 미도달, 추출 문제 등을 별도로 재심해야 한다.

| 바이트 검사 | GNU | Clang |
|---|---:|---:|
| 좁게 지원하는 행·필드 일치 `matched` | 151 | 142 |
| 일부 필드만 일치 `partial` | 16,586 | 16,545 |
| 검사한 필드 불일치 `different` | 3,425 | 3,431 |
| 미검증·검사 미완료 `unverified` | 3,037 | 3,081 |
| 정상 커버리지 집계 가능 (제한된 검사 범위) | 143 | 142 |

VEX/EVEX의 family/map/pp/W/L 등 일부 필드를 새로 대조하므로 과거 legacy-only 검사에서 나온
342건과 직접 증감 비교할 수 없다. 마스크·broadcast·모든 ModRM 레지스터 및 의미 제약은
아직 완전하게 검사하지 않는다. `checked`, `matched`, `coverage_eligible` 모두 전체 ISA
적합성·CPU 실행 가능성의 증명이 아니다. 검사한 항목과 미검증 항목을 행마다 함께 기록한다.

## 중요한 관측

- `mov al, ds:0x123456789abcdef0`은 기존 edge 입력으로 남는다. 주소가 64비트라는 이유로
  생성 오류라고 분류하지 않는다. moffs8의 8은 데이터 폭이다.
- `movabs al, byte ptr [0x100000000]`은 양쪽에서 `a0 00 00 00 00 01 00 00 00`을 만든다.
  데이터 폭 8/16/32/64, 읽기/쓰기, AL의 명시 REX.W 행까지 별도로 검증했다.
- `data16 xbegin .Ltarget16`은 GNU에서 `66 c7 f8 fb 0f`, Clang에서
  `66 c7 f8 f9 0f 00 00`으로 관측됐다. Clang 결과는 현재 공통 검사기의
  `inspection_complete=False`여서 `unverified`로 남긴다. 이 보고서에서 새 도구 버그로 확정하지 않는다.
- 경고가 남은 것은 벡터 연속 레지스터 묶음 24개(양쪽), IRET 크기 모호성 1개(GNU),
  XLAT 명시 메모리가 크기만 지정한다는 경고 1개(Clang)다. 모두 검토 대상으로 남긴다.
- PREFETCHIT의 비-RIP 입력은 인코딩 불가능하다는 뜻이 아니라 의도한 prefetch 동작을
  시험하지 못한다는 문제다. 해당 형태는 NOP으로 동작할 수 있다.
  [Intel 정의](https://cdrdv2-public.intel.com/868137/325462-089-sdm-vol-1-2abcd-3abcd-4.pdf)

## 과거 기록 연결

[lineage.csv](../out/generator_audit_2026-09-28/lineage.csv)는 과거 입력 중 유지 23,046개,
retired 277개와 새 identity 153개를 기록한다. 변경된 소스에는 기존 소스의 ID를 붙이지 않는다.
과거 CSV에는 form hash가 없으므로 유지한 행도 `same_source_legacy_form_unverified`로 표시한다.
같은 문자열이라고 과거의 모든 제약·판정을 검증했다고 주장하지 않는다.

ID 단독으로 서로 다른 실행을 연결하지 말고 `source_hash`, `form_hash`, `constraint_hash`,
generator revision과 실행 manifest를 함께 사용한다. 기존 정수 ID는 전 세계적으로 고유한
영구 ID가 아니라 전달된 이전 snapshot을 기준으로 배정된다.
회귀 테스트의 2026-09-19 슬롯 정책은 `legacy_combos.csv`에 고정했고, 새 정책은 별도 검사한다.
수동 재심 7개 사례의 ID·소스는 유지했다.

## 재현

권장 진입점은 기존 산출물을 보존하는 감사 CLI다.

```bash
python3 scripts/audit_generator.py --assemble all --workers 8
python3 -m unittest discover -s tests -p 'test_*.py'
python3 docs/review_artifacts/generator_independent_2026-09-28.py
```

같은 도구 버전·조립 헤더·실행 환경에서 판정 코드만 바꿨다면 원시 관측을 재사용할 수 있다.
캐시는 소스·도구 이름으로 찾으므로, 환경이 달라졌을 때는 재사용하지 말고 새로 조립한다.

```bash
python3 scripts/audit_generator.py --assemble all --workers 8 \
  --reuse-audit out/generator_audit_2026-09-28/raw_observations.csv
```

최종 재판정은 저장된 관측을 재사용하고 새 소스의 도구 관측 4개만 추가 조립했다.
일반 파이프라인의 2→3→4단계를 실행하면 기본 DB도 새 스키마로 바뀐다. **이번 검증은
별도 snapshot에서 수행했으며 기본 DB 교체 및 기존 5~13단계 전체 재실행은 하지 않았다.**
구 스키마 tokens로 새 3단계만 실행하면 재생성 안내와 함께 중단된다.

검증 결과: 회귀 **92개 통과**. 별도 독립 스크립트는 생성기 검사 함수를 쓰지 않고
CR8 4개·rel32 68개·정규 moffs 20개 도구 관측의 바이트를 확인했다. 전체 ID/소스 연결,
정상 커버리지 gate, 실행 코드 해시, 기존 파일 7개의 해시 보존도 통과했다.
독립 스크립트의 원본 해시는 이번 검토 시점에 고정돼 있으므로, 향후 기본 DB를 의도적으로
갱신한 뒤에는 과거 보존 검사가 실패하는 것이 정상이다.

이번 변경은 발견된 생성 결함을 고치고 미검증 영역을 드러내는 단계다. 일반적인 전체 ISA
제약 엔진, 모든 SDM 행 강제 인코딩, 모든 description 본문의 자동 의미 검증은 구현 범위가 아니다.

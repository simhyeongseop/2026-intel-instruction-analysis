# 최신 검증 실행

## 2026-09-20 전체 검증 (생성기 수정 + 슬롯별 레지스터 변형 이후)

```bash
bash scripts/run_ubuntu_tests.sh
```

환경: WSL2 Ubuntu 24.04, Python 3.12.3, GNU binutils 2.42, Clang 18.1.3.
기록: `out/ubuntu-tests/20260920T055158Z/`, 파이프라인 실행 기록 `out/runs/20260920T0545*.json`,
`out/runs/20260920T055205528980Z.json`. 종료 상태 `failures=0`.

| 단계 | 결과 |
|---|---|
| 회귀 테스트 59개 | 통과 |
| CLI smoke·JSON 확인 | 통과 |
| 고정 재심 사례 + CPU 대조 | 통과 |
| 11단계 주소 실행 | 6건, 기대값 일치 |
| 12단계 경계 실행 | 29건, 도구 오류 없음 |
| 13단계 lint | 생성 23,323 + 추가 7건, manifest 검사 통과 |

파이프라인 5~10단계 (입력 23,323줄, 고유 소스 19,984):

| 항목 | 결과 |
|---|---:|
| 5단계 as | 수용 23,219 / 거부 104 / 도구 사건(crashed·timeout) 0 |
| 매뉴얼 Valid 행인데 거부 | 17건 (수정 전 56건) |
| 6단계 roundtrip | same 13,228 / different 9,991 |
| 7단계 triage | false_alarm 10,066 / unsure 47 / bug 3 |
| 8단계 clang | 수용 23,157 / 거부 166 |
| 9단계 바이트 비교 | 같음 23,020 / 다름 125 / as만 74 / clang만 12 / 둘 다 거부 92 |
| 10단계 재어셈블 | 바이트 동일 9,834 / 다름 7 / 실패 51 / 라벨 artifact 99 |
| 13단계 상태 | accepted 4,295 / needs_review 18,926 / rejected 106 / incomplete 3 |
| 점검 도구 | 건전성 FAIL 0 · 수용→거부 회귀 0 · 판정 감사 어긋남 0 |

`needs_review` 18,926건은 버그 수가 아니다. 대부분(17,847건)은 지정한 SDM 행의 legacy opcode
필드를 대조할 수 없는 행(VEX/EVEX 등)이라 `not_checked`로 남은 것이다. 이 중 349건은 실제로
지정 행과 다른 인코딩이 나온 것(`different_encoding`)이고, 344건은 의도한 인코딩을 시험하지
못한 것(`target_encoding_not_exercised`)으로 표시된다.

수용 성공·바이트 동일·정상 종료는 실행 의미나 ISA 적합성의 확정이 아니다.
`unsure 47`과 미재심 행은 확정으로 보고하지 않는다.

## 2026-09-19 부분 재실행 (생성기 수정)

생성기(3·4단계) 수정 후 **5~10단계만** 다시 실행했다. `run_ubuntu_tests.sh` 전체 검증(11~13단계,
CPU 사례 포함)은 이번 변경 이후 다시 돌리지 않았다. 아래 2026-09-14 기록은 그 시점 기준이다.

환경: WSL2 Ubuntu 24.04, Python 3.12.3, GNU binutils 2.42, Clang 18.1.3.
실행 기록: `out/runs/20260919T151343549180Z.json`

| 항목 | 결과 |
|---|---:|
| 생성 입력 | 19,120줄 (고유 소스 16,675) |
| 5단계 as | 수용 19,020 / 거부 100 / 도구 사건(crashed·timeout) 0 |
| 매뉴얼 Valid 행인데 거부 | 16건 (수정 전 56건) |
| 6단계 roundtrip | same 9,643 / different 9,377 |
| 7단계 triage | false_alarm 9,449 / unsure 44 / bug 3 |
| 8단계 clang | 수용 18,966 / 거부 154 |
| 9단계 바이트 비교 | 같음 18,843 / 다름 111 / as만 66 / clang만 12 / 둘 다 거부 88 |
| 10단계 재어셈블 | 바이트 동일 9,237 / 다름 7 / 실패 34 / 라벨 artifact 99 |
| 회귀 테스트 | 57개 통과 |
| 점검 도구 | 건전성 FAIL 0 · 수용→거부 회귀 0 · 판정 감사 어긋남 0 |

수용 성공과 바이트 동일은 실행 의미나 ISA 적합성의 확정이 아니다. `unsure 44`와 미재심 행은
확정으로 보고하지 않는다.

## 2026-09-14 전체 검증

실행 시작: 2026-09-14 15:02:11 UTC

현재 저장소에서 실행한 Ubuntu 전체 검증의 요약이다. 원시 로그와 명령 출력은 로컬 `out/ubuntu-tests/20260914T150211Z/`에 보관한다. `out/ubuntu-tests/`는 실행마다 생성되는 환경별 기록이라 Git에는 포함하지 않는다.

실행 명령:

```bash
bash scripts/run_ubuntu_tests.sh
```

환경: WSL2 Ubuntu, Python 3.12.3, GNU binutils 2.42 (`as`, `objdump`, `objcopy`, `readelf`), Clang 18.1.3, Intel Core Ultra 5 226V.

| 단계 | 결과 |
|---|---:|
| 회귀 테스트 20개 | 통과 |
| CLI smoke 및 JSON 확인 | 통과 |
| 고정 재심 27개 조립 사례 | 통과 |
| 재심 CPU 사례 20개 | 통과 |
| 11단계 주소 실행 | 6건, 기대값 일치 |
| 12단계 경계 실행 | 19건, 도구 오류 없음 |
| 13단계 lint | 7,276개 생성 + 7개 추가 |
| lint manifest 검사 | 통과 |

전체 종료 상태는 `failures=0`이다. 13단계 상태 분포는 `accepted=4,401`, `needs_review=2,763`, `rejected=116`, `incomplete=3`이다. 이 실행은 명령어 수용·바이트·표기·선택 CPU 사례를 확인하지만 전체 ISA 의미 검증을 뜻하지 않는다.

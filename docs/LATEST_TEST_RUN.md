# 최신 검증 실행

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

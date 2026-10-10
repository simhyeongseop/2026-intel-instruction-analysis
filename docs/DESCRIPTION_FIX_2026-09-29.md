# Description 불일치 13개 교정 및 전량 재실행

Sol이 생성 규칙과 회귀 테스트를 구현했고, 주 에이전트가 코드 검토·전량 재실행·독립 검증을 수행했다.
대상은 [거부 입력 검토](REJECTED_INPUT_REVIEW_2026-09-28.md)에서 확인한 Description 불일치 13개다.

## 변경

| 대상 | 개수 | 교정 |
|---|---:|---|
| VPMOVQD EVEX.128 메모리 목적지 | 5 | `xmmword ptr` → `qword ptr` |
| VSCATTERDPD YMM/ZMM 데이터의 인덱스 | 2 | YMM → XMM, ZMM → YMM |
| far CALL/JMP 16비트 offset | 2 | `data16 call/jmp fword ptr [eax]` |
| far CALL/JMP 64비트 offset | 2 | `rex64 call/jmp fword ptr [rax]` |
| 64비트 SYSEXIT/SYSRET | 2 | `sysexitq` / `sysretq` |

far 64비트의 대표 주소를 RAX로 바꾼 이유는 Clang이 `[eax]`의 주소 크기 접두어를
REX 뒤에 배치하면 REX.W가 무효가 되기 때문이다. 두 도구에서 단일 REX.W가 opcode 바로 앞에
오는 `48 ff 18` / `48 ff 28`을 확인했다. far 16비트는 접두어 순서가 달라도 양쪽 모두
16비트 offset이며, 단순 수용 여부로 폭을 추정하지 않았다.

규칙은 row ID가 아니라 명령어·opcode·전체 오퍼랜드 형식으로 한정한다.
ISA DB와 원문 타입은 보존하며 `effective_operand_types`, `generation_corrections`에
교정된 형식과 근거를 별도로 기록한다. 인접 형식, 주소 문제 31개, 미확정 MOV 3개는 수정하지 않았다.

## 전량 재실행 결과

생성부터 GNU/Clang 조립·오브젝트 검사·비교까지 새로 실행했다. 과거 관측 캐시는 재사용하지 않았다.
23,199개 combo를 19,932개 고유 소스로 묶어 양 도구에서 총 39,864회 실행하고,
각 combo에 대응하는 46,398개 관측을 기록했다. CPU 실행은 하지 않았다.

| 실제 어셈블러 결과 | 이전 | 수정 후 |
|---|---:|---:|
| 양쪽 수용 | 23,021 | 23,034 |
| GNU만 수용 | 74 | 70 |
| Clang만 수용 | 12 | 10 |
| 양쪽 거부 | 92 | 85 |
| 합계 | 23,199 | 23,199 |
| 한쪽 이상 거부 (위 항목과 중복되는 소계) | 178 | 165 |

GNU 거부는 104→95, Clang 거부는 166→155다. 수정한 13개 모두 양쪽에서 경고 없이 수용됐고,
별도 검증으로 목적지·인덱스·분기 offset·반환 크기도 확인했다. 기존 성공 경고 25개씩은 그대로다.
나머지 165개의 거부 원인이 모두 어셈블러 결함이라는 뜻은 아니다.

## 검증과 보존

- 전체 회귀 테스트 **97개 PASS** (수정 전 92개, 신규 5개).
- 독립 검증: 수정 대상 13개만 소스 변경, 나머지 23,186개 소스와 ID 보존.
- 13개는 새 ID 25241–25253으로 기록하고 이전 ID와 대응을 남겼다.
- 원문 instruction/opcode/description/form hash 전량 보존.
- 기존 DB·기본 결과·이전 감사 결과 8개 파일의 SHA-256 보존 확인.
- 기본 `data/db/combos.csv` 및 `out/tests.s` 등은 이전 결과로 남겨 두었다.
  이번 결과는 아래 별도 snapshot이 기준이다.

[전체 관측](../out/generator_audit_2026-09-29_description_fix/encoding_audit.csv) ·
[실행 환경·코드 해시](../out/generator_audit_2026-09-29_description_fix/manifest.json) ·
[13개 전후 대응과 독립 검증](../out/generator_audit_2026-09-29_description_fix/independent_validation.json) ·
[독립 검증 스크립트](review_artifacts/description_fix_independent_2026-09-29.py)

재현 명령:

```bash
python3 -m unittest discover -s tests -p 'test_*.py' -q
python3 scripts/audit_generator.py --output-dir out/generator_audit_2026-09-29_description_fix --previous-combos out/generator_audit_2026-09-28/combos.csv --assemble all --workers 8
python3 docs/review_artifacts/description_fix_independent_2026-09-29.py
```

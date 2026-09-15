# 명령어 검사 도구 사용법

이 도구는 퍼징으로 만든 어셈블리 입력을 GNU as/Clang에 넣어 수용 여부와 실제 생성 바이트를 비교한다.
검사 결과를 저장하고 후속 분석 대상을 고르는 데 사용한다. 입력 명령어를 CPU에서 실행하지 않는다.

## 입력과 실행

프로젝트 폴더의 WSL Ubuntu 또는 Linux 터미널에서 실행한다.
Windows PowerShell에서는 명령 앞에 `wsl -d Ubuntu --`를 붙인다.

```bash
python3 scripts/asm_linter.py 'mov eax, ebx'
python3 scripts/asm_linter.py --file examples/fuzz_inputs.s
python3 scripts/asm_linter.py --stdin --format jsonl
python3 scripts/asm_linter.py --demo --format json --output out/demo.json
```

`--file`은 각 명령어를 독립적으로 검사한다. 파일 전체의 제어 흐름·매크로·링크를 검증하는 방식이 아니다.
`.intel_syntax noprefix`, `.text`, 라벨, `#` 주석 및 `;` 문장 구분을 처리한다.
다른 지시자가 등장하면 그 지시자와 이후 문맥을 `incomplete`로 남긴다. 모드 변경을 무시하고 성공이라고 보고하지 않는다.

각 명령어의 실측 소스에는 아래 공통 설정이 붙는다. `.Ltarget`은 기존 파이프라인의 분기용 더미 라벨이다.

```asm
.intel_syntax noprefix
.text
.Ltarget:
```

## 출력 읽는 법

| 필드 | 의미 |
|---|---|
| `status` | 이 검사의 수용/거부/검토/미완료 상태 |
| `gnu_as`, `clang` | 실제 명령행, stdout/stderr, 종료 코드, 바이트, objdump 출력, 재배치 여부 |
| `sdm` | DB의 오퍼랜드 형태 후보. `form_match`도 전체 명세 적합 판정이 아님 |
| `comparison` | 두 구현의 바이트 일치 여부. 재배치가 있으면 문맥 필요 |
| `roundtrip` | 역어셈블 문장을 재어셈블한 바이트 비교. 분기·재배치는 문맥 필요 |
| `findings` | 입력 형식 차이·표시 결함·지원 차이·동등 표현 등 확인 사항 |
| `expected_encoding` | `--expect-row`를 준 경우 제한된 legacy opcode 필드 대조 |
| `semantic_status` | 현재 일반 검사에서는 항상 `not_verified` |

`gnu_as.bytes`는 오브젝트의 `.text` 전체를 `objcopy`로 추출한 값이다.
objdump에서 보이는 첫 줄 바이트만 잘라 비교하지 않으므로 긴 명령어도 끝까지 읽는다.
`readelf`로 재배치를 확인한다. 왕복 바이트가 같아도 원본 입력의 의미까지 맞았다고 승격하지 않는다.

| 종료 코드 | 처리 방법 |
|---|---|
| 0 | 지정 도구가 수용했고 수행한 제한 검사에서 검토 항목이 없음. 일반적 실행 안전성 증명은 아님 |
| 1 | 거부되었거나 검토할 항목이 있음. 버그라고 자동 집계하지 말고 결과를 보관 |
| 2 | 미완료·도구/설정 오류·빈 입력·부분 처리. 성공 테스트로 집계하지 않음 |

예를 들어 `mov eax, ebx`는 현재 도구에서 `89d8`로 수용된다.
`mov eax, rbx`는 거부된다. `lss rcx, tbyte ptr [eax]`는 수용되지만 objdump 표시 결함이 관측되므로 검토 대상으로 나온다.
이 동작은 도구 버전과 옵션에 따라 달라질 수 있으며 실행 결과에 버전과 바이너리 해시를 함께 저장한다.

## 퍼징에서 호출하기

```python
import json
import subprocess

result = subprocess.run(
    ["python3", "scripts/asm_linter.py", "--format", "json", "mov eax, ebx"],
    capture_output=True, text=True, encoding="utf-8",
)
if not result.stdout:
    raise RuntimeError(result.stderr)  # 인자/DB/환경 설정 오류
report = json.loads(result.stdout)
for case in report["results"]:
    print(case["source"], case["status"])
# 1은 버그 확정 코드가 아니다. 입력 거부와 분석 대상이 모두 포함된다.
```

Python API를 반복 호출하면 도구 버전 조회 비용을 줄일 수 있다. 작업 디렉터리를 저장소 루트로 두거나 저장소를 Python 경로에 넣는다.

```python
from pipeline.operand_forms import load_db
from pipeline.instruction_check import check_instruction

db = load_db()
result = check_instruction("mov eax, ebx", db)
```

어셈블러가 특정 매뉴얼 행의 인코딩을 골랐는지 조사하려면 `--expect-row`에 DB 데이터 행 번호(0부터)를 준다.
검사한 필드는 출력의 `checked_fields`에 명시된다. `fields_match`는 전체 행 일치가 아니다.
VEX/EVEX, `+r` 등 지원하지 않는 템플릿은 `not_checked`다.

## 현재 검사 범위

- 기본 Intel syntax, x86-64 타깃, GNU as `--64 -mintel64`; Clang `-target x86_64-linux-gnu`.
- 일반 레지스터·명시적 메모리 폭·즉시값·일부 복합 SDM 토큰의 형태 비교.
- 마스크/브로드캐스트/반올림, 주소 표현식의 모든 제약, 즉시값 부호확장 의미, CPUID·권한·OS 조건은 일반 검증하지 않음.
- 디스어셈블을 단일 명령어로 해석하지 못하거나 도구가 없으면 미완료.
- `--static-only`는 도구가 없는 환경에서 후보만 확인하며 종료 코드 2. 동적 검사 대신 성공으로 처리하지 않음.
- `--limit N`으로 잘라 검사한 경우 미처리 입력이 있음을 표시하고 종료 코드 2.

알려진 사례와 현재 판단의 근거는 [재심 보고서](CASE_REVIEW_2026-09-14.md)에 있다.


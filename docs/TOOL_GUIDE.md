# 명령어 검사 도구 사용법

퍼징 등으로 만든 Intel 문법 명령어를 한 줄씩 파이프라인 3·4단계와 같은 기준으로 판정한다(2026-10-12).
1. 입력 줄의 후보 SDM 행을 찾는다.
2. SDM 대 각 어셈블러(GNU as, clang)로 판정한다.
3. SDM 대 각 역어셈블러(objdump, llvm-mc)로 판정한다.

도구끼리는 비교하지 않는다. 판정 코드는 `pipeline/sdm_judge.py`이고, 3단계 `m3_check`·4단계 `m4_disasm`의 함수를 그대로 쓴다.
입력 명령어를 CPU에서 실행하지 않는다.

## 입력과 실행

프로젝트 폴더의 WSL Ubuntu 또는 Linux 터미널에서 실행한다.
Windows PowerShell에서는 명령 앞에 `wsl -d Ubuntu --`를 붙인다.

```bash
python3 scripts/asm_linter.py 'add cx, dx'
python3 scripts/asm_linter.py --file examples/fuzz_inputs.s
python3 scripts/asm_linter.py --stdin --format jsonl
python3 scripts/asm_linter.py --demo --format json --output out/demo.json
```

입력 처리:
- `--file`은 각 명령어를 독립적으로 검사한다. 파일 전체의 제어 흐름·매크로·링크를 검증하지 않는다.
- `.intel_syntax noprefix`, `.text`, 라벨, `#` 주석, `;` 문장 구분을 처리한다.
- 다른 지시자가 나오면 그 지시자와 이후 문맥을 `incomplete`로 남긴다.

각 명령어의 실측 소스 앞에는 `.intel_syntax noprefix`, `.text`, `.Ltarget:`가 붙는다.
도구 판은 `pipeline/toolchain.py`(GNU Binutils 2.47, LLVM 23.1.3)를 따른다.

## 출력 예

```text
[추가 확인 필요] call dword ptr [rax]
  후보 SDM 행 2개 - 64비트 모드 유효 행이 있음(조립돼야 함)
      227  CALL r/m32        FF /2   N.E.   원문 확정
      231  CALL m16:16       FF /3   Valid  원문 확정
  GNU as   SDM 일치             66ff18  -> 행 231
  clang    다른 행 인코딩        ff18  -> 행 232
  objdump  SDM 일치             call   DWORD PTR [rax]  (GNU 바이트, 행 231)
  llvm-mc  니모닉 다름(도구 관례 철자)   lcall	[rax]  (GNU 바이트, 행 231)
  SDM 대조: SDM과 다른 도구가 있음
```

## 판정

**후보 SDM 행**(`sdm`)
- 2단계 생성기와 같은 행 정리를 쓴다(REP 계열, 행 지정 철자 `retf`·`pushfw`·`data16`·`movabs`, Description 보정).
- 니모닉과 오퍼랜드 종류(레지스터 계열·메모리·즉시값·분기 대상·먼 포인터)와 폭이 맞는 표 행을 고른다.
- `form`:
  - `match`: 모든 칸을 대조함
  - `partial`: 마스크·브로드캐스트처럼 이 검사기가 확정하지 못한 칸이 있음
- 기대 결과:
  - 64비트 모드 Valid인 후보가 있으면 조립돼야 함(reach)
  - 후보가 모두 무효면 거부돼야 함(reject)
  - 후보가 없으면 판정하지 않음
- `rep movsb`처럼 REP 행 철자가 아니면, REP를 따로 붙인 기본 행(MOVSB)을 후보로 보고 `rep_separate`를 표시한다.

**어셈블러별**(`sdm_judgment.assemblers`)

| 판정 | 뜻 |
|---|---|
| SDM 일치 | 바이트가 후보 행의 인코딩과 맞음(접두어·66H·REX.W·맵·opcode·ModRM·꼬리 길이) |
| SDM 일치(거부) | 후보가 모두 무효이고 도구도 거부함 |
| 다른 행 인코딩 | 후보가 아닌 같은 니모닉의 유효 행 바이트가 나옴(`rows`) |
| 다른 행으로 수용 | 거부돼야 하는데 받아들였고, 바이트는 같은 니모닉의 유효 행 |
| SDM과 다름(수용) | 거부돼야 하는데 받아들였고, 맞는 유효 행이 없음 |
| 다른 인코딩 / 인코딩 미대조 | 맞는 행이 없음 / 대조기가 읽지 못하는 표기·재배치 |
| 거부 / 모르는 명령 | 조립돼야 하는데 거부함 / 니모닉 자체를 모름 |

- note에는 기본 설정에서 끈 기능(GNU MPX: `-march=generic64+mpx`)과 도달 불가 등록 사유가 적힌다.
- 분기(rel) 행은 사용자 라벨의 거리를 정할 수 없어 꼬리 폭만 대조한다.

**역어셈블러별**(`sdm_judgment.disassemblers`)
- SDM 일치한 바이트(GNU 우선, 없으면 clang)를 objdump와 llvm-mc로 따로 푼다.
- 4단계와 같은 판정(`SDM 일치`, `니모닉 다름(도구 관례 철자)`, `오퍼랜드 다름`, `디코드 실패` …)을 쓴다.

**요약**(`sdm_judgment.summary`)
- `sdm_match`: 모든 도구가 SDM과 일치
- `sdm_difference`: SDM과 다른 도구가 있음
- `no_sdm_row`: 형태가 맞는 SDM 행이 없음

`status`(GNU as 기준):
- `accepted`: GNU가 받았고, 모든 도구가 SDM과 일치했고, 경고·확인 사항이 없음
- `needs_review`: 그 밖의 수용
- `rejected`: GNU가 거부함. 기대가 거부인지는 `sdm_judgment`로 본다.

`roundtrip`(역어셈블 → 다시 조립)과 `option_comparison`(`--64`만 준 GNU)은 참고 기록이며 판정에 쓰지 않는다.

| 종료 코드 | 처리 방법 |
|---|---|
| 0 | 모든 줄이 `accepted`. 일반적 실행 안전성 증명은 아님 |
| 1 | 거부되었거나 검토할 항목이 있음. 버그라고 자동 집계하지 말고 결과를 보관 |
| 2 | 미완료·도구/설정 오류·빈 입력·부분 처리. 성공 테스트로 집계하지 않음 |

## 퍼징에서 호출하기

```python
import json
import subprocess

result = subprocess.run(
    ["python3", "scripts/asm_linter.py", "--format", "json", "mov eax, ebx"],
    capture_output=True, text=True, encoding="utf-8",
)
report = json.loads(result.stdout)
for case in report["results"]:
    judgment = case.get("sdm_judgment", {})
    print(case["source"], case["status"], judgment.get("summary"),
          {tool: a["verdict"] for tool, a in judgment.get("assemblers", {}).items()})
```

Python API(저장소 루트에서):

```python
from pipeline.operand_forms import load_db
from pipeline.instruction_check import check_instruction

result = check_instruction("mov eax, ebx", load_db())
print(result["sdm_judgment"]["summary"])
```

특정 표 행 하나와 대조하려면 `--expect-row`에 DB 데이터 행 번호(0부터)를 준다(3단계와 같은 인코딩 대조).

## 검사 범위

- Intel 문법, x86-64 타깃. GNU as `--64 -mintel64`, clang `-target x86_64-linux-gnu`.
- 인코딩 필드 대조다. 레지스터 번호, 즉시값 부호확장 의미, CPUID·권한·OS 조건, 실행 의미는 검증하지 않는다.
- 후보 형태 대조는 마스크·브로드캐스트·반올림 칸을 `partial`로 남긴다.
- 표 행이 오퍼랜드 종류로만 갈리는 경우(예: `call dword ptr [rax]`는 CALL r/m32와 CALL m16:16)는 후보를 모두 보여 준다.
- `--static-only`는 도구 없이 후보만 확인하며 종료 코드 2.
- `--limit N`으로 잘라 검사하면 미처리 입력이 있음을 표시하고 종료 코드 2.

알려진 차이와 근거는 `out/cases/REPORT.md`와 [재심 보고서](CASE_REVIEW_2026-09-14.md)에 있다.

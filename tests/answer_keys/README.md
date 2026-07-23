# 정답지 (answer keys)

여기 CSV는 **형섭이 손으로 직접 값을 채우는 소규모 정답지**다.
LLM이 값을 채우지 않는다 (CLAUDE.md 1절: "설계는 형섭이 소유한다").
`verifier`는 이 정답지와 파이프라인 산출물(generator/assembler/roundtrip)을 대조해서 pass/fail을 낸다.

## 컬럼

| 컬럼 | 의미 | 채우는 기준 |
|---|---|---|
| `id` | 케이스 이름 (예: `mov_r32_r32`) | 이미 채워둠. 필요하면 행 추가/삭제 가능 |
| `operand_form` | SDM 상의 operand 형태 (예: `r32, r32`) | 이미 채워둠 |
| `intel_asm` | 실제로 어셈블할 Intel-syntax 한 줄 | **형섭이 SDM 보고 작성** (예: `mov eax, ebx`) |
| `expect_assemble` | GNU as (`--64 -mintel64`)가 이 코드를 받아줘야 하는지 | `ok` 또는 `error` |
| `expect_bytes` | 기대하는 기계어 (hex, 공백으로 바이트 구분) | 예: `89 d8`. 모르면 비워두고 objdump로 나중에 확인 |
| `expect_disasm` | `objdump -d -M intel` 로 역어셈블했을 때 기대하는 텍스트 | `intel_asm`과 다를 수 있음 (alias 등) |
| `note` | alias·특이사항 메모 | 필요할 때만 |

## 규칙

- 값이 비어 있으면 아직 정답이 안 채워진 것 → verifier는 그 행을 건너뛰고 `unsure`로 표시한다.
- `intel_asm`은 반드시 Intel SDM Vol.2 문법 그대로 작성한다 (매뉴얼이 정답이지, 어셈블러가 받아주는 게 정답이 아니다 — CLAUDE.md 1절).
- 행을 더 늘리고 싶으면 같은 컬럼 형식으로 추가하면 된다. `operand_form`은 참고용이라 자유롭게 고쳐도 된다.

# DB 커버리지 진단: SIMD 명령어 누락 원인

작성일: 2026-07-01
대상: `data/stage1_extracted/instruction_list_original.csv` (Stage 1 추출 결과)
관련 코드: `src/stage1_extraction/extract_intel_instructions.py`

## 1. 한 줄 요약

현재 DB에는 **정수(general-purpose) 명령어와 x87 FPU 명령어만** 들어 있고,
**SIMD 벡터 명령어 전체(MMX / SSE / AVX / AVX-512)가 누락**되어 있다.
원인은 추출 스크립트가 Intel SDM의 **레거시 6-컬럼 표 구조만 가정**하고,
SIMD 명령어가 쓰는 **5-컬럼 표 구조를 파싱하지 못하기** 때문이다.

## 2. 현재 커버리지 (측정값)

Stage 2 결과 기준 unique mnemonic = **352개**. 첫 글자 분포:

| 글자 | 개수 | 글자 | 개수 |
|---|---|---|---|
| A | 3 | M | 14 |
| B | 7 | N | 3 |
| C | 50 | O | 6 |
| D | 2 | P | 8 |
| E | 4 | R | 14 |
| F | 92 | S | 64 |
| H | 1 | T | 1 |
| I | 16 | U | 2 |
| J | 32 | W | 3 |
| L | 23 | X | 7 |

**명백한 공백:**

- `V*` (VEX/EVEX 인코딩 벡터 명령어): **0개** — VADDPD, VMOVAPS, VFMADD... 전부 없음
- `K*` (AVX-512 mask 명령어): **0개** — KMOVW, KADDB... 전부 없음
- `P*`: 8개뿐 (PUSH, POP, POPCNT, PAUSE 등 정수 계열만).
  PADDB, PAND, PCMPEQB, PSHUFB 등 **SSE/MMX 계열 전부 누락**
- `G*`: 0개

즉 x87 FPU(F로 시작, 92개)는 잘 잡혔지만, 그 이후 세대인 MMX/SSE/AVX/AVX-512 벡터 확장이 통째로 빠졌다.

## 3. 근본 원인 (PDF로 직접 확인)

Intel SDM Volume 2의 명령어 정의 표는 **두 가지 서로 다른 컬럼 구조**를 쓴다.

### (A) 레거시 명령어 표 — 6컬럼

```
Opcode | Instruction | Op/En | 64-Bit Mode | Compat/Leg Mode | Description
```

- 명령어 형식(mnemonic + operand)이 **col[1]** 에 있음
- 64비트 유효성이 **col[3]** 에 있음

### (B) SIMD / VEX / EVEX 명령어 표 — 5컬럼

```
Opcode/Instruction | Op/En | 64/32 Bit Mode Support | CPUID Feature Flag | Description
```

- Opcode와 명령어 형식이 **col[0]에 합쳐져** 있음
- **col[1]은 Op/En 코드**("A", "B" 등 한두 글자)
- **col[3]은 CPUID Feature Flag**("AVX512F OR AVX10.1" 등)

### 코드가 실패하는 지점

`extract_intel_instructions.py`의 `is_valid_instruction_row()`는 (A) 구조만 가정한다.

```python
cell = str(row[1]).strip()          # 명령어가 col[1]에 있다고 가정
...
if not INSTR_PATTERN.match(cell):   # 2글자 이상 대문자로 시작해야 통과
    return False
...
mode_64 = str(row[3]).strip()       # 64비트 모드가 col[3]에 있다고 가정
if mode_64 in MODE_64BIT_INVALID:
    return False
```

SIMD 표(B 구조)에서는:

1. `col[1]`이 `"A"`, `"B"` 같은 Op/En 코드 → `INSTR_PATTERN`(대문자 2글자 이상) 불통과로 **탈락**
2. 실제 명령어 형식은 `col[0]`에 opcode와 붙어 있어 **읽는 위치 자체가 다름**
3. `col[3]`을 64비트 모드로 읽지만 실제로는 CPUID Flag → 판단 근거가 어긋남

결과적으로 SIMD 표의 **모든 행이 조용히 버려진다**.

### 직접 확인한 증거

PDF 1590쪽 `VCVTTSS2USI` 표를 `pdfplumber`로 추출한 실제 결과:

```
ncols = 5
ROW: ['Opcode/\nInstruction', 'Op /\nEn', '64/32\nBit Mode\nSupport', 'CPUID Feature\nFlag', 'Description']
ROW: ['EVEX.LLIG.F3.0F.W0 78 /r\nV', 'A', 'V/V', 'AVX512F\nOR AVX10.1', 'Convert one single precisi...']
```

- `col[0]` = 인코딩 + 명령어(잘림) 합쳐짐
- `col[1]` = `"A"` (Op/En)
- `col[3]` = `"AVX512F OR AVX10.1"` (CPUID Flag, 64비트 모드 아님)

레거시 페이지(예: 51쪽 부근)는 4~6컬럼 구조로, col[1]에 명령어가 정상적으로 들어 있어 잘 추출된다.

## 4. Stage 1(988) vs Stage 2(1481) 행 수 차이 — 버그 아님

- Stage 1: 988 instruction form
- Stage 2: 1481 instruction form

Stage 2(`step2_separate_opcode.py`)가 `r/m` operand를 `r` 버전과 `m` 버전으로 **분리 확장**하기 때문에 늘어난 것이다. 예:

```
ADC r/m16, r16  ->  ADC r16, r16
                    ADC m16, r16
```

정상 동작이며 누락과는 무관하다.

## 5. 재추출 방안 (미팅 후 진행 예정)

추출기를 다음과 같이 확장하면 SIMD 명령어를 포함할 수 있다.

1. 표의 **컬럼 수와 헤더**를 먼저 판별해 (A) 6컬럼 / (B) 5컬럼 구조를 구분
2. (B) 구조일 때는 `col[0]`을 **"인코딩 부분"과 "명령어 형식 부분"으로 분리** (명령어는 보통 대문자 mnemonic + operand로 시작)
3. 64비트 유효성은 (B)에서 `"64/32 Bit Mode Support"` 컬럼(col[2])으로 읽기
4. VEX/EVEX 접두어(`VEX.`, `EVEX.`)를 opcode로 인정 (현재 `OPCODE_VALID`에는 이미 포함되어 있으나 col 위치가 달라 도달하지 못함)

이 방향으로 고치면 `V*`, `K*`, `P*`(SSE) 계열이 DB에 편입된다.

## 6. 교수님 피드백과의 연결

- "누락된 명령어(특정 부위로 시작하는 것들)" → **V/K/P 계열(SIMD)** 로 특정됨
- 원인을 LLM 판단이 아니라 **PDF 표 구조를 직접 확인**해 규명함
- 재추출은 위 4단계 설계에 따라 재현 가능한 코드로 반영 예정

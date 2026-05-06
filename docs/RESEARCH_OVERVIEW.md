# Intel x86/x64 Assembly Instruction 분석 연구

## 연구 개요

Intel SDM(Software Developer's Manual) Volume 2에서 추출한 instruction form을 기반으로, operand type별 candidate 값을 자동 대입하여 어셈블리 테스트 케이스를 생성하고, 어셈블러(GNU as, GCC, Clang)가 이를 수용하는지 검증하는 **테스트 생성 파이프라인**을 구축하는 프로젝트입니다.

## 연구 목표

**Intel SDM instruction form을 자동 테스트 케이스로 변환하는 파이프라인을 만들고**, 어셈블러의 accept/reject 동작을 분석하여 에러 발생 시 원인을 분류한다.

> SDM이 틀렸는지를 찾는 프로젝트가 아니라, SDM 명세를 실제 어셈블러 테스트로 변환하고 검증하는 파이프라인 구축 프로젝트입니다.

## 전체 파이프라인

| 단계 | 한 일 | 산출물 |
|------|--------|--------|
| 1 | SDM PDF에서 instruction form 추출 | `instruction_list_original.csv` |
| 2 | r/m operand를 r/m 두 form으로 확장 | `step2_final_instruction_opcode_split.csv` |
| 3 | operand type 그룹화 + candidate 값 정의 | `step3_operand_groups.csv` |
| 4 | SDM form 구조 안에서 테스트 케이스 자동 생성 | `test_all_instructions.s` |
| 5 | GNU as / GCC / Clang으로 어셈블 실행 | 에러 로그 |
| 6 | 에러 triage — 원인별 분류 | `step4_error_report.md` |
| 7 | *(다음 단계)* objdump로 실제 opcode 검증 | — |

---

## 단계별 진행 현황

### 1단계: 명령어(Instruction) 리스트 추출 ✅

**목표**: Intel SDM Volume 2 PDF에서 완전한 instruction form 추출

**방법**:
- `pdfplumber`로 PDF 테이블 파싱
- **col[1]** (Instruction 컬럼) 읽기 → 완전한 형태 `ADC AL, imm8` 추출
- **col[3]** (64-Bit Mode 컬럼) 기반 필터링 → `Invalid` 명령어 제외
- 노이즈 필터링: Op/En 인코딩 코드(`RM`, `MR`, `ZO` 등), 프리픽스 바이트, 64비트 미지원 명령어
- `clean_instruction_text()` 함수로 PDF 각주 번호 오염 제거 (`r/m81` → `r/m8` 등)

**수정 이력**:
- 초기: `col[0]` (Opcode 컬럼)을 잘못 읽어 소스 오퍼랜드 누락
- 수정: `col[1]` 읽기로 완전한 form 추출
- 추가 수정: PDF 각주 superscript 번호가 operand type에 오염되는 문제 수정 (`r/m81`, `r81`, `m162` 등)

**결과물**:
- `instruction_list_original.csv` — **987개** instruction form (64비트 유효 명령어만)

---

### 2단계: r/m 오퍼랜드 확장 ✅

**목표**: `r/m` 표기를 레지스터(r)와 메모리(m) 두 가지 케이스로 확장

**방법**:
- `ADC r/m16, r16` → `ADC r16, r16` + `ADC m16, r16` 두 행으로 분리
- 완전한 instruction form 기반으로 오퍼랜드 개수/타입 유지

**결과물**:
- `step2_final_instruction_opcode_split.csv` — **1,480개** instruction form

---

### 3단계: 오퍼랜드 그룹 정의 ✅

**목표**: SDM에 등장하는 모든 operand type을 그룹화하고, 각 그룹에 테스트에 넣을 candidate 값을 정의

**그룹화 기준**:

| 카테고리 | Operand Type | Candidate 예시 |
|----------|-------------|----------------|
| 범용 레지스터 | `r8`, `r16`, `r32`, `r64` | `al, cl`, `ax, bx`, `eax, ebx`, `rax, rbx, r8` |
| 메모리 | `m8`, `m16`, `m32`, `m64` | `BYTE PTR [rax]`, `QWORD PTR [rip+0x100]` 등 |
| 즉시값 | `imm8`, `imm16`, `imm32` | `0xff`, `0xffff`, `0xffffffff` |
| imm32 (r64 sign-extend) | `imm32` + r64 문맥 | `0x7fffffff`, `-1` (양쪽 경계) |
| Far pointer | `m16:16`, `m16:32`, `m16:64` | `DWORD PTR`, `FWORD PTR`, `TBYTE PTR` |
| 고정 레지스터 | `AL`, `AX`, `EAX`, `RAX`, `CL` | 해당 레지스터 고정 |
| 벡터 레지스터 | `xmm`, `ymm`, `zmm` | `xmm0~xmm3`, `ymm0~ymm2` |
| 세그먼트 레지스터 | `Sreg` | `cs, ds, es, fs, gs, ss` |
| 상대 주소 | `rel8`, `rel32` | `.` (현재 주소) |

**핵심 설계 원칙** — SDM form 안에서만 대입:
- 완전 랜덤 조합이 아니라 **SDM instruction form의 operand 개수와 타입 구조 유지**
- 각 operand 자리에 해당 type의 candidate만 대입
- 초기에는 랜덤 조합으로 SDM에 없는 잘못된 syntax까지 생성되는 문제가 있었음

**특수 처리**:
- 스트링 명령어(`CMPS`, `MOVS`, `LODS`, `STOS`, `SCAS`): 메모리 오퍼랜드를 `[RSI]`/`[RDI]`로 고정
- XLAT: 메모리 오퍼랜드를 `BYTE PTR [rbx]`로 고정
- IRET/IRETD: 64비트 모드에서 `IRETQ`만 사용
- MOVSXD: 64비트 모드에서 r64 대상 form만 테스트

**결과물**:
- `step3_operand_groups.csv` — 62개 타입, 177개 후보값
- `step3_coverage_report.csv` — 1,425/1,480 (96.3%) instruction form 매핑 가능

---

### 4단계: 테스트 코드 생성 및 어셈블러 검증 ✅

**목표**: 매뉴얼 syntax 구조를 유지한 채 오퍼랜드 자리에 후보값을 랜덤 대입하여 테스트

**테스트 생성 규칙**:
- `.intel_syntax noprefix` 필수
- 매뉴얼의 오퍼랜드 개수/타입 구조 그대로 유지
- `imm32`: r64/m64 대상(sign-extend)이면 `0x7fffffff`와 `-1` 사용, r32/m32 대상이면 `0xffffffff` 사용

**테스트 결과**:

| 항목 | 수치 |
|------|------|
| 생성된 instruction form | **1,338개** |
| 생성된 테스트 케이스 | **8,631개** |
| GNU as 에러 (`-mintel64` 기준) | **0건** ✅ |
| GCC 에러 (`-Wa,-mintel64` 기준) | **0건** ✅ |
| Clang 에러 (툴 특성) | **89건** |

---

## 주요 분석 결과

### imm32 sign-extension: Intel SDM vs GAS 의미론 차이

```asm
adc rax, 0xffffffff   // Error — GAS가 +4,294,967,295로 해석, signed 32-bit 초과
adc rax, -1           // OK   — GAS가 -1로 해석, signed 32-bit 범위 내
```

- Intel SDM: 기계어 비트패턴 기준 (`ff ff ff ff` → sign-extend)
- GAS/LLVM: 소스 리터럴의 수학적 값 기준 (`isInt<32>(Value)` 검사)
- GAS 버그 아님 — assembler expression semantics의 의도된 동작 (Codex 교차검증 확인)

### LSS/LFS/LGS r64 — AMD64/Intel64 모드 차이

- `as --64` (AMD64 기본 모드): `lss rdi, TBYTE PTR [...]` 거부
- `as --64 -mintel64` (Intel64 모드): 정상 통과, Intel SDM과 일치하는 인코딩 생성
- 결론: GAS 미지원이 아니라 ISA 모드 선택의 차이

---

## 전체 진행 통계

| 항목 | 수치 |
|------|------|
| 추출된 instruction form (64비트 유효) | 987개 |
| r/m 확장 후 (Stage 2) | 1,480개 |
| 오퍼랜드 그룹 정의 (Stage 3) | 62개 타입, 커버리지 96.3% |
| 생성된 테스트 케이스 (Stage 4) | 8,631개 |
| GNU as 최종 에러 수 (`-mintel64`) | **0건** |
| GCC 최종 에러 수 (`-Wa,-mintel64`) | **0건** |
| Clang 에러 수 (툴 특성) | 89건 |

---

## 검증 범위 및 한계

**현재 테스트가 검증하는 것**: 어셈블러의 **accept/reject** — SDM instruction form을 어셈블러가 수용하는지 여부

**검증하지 않은 것**:
- 실행 의미(runtime semantics), CPU exception, feature availability
- 실제 생성된 opcode가 의도한 SDM form과 일치하는지 (imm8 vs imm32 인코딩 선택 등)

## 다음 단계 (미완료)

- `objdump -d`로 생성된 opcode 검증 — 어셈블러가 수용했더라도 의도한 form으로 조립됐는지 확인
- 예: `adc rax, -1`이 `REX.W + 81 /2 id` (imm32)가 아닌 `REX.W + 83 /2 ib` (imm8)로 조립됨

---

## 실행 기록

| 회차 | 날짜 | 주요 내용 |
|------|------|-----------|
| 1회 | 2026-03-10 | 프로젝트 목표 설정, 3단계 파이프라인 설계 |
| 2회 | 2026-03-17 | PDF 파싱 방법론 논의, pdfplumber 활용 |
| 3회 | 2026-03-24 | Opcode 분리, r/m 오퍼랜드 분리 및 그룹화 |
| 4회 | 2026-04-01 | 테스트 코드 생성, GCC/Clang 컴파일 및 에러 triage |
| 5회 | 2026-04-15 | 문제점 교정: 매뉴얼 syntax 구조 준수, PDF 추출 버그 수정 |
| 6회 | 2026-05-05 | Stage 1/2/3 재검토 및 수정, Stage 3 구조 분리, 테스트 설계 오류 교정, Codex 교차검증 |

---

## 프로젝트 구조

```
.
├── docs/
│   ├── RESEARCH_OVERVIEW.md            (이 파일)
│   └── MEETING_NOTES/
│       ├── 1회_미팅_내용.md ~ 5회_미팅_내용.md
├── src/
│   ├── stage1_extraction/
│   │   └── extract_intel_instructions.py   (PDF → instruction form CSV)
│   ├── stage2_opcode_separation/
│   │   └── step2_separate_opcode.py        (r/m 확장)
│   ├── stage3_operand_grouping/
│   │   └── step3_operand_grouping.py       (오퍼랜드 그룹 정의 + 커버리지 확인)
│   └── stage4_test_generation/
│       ├── step4_test_generator.py         (테스트 .s 파일 생성)
│       ├── step4_compile_and_analyze.py    (GNU as/GCC/Clang 어셈블)
│       └── step4_error_triage.py           (에러 분류 보고서)
├── data/
│   ├── stage1_extracted/
│   │   └── instruction_list_original.csv      (987개)
│   ├── stage2_opcode_split/
│   │   └── step2_final_instruction_opcode_split.csv  (1,480개)
│   ├── stage3_operands/
│   │   ├── step3_operand_groups.csv           (62개 타입, 177개 후보값)
│   │   └── step3_coverage_report.csv          (instruction form 커버리지)
│   └── stage4_tests/
│       ├── test_all_instructions.s            (8,631개 테스트 케이스)
│       ├── step4_as_errors.txt                (GNU as 에러 원본)
│       ├── step4_gcc_errors.txt               (GCC 에러 원본)
│       ├── step4_clang_errors.txt             (Clang 에러 원본)
│       ├── step4_error_lines.csv              (에러 파싱 결과)
│       ├── step4_error_triage.csv             (카테고리 분류)
│       ├── step4_triage_report.md             (자동 생성 triage 보고서)
│       └── step4_error_report.md             (최종 연구 분석 보고서)
└── 325383-090-sdm-vol-2abcd.pdf              (Intel SDM Volume 2)
```

---

## 참고 자료

- Intel 64 and IA-32 Architectures Software Developer's Manual Volume 2 (325383-090)
- AsFuzzer 관련 연구 (교수님 이전 연구)
- GAS x86-64 Imm32S 구현: https://sourceware.org/pipermail/binutils/2000-December/008581.html
- LLVM isImmSExti64i32Value: https://codebrowser.dev/llvm/llvm/lib/Target/X86/AsmParser/X86AsmParserCommon.h.html

---

*마지막 업데이트: 2026-05-06*

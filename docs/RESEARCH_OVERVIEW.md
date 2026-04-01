# Intel x86/x64 Assembly Instruction 분석 연구

## 📋 연구 개요

Intel x86/x64 어셈블리 명령어 매뉴얼(Volume 2)을 분석하여, 명령어와 오피코드의 관계를 체계적으로 정리하고, 실제 어셈블러의 정확성을 검증하는 프로젝트입니다.

## 🎯 연구 목표

실제 어셈블러가 Intel 공식 매뉴얼의 규격을 정확하게 준수하는지 검증하기 위한 테스트 데이터 수집 및 구성.

---

## 3️⃣ 단계별 진행 계획

### 1단계: 명령어(Instruction) 리스트 추출

**목표**: Intel x86/x64 어셈블리 명령어 매뉴얼에서 A~Z의 모든 명령어 신텍스(Syntax) 추출

**설명**:
- 매뉴얼 PDF를 텍스트로 변환
- 정규표현식을 활용하여 유효한 명령어 신텍스 추출
- 중복 제거 후 CSV 포맷으로 저장

**결과물**: 
- `instruction_list_original.csv` (5,128개 명령어)

---

### 2단계: Opcode와 Instruction 분리

**목표**: 명령어별로 Opcode(기계어)와 Instruction(명령어 포맷)을 분리

**설명**:
- EVEX/VEX/REX 접두사 감지 및 분리
- 명령어별 오피코드 매핑
- 파라미터(레지스터, 메모리, 상수값)에 따른 다양한 신텍스 보存

**예시**:
```
원본: EVEX.128.0F.W0 10 /rVMOVUPS xmm1 {k1}{z}
→ Opcode: EVEX.128.0F.W0 10 /r
→ Instruction: VMOVUPS xmm1 {k1}{z}
```

**결과물**:
- `instruction_list.csv` (Opcode 분리 완료)

---

### 3단계: 오퍼랜드(Operand) 분석 및 분류

**목표**: 명령어에 사용되는 오퍼랜드를 추출하고 의미별로 분류

**세부 작업**:

#### 3-1. 오퍼랜드 분리 (1로 확장)
- `r/m16` → `r16`, `m16` (레지스터 또는 메모리 표현을 분리)
- `m16&16` → `m16` (유효성 검증 제거)

**결과물**: 6,080개 명령어 (원본 5,128 + 확장 952개)

#### 3-2. 오퍼랜드 추출 및 중복 제거
- 모든 명령어에서 오퍼랜드 추출
- Set 자료구조를 사용한 자동 중복 제거

**결과물**: 229개 고유 오퍼랜드

#### 3-3. 오퍼랜드 의미별 분류
- 15개 카테고리로 분류:
  - 레지스터 (8bit, 16bit, 32bit, 64bit)
  - 벡터 레지스터 (XMM, YMM, ZMM)
  - 메모리 접근 (8bit ~ 512bit)
  - 즉시값 (imm8, imm16, imm32, imm64)
  - 주소 지정 (ptr, rel, vm32x 등)
  - 마스크 레지스터 (k0-k7)

**결과물**:
- `step3_operands_raw.csv` (229개)
- `step3_operands_classified.csv` (221개 분류됨)

---

## 📊 주요 통계

| 항목 | 수치 |
|------|------|
| 원본 명령어 수 | 5,128개 |
| Opcode 포함 (EVEX/VEX/REX) | 2,085개 |
| 일반 명령어 | 3,043개 |
| 오퍼랜드 분리 후 행 수 | 6,080개 |
| 추출된 고유 오퍼랜드 | 229개 |
| 분류된 오퍼랜드 | 221개 |
| 오퍼랜드 카테고리 | 15개 |

---

## 🔬 후속 연구

이 프로젝트에서 수집한 데이터는 다음과 같이 활용될 수 있습니다:

1. **어셈블러 정확성 검증** (AsFuzzer 관련)
   - 실제 어셈블러가 매뉴얼 규격을 정확히 따르는지 테스트
   - 의도하지 않은 문법이 수용되는 버그 탐지

2. **에뮬레이터 버그 발견** (QEMU)
   - 명령어 인코딩/디코딩 검증

3. **명령어 분석 도구 개발**
   - 자동 신텍스 검증 시스템 구축

---

## 📅 실행 기록

- **1회 미팅 (2026-03-10)**: 프로젝트 목표 설정 및 PDF 분석 방식 논의
- **2회 미팅 (2026-03-17)**: 명령어 추출 방법론 및 정규표현식 활용
- **3회 미팅 (2026-03-24)**: Opcode 분리, Operand 분리 및 분류 작업
- **진행 중**: 4회 미팅 준비 (최종 검증 및 보고서 작성)

---

## 📁 프로젝트 구조

```
.
├── docs/
│   ├── RESEARCH_OVERVIEW.md (이 파일)
│   ├── MEETING_NOTES/
│   │   ├── 1회_미팅_내용.md
│   │   ├── 2회_미팅_내용.md
│   │   └── 3회_미팅_내용.md
│   └── references/
│       ├── 325383-090-sdm-vol-2abcd.pdf
│       └── kim-issta24.pdf
├── src/
│   ├── stage1_extraction/
│   │   └── extract_intel_instructions.py
│   ├── stage2_opcode_separation/
│   │   └── (Opcode 분리 로직)
│   └── stage3_operand_processing/
│       └── intel_operand_processing.ipynb
├── data/
│   ├── stage1_extracted/
│   │   └── instruction_list_original.csv
│   ├── stage2_opcode_split/
│   │   ├── instruction_list.csv
│   │   └── instruction_opcode_split.csv
│   └── stage3_operands/
│       ├── operands_raw.csv
│       └── operands_classified.csv
└── scripts/
    └── verify_results.py
```

---

## 🔗 참고 자료

- Intel 64 and IA-32 Architectures Software Developer's Manual Volume 2 (325383-090)
- kim-issta24.pdf (관련 연구논문)

---

*마지막 업데이트: 2026-04-01*

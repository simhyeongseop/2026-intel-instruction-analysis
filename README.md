# Intel x86/x64 Assembly Instruction Analysis Research

<div align="center">

![Python](https://img.shields.io/badge/Python-3.8+-blue)
![Pandas](https://img.shields.io/badge/Pandas-Data%20Analysis-green)
![License](https://img.shields.io/badge/License-CNU%20Research-red)
![Status](https://img.shields.io/badge/Status-In%20Progress-yellow)

**Intel x86/x64 어셈블리 명령어 매뉴얼 분석 및 어셈블러 검증 프로젝트**

</div>

---

## 📖 프로젝트 소개

이 프로젝트는 Intel 64 and IA-32 Architectures Software Developer's Manual(Volume 2)을 자동으로 분석하여, 5,000+ 어셈블리 명령어를 추출하고 체계적으로 분류합니다.

**목표**: 실제 어셈블러가 Intel 공식 매뉴얼의 규격을 정확하게 준수하는지 검증하기 위한 참조 데이터 구축

---

## 🎯 주요 성과

| 항목 | 수치 |
|------|------|
| 추출된 명령어 | 5,128개 |
| Opcode 포함 | 2,085개 (EVEX/VEX/REX) |
| 오퍼랜드 확장 | 6,080개 |
| 고유 오퍼랜드 | 229개 |
| 분류 카테고리 | 15개 |

---

## 🏗️ 프로젝트 구조

```
.
├── README.md                      # 프로젝트 소개 (이 파일)
├── .gitignore                     # Git 제외 파일 설정
│
├── docs/                          # 📚 문서 폴더
│   ├── RESEARCH_OVERVIEW.md       # 연구 개요 (자세한 설명)
│   ├── MEETING_NOTES/             # 각 미팅별 기록
│   │   ├── 1회_미팅_내용.md
│   │   ├── 2회_미팅_내용.md
│   │   └── 3회_미팅_내용.md
│   └── references/                # 참고 문서
│       ├── 325383-090-sdm-vol-2abcd.pdf
│       └── kim-issta24.pdf
│
├── src/                           # 💻 소스 코드
│   ├── stage1_extraction/
│   │   └── extract_intel_instructions.py
│   ├── stage2_opcode_separation/
│   │   └── (Opcode 분리 로직 포함)
│   └── stage3_operand_processing/
│       └── intel_operand_processing.ipynb
│
├── data/                          # 📊 데이터 폴더
│   ├── stage1_extracted/
│   │   └── instruction_list_original.csv (5,128줄)
│   ├── stage2_opcode_split/
│   │   ├── instruction_list.csv
│   │   └── instruction_opcode_split.csv
│   └── stage3_operands/
│       ├── operands_raw.csv (229개)
│       └── operands_classified.csv (221개)
│
└── scripts/                       # 🔧 유틸리티
    └── verify_results.py
```

---

## 🚀 빠른 시작

### 필수 요구사항

```bash
Python 3.8+
pandas >= 1.3.0
pdfplumber >= 0.5.0
```

### 설치

```bash
# 저장소 클론
git clone https://github.com/yourusername/intel-instruction-analysis.git
cd intel-instruction-analysis

# 의존성 설치
pip install -r requirements.txt
```

### 실행

```bash
# 1단계: 명령어 추출
python src/stage1_extraction/extract_intel_instructions.py

# 2단계: Opcode 분리 (코드 내 구현)
python src/stage2_opcode_separation/...

# 3단계: Operand 처리 (Jupyter Notebook)
jupyter notebook src/stage3_operand_processing/intel_operand_processing.ipynb

# 최종 검증
python scripts/verify_results.py
```

---

## 📊 3단계 작업 흐름

### **1️⃣ 명령어 추출 (Stage 1)**
```
Intel Manua PDF
     ↓
pdfplumber PDF 파싱
     ↓
정규식 필터링 (Instruction 패턴)
     ↓
중복 제거 (Set)
     ↓
✅ instruction_list_original.csv (5,128개)
```

### **2️⃣ Opcode 분리 (Stage 2)**
```
Instruction 리스트
     ↓
EVEX/VEX/REX 접두사 감지
     ↓
정규식으로 Opcode 추출
     ↓
Instruction 부분 분리
     ↓
✅ instruction_list.csv (분리 완료)
```

### **3️⃣ Operand 분석 (Stage 3)**

#### 3-1. Operand 분리 (1로 확장)
```
ADD r/m16  →  ADD r16, ADD m16  (2줄)
     ↓
✅ 6,080개 명령어 (952개 추가)
```

#### 3-2. Operand 추출
```
모든 명령어 스캔
     ↓
정규식으로 operand 패턴 추출
     ↓
Set으로 중복 제거
     ↓
✅ 229개 고유 operand
```

#### 3-3. Operand 분류
```
229개 operand
     ↓
의미별로 15개 카테고리 분류
     ↓
✅ operands_classified.csv (221개 분류됨)
```

---

## 🔬 데이터 형식

### Stage 1: instruction_list_original.csv
```csv
Instruction Syntax
AAA
AAD
AAD imm8
...
```

### Stage 2: instruction_list.csv
```csv
Original,Opcode,Instruction
ADC r/m16,,ADC r16
ADC r/m16,,ADC m16
EVEX.128.0F.W0 10 /rVMOVUPS xmm1 {k1}{z},EVEX.128.0F.W0 10 /r,VMOVUPS xmm1 {k1}{z}
...
```

### Stage 3: operands_classified.csv
```csv
Category,Operand
Register_16bit,ax
Register_16bit,bx
Memory_16bit,m16
Immediate,imm8
...
```

---

## 📈 통계 요약

### Opcode 분포
- **EVEX 접두사**: ~800개
- **VEX 접두사**: ~700개
- **REX 접두사**: ~585개
- **일반 명령어**: 3,043개

### Operand 분류
- **기타 (Other)**: 170개
- **주소 지정 (AddressingMode)**: 11개
- **즉시값 (Immediate)**: 5개
- **벡터 레지스터**: 14개 (XMM 6, YMM 5, ZMM 3)
- **일반 레지스터**: 11개
- **메모리**: 7개
- **마스크**: 3개

---

## 🔍 핵심 개념

### Opcode vs Operand

| 항목 | 설명 | 예시 |
|------|------|------|
| **Opcode** | CPU가 해석하는 기계어 코드 | `EVEX.128.0F.W0 10 /r` |
| **Operand** | 명령어가 사용할 데이터/레지스터 | `r16`, `m128`, `imm8` |
| **Instruction** | 명령어 = Mnemonic + Operands | `ADD r16, m16` |

---

## 📚 참고 자료

- [Intel 64 and IA-32 Architectures Software Developer Manual Volume 2](https://www.intel.com/content/www/us/en/develop/download/intel-64-and-ia-32-architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4.html)
- AsFuzzer: Automatic Syntax Error Detection for x86 Assembly (Related Research)

---

## 🤝 기여

이 프로젝트는 CNU(충남대학교) 컴퓨터과학과 연구실 인턴 프로젝트입니다.

**담당 교수**: [교수님 이름]  
**연구원**: [2026학년도 학부생 인턴]

---

## 📅 진행 일정

- **1회 미팅** (2026-03-10): 프로젝트 킥오프, 목표 설정
- **2회 미팅** (2026-03-17): 1단계 결과 검토, 기술 피드백
- **3회 미팅** (2026-03-24): 2-3단계 완성, 최종 검증
- **4회 미팅** (미정): 최종 보고 및 GitHub 업로드

---

## 📝 라이선스

이 프로젝트는 CNU 연구실 프로젝트로 관리됩니다.

---

## 💬 문의

질문이나 제안사항이 있으시면 이슈(Issue)를 등록해주세요.

---

<div align="center">

**Made with ❤️ at CNU Research Lab**

*Last Updated: 2026-04-01*

</div>

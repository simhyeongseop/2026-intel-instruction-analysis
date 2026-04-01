# Intel x86/x64 Assembly Instruction Analysis - 인포그래픽 프롬프트

## 📋 프롬프트 개요

다음 프롬프트를 Figma, Adobe Illustrator, Canva, 또는 AI 이미지 생성 도구(DALL-E, Midjourney, Claude Vision 등)에서 사용할 수 있습니다.

---

## 🎨 인포그래픽 프롬프트 1: 프로젝트 전체 흐름도

### **스타일**: 모던 데이터 시각화 / 기술 블로그 스타일

```
Create a comprehensive infographic showing the 3-stage data processing pipeline 
for Intel x86/x64 assembly instruction analysis research.

LAYOUT:
- Horizontal flow diagram with 3 main stages, left to right
- Clean, modern design with blue/tech color scheme (blue, cyan, white)
- Monospace fonts for technical terms

STAGE 1 - INSTRUCTION EXTRACTION (왼쪽):
- Input: Intel PDF Manual Volume 2 (show book icon)
- Process: pdfplumber → Regex filtering → Deduplication
- Output: 5,128 Instructions CSV
- Color: Light Blue (#E3F2FD)
- Icons: PDF document, code brackets, database

STAGE 2 - OPCODE SEPARATION (중앙):
- Input: 5,128 Instructions from Stage 1
- Process boxes showing:
  * EVEX/VEX/REX detection (glow effect)
  * Opcode extraction using regex
  * Instruction format parsing
- Statistics: 2,085 with prefix, 3,043 without
- Output: Separated CSV (Original | Opcode | Instruction)
- Color: Cyan (#B3E5FC)
- Icons: Split symbol, prefix tags, table

STAGE 3 - OPERAND ANALYSIS (오른쪽):
- 3 sub-stages shown vertically:
  * 3-1: Operand Splitting (r/m16 → r16, m16) → 6,080 rows
  * 3-2: Operand Extraction → 229 unique operands
  * 3-3: Operand Classification → 15 categories
- Color: Light Cyan (#80DEEA)
- Icons: Split arrows, collection/set, categorization pie chart

STATISTICS BOX (아래):
- 3 key metrics displayed with icons:
  * 5,128 Total Instructions
  * 229 Unique Operands
  * 15 Classification Categories
- Use progress bars or circular gauges

CONNECTIONS:
- Thick arrows between stages showing data flow
- Show row/element counts on arrows (5,128 → 6,080 → ...)

DESIGN DETAILS:
- White background with subtle grid pattern
- Rounded corner boxes for each section
- Drop shadows for depth
- Color-coded legends
- Sans-serif font (Roboto, Inter, or similar) for labels
- Monospace font (Monaco, Courier New) for technical terms and statistics
```

---

## 🎨 인포그래픽 프롬프트 2: Operand 분류 원형 차트

### **스타일**: 데이터 시각화 / 카테고리 분해

```
Create a circular/donut chart infographic showing the classification distribution 
of 221 operands across 15 categories.

CHART TYPE: Donut chart with category breakdown

CATEGORIES & COLORS:
- Other (170): #1976D2 (Deep Blue) - largest segment
- AddressingMode (11): #0097A7 (Cyan)
- Immediate (5): #7B1FA2 (Purple)
- VectorRegister_XMM (6): #F57C00 (Orange)
- VectorRegister_YMM (5): #FFA726 (Light Orange)
- Register_64bit (3): #388E3C (Green)
- Register_16bit (3): #66BB6A (Light Green)
- MaskRegister (3): #EC407A (Pink)
- Memory_128bit_plus (3): #5C6BC0 (Indigo)
- Register_32bit (2): #29B6F6 (Light Blue)
- Memory_32bit (2): #AB47BC (Purple)
- VectorRegister_ZMM (3): #EF5350 (Red)
- Memory_16bit (1): #FFCA28 (Amber)
- Memory_8bit (1): #FFA726 (Orange)
- Register_8bit (3): #26A69A (Teal)

CENTER TEXT:
- Large number: "221"
- Smaller text: "Total Operands"

OUTER RING LABELS:
- Category names with percentage
- Example: "Other (77%)" with small icon representing each category
  * Register icon for register categories
  * Memory icon for memory categories
  * Number icon for immediates
  * Location pin for addressing mode
  * Mask icon for mask registers

LEGEND (옆)
- List all categories with color squares
- Show exact numbers (170, 11, 5, etc.)
- Alphabetically sorted or by size

ANNOTATIONS:
- Highlight top 3 categories with callout boxes
- Add brief descriptions:
  * "Other": ALU instructions, jumps, etc.
  * "Memory Categories": Various memory access sizes
  * "Vector Registers": SIMD instruction operands
```

---

## 🎨 인포그래픽 프롬프트 3: Opcode 접두사 분포

### **스타일**: 비교 차트 / 통계

```
Create a comparison infographic showing the distribution of Opcode prefixes 
in Intel x86/x64 instructions.

LAYOUT: Vertical bar chart with summary

BAR CHART:
- X-axis: Opcode Types (EVEX, VEX, REX, None)
- Y-axis: Number of Instructions (0-3500)
- Bar colors:
  * EVEX: #1565C0 (Dark Blue)
  * VEX: #0097A7 (Cyan)
  * REX: #FFA000 (Amber)
  * None: #E0E0E0 (Light Gray)

DATA:
- EVEX: ~800 bars showing AVX-512 instructions
- VEX: ~700 bars showing AVX/AVX2 instructions
- REX: ~585 bars showing 64-bit extension instructions
- None: 3,043 bars showing traditional x86 instructions

ANNOTATIONS ON BARS:
- Exact numbers on top of each bar
- Percentage labels (e.g., "60.7%")
- Horizontal line at 3,000 showing baseline

LEGEND BOX (우상단):
- Icon + color + name + count for each category
- Small icons:
  * EVEX: Fancy "E" letter with glow
  * VEX: "V" letter
  * REX: "R" letter
  * None: Document icon

SUMMARY STATISTICS (아래):
- Total Instructions: 5,128
- With Prefix: 2,085 (40.6%)
- Without Prefix: 3,043 (59.4%)
- Most Common: Traditional x86 instructions
- Advanced Extensions: 39.4% of instructions

DESIGN:
- Tech blue and amber color scheme
- Clean grid background
- No 3D effects, flat design
- Rounded corners
- Clear typography hierarchy
```

---

## 🎨 인포그래픽 프롬프트 4: 3단계 병렬 처리

### **스타일**: 프로세스 플로우 / 마이크로인터렉션

```
Create a side-by-side comparison showing the data transformation 
at each of the 3 stages of the research project.

LAYOUT: 3 columns (one per stage)

COLUMN 1 - STAGE 1: 명령어 추출
- Top: Source icon (PDF document with glow)
- Middle: Processing step illustrations
  * PDF scanning
  * Table parsing (show table grid)
  * Regex pattern matching (show regex symbols)
  * Deduplication (show overlapping items becoming single)
- Bottom: Output count in large bold: "5,128"
- Subtitle: "Unique Instructions"
- Background color: #E3F2FD (Light Blue)
- Icons: PDF, table, regex, set

COLUMN 2 - STAGE 2: Opcode 분리
- Top: Input from Stage 1 (arrow pointing down)
- Middle: Processing illustrations
  * Prefix detection (show EVEX, VEX, REX labels with highlights)
  * String splitting (show slash separator)
  * Format parsing (show before/after example)
- Bottom: 2 output counts side-by-side
  * "2,085 with Prefix"
  * "3,043 without Prefix"
- Subtitle: "Instructions Separated"
- Background: #B3E5FC (Cyan)
- Icons: Prefix badges, split arrows, code brackets

COLUMN 3 - STAGE 3: Operand 분석
- Top: Input from Stage 2 (arrow pointing down)
- Middle: 3 sub-boxes showing:
  * Box 3-1: r/m16 splitting illustration → "6,080 rows"
  * Box 3-2: Operand collection → "229 operands"
  * Box 3-3: Category classification → "15 categories"
- Bottom: "Complete Classification"
- Background: #80DEEA (Light Cyan)
- Icons: Split sign, database, pie chart

CONNECTING ARROWS:
- Thick arrows between columns showing progression
- Show data count transformations on arrows
- Curved arrow style, not straight

HEADER:
- Title: "3-Stage Intel Instruction Analysis Pipeline"
- Subtitle: "From Raw Manual Data to Classified Operands"

DESIGN ELEMENTS:
- Consistent color progression (light blue → cyan → lighter cyan)
- Icons for each stage (extraction, separation, classification)
- Modern rounded corner boxes
- Clean monospace font for numbers
- Sans-serif for labels
- Subtle background grid
```

---

## 🎨 인포그래픽 프롬프트 5: Timeline & Milestones

### **스타일**: 프로젝트 진행상황 / 타임라인

```
Create a project timeline infographic showing research progress from 
initial project launch to completion.

LAYOUT: Horizontal timeline with 4 milestones

TIMELINE DESIGN:
- Horizontal line from left to right
- 4 milestone circles on the line (one per week)
- Dates below each circle
- Descriptions above each circle

MILESTONE 1 (2026-03-10):
- Circle color: #FFC107 (Amber) - In progress
- Icon: Target/Goal
- Title: "Project Kickoff"
- Description: 
  * Problem definition
  * Methodology selection
  * Research scope
- Key achievement: Started with 0, planning to extract 5,000+

MILESTONE 2 (2026-03-17):
- Circle color: #66BB6A (Green) - Completed
- Icon: Data extraction (arrow into database)
- Title: "Instruction Extraction Complete"
- Description:
  * 5,128 instructions extracted
  * PDF parsing successful
  * Regex filtering applied
- Key stat: "5,128 Instruction Syntax"

MILESTONE 3 (2026-03-24):
- Circle color: #66BB6A (Green) - Completed
- Icon: Split/separation symbol
- Title: "Opcode Separation & Operand Analysis"
- Description:
  * Opcode-Instruction separated
  * Combined operands split (1-to-many)
  * 229 unique operands extracted
  * 15 categories created
- Key stats: "2,085 opcodes | 6,080 rows | 229 operands"

MILESTONE 4 (In Progress):
- Circle color: #29B6F6 (Light Blue) - Next
- Icon: Report/presentation
- Title: "Final Report & Publication"
- Description:
  * Data validation
  * GitHub organization
  * Documentation completion
  * Ready for further research
- Key milestone: "GitHub Repository Launch"

PROGRESS BAR (위쪽):
- Shows 75% completion (3 of 4 stages done)
- Color fills from left to right
- Gradient from blue to cyan

STATISTICS BOXES (아래의 타임라인):
- Each milestone has a stat box showing:
  * Inputs (what went in)
  * Outputs (what came out)
  * Key metrics
  
DESIGN:
- Vertical alignment with clear hierarchy
- Light background (#FAFAFA)
- Color-coded progress status
- Icons for each phase
- Clean typography
- Subtle shadows for depth
```

---

## 📝 인포그래픽 생성 순위 추천

1. **프롬프트 1** (전체 흐름도): 프로젝트 이해를 위해 가장 중요
2. **프롬프트 3** (Opcode 분포): 분석 결과를 가장 직관적으로 표현
3. **프롬프트 2** (Operand 원형 차트): 분류 결과 시각화
4. **프롬프트 4** (병렬 처리): 각 단계의 변환 과정 설명
5. **프롬프트 5** (타임라인): 프로젝트 진행상황 추적

---

## 🛠️ 사용 방법

### Figma에서 사용
```
1. Figma 신규 프로젝트 생성
2. "FigJam" 또는 "Design" 선택
3. 위의 프롬프트를 복사하여 붙여넣기
4. 각 섹션의 지시사항에 따라 수동으로 구성
5. Assets 라이브러리에서 아이콘 추가
```

### AI 이미지 생성 도구 (DALL-E, Midjourney)
```
1. 위의 프롬프트를 영어로 번역
2. "Create an infographic showing..." 으로 시작
3. 스타일 지정 (modern, tech, data visualization)
4. 색상 코드 명시
5. 생성 및 수정
```

### Adobe Illustrator에서 사용
```
1. 프롬프트대로 도형 및 텍스트 배치
2. 색상 라이브러리 생성
3. 단계별로 그룹화하여 관리
4. 최종 export
```

---

## 🎨 색상 팔레트

```
Primary Colors:
- Deep Blue: #1976D2
- Cyan: #0097A7
- Light Blue: #E3F2FD
- Lighter Blue: #B3E5FC
- Lightest Blue: #80DEEA

Accent Colors:
- Amber: #FFC107
- Green: #66BB6A
- Purple: #7B1FA2
- Orange: #F57C00

Neutral:
- White: #FFFFFF
- Light Gray: #F5F5F5
- Medium Gray: #E0E0E0
- Dark Gray: #424242
```

---

## 📐 추천 크기

- **웹**: 1200 x 800px (~16:10 ratio)
- **프레젠테이션**: 1920 x 1080px (Full HD)
- **문서**: A4 (2480 x 3508px @ 300dpi)
- **소셜 미디어**: 1080 x 1350px (Instagram)

---

## ✨ 디자인 팁

1. **일관성**: 모든 인포그래픽에서 색상/폰트 통일
2. **가독성**: 큰 숫자와 작은 설명 구분
3. **흐름**: 위→아래 또는 왼쪽→오른쪽 방향성 명확
4. **아이콘**: 각 개념마다 고유 아이콘 사용
5. **여백**: 과도하지 않은 spacing으로 깔끔함 유지

---

*마지막 수정: 2026-04-01*  
*프롬프트 버전: 1.0*

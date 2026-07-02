# Intel Instruction Analysis

Intel SDM(Software Developer's Manual) Volume 2에서 instruction form을 추출하고, 이를 실제 Intel-syntax assembly test case로 변환한 뒤 assembler/disassembler 동작을 검증하는 연구 프로젝트입니다.

## 연구 질문

```text
Intel SDM의 instruction form을 실제 assembly로 만들었을 때,
GNU as(binutils)와 llvm-mc(LLVM)가 이를 어떻게 인코딩하는가?
두 어셈블러 간 divergence가 발생하는 조건은 무엇인가?
```

## 파이프라인

```text
Intel SDM PDF (Vol. 2A-2D)
  ├─ Stage 1: instruction form 전량 추출 (64비트 무효 포함)
  ├─ Stage 2: opcode / mnemonic / operand 분리 + r/m 확장
  ├─ Stage 3: operand type → concrete assembly 매핑 + 변주 축(A/C/D) + 음성셋(N1/N2)
  ├─ Stage 4: assembly test case 생성 + compile error triage (TODO: 재실행 필요)
  ├─ Stage 5: objdump roundtrip 비교 (TODO: 재실행 필요)
  └─ Stage 6: differential encoding (as vs llvm-mc → divergence 측정)
```

## 현재 진행 상태

| Stage | 상태 | 산출물 행수 |
|-------|------|------------|
| 1 | ✅ 완료 | 4,184 form (Invalid 포함) |
| 2 | ✅ 완료 | 4,757 행 (r/m split) |
| 3 | ⏳ 재실행 필요 | — |
| 4 | ⏳ Stage 3 이후 재실행 | — |
| 5 | ⏳ Stage 4 이후 재실행 | — |
| 6 | ✅ 기반 코드 완료 | base 116 divergence |

## 주요 디렉터리

```text
src/
  stage1_extraction/              PDF에서 instruction form 추출
  stage2_opcode_separation/       opcode/instruction 분리 + r/m 확장
  stage3_operand_processing/      operand 매핑, 축 변주, 음성셋 생성
  stage4_test_generation/         assembly 생성 및 compile error triage
  stage5_disassembly_validation/  objdump roundtrip 비교
  stage6_differential/            as vs llvm-mc differential encoding

data/
  stage1_extracted/               Stage 1 산출물
  stage2_opcode_split/            Stage 2 산출물
  stage3_operands/                operand 매핑 + coverage + .s 파일
  stage4_tests/                   생성된 assembly와 에러 결과
  stage5_disassembly/             disassembly 비교 결과
  stage6_differential/            differential encoding 결과
  instruction_db/                 instruction description DB

scripts/                          일회성 분석/검증 스크립트
docs/                             설계 문서, 미팅 노트, 보고서
```

## 실행

```bash
# Stage 1: PDF에서 form 추출
python src/stage1_extraction/extract_instruction_forms.py

# Stage 2: opcode 분리 + r/m split
python src/stage2_opcode_separation/step2_separate_operands.py

# Stage 3: operand 매핑 + assembly 생성
python src/stage3_operand_processing/step3_operand_mapping.py

# Stage 6: differential encoding (WSL 필요)
python src/stage6_differential/diff_encode.py --src data/stage3_operands/step3_generated.s
```

## 설계 원칙

- **전량 추출**: 64비트 무효(Invalid/N.E./N.S.) form도 추출하고 `ModeSupport` 컬럼으로 구분. 무효 form은 음성 테스트셋(N9)으로 활용 가능.
- **독립 오라클**: GNU as(binutils) vs llvm-mc(LLVM) 두 어셈블러를 독립 오라클로 사용.
- **지표**: 통과율이 아닌 **divergence** (support_diff + semantic_divergence + decode_disagree).
- **정답 기준**: Intel SDM 매뉴얼 원문.

## 환경 요구사항

- Python 3.10+ (pdfplumber, iced-x86)
- WSL(Ubuntu): `as`, `llvm-mc`, `objdump` 설치 필요
- 입력 PDF: `325383-090-sdm-vol-2abcd.pdf` (git 미포함, 별도 준비)

## 주의사항

- `data/` 산출물은 재생성 가능하며, 스크립트 재실행으로 복구됩니다.
- Stage 4/5는 현재 Stage 2 갱신 이후 아직 재실행되지 않았으므로 과거 결과가 남아 있을 수 있습니다.

# Stage 1–3 재작성 및 3중 검토 요약

## 배경 (문제)
기존 Stage 1(`extract_intel_instructions.py`)은 인코딩 표 레이아웃을 legacy 6-컬럼
(`Opcode | Instruction | ...`)으로 고정 가정했다. 그러나 Intel SDM의 벡터
(SSE/AVX/AVX-512) 명령어 표는 `Opcode/Instruction` 이 한 셀에 병합된 5-컬럼
레이아웃이라, 기존 코드는 그 행들을 전부 버렸다.
→ 결과적으로 **V로 시작하는 벡터 명령어가 통째로 누락**됐다(교수님 지적사항).

## 재작성 파이프라인
| 단계 | 파일 | 산출물 | 내용 |
|---|---|---|---|
| TOC | `src/stage1_extraction/extract_toc_instruction_list.py` | `data/stage1_extracted/toc_instruction_list.csv` | 목차에서 명령어 전체 목록 추출(ground truth) |
| Stage 1 | `src/stage1_extraction/extract_instruction_forms.py` | `data/stage1_extracted/instruction_forms.csv` | description 페이지 인코딩 표에서 instruction form 추출 (레이아웃 자동판별) |
| 검증 | `src/stage1_extraction/check_coverage.py` | (출력) | 목차 대비 커버리지 대조 |
| Stage 2 | `src/stage2_opcode_separation/step2_separate_operands.py` | `data/stage2_opcode_split/step2_instruction_forms_split.csv` | 니모닉/오퍼랜드 분리 + `r/m` 확장 |
| Stage 3 | `src/stage3_operand_processing/step3_operand_mapping.py` | `data/stage3_operands/step3_*` | 오퍼랜드 타입 → 구체 어셈블리 값 매핑, 어셈블리 생성 |
| 검증 | `src/stage3_operand_processing/verify_assembly.py` | `data/stage3_operands/step3_asm_errors.csv` | 생성 어셈블리를 GNU as로 실제 어셈블 |
| Stage 5 | `src/stage5_disassembly_validation/step5_roundtrip.py` | `data/stage5_disassembly/step5_roundtrip_*` | 어셈블 → objdump 역어셈블 → 원본과 비교/분류 |

## Stage 1 레이아웃 자동 판별
표 헤더 첫 셀이 `Opcode`로 시작하면 인코딩 표로 인식하고:
- **분리형**(`Opcode | Instruction`): legacy 6-컬럼, GETSEC 3-컬럼
- **병합형**(`Opcode/Instruction`, `Opcode Instruction`): 벡터/SSE — col0에서 opcode 토큰을 걷어내고 니모닉부터를 instruction으로 분리
- opcode 칸이 진짜 opcode(16진/VEX/EVEX/0F 등)가 아니면 배제(설명 표 오탐 방지)
- 다음 페이지로 넘어간 헤더 없는 연속 표도 직전 표 구조로 파싱

매뉴얼 원문 근거로 고친 파싱 버그(실제 페이지 확인):
`56/r` 글루, `E0,`·`/r1` 각주, `!(11):rrr:bbb` ModRM 지정자, `/ib`·`/vsib` 토큰,
헤더병합·데이터분리(CRC32), `FNSTSW1` 각주, `AES- ENCWIDE` 줄바꿈 하이픈,
`(mod!=11, /5, memory only)` 괄호 주석.

---

# 3중 검토 결과

## 검토 1 — 목차 대비 커버리지 (실제 명령어 누락 0)
- 추출 form: **4,094**, 고유 니모닉: **1,602**, V(벡터) 니모닉: **773**
- 목차 니모닉 1,141개 중 forms 미포함 67개 내역:
  - 예상된 제외 41 (64비트 invalid[ARPL 포함], `cc` placeholder, 그룹 대표명)
  - 대소문자 차이 12 (`VEXTRACTF32x8` = SDM이 `X`로 표기 → 존재)
  - 그룹명→구체형 존재 6 (`VPSHLD`→`VPSHLDW/D/Q`)
  - AVX-512 V접두형 존재 7 (`PABSQ`→`VPABSQ`)
  - **진짜 누락 1**: `VCOMPRESSW` (목차 오타, 실제 `VPCOMPRESSW`는 정상 캡처)
- → **실제 어셈블러 명령어 기준 누락 없음**

## 검토 2 — 실제 어셈블 (GNU as 2.42, `--64 -mintel64`)
- Stage 2 확장 후 form: 4,657 → Stage 3 매핑·생성: **4,650 (99.8%)**, 스킵 7
- 어셈블 성공: **4,642 / 4,650 = 99.83%**

## 검토 3 — 실패 8건 분석 (매뉴얼 근거 분류)
| 실패 | 건수 | 성격 |
|---|---|---|
| `ud01`, `udb` no such instruction | 3 | 실존하지 않는 표기(UD0/1/2만 유효) — 어셈블러가 올바르게 거부 |
| `vscatterdpd` VSIB 주소 | 2 | scatter/VSIB 마스크 문법 특수(엣지) |
| `lsl rax, eax` | 1 | 소스가 r/m16 이어야 하는 특수 form |
| `mov ds, ...` | 1 | 세그먼트 로드 메모리 크기 특수 |
| `senduipi eax` | 1 | 핸들 레지스터 r64 필요 |

→ 3건은 "어셈블러가 올바르게 거부한 비실존 명령어", 5건은 소수 특수 명령어의
오퍼랜드 구체값 엣지케이스.

## Stage 3 특수 케이스 처리 (매핑률 향상)
- 문자열 prefix형: `REP/REPE/REPNE + CMPS/LODS/MOVS/STOS/SCAS/INS/OUTS` → `repne scasd` 등
- 레지스터 쌍: `zmm2+3`→`zmm2`, `k1+1`→`k1`
- 토큰 내 암묵 오퍼랜드: `r32 <XMM0-6>`→`r32`
- GP 레지스터 다중 크기 대안(`r16/r32/r64`)은 64비트 선호(주소 레지스터 안전)
- 64비트 모드 필터 보강: `N. E.`(공백 아티팩트)도 인식 → ARPL 등 제외

## 남은 미매핑 (7 form) — 파싱 아티팩트/미지원 문법
- far pointer: `ptr16:16`, `ptr16:32` (GAS far-jump 문법 위험으로 스킵)
- 파싱 잔재: `1 m8`, `1 r8`, `2 1`, `imm8/r`

---

# Stage 5 — 역어셈블 Roundtrip 비교

Stage 3 생성 어셈블리 → GNU as 조립 → `objdump -d -M intel` 역어셈블 →
원본과 정규화 비교. (어셈블 실패 8건 제외한 4,642개 대상)

## 결과
- 비교 대상: **4,642**
- 의미적 동일(정상)으로 자동 분류: **4,571 (98.47%)**
  - exact_match 4,179 / alias 131 / string_alias 85 / operand_repr 66 / relative_target 67 / pseudo_op 28 / implicit_operand 15
- 검토 대상: 71 (register_width 9, mnemonic_changed 35, operand_changed 24, missing 3)

## 분류 기준(정상)
- `alias` 니모닉 별칭·조건코드 동의어 (`sal=shl`, `cmovc=cmovb`, `retq=ret`)
- `string_alias` 문자열 명령 표준형 (`cmpsb`↔`cmps ds:[rsi],es:[rdi]`, `rep`/`repz` 접두)
- `pseudo_op` 의사명령 (`cmppd,imm=1`↔`cmpltpd`, `pclmulqdq,imm`↔`pclmulhqlqdq`)
- `implicit_operand` objdump가 암묵 피연산자 명시 (`blendvpd ...`↔`...,xmm0`)
- `operand_repr_changed` 숫자/표기 차이, `relative_target` `.`↔절대주소

## 검토 대상(정상 아님, 의도적으로 남김)
- `register_width_changed`(9): `lldt ax`↔`lldt eax` 등 — **교수님이 언급한 레지스터 폭 표시 케이스**. objdump가 시스템 명령의 r/m16 피연산자를 32비트 이름으로 표기
- `prefetchit0/it1`→`nop`: as 2.42가 최신 명령을 NOP 힌트로 인코딩(툴 버전차)
- `vgatherdpd` 등 VSIB gather 표기차, loop/lock 구간 정렬 잔재

→ Roundtrip은 "모두 초록"을 목표로 하지 않고, **의미 차이가 있는 소수를 표면화**하는 것이 목적이다. 검토 대상 71건은 `step5_roundtrip_compare.csv`에서 확인 가능.

## 재현 방법
```
python src/stage1_extraction/extract_instruction_forms.py
python src/stage1_extraction/check_coverage.py
python src/stage2_opcode_separation/step2_separate_operands.py
python src/stage3_operand_processing/step3_operand_mapping.py
python src/stage3_operand_processing/verify_assembly.py   # WSL + GNU as 필요
python src/stage5_disassembly_validation/step5_roundtrip.py  # WSL + as/objdump 필요
```

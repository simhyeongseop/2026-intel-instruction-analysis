# 8회 미팅 PPT 초안 (지도교수님 1:1, 15~20분, 약 15장)

작성일: 2026-07-24
구성: 방법론(파이프라인 재설계) + 결과(진짜 버그 7건) 균형. 미해결 항목은 "질문/논의" 슬라이드로 분리.

각 슬라이드마다 **내용 / 첨부(사진·표) / 근거 파일** 순으로 정리했다. 근거 파일 경로는 이 저장소(`2026-intel-instruction-analysis/`) 기준 상대경로.

---

## 슬라이드 1. 표지

**내용**
- 제목: "Intel Instruction Syntax 검증 파이프라인 재설계 및 결과 보고"
- 부제: SDM Vol.2 문법 준수 어셈블리를 GNU as가 처리하지 못하는 사례 탐색
- 이름 / 날짜 / 지도교수님

**첨부**: 없음 (심플하게)

---

## 슬라이드 2. 지난 미팅 회고 — 연구 질문 재확인

**내용**
- 7회 미팅(2026-05-20) 핵심 피드백 인용: "Intel syntax의 규칙을 지켜서 assembly text를 만들었는데도 assembler/disassembler가 제대로 처리하지 못하는 사례를 찾는 것이 이 스터디의 주제에 가깝다."
- 그때 지적받은 문제점 3가지와 이번에 어떻게 반영했는지 한 줄씩:
  1. "무작위 오퍼랜드 생성" → SDM 기반 대표값 생성으로 교체
  2. "compile 전에 교수님께 질문하지 말고 직접 as/objdump로 확인" → 모든 판정을 도구 실행 결과로만 함
  3. "문제 케이스를 유형별로 그룹핑" → triage 7단계에서 자동 카테고리 분류

**첨부**: 7회 미팅 노트 인용 박스 (텍스트만, 사진 불필요)

**근거 파일**: `docs/MEETING_NOTES/7회_미팅_내용.md`

---

## 슬라이드 3. 이번 라운드 한 줄 요약

**내용**
- 기존의 llvm-mc·iced-x86·다수 어셈블러 비교 등으로 과도하게 복잡해진 파이프라인을 폐기하고, 7단계 구조로 전면 재설계
- SDM 명령어 형식 4,210건 → 구체 조합 7,277개 → 실제 GNU as 어셈블 → objdump 역어셈블 → 유형별 자동 분류
- 최종적으로 **SDM과 GNU as가 실제로 다르게 동작하는 진짜 버그 후보 7건**을 도구 재현 + PDF 원문 대조까지 마쳐서 확정
- 부수적으로 우리 자신의 테스트 생성기(combiner) 자체의 결함 6가지도 발견해서 수정

**첨부**: 숫자 요약 카드 4개 (4,210 → 7,277 → 7 버그 확정 → 6 도구 결함 수정)

**근거 파일**: `docs/DEVLOG.md` (2026-07-23 ~ 2026-07-24 전체 항목)

---

## 슬라이드 4. 파이프라인 구조 (7단계)

**내용**: 아래 다이어그램을 그대로 슬라이드에 옮기기

```
SDM PDF
  │
  ▼
[1 extractor]  매뉴얼 -> ISA DB (opcode/instruction/mnemonic/operands/mode_support 등)
  ▼
[2 tokenizer]  mnemonic·operand form을 토큰으로 분해
  ▼
[3 combiner]   토큰 -> 가능한 operand 조합 생성 (대표값 1~2개, 조합 폭발 방지)
  ▼
[4 generator]  조합 선택 -> 구체 Intel-syntax 어셈블리 생성
  ▼
[5 assembler]  어셈블리 -> 기계어 (GNU as)   ──컴파일 에러──▶ [7 triage]
  ▼ (성공)
[6 roundtrip]  기계어 -> objdump 역어셈블 -> 원본과 비교   ──차이 발견──▶ [7 triage]
  ▼
[7 triage]     에러·차이를 유형별로 그룹핑, false alarm과 진짜 버그 구분
```

- 핵심 설계 원칙: "정답 = 인텔 매뉴얼", "판정은 도구(as/objdump)가 한다, LLM 추측 아님", "차이 ≠ 버그"

**첨부**: 위 다이어그램을 파워포인트 도형(사각형+화살표)으로 재현. 또는 스크린샷 대신 직접 그리기 권장

**근거 파일**: `CLAUDE.md` (2절 하이레벨 설계)

---

## 슬라이드 5. 개발 방식 — "개발하는 애 + 검증하는 애"

**내용**
- 모듈(단계) 하나를 구현할 때마다 별도의 검증 담당이 정답지·회귀 테스트로 대조 → pass 안 하면 다음 단계로 안 넘어감
- 실패하면 피드백을 반영해 다시 구현 → 재검증 (반복)
- 이 구조 덕분에 개발 중간에 **실제 결함**을 발견해서 상위 단계로 피드백한 사례가 여러 번 있었음 (다음 슬라이드에서 대표 사례 소개)

**첨부**: 개발 루프 다이어그램 (구현 → 검증 → pass? → 다음 단계 / fail → 재구현)

**근거 파일**: `CLAUDE.md` (4절 개발 루프)

---

## 슬라이드 6. 개발 루프가 실제로 잡아낸 버그 사례

**내용**
- 5단계(assembler) 구현 중 검증 과정에서 **1단계(extractor)의 실제 파싱 버그**를 발견
- 문제: `mode_support`가 `V/N.E.`처럼 슬래시로 결합된 SDM 원문 표기에서, 약어 `V`를 정규식이 인식 못해 앞쪽 64비트 모드 값(Valid)이 통째로 사라지는 버그
- 영향: ADCX/MOVBE 등 REX.W 확장 레지스터 폭 변형 131개 mnemonic
- 수정 후 재계산: assembler mismatch(기대와 실제 불일치) **416건 → 248건**으로 감소
- 이 사례를 통해 "검증 없이 파이프라인만 쭉 돌렸으면 131건이 전부 잘못된 결과로 남았을 것"을 강조

**첨부**: `tidy_mode_text('V/N.E.')` 수정 전/후 결과 비교 표 (아래 근거 파일에서 텍스트로 인용)

**근거 파일**: `docs/DEVLOG.md` (2026-07-23 [extractor] Stage 1 버그 수정 항목)

---

## 슬라이드 7. 파이프라인 실행 결과 — 단계별 수치

**내용**: 아래 표를 그대로 슬라이드 표로 옮기기

| 단계 | 산출물 | 건수 |
|---|---|---|
| 1. extractor | SDM 명령어 형식 (`isa_db.csv`) | 4,210건 |
| 2. tokenizer | operand 토큰 (`tokens.csv`) | 9,820건 |
| 3. combiner | 구체 조합 (`combos.csv`) | 7,277건 |
| 4. generator | 어셈블리 테스트 라인 (`out/tests.s`) | 7,276줄 |
| 5. assembler | 성공 / 실패 | 7,162 / 114 |
| 6. roundtrip | 동일(same) / 다름(different) | 5,706 / 1,456 |
| 7. triage | 분류 대상 (에러+mismatch+different 중복제거) | 1,585건 |

**첨부**: 위 표 그대로 (막대그래프로 5→6→7단계 깔때기 형태로 시각화하면 더 좋음)

**근거 파일**: `data/db/isa_db.csv`, `data/db/tokens.csv`, `data/db/combos.csv`, `out/asm_result.csv`, `out/roundtrip.csv`, `out/triage.csv`

---

## 슬라이드 8. Triage 최종 분류 — bug vs false_alarm vs unsure

**내용**
- 1,585건을 30여 개 카테고리로 자동 분류 → 최종 verdict 3가지로 수렴

| verdict | 건수 | 의미 |
|---|---|---|
| false_alarm | 1,552 | alias·표기 차이 등 실제로는 버그 아님 (예: 10진→16진 표기, jc→jb alias) |
| bug | 7 | SDM과 GNU as가 실제로 다르게 동작 (도구 재현 + PDF 대조 완료) |
| unsure | 26 | 도구만으로는 판단 불가, 사람 확인 필요 |

- "LLM이 버그라고 주장하는 게 아니라, as/objdump 실행 결과 + SDM PDF 원문 대조까지 마친 것만 bug로 표시" 원칙 강조

**첨부**: 파이 차트 또는 막대그래프 (1552 vs 7 vs 26, 로그 스케일 주의 — 7건이 하도 작아서 별도 콜아웃 필요)

**근거 파일**: `out/triage_report.md`, `out/triage.csv`

---

## 슬라이드 9. 진짜 버그 후보 7건 — 한눈에 보기

**내용**: 7회 미팅에서 요청받았던 표 형식(분류/instruction/source/objdump/compile 여부/차이 원인/error 여부) 그대로 채움

| Instruction | SDM 근거 | 실행한 asm | compile 결과 | 차이 원인 |
|---|---|---|---|---|
| CALL r/m32 | 64비트 모드 N.E.(인코딩 불가) | `call dword ptr [eax]` | 성공(모순) | as가 addr32+opsize 프리픽스로 조용히 인코딩 |
| JMP r/m32 | 64비트 모드 N.E./N.S. | `jmp dword ptr [eax]` | 성공(모순) | CALL과 동일 |
| LAR r32, r64 | p.651 Valid(r64 소스 명시) | `lar ecx, rcx` | 실패 | as는 r16만 허용 |
| LSL r64, r32 | p.691 Valid(r32 소스 명시) | `lsl rcx, ecx` | 실패 | as는 r16만 허용 |
| MOV Sreg, r/m64 | REX.W+8E/r Valid | `mov ds, qword ptr [eax]` | 실패 | as는 m16만 허용 |
| UDB | p.1436 Valid(D6 opcode) | `udb` | 실패 | as가 니모닉 자체를 모름 |
| VPMOVQD mem | p.2054: xmm1/m128 | `vpmovqd xmmword ptr [eax], xmm0` | 실패 | as는 qword ptr(m64)만 허용 |

**첨부**: 위 표 (7행이라 한 슬라이드에 다 들어감)

**근거 파일**: `out/triage_report.md` (진짜 의심되는 버그 후보 섹션), `tests/manual_bug_check.py`

---

## 슬라이드 10. 버그 상세 예시 — CALL/JMP (가장 인상적인 사례)

**내용**
- SDM은 64비트 모드에서 `CALL r/m32`(FF /2)를 N.E.(인코딩 자체가 불가능)로 명시
- 그런데 GNU as는 `call dword ptr [eax]`를 **경고 없이** 받아서 조용히 어셈블함
- objdump로 실제 바이트 확인: `67 66 ff 18` → `call DWORD PTR [eax]` (addr32 + opsize 프리픽스를 몰래 붙여서 인코딩)
- 즉 매뉴얼상 "존재할 수 없는 인코딩"을 as가 실제로 만들어내는 것 — 매뉴얼 위반

**첨부**: 터미널 스크린샷 — `python3 tests/manual_bug_check.py call_rm32_ne` 실행 결과 (또는 objdump 바이트 덤프 캡처)

**근거 파일**: `out/asm_result.csv` (combo_id=419), `out/triage_report.md`

---

## 슬라이드 11. 버그 상세 예시 — MOV Sreg, r/m64 (신규 발견)

**내용**
- 이번 라운드에서 새로 발견한 사례 (triage 1차 검증에서 verifier가 잡아냄)
- `isa_db.csv`: `REX.W + 8E /r MOV Sreg, r/m64`가 64비트 모드 Valid로 명시
- 그런데 `mov ds, qword ptr [eax]`는 as가 거부, `mov ds, word ptr [eax]`(r/m16)만 받아줌
- 레지스터 폼(`mov ds, rax`)은 문법상 받아주지만 objdump로 확인하면 REX.W 없이 `mov ds, eax`와 동일한 2바이트 인코딩만 나옴 — LAR/LSL과 같은 유형의 "as가 넓은 레지스터 인코딩 경로를 구현 안 한" 패턴

**첨부**: `mov ds, qword ptr [eax]` vs `mov ds, word ptr [eax]` 어셈블 결과 비교 스크린샷

**근거 파일**: `out/asm_result.csv` (combo_id=1683), `out/triage_report.md`

---

## 슬라이드 12. 부수 성과 — 우리 테스트 생성기(combiner) 자체 결함 6개 발견·수정

**내용**
- triage 과정에서 "SDM상 멀쩡한데 실패하는" 케이스 중 일부는 GNU as 문제가 아니라 **우리 자신의 조합 생성 로직(combiner)이 잘못된 대표값을 고른 것**임을 구분해서 확인
- 6가지 모두 수정 완료 (예시 3개만 표로)

| 문제 | 수정 전 | 수정 후 |
|---|---|---|
| far-ptr 뭉개짐 | `call word ptr [eax]` (실패) | `call far ptr [eax]` (성공) |
| moffs 괄호 누락 | `mov 0x1000, al` (실패) | `mov [0x1000], al` (성공) |
| 레지스터 재사용 | `tdpbf16ps tmm0,tmm0,tmm0` (실패) | `tdpbf16ps tmm0,tmm1,tmm2` (성공) |

- 수정 후 combos.csv 165개 값 변경, triage 대상 1,630건 → 1,585건으로 감소(정상 통과되는 만큼 빠짐)
- **이 구분 자체가 연구의 핵심 원칙("차이 ≠ 버그")을 실제로 적용한 사례**임을 강조

**첨부**: 위 표

**근거 파일**: `pipeline/m3_combine.py`, `docs/DEVLOG.md` (2026-07-24 [combiner] 항목), `tests/manual_bug_check.py`

---

## 슬라이드 13. 재현 가능성 — 직접 확인용 도구

**내용**
- "LLM 설명을 믿는 게 아니라 직접 눈으로 확인" 원칙에 따라 `tests/manual_bug_check.py` 작성
- `python3 tests/manual_bug_check.py` 한 번이면 13건(진짜 버그 7 + combiner 수정 6) 전부 실제 `as`로 재실행해서 그 자리에서 성공/실패를 보여줌
- combiner 코드(`MEM_SIZE_RE`, `expand_token`)를 직접 import해서 정규식이 실제로 어떻게 잘못 매치하는지 코드 레벨로도 증명
- 오늘 발표 준비하면서도 다시 실행해서 13/13건 전부 재확인함

**첨부**: 터미널 실행 스크린샷 (요약 부분: "[B] 진짜 버그 후보: 7/7건 여전히 재현됨. [A] combiner 수정: 6/6건 정상 어셈블 확인.")

**근거 파일**: `tests/manual_bug_check.py`

---

## 슬라이드 14. 교수님께 질문/논의 — 미해결 항목

**내용**
1. **VSCATTERDPD ymm/zmm 비대칭 표기**: SDM PDF p.2202에 `VSCATTERDPD`가 `vm32y {k1}, ymm1` / `vm32z {k1}, zmm1`로 명시돼 있는데, 유사 명령어 `VGATHERDPD`(p.1824)는 ymm 데이터에도 `vm32x`를 그대로 씀 — GATHER와 SCATTER 사이에 SDM 표기 자체가 비대칭. GNU as는 SCATTER의 vm32y/vm32z 폼을 거부함. **이게 SDM 오탈자인지, 의도적 설계인지 Intel 공식 정오표(errata) 확인이 필요** — 확인 방법이나 우선순위에 대해 여쭤보고 싶음.
2. **unsure 26건**: `register_width/name_changed`(14건) 등 도구만으로 판단하기 애매한 케이스들 — 어느 정도까지 파고들지, 아니면 이번 보고서 스코프에서 제외할지 방향 문의.
3. (선택) 앞으로 clang/AT&T syntax 비교 등 v2 스코프로 넘어갈 시점에 대한 의견.

**첨부**: 없음 (논의용 슬라이드, 텍스트만)

**근거 파일**: `out/triage.csv` (category=`sdm_gather_scatter_vsib_width_asymmetry`), `out/verify_report.md`

---

## 슬라이드 15. 다음 계획

**내용**
- VSCATTERDPD 건 Intel 공식 정오표(errata) 확인
- unsure 26건 직접 검토 (특히 register_width/name_changed 14건)
- 정식 회귀 테스트 하네스(`tests/test_modules.py`) 아직 부재 — 필요성 재확인 후 작성 여부 결정
- (다음 단계 로드맵) v2 스코프: clang 옵션 비교 → AT&T syntax 변환/비교 → 실행 시 SIGILL 탐색

**첨부**: 없음 (텍스트 bullet)

**근거 파일**: `CLAUDE.md` (6절 스코프), `docs/DEVLOG.md` (마지막 항목 "남은 것")

---

## 부록 — 슬라이드 만들 때 참고할 파일 목록 (링크 모음)

- 프로젝트 지침 전체: `CLAUDE.md`
- 개발 일지 전체: `docs/DEVLOG.md`
- 지난 미팅 피드백: `docs/MEETING_NOTES/7회_미팅_내용.md`
- 최종 버그 리포트: `out/triage_report.md`
- 원본 데이터: `data/db/isa_db.csv`, `data/db/tokens.csv`, `data/db/combos.csv`
- 산출물: `out/asm_result.csv`, `out/roundtrip.csv`, `out/triage.csv`
- 직접 확인용 스크립트: `tests/manual_bug_check.py` (실행: `python3 tests/manual_bug_check.py`)
- 검증 기록: `out/verify_report.md`

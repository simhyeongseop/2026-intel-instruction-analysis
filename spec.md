# codex 작업 지시서 (spec) — 남은 "확정 버그" 3사안 독립 재검증

작성일: 2026-09-03 / 작성: Claude Code (형섭이 codex에 직접 넣어 돌릴 용도)

실행 예:
```bash
codex exec -s workspace-write - < spec.md      # 조사 후 보고 (파일 수정은 6절 규칙 준수)
```

---

## 0. 너에게 요청하는 것 (한 줄)

이 프로젝트가 "GNU as/objdump의 진짜 버그"라고 판정해 둔 **3개 사안**에 대해, 프로젝트 주인(형섭)이 새로 제기한
반론이 타당한지 **독립적으로** 검증하고, 각 사안의 verdict를 어떻게 바꿔야 하는지 근거와 함께 권고해라.
**앞선 판정에 동조할 필요도, 반대할 필요도 없다. 근거만 따라가라.**

## 1. 프로젝트 배경 (판단 기준)

- **목적**: 인텔 매뉴얼(Intel SDM Vol.2)의 **Intel syntax** 명령어 문법을 어셈블러(GNU `as`)와
  디스어셈블러(`objdump`)가 얼마나 정확히 지원하는지 검사한다.
- **찾는 것**: "매뉴얼대로 작성했는데 어셈블러/디스어셈블러가 제대로 처리하지 못하는 경우".
- **정답은 인텔 매뉴얼이다.** 어셈블러가 받아주는지가 아니라, 매뉴얼이 그렇게 정의하는지가 기준.
- **차이 ≠ 버그.** 원본과 역어셈블 결과가 달라도 alias·동등표현·SDM 표기 관례일 수 있다.
- **LLM 판단만으로 "버그"라고 결론짓지 않는다.** 근거는 항상 도구(as/objdump/clang) 실측 결과와
  SDM 원문 인용이어야 한다.
- 파이프라인: SDM PDF → ①extractor(isa_db.csv) → ②tokenizer → ③combiner(combos.csv) →
  ④generator(tests.s) → ⑤as 어셈블 → ⑥objdump 역어셈블·비교 → ⑦triage(유형별 분류·판정).

### 이미 확정된 선례 (판단의 일관성을 위해 반드시 참고)

같은 재검토 라운드에서 아래 3건이 **bug → false_alarm**으로 내려갔다. 논거의 형태를 참고하되,
이번 3사안에 기계적으로 적용하지는 마라.

- **VPMOVQD (combo 6540)**: SDM 오피코드 표가 EVEX.128 행만 `xmm1/m128`로 적었으나, 형제 명령어
  (VPMOVSQD/VPMOVUSQD)는 같은 행이 `xmm1/m64`이고 Description·Operation pseudocode도 64비트 →
  **SDM 표 자체의 오탈자**. as/clang 18/19/20 네 어셈블러 전부 m64만 허용해 일치.
- **LAR (1516) / LSL (1571)**: SDM 표의 비대칭 표기(`LAR r32, r64/m16`)는 **REX.W 하나로 두 GPR
  오퍼랜드의 폭을 독립 지정할 수 없다**는 인코딩 구조상 어느 어셈블러로도 실현 불가능한 폼이다.
  clang도 요청받은 폭을 조용히 한쪽에 맞춰 재해석할 뿐이다 → SDM 표기를 그대로 테스트한 것이
  애초에 무의미했던 케이스(이 프로젝트가 CALL/JMP·DEC/INC·LEAVE·LGDT/LIDT·BNDCL에서 이미 6번 겪은 패턴).

## 2. 과제 A — LSS/LFS/LGS (combo 1527/1532/1535)

- **현재 판정**: `verdict=bug`, category=`objdump_farptr_size_ignores_rexw`
  (`pipeline/m7_triage.py`의 `ROUNDTRIP_COMBO_OVERRIDES`, 447행 부근)
- **판정 근거(기존)**: `lss rcx, m16:64`(REX.W + 0F B2 /r)를 as는 SDM대로 정확히 인코딩(`67 48 0f b2 08`)하는데,
  objdump가 REX.W로 승격된 r64 폼의 메모리 크기를 `FWORD PTR`(6바이트, m16:32용)로 표시한다.
  m16:64는 10바이트라 `TBYTE PTR`이어야 한다. 그 출력 텍스트를 다시 as에 넣으면
  ``incorrect register `rcx' used with `l' suffix``로 거부된다(as 자신은 rcx엔 TBYTE가 맞다고 알고 있다는 방증).
  llvm-objdump는 같은 바이트에 이 오표기를 하지 않는다 → "GNU objdump만의 표시 결함".
- **형섭의 반론**: *"입출력 비트수만 맞추면 되는 거라 버그가 아닌 것 같다."*
  즉 `FWORD PTR`/`TBYTE PTR` 같은 크기 지시자는 **어셈블 시점의 문법적 크기 힌트**일 뿐이고,
  일단 인코딩된 뒤 CPU가 실제로 읽는 바이트 수는 opcode+REX.W가 이미 결정한다. objdump가 텍스트로 어떤
  크기 키워드를 찍든 실행 의미는 달라지지 않으므로 화면 표시 문제일 뿐 진짜 버그가 아니다.

**확인할 것**
1. SDM 원문에서 LSS/LFS/LGS의 Description/Operation을 인용해, m16:64 폼에서 실제 로드되는 바이트 수와
   피연산자 크기 규정을 확정해라.
2. 크기 지시자가 **실행 의미에 영향을 주는가**(= 인코딩 후 CPU 동작을 바꾸는가), 아니면 순수히
   어셈블 시점 힌트 + 디스어셈블 표시 관례인가? 이 구분을 명확히 논증해라.
3. 그럼에도 **디스어셈블러가 자기 출력을 같은 툴체인의 어셈블러에 되먹일 수 없다는 사실**(round-trip 실패)이
   1절의 버그 정의("매뉴얼대로 작성했는데 어셈블러/디스어셈블러가 제대로 처리하지 못하는 경우")에
   해당하는지 판단해라. **양쪽 논거를 모두 검토한 뒤** 결론을 내라.

## 3. 과제 B — MOV Sreg, r/m64 메모리형 (combo 1683)

- **현재 판정**: `verdict=unsure`, category=`gas_register_width_stricter_than_manual`
  (`ERROR_COMBO_OVERRIDES`, 210행 부근)
- **사실관계(기존 실측)**: SDM 표에 `REX.W + 8E /r MOV Sreg, r/m64`가 64비트 모드 Valid로 적혀 있다.
  as는 `mov ds, qword ptr [eax]`를 'operand type mismatch'로 거부하고 `mov ds, word ptr [eax]`만 받는다.
  clang 18.1.3/19.1.1/20.1.2도 똑같이 거부한다(4개 어셈블러 일치). 레지스터 폼 `mov ds, rax`는 as가
  문법상 받지만 REX.W를 버려 `8e d8`(= `mov ds, eax`와 동일)로 인코딩하고, clang은 `48 8e d8`로 REX.W를 유지한다.
- **형섭의 반론**: *"입출력 비트수만 맞추면 되는 거라 버그가 아닌 것 같다."*
  세그먼트 레지스터는 아키텍처상 항상 16비트 셀렉터만 로드하므로 이 인코딩에서 REX.W는 "허용되지만
  의미상 무효(inert)"일 가능성이 크다. 그렇다면 SDM 표의 `r/m64`는 실제 64비트 전송을 뜻하는 게 아니라
  표기 관례일 뿐이고, as가 r/m16 폼만 구현한 건 실제 의미와 어긋나지 않는다 → LAR/LSL과 같은 계열의 오탐.
- **직전 codex 라운드가 남긴 반대 논거(그대로 다시 따져볼 것)**: "clang 3개 버전은 전부 LLVM 계열이라
  독립성이 약하다. SDM 정의상 r/m64는 명시적으로 64비트 메모리를 포함하며, **반대방향 행
  `REX.W + 8C /r MOV r64/m16, Sreg`는 이미 레지스터 폭(r64)과 메모리 폭(m16)을 구분해 표기**했으므로,
  8E 행의 `r/m64`를 단순 축약 오탈자로 보기엔 근거가 약하다."

**확인할 것**
1. SDM의 MOV 항목(Description/Operation, 그리고 8E·8C 행)을 인용해, 세그먼트 레지스터 로드의 피연산자
   크기가 16비트로 고정되는지, REX.W가 무효라고 명시하는지 확정해라.
2. 8C 행이 폭을 구분해 적은 것과 8E 행의 `r/m64` 표기 차이를 어떻게 해석해야 하는지 판단해라
   (의도적 구분인가, 표기 느슨함인가).
3. 메모리 폼(`mov ds, qword ptr [eax]`)이 실제로 존재 가능한 폼인지 — 즉 SDM대로라면 CPU가 메모리에서
   몇 바이트를 읽어야 하는지, 그 폼을 인코딩할 방법이 실제로 있는지 논증해라.

## 4. 과제 C — UDB (combo 4597)

- **현재 판정**: `verdict=bug`, category=`gas_missing_mnemonic` (`ERROR_COMBO_OVERRIDES`, 167행 부근)
- **판정 근거(기존)**: "SDM p.1436에 'D6 UDB' 오피코드가 64비트 모드 Valid로 명시돼 있으나(UD0/UD1/UD2와
  같은 계열) GNU as는 'udb'라는 니모닉 자체를 모른다(`no such instruction: udb`)."
  직전 codex 라운드도 "SDM Exceptions 섹션에 'UDB does so only in 64-bit mode'로 UDB를 직접 언급 —
  오탈자 아님"이라며 CONFIRMED로 유지했다.
- **형섭의 반론**: *"UDB는 그냥 정의되지 않은 명령어 전체를 뜻하는 거라, 인식 못하는 게 문제가 되지 않는다."*
  즉 UDB가 UD0/UD1/UD2처럼 고유 오피코드를 갖고 실제로 어셈블해 쓰라고 만든 구체적 명령어가 아니라,
  "이 오피코드 자리는 영구히 정의되지 않음"을 나타내는 문서상 라벨일 수 있다. 그렇다면 as에 `udb`
  니모닉이 없는 건 당연하고, 현재 판정은 SDM 오독(또는 extractor 추출 오류)에 기반한 오탐이 된다.

**확인할 것 (이 과제의 핵심)**
1. PDF 원문에서 **UDB가 등장하는 모든 위치**를 앞뒤 문맥까지 그대로 인용해라. 판별 기준:
   - (a) UD0/UD1/UD2와 나란히 **정식 명령어 참조 항목**으로 실려 있는가?
     (자체 Opcode/Instruction/64-bit Mode/Compat Mode/Description/Operation/Exceptions 구조를 갖춘 표 행)
   - (b) 아니면 설명 문단·각주·부록 오피코드 맵 안에서 **라벨/약어**로만 등장하는가?
2. **"UDB does so only in 64-bit mode" 문장의 실제 전후 문맥을 반드시 확인해라.** 이 문장이 UDB를 하나의
   명령어로 취급하는 문장인지, 다른 뜻인지가 갈림길이다. (직전 라운드의 CONFIRMED 근거가 바로 이 문장이다.)
3. `data/db/isa_db.csv`의 UDB 행이 정상적인 명령어 행처럼 생겼는지, 설명문이 표 행으로 잘못 파싱된
   흔적이 있는지 확인해라. 비교 기준: 이 프로젝트가 이미 잡아낸 추출 아티팩트 사례
   (`out/triage.csv`의 VREDUCESD combo 6953/6961, category `extractor_artifact_stray_text`).
4. as/clang이 `udb`와 비교군 `ud0`/`ud1`/`ud2`를 각각 어떻게 처리하는지, 그리고 `.byte 0xd6`를 objdump로
   역어셈블하면 어떤 이름으로 표시되는지(이름이 붙는지 `(bad)`인지) 확인해라.

## 5. 환경 (중요 — Windows + WSL 혼합)

- **SDM PDF**: 저장소 루트의 `intel_manual.pdf`.
  **인쇄된 페이지 번호(p.651, p.1436 등)와 PDF 페이지 인덱스는 다르다.** 인덱스를 추측하지 말고
  텍스트 검색으로 찾아라.
- **pdfplumber**: WSL에 venv가 준비돼 있다 →
  `wsl -d Ubuntu -- bash -lc "~/pdftools_venv/bin/python /mnt/c/.../script.py"`
- **as / objdump / clang**: **WSL(Ubuntu)에만 있다**(Windows에는 없음) →
  `wsl -d Ubuntu -- bash -lc "..."`, 프로젝트 경로는 WSL에서 `/mnt/c/Users/wltjq/OneDrive/assembler-testing`.
  시스템 버전은 as 2.42 / clang 18.1.3. (8월에 쓰던 clang 19/20·binutils 2.47 스크래치 빌드는 **현재 남아있지 않다.**
  필요하면 `apt-get download` + `dpkg-deb -x` + `LD_LIBRARY_PATH`로 재구축해라 — sudo 비밀번호가 없어 apt install은 불가.)
- 쉘 인용부호가 잘 꼬이니, 어셈블리 테스트나 PDF 추출은 **스크립트 파일로 써서 실행**하는 편이 안전하다.
- **판정 근거 원문**: `pipeline/m7_triage.py`의 `ERROR_COMBO_OVERRIDES`(152행~) /
  `ROUNDTRIP_COMBO_OVERRIDES`(446행~) — combo마다 왜 그렇게 판정했는지 긴 한국어 사유가 그대로 들어있다.
- **이전 라운드 증거 파일**: `docs/DEVLOG.md`(2026-08-25, 2026-09-03 항목), `out/clang_compare_evidence_raw.md`,
  `out/reassemble_check_evidence.md`, `out/edge_case_execution_evidence.md`, `docs/HANDOFF.md`.

## 6. 지켜야 할 것

- **저장소 파일을 고치지 마라.** 조사와 보고만 한다. (임시 스크립트는 `/tmp`나 스크래치에 써라.)
  verdict를 바꿔야 한다고 판단하면 **어디를 어떻게 고칠지 제안만** 하고, 실제 반영은 형섭이 결정한다.
  — 과거에 병렬 에이전트가 "수정 금지" 지시를 어기고 `out/triage.csv`를 직접 고쳐서 사고가 난 적이 있다.
- **세 과제는 서로 독립이다.** 한 과제의 결론을 다른 과제에 기계적으로 전이하지 마라(특히 A와 B는
  "비트수만 맞으면 된다"는 같은 형태의 반론이지만 사안의 성격이 다르다).
- 확신이 없으면 `unsure`로 남기고 **무엇을 더 확인해야 확정 가능한지** 적어라. 억지로 결론내지 마라.
- 근거 없는 단정 금지. 모든 주장에 **SDM 인용(페이지·문장) 또는 도구 실측 결과(명령어와 출력)**를 붙여라.

## 7. 보고 형식

과제 A/B/C 각각에 대해:

1. **결론**: `bug 유지` / `unsure로 하향` / `false_alarm으로 하향` / `bug로 복원` 중 하나 + 확신도(상/중/하)
2. **근거**:
   - SDM 원문 인용 (인쇄 페이지 번호 + 해당 문장 그대로)
   - 도구 실측 (실행한 명령어와 그 출력 — 바이트 인코딩 포함)
3. **형섭의 반론에 대한 판단**: 어느 지점이 맞고 어느 지점이 틀렸는지 명시적으로
4. **반대 논거 검토**: 네 결론에 반대되는 가장 강한 논거는 무엇이며, 왜 그것을 기각/수용했는지
5. **남은 불확실성**: 무엇을 더 확인해야 확정되는가
6. verdict를 바꾸라고 권고하는 경우: `pipeline/m7_triage.py`의 해당 override에 넣을
   **category / verdict / 사유 문구 초안**(한국어, 기존 항목들과 같은 톤 — 정정 날짜·근거·교차검증 출처 포함)

마지막에 **전체 요약 표**(과제 | 기존 verdict | 권고 verdict | 한 줄 근거)를 붙여라.

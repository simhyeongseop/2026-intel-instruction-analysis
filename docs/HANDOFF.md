# 인계 문서 (HANDOFF) — 2026-09-03 기준

이 파일은 **작업이 중단됐을 때 다음 사람(또는 codex)이 그대로 이어받기 위한 문서**다.
새 라운드를 시작하면 이 파일을 갱신해서 항상 "지금 상태"만 담고 있게 유지한다.

---

## 1. 지금 무엇을 하던 중인가

**9회 보고서의 "확정 버그" 판정을 계속 좁혀나가는 중이다.**

- 8월 세션: 확정 버그 8건 → codex + 최신 clang(19.1.1/20.1.2) 교차검증으로 **4건**으로 하향
  (VPMOVQD/LAR/LSL → false_alarm, MOV Sreg 메모리형 → unsure). 이 작업은 **완료·검증 통과**했으나
  아직 **커밋 안 됨**(아래 2절).
- 9월 3일(현재): 형섭이 남은 4건에도 이의를 제기해서 **3개 사안을 재검증 중**(아래 3절).

## 2. 커밋 안 된 변경 (working tree, 브랜치 main)

`git status --short` 기준 6개 파일. 전부 "bug 8→4 하향" 작업의 결과물이고 서로 일치한다.

| 파일 | 변경 내용 |
|---|---|
| `pipeline/m7_triage.py` | `ERROR_COMBO_OVERRIDES`에서 combo 6540(VPMOVQD)/1516(LAR)/1571(LSL)을 bug→false_alarm, 1683(MOV Sreg)을 bug→unsure. `ROUNDTRIP_COMBO_OVERRIDES`의 1527(LSS) 사유 문구 정밀화 |
| `out/triage.csv`, `out/triage_report.md` | 위 스크립트 재실행 결과 (verdict: bug=4, false_alarm=1557, unsure=24) |
| `docs/DEVLOG.md` | 2026-09-03 항목 — 재검토 경위·근거·fork 충돌 사고 교훈 기록 |
| `docs/MEETING_NOTES/9회_미팅_보고서.md` | 5절 "확정 버그 8건" 표에 정정 경고 + "재검토 후 4건" 표 추가 |
| `tests/manual_bug_check.py` | PoC 재현 대상에서 LAR/LSL/MOV/VPMOVQD 제거, `DOWNGRADED_CASES`로 이동 |

**검증 상태: PASS**(2026-09-03, `@agent-verifier`). 확인된 것 — 문법 정상, `python3 pipeline/m7_triage.py`
재실행 결과가 워킹트리와 바이트 동일(결정적), combo별 verdict 정확, `tests/manual_bug_check.py` 정상 실행,
다른 파이프라인 산출물 회귀 없음.

**→ 커밋해도 되는 상태다.** (형섭이 3절 재검증 결과를 보고 함께 커밋할지, 먼저 커밋할지 정하면 됨)

## 3. 진행 중인 재검증 — 형섭의 이의 3건

형섭 발언(2026-09-03): *"lss/lfs/lgs, mov sreg는 입출력 비트수만 맞추면 되는 거라 버그가 아닌 것 같고,
udb는 그냥 정의되지 않은 명령어 전체를 뜻하는 거라 인식 못하는 게 문제가 되지 않는 것 같다."*

| # | 대상 combo | 현재 verdict | 형섭의 반론 | 확인해야 할 핵심 질문 |
|---|---|---|---|---|
| A | 1527/1532/1535 (LSS/LFS/LGS) | `bug` (objdump 표시 결함) | 크기 지시자(FWORD/TBYTE)는 어셈블 시점 문법 힌트일 뿐, 인코딩된 뒤 CPU가 읽는 바이트 수는 opcode+REX.W가 결정 → 표시만의 문제, 진짜 버그 아님 | 실행 의미가 안 바뀌면 오탐인가? 아니면 objdump 출력을 같은 툴체인의 as에 되먹일 수 없는 것(round-trip 실패)이 그 자체로 도구 결함인가? |
| B | 1683 (MOV Sreg, r/m64 메모리형) | `unsure` | 세그먼트 레지스터는 항상 16비트 셀렉터만 로드 → REX.W는 허용되지만 의미상 무효. SDM 표의 `r/m64`는 실제 64비트 전송을 뜻하지 않음 → LAR/LSL과 같은 계열의 오탐 | SDM이 Sreg 로드의 폭 고정/REX.W 무효를 명시하는가? 반대방향 행 `REX.W + 8C /r MOV r64/m16, Sreg`는 폭을 구분해 적는데 8E 행만 뭉뚱그린 표기인가? |
| C | 4597 (UDB) | `bug` (as에 니모닉 없음) | UDB는 UD0/UD1/UD2 같은 구체 명령어가 아니라 "정의되지 않은 명령어"를 가리키는 문서상 라벨 → as가 몰라도 정상 | UDB가 SDM에 **정식 명령어 참조 항목**(자체 Opcode/Description/Operation/Exceptions 구조)으로 실려 있는가, 아니면 설명문·각주·오피코드 맵의 라벨로만 등장하는가? "UDB does so only in 64-bit mode" 문장의 실제 전후 문맥이 갈림길 |

**진행 방식**: 세 사안을 각각 독립 fork에 맡겨 (1) SDM PDF 원문 직접 인용, (2) as/objdump/clang 바이트 레벨
재현, (3) codex 교차검증(전문가 독립 판단, 유도 금지) 순으로 조사시키고, **최종 판정은 오케스트레이터(또는 형섭)가
원시 데이터를 직접 재현해서 확정한다.** 각 fork는 저장소 파일 수정 금지(조사·보고만) — 8월에 fork가 지시를 어기고
triage.csv를 직접 고친 사고가 있었으므로 fork 종료 후 반드시 `git diff`로 실제 변경 범위를 확인할 것.

**아직 결론 안 남.** 결과가 나오면 이 표의 "현재 verdict"와 `pipeline/m7_triage.py`의 override를 갱신하고,
`python3 pipeline/m7_triage.py` 재실행 → `@agent-verifier` → DEVLOG 기록 → 커밋 순서로 진행한다.

## 4. codex가 이어받는 법

codex CLI는 **Windows 쪽**에 설치돼 있다(WSL에는 없음). 긴 프롬프트는 인용부호 문제를 피해 stdin으로 넣는다:

```bash
"/c/Users/wltjq/AppData/Local/Programs/OpenAI/Codex/bin/codex" exec -s read-only - < prompt.txt
```

조사에 필요한 것들:

- **SDM PDF 원문**: `intel_manual.pdf` (저장소 루트). 인쇄 페이지 번호(p.651, p.1436 등)와 PDF 인덱스는
  다르므로 **텍스트 검색으로 찾을 것**.
- **pdfplumber**: WSL에 venv 준비돼 있음 → `wsl -d Ubuntu -- bash -lc "~/pdftools_venv/bin/python <script.py>"`
- **as / objdump / clang**: WSL(Ubuntu)에만 있다 → `wsl -d Ubuntu -- bash -lc "..."`,
  프로젝트 경로는 WSL에서 `/mnt/c/Users/wltjq/OneDrive/assembler-testing`
- **판정 근거 원문**: `pipeline/m7_triage.py`의 `ERROR_COMBO_OVERRIDES` / `ROUNDTRIP_COMBO_OVERRIDES`
  (각 combo마다 왜 그렇게 판정했는지 긴 한국어 사유가 그대로 들어있다)
- **이전 라운드 근거 파일**: `out/clang_compare_evidence_raw.md`, `out/reassemble_check_evidence.md`,
  `out/edge_case_execution_evidence.md`, `docs/DEVLOG.md`

## 5. 환경 메모 (재구축이 필요할 때)

- WSL이 `Wsl/Service/0x8007274c`로 끊기면 → `wsl --shutdown` 후 재시작하면 복구됨(재부팅이 근본 해결).
- WSL에 sudo 비밀번호가 없어 `apt install` 불가. 8월 세션에서는 `apt-get download` + `dpkg-deb -x`로
  clang-19/20을 시스템 설치 없이 스크래치에 풀어서 썼다(`LD_LIBRARY_PATH`만 맞춰주면 동작).
  **주의: 그 스크래치 디렉터리는 현재 남아있지 않다** — 최신 clang 교차검증이 다시 필요하면 재구축해야 한다.
  시스템 clang은 18.1.3 고정.
- binutils 2.47도 8월에 root 없이 소스 빌드해 썼으나 역시 남아있지 않음. 시스템 as는 2.42.

## 6. 다음 라운드 후보 (아직 착수 안 함)

- **LAR/LSL 대칭 REX.W 폼 정식 판정**: `as`는 `lar rcx,rcx` / `lsl rcx,rcx`(양쪽 다 r64) 대칭 폼에서도
  REX.W를 전혀 만들지 않는다(AT&T `larq`/`lslq`로도). clang은 정확히 만든다 → **as만의 진짜 한계일 가능성**.
  현재 `combos.csv`에 이 대칭 폼 combo가 없어서 미판정 상태다. combiner/generator에 케이스를 추가해서
  정식 combo로 확정할 것.
- 8회 후속 과제 5번(커버리지 수치 + GitHub 정리)은 9회 보고서와 함께 완료됨.

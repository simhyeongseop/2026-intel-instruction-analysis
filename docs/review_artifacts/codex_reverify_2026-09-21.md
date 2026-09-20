# 독립 재검증 요청 — Intel SDM 기반 어셈블러 대조 파이프라인

대상 저장소: 이 문서가 들어 있는 저장소
검토 기준일: 2026-09-21
요청자 주: **이 문서는 어느 항목이 더 중요한지 순위를 매기지 않는다.** 항목은 파이프라인 단계 순서와
사례 수 순서로만 나열했다. 중요도 판단은 검토자가 한다.

---

# 0. 검토자에게

당신은 **시스템 보안 연구자(박사·교수 수준)** 로서 이 연구를 심사한다.
학생이 낸 결과를 그대로 받아들이지 말고, 아래 세 가지를 독립적으로 판정한다.

1. **판정 재검토** — 보고된 예외 사항 각각이 정말 그 판정인지, 최신 도구로 다시 확인하고
   **원인까지 규명**한다.
2. **설계 검토** — 파이프라인 구현이 도구가 표방한 의도대로 되어 있는지 확인한다.
3. **방법론 검토** — 이 실험 설계가 주장하려는 결론을 뒷받침할 수 있는지 판단한다.

## 요구 사항

- **각 항목에 결론을 내린다.** "확인 필요", "가능성 있음" 같은 유보는 최소화한다.
  유보가 불가피하면 **무엇을 관측하면 결론이 나는지** 구체적으로 적는다.
- **관측과 판정을 분리해 적는다.** 바이트가 다르다(관측)와 결함이다(판정)는 다르다.
- **원인을 규명한다.** "거부됨"에서 멈추지 말고 왜 그런지(도구 구현, 매뉴얼 표기, ISA 제약,
  입력 생성 오류, 버전 차이 중 무엇인지) 밝힌다.
- **근거를 남긴다.** 실행한 명령, 도구 버전, 관측 원문.
- 이 연구는 버그 수를 7→5→8→4→3으로 반복 정정한 이력이 있다. **과잉 주장과 과소 주장 양쪽을
  모두 지적한다.**

---

# 1. 검토 환경

## 1.1 현재 저장소가 사용한 환경

- Ubuntu 24.04 (WSL2), Python 3.12.3
- GNU binutils **2.42** (`as --64 -mintel64`, `objdump -d -M intel`)
- Clang **18.1.3** (`clang -c -x assembler`)
- 모든 as 호출에 `-mintel64`가 붙는다. 이 옵션 유무로 결과가 달라지는 사례가 보고돼 있다.

## 1.2 최신 도구 확보 (둘 중 하나 또는 둘 다)

### (A) 로컬 빌드·설치

```bash
# binutils 최신 릴리스 (2026-09 기준 2.47). 버전당 약 2분
curl -O https://ftp.gnu.org/gnu/binutils/binutils-2.47.tar.xz
tar xf binutils-2.47.tar.xz && mkdir build-2.47 && cd build-2.47
../binutils-2.47/configure --disable-gdb --disable-sim --disable-gprofng \
    --disable-nls --disable-werror --disable-ld --target=x86_64-linux-gnu
make -j"$(nproc)" all-gas all-binutils
# 사용: ./gas/as-new --64 -mintel64 ... , ./binutils/objdump -d -M intel ...

# clang: Ubuntu 24.04 저장소에 clang-20(20.1.2)까지 있다
sudo apt-get install -y clang-20
# 더 최신은 apt.llvm.org 사용 (접근 가능함을 확인했다)
```

`ftp.gnu.org/gnu/binutils/`에는 2.45 / 2.46.0 / 2.46.1 / 2.47이 있다.
LLVM 최신 릴리스 태그는 `llvmorg-23.1.1`(2026-09-08)이다.

### (B) Godbolt(Compiler Explorer) API

`docs/review_artifacts/godbolt_api_2026-09-21.py`에 호출 예가 있다.

```bash
curl -s 'https://godbolt.org/api/compilers/assembly?fields=id,name,semver,version'
# POST https://godbolt.org/api/compiler/<id>/compile
#   body: {"source": "...", "options": {"userArguments": "-mintel64",
#          "filters": {"intel": true, "directives": true, "labels": true}},
#          "lang": "assembly"}
```

사용 가능한 x86-64 어셈블러: `gnuas142`(2.42), `gnuas151`, `gnuassnapshot`,
`llvmas2310`(clang 23.1.0), `llvmas_trunk`(LLVM 24.0.0git) 등.

**확인된 주의점 2가지:**
1. `gnuas151`의 라벨은 "binutils 2.45"이고 `gnuassnapshot`은 "(trunk)"인데,
   `api/compilers`의 `version` 필드는 **둘 다 2.44**로 보고한다. 라벨을 신뢰하지 말 것.
2. Godbolt의 assembly 뷰는 어떤 어셈블러를 쓰든 출력을 objdump 형식으로 렌더링한다.
   따라서 **"조립되는가"는 확인되지만 "어느 디스어셈블러가 무엇을 출력하는가"는 확인되지 않는다.**
   디스어셈블러 표시를 검증하려면 로컬 objdump / llvm-objdump를 직접 써야 한다.

## 1.3 저장소 진입점

```bash
python3 -m unittest discover -s tests -p 'test_*.py'     # 회귀 69개
python3 scripts/check_report_numbers.py --json           # 산출물에서 모든 수치 재계산
python3 scripts/asm_linter.py "add ecx, ecx"             # 단일 입력 검사 CLI
python3 pipeline/run.py --list                           # 단계 목록
```

| 파일 | 내용 |
|---|---|
| `data/db/isa_db.csv` | SDM 추출 결과 4,210행 |
| `data/db/tokens.csv` / `combos.csv` | 오퍼랜드 전개 9,820행 / 조합 23,323행 |
| `out/tests.s` | 생성된 어셈블리 입력 |
| `out/asm_result.csv` | 5단계 as 수용/거부 |
| `out/roundtrip.csv` | 6단계 역어셈블 대조 |
| `out/triage.csv` | 7단계 판정 |
| `out/clang_result.csv` / `clang_compare.csv` | 8·9단계 |
| `out/reassemble_check.csv` | 10단계 바이트 왕복 |
| `out/lint/observations.jsonl` / `manifest.json` | 13단계 전량 검사 |
| `docs/MEETING_NOTES/11회_발표자료.md` | 이번 라운드 결론 문서 |
| `docs/RESULT_VALIDITY_AND_BUG_CRITERIA.md` | 저장소가 쓰는 버그 판정 기준 |
| `docs/review_artifacts/verify_cases_2026-09-21.json` | 도구 9종 관측 원본 |

---

# 2. 예외 사항 전면 재검토

아래는 파이프라인이 낸 **뜻대로 되지 않은 결과 전부**다. 각 항목에 대해
**(1) 재현 여부 (2) 원인 (3) 판정 (4) 우리 판정과의 차이**를 답한다.

현재 전체 분포:

| 구분 | 건수 |
|---|---:|
| 생성 입력 | 23,323 |
| as 수용 / 거부 | 23,219 / 104 |
| clang 수용 / 거부 | 23,157 / 166 |
| 역어셈블 결과가 원본과 같음 / 다름 | 13,228 / 9,991 |
| as·clang 바이트 같음 / 다름 / as만 수용 / clang만 수용 / 둘 다 거부 | 23,020 / 125 / 74 / 12 / 92 |
| 재조립 바이트 동일 / 다름 / 실패 / 라벨 artifact | 9,834 / 7 / 51 / 99 |
| triage: bug / false_alarm / unsure | 3 / 10,066 / 47 |
| 지정한 SDM 행을 시험하지 못함 | 349 |

## 2.1 as가 거부한 104건

### (a) 매뉴얼도 무효로 규정한 87건

`mode_support`가 Invalid 44 / N.E. 38 / N.S. 5. 니모닉 상위: push 9, pop 8, call 7, jmp 7,
arpl 6, bound 6, lds 6, les 6.
저장소 판정: 정상 동작(거부가 기대와 일치).

**검토:** 이 87건에 정상 동작이 아닌 것이 섞여 있는지 확인한다.

### (b) 매뉴얼이 Valid라는데 거부된 17건 — 전부 나열

| # | 입력 | as 2.42 오류 | 저장소 판정 |
|---|---|---|---|
| 1 | `vpmovqd xmmword ptr [eax], xmm0` | operand size mismatch | 매뉴얼 표기 오류 |
| 2 | `vpmovqd xmmword ptr [rax+rbx*4+0x10], xmm0` | 〃 | 〃 |
| 3 | `vpmovqd xmmword ptr [rip+0x10], xmm0` | 〃 | 〃 |
| 4 | `vpmovqd xmmword ptr [eax] {k1}, xmm0` | 〃 | 〃 |
| 5 | `vpmovqd xmmword ptr [eax], xmm1` | 〃 | 〃 |
| 6 | `sysexit` | ambiguous operand size | 매뉴얼 표기의 한계 |
| 7 | `sysexit` (변형) | 〃 | 〃 |
| 8 | `sysret` | 〃 | 〃 |
| 9 | `sysret` (변형) | 〃 | 〃 |
| 10 | `mov ds, qword ptr [eax]` | operand type mismatch | 재심 완료, 구현 버그 아님 |
| 11 | `mov ds, qword ptr [rax+rbx*4+0x10]` | 〃 | 〃 |
| 12 | `mov ds, qword ptr [rip+0x10]` | 〃 | 〃 |
| 13 | `lar ecx, rcx` | register type mismatch | 재심 완료, 구현 버그 아님 |
| 14 | `lsl rcx, ecx` | 〃 | 〃 |
| 15 | `vscatterdpd [eax + ymm1] {k1}, ymm0` | invalid VSIB address | 매뉴얼 표기 오류 |
| 16 | `vscatterdpd [eax + zmm1] {k1}, zmm0` | 〃 | 〃 |
| 17 | `udb` | no such instruction | 버전 지원 차이 |

관련 SDM 행(추출 결과):

```
EVEX.128.F3.0F38.W0 35 /r   VPMOVQD xmm1/m128 {k1}{z}, xmm2      (p.2054)
EVEX.256.F3.0F38.W0 35 /r   VPMOVQD xmm1/m128 {k1}{z}, ymm2
EVEX.512.F3.0F38.W0 35 /r   VPMOVQD ymm1/m256 {k1}{z}, zmm2
EVEX.256.66.0F38.W1 A2 /vsib  VSCATTERDPD vm32y {k1}, ymm1       (p.2202)
EVEX.256.66.0F38.W1 A0 /vsib  VPSCATTERDQ vm32x {k1}, ymm1       (p.2080)
0F 35 / REX.W + 0F 35       SYSEXIT                              (동일 니모닉 두 행)
0F 02 /r                    LAR r16, r16/m16                     (p.651)
0F 02 /r                    LAR r32, r32/m16¹
REX.W + 0F 02/r             LAR r32, r64/m16
0F 03 /r                    LSL r16, r16/m16                     (p.691)
0F 03 /r                    LSL r32, r32/m16¹
REX.W + 0F 03 /r            LSL r64, r32/m16¹
  각주 1: Regardless of operand size, only bits 15:0 of a register source operand are used.
REX.W + 8E /r               MOV Sreg, r/m64                      (MOV Sreg 행)
D6                          UDB                                  (p.1436)
```

**검토:** 17건 각각에 대해 최신 as/clang으로 재현하고, 원인이 다음 중 무엇인지 판정한다 —
매뉴얼 표기 오류 / 매뉴얼 표기의 한계 / 도구 구현 결함 / ISA 제약 / 입력 생성 오류 / 버전 차이.
**저장소가 "매뉴얼 오류"로 판정한 7건(1~5, 15~16)은 SDM 개정 이력·정오표를 확인해 판정한다.**

## 2.2 역어셈블 결과가 원본과 다른 9,991건

유형별 분포(7단계 분류기 기준):

| 건수 | 분류 | 예 |
|---:|---|---|
| 7,736 | numeric_repr | `adc al, 1` → `adc al,0x1` |
| 860 | broadcast_display | `qword ptr [eax]{1to2}` → `QWORD BCST [eax]` |
| 729 | mnemonic_alias | `cmovc` → `cmovb` |
| 210 | implicit_operand_display | `cmps byte ptr [eax], …` → `cmps BYTE PTR ds:[esi],BYTE PTR es:[edi]` |
| 118 | size_directive_inferred/omitted | `call far ptr [eax]` → `call FWORD PTR [eax]` |
| 86 | encoding_form_annotation | `vpslldq …` → `{evex} vpslldq …` |
| 71 | fpu_stack_register_display | `fadd st(0), st(0)` → `fadd st,st(0)` |
| 42 | relative_target_absolute_display | `call .Ltarget` → `call 0x0` |
| 35 | operand_count/order_changed | `blendvpd xmm0, xmm0` → `blendvpd xmm0,xmm0,xmm0` |
| 나머지 | 그 외 분류 | `out/triage.csv` 참조 |

저장소 판정: 표기 차이이며 결함이 아니다. 근거는 10단계 재조립에서 9,834건이 바이트까지 동일.

**검토:** (1) 분류 기준이 타당한가 (2) 표기 차이로 분류된 것 중 실제로는 정보 손실이 있는 것이
있는가 (3) 재조립 바이트 동일이 "표기 차이"의 충분한 근거인가.

## 2.3 as와 clang이 갈린 211건

| 구분 | 건수 | 예 | 관측 |
|---|---:|---|---|
| 둘 다 수용, 바이트 다름 | 125 | `call dword ptr [eax]` | as `67 66 ff 18` / clang `67 ff 18` |
| 〃 | | `iret` | as `cf` / clang `66 cf` |
| as만 수용 | 74 | `bndcl bnd0, dword ptr [rax]` | clang: invalid instruction mnemonic |
| clang만 수용 | 12 | `call word ptr [eax]` | as: operand type mismatch |
| 둘 다 거부 | 92 | — | 대부분 매뉴얼이 64비트 무효로 규정 |

as만 수용 74건의 니모닉 상위: bndmov 11, movsxd 10, ud0 5, lkgs 4, bndcl 3.
clang만 수용 12건: call 3, jmp 3, sysexit 2, sysret 2, lar 1.

**검토:** 각 범주의 원인을 규명한다. 특히 125건의 프리픽스 차이가 어느 쪽 기준에서 옳은지,
ISA 명세상 판정 가능한지.

## 2.4 지정한 SDM 행을 시험하지 못한 349건

저장소의 원인 분류(`scripts/check_report_numbers.py`의 `count_encoding_causes()`):

| 건수 | 분류 | 예 |
|---:|---|---|
| 264 | 같은 문법에 SDM 행이 둘 | `adc cl, cl` — 지정 `12 /r`, 실제 `10 c9` |
| 64 | 분기 변위 축약 | `ja .Ltarget` — 지정 `0F 87 cd`, 실제 `77 fe` |
| 21 | REX.W 미부착 | `lar ecx, word ptr [eax]` — 지정 `REX.W + 0F 02 /r`, 실제 `67 0f 02 08` |

21건의 니모닉: mov 7, lar 4, lsl 4, smsw 3, call 1, jmp 1, xlatb 1.
저장소 판정: 264건은 Intel 문법으로 구분 불가(구조적 한계), 85건은 입력을 고치면 시험 가능.

**검토:** (1) 분류 코드가 정확한가 (2) 264건이 정말 구분 불가능한가 —
Intel 문법·GAS 확장·`.byte` 외의 수단으로 특정 행을 강제할 방법이 없는지 확인한다
(3) 이 지표("지정 행 미타격")가 커버리지 측정으로 타당한가.

## 2.5 판정을 내리지 못한 47건

| 건수 | 분류 |
|---:|---|
| 22 | register_width/name_changed |
| 16 | mismatch_assembler_more_permissive |
| 4 | gas_ambiguous_bare_mnemonic |
| 2 | compile_error_unclassified |
| 2 | sdm_gather_scatter_vsib_width_asymmetry |
| 1 | udb_support |

**검토:** 47건 전부에 결론을 낸다. 저장소는 이 중 MPX 계열을 "버전 차이"로,
register_width 계열을 "LSS/LAR 사안과 동일"로 보았으나 `out/triage.csv`에는 반영하지 않았다.

## 2.6 확정 결함으로 분류된 3건과 관련 관측

### (a) LSS/LFS/LGS — `verdict=bug`, `category=far_pointer_display`

```
SDM p.658    REX.W + 0F B2 /r   LSS r64, m16:64   (Valid)
as 입력      lss rcx, tbyte ptr [rax]   → 48 0f b2 08   수용
objdump      48 0f b2 08 → lss rcx,FWORD PTR [rax]
그 출력을 as → 거부  Error: incorrect register `rcx' used with `l' suffix
그 출력을 clang → 수용, 48 0f b2 08 (동일)
llvm-objdump 18 → lss rcx, [rax] (크기 표기 없음)
```
저장소 관측: objdump 2.42·2.45·2.46.1·2.47 모두 동일. LFS(`0F B4`)·LGS(`0F B5`)도 같다.

### (b) LAR/LSL REX.W — `verdict` 미부여(관측만)

```
lar rcx, rcx   → as: 0f 02 c9 (REX.W 없음, 경고 없음) / clang: 48 0f 02 c9
lsl rcx, rcx   → as: 0f 03 c9                        / clang: 48 0f 03 c9
AT&T lar %rcx,%rcx, larq %rcx,%rcx → 모두 0f 02 c9
바이트 48 0f 02 c9 → objdump "lar rcx,rcx" → as → 0f 02 c9  (바이트 불일치, 오류 없음)
```
저장소 관측: 2.42·2.45·2.46.1·2.47 모두 동일.
저장소 판정: **보류.** 두 인코딩의 실행 의미 차이를 확인하지 않아 버그 수를 3에서 올리지 않았다.

### (c) 관련 관측 — SYSEXIT/SYSRET 이식성

```
sysexit   as: 거부(ambiguous)   clang: 수용 0f 35
sysexitd  as: 수용 0f 35        clang: 거부
sysexitq  as: 수용 48 0f 35     clang: 수용 48 0f 35
```

### (d) 관련 관측 — clang의 오퍼랜드 치환

```
lar ecx, rcx  → clang 18: lar ecx,ecx (0f 02 c9) / clang 23.1: lar ecx,cx / clang 24: lar ecx,ecx
lsl rcx, ecx  → clang 18: lsl rcx,rcx (48 0f 03 c9)
```
as는 위 두 입력을 거부한다.

**검토:** (a)~(d)를 최신 도구로 재현하고 각각 판정한다.
`docs/RESULT_VALIDITY_AND_BUG_CRITERIA.md`의 기준을 적용했을 때 (b)가 버그인지,
(a)를 "objdump 표시 결함"으로 부르는 것과 "objdump와 as의 불일치"로 부르는 것 중 무엇이 정확한지,
(d)가 clang의 결함인지 판정한다.

관련 회귀 테스트: `python3 -m unittest tests.test_manual_notation_cases -v`

---

# 3. 파이프라인 설계 검토

도구가 표방한 의도는 `CLAUDE.md`, `docs/PIPELINE.md`, `docs/TOOL_GUIDE.md`에 있다.
**구현이 그 의도대로 되어 있는지** 단계별로 확인한다.

| 단계 | 모듈 | 표방한 역할 | 확인할 것 |
|---|---|---|---|
| 1 | `m1_extract.py` | SDM PDF에서 인코딩 표 추출 | 각주 제거·헤더 분류가 원문을 왜곡하지 않는가. `LAR r32, r64/m161`처럼 각주 번호가 남은 행이 있다 |
| 2 | `m2_tokenize.py` | 오퍼랜드 단위 전개 | 전개 규칙이 SDM 표기를 보존하는가 |
| 3 | `m3_combine.py` | 오퍼랜드 타입을 구체값으로 | 대표값 선택이 인코딩 선택을 왜곡하지 않는가. `combo_id` 안정성 |
| 4 | `m4_generate.py` | Intel 문법 소스 생성 | 생성 문자열이 의도한 행을 표현하는가 |
| 5 | `m5_assemble.py` | as로 한 줄씩 조립 | 크래시·타임아웃이 일반 거부와 분리되는가 |
| 6 | `m6_roundtrip.py` | objdump 대조 | 정규화 규칙이 실제 차이를 감추지 않는가 |
| 7 | `m7_triage.py` | 유형별 분류·판정 | 분류 카테고리가 원인과 대응하는가. false_alarm 판정 근거 |
| 8·9 | `m8_clang_assemble.py`, `m9_clang_compare.py` | clang 대조 | `as_only`/`clang_only` 의미가 코드와 문서에서 일치하는가 |
| 10 | `m10_reassemble_check.py` | 바이트 왕복 | 왕복 성공 판정이 충분한가 |
| 11·12 | `m11_execute.py`, `m12_execute_edge_cases.py` | 격리 실행 관측 | 격리가 충분한가. 기대값 대조가 있는 것과 없는 것의 구분 |
| 13 | `m13_lint.py` | 전량 검사·상태 부여 | `accepted`/`needs_review`/`rejected`/`incomplete` 의미가 일관된가. 하위 도구 실패가 성공으로 집계되지 않는가 |
| 공통 | `instruction_check.py`, `operand_forms.py` | 검사 API | CLI·배치·API의 판정이 같은가 |

추가로 확인할 것:

1. **판정 전달 경로.** `docs/FUZZING_RESEARCH_REVIEW_2026-09-15.md`의 R1~R3(크래시가 일반 거부로
   분류됨, 지정 인코딩 불일치가 최종 상태에 반영 안 됨, 검사 도구 실패가 배치 성공에 누락됨)이
   실제로 해결됐는지 **실패 주입으로** 확인한다.
2. **캐싱.** `m13_lint.py`는 `(code, syntax, display_syntax)`로 결과를 캐시하고 기대 행 비교는
   따로 한다. 이 분리가 올바른가.
3. **판정 보존.** `review_verdicts.py`가 고정한 사례가 생성기 변경에 영향받지 않는지.
4. **재현성.** `out/runs/*.json`의 환경·해시 기록이 결과를 재현하기에 충분한가.

---

# 4. 실험 방법론 검토

이 연구가 주장하려는 것은 대략 다음이다.

> 매뉴얼에서 생성한 입력을 GNU as와 Clang으로 조립하고 objdump 역어셈블·재조립까지 연결하면,
> 도구 결함·입력 생성 오류·표기 차이·버전 차이를 구분해 낼 수 있다. 이 도구는 이후
> 어셈블러 퍼징의 시드 생성기 또는 차등 테스트 오라클로 쓸 수 있다.

**검토할 것:**

1. **오라클 타당성.** SDM 표를 정답으로 쓰는 것이 타당한가. 매뉴얼 자체에 표기 오류가 있다면
   오라클이 흔들리는데, 이 연구는 그것을 어떻게 다루고 있는가.
2. **커버리지 주장.** "SDM 4,210행에서 입력을 생성했다"가 무엇을 보장하고 무엇을 보장하지 않는가.
   행당 1개 이상 생성했다는 것과 그 행을 검증했다는 것의 간극(현재 349건이 미타격으로 측정됨)이
   적절히 기술돼 있는가.
3. **차등 테스트 전제.** as와 clang에 같은 입력을 넣는다는 전제가 성립하는가
   (2.6(c)에서 공통 표기가 없는 사례가 보고됨).
4. **평가 지표 부재.** 정답 집합과 분리한 평가가 없어 precision/recall을 측정하지 못한다.
   이 상태에서 "도구가 유용하다"고 주장할 수 있는가. 어떤 최소 실험이 필요한가.
5. **선행 연구 대비.** AsFuzzer 등 어셈블러 퍼징 연구와 비교해 이 접근의 새로움과 한계는 무엇인가.
   매뉴얼 기반 시드 생성이 기존 접근보다 나은 점을 어떻게 입증해야 하는가.
6. **결론의 범위.** "확정 어셈블러 버그 0건"이라는 진술이 데이터로 뒷받침되는가.
   미재심 10,109행·unsure 47건이 있는 상태에서 이 진술이 허용되는가.
7. **실행 의미.** 11단계 6건만 기대값과 대조했고 나머지는 실행 여부만 관측했다.
   바이트 일치를 의미 동등성의 근거로 쓰는 지점이 있는지 점검한다.
8. **위협 요인(threats to validity).** 단일 환경(단일 CPU·OS·도구 버전), 단일 문법(Intel),
   64비트 모드 한정, 단일 디스어셈블러 의존이 결론에 미치는 영향.
9. **보안 연구로서의 의의.** 여기서 나온 결함 유형(역어셈블 출력이 재조립되지 않음,
   바이트가 조용히 달라짐)이 실제 보안 문제(바이너리 분석·패치·리버싱 도구 체인)로
   이어지는지, 이어진다면 어떤 시나리오인지.

---

# 5. 요구 산출물

1. **예외 사항 판정표** — 2장의 각 항목에 대해: 재현 여부 / 원인 / 판정 / 저장소 판정과의 차이 /
   근거(명령·버전·출력).
2. **설계 검토 결과** — 3장의 각 단계에 대해: 의도와 구현의 일치 여부, 발견한 불일치와 그 영향.
3. **방법론 검토 결과** — 4장의 각 질문에 대한 답. 이 연구가 현재 데이터로 주장할 수 있는 것과
   없는 것의 경계.
4. **우선순위 없는 결함 목록** — 발견한 문제를 중요도 순으로 배열하되, 그 순위의 근거를 밝힌다.
5. **반대 의견** — 저장소의 판정 중 동의하지 않는 것 전부.

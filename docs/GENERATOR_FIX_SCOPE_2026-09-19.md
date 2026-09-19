# 생성기 수정 라운드 범위 (2026-09-19)

대상: `pipeline/m3_combine.py`, `pipeline/m4_generate.py`
근거 문서: [11회 보고 준비](MEETING_NOTES/11회_보고_준비.md) Q1·Q2, `review/false_alarm_checklist.csv`
환경: Ubuntu 24.04(WSL), GNU as 2.42, objdump 2.42, Clang 18.1.3

이 문서는 **코드를 고치기 전에** 무엇을 바꾸고 무엇을 그대로 둘지 고정한다.
아래의 기대값은 사람이 적은 추측이 아니라 2026-09-19에 실제 도구를 돌려 기록한 관측이다.
수용 여부와 바이트만 기록하며, 수용됐다는 사실을 실행 의미의 확정으로 보지 않는다.

## 1. 결정 사항

| 항목 | 결정 |
|---|---|
| 수정 범위 | `m3`(조합) + `m4`(생성). `m1`(PDF 추출)·`m2`(토큰 분해)는 이번 라운드 제외 |
| 확장 방식 | 결함 수정 + **고정 시드 변형 추가**(랜덤 다중 생성은 다음 라운드) |
| 기존 ID | `combo_id` 재배치 금지. 새 변형은 항상 기존 `combo_index` 뒤에 덧붙인다 |
| 예상 규모 | 7,278 → 약 20,300행 (2.8배). 5~10단계 재실행 시간 증가 |

## 2. 불변조건 (깨지면 파이프라인이 멈춘다)

1. **`combo_id` ↔ `(row_id, combo_index)` 대응 유지.** `m3_combine.py:assign_stable_combo_ids()`가
   이 대응으로 ID를 보존한다. 기존 슬롯 순서를 바꾸면 과거 판정·체크리스트·보고서의 ID가 전부 어긋난다.
2. **재심 고정 사례의 소스 문자열 유지.** `pipeline/review_verdicts.py`는 combo `1516/1527/1532/1535/1571/1683/4597`에
   대해 소스 문자열까지 고정하고 있고, 값이 달라지면 `build_triage_rows()`가 `ValueError`로 중단한다.
   해당 행(LSS/LFS/LGS, LAR/LSL, MOV Sreg, UDB)은 이번 수정 대상에서 제외한다.
3. **`combo_index=0`의 값 변경은 의도한 유형만.** 크기 지시자 제거, 암묵 오퍼랜드 제거, 표기 정리,
   moffs 교정, 레지스터 폭 교정 — 이 다섯 가지 외의 변경은 회귀 테스트가 실패시킨다.

## 3. 고칠 것 (mode_support=Valid 인데 우리 입력이 틀린 행)

기대값 전체는 `tests/expectations/generator_fix_expectations.csv`(29행)에 있다. 유형별 대표 사례:

| 유형 | 현재 (as) | 수정 후 (as, 바이트) |
|---|---|---|
| m512 등 고정 블록에 크기 지시자 | `aesdec256kl xmm0, zmmword ptr [eax]` 거부 | `aesdec256kl xmm0, [eax]` 수용 `67 f3 0f 38 df 00` |
| 〃 | `fxsave zmmword ptr [eax]` 거부 | `fxsave [eax]` 수용 `67 0f ae 00` |
| 모드/폭 제약 미반영 | `movdir64b cx, zmmword ptr [eax]` 거부 | `movdir64b ecx, [eax]` 수용 `67 66 0f 38 f8 08` |
| 〃 | `umonitor cx` 거부 | `umonitor ecx` 수용 `67 f3 0f ae f1` |
| 암묵 오퍼랜드를 명시 | `aesdecwide128kl [eax], xmm0` 거부 | `aesdecwide128kl [eax]` 수용 `67 f3 0f 38 d8 08` |
| 〃 | `tpause ecx, edx, eax` (as 수용/Clang 거부) | `tpause ecx` 양쪽 수용 |
| 매뉴얼 표기 원문 유출 | `vp2intersectd k1+1, xmm0, xmm0` 거부 | `vp2intersectd k1, xmm0, xmm0` 수용 |
| 〃 | `v4fmaddps zmm0, zmm2+3, …` 거부 | `v4fmaddps zmm0, zmm2, …` 수용 |
| 추출 잔여 텍스트 | `vreducesd …, imm8/r` 거부 | `vreducesd …, 1` 수용 |
| moffs 인코딩 미타격 | `mov al, [0x1000]` **수용**하지만 `8a 04 25`(ModRM) | `mov al, ds:0x123456789abcdef0` → `a0 …`(moffs) |

`moffs` 사례는 **as가 받아줬는데도 의도한 행을 시험하지 못한** 경우다. 수용 성공이 곧 검증이 아니라는
기존 기준(CLAUDE.md)의 구체적인 사례이므로 별도로 기록한다.

## 4. 고치지 않을 것

- **매뉴얼이 64비트 무효로 규정한 행**: `bndcl bnd0, ecx`(N.E.), `invpcid ecx, …`(N.E.), `rdpid ecx`(N.E.),
  `push/pop r32`, `call/jmp cx|ecx`. as의 거부가 매뉴얼 기대와 일치하므로 통과시키려고 값을 바꾸지 않는다.
- **rel16 행(33건)**: `call/ja/jb … rel16`은 64비트 모드에서 입력으로 표현할 수 없다. 현재 `call .Ltarget`은
  rel32(`e8 fb ff ff ff`)로 어셈블되므로 그 행을 시험한 것이 아니다. `data16 call .Ltarget`을 관측용 변형으로만
  추가한다 — as는 이때 `66 e8 fa ff ff ff`, 즉 data16 접두어를 붙이고도 4바이트 변위를 낸다. 이 관측은
  기록만 하고 버그로 주장하지 않는다.
- **`m1`/`m2`**: `imm8/r` 같은 추출 잔여 텍스트는 이번엔 `m3`에서 걸러내고, 추출기 자체 수정은 다음 라운드로 둔다.
- **SYSEXIT/SYSRET**(as가 `sysexitq`/`sysretq`만 수용), **VSCATTER vm32y/vm32z**: 판단 보류 유지.

## 5. 변형 추가 정책 (고정 시드)

`combo_index=0`은 기존 값 그대로 두고, 아래를 뒤에 덧붙인다. 난수를 쓰면 시드를 기록한다.

| 변형 | 예 | 관측 |
|---|---|---|
| SIB 메모리 | `add ecx, dword ptr [rax+rbx*4+0x10]` | 수용 `03 4c 98 10` |
| rip 상대 | `add ecx, dword ptr [rip+0x10]` | 수용 `03 0d 10 00 00 00` (현재 생성 입력에 0건) |
| 즉시값 최대 | `adc eax, 0x7fffffff` | 수용 `15 ff ff ff 7f` |
| 즉시값 비축약 | `adc ecx, 0x12345678` | 수용 `81 d1 78 56 34 12` |
| AVX-512 마스크 | `vaddpd zmm0 {k1}{z}, zmm0, zmm0` | 수용 `62 f1 fd c9 58 c0` |
| 브로드캐스트 | `vaddpd zmm0, zmm0, qword ptr [eax]{1to8}` | 수용 `67 62 f1 fd 58 58 00` |

**즉시값 주의**: "해당 크기의 최대값"을 그대로 쓰면 의도한 인코딩 행을 못 때린다.
`adc ax, 0xffff` → `66 83 d0 ff`, `adc eax, 0xffffffff` → `83 d0 ff`로 as가 부호확장 imm8 형식으로 줄인다.
`adc rax, 0xffffffff`는 아예 거부된다. 그래서 최대값 변형은 `0x7fff`/`0x7fffffff`를 쓰고,
인코딩 행 타격용으로 `0x1234`/`0x12345678`(축약되지 않는 값) 변형을 따로 둔다.

규모 추산: 메모리 포함 3,545행 ×2, 즉시값 1,103행, 마스크 3,057행, 브로드캐스트 1,762행 → 약 20,300행.

## 6. 회귀 기대값과 검증 방법

| 파일 | 역할 |
|---|---|
| `tests/baseline/combos_2026-09-15.csv` | 수정 전 7,278행 스냅샷 (ID 대응 기준선) |
| `tests/expectations/generator_fix_expectations.csv` | before/after와 그 자리에서 관측한 as·clang 결과 29행 |
| `scripts/build_fix_expectations.py` | 위 표를 도구 실행으로 다시 만든다 |
| `tests/test_generator_fix.py` | 불변조건 + 기대값 재현 검사 |

```bash
python3 scripts/build_fix_expectations.py      # 기대값 표 재생성 (as/clang 필요)
python3 -m unittest tests.test_generator_fix -v
```

수정이 반영되면 `tests/test_generator_fix.py`의 `FIX_LANDED`를 `True`로 바꾼다.
그러면 "생성기가 실제로 after 값을 만들어내는지"를 검사하는 클래스가 함께 돌아간다.

**반례 확인(2026-09-19)**: combos.csv를 일부러 망가뜨려 테스트가 잡는지 확인했다.
combo_id 전체 이동 → 3건 실패, 재심 고정 사례(1527 LSS) 소스 변경 → 2건 실패,
무관한 행의 오퍼랜드 임의 변경 → 1건 실패, baseline 행 삭제 → 2건 실패. 정상 상태에서는 0건.

## 7. 다음 단계

1. `m3`/`m4` 수정 (이 문서 3·5절 범위)
2. `FIX_LANDED=True`로 바꾸고 회귀 테스트 통과 확인
3. 2~4단계 재생성 후 **5~10단계 재실행** — 현재 `asm_result.csv`(8/24)와 `tests.s`(9/15)의 버전 불일치 해소
4. `review/false_alarm_checklist.csv`의 B그룹 120행을 수정 결과로 판정
5. 결과 수치를 쓰는 문서(11회 발표자료, `docs/LATEST_TEST_RUN.md`)를 재실행 결과로 갱신

---

## 8. 실행 결과 (2026-09-19 마감)

계획대로 `m3`·`m4`를 고치고 5~10단계를 재실행했다. 실행 기록은 `out/runs/20260919T151343549180Z.json`.

| 지표 | 수정 전 | 수정 후 |
|---|---:|---:|
| 생성 입력 | 7,276줄 | 19,120줄 |
| as 수용 / 거부 | 7,162 / 114 | 19,020 / 100 |
| **매뉴얼 Valid 행인데 거부** | **56** | **16** |
| as·clang 바이트 동일 | 7,058 | 18,843 |
| triage `unsure` | 24 | 44 |
| rip 상대 주소 줄 | 0 | 3,432 |
| SIB 주소 줄 | 0 | 3,435 |
| 마스크 사용 줄 | 64 | 2,993 |
| 브로드캐스트 줄 | 0 | 881 |

남은 Valid 행 거부 16건은 전부 기존에 판정·보류된 사례다: SYSEXIT/SYSRET(판단 보류),
LAR/LSL·MOV Sreg(재심 완료, 표기 사례), UDB(as 2.42 미지원), VPMOVQD(SDM 표 오탈자 추정),
VSCATTERDPD vm32y/vm32z(판단 보류). **우리 입력 결함으로 남은 것은 없다.**

체크리스트 B그룹(생성기 결함) 120건: 103건 수용, 17건은 매뉴얼이 N.E./N.S.로 규정한 행이라
거부가 기대와 일치한다. 항목별 관측은 `out/review/checklist_b_status.md`에 있다.

### 계획에 없었는데 추가로 고친 것

1. **7단계 분류 보완**: 변형을 넣자 roundtrip `different`가 9,377건으로 늘었는데, 원인은 분류기가
   새 표기를 못 읽는 것이었다(objdump의 `# 0x17` 주석, 마스크 앞 공백, `QWORD BCST` 표기).
   보완 후 `unsure` 7,046 → 44. 반례 테스트는 `tests/test_roundtrip_classification.py`.
2. **5단계 관측 상태 분리**: `actual_result`에 `crashed`/`timeout`을 추가했다. 예전에는 타임아웃
   예외를 잡지 않아 한 줄 때문에 5단계 전체가 중단될 수 있었다. 7단계는 이 둘을
   `tool_process_failure` · `unsure`로 남기고 false_alarm으로 내리지 않는다.
3. **전체 실행에서만 드러난 생성기 결함 13건**: `rep lods al`(누산기 표기), `enqcmd ecx, [rax+…]`
   (레지스터 폭과 주소 폭 불일치), AMX `sibmem`에 rip 상대 주소. 표본 게이트에서는 안 잡혔다.

### 아직 남은 것

- 전 오퍼랜드가 동일한 줄 2,179개(수정 전 2,161). 오퍼랜드 순서 오류를 구분하려면 슬롯마다 다른
  레지스터를 쓰는 변형이 필요하다. 이번 라운드 범위 밖이다.
- `run_ubuntu_tests.sh` 전체 검증(11~13단계·CPU)은 이번 변경 이후 다시 돌리지 않았다.
- 체크리스트 1,558행의 `내_판단`은 여전히 공란이다(사람이 채울 부분).

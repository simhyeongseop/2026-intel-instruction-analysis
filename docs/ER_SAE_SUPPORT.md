# ER/SAE 생성·CLI 지원 — 2026-10-13

`vaddpd zmm0, zmm1, zmm2, {rn-sae}`와 `vcomisd xmm0, xmm1, {sae}`는 이제 CLI에서 해당 SDM 행을 찾고, 조립 바이트와 역어셈블 장식을 대조한다. 생성기는 SDM 093판의 ER/SAE 288행에 1,598개 변형을 추가한다.

## 수정 내용과 원문 근거

- `pipeline/fp_controls.py`: 일반 오퍼랜드와 반올림·SAE 표기를 분리하면서 위치·중복을 보존한다. 모르는 장식은 지우지 않는다. 후보 탐색은 데이터 오퍼랜드의 수·종류·폭과 ER/SAE 조건을 각각 검사한다.
- SDM Vol.2 PDF 72쪽 §§2.7.8–9: register-to-register, scalar/512-bit 조건. PDF 108쪽: `{er}`·`{sae}` 표 기호 정의. 실제 범위는 DB의 EVEX.512/LLIG 행이며, 변환 명령은 목적지나 소스 레지스터가 작아도 EVEX.512 표 행일 수 있다.
- PDF 73쪽 Table 2-38: ER 네 모드의 RC 값 00/01/10/11. PDF 75쪽 Table 2-43 note 2: SAE-only의 L'L은 ignored. SAE 입력을 특정 RC 모드로 판단하지 않는다.
- 생성기는 레지스터 대표 입력에 네 ER 모드 또는 SAE를 추가한다. 마스크가 있는 행은 마스크 없는 입력과 마스크 있는 입력을 만든다. 기존 변형 뒤에 추가해 기존 case_id·입력·근거를 유지한다.
- 인코딩 검사는 요청한 장식과 EVEX.b, RC, ModRM.mod를 대조한다. 반올림 모드 변경, 장식 비트 누락, 장식 없는 입력에 ER/SAE 바이트를 내는 반례를 구분한다. `--expect-row`도 같은 조건을 확인한다.
- 역어셈블에서는 RC/SAE를 마스크와 별도로 비교한다. 모드가 다르거나 장식이 빠지면 오퍼랜드 불일치다. 즉시값이 니모닉에 접힌 CMP 의사 명령도 처리한다.

사용한 색인 원문은 별도 snapshot의 `sdm_control_evidence.json`에 보존했다. 원문 DB와 PDF는 수정하지 않았다. 위 판정은 부분 인코딩·입력 조건 검사이며 전체 ISA 의미나 CPU 실행 결과를 뜻하지 않는다.

## 실제 관측

환경: GNU Binutils 2.47.20260726, LLVM/clang 23.1.3, WSL Ubuntu.

| 새 생성 입력 1,598개 | 결과 |
| --- | --- |
| GNU 조립 | SDM 일치 1,598 |
| clang 조립 | SDM 일치 1,558, 거부 40 |
| objdump / LLVM 역어셈블 | 각각 SDM 일치 1,598 |
| 각 역어셈블 출력 재조립 | 각각 1,598 모두 거부 없이 처리 |
| CLI 생성 행 후보 | 1,598 모두 포함 |
| 조립 SDM 일치와 CLI 같은 행 판정 | 3,156 모두 일치 |

clang의 거부 40개는 `VCVTSI2SD/SS/SH`와 `VCVTUSI2SD/SS/SH`의 10개 GPR 폭 형식 × 네 모드다. 예:

```asm
vcvtsi2sd xmm0, xmm1, rcx, {rn-sae}  # 생성 입력: GNU 수용, clang 거부
vcvtsi2sd xmm0, xmm1, {rn-sae}, rcx  # LLVM 출력: GNU·clang 모두 수용
```

LLVM 출력의 RC-before-GPR 철자 40개도 새로 조립해, 각 도구의 바이트를 해당 SDM 행과 대조했다. 두 도구와 CLI 모두 40개 SDM 일치다. 이 결과를 명령 미지원이나 새 LLVM 버그로 분류하지 않는다. CLI는 두 철자를 인식하지만 각 도구의 실제 수용·거부는 그대로 기록한다. 원문의 추상 표기와 도구의 철자를 구분한다.

대표 반례의 원시 관측도 보존했다: YMM VADDPD ER, 메모리 VADDPD ER, VADDPD SAE 단독, 메모리 VCOMISD SAE, 잘못된 위치·중복 장식. 이 입력들은 후보가 없고 두 도구 모두 거부했다. 회귀 검사에는 RC 비트를 바꾼 바이트, EVEX.b를 지운 바이트, SAE-only LL ignored, 지원하지 않는 지정 행도 포함한다.

## snapshot과 검증 범위

- `out/er_sae_support_20261013/generated/`: 전체 21,060케이스 생성 결과.
- `added/`: 새 1,598개만 실제로 조립·역어셈블. 기존 전체 조립 결과와 혼합하지 않았다.
- `focused_cli.json`, `layout_observations.json`: 대표 정상·반례와 대체 철자의 원시 도구 결과.
- `manifest.json`: 새 조립 실행 환경·코드·입출력 해시. `run_review.py`가 실행한 기록이다.
- `final_validation_v2/manifest.json`: 최종 코드의 테스트·기존 및 추가 관측 재판정. `verify_final.py`의 기록이며, 이 단계의 전체 조립은 새로 수행하지 않았다.

최종 WSL 회귀 153개 통과, 건너뜀 없음. 기존 생성 19,462개는 모든 CSV 필드가 같고, 보존된 기존 인코딩 일치 38,282건과 역어셈블 오퍼랜드 일치 38,115건이 유지됐다. CLI의 기존 34,144개 SDM 일치도 같은 행으로 유지됐다. 기본 `out/cases` 파일 해시는 첫 실행 전후 같다.

첫 저장 텍스트 재판정 도구는 FWAIT+FN* 결합을 빠뜨려 세 기존 결과를 회귀로 잘못 표시했다(`final_validation/`, completed=false). 재판정 도구에 기존 m4 규칙을 적용한 `final_validation_v2/`는 errors=[]로 완료됐다. 파이프라인의 FWAIT 판정은 변경하지 않았다.

새 CPU 실행, LLVM 패치 빌드, 이슈 제출, 커밋은 수행하지 않았다.

# LLVM AVX512PF Intel 문법 수정

관련 이슈: https://github.com/llvm/llvm-project/issues/233852

제출한 PR: https://github.com/llvm/llvm-project/pull/233869 (2026-10-20).
커밋: `b836e813e18e475bb9472762b994a97675654103`.
브랜치: `simhyeongseop/llvm-project:codex/fix-avx512pf-intel-mask`.
로컬 검증 완료와 별개로 LLVM 측 자동 검사 및 리뷰 결과는 PR에서 확인한다.

기준 소스: LLVM main `74a120bff99f527087d231e14844b384a7dc1131`.

## 변경 이유와 코드

AVX512PF gather/scatter prefetch 공통 정의가 Intel 문법에서 마스크를
메모리 앞의 별도 피연산자로 배치한다. 파서는 그 출력을 받지 못한다.
기존 두 문법의 분기 구조를 유지하면서 Intel 쪽도 메모리 뒤에 마스크를 둔다.

```diff
- !strconcat(OpcodeStr, "\t{$src {${mask}}|{${mask}}, $src}")
+ !strconcat(OpcodeStr, "\t{$src {${mask}}|$src {${mask}}}")
```

이 한 줄을 16개 prefetch 명령이 공유한다. AT&T의 출력 순서는 유지한다.
기존 PR #122051의 수정 논의도 참고했다:
https://github.com/llvm/llvm-project/pull/122051#issuecomment-2576984459

TableGen은 가장 바깥 중괄호를 문법 선택 기호로 해석한다. 따라서 분기를
유지해 실제 마스크 장식의 중괄호를 보존한다. 관련 구현은
`llvm/utils/TableGen/Common/CodeGenInstruction.cpp`의
`FlattenAsmStringVariants`이다.

## 패치 적용

LLVM 소스 저장소에서 다음 명령을 실행한다.

```sh
git apply --check /path/to/llvm-avx512pf-intel-mask.patch
git apply /path/to/llvm-avx512pf-intel-mask.patch
```

`avx512pf-64-intel.s`는 패치 안에 포함된 새 LLVM 회귀 테스트의 별도 사본이다.
기존 `avx512pf-64-att.s`의 32개 기대 인코딩을 그대로 사용한다. 16개 명령
각각의 크기 생략·명시 입력, YMM/ZMM, 높은 번호의 레지스터, k1–k7,
인덱스 배율과 압축 변위를 다룬다.

새 테스트는 다음 세 경로를 확인한다.

- Intel 조립 결과와 기존 기대 바이트가 일치한다.
- LLVM이 출력한 Intel 문법을 다시 조립해 같은 바이트를 얻는다.
- 오브젝트 파일을 역어셈블하면 마스크가 메모리 뒤에 나온다.

## 검증 기록

별도 실험 폴더: `out/avx512pf_fix_20261020/`.
기존 LLVM 23.1.3에서 새 Intel 입력 32개가 모두 거부되고, 대응하는 기존
AT&T 입력 32개는 성공하는 것을 `baseline.json`에 기록했다.
최종 패치는 같은 main 커밋에서 X86 전용 LLVM 도구를 직접 빌드해 검증했다.
Release, assertions ON, GCC, C++ 최적화 `-O1` 설정이다.

| 검사 | 결과 |
|---|---|
| Intel 입력 32개 조립 및 기존 기대 바이트 비교 | 모두 통과 |
| 기존 AT&T 입력 32개 바이트 유지 | 모두 통과 |
| LLVM Intel 출력 32개 재조립 및 바이트 비교 | 모두 통과 |
| 오브젝트 역어셈블의 Intel 마스크 위치 | 모두 통과 |
| 마스크 생략·k0·zeroing·잘못된 VSIB 폭 2개·잘못된 크기 | 6개 모두 거부 |
| LLVM lit 회귀 테스트 | 8개 통과, 실패·건너뜀 없음 |

회귀 테스트는 새 Intel 정상/오류 파일 2개, 기존 prefetch AT&T 파일,
기존 AVX512 두 문법의 정상/오류 파일 4개, `gather.s`다.
`avx512pf-intel-errors.s`도 패치에 포함했다.

검증 범위는 X86 조립·인코딩·역어셈블이다. 전체 LLVM 테스트나 CPU 실행을
수행한 결과가 아니다. 최종 성공 기록은 `manifest.json`,
`validation_final.json`, `lit_results.json`과 `lit_results.log`다.
최초 두 문자열 시도의 실패 기록과 역어셈블 16진수 표기로 인한 테스트 실패
기록도 별도 이름으로 보존했다. 이를 최종 패치 결과와 혼동하지 않는다.

준비·빌드·검증 스크립트도 같은 실험 폴더에 보존한다. 소스와 빌드 도구는
WSL의 `~/opt/build/llvm-avx512pf-fix-20261020/`에 격리되어 있다.

다시 테스트하려면 해당 빌드의 `bin/llvm-lit -v`에 위 8개 파일을 전달하거나
실험 폴더의 `run_lit.sh`를 사용한다. 후자는 이 작업 환경의 경로를 사용한다.

## 2026-10-21 CI 후속 보완
기존 APX 역어셈블 기대값 갱신과 비활성화된 Intel 조립 예제 복구를 추가 커밋95243a87ae24d35a27a4cf2c46824bbd999bb645으로 같은 PR에 반영했다. 관련 lit10/10 통과 근거와 두 파일의 추가 diff는 out/avx512pf_ci_followup_20261021/에 있다. 이 폴더의 원래 패치 파일은 최초 제출분이며, 후속 보완은 해당 snapshot의 expected_output_update.patch와 함께 확인한다.

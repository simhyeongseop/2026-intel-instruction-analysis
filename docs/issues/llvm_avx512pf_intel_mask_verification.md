# AVX512PF Intel 문법 버그 재검증 — 2026-10-12

판정: **실제 LLVM Intel 문법 결함으로 보고할 근거가 충분하다.** SDM 표에 맞는 입력의 조립 거부와 LLVM 자체 Intel 출력의 재조립 거부를 직접 재현했다. 제안한 수정은 소스 구조와 맞지만 패치 빌드로 검증하지 않았다.

## 이번에 직접 실행한 범위

- 별도 snapshot: `out/avx512pf_review_20261012/`; 기존 `out/cases`나 원문 DB는 바꾸지 않았다.
- `reproduce.py`: 실행 입력과 수집 방법. `manifest.json`: 범위, 시간, 버전, LLVM 실행 파일 SHA256. `observations.json`: 각 명령, 표준입력, 반환값, stdout/stderr. `summary.csv`: 16개 요약.
- WSL Ubuntu의 `llvm-mc` 출력은 `LLVM version 23.1.3`, GNU as/objdump는 정확히 `GNU Binutils 2.47.20260726`이다. 기존 설치 파일의 출처를 이번에 다시 인증한 것은 아니다.
- 16개 × LLVM AT&T, Intel 크기 생략, Intel 올바른 크기 표기, Intel 역어셈블, 그 출력 재조립, GNU Intel 조립을 확인했다.
- `*DPD` 4개는 YMM 인덱스, 나머지 12개는 ZMM 인덱스. DPS/QPS는 `dword ptr`, DPD/QPD는 `qword ptr`를 사용했다.

| 검사 | 결과 |
| --- | --- |
| LLVM AT&T | 16/16 조립 성공 |
| LLVM Intel, 크기 생략 | 16/16 `invalid operand for instruction` |
| LLVM Intel, 올바른 크기 표기 | 16/16 `invalid operand for instruction` |
| LLVM Intel 역어셈블 | 16/16 마스크를 앞에 출력 |
| LLVM Intel 출력 재조립 | 16/16 `unknown token in expression` |
| GNU Intel | 16/16 성공, 각 명령의 LLVM AT&T 바이트와 같음 |
| 일반 `vgatherdps` / 메모리 마스크 `vscatterdps` 대조군 | 둘 다 성공 |

대표 명령 `vgatherpf0dps`의 AT&T와 GNU Intel 바이트는 모두 `62 f2 7d 49 c6 0c 00`이다. LLVM Intel 출력은 `vgatherpf0dps {k1}, dword ptr [rax + zmm0]`이고 재조립은 실패한다. 추가 Intel 철자 4개도 초안대로 실패했다. 다만 `zmmword ptr` 실패는 올바른 크기의 입력을 거부했다는 근거로 사용하지 않는다.

**추가 옵션 시험의 한계:** `-mattr=+avx512f,+avx512pf`도 기록했지만, 도구가 `+avx512pf`를 인식하지 않고 무시한다는 경고를 냈다. `intel_features_rc`는 기능 활성화 성공을 뜻하지 않으며, 이 시험은 기능 활성화 여부의 근거에서 제외한다. 기본 설정의 조립·역어셈블 결과와 대조군이 본 판정의 근거다.

## 원문과 기존 결과 대조

- 로컬 `intel_manual.pdf`, order no. 325383-093US, PDF 2375쪽 = Vol. 2D 8-12: `EVEX.512.66.0F38.W0 C6 /1 /vsib VGATHERPF0DPS vm32z {k1}`. 초안의 쪽수·순서·대표 opcode 근거가 맞다.
- 나머지 묶음은 PDF 2377/2399/2401쪽, 인쇄 쪽 8-14/8-36/8-38. 네 DPD 표는 `vm32y`이며 프로젝트의 표 우선 규칙에 따라 YMM을 쓴다.
- 기존 `out/runs/20261012T010114208021Z.json`의 범위는 check + disasm이며, 현재 결과 파일 6개의 SHA256은 manifest와 일치한다. 그 결과도 올바른 인덱스 폭으로 16개 GNU 수용·clang 거부, LLVM Intel 출력 재조립 거부를 기록한다.
- 기존 `disasm_results.csv`의 `verdict_llvm=SDM 일치`는 의미 행 대조 결과다. `reassembled_llvm=거부`와 함께 해석해야 하며 왕복 성공으로 설명하면 안 된다.

## 원인 및 수정안의 확실성

공식 LLVM 소스의 `avx512_gather_scatter_prefetch` 공통 정의는 Intel 쪽을 `{${mask}}, $src`로 적고, 16개 명령이 이를 공유한다. 따라서 출력의 마스크 위치도 이 정의를 따른다.

- 피연산자 시작의 `{...}`는 Intel 파서의 rounding/SAE 처리로 들어가고, `{k1}`는 거부된다.
- 메모리 뒤 `{k1}`는 `HandleAVX512Operand`가 파싱할 수 있다. 실패 지점은 이 순서와 Intel 명령 정의의 matcher 순서 불일치다. 메모리 마스크의 파싱 자체가 미지원이라는 설명은 부정확하다.
- Intel 정의를 `$src {${mask}}`로 바꾸는 것은 합리적인 수정안이다. 패치 빌드, 16개 Intel 조립·역어셈블·재조립 및 기존 AT&T 회귀 전에는 수정 완료라고 하지 않는다.

GitHub API로 `llvmorg-23.1.3`의 commit `0d261d1ca552c95a8f007e061c787ac7132fbcbc`를 확인했다. 공식 소스: [AVX512 정의 L10434–10440](https://github.com/llvm/llvm-project/blob/0d261d1ca552c95a8f007e061c787ac7132fbcbc/llvm/lib/Target/X86/X86InstrAVX512.td#L10434-L10440), [선행 중괄호 처리](https://github.com/llvm/llvm-project/blob/0d261d1ca552c95a8f007e061c787ac7132fbcbc/llvm/lib/Target/X86/AsmParser/X86AsmParser.cpp#L2672-L2673), [뒤쪽 마스크 처리](https://github.com/llvm/llvm-project/blob/0d261d1ca552c95a8f007e061c787ac7132fbcbc/llvm/lib/Target/X86/AsmParser/X86AsmParser.cpp#L3021-L3030). 조회 근거는 snapshot의 `upstream_check.json`(커밋)과 `upstream_check.txt`(로컬에만 있음)에 있다.

[PR #122051](https://github.com/llvm/llvm-project/pull/122051)은 cdisp8 인코딩 수정이며 2025-01-11 병합됐다. GitHub API 원문에서 마스크 위치는 그 패치에서 다루지 않았다는 언급을 직접 확인했다. 관련 언급이 있다는 것과 이 Intel 문법 버그가 이미 수정됐다는 것은 다르다. 검색에서 못 찾았다는 사실만으로 중복 이슈가 없다고 단정할 수 없다.

- `llvmorg-23.1.3` X86 MC 시험 디렉터리 456개 항목을 잘림 없이 조회했다. `avx512pf-64-att.s`는 있고 `avx512pf-64-intel.s`는 없다. 이것은 해당 파일명의 부재 확인이며, 다른 파일에 Intel 시험이 전혀 없다는 증명은 아니다.
- GitHub API에서 `repo:llvm/llvm-project AVX512PF Intel`, `repo:llvm/llvm-project vgatherpf0dps`, `repo:llvm/llvm-project "mask operand position"`을 검색했다(각 28/3/6개, incomplete=false). 이 마스크 순서 문제의 별도 이슈는 발견하지 못했다. 함께 나온 PR #122530은 gather/scatter 메모리 크기 표기의 수정이며, #35550은 높은 번호 ZMM 레지스터의 기능 검사 문제다.

CPU 실행 가능성·명령 실행 의미·수정 후 회귀는 이번 검증 범위가 아니다. 이슈는 제출하지 않았다.

# AVX512PF Intel 문법 거부: 매뉴얼 문제인가, 도구 문제인가 (2026-10-13)

질문: clang/llvm-mc가 Intel 문법의 AVX512PF 16행을 거부하는 것을 SDM 위반(LLVM 버그)으로 볼 수 있는가, 아니면 매뉴얼 쪽 문제이거나 "안 되는 게 맞는" 것인가.
근거 파일: `out/avx512pf_review_20261012/`, `out/presentation_review_20261013/`(XED `knl-isa.xed.txt`, `xed-disas.c`).

## 1. 관측(재현됨)

| 입력 | GNU as 2.47 | LLVM 23.1.3 |
|---|---|---|
| Intel `vgatherpf0dps [rax+zmm0] {k1}`(SDM 순서) | `62 f2 7d 49 c6 0c 00` | 거부 "invalid operand" |
| Intel `vgatherpf0dps {k1}, dword ptr [rax + zmm0]`(LLVM 자신의 Intel 출력) | – | 거부 |
| AT&T `vgatherpf0dps (%rax,%zmm0) {%k1}` | – | `62 f2 7d 49 c6 0c 00` |
| 역어셈블 | objdump `vgatherpf0dps DWORD PTR [rax+zmm0*1]{k1}` | llvm-mc `vgatherpf0dps {k1}, dword ptr [rax + zmm0]` |

16행 모두 같은 양상이다. Godbolt(Clang 23.1.0) 대표 1개도 같다.

## 2. "매뉴얼 문제"라는 견해 — 이 쪽 논리

- SDM의 Instruction 칸은 추상 표기이고 어셈블러 문법 명세가 아니다. 우리도 같은 이유로 먼 호출 출력 후보(`PTR` 크기 표기)를 철회했다.
- 그렇다면 `{k1}`를 앞에 두든 뒤에 두든 도구 관례이고, LLVM이 SDM을 "위반"했다고 말할 수 없다.
- 대상 ISA는 단종된 Xeon Phi(KNL/KNM) 전용이다. LLVM 19가 관련 intrinsic을 지웠으므로 "안 되는 게 자연스럽다"고 볼 수도 있다.

## 3. 반대 근거 — 조사한 사실

1. **SDM이 이 부분은 Intel 문법을 직접 말한다.** Vol.1 §15.6.1.2(15-10, PDF 394): "An opmask register serving as a predicate operand is expressed as a curly-braces-enclosed decorator following the first operand in the Intel assembly syntax." 먼 호출의 `PTR`처럼 SDM이 침묵한 경우와 다르다.
2. **표·본문·Intel 자체 도구가 서로 맞는다.** Vol.2 8-12 표 `VGATHERPF0DPS vm32z {k1}`, Vol.1 문장, Intel XED 정의 `OPERANDS: MEM0:r:d:f32 REG0=MASKNOT0()`(메모리가 첫 피연산자), GNU as·objdump. 매뉴얼 안에서 충돌하는 곳을 찾지 못했다.
3. **LLVM은 지원을 유지한다고 밝혔다.** LLVM 19 릴리스 노트: "Removed knl/knm specific ISA intrinsics: AVX512PF, AVX512ER, PREFETCHWT1, while assembly encoding/decoding supports are kept." 실제로 AT&T는 조립되고 역어셈블도 된다. "의도적으로 끊었다"는 설명은 맞지 않는다.
4. **SDM과 무관하게 도구 안에서 모순이다.** LLVM이 Intel 문법으로 출력한 자기 결과(`{k1}, dword ptr [...]`)를 같은 LLVM이 다시 조립하지 못한다. 원인은 Intel 정의 `{${mask}}, $src`와 파서가 맨 앞 `{k1}`을 읽지 못하는 것의 불일치다(`X86InstrAVX512.td`).

## 4. 의견

- **매뉴얼 오류로 볼 근거는 찾지 못했다.** 표, Vol.1 문법 설명, Intel XED, GNU가 같은 순서를 쓴다.
- **"SDM 위반"이라는 주장은 중간 강도다.** Vol.1 문장이 있어서 `PTR` 사례보다는 강하지만, SDM 전체가 어셈블러 문법 명세는 아니라는 반론은 남는다.
- **가장 확실한 주장은 "LLVM 내부 불일치"다.** 지원을 유지한다고 밝힌 명령에서 Intel 문법 입력이 하나도 조립되지 않고, 자기 출력을 다시 조립하지 못한다. 이것은 SDM 해석과 무관하다.
- **실제 영향은 작다.** 단종 하드웨어 전용이고 AT&T 문법으로는 쓸 수 있다.

발표 문구 제안: "SDM 표기·Intel XED·GNU와 다른 순서를 쓰며, LLVM 자신의 Intel 출력도 재조립되지 않는 도구 내부 불일치(단종 ISA, 영향 작음)". "SDM 위반 버그"라고 단정하지 않는다.

## 5. 교수님께 여쭐 것

- 검사 기준을 "SDM 원문"으로 둘 때, Vol.1처럼 문법을 직접 말한 문장이 있는 경우와 없는 경우(`PTR`)를 다르게 다루는 기준이 타당한가.
- 단종 ISA의 도구 결함을 이슈로 보고할 가치가 있는가.

## 출처

- Intel SDM 093판 Vol.1 §15.6.1.2(PDF 394), Vol.2D 8-12(PDF 2375)
- LLVM 19.1.0 Release Notes: https://releases.llvm.org/19.1.0/docs/ReleaseNotes.html
- Intel XED `datafiles/knl/knl-isa.xed.txt`, `src/dec/xed-disas.c`: https://github.com/intelxed/xed
- LLVM 23.1.3 `X86InstrAVX512.td`: https://github.com/llvm/llvm-project/tree/llvmorg-23.1.3/llvm/lib/Target/X86
- 재현: Godbolt Intel 실패 https://godbolt.org/z/of1hfozfa , AT&T 성공 https://godbolt.org/z/Goo8f9jvd

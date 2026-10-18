# 발표 전 재점검: SDM 일치가 아닌 케이스 (2026-10-13)

대상: 기본 결과 `out/cases/check_results.csv`(19,462케이스, GNU Binutils 2.47 `--64 -mintel64`, LLVM 23.1.3).
근거 파일: `out/presentation_review_20261013/`(재실행 스크립트·결과, LLVM 23.1.3 TableGen 발췌, Intel XED main 발췌).
이 문서는 분류 재점검이다. 파이프라인 코드와 기본 판정 파일은 바꾸지 않았다.

## 기대 결과 구성(2단계)

- 4,219는 SDM 인코딩 표의 행 수다. 니모닉은 1,617개다.
- 19,462는 행마다 대표값(레지스터 1, 메모리 base·SIB·RIP, 즉시값 2개 등)으로 만든 케이스다. 모든 조합이 아니다.
- reject 106(55행): 표의 64비트 열이 Invalid·N.E.인 행. 도구가 거부해야 맞는 음성 시험이다.
- alias_no_test 48(44행): 64비트 무효 행인데 같은 소스가 다른 유효 행으로 조립된다(예: `inc ecx`, `jz rel16`). 거부를 시험할 수 없어 뺐다.

## 재분류(GNU 78케이스, clang 274케이스)

| 그룹 | GNU | clang | 근거 | 판단 |
|---|---|---|---|---|
| 같은 문법의 다른 유효 행(별칭 행 도달) | 24 | 181 | 판정 규칙 | 정상 |
| 우리 기대값 오류: `call/jmp dword ptr [m]` | 6 | – | CALL 절 Description(파일 239~): 간접 먼 호출 메모리는 4바이트(16비트 오퍼랜드 크기) 또는 6바이트. 4바이트 = m16:16(Valid). XED CALL_FAR 메모리 폭 p2 = 4/6/10 | GNU의 `66 FF /3`은 SDM 유효 행. 소스가 N.E. 행 CALL r/m32와 유효 행 m16:16에 모두 맞으므로 reject가 아니라 alias였다 |
| 원문이 허용한 동의어: GNU `iret` → `cf` | 1 | – | IRET Description(파일 608): "most assemblers use the IRET mnemonic interchangeably for both operand sizes" | 정상(원문 허용) |
| 원문 표기 한계: SYSEXIT·SYSRET | 2 | – | 표의 두 행이 같은 니모닉(0F 35, REX.W 0F 35). GNU는 `sysexitd/q` 접미사 요구 | 버그 아님, SDM 철자로는 행 구별 불가 |
| 등록된 도달 불가 형식: LAR·LSL REX.W | 2 | 1 | `data/rules/unreachable_forms.csv`, 본문이 32/64 동작 동일 명시 | 버그 아님 |
| 도구 기본 미지원: MPX | 26 | 26 | binutils 57c526470(2.44부터 기본 비활성), clang 어셈블러는 니모닉 미지원 | 지원 중단/비활성 |
| 도구 미지원 니모닉: INT1, UD0, UDB | – | 6 | LLVM 23.1.3 TableGen에 INT1·UD0 정의 없음(UD1·UD2만). Intel XED는 INT1(F1), UD0(0F FF /r) 정의. UDB는 093판 신규 | 도구 미지원(버그 아님) |
| 도구 의도적 미지원: MOVSXD r16·r32 | – | 8 | SDM 표 Valid, NOTES 2 "discouraged". XED·GNU 지원. LLVM 소스 주석 "Only support them for the disassembler"(`X86InstrExtension.td`) | 도구 설계 선택(버그 아님). 단, LLVM 역어셈 출력 `movsxd ecx, edx`를 자기 어셈블러가 거부 |
| 우리 생성 근거 약함: VMOVW·VPBROADCASTB/W r64 | 14 | 12 | SDM은 표 `reg` + SYM039 "r16, r32, or r64"뿐. Intel XED는 GPR32만 정의. GNU는 모두 거부, LLVM은 VMOVW만 받음 | 버그 아님. r64 변형(2026-10-12 추가)은 재검토 대상 |
| 원문 표기와 실제 동작 차이: MOV Sreg, r/m64 메모리 | 3 | 3 | 표·SYM038 m64, 도구 2바이트(`word ptr`), CPU 쪽 경계 실험 2바이트 읽기 | 버그 아님. SDM 표기 문제 가능성 |
| 우리 생성 철자 문제: PUSH imm16, XBEGIN rel16 | – | 3 | 생성 소스 `data16 push`·`data16 xbegin`은 GNU 관례. LLVM은 `data16`을 원시 66 바이트로 내고 명령은 32비트로 조립. LLVM Intel 문법에는 16비트 즉시값 push 철자가 없고 AT&T `pushw $imm`은 `66 68 iw` | 버그 아님. 도구 문법 차이 |
| 버그 후보(이미 보고): CLRSSBSY·RSTORSSP `qword ptr` 거부 | – | 6 | SDM m64(SYM044 quadword), XED `MEM0:rw:q:u64`. LLVM은 `dword ptr` 받고 `qword ptr` 거부 | 가장 강함. #95232(2024-06, 열림, 관리자 응답 없음) |
| 버그 후보(이미 보고): `call/jmp word·dword ptr [m]` → `FF /3`(m16:32) | – | 12 | 위 CALL 4/6바이트 문장. word(2바이트)에 맞는 먼 포인터 없음, dword(4바이트)는 m16:16 | 크기 키워드(PTR)는 SDM 문법이 아니어서 근거가 도구 관례에 기댐. 먼 호출 출력 후보를 철회한 이유와 같은 한계. #88516(2024-04), #95232, 모두 열림, 관리자 응답 없음 |
| 버그 후보(미보고): AVX512PF Intel 문법 16행 거부 | – | 16 | 표 순서·Vol.1 §15.6.1.2. LLVM 19 릴리스 노트: "Removed knl/knm specific ISA intrinsics: AVX512PF, AVX512ER, PREFETCHWT1, while assembly encoding/decoding supports are kept." AT&T 성공, 자기 Intel 출력 재조립 실패 | 도구 내부 불일치. 생성 소스는 SDM 순서 그대로. 대상 ISA는 단종된 Xeon Phi 전용 |

합계: GNU 24+6+1+2+2+26+14+3 = 78, clang 181+1+26+6+8+12+3+3+6+12+16 = 274.

## 정리

- 기존 "버그 후보 3개"는 clang에만 있다. 근거 강도: CLRSSBSY·RSTORSSP > AVX512PF(도구 자기 모순) > 먼 호출(PTR 관례 의존).
- 우리 쪽 문제 3가지: CALL·JMP dword 기대값(6), r64 변형 근거(26), `data16` 철자(3). 판정 코드·생성기는 아직 고치지 않았다(사용자 결정 필요).
- 원문 문제 가능성: MOV Sreg r/m64 메모리 폭.

## 출처

- LLVM 19.1.0 Release Notes, X86: https://releases.llvm.org/19.1.0/docs/ReleaseNotes.html
- LLVM issue #88516: https://github.com/llvm/llvm-project/issues/88516
- LLVM issue #95232: https://github.com/llvm/llvm-project/issues/95232
- binutils bc31405ebb2c "x86-64: Properly encode and decode movsxd"(H.J. Lu, 2020-01-27): https://gnu.googlesource.com/binutils-gdb/+/bc31405ebb2c
- Intel XED datafiles(main): https://github.com/intelxed/xed/tree/main/datafiles
- LLVM 23.1.3 TableGen: https://github.com/llvm/llvm-project/tree/llvmorg-23.1.3/llvm/lib/Target/X86

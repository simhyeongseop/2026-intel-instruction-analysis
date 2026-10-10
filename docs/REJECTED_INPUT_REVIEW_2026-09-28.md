# 거부된 178개 입력의 SDM 오퍼랜드 재검토

대상은 2026-09-28 생성 감사 snapshot이며, 검토 완료일은 2026-09-29이다. 한 어셈블러라도
`diagnostic_rejection`인 고유 combo 178개, ISA DB 104행을 전부 검토했다.
GNU와 Clang 모두 거부한 것은 92개, Clang만 거부한 것은 74개, GNU만 거부한 것은 12개다.

**결과는 오퍼랜드 형태 합치 129개, Description 또는 지원 모드와 양립하지 않는 주소 문제 44개,
도구별 크기 표기 관례 차이 2개, SDM 메모리 폭 표기 미확인 3개다.**
129개 중 62개는 대상 행 자체가 64비트 모드에서 무효다. 따라서 129개를 정상적인 64비트 입력 수로
해석하면 안 된다. 도구 관례 차이가 있는 BOUND는 전체 6개지만, 4개는 주소 문제 44개에도 들어가므로
상호 배타적인 최종 집계에서는 나머지 2개만 별도 항목으로 센다.

| 최종 오퍼랜드 판정 | 64비트 Valid 행 | 64비트 무효 행 | 합계 |
|---|---:|---:|---:|
| 정적 오퍼랜드 형태 합치 | 67 | 62 | 129 |
| Description/주소 조합 문제 | 13 | 31 | 44 |
| 도구별 크기 표기 관례 차이만 남음 | 0 | 2 | 2 |
| 메모리 폭 표기 미확인 | 3 | 0 | 3 |
| 합계 | 83 | 95 | 178 |

모드 열의 분포는 `Valid=83, Invalid=44, N.E.=46, N.S.=5`다.
모드 무효 95개도 오퍼랜드를 별도로 검사했다. 데이터 형식은 맞아도 RAX/RBX 또는 RIP-relative
주소를 사용하는 31개는 해당 명령 행을 지원하는 비64비트 모드에 그 주소를 그대로 옮길 수 없다.
이 입력들은 부정 테스트로 유지할 수 있지만, 해당 SDM 행의 정상 오퍼랜드 예제로 사용할 수 없다.

## 개별 판정과 증거

- [178개 개별 검토 CSV](../out/rejected_input_review_2026-09-28/cases.csv): 원본 source, row ID,
  Description, SDM operands, mode, 양 어셈블러의 저장된 상태/진단, 표기 일치와 Description 판정,
  개별 register/memory/mask 검토 이유, 주소와 지원 모드 관계, 증거 참조를 담았다.
- [집계 JSON](../out/rejected_input_review_2026-09-28/summary.json): 상호 배타적 총계와 문제 입력
  44개의 combo ID, 미확인 3개의 ID를 제공한다.
- [SDM 해당 페이지 원문 추출](../out/rejected_input_review_2026-09-28/sdm_pages.json): key는 1부터
  세는 PDF 파일 페이지다. 명령의 표, Description, 필요한 Operation/예외 조건과 주소형 규정을 보존했다.
- [문법 대조 관측 36개](../out/rejected_input_review_2026-09-28/syntax_probes.json): BOUND의 지원 모드,
  far branch 폭 지정, CET의 memory 크기 생략, MPX mib의 index 생략을 확인한 명령행/진단/역어셈블 원문이다.
- [입력 해시와 환경](../out/rejected_input_review_2026-09-28/manifest.json),
  [재현 스크립트](review_artifacts/review_rejected_inputs_2026-09-28.py).

ISA 판정의 기준은 로컬 `intel_manual.pdf`의 원문이다. 어셈블 성공이나 바이트 동일을 ISA 적합성의
증거로 대체하지 않았다. 새 probe는 source 문법의 해석을 설명하는 용도이며 CPU 실행은 하지 않았다.
원본 snapshot과 생성 pipeline 코드는 수정하지 않았다.

## Description 또는 주소 문제가 있는 입력

Description 문제 13개와 주소 조합 문제 31개는 서로 겹치지 않아 union이 44개다.

| 유형 | 개수 | combo ID/근거 |
|---|---:|---|
| VPMOVQD EVEX.128 memory destination 폭 | 5 | 6540, 18282, 18283, 18284, 24567; PDF 2054–2055 |
| VSCATTERDPD index register 폭 | 2 | 7035, 7036; PDF 2202–2204 |
| far CALL/JMP target offset 폭 미지정 | 4 | 424, 426, 1441, 1443; PDF 239–242, 622–624 |
| 64비트 SYSEXIT/SYSRET size 선택 누락 | 2 | 4538, 4540; PDF 1408, 1411 |
| 지원 모드와 양립하지 않는 64비트 주소 | 31 | MPX 7, ARPL 2, BOUND 4, near CALL/JMP 4, INVPCID 2, LDS/LES 8, PUSH/POP 4; PDF 37–42 및 각 명령의 모드 규정 |

VPMOVQD의 표는 `xmm1/m128`이라 입력과 문자상 일치한다. 그러나 EVEX.128 행의 결과는 doubleword
두 개, 총 64비트다. 같은 페이지의 `Half Mem`, 다음 페이지의 256/128/64비트 memory 목적지 설명과
memory Operation의 `KL=2`가 m64를 지지한다. XMM0/XMM1 소스, K1 merge mask 또는 mask 생략,
세 주소 형태 자체는 맞으며 잘못된 항목은 m128 destination directive다.

VSCATTERDPD도 표의 `vm32y/vm32z`와 source는 문자상 일치한다. Operation은 YMM/ZMM 데이터의
doubleword index를 각각 4개/8개 사용하므로 필요한 index vector 폭은 XMM/YMM이다. 입력은 YMM/ZMM을
썼다. EAX 기반 주소, scale 1, K1 및 source YMM0/ZMM0은 따로 확인했다.
두 가족의 표와 본문 사이 모순은 확인했지만, 공식 정오표로 개정 이력을 확정한 것은 아니다.

far CALL/JMP의 6개 source는 모두 `far ptr [eax]`로 offset 폭을 생략한다. GNU의 현재 64비트 Intel
문맥에서 기본 32비트 offset을 선택하므로 m16:32 행 425/1442는 Description에 맞는 기본형이다.
반면 m16:16과 m16:64 행 424/426/1441/1443에는 맞지 않는다. CSV에서 6개 모두 literal operand는
`underspecified`로, Description 판정은 32비트 기본형 2개와 target 폭 문제 4개로 구분했다.
GNU의 `dword ptr`/`tbyte ptr` 대조는 16/64비트 선택을 보여 주지만, Clang은 이 directive에도 기본
32비트 offset을 선택했다. 따라서 이 치환을 양 도구 공통 해결책으로 제시하지 않는다.
ptr 크기는 [GNU Intel 문법 문서](https://sourceware.org/binutils/docs/as/i386_002dVariations.html)도 대조했다.

SYSEXIT/SYSRET의 명시 오퍼랜드 개수 0개는 네 행 모두 적합하다. 그러나 64비트 user-mode return 행
4538/4540의 bare source에는 REX.W/64비트 operand-size 선택이 없다. 이는 단순한 명시 operand 개수
문제가 아니라 Description에서 요구하는 return 크기를 선택하지 못하는 문제다.
non-REX.W 행 4537/4539는 현재 Clang의 기본 크기로 해당 Description에 맞는다.

## BOUND 6개의 도구별 크기 표기

SDM PDF 223은 bounds operand를 word 또는 doubleword **두 개의 pair**로 정의한다.
총 memory 폭은 r16 행에서 32비트, r32 행에서 64비트다.

| 지원되는 32비트 문맥의 입력 | GNU 2.42 관례 | Clang 18.1.3 관례 |
|---|---|---|
| `bound cx, word ptr [eax]` | 전체 pair 폭에 못 미쳐 거부 | 각 경계값 폭 표기; 올바른 16비트 BOUND 의미 |
| `bound cx, dword ptr [eax]` | 올바른 전체 pair 폭 | 각 경계값 폭과 CX가 맞지 않아 거부 |
| `bound ecx, dword ptr [eax]` | 전체 pair 폭에 못 미쳐 거부 | 각 경계값 폭 표기; 올바른 32비트 BOUND 의미 |
| `bound ecx, qword ptr [eax]` | 올바른 전체 pair 폭 | 각 경계값 폭과 ECX가 맞지 않아 거부 |

따라서 원본 6개에 “ISA memory 총폭 부족”이라는 판정을 공통으로 붙이지 않았다.
GNU와 Clang에 공유하는 입력으로는 크기 표기가 맞지 않으며, Clang의 의미로는 pair를 올바르게 나타낸다.
그중 RAX/RBX 또는 RIP-relative 주소 4개는 이 문법 차이와 별도로 지원 모드에 없는 주소형이므로
최종 집계에서 주소 문제에 들어간다. EAX 주소의 346/347만 도구 관례 차이 항목에 남는다.

## 합치 판정의 주요 근거와 미확인 3개

정상 형태 판정도 각 source를 확인해 내렸다. 특히 MPX mib의 `[rax]`는 index를 생략한 합법적인
형태다(PDF 212/220). BNDMOV는 모드에 따른 m64/m128 pair 폭을 Figure 3-5와 대조했다(PDF 217–218).
LAR/LSL의 비대칭 register는 표와 source 하위16비트 사용 각주, 32/64비트 destination 결과가 같다는
Description에 맞는다(PDF 651/691). 같은 폭의 MOVSXD는 명시된 Valid 행이고 discouraged 각주가
금지 규정은 아니다(PDF 824).

sparse prefetch 16개는 DPS의 16×32-bit index를 ZMM, DPD의 8×32-bit index를 YMM,
QPS/QPD의 8×64-bit index를 ZMM으로 지정했다. EAX 32비트 VSIB base, scale 1, K1 및
T0/T1/read/write mnemonic도 맞는다(PDF 2366–2369/2390–2393). 나머지 가족의 register/폭/주소/implicit
operand 확인 내용은 CSV의 각 입력에 기록했다.

CLRSSBSY/RSTORSSP의 qword memory는 SDM에 맞는다. 새 문법 probe는 Clang이 qword directive를 거부하지만
같은 주소에서 크기를 생략하면 수용함을 보여 준다. 이 차이를 memory operand 자체의 ISA 오류로
분류하지 않았다. MPX, UD0, ERETS/U, INT1, LKGS, MOVSXD와 sparse prefetch의 일부 니모닉/표기 거부도
SDM operand 적합성과 별개다. 해당 도구 버전의 지원 약속까지 검토하지 않았으므로 구현 버그라고 확정하지 않는다.

미확인은 `mov ds, qword ptr [...]`의 combo **1683, 9292, 9293**이다. PDF 731의 행은
`REX.W + 8E /r; Sreg,r/m64; lower 16 bits`여서 원본과 문자상 일치한다. PDF 732는 유효한 segment
selector를 요구하지만 이 메모리 대안의 실제 fetch 폭과 container 표기의 관계를 분명히 해소하지 않는다.
이 쟁점을 닫으려면 Intel의 이 행에 대한 명시적 memory-width 설명 또는 공식 정정이 필요하다.
이전의 제한된 CPU 접근폭 관측은 모든 CPU의 명세를 대신하지 않으며 이번 검토에서는 CPU 실험을 하지 않았다.

정적 합치 판정은 register/memory **값**, 정렬, canonical 주소, CPUID 기능, CPL, CR/MSR 상태,
descriptor/token 유효성까지 보증하지 않는다. 이런 조건은 178개 모두 별도 `runtime_conditions` 열에서
평가하지 않았다고 표시했다. source가 값을 정하지 않는 조건을 오퍼랜드 오류로 과장하지 않았다.

## 검토 산출물 검증

178개 ID의 누락/중복, 원본 source 및 SDM metadata/양 도구 상태·진단의 일치, 최종 집계 합계,
원본 파일 SHA-256 보존과 모든 PDF 증거 참조 페이지의 존재를 검사했고 모두 PASS였다.
[검증 기록](../out/rejected_input_review_2026-09-28/validation.json)에 결과를 남겼다.
별도의 독립 검토에서도 같은 원본 일치·누락/중복 검사와 주요 SDM 원문 대조를 통과했다.
이 검토는 178개 source를 읽는 명시적인 row 규칙과 개별 주소/mask
확인을 재현하는 스크립트이며, 새로운 범용 ISA validator나 전체 DB 커버리지 검증은 아니다.

# 미결 사례 재심 결과

재심일: 2026-09-14. 로컬 Intel SDM 전체에서 관련 페이지를 검색한 후 표 이미지와 본문을 대조했다.
매뉴얼 파일 SHA-256은 `4fc6af6552e4f1c059f32e5a2a9053b31bc728529975bd00f6955023c6346891`이다.
아래 PDF 페이지는 1부터 세는 파일 페이지이며 인쇄된 절/페이지와 함께 적었다.

실측 환경: Intel Core Ultra 5 226V, Linux/WSL x86-64, GNU binutils 2.42, Clang 18.1.3.
정확한 바이너리 경로·버전·해시·CPU flags·명령행·전체 출력은 [원시 기록](../out/review/cases.json)에 있다.
다른 버전/CPU에 그대로 일반화하지 않는다.

## 결론

| 사례 | 현재 분류 | 재심 결과 |
|---|---|---|
| LSS/LFS/LGS r64 | 표시 결함, 확인 | objdump가 80비트 포인터를 48비트 크기로 표시하는 한 유형의 3개 사례 |
| UDB | 지원 차이, 관측 | SDM의 D6 명령 정의는 존재. as/Clang 미지원만으로 구현 결함은 입증되지 않음 |
| MOV Sreg 메모리형 | 지원 차이·명세 표기 쟁점 | 2바이트 접근 대조 실험으로 기존 8바이트 요구 추론을 반박. 구현 버그 주장을 철회 |
| LAR/LSL 대칭 r64 | 동등한 표현·인코딩 선택 차이 | SDM 본문에서 32/64비트 동작 동일 명시. REX.W 생략을 실행 의미 결함으로 집계하지 않음 |

triage의 새 집계는 `bug=3 / false_alarm=1558 / unsure=24`다.
`bug=3`은 표시 결함 한 유형의 세 사례다. 별개의 코드상 근본 원인 3개를 입증한 것은 아니다.
전량 재심을 마친 것은 아니며 나머지 행은 `review_status=not_reassessed`로 구분한다.

## A. LSS/LFS/LGS

SDM PDF 658, 인쇄 Vol.2A 3-540의 Description은 REX.W 형식의 메모리가 80비트 포인터라고 명시한다.
표도 `r64,m16:64`이며, 16비트 셀렉터와 64비트 오프셋을 합친 크기다.
GNU의 Intel syntax 문서는 `fword ptr`/`tbyte ptr`를 48/80비트 메모리로 정의한다.
[GNU as 문법 문서](https://sourceware.org/binutils/docs/as/i386_002dVariations.html)

| 입력 | GNU as 바이트 | GNU objdump 표시 |
|---|---|---|
| `lss cx, dword ptr [eax]` | `67 66 0f b2 08` | cx, DWORD PTR |
| `lss ecx, fword ptr [eax]` | `67 0f b2 08` | ecx, FWORD PTR |
| `lss rcx, tbyte ptr [eax]` | `67 48 0f b2 08` | rcx, FWORD PTR |

REX.W는 `48`에 있고 `0F B2 /r`가 LSS다. LFS/LGS도 각각 `0F B4`/`0F B5`에서 같은 패턴을 재현했다.
Clang은 올바른 입력에서 같은 바이트를 생성한다. 여기서 Clang 오브젝트도 GNU objdump로 해독했으므로,
그 출력 두 개가 같다는 것은 독립 역어셈블러 교차검증이 아니다.

반론 중 “표시가 이미 생성된 기계어의 CPU 동작을 바꾸지 않는다”는 부분은 맞다.
그렇더라도 바이트가 뜻하는 메모리 크기와 설명이 모순되는 것은 objdump의 표시 기능 결함이다.
왕복 거부는 추가 영향 증거이며 단독 판정 근거가 아니다. GNU objdump가 모든 출력을 재어셈블 가능한
원본 소스로 복구한다고 가정하지 않는다. [GNU objdump 문서](https://sourceware.org/binutils/docs/binutils/objdump.html)

영향: 사람이 출력 크기를 오해하거나 출력을 재어셈블 입력으로 재사용할 때 실패할 수 있다.
우회: 원본 바이트와 SDM을 함께 확인하고, 해당 r64 메모리 표기는 TBYTE PTR로 확인한다.
LSS/LFS/LGS를 실제 CPU에서 실행한 결과나 최신 binutils에서의 존속 여부는 이번에 확인하지 않았다.

## B. MOV Sreg

SDM PDF 731~734, 인쇄 Vol.2B 4-28~4-31을 대조했다. 표에는 `REX.W + 8E /r MOV Sreg,r/m64`가 있고,
Description은 하위 16비트를 세그먼트 레지스터로 옮긴다고 적는다. 반대 방향 8C 행은 `r64/m16`을 구분해 적는다.
본문의 일반적인 REX.W 설명만으로 8E 메모리 읽기 폭이 64비트라고 확정할 수 없으며,
이 페이지들에서 “8E에서 REX.W는 항상 무효”라는 명시적 문장을 찾았다고 주장하지 않는다.

`mov ds, qword ptr [rax]`는 양 어셈블러가 거부하고 `word ptr`는 수용한다.
실제 읽기 폭을 구분하기 위해 인접한 두 페이지 중 뒤를 `PROT_NONE`으로 설정하고 앞 페이지에 null selector를 둔다.
고정 실험은 자식 프로세스에서만 DS를 변경하며, SIGSEGV의 주소가 보호 페이지 시작인지도 확인한다.

| 명령 바이트 (주소는 RDI) | 읽을 수 있는 1바이트 | 2바이트 | 8바이트 |
|---|---|---|---|
| `8e 1f` | SIGSEGV, 보호 페이지 주소 | 성공 | 성공 |
| `66 8e 1f` | SIGSEGV, 보호 페이지 주소 | 성공 | 성공 |
| `48 8e 1f` | SIGSEGV, 보호 페이지 주소 | 성공 | 성공 |
| 64비트 일반 MOV 대조군 | SIGSEGV, 보호 페이지 주소 | SIGSEGV, 보호 페이지 주소 | 성공 |

12개 대조 결과는 이 환경에서 세 8E 형식이 2바이트 접근으로 완료됨을 지지한다.
“SDM r/m64이므로 이 입력은 반드시 8바이트를 읽어야 하며, qword 거부는 버그”라는 기존 추론을 철회한다.
단, 8C/8E 표기 차이가 공식적으로 오탈자인지, 모든 CPU에서도 같은 관측인지까지 해결하지는 않았다.
최종 보고에서는 구현 결함 주장은 기각하고, 문법 지원 차이와 남은 명세 표기 쟁점을 기록한다.

## C. UDB

PDF 전체 텍스트의 `UDB` 검색은 PDF 1436과 2447에서 일치했다.
PDF 1436, 인쇄 Vol.2B 4-733은 UD 명령 설명 항목이다. UDB는 UD0/UD1/UD2와 같은 표에서
`D6 / UDB / 64-bit Valid / Compat N.E.`로 등장하며 Operation은 `#UD`다.
Exceptions 문단은 UDB가 64비트 모드에서 예외를 발생시킨다는 예외 조건을 명시한다.
PDF 2447의 opcode map 각주 1B도 의도적으로 #UD를 발생시키는 D6를 UDB instruction이라고 부른다.

따라서 “UDB는 정의되지 않은 모든 명령어를 가리키는 라벨일 뿐”이라는 설명은 맞지 않는다.
다만 그 명령 정의가 있다는 사실은 과거 버전의 GNU as가 해당 니모닉을 반드시 지원한다는 약속과 다르다.
현재 도구의 `udb` 거부를 `support_gap`으로 기록하며, 지원 약속 위반 또는 회귀 증거가 없어 구현 버그 집계에서 제외한다.

대조군은 `ud0`, `ud0 eax,eax`, `ud1 eax,eax`, `ud2`, `.byte 0xd6`다.
GNU as는 명시적 2오퍼랜드 UD0와 UD1, UD2를 수용한다. Clang 18.1.3은 UD0 니모닉을 거부하지만 UD1/UD2는 수용한다.
`.byte 0xd6`는 양 도구에서 D6를 만들며 GNU objdump 2.42의 64비트 해독은 `(bad)`다.
이 바이트를 CPU에서 실행하지는 않았다. `Z0`/`ZO`의 글자 차이는 정의 존재 여부를 바꾸는 증거로 쓰지 않는다.

## D. LAR/LSL — 기존 설명의 추가 정정

PDF 651/691, 인쇄 Vol.2A 3-533/3-573은 32비트 결과의 상위 비트를 지우는 경우와
64비트로 zero-extend하는 경우를 설명하면서 두 operand size의 동작이 동일하다고 명시한다.
메모리 소스는 16비트만 접근하며, 레지스터 소스도 하위 16비트 selector를 사용한다.
따라서 “REX.W 하나로 두 레지스터 폭을 독립 지정할 수 없어 비대칭 표기는 불가능”이라는 일반론은
이 명령의 소스/목적지 의미를 설명하는 충분한 논거가 아니었다.

PDF 651의 렌더링을 다시 확인하면 LAR 표의 2·3번째 행 모두에 각주 1이 있다.
과거 기록의 “각주 1이 2번째 행에만 있고 3번째 행에는 없다”는 설명도 정정한다.
표를 어떤 입력 문법으로 지원할지는 별도 문제이며, 본문이 명시한 실행 의미를 우선 대조했다.

`lar rcx,rcx`/`lsl rcx,rcx`는 as에서 REX.W 없이, Clang에서 REX.W를 붙여 인코딩된다.
이 차이를 자동으로 실행 의미 결함이라고 부르지 않는다.
null·CS·SS·범위 밖 selector의 네 조건에 대해 두 명령의 raw 32/64비트 형식을 비교한 8개 실험에서
목적지 값과 ZF가 같았다. 실패 시 초기 목적지 `0x123456789abcdef0`도 보존됐다.
LAR의 SDM상 undefined인 bits 19:16은 성공 결과 동등성 비교에서 제외했다.

동작을 시험하려는 목적에서는 동등 표현으로 분류한다. 특정 REX.W 인코딩 행을 시험하려는 목적에서는
그 행이 선택되지 않았음을 별도로 기록한다. `data/cases.csv`에 대칭 r64 사례를 등록하고 13단계에서 검사한다.

## 재현과 남은 범위

```bash
python3 scripts/review_cases.py
python3 -m unittest discover -s tests -p 'test_*.py' -v
python3 pipeline/run.py --only triage
python3 pipeline/run.py --only lint
```

`tests/review_cpu_cases.c`는 제한된 고정 실험이다. 전체 7,276개 명령어를 실행하거나 모든 CPU/OS 조건을 검증하지 않는다.
최신 버전 비교, 공식 정오표/지원 이력, 다른 unsure 사례는 후속 검증 범위로 남긴다.
이번에 얻지 못한 근거를 근거가 있는 것처럼 확정 수에 넣지 않는다.

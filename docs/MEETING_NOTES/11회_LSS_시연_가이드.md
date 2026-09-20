# LSS/LFS/LGS 시연 가이드 (11회 보고 라이브 데모)

확인: 2026-09-20 · Ubuntu 24.04(WSL2) · GNU Binutils 2.42 · Clang 18.1.3 · LLVM 18

아래 출력은 **2026-09-20에 이 환경에서 실제로 실행한 결과 그대로**다. 붙여 넣은 예상값이 아니다.

## 한 문장 요약

objdump가 REX.W 형식 LSS/LFS/LGS를 `FWORD PTR`(48비트)로 표시하는데,
SDM의 `m16:64`는 80비트이고, **objdump가 보여준 그 줄을 같은 어셈블러에 다시 넣으면 거부된다.**

```
SDM Vol.2 p.658    REX.W + 0F B2 /r    LSS r64, m16:64    Valid
                                                  └ 16 + 64 = 80비트 (TBYTE)
```

## 시연 절차 (4단계, 약 1분)

```bash
cd $(mktemp -d)

# 1) SDM 표기대로 조립 — 수용되고 REX.W 바이트가 나온다
printf '.intel_syntax noprefix\n.text\nlss rcx, tbyte ptr [rax]\n' > s1.s
as --64 -mintel64 s1.s -o s1.o && echo "수용"
objdump -d -M intel s1.o | tail -1

# 2) objdump의 표시
#    0:  48 0f b2 08    lss    rcx,FWORD PTR [rax]      ← FWORD = 48비트

# 3) 그 줄을 그대로 다시 조립
printf '.intel_syntax noprefix\n.text\nlss rcx,FWORD PTR [rax]\n' > s2.s
as --64 -mintel64 s2.s -o s2.o        # 거부된다

# 4) llvm-objdump와 비교
llvm-objdump-18 -d --x86-asm-syntax=intel s1.o | tail -1
```

### 실제 출력

```
### 1) SDM 표기대로 조립 — 수용되고 REX.W 바이트가 나온다
종료코드=0 (수용)
0000000000000000 <.text>:
   0:	48 0f b2 08          	lss    rcx,FWORD PTR [rax]

### 3) objdump가 보여준 그 줄을 다시 조립하면
s2.s: Assembler messages:
s2.s:3: Error: incorrect register `rcx' used with `l' suffix
종료코드=1

### 4) llvm-objdump는 같은 바이트를 어떻게 표시하나
       0: 48 0f b2 08                  	lss	rcx, [rax]
그 출력은 다시 조립된다
```

**핵심:** llvm-objdump는 크기를 **적지 않아서** 틀린 크기를 적지 않고, 그 출력은 다시 조립된다.
"llvm-objdump가 올바른 크기를 표시한다"고 말하면 틀린다. 크기 표기를 생략할 뿐이다.

## 버전별 재현 (2026-09-20 소스 빌드로 확인)

시스템 도구는 그대로 두고 스크래치패드에 빌드해서 같은 명령으로 관측했다.

| binutils | objdump 표시 | 그 출력 재조립 | `tbyte` 입력 조립 | UDB |
|---|---|---|---|---|
| 2.42 (Ubuntu 기본) | `lss rcx,FWORD PTR [rax]` | 거부 | 수용 `48 0f b2 08` | 거부 |
| 2.45 | 같음 | 거부 | 수용 | 거부 |
| 2.46.1 | 같음 | 거부 | 수용 | **수용** |
| 2.47.20260726 | 같음 | 거부 | 수용 | **수용** |

- **LSS 결함은 최신 2.47에도 남아 있다.**
- **UDB는 2.46.1부터 수용된다** → 버그가 아니라 버전 간 지원 차이.

재현 방법:

```bash
curl -O https://ftp.gnu.org/gnu/binutils/binutils-2.47.tar.xz
tar xf binutils-2.47.tar.xz && mkdir build && cd build
../binutils-2.47/configure --disable-gdb --disable-sim --disable-gprofng \
    --disable-nls --disable-werror --disable-ld --target=x86_64-linux-gnu
make -j8 all-gas all-binutils          # 약 2분
./gas/as-new --64 -mintel64 s1.s -o s1.o && ./binutils/objdump -d -M intel s1.o
```

## 함께 알아 둘 것 (질문이 나올 수 있는 지점)

1. **`-mintel64` 없이는 as가 SDM 표기도 거부한다.**
   `as --64`만 주면 `lss rcx, tbyte ptr [rax]`가 `operand size mismatch`로 거부된다.
   우리 파이프라인은 `--64 -mintel64`로 고정해 돌린다. "어셈블러가 거부했다"는 말은 옵션까지 적어야 한다.
2. **Clang은 크기 표기에 관대하다.** `lss rcx, [rax]`, `... FWORD PTR ...`, `... TBYTE PTR ...`를
   모두 받아들여 같은 `48 0f b2 08`을 만든다. 엄격도 차이지 결함은 아니다.
3. **LFS(0F B4)·LGS(0F B5)도 같은 증상이다.** 서로 다른 버그 3개가 아니라 한 결함의 세 명령어다.
4. **아직 binutils에 보고하지 않았다.** 기존 보고 검색도 하지 않았다. 교수님 승인 후 진행할 항목이다.

## 파이프라인 안에서의 위치

이 사례는 6단계(roundtrip)의 `different`와 10단계(재조립 검증)로 자동 검출된다.

```
combo 1527  lss rcx, tbyte ptr [eax]
  5단계  as 수용        67 48 0f b2 08          (67 = 32비트 주소 프리픽스)
  6단계  objdump        lss rcx,FWORD PTR [eax]   → different
  7단계  triage         verdict=bug, category=far_pointer_display,
                        review_status=confirmed, 근거=docs/CASE_REVIEW_2026-09-14.md
```

`out/triage.csv`에서 `verdict=bug`인 행은 이 세 개(lss 1527 / lfs 1532 / lgs 1535)뿐이다.

`review_verdicts.py`가 combo 1527/1532/1535의 소스 문자열을 고정하고 있어, 생성기를 고쳐도
이 세 사례의 입력은 바뀌지 않는다(재심 근거 보존).

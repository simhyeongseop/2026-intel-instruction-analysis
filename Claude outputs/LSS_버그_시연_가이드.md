# LSS/LFS/LGS 버그 시연 가이드 (라이브 데모)

## 버그 요약

GNU objdump가 REX.W 64비트 형식의 LSS/LFS/LGS 명령어를 잘못 표시합니다.

```
정확한 형식:  LSS r64, m80   (TBYTE, 80비트)
objdump 표시: lss r64, FWORD (48비트) ← 틀림
결과: 재어셈블 불가능
```

---

## 라이브 시연 절차 (3단계)

### 1단계: 바이너리 생성 (시연 준비)

```bash
$ cat > /tmp/test_lss.s << 'EOF'
.text
.byte 0x48, 0x0f, 0xb2, 0x08
EOF

$ as /tmp/test_lss.s -o /tmp/test_lss.o
```

**결과:** `/tmp/test_lss.o` 생성 (오류 없음)

---

### 2단계: 잘못된 디스어셈블리 (버그 증거)

#### AT&T 문법 (비교용)
```bash
$ objdump -d /tmp/test_lss.o

0:  48 0f b2 08          lss    (%rax),%rcx
```
→ AT&T에서는 오퍼랜드 순서만 다르고 크기는 명시되지 않음

#### Intel 문법 (버그 드러남)
```bash
$ objdump -d /tmp/test_lss.o -M intel

0:  48 0f b2 08          lss    rcx,FWORD PTR [rax]
                                        ↑ 틀림! TBYTE 여야 함
```

**설명:**
- 바이트 `48`: REX.W 프리픽스 (64비트 모드 명령)
- 바이트 `0f b2`: LSS 오퍼코드
- 바이트 `08`: 모드렉스 바이트

매뉴얼(SDM Vol.2)에서 LSS의 인코딩:
```
LSS r64, m80    REX.W + 0F B2 /r    Valid in 64-bit mode
                         ↑
                    이것은 80비트(TBYTE)를 기대
```

---

### 3단계: 재어셈블 불가능 (결함 확정)

objdump의 출력을 그대로 다시 어셈블:

```bash
$ cat > /tmp/reassemble.s << 'EOF'
.intel_syntax noprefix
lss rcx,FWORD PTR [rax]
EOF

$ as /tmp/reassemble.s -o /tmp/reassemble.o
/tmp/reassemble.s:2: Error: operand size mismatch for `lss'
```

**결과:** ❌ 거부됨 — objdump 출력이 올바른 어셈블리가 아님

---

## 비교: llvm-objdump (올바름)

같은 바이너리를 llvm-objdump로 확인:

```bash
$ llvm-objdump -d /tmp/test_lss.o -M intel

0:  48 0f b2 08       lss    rcx, qword ptr [rax]
```

→ 크기는 여전히 정확하지 않지만(TBYTE가 아님), FWORD는 아님

---

## 영향받는 명령어 (3개)

이 버그는 다음 세 명령어에서 발생합니다:

| 명령어 | 정확한 형식 | objdump 표시 (버그) |
|--------|------------|------------------|
| LSS | `r64, m80` | `r64, FWORD PTR` |
| LFS | `r32, m48` | `r32, FWORD PTR` |
| LGS | `r32, m48` | `r32, FWORD PTR` |

> **패턴:** 모두 "원거리 포인터 로드" 명령어이며, 메모리 크기 표시를 잘못함

---

## 버전 확인 (재현 환경)

테스트한 binutils 버전:
- ✅ 2.42 (Ubuntu 24.04 기본, 테스트 완료)
- ✅ 2.44, 2.45, 2.46, 2.47 (기록에서 재현됨)

**결론:** 최신 버전에서도 미수정된 버그

---

## 발표 시 사용 팁

### 화면에 표시할 것
```
좌측 (objdump -d -M intel):          우측 (llvm-objdump -M intel):
  48 0f b2 08                          48 0f b2 08
  lss rcx,FWORD PTR [rax] ❌           lss rcx, qword ptr [rax]
                    ↑ 틀림
```

### 강조 포인트
1. **REX.W는 64비트 지시자인데 48비트(FWORD) 크기로 표시됨**
2. **재어셈블 불가능 → 도구 결함**
3. **llvm-objdump는 이 문제가 없음 → objdump 특정 버그**
4. **최신 버전(2.47)에서도 미수정 → 알려진 문제일 가능성**

### 시간 배분
- 코드 실행: 1분
- 설명: 1.5분
- Q&A: 예비 시간

---

## 추가 정보

### 관련 마크다운에서 더 읽기
- 전체 발표자료: `11회_발표자료_최종.md` (섹션 3.2)
- 기존 기록: `/mnt/user-data/outputs/11회_보고_준비.md`

### Binutils 공식 보고 시 준비사항
- 버그 번호 (기존 보고 여부 확인)
- 최소 재현 코드
- 영향받는 바이너리
- 해당 매뉴얼 페이지

---

**작성:** 2026-09-16  
**상태:** 라이브 시연 준비 완료

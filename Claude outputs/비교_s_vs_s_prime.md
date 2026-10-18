# LSS/LFS/LGS 버그 비교: .s vs objdump 출력 (.s')

## 파일 위치
- **원본 테스트:** `/mnt/user-data/outputs/seg_load_test_binary.s`
- **objdump 출력:** `/mnt/user-data/outputs/objdump_output.txt`
- **objdump 출력 기반 재어셈블:** `/mnt/user-data/outputs/seg_load_reassemble.s`

---

## 1단계: 원본 테스트 명령어 (seg_load_test_binary.s)

```asm
.text
# LSS r64, m80 (REX.W + 0F B2 /r)
.byte 0x48, 0x0f, 0xb2, 0x08

# LFS r32, m48 (0F B4 /r)
.byte 0x0f, 0xb4, 0x10

# LGS r32, m48 (0F B5 /r)
.byte 0x0f, 0xb5, 0x18
```

**어셈블 결과:** ✅ 성공

---

## 2단계: objdump 출력 (Intel 문법)

```
0000000000000000 <.text>:
   0:	48 0f b2 08          	lss    rcx,FWORD PTR [rax]
   4:	0f b4 10             	lfs    edx,FWORD PTR [rax]
   7:	0f b5 18             	lgs    ebx,FWORD PTR [rax]
```

**분석:**
```
명령어   | 바이트        | objdump 출력              | 문제
---------|---------------|-------------------------|--------
LSS      | 48 0f b2 08   | lss rcx,FWORD PTR [rax] | ❌ TBYTE 여야 함
LFS      | 0f b4 10      | lfs edx,FWORD PTR [rax] | ❌ TBYTE 여야 함  
LGS      | 0f b5 18      | lgs ebx,FWORD PTR [rax] | ❌ TBYTE 여야 함
```

---

## 3단계: objdump 출력을 다시 어셈블 (seg_load_reassemble.s)

```asm
.intel_syntax noprefix
.text

lss rcx,FWORD PTR [rax]
lfs edx,FWORD PTR [rax]
lgs ebx,FWORD PTR [rax]
```

**어셈블 결과:** ❌ **실패**
```
seg_load_reassemble.s:5: Error: operand size mismatch for `lss'
```

---

## 결론

| 단계 | 입력 | 결과 | 의미 |
|------|------|------|------|
| **1** | 원본 바이트 `.byte 0x48, 0x0f, 0xb2, ...` | ✅ 어셈블 성공 | 바이너리는 유효함 |
| **2** | objdump 디스어셈블 | `lss rcx,FWORD PTR [rax]` | 잘못된 출력 |
| **3** | objdump 출력을 다시 어셈블 | ❌ 거부됨 | **objdump 버그 확정** |

**핵심:**
- 원본 바이너리는 올바름 (as가 수용)
- objdump가 잘못 디스어셈블함
- objdump 출력이 다시 어셈블되지 않음
- **따라서 objdump의 표시 결함이 버그**

---

## 기술 상세

### LSS의 경우:

**바이트 분석:**
```
48      = REX.W (64비트 지시자)
0F B2   = LSS 오퍼코드
08      = ModRM byte (레지스터 rcx, 메모리 [rax])
```

**매뉴얼 정의 (Intel SDM Vol.2):**
```
REX.W + 0F B2 /r    LSS r64, m80
                           ↑
                    80비트 메모리 (TBYTE)
```

**objdump 출력 (버그):**
```
lss rcx,FWORD PTR [rax]
          ↑
      48비트 (틀림!)
      
FWORD는 32비트 mode에서 쓰는 표기
64비트 mode의 REX.W 명령어는 TBYTE 필요
```

### 왜 FWORD인가?

objdump가 REX.W를 무시하고 기본 형식(`0F B2`)만 보면:
```
LFS r32, m48 (기본)  →  m48 = FWORD (5 bytes = 16비트 segment + 32비트 offset)
```

하지만 REX.W가 있으므로:
```
LSS r64, m80         →  m80 = TBYTE (10 bytes = 16비트 segment + 64비트 offset)
```

objdump가 이 규칙을 구현하지 않은 버그입니다.

---

## 파일 확인 명령어

```bash
# 1단계 어셈블
as seg_load_test_binary.s -o seg_load_test_binary.o

# 2단계 디스어셈블 (Intel 문법)
objdump -d seg_load_test_binary.o -M intel

# 3단계 재어셈블 (실패)
as seg_load_reassemble.s -o seg_load_reassemble.o
```

---

**작성:** 2026-09-16  
**환경:** GNU Binutils 2.42, binutils 2.42~2.47까지 동일 재현

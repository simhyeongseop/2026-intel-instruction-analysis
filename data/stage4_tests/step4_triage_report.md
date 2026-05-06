# Step 4 에러 Triage 보고서

**대상 파일**: `test_all_instructions.s`  
**총 에러 수**: 89개  
**컴파일러**: GNU as (`-mintel64` 통과), GCC, Clang  

---

## 1. 에러 카테고리별 분포

| 카테고리 | 설명 | 건수 | 비율 |
|----------|------|-----:|-----:|
| `other` | 기타 에러 | 89 | 100.0% |

---

## 2. 카테고리별 대표 예제 (다음 미팅 준비물)

### 2.1 `other` — 기타 에러 (89건)

**예제 1**: `CALL rel32` 블록
```asm
call .  # [ERROR] unknown token in expression
```

**예제 2**: `ERETS` 블록
```asm
erets  # [ERROR] invalid instruction mnemonic 'erets'
```

**예제 3**: `ERETU` 블록
```asm
eretu  # [ERROR] invalid instruction mnemonic 'eretu'
```


---

## 3. 주요 니모닉별 에러 발생 빈도 (TOP 20)

| 니모닉 | 에러 수 |
|--------|--------:|

---

## 4. 64비트 모드 미지원 명령어 목록


---

## 5. GCC vs Clang 비교

```
category  other
compiler       
clang        89
```

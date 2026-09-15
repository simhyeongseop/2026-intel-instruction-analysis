# Stage 5 Roundtrip 비교 리포트

- 비교 행: 4635
- 정상(일치/별칭/표기차/상대주소): 4523 (97.58%)
- 검토 대상: 112

## 카테고리별 분포

| 카테고리 | 건수 |
|---|---:|
| exact_match | 4197 |
| alias | 131 |
| string_alias | 86 |
| operand_changed | 72 |
| operand_repr_changed | 66 |
| mnemonic_changed | 29 |
| pseudo_op | 28 |
| implicit_operand | 15 |
| register_width_changed | 11 |

## 검토 대상 샘플 (최대 25)

- `call 1f`  →  `call 0x541a`  (operand_changed)
- `ja 1f`  →  `ja 0x541a`  (operand_changed)
- `jae 1f`  →  `jae 0x541a`  (operand_changed)
- `jb 1f`  →  `jb 0x541a`  (operand_changed)
- `jbe 1f`  →  `jbe 0x541a`  (operand_changed)
- `jc 1f`  →  `jb 0x541a`  (operand_changed)
- `je 1f`  →  `je 0x541a`  (operand_changed)
- `jg 1f`  →  `jg 0x541a`  (operand_changed)
- `jge 1f`  →  `jge 0x541a`  (operand_changed)
- `jl 1f`  →  `jl 0x541a`  (operand_changed)
- `jle 1f`  →  `jle 0x541a`  (operand_changed)
- `jna 1f`  →  `jbe 0x541a`  (operand_changed)
- `jnae 1f`  →  `jb 0x541a`  (operand_changed)
- `jnb 1f`  →  `jae 0x541a`  (operand_changed)
- `jnbe 1f`  →  `ja 0x541a`  (operand_changed)
- `jnc 1f`  →  `jae 0x541a`  (operand_changed)
- `jne 1f`  →  `jne 0x541a`  (operand_changed)
- `jng 1f`  →  `jle 0x541a`  (operand_changed)
- `jnge 1f`  →  `jl 0x541a`  (operand_changed)
- `jnl 1f`  →  `jge 0x541a`  (operand_changed)
- `jnle 1f`  →  `jg 0x541a`  (operand_changed)
- `jno 1f`  →  `jno 0x541a`  (operand_changed)
- `jnp 1f`  →  `jnp 0x541a`  (operand_changed)
- `jns 1f`  →  `jns 0x541a`  (operand_changed)
- `jnz 1f`  →  `jne 0x541a`  (operand_changed)

# Stage 5 Roundtrip 비교 리포트

- 비교 행: 4642
- 정상(일치/별칭/표기차/상대주소): 4571 (98.47%)
- 검토 대상: 71

## 카테고리별 분포

| 카테고리 | 건수 |
|---|---:|
| exact_match | 4179 |
| alias | 131 |
| string_alias | 85 |
| relative_target | 67 |
| operand_repr_changed | 66 |
| mnemonic_changed | 35 |
| pseudo_op | 28 |
| operand_changed | 24 |
| implicit_operand | 15 |
| register_width_changed | 9 |
| missing_disasm | 3 |

## 검토 대상 샘플 (최대 25)

- `lkgs ax`  →  `lkgs eax`  (register_width_changed)
- `lldt ax`  →  `lldt eax`  (register_width_changed)
- `lock`  →  `lock lods al,BYTE PTR ds:[rsi]`  (operand_changed)
- `lodsq`  →  `loop 0x1109`  (mnemonic_changed)
- `loop .`  →  `loope 0x110b`  (mnemonic_changed)
- `loope .`  →  `loopne 0x110d`  (mnemonic_changed)
- `loopne .`  →  ``  (missing_disasm)
- `ltr ax`  →  `ltr eax`  (register_width_changed)
- `mov rax, ds`  →  `mov eax,ds`  (register_width_changed)
- `mov ds, ax`  →  `mov ds,eax`  (register_width_changed)
- `mov ds, rax`  →  `mov ds,eax`  (register_width_changed)
- `movsxd ax, ax`  →  `movsxd ax,eax`  (register_width_changed)
- `prefetchit0 BYTE PTR [rax]`  →  `nop DWORD PTR [rax]`  (mnemonic_changed)
- `prefetchit1 BYTE PTR [rax]`  →  `nop DWORD PTR [rax]`  (mnemonic_changed)
- `verr ax`  →  `verr eax`  (register_width_changed)
- `verw ax`  →  `verw eax`  (register_width_changed)
- `vgatherdpd xmm1, [rax+xmm2*1], xmm2`  →  `vgatherdpd xmm1,QWORD PTR [rax+xmm2*1]/(bad),xmm2/(bad)`  (operand_changed)
- `vgatherqpd xmm1, [rax+xmm2*1], xmm2`  →  `vgatherqpd xmm1,QWORD PTR [rax+xmm2*1]/(bad),xmm2/(bad)`  (operand_changed)
- `vgatherdpd ymm1, [rax+xmm2*1], ymm2`  →  `vgatherdpd ymm1,QWORD PTR [rax+xmm2*1]/(bad),ymm2/(bad)`  (operand_changed)
- `vgatherqpd ymm1, [rax+ymm2*1], ymm2`  →  `vgatherqpd ymm1,QWORD PTR [rax+ymm2*1]/(bad),ymm2/(bad)`  (operand_changed)
- `vgatherdps xmm1, [rax+xmm2*1], xmm2`  →  `vgatherdps xmm1,DWORD PTR [rax+xmm2*1]/(bad),xmm2/(bad)`  (operand_changed)
- `vgatherqps xmm1, [rax+xmm2*1], xmm2`  →  `vgatherqps xmm1,DWORD PTR [rax+xmm2*1]/(bad),xmm2/(bad)`  (operand_changed)
- `vgatherdps ymm1, [rax+ymm2*1], ymm2`  →  `vgatherdps ymm1,DWORD PTR [rax+ymm2*1]/(bad),ymm2/(bad)`  (operand_changed)
- `vgatherqps xmm1, [rax+ymm2*1], xmm2`  →  `vgatherqps xmm1,DWORD PTR [rax+ymm2*1]/(bad),xmm2/(bad)`  (operand_changed)
- `vpcmpb k1{k2}, xmm2, xmm3, 0x1`  →  `vpcmpltb k1{k2},xmm2,xmm3`  (mnemonic_changed)

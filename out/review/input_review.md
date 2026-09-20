# 생성 입력 확인표

판정은 들어 있지 않다. 각 항목을 보고 직접 ☐ 에 표시하면 된다.

항목 12개

### combo 24463 · VPERMT2B · 변형 distinct_regs

- 매뉴얼 원문: `VPERMT2B zmm1 {k1}{z}, zmm2, zmm3/m512`  (PDF 1995쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 생성된 줄: `vpermt2b zmm0, zmm1, zmmword ptr [eax]`
- as 결과: **accepted** / 바이트 `67 62 f2 75 48 7d 00`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvpermt2b zmm0, zmm1, zmmword ptr [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 22760 · VPSRAW · 변형 distinct_regs

- 매뉴얼 원문: `VPSRAW zmm1 {k1}{z}, zmm2, xmm3/m128`  (PDF 1158쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 생성된 줄: `vpsraw zmm0, zmm1, xmm0`
- as 결과: **accepted** / 바이트 `62 f1 75 48 e1 c0`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvpsraw zmm0, zmm1, xmm0\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 23467 · VFIXUPIMMPD · 변형 distinct_regs

- 매뉴얼 원문: `VFIXUPIMMPD xmm1 {k1}{z}, xmm2, xmm3/m128/m64bcst, imm8`  (PDF 1653쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 생성된 줄: `vfixupimmpd xmm0, xmm1, xmm2, 1`
- as 결과: **accepted** / 바이트 `62 f3 f5 08 54 c2 01`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvfixupimmpd xmm0, xmm1, xmm2, 1\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 23244 · VUNPCKHPD · 변형 distinct_regs

- 매뉴얼 원문: `VUNPCKHPD xmm1 {k1}{z}, xmm2, xmm3/m128/m64bcst`  (PDF 1443쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 생성된 줄: `vunpckhpd xmm0, xmm1, xmmword ptr [eax]`
- as 결과: **accepted** / 바이트 `67 c5 f1 15 00`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvunpckhpd xmm0, xmm1, xmmword ptr [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 20901 · ADD · 변형 distinct_regs

- 매뉴얼 원문: `ADD r/m16, r16`  (PDF 132쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 생성된 줄: `add cx, dx`
- as 결과: **accepted** / 바이트 `66 01 d1`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nadd cx, dx\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 24638 · VPSHLDW · 변형 distinct_regs

- 매뉴얼 원문: `VPSHLDW xmm1{k1}{z}, xmm2, xmm3/m128, imm8`  (PDF 2084쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 생성된 줄: `vpshldw xmm0, xmm1, xmm2, 1`
- as 결과: **accepted** / 바이트 `62 f3 f5 08 70 c2 01`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvpshldw xmm0, xmm1, xmm2, 1\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 24206 · VPBROADCASTB · 변형 distinct_regs

- 매뉴얼 원문: `VPBROADCASTB xmm1{k1}{z}, xmm2/m8`  (PDF 1904쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 생성된 줄: `vpbroadcastb xmm0, xmm1`
- as 결과: **accepted** / 바이트 `c4 e2 79 78 c1`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvpbroadcastb xmm0, xmm1\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 23869 · VFMSUBADD231PH · 변형 distinct_regs

- 매뉴얼 원문: `VFMSUBADD231PH ymm1{k1}{z}, ymm2, ymm3/m256/m16bcst`  (PDF 1754쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 생성된 줄: `vfmsubadd231ph ymm0, ymm1, ymm2`
- as 결과: **accepted** / 바이트 `62 f6 75 28 b7 c2`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvfmsubadd231ph ymm0, ymm1, ymm2\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 24361 · VPERMD · 변형 distinct_regs

- 매뉴얼 원문: `VPERMD ymm1, ymm2, ymm3/m256`  (PDF 1962쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 생성된 줄: `vpermd ymm0, ymm1, ymmword ptr [eax]`
- as 결과: **accepted** / 바이트 `67 c4 e2 75 36 00`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvpermd ymm0, ymm1, ymmword ptr [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 24071 · VGATHERDPD · 변형 distinct_regs

- 매뉴얼 원문: `VGATHERDPD xmm1, vm32x, xmm2`  (PDF 1820쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 생성된 줄: `vgatherdpd xmm0, [eax + xmm1], xmm1`
- as 결과: **accepted** / 바이트 `67 c4 e2 f1 92 04 08`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvgatherdpd xmm0, [eax + xmm1], xmm1\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 21462 · VHSUBPS · 변형 distinct_regs

- 매뉴얼 원문: `VHSUBPS ymm1, ymm2, ymm3/m256`  (PDF 563쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 생성된 줄: `vhsubps ymm0, ymm1, ymmword ptr [eax]`
- as 결과: **accepted** / 바이트 `67 c5 f7 7d 00`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvhsubps ymm0, ymm1, ymmword ptr [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 22592 · VPMULUDQ · 변형 distinct_regs

- 매뉴얼 원문: `VPMULUDQ xmm1, xmm2, xmm3/m128`  (PDF 1098쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 생성된 줄: `vpmuludq xmm0, xmm1, xmm2`
- as 결과: **accepted** / 바이트 `c5 f1 f4 c2`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvpmuludq xmm0, xmm1, xmm2\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 


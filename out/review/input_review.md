# 생성 입력 확인표

판정은 들어 있지 않다. 각 항목을 보고 직접 ☐ 에 표시하면 된다.

항목 60개

### combo 143 · AESDEC256KL

- 매뉴얼 원문: `AESDEC256KL xmm, m512`  (PDF 155쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `aesdec256kl xmm0, zmmword ptr [eax]`
- 생성된 줄: `aesdec256kl xmm0, [eax]`
- as 결과: **accepted** / 바이트 `67 f3 0f 38 df 00`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\naesdec256kl xmm0, [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 156 · AESDECWIDE128KL

- 매뉴얼 원문: `AESDECWIDE128KL m384, <XMM0-7>`  (PDF 159쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `aesdecwide128kl [eax], xmm0`
- 생성된 줄: `aesdecwide128kl [eax]`
- as 결과: **accepted** / 바이트 `67 f3 0f 38 d8 08`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\naesdecwide128kl [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 157 · AESDECWIDE256KL

- 매뉴얼 원문: `AESDECWIDE256KL m512, <XMM0-7>`  (PDF 161쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `aesdecwide256kl zmmword ptr [eax], xmm0`
- 생성된 줄: `aesdecwide256kl [eax]`
- as 결과: **accepted** / 바이트 `67 f3 0f 38 d8 18`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\naesdecwide256kl [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 171 · AESENC256KL

- 매뉴얼 원문: `AESENC256KL xmm, m512`  (PDF 167쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `aesenc256kl xmm0, zmmword ptr [eax]`
- 생성된 줄: `aesenc256kl xmm0, [eax]`
- as 결과: **accepted** / 바이트 `67 f3 0f 38 de 00`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\naesenc256kl xmm0, [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 184 · AESENCWIDE128KL

- 매뉴얼 원문: `AESENCWIDE128KL m384, <XMM0-7>`  (PDF 171쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `aesencwide128kl [eax], xmm0`
- 생성된 줄: `aesencwide128kl [eax]`
- as 결과: **accepted** / 바이트 `67 f3 0f 38 d8 00`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\naesencwide128kl [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 185 · AESENCWIDE256KL

- 매뉴얼 원문: `AESENCWIDE256KL m512, <XMM0-7>`  (PDF 173쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `aesencwide256kl zmmword ptr [eax], xmm0`
- 생성된 줄: `aesencwide256kl [eax]`
- as 결과: **accepted** / 바이트 `67 f3 0f 38 d8 10`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\naesencwide256kl [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 298 · BLENDVPD

- 매뉴얼 원문: `BLENDVPD xmm1, xmm2/m128, <XMM0>`  (PDF 200쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `blendvpd xmm0, xmm0, xmm0`
- 생성된 줄: `blendvpd xmm0, xmm0`
- as 결과: **accepted** / 바이트 `66 0f 38 15 c0`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nblendvpd xmm0, xmm0\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 299 · BLENDVPD

- 매뉴얼 원문: `BLENDVPD xmm1, xmm2/m128, <XMM0>`  (PDF 200쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `blendvpd xmm0, xmmword ptr [eax], xmm0`
- 생성된 줄: `blendvpd xmm0, xmmword ptr [eax]`
- as 결과: **accepted** / 바이트 `67 66 0f 38 15 00`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nblendvpd xmm0, xmmword ptr [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 304 · BLENDVPS

- 매뉴얼 원문: `BLENDVPS xmm1, xmm2/m128, <XMM0>`  (PDF 202쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `blendvps xmm0, xmm0, xmm0`
- 생성된 줄: `blendvps xmm0, xmm0`
- as 결과: **accepted** / 바이트 `66 0f 38 14 c0`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nblendvps xmm0, xmm0\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 305 · BLENDVPS

- 매뉴얼 원문: `BLENDVPS xmm1, xmm2/m128, <XMM0>`  (PDF 202쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `blendvps xmm0, xmmword ptr [eax], xmm0`
- 생성된 줄: `blendvps xmm0, xmmword ptr [eax]`
- as 결과: **accepted** / 바이트 `67 66 0f 38 14 00`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nblendvps xmm0, xmmword ptr [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 1027 · ENCODEKEY128

- 매뉴얼 원문: `ENCODEKEY128 r32, r32, <XMM0-2>, <XMM4-6>`  (PDF 401쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `encodekey128 ecx, ecx, xmm0, xmm4`
- 생성된 줄: `encodekey128 ecx, ecx`
- as 결과: **accepted** / 바이트 `f3 0f 38 fa c9`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nencodekey128 ecx, ecx\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 1031 · ENQCMD

- 매뉴얼 원문: `ENQCMD r32/r64, m512`  (PDF 407쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `enqcmd ecx, zmmword ptr [eax]`
- 생성된 줄: `enqcmd ecx, [eax]`
- as 결과: **accepted** / 바이트 `67 f2 0f 38 f8 08`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nenqcmd ecx, [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 1032 · ENQCMDS

- 매뉴얼 원문: `ENQCMDS r32/r64, m512`  (PDF 410쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `enqcmds ecx, zmmword ptr [eax]`
- 생성된 줄: `enqcmds ecx, [eax]`
- as 결과: **accepted** / 바이트 `67 f3 0f 38 f8 08`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nenqcmds ecx, [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 1191 · FXRSTOR

- 매뉴얼 원문: `FXRSTOR m512byte`  (PDF 527쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `fxrstor zmmword ptr [eax]`
- 생성된 줄: `fxrstor [eax]`
- as 결과: **accepted** / 바이트 `67 0f ae 08`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nfxrstor [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 1192 · FXRSTOR64

- 매뉴얼 원문: `FXRSTOR64 m512byte`  (PDF 527쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `fxrstor64 zmmword ptr [eax]`
- 생성된 줄: `fxrstor64 [eax]`
- as 결과: **accepted** / 바이트 `67 48 0f ae 08`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nfxrstor64 [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 1193 · FXSAVE

- 매뉴얼 원문: `FXSAVE m512byte`  (PDF 530쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `fxsave zmmword ptr [eax]`
- 생성된 줄: `fxsave [eax]`
- as 결과: **accepted** / 바이트 `67 0f ae 00`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nfxsave [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 1194 · FXSAVE64

- 매뉴얼 원문: `FXSAVE64 m512byte`  (PDF 530쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `fxsave64 zmmword ptr [eax]`
- 생성된 줄: `fxsave64 [eax]`
- as 결과: **accepted** / 바이트 `67 48 0f ae 00`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nfxsave64 [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 1247 · HRESET

- 매뉴얼 원문: `HRESET imm8, <EAX>`  (PDF 558쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `hreset 1, eax`
- 생성된 줄: `hreset 1`
- as 결과: **accepted** / 바이트 `f3 0f 3a f0 c0 01`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nhreset 1\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 1536 · LDTILECFG

- 매뉴얼 원문: `LDTILECFG m512`  (PDF 662쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `ldtilecfg zmmword ptr [eax]`
- 생성된 줄: `ldtilecfg [eax]`
- as 결과: **accepted** / 바이트 `67 c4 e2 78 49 00`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nldtilecfg [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 1554 · LOADIWKEY

- 매뉴얼 원문: `LOADIWKEY xmm1, xmm2, <EAX>, <XMM0>`  (PDF 680쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `loadiwkey xmm0, xmm0, eax, xmm0`
- 생성된 줄: `loadiwkey xmm0, xmm0`
- as 결과: **accepted** / 바이트 `f3 0f 38 dc c0`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nloadiwkey xmm0, xmm0\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 1684 · MOV

- 매뉴얼 원문: `MOV AL, moffs8`  (PDF 731쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `mov al, [0x1000]`
- 생성된 줄: `mov al, ds:0x123456789abcdef0`
- as 결과: **accepted** / 바이트 `a0 f0 de bc 9a 78 56 34 12`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nmov al, ds:0x123456789abcdef0\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 1685 · MOV

- 매뉴얼 원문: `MOV AL, moffs8`  (PDF 731쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `mov al, [0x1000]`
- 생성된 줄: `mov al, ds:0x123456789abcdef0`
- as 결과: **accepted** / 바이트 `a0 f0 de bc 9a 78 56 34 12`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nmov al, ds:0x123456789abcdef0\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 1686 · MOV

- 매뉴얼 원문: `MOV AX, moffs16`  (PDF 731쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `mov ax, [0x1000]`
- 생성된 줄: `mov ax, ds:0x123456789abcdef0`
- as 결과: **accepted** / 바이트 `66 a1 f0 de bc 9a 78 56 34 12`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nmov ax, ds:0x123456789abcdef0\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 1687 · MOV

- 매뉴얼 원문: `MOV EAX, moffs32`  (PDF 731쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `mov eax, [0x1000]`
- 생성된 줄: `mov eax, ds:0x123456789abcdef0`
- as 결과: **accepted** / 바이트 `a1 f0 de bc 9a 78 56 34 12`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nmov eax, ds:0x123456789abcdef0\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 1688 · MOV

- 매뉴얼 원문: `MOV RAX, moffs64`  (PDF 731쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `mov rax, [0x1000]`
- 생성된 줄: `mov rax, ds:0x123456789abcdef0`
- as 결과: **accepted** / 바이트 `48 a1 f0 de bc 9a 78 56 34 12`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nmov rax, ds:0x123456789abcdef0\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 1689 · MOV

- 매뉴얼 원문: `MOV moffs8, AL`  (PDF 731쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `mov [0x1000], al`
- 생성된 줄: `mov ds:0x123456789abcdef0, al`
- as 결과: **accepted** / 바이트 `a2 f0 de bc 9a 78 56 34 12`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nmov ds:0x123456789abcdef0, al\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 1690 · MOV

- 매뉴얼 원문: `MOV moffs8, AL`  (PDF 731쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `mov [0x1000], al`
- 생성된 줄: `mov ds:0x123456789abcdef0, al`
- as 결과: **accepted** / 바이트 `a2 f0 de bc 9a 78 56 34 12`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nmov ds:0x123456789abcdef0, al\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 1691 · MOV

- 매뉴얼 원문: `MOV moffs16, AX`  (PDF 731쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `mov [0x1000], ax`
- 생성된 줄: `mov ds:0x123456789abcdef0, ax`
- as 결과: **accepted** / 바이트 `66 a3 f0 de bc 9a 78 56 34 12`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nmov ds:0x123456789abcdef0, ax\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 1692 · MOV

- 매뉴얼 원문: `MOV moffs32, EAX`  (PDF 731쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `mov [0x1000], eax`
- 생성된 줄: `mov ds:0x123456789abcdef0, eax`
- as 결과: **accepted** / 바이트 `a3 f0 de bc 9a 78 56 34 12`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nmov ds:0x123456789abcdef0, eax\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 1693 · MOV

- 매뉴얼 원문: `MOV moffs64, RAX`  (PDF 731쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `mov [0x1000], rax`
- 생성된 줄: `mov ds:0x123456789abcdef0, rax`
- as 결과: **accepted** / 바이트 `48 a3 f0 de bc 9a 78 56 34 12`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nmov ds:0x123456789abcdef0, rax\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 1782 · MOVDIR64B

- 매뉴얼 원문: `MOVDIR64B r16/r32/r64, m512`  (PDF 754쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `movdir64b cx, zmmword ptr [eax]`
- 생성된 줄: `movdir64b ecx, [eax]`
- as 결과: **accepted** / 바이트 `67 66 0f 38 f8 08`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nmovdir64b ecx, [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 2565 · PBLENDVB

- 매뉴얼 원문: `PBLENDVB xmm1, xmm2/m128, <XMM0>`  (PDF 934쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `pblendvb xmm0, xmm0, xmm0`
- 생성된 줄: `pblendvb xmm0, xmm0`
- as 결과: **accepted** / 바이트 `66 0f 38 10 c0`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\npblendvb xmm0, xmm0\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 2566 · PBLENDVB

- 매뉴얼 원문: `PBLENDVB xmm1, xmm2/m128, <XMM0>`  (PDF 934쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `pblendvb xmm0, xmmword ptr [eax], xmm0`
- 생성된 줄: `pblendvb xmm0, xmmword ptr [eax]`
- as 결과: **accepted** / 바이트 `67 66 0f 38 10 00`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\npblendvb xmm0, xmmword ptr [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 4274 · SENDUIPI

- 매뉴얼 원문: `SENDUIPI reg`  (PDF 1322쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `senduipi ecx`
- 생성된 줄: `senduipi rcx`
- as 결과: **accepted** / 바이트 `f3 0f c7 f1`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nsenduipi rcx\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 4351 · SHA256RNDS2

- 매뉴얼 원문: `SHA256RNDS2 xmm1, xmm2/m128, <XMM0>`  (PDF 1340쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `sha256rnds2 xmm0, xmm0, xmm0`
- 생성된 줄: `sha256rnds2 xmm0, xmm0`
- as 결과: **accepted** / 바이트 `0f 38 cb c0`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nsha256rnds2 xmm0, xmm0\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 4352 · SHA256RNDS2

- 매뉴얼 원문: `SHA256RNDS2 xmm1, xmm2/m128, <XMM0>`  (PDF 1340쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `sha256rnds2 xmm0, xmmword ptr [eax], xmm0`
- 생성된 줄: `sha256rnds2 xmm0, xmmword ptr [eax]`
- as 결과: **accepted** / 바이트 `67 0f 38 cb 00`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nsha256rnds2 xmm0, xmmword ptr [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 4462 · STTILECFG

- 매뉴얼 원문: `STTILECFG m512`  (PDF 1384쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `sttilecfg zmmword ptr [eax]`
- 생성된 줄: `sttilecfg [eax]`
- as 결과: **accepted** / 바이트 `67 c4 e2 79 49 00`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nsttilecfg [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 4573 · TPAUSE

- 매뉴얼 원문: `TPAUSE r32, <edx>, <eax>`  (PDF 1428쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `tpause ecx, edx, eax`
- 생성된 줄: `tpause ecx`
- as 결과: **accepted** / 바이트 `66 0f ae f1`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\ntpause ecx\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 4599 · UMONITOR

- 매뉴얼 원문: `UMONITOR r16/r32/r64`  (PDF 1439쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `umonitor cx`
- 생성된 줄: `umonitor ecx`
- as 결과: **accepted** / 바이트 `67 f3 0f ae f1`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\numonitor ecx\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 4600 · UMWAIT

- 매뉴얼 원문: `UMWAIT r32, <edx>, <eax>`  (PDF 1441쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `umwait ecx, edx, eax`
- 생성된 줄: `umwait ecx`
- as 결과: **accepted** / 바이트 `f2 0f ae f1`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\numwait ecx\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 5934 · VP2INTERSECTD

- 매뉴얼 원문: `VP2INTERSECTD k1+1, xmm2, xmm3/m128/m32bcst`  (PDF 1895쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `vp2intersectd k1+1, xmm0, xmm0`
- 생성된 줄: `vp2intersectd k1, xmm0, xmm0`
- as 결과: **accepted** / 바이트 `62 f2 7f 08 68 c8`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvp2intersectd k1, xmm0, xmm0\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 5935 · VP2INTERSECTD

- 매뉴얼 원문: `VP2INTERSECTD k1+1, xmm2, xmm3/m128/m32bcst`  (PDF 1895쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `vp2intersectd k1+1, xmm0, xmmword ptr [eax]`
- 생성된 줄: `vp2intersectd k1, xmm0, xmmword ptr [eax]`
- as 결과: **accepted** / 바이트 `67 62 f2 7f 08 68 08`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvp2intersectd k1, xmm0, xmmword ptr [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 5936 · VP2INTERSECTD

- 매뉴얼 원문: `VP2INTERSECTD k1+1, ymm2, ymm3/m256/m32bcst`  (PDF 1895쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `vp2intersectd k1+1, ymm0, ymm0`
- 생성된 줄: `vp2intersectd k1, ymm0, ymm0`
- as 결과: **accepted** / 바이트 `62 f2 7f 28 68 c8`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvp2intersectd k1, ymm0, ymm0\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 5937 · VP2INTERSECTD

- 매뉴얼 원문: `VP2INTERSECTD k1+1, ymm2, ymm3/m256/m32bcst`  (PDF 1895쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `vp2intersectd k1+1, ymm0, ymmword ptr [eax]`
- 생성된 줄: `vp2intersectd k1, ymm0, ymmword ptr [eax]`
- as 결과: **accepted** / 바이트 `67 62 f2 7f 28 68 08`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvp2intersectd k1, ymm0, ymmword ptr [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 5938 · VP2INTERSECTD

- 매뉴얼 원문: `VP2INTERSECTD k1+1, zmm2, zmm3/m512/m32bcst`  (PDF 1895쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `vp2intersectd k1+1, zmm0, zmm0`
- 생성된 줄: `vp2intersectd k1, zmm0, zmm0`
- as 결과: **accepted** / 바이트 `62 f2 7f 48 68 c8`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvp2intersectd k1, zmm0, zmm0\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 5939 · VP2INTERSECTD

- 매뉴얼 원문: `VP2INTERSECTD k1+1, zmm2, zmm3/m512/m32bcst`  (PDF 1895쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `vp2intersectd k1+1, zmm0, zmmword ptr [eax]`
- 생성된 줄: `vp2intersectd k1, zmm0, zmmword ptr [eax]`
- as 결과: **accepted** / 바이트 `67 62 f2 7f 48 68 08`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvp2intersectd k1, zmm0, zmmword ptr [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 5940 · VP2INTERSECTQ

- 매뉴얼 원문: `VP2INTERSECTQ k1+1, xmm2, xmm3/m128/m64bcst`  (PDF 1895쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `vp2intersectq k1+1, xmm0, xmm0`
- 생성된 줄: `vp2intersectq k1, xmm0, xmm0`
- as 결과: **accepted** / 바이트 `62 f2 ff 08 68 c8`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvp2intersectq k1, xmm0, xmm0\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 5941 · VP2INTERSECTQ

- 매뉴얼 원문: `VP2INTERSECTQ k1+1, xmm2, xmm3/m128/m64bcst`  (PDF 1895쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `vp2intersectq k1+1, xmm0, xmmword ptr [eax]`
- 생성된 줄: `vp2intersectq k1, xmm0, xmmword ptr [eax]`
- as 결과: **accepted** / 바이트 `67 62 f2 ff 08 68 08`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvp2intersectq k1, xmm0, xmmword ptr [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 5942 · VP2INTERSECTQ

- 매뉴얼 원문: `VP2INTERSECTQ k1+1, ymm2, ymm3/m256/m64bcst`  (PDF 1895쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `vp2intersectq k1+1, ymm0, ymm0`
- 생성된 줄: `vp2intersectq k1, ymm0, ymm0`
- as 결과: **accepted** / 바이트 `62 f2 ff 28 68 c8`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvp2intersectq k1, ymm0, ymm0\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 5943 · VP2INTERSECTQ

- 매뉴얼 원문: `VP2INTERSECTQ k1+1, ymm2, ymm3/m256/m64bcst`  (PDF 1895쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `vp2intersectq k1+1, ymm0, ymmword ptr [eax]`
- 생성된 줄: `vp2intersectq k1, ymm0, ymmword ptr [eax]`
- as 결과: **accepted** / 바이트 `67 62 f2 ff 28 68 08`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvp2intersectq k1, ymm0, ymmword ptr [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 5944 · VP2INTERSECTQ

- 매뉴얼 원문: `VP2INTERSECTQ k1+1, zmm2, zmm3/m512/m64bcst`  (PDF 1895쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `vp2intersectq k1+1, zmm0, zmm0`
- 생성된 줄: `vp2intersectq k1, zmm0, zmm0`
- as 결과: **accepted** / 바이트 `62 f2 ff 48 68 c8`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvp2intersectq k1, zmm0, zmm0\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 5945 · VP2INTERSECTQ

- 매뉴얼 원문: `VP2INTERSECTQ k1+1, zmm2, zmm3/m512/m64bcst`  (PDF 1895쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `vp2intersectq k1+1, zmm0, zmmword ptr [eax]`
- 생성된 줄: `vp2intersectq k1, zmm0, zmmword ptr [eax]`
- as 결과: **accepted** / 바이트 `67 62 f2 ff 48 68 08`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvp2intersectq k1, zmm0, zmmword ptr [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 6953 · VREDUCESD

- 매뉴얼 원문: `VREDUCESD xmm1 {k1}{z}, xmm2, xmm3/m64{sae}, imm8/r`  (PDF 2155쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `vreducesd xmm0, xmm0, xmm0, imm8/r`
- 생성된 줄: `vreducesd xmm0, xmm0, xmm0, 1`
- as 결과: **accepted** / 바이트 `62 f3 fd 08 57 c0 01`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvreducesd xmm0, xmm0, xmm0, 1\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 6954 · VREDUCESD

- 매뉴얼 원문: `VREDUCESD xmm1 {k1}{z}, xmm2, xmm3/m64{sae}, imm8/r`  (PDF 2155쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `vreducesd xmm0, xmm0, qword ptr [eax], imm8/r`
- 생성된 줄: `vreducesd xmm0, xmm0, qword ptr [eax], 1`
- as 결과: **accepted** / 바이트 `67 62 f3 fd 08 57 00 01`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvreducesd xmm0, xmm0, qword ptr [eax], 1\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 7235 · V4FMADDPS

- 매뉴얼 원문: `V4FMADDPS zmm1{k1}{z}, zmm2+3, m128`  (PDF 2358쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `v4fmaddps zmm0, zmm2+3, xmmword ptr [eax]`
- 생성된 줄: `v4fmaddps zmm0, zmm2, xmmword ptr [eax]`
- as 결과: **accepted** / 바이트 `67 62 f2 6f 48 9a 00`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nv4fmaddps zmm0, zmm2, xmmword ptr [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 7236 · V4FNMADDPS

- 매뉴얼 원문: `V4FNMADDPS zmm1{k1}{z}, zmm2+3, m128`  (PDF 2358쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `v4fnmaddps zmm0, zmm2+3, xmmword ptr [eax]`
- 생성된 줄: `v4fnmaddps zmm0, zmm2, xmmword ptr [eax]`
- as 결과: **accepted** / 바이트 `67 62 f2 6f 48 aa 00`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nv4fnmaddps zmm0, zmm2, xmmword ptr [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 7237 · V4FMADDSS

- 매뉴얼 원문: `V4FMADDSS xmm1{k1}{z}, xmm2+3, m128`  (PDF 2360쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `v4fmaddss xmm0, xmm2+3, xmmword ptr [eax]`
- 생성된 줄: `v4fmaddss xmm0, xmm2, xmmword ptr [eax]`
- as 결과: **accepted** / 바이트 `67 62 f2 6f 08 9b 00`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nv4fmaddss xmm0, xmm2, xmmword ptr [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 7238 · V4FNMADDSS

- 매뉴얼 원문: `V4FNMADDSS xmm1{k1}{z}, xmm2+3, m128`  (PDF 2360쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `v4fnmaddss xmm0, xmm2+3, xmmword ptr [eax]`
- 생성된 줄: `v4fnmaddss xmm0, xmm2, xmmword ptr [eax]`
- as 결과: **accepted** / 바이트 `67 62 f2 6f 08 ab 00`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nv4fnmaddss xmm0, xmm2, xmmword ptr [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 7251 · VP4DPWSSDS

- 매뉴얼 원문: `VP4DPWSSDS zmm1{k1}{z}, zmm2+3, m128`  (PDF 2370쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `vp4dpwssds zmm0, zmm2+3, xmmword ptr [eax]`
- 생성된 줄: `vp4dpwssds zmm0, zmm2, xmmword ptr [eax]`
- as 결과: **accepted** / 바이트 `67 62 f2 6f 48 53 00`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvp4dpwssds zmm0, zmm2, xmmword ptr [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 

### combo 7252 · VP4DPWSSD

- 매뉴얼 원문: `VP4DPWSSD zmm1{k1}{z}, zmm2+3, m128`  (PDF 2372쪽)
- 매뉴얼 기대: Valid (expected_valid=True)
- 수정 전: `vp4dpwssd zmm0, zmm2+3, xmmword ptr [eax]`
- 생성된 줄: `vp4dpwssd zmm0, zmm2, xmmword ptr [eax]`
- as 결과: **accepted** / 바이트 `67 62 f2 6f 48 52 00`
- 재현: `printf '.intel_syntax noprefix\n.Ltarget:\nvp4dpwssd zmm0, zmm2, xmmword ptr [eax]\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`
- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: 


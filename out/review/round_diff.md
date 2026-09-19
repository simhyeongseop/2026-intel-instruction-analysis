# 수정 전후 비교

- 수정 전: 7,276행 (기준선 스냅샷)
- 수정 후: 19,120행 (신규 11,844행은 이번에 추가한 변형)
- 결과가 같은 공통 combo: 7,231행

## ⚠ 수용 → 거부 (이번 수정이 깨뜨렸을 수 있음) (0건)

없음

## 거부 → 수용 (의도한 개선인지 확인) (45건)

| combo | 수정 전 | 수정 후 | 수정 후 결과 |
|---|---|---|---|
| 143 | `aesdec256kl xmm0, zmmword ptr [eax]` | `aesdec256kl xmm0, [eax]` | ok |
| 156 | `aesdecwide128kl [eax], xmm0` | `aesdecwide128kl [eax]` | ok |
| 157 | `aesdecwide256kl zmmword ptr [eax], xmm0` | `aesdecwide256kl [eax]` | ok |
| 171 | `aesenc256kl xmm0, zmmword ptr [eax]` | `aesenc256kl xmm0, [eax]` | ok |
| 184 | `aesencwide128kl [eax], xmm0` | `aesencwide128kl [eax]` | ok |
| 185 | `aesencwide256kl zmmword ptr [eax], xmm0` | `aesencwide256kl [eax]` | ok |
| 1027 | `encodekey128 ecx, ecx, xmm0, xmm4` | `encodekey128 ecx, ecx` | ok |
| 1031 | `enqcmd ecx, zmmword ptr [eax]` | `enqcmd ecx, [eax]` | ok |
| 1032 | `enqcmds ecx, zmmword ptr [eax]` | `enqcmds ecx, [eax]` | ok |
| 1191 | `fxrstor zmmword ptr [eax]` | `fxrstor [eax]` | ok |
| 1192 | `fxrstor64 zmmword ptr [eax]` | `fxrstor64 [eax]` | ok |
| 1193 | `fxsave zmmword ptr [eax]` | `fxsave [eax]` | ok |
| 1194 | `fxsave64 zmmword ptr [eax]` | `fxsave64 [eax]` | ok |
| 1247 | `hreset 1, eax` | `hreset 1` | ok |
| 1536 | `ldtilecfg zmmword ptr [eax]` | `ldtilecfg [eax]` | ok |
| 1554 | `loadiwkey xmm0, xmm0, eax, xmm0` | `loadiwkey xmm0, xmm0` | ok |
| 1782 | `movdir64b cx, zmmword ptr [eax]` | `movdir64b ecx, [eax]` | ok |
| 2503 | `vpand ymm0, ymm0, ymm3/.m256` | `vpand ymm0, ymm0, ymm0` | ok |
| 4051 | `rep lods al` | `rep lods byte ptr [rsi]` | ok |
| 4052 | `rep lods ax` | `rep lods word ptr [rsi]` | ok |
| 4053 | `rep lods eax` | `rep lods dword ptr [rsi]` | ok |
| 4054 | `rep lods rax` | `rep lods qword ptr [rsi]` | ok |
| 4274 | `senduipi ecx` | `senduipi rcx` | ok |
| 4462 | `sttilecfg zmmword ptr [eax]` | `sttilecfg [eax]` | ok |
| 4599 | `umonitor cx` | `umonitor ecx` | ok |
| 5934 | `vp2intersectd k1+1, xmm0, xmm0` | `vp2intersectd k1, xmm0, xmm0` | ok |
| 5935 | `vp2intersectd k1+1, xmm0, xmmword ptr [eax]` | `vp2intersectd k1, xmm0, xmmword ptr [eax]` | ok |
| 5936 | `vp2intersectd k1+1, ymm0, ymm0` | `vp2intersectd k1, ymm0, ymm0` | ok |
| 5937 | `vp2intersectd k1+1, ymm0, ymmword ptr [eax]` | `vp2intersectd k1, ymm0, ymmword ptr [eax]` | ok |
| 5938 | `vp2intersectd k1+1, zmm0, zmm0` | `vp2intersectd k1, zmm0, zmm0` | ok |
| 5939 | `vp2intersectd k1+1, zmm0, zmmword ptr [eax]` | `vp2intersectd k1, zmm0, zmmword ptr [eax]` | ok |
| 5940 | `vp2intersectq k1+1, xmm0, xmm0` | `vp2intersectq k1, xmm0, xmm0` | ok |
| 5941 | `vp2intersectq k1+1, xmm0, xmmword ptr [eax]` | `vp2intersectq k1, xmm0, xmmword ptr [eax]` | ok |
| 5942 | `vp2intersectq k1+1, ymm0, ymm0` | `vp2intersectq k1, ymm0, ymm0` | ok |
| 5943 | `vp2intersectq k1+1, ymm0, ymmword ptr [eax]` | `vp2intersectq k1, ymm0, ymmword ptr [eax]` | ok |
| 5944 | `vp2intersectq k1+1, zmm0, zmm0` | `vp2intersectq k1, zmm0, zmm0` | ok |
| 5945 | `vp2intersectq k1+1, zmm0, zmmword ptr [eax]` | `vp2intersectq k1, zmm0, zmmword ptr [eax]` | ok |
| 6953 | `vreducesd xmm0, xmm0, xmm0, imm8/r` | `vreducesd xmm0, xmm0, xmm0, 1` | ok |
| 6954 | `vreducesd xmm0, xmm0, qword ptr [eax], imm8/r` | `vreducesd xmm0, xmm0, qword ptr [eax], 1` | ok |
| 7235 | `v4fmaddps zmm0, zmm2+3, xmmword ptr [eax]` | `v4fmaddps zmm0, zmm2, xmmword ptr [eax]` | ok |
| … | 외 5건 | | |

## 줄 내용이 바뀐 것 (66건)

| combo | 수정 전 | 수정 후 | 수정 후 결과 |
|---|---|---|---|
| 143 | `aesdec256kl xmm0, zmmword ptr [eax]` | `aesdec256kl xmm0, [eax]` | ok |
| 156 | `aesdecwide128kl [eax], xmm0` | `aesdecwide128kl [eax]` | ok |
| 157 | `aesdecwide256kl zmmword ptr [eax], xmm0` | `aesdecwide256kl [eax]` | ok |
| 171 | `aesenc256kl xmm0, zmmword ptr [eax]` | `aesenc256kl xmm0, [eax]` | ok |
| 184 | `aesencwide128kl [eax], xmm0` | `aesencwide128kl [eax]` | ok |
| 185 | `aesencwide256kl zmmword ptr [eax], xmm0` | `aesencwide256kl [eax]` | ok |
| 298 | `blendvpd xmm0, xmm0, xmm0` | `blendvpd xmm0, xmm0` | ok |
| 299 | `blendvpd xmm0, xmmword ptr [eax], xmm0` | `blendvpd xmm0, xmmword ptr [eax]` | ok |
| 304 | `blendvps xmm0, xmm0, xmm0` | `blendvps xmm0, xmm0` | ok |
| 305 | `blendvps xmm0, xmmword ptr [eax], xmm0` | `blendvps xmm0, xmmword ptr [eax]` | ok |
| 1027 | `encodekey128 ecx, ecx, xmm0, xmm4` | `encodekey128 ecx, ecx` | ok |
| 1031 | `enqcmd ecx, zmmword ptr [eax]` | `enqcmd ecx, [eax]` | ok |
| 1032 | `enqcmds ecx, zmmword ptr [eax]` | `enqcmds ecx, [eax]` | ok |
| 1191 | `fxrstor zmmword ptr [eax]` | `fxrstor [eax]` | ok |
| 1192 | `fxrstor64 zmmword ptr [eax]` | `fxrstor64 [eax]` | ok |
| 1193 | `fxsave zmmword ptr [eax]` | `fxsave [eax]` | ok |
| 1194 | `fxsave64 zmmword ptr [eax]` | `fxsave64 [eax]` | ok |
| 1247 | `hreset 1, eax` | `hreset 1` | ok |
| 1517 | `lar ecx, [eax]` | `lar ecx, word ptr [eax]` | ok |
| 1536 | `ldtilecfg zmmword ptr [eax]` | `ldtilecfg [eax]` | ok |
| 1554 | `loadiwkey xmm0, xmm0, eax, xmm0` | `loadiwkey xmm0, xmm0` | ok |
| 1684 | `mov al, [0x1000]` | `mov al, ds:0x123456789abcdef0` | ok |
| 1685 | `mov al, [0x1000]` | `mov al, ds:0x123456789abcdef0` | ok |
| 1686 | `mov ax, [0x1000]` | `mov ax, ds:0x123456789abcdef0` | ok |
| 1687 | `mov eax, [0x1000]` | `mov eax, ds:0x123456789abcdef0` | ok |
| 1688 | `mov rax, [0x1000]` | `mov rax, ds:0x123456789abcdef0` | ok |
| 1689 | `mov [0x1000], al` | `mov ds:0x123456789abcdef0, al` | ok |
| 1690 | `mov [0x1000], al` | `mov ds:0x123456789abcdef0, al` | ok |
| 1691 | `mov [0x1000], ax` | `mov ds:0x123456789abcdef0, ax` | ok |
| 1692 | `mov [0x1000], eax` | `mov ds:0x123456789abcdef0, eax` | ok |
| 1693 | `mov [0x1000], rax` | `mov ds:0x123456789abcdef0, rax` | ok |
| 1782 | `movdir64b cx, zmmword ptr [eax]` | `movdir64b ecx, [eax]` | ok |
| 2503 | `vpand ymm0, ymm0, ymm3/.m256` | `vpand ymm0, ymm0, ymm0` | ok |
| 2565 | `pblendvb xmm0, xmm0, xmm0` | `pblendvb xmm0, xmm0` | ok |
| 2566 | `pblendvb xmm0, xmmword ptr [eax], xmm0` | `pblendvb xmm0, xmmword ptr [eax]` | ok |
| 4051 | `rep lods al` | `rep lods byte ptr [rsi]` | ok |
| 4052 | `rep lods ax` | `rep lods word ptr [rsi]` | ok |
| 4053 | `rep lods eax` | `rep lods dword ptr [rsi]` | ok |
| 4054 | `rep lods rax` | `rep lods qword ptr [rsi]` | ok |
| 4274 | `senduipi ecx` | `senduipi rcx` | ok |
| … | 외 26건 | | |


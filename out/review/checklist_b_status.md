# 체크리스트 B그룹(생성기 결함 120건) 수정 후 상태

2026-09-19 라운드 재실행 결과다. 판정(`내_판단`)은 사람이 채운다. 여기서는 관측만 정리한다.

| combo | 분류 | 수정 전 | 수정 후 | as 결과 | 매뉴얼 기대 |
|---|---|---|---|---|---|
| 143 | compile_error_operand_size_mismatch | `aesdec256kl xmm0, zmmword ptr [eax` | `aesdec256kl xmm0, [eax]` ✎ | ok | Valid |
| 156 | combiner_implicit_operand_as_explicit | `aesdecwide128kl [eax], xmm0` | `aesdecwide128kl [eax]` ✎ | ok | Valid |
| 157 | combiner_implicit_operand_as_explicit | `aesdecwide256kl zmmword ptr [eax],` | `aesdecwide256kl [eax]` ✎ | ok | Valid |
| 171 | compile_error_operand_size_mismatch | `aesenc256kl xmm0, zmmword ptr [eax` | `aesenc256kl xmm0, [eax]` ✎ | ok | Valid |
| 184 | combiner_implicit_operand_as_explicit | `aesencwide128kl [eax], xmm0` | `aesencwide128kl [eax]` ✎ | ok | Valid |
| 185 | combiner_implicit_operand_as_explicit | `aesencwide256kl zmmword ptr [eax],` | `aesencwide256kl [eax]` ✎ | ok | Valid |
| 322 | compile_error_operand_size_mismatch | `bndcl bnd0, ecx` | `bndcl bnd0, ecx` | error | N.E. |
| 325 | implicit_operand_added_by_generator | `bndcl bnd0, qword ptr [rax]` | `bndcl bnd0, qword ptr [rax]` | ok | Valid |
| 326 | compile_error_operand_size_mismatch | `bndcu bnd0, ecx` | `bndcu bnd0, ecx` | error | N.E. |
| 329 | implicit_operand_added_by_generator | `bndcu bnd0, qword ptr [rax]` | `bndcu bnd0, qword ptr [rax]` | ok | Valid |
| 330 | compile_error_operand_size_mismatch | `bndcn bnd0, ecx` | `bndcn bnd0, ecx` | error | N.E. |
| 333 | implicit_operand_added_by_generator | `bndcn bnd0, qword ptr [rax]` | `bndcn bnd0, qword ptr [rax]` | ok | Valid |
| 336 | implicit_operand_added_by_generator | `bndmk bnd0, qword ptr [rax]` | `bndmk bnd0, qword ptr [rax]` | ok | Valid |
| 338 | compile_error_operand_size_mismatch | `bndmov bnd0, qword ptr [rax]` | `bndmov bnd0, qword ptr [rax]` | error | N.E. |
| 340 | implicit_operand_added_by_generator | `bndmov bnd0, xmmword ptr [rax]` | `bndmov bnd0, xmmword ptr [rax]` | ok | Valid |
| 342 | compile_error_operand_size_mismatch | `bndmov qword ptr [rax], bnd0` | `bndmov qword ptr [rax], bnd0` | error | N.E. |
| 344 | implicit_operand_added_by_generator | `bndmov xmmword ptr [rax], bnd0` | `bndmov xmmword ptr [rax], bnd0` | ok | Valid |
| 414 | generator_did_not_target_invalid_variant | `call .Ltarget` | `call .Ltarget` | ok | N.S. |
| 416 | compile_error_operand_size_mismatch | `call cx` | `call cx` | error | N.E. |
| 418 | compile_error_operand_size_mismatch | `call ecx` | `call ecx` | error | N.E. |
| 1027 | combiner_implicit_operand_as_explicit | `encodekey128 ecx, ecx, xmm0, xmm4` | `encodekey128 ecx, ecx` ✎ | ok | Valid |
| 1031 | compile_error_operand_size_mismatch | `enqcmd ecx, zmmword ptr [eax]` | `enqcmd ecx, [eax]` ✎ | ok | Valid |
| 1032 | compile_error_operand_size_mismatch | `enqcmds ecx, zmmword ptr [eax]` | `enqcmds ecx, [eax]` ✎ | ok | Valid |
| 1191 | compile_error_operand_size_mismatch | `fxrstor zmmword ptr [eax]` | `fxrstor [eax]` ✎ | ok | Valid |
| 1192 | compile_error_operand_size_mismatch | `fxrstor64 zmmword ptr [eax]` | `fxrstor64 [eax]` ✎ | ok | Valid |
| 1193 | compile_error_operand_size_mismatch | `fxsave zmmword ptr [eax]` | `fxsave [eax]` ✎ | ok | Valid |
| 1194 | compile_error_operand_size_mismatch | `fxsave64 zmmword ptr [eax]` | `fxsave64 [eax]` ✎ | ok | Valid |
| 1247 | combiner_implicit_operand_as_explicit | `hreset 1, eax` | `hreset 1` ✎ | ok | Valid |
| 1330 | compile_error_operand_size_mismatch | `invpcid ecx, xmmword ptr [eax]` | `invpcid ecx, xmmword ptr [eax]` | error | N.E. |
| 1331 | implicit_operand_added_by_generator | `invpcid rcx, xmmword ptr [eax]` | `invpcid rcx, xmmword ptr [eax]` | ok | Valid |
| 1368 | generator_did_not_target_invalid_variant | `ja .Ltarget` | `ja .Ltarget` | ok | N.S. |
| 1370 | generator_did_not_target_invalid_variant | `jae .Ltarget` | `jae .Ltarget` | ok | N.S. |
| 1372 | generator_did_not_target_invalid_variant | `jb .Ltarget` | `jb .Ltarget` | ok | N.S. |
| 1374 | generator_did_not_target_invalid_variant | `jbe .Ltarget` | `jbe .Ltarget` | ok | N.S. |
| 1376 | generator_did_not_target_invalid_variant | `jc .Ltarget` | `jc .Ltarget` | ok | N.S. |
| 1378 | generator_did_not_target_invalid_variant | `je .Ltarget` | `je .Ltarget` | ok | N.S. |
| 1380 | generator_did_not_target_invalid_variant | `jz .Ltarget` | `jz .Ltarget` | ok | N.S. |
| 1382 | generator_did_not_target_invalid_variant | `jg .Ltarget` | `jg .Ltarget` | ok | N.S. |
| 1384 | generator_did_not_target_invalid_variant | `jge .Ltarget` | `jge .Ltarget` | ok | N.S. |
| 1386 | generator_did_not_target_invalid_variant | `jl .Ltarget` | `jl .Ltarget` | ok | N.S. |
| 1388 | generator_did_not_target_invalid_variant | `jle .Ltarget` | `jle .Ltarget` | ok | N.S. |
| 1390 | generator_did_not_target_invalid_variant | `jna .Ltarget` | `jna .Ltarget` | ok | N.S. |
| 1392 | generator_did_not_target_invalid_variant | `jnae .Ltarget` | `jnae .Ltarget` | ok | N.S. |
| 1394 | generator_did_not_target_invalid_variant | `jnb .Ltarget` | `jnb .Ltarget` | ok | N.S. |
| 1396 | generator_did_not_target_invalid_variant | `jnbe .Ltarget` | `jnbe .Ltarget` | ok | N.S. |
| 1398 | generator_did_not_target_invalid_variant | `jnc .Ltarget` | `jnc .Ltarget` | ok | N.S. |
| 1400 | generator_did_not_target_invalid_variant | `jne .Ltarget` | `jne .Ltarget` | ok | N.S. |
| 1402 | generator_did_not_target_invalid_variant | `jng .Ltarget` | `jng .Ltarget` | ok | N.S. |
| 1404 | generator_did_not_target_invalid_variant | `jnge .Ltarget` | `jnge .Ltarget` | ok | N.S. |
| 1406 | generator_did_not_target_invalid_variant | `jnl .Ltarget` | `jnl .Ltarget` | ok | N.S. |
| 1408 | generator_did_not_target_invalid_variant | `jnle .Ltarget` | `jnle .Ltarget` | ok | N.S. |
| 1410 | generator_did_not_target_invalid_variant | `jno .Ltarget` | `jno .Ltarget` | ok | N.S. |
| 1412 | generator_did_not_target_invalid_variant | `jnp .Ltarget` | `jnp .Ltarget` | ok | N.S. |
| 1414 | generator_did_not_target_invalid_variant | `jns .Ltarget` | `jns .Ltarget` | ok | N.S. |
| 1416 | generator_did_not_target_invalid_variant | `jnz .Ltarget` | `jnz .Ltarget` | ok | N.S. |
| 1418 | generator_did_not_target_invalid_variant | `jo .Ltarget` | `jo .Ltarget` | ok | N.S. |
| 1420 | generator_did_not_target_invalid_variant | `jp .Ltarget` | `jp .Ltarget` | ok | N.S. |
| 1422 | generator_did_not_target_invalid_variant | `jpe .Ltarget` | `jpe .Ltarget` | ok | N.S. |
| 1424 | generator_did_not_target_invalid_variant | `jpo .Ltarget` | `jpo .Ltarget` | ok | N.S. |
| 1426 | generator_did_not_target_invalid_variant | `js .Ltarget` | `js .Ltarget` | ok | N.S. |
| 1428 | generator_did_not_target_invalid_variant | `jz .Ltarget` | `jz .Ltarget` | ok | N.S. |
| 1431 | generator_did_not_target_invalid_variant | `jmp .Ltarget` | `jmp .Ltarget` | ok | N.S. |
| 1433 | compile_error_operand_size_mismatch | `jmp cx` | `jmp cx` | error | N.S. |
| 1435 | compile_error_operand_size_mismatch | `jmp ecx` | `jmp ecx` | error | N.S. |
| 1519 | implicit_operand_added_by_generator | `vlddqu xmm0, xmmword ptr [eax]` | `vlddqu xmm0, xmmword ptr [eax]` | ok | Valid |
| 1520 | implicit_operand_added_by_generator | `vlddqu ymm0, ymmword ptr [eax]` | `vlddqu ymm0, ymmword ptr [eax]` | ok | Valid |
| 1536 | compile_error_operand_size_mismatch | `ldtilecfg zmmword ptr [eax]` | `ldtilecfg [eax]` ✎ | ok | Valid |
| 1554 | combiner_implicit_operand_as_explicit | `loadiwkey xmm0, xmm0, eax, xmm0` | `loadiwkey xmm0, xmm0` ✎ | ok | Valid |
| 1684 | imm_value_truncated_by_generator | `mov al, [0x1000]` | `mov al, ds:0x123456789abcdef0` ✎ | ok | Valid |
| 1685 | imm_value_truncated_by_generator | `mov al, [0x1000]` | `mov al, ds:0x123456789abcdef0` ✎ | ok | Valid |
| 1686 | imm_value_truncated_by_generator | `mov ax, [0x1000]` | `mov ax, ds:0x123456789abcdef0` ✎ | ok | Valid |
| 1687 | imm_value_truncated_by_generator | `mov eax, [0x1000]` | `mov eax, ds:0x123456789abcdef0` ✎ | ok | Valid |
| 1688 | imm_value_truncated_by_generator | `mov rax, [0x1000]` | `mov rax, ds:0x123456789abcdef0` ✎ | ok | Valid |
| 1689 | imm_value_truncated_by_generator | `mov [0x1000], al` | `mov ds:0x123456789abcdef0, al` ✎ | ok | Valid |
| 1690 | imm_value_truncated_by_generator | `mov [0x1000], al` | `mov ds:0x123456789abcdef0, al` ✎ | ok | Valid |
| 1691 | imm_value_truncated_by_generator | `mov [0x1000], ax` | `mov ds:0x123456789abcdef0, ax` ✎ | ok | Valid |
| 1692 | imm_value_truncated_by_generator | `mov [0x1000], eax` | `mov ds:0x123456789abcdef0, eax` ✎ | ok | Valid |
| 1693 | imm_value_truncated_by_generator | `mov [0x1000], rax` | `mov ds:0x123456789abcdef0, rax` ✎ | ok | Valid |
| 1782 | compile_error_operand_size_mismatch | `movdir64b cx, zmmword ptr [eax]` | `movdir64b ecx, [eax]` ✎ | ok | Valid |
| 2503 | combiner_raw_notation_literal | `vpand ymm0, ymm0, ymm0` | `vpand ymm0, ymm0, ymm0` | ok | Valid |
| 3283 | compile_error_operand_size_mismatch | `pop ecx` | `pop ecx` | error | N.E. |
| 3284 | compile_error_operand_size_mismatch | `pop dword ptr [eax]` | `pop dword ptr [eax]` | error | N.E. |
| 3288 | compile_error_operand_size_mismatch | `pop ecx` | `pop ecx` | error | N.E. |
| 3881 | compile_error_operand_size_mismatch | `push ecx` | `push ecx` | error | N.E. |
| 3882 | compile_error_operand_size_mismatch | `push dword ptr [eax]` | `push dword ptr [eax]` | error | N.E. |
| 3886 | compile_error_operand_size_mismatch | `push ecx` | `push ecx` | error | N.E. |
| 4034 | compile_error_operand_size_mismatch | `rdpid ecx` | `rdpid ecx` | error | N.E. |
| 4051 | compile_error_operand_size_mismatch | `rep lods al` | `rep lods byte ptr [rsi]` ✎ | ok | Valid |
| 4052 | compile_error_operand_size_mismatch | `rep lods ax` | `rep lods word ptr [rsi]` ✎ | ok | Valid |
| 4053 | compile_error_operand_size_mismatch | `rep lods eax` | `rep lods dword ptr [rsi]` ✎ | ok | Valid |
| 4054 | compile_error_operand_size_mismatch | `rep lods rax` | `rep lods qword ptr [rsi]` ✎ | ok | Valid |
| 4274 | compile_error_operand_size_mismatch | `senduipi ecx` | `senduipi rcx` ✎ | ok | Valid |
| 4462 | compile_error_operand_size_mismatch | `sttilecfg zmmword ptr [eax]` | `sttilecfg [eax]` ✎ | ok | Valid |
| 4573 | implicit_operand_added_by_generator | `tpause ecx, edx, eax` | `tpause ecx` ✎ | ok | Valid |
| 4599 | combiner_mode_invalid_register_choice | `umonitor cx` | `umonitor ecx` ✎ | ok | Valid |
| 4600 | implicit_operand_added_by_generator | `umwait ecx, edx, eax` | `umwait ecx` ✎ | ok | Valid |
| 5934 | combiner_raw_notation_literal | `vp2intersectd k1+1, xmm0, xmm0` | `vp2intersectd k1, xmm0, xmm0` ✎ | ok | Valid |
| 5935 | combiner_raw_notation_literal | `vp2intersectd k1+1, xmm0, xmmword ` | `vp2intersectd k1, xmm0, xmmword pt` ✎ | ok | Valid |
| 5936 | combiner_raw_notation_literal | `vp2intersectd k1+1, ymm0, ymm0` | `vp2intersectd k1, ymm0, ymm0` ✎ | ok | Valid |
| 5937 | combiner_raw_notation_literal | `vp2intersectd k1+1, ymm0, ymmword ` | `vp2intersectd k1, ymm0, ymmword pt` ✎ | ok | Valid |
| 5938 | combiner_raw_notation_literal | `vp2intersectd k1+1, zmm0, zmm0` | `vp2intersectd k1, zmm0, zmm0` ✎ | ok | Valid |
| 5939 | combiner_raw_notation_literal | `vp2intersectd k1+1, zmm0, zmmword ` | `vp2intersectd k1, zmm0, zmmword pt` ✎ | ok | Valid |
| 5940 | combiner_raw_notation_literal | `vp2intersectq k1+1, xmm0, xmm0` | `vp2intersectq k1, xmm0, xmm0` ✎ | ok | Valid |
| 5941 | combiner_raw_notation_literal | `vp2intersectq k1+1, xmm0, xmmword ` | `vp2intersectq k1, xmm0, xmmword pt` ✎ | ok | Valid |
| 5942 | combiner_raw_notation_literal | `vp2intersectq k1+1, ymm0, ymm0` | `vp2intersectq k1, ymm0, ymm0` ✎ | ok | Valid |
| 5943 | combiner_raw_notation_literal | `vp2intersectq k1+1, ymm0, ymmword ` | `vp2intersectq k1, ymm0, ymmword pt` ✎ | ok | Valid |
| 5944 | combiner_raw_notation_literal | `vp2intersectq k1+1, zmm0, zmm0` | `vp2intersectq k1, zmm0, zmm0` ✎ | ok | Valid |
| 5945 | combiner_raw_notation_literal | `vp2intersectq k1+1, zmm0, zmmword ` | `vp2intersectq k1, zmm0, zmmword pt` ✎ | ok | Valid |
| 6953 | extractor_artifact_stray_text | `vreducesd xmm0, xmm0, xmm0, imm8/r` | `vreducesd xmm0, xmm0, xmm0, 1` ✎ | ok | Valid |
| 6954 | extractor_artifact_stray_text | `vreducesd xmm0, xmm0, qword ptr [e` | `vreducesd xmm0, xmm0, qword ptr [e` ✎ | ok | Valid |
| 7116 | implicit_operand_added_by_generator | `wrssd dword ptr [eax], ecx` | `wrssd dword ptr [eax], ecx` | ok | Valid |
| 7117 | implicit_operand_added_by_generator | `wrssq qword ptr [eax], rcx` | `wrssq qword ptr [eax], rcx` | ok | Valid |
| 7118 | implicit_operand_added_by_generator | `wrussd dword ptr [eax], ecx` | `wrussd dword ptr [eax], ecx` | ok | Valid |
| 7119 | implicit_operand_added_by_generator | `wrussq qword ptr [eax], rcx` | `wrussq qword ptr [eax], rcx` | ok | Valid |
| 7235 | combiner_raw_notation_literal | `v4fmaddps zmm0, zmm2+3, xmmword pt` | `v4fmaddps zmm0, zmm2, xmmword ptr ` ✎ | ok | Valid |
| 7236 | combiner_raw_notation_literal | `v4fnmaddps zmm0, zmm2+3, xmmword p` | `v4fnmaddps zmm0, zmm2, xmmword ptr` ✎ | ok | Valid |
| 7237 | combiner_raw_notation_literal | `v4fmaddss xmm0, xmm2+3, xmmword pt` | `v4fmaddss xmm0, xmm2, xmmword ptr ` ✎ | ok | Valid |
| 7238 | combiner_raw_notation_literal | `v4fnmaddss xmm0, xmm2+3, xmmword p` | `v4fnmaddss xmm0, xmm2, xmmword ptr` ✎ | ok | Valid |
| 7251 | combiner_raw_notation_literal | `vp4dpwssds zmm0, zmm2+3, xmmword p` | `vp4dpwssds zmm0, zmm2, xmmword ptr` ✎ | ok | Valid |
| 7252 | combiner_raw_notation_literal | `vp4dpwssd zmm0, zmm2+3, xmmword pt` | `vp4dpwssd zmm0, zmm2, xmmword ptr ` ✎ | ok | Valid |

# Clang vs GNU as 비교 (9단계 clang_compare)

as = GNU as (기존 5단계 assembler), clang = clang 통합 어셈블러(8단계).
둘 다 같은 out/tests.s를 한 줄씩 개별 어셈블한 결과를 combo_id로 맞댄 것이다.

**원칙(CLAUDE.md 6절): 차이 ≠ 버그.** 아래 분류는 사실 확인까지만이고,
SDM 위반 여부 판단은 별도로 원문 대조가 필요하다.

## 카테고리별 건수

| 카테고리 | 건수 | 의미 |
|---|---|---|
| both_ok_same_bytes | 7058 | 둘 다 성공, 바이트(hex) 인코딩이 완전히 같음 |
| both_ok_diff_bytes | 48 | 둘 다 성공, 바이트 인코딩이 다름 |
| as_only | 56 | as만 성공, clang은 거부 |
| clang_only | 18 | clang만 성공, as는 거부 |
| both_reject | 96 | as/clang 둘 다 거부 |
| parse_error | 0 | 둘 다 성공했다고 나왔는데 objdump가 바이트를 못 뽑음 (조사 필요) |

## both_ok_diff_bytes 사례 (최대 30건)

as와 clang이 둘 다 받아줬는데 실제 바이트(hex)가 다름 — 이 카테고리가
가장 흥미로운 대상이다. `note`는 이 라운드에서 직접 objdump/코드로 확인한 것만 채움.

| combo_id | mnemonic | asm_line | as_bytes | clang_bytes | as_objdump | clang_objdump |
|---|---|---|---|---|---|---|
| 419 | CALL | `call dword ptr [eax]` | `6766ff18` | `67ff18` | `call   DWORD PTR [eax]` | `call   FWORD PTR [eax]` |
| 1332 | IRET | `iret` | `cf` | `66cf` | `iret` | `iretw` |
| 1436 | JMP | `jmp dword ptr [eax]` | `6766ff28` | `67ff28` | `jmp    DWORD PTR [eax]` | `jmp    FWORD PTR [eax]` |
| 1572 | LSL | `lsl rcx, word ptr [eax]` | `670f0308` | `67480f0308` | `lsl    ecx,WORD PTR [eax]` | `lsl    rcx,WORD PTR [eax]` |
| 1674 | MOV | `mov cx, ds` | `668cd9` | `8cd9` | `mov    cx,ds` | `mov    ecx,ds` |
| 1676 | MOV | `mov cx, ds` | `668cd9` | `8cd9` | `mov    cx,ds` | `mov    ecx,ds` |
| 1678 | MOV | `mov rcx, ds` | `8cd9` | `488cd9` | `mov    ecx,ds` | `mov    rcx,ds` |
| 1680 | MOV | `mov ds, cx` | `8ed9` | `668ed9` | `mov    ds,ecx` | `mov    ds,cx` |
| 1682 | MOV | `mov ds, rcx` | `8ed9` | `488ed9` | `mov    ds,ecx` | `mov    ds,rcx` |
| 3293 | POP | `pop fs` | `0fa1` | `660fa1` | `pop    fs` | `popw   fs` |
| 3294 | POP | `pop fs` | `0fa1` | `660fa1` | `pop    fs` | `popw   fs` |
| 3295 | POP | `pop fs` | `0fa1` | `660fa1` | `pop    fs` | `popw   fs` |
| 3296 | POP | `pop gs` | `0fa9` | `660fa9` | `pop    gs` | `popw   gs` |
| 3297 | POP | `pop gs` | `0fa9` | `660fa9` | `pop    gs` | `popw   gs` |
| 3298 | POP | `pop gs` | `0fa9` | `660fa9` | `pop    gs` | `popw   gs` |
| 3895 | PUSH | `push fs` | `0fa0` | `660fa0` | `push   fs` | `pushw  fs` |
| 3896 | PUSH | `push gs` | `0fa8` | `660fa8` | `push   gs` | `pushw  gs` |
| 4048 | REP INS | `rep ins byte ptr [eax], dx` | `67f36c` | `f3676c` | `rep ins BYTE PTR es:[edi],dx` | `rep ins BYTE PTR es:[edi],dx` |
| 4049 | REP INS | `rep ins word ptr [eax], dx` | `6766f36d` | `f367666d` | `rep ins WORD PTR es:[edi],dx` | `rep ins WORD PTR es:[edi],dx` |
| 4050 | REP INS | `rep ins dword ptr [eax], dx` | `67f36d` | `f3676d` | `rep ins DWORD PTR es:[edi],dx` | `rep ins DWORD PTR es:[edi],dx` |
| 4055 | REP MOVS | `rep movs byte ptr [eax], byte ptr [eax]` | `67f3a4` | `f367a4` | `rep movs BYTE PTR es:[edi],BYTE PTR ds:[esi]` | `rep movs BYTE PTR es:[edi],BYTE PTR ds:[esi]` |
| 4056 | REP MOVS | `rep movs word ptr [eax], word ptr [eax]` | `6766f3a5` | `f36766a5` | `rep movs WORD PTR es:[edi],WORD PTR ds:[esi]` | `rep movs WORD PTR es:[edi],WORD PTR ds:[esi]` |
| 4057 | REP MOVS | `rep movs dword ptr [eax], dword ptr [eax]` | `67f3a5` | `f367a5` | `rep movs DWORD PTR es:[edi],DWORD PTR ds:[esi]` | `rep movs DWORD PTR es:[edi],DWORD PTR ds:[esi]` |
| 4058 | REP MOVS | `rep movs qword ptr [eax], qword ptr [eax]` | `67f348a5` | `f36748a5` | `rep movs QWORD PTR es:[edi],QWORD PTR ds:[esi]` | `rep movs QWORD PTR es:[edi],QWORD PTR ds:[esi]` |
| 4059 | REP OUTS | `rep outs dx, byte ptr [eax]` | `67f36e` | `f3676e` | `rep outs dx,BYTE PTR ds:[esi]` | `rep outs dx,BYTE PTR ds:[esi]` |
| 4060 | REP OUTS | `rep outs dx, word ptr [eax]` | `6766f36f` | `f367666f` | `rep outs dx,WORD PTR ds:[esi]` | `rep outs dx,WORD PTR ds:[esi]` |
| 4061 | REP OUTS | `rep outs dx, dword ptr [eax]` | `67f36f` | `f3676f` | `rep outs dx,DWORD PTR ds:[esi]` | `rep outs dx,DWORD PTR ds:[esi]` |
| 4062 | REP STOS | `rep stos byte ptr [eax]` | `67f3aa` | `f367aa` | `rep stos BYTE PTR es:[edi],al` | `rep stos BYTE PTR es:[edi],al` |
| 4063 | REP STOS | `rep stos word ptr [eax]` | `6766f3ab` | `f36766ab` | `rep stos WORD PTR es:[edi],ax` | `rep stos WORD PTR es:[edi],ax` |
| 4064 | REP STOS | `rep stos dword ptr [eax]` | `67f3ab` | `f367ab` | `rep stos DWORD PTR es:[edi],eax` | `rep stos DWORD PTR es:[edi],eax` |

## as_only 사례 (최대 15건)

| combo_id | mnemonic | asm_line | expected_valid | clang_error |
|---|---|---|---|---|
| 323 | BNDCL | `bndcl bnd0, dword ptr [rax]` | False | line.s:3:1: error: invalid instruction mnemonic 'bndcl' | bndcl bnd0, dword ptr [rax] | ^~~~~ |
| 324 | BNDCL | `bndcl bnd0, rcx` | True | line.s:3:1: error: invalid instruction mnemonic 'bndcl' | bndcl bnd0, rcx | ^~~~~ |
| 325 | BNDCL | `bndcl bnd0, qword ptr [rax]` | True | line.s:3:1: error: invalid instruction mnemonic 'bndcl' | bndcl bnd0, qword ptr [rax] | ^~~~~ |
| 327 | BNDCU | `bndcu bnd0, dword ptr [rax]` | False | line.s:3:1: error: invalid instruction mnemonic 'bndcu' | bndcu bnd0, dword ptr [rax] | ^~~~~ |
| 328 | BNDCU | `bndcu bnd0, rcx` | True | line.s:3:1: error: invalid instruction mnemonic 'bndcu' | bndcu bnd0, rcx | ^~~~~ |
| 329 | BNDCU | `bndcu bnd0, qword ptr [rax]` | True | line.s:3:1: error: invalid instruction mnemonic 'bndcu' | bndcu bnd0, qword ptr [rax] | ^~~~~ |
| 331 | BNDCN | `bndcn bnd0, dword ptr [rax]` | False | line.s:3:1: error: invalid instruction mnemonic 'bndcn' | bndcn bnd0, dword ptr [rax] | ^~~~~ |
| 332 | BNDCN | `bndcn bnd0, rcx` | True | line.s:3:1: error: invalid instruction mnemonic 'bndcn' | bndcn bnd0, rcx | ^~~~~ |
| 333 | BNDCN | `bndcn bnd0, qword ptr [rax]` | True | line.s:3:1: error: invalid instruction mnemonic 'bndcn' | bndcn bnd0, qword ptr [rax] | ^~~~~ |
| 334 | BNDLDX | `bndldx bnd0, [rax]` | True | line.s:3:1: error: invalid instruction mnemonic 'bndldx' | bndldx bnd0, [rax] | ^~~~~~ |
| 335 | BNDMK | `bndmk bnd0, dword ptr [rax]` | False | line.s:3:1: error: invalid instruction mnemonic 'bndmk' | bndmk bnd0, dword ptr [rax] | ^~~~~ |
| 336 | BNDMK | `bndmk bnd0, qword ptr [rax]` | True | line.s:3:1: error: invalid instruction mnemonic 'bndmk' | bndmk bnd0, qword ptr [rax] | ^~~~~ |
| 337 | BNDMOV | `bndmov bnd0, bnd0` | False | line.s:3:1: error: invalid instruction mnemonic 'bndmov' | bndmov bnd0, bnd0 | ^~~~~~ |
| 339 | BNDMOV | `bndmov bnd0, bnd0` | True | line.s:3:1: error: invalid instruction mnemonic 'bndmov' | bndmov bnd0, bnd0 | ^~~~~~ |
| 340 | BNDMOV | `bndmov bnd0, xmmword ptr [rax]` | True | line.s:3:1: error: invalid instruction mnemonic 'bndmov' | bndmov bnd0, xmmword ptr [rax] | ^~~~~~ |

## clang_only 사례 (최대 15건)

| combo_id | mnemonic | asm_line | expected_valid | as_error |
|---|---|---|---|---|
| 143 | AESDEC256KL | `aesdec256kl xmm0, zmmword ptr [eax]` | True | line.s: Assembler messages: | line.s:3: Error: operand size mismatch for `aesdec256kl' |
| 171 | AESENC256KL | `aesenc256kl xmm0, zmmword ptr [eax]` | True | line.s: Assembler messages: | line.s:3: Error: operand size mismatch for `aesenc256kl' |
| 417 | CALL | `call word ptr [eax]` | False | line.s: Assembler messages: | line.s:3: Error: operand type mismatch for `call' |
| 1031 | ENQCMD | `enqcmd ecx, zmmword ptr [eax]` | True | line.s: Assembler messages: | line.s:3: Error: operand size mismatch for `enqcmd' |
| 1032 | ENQCMDS | `enqcmds ecx, zmmword ptr [eax]` | True | line.s: Assembler messages: | line.s:3: Error: operand size mismatch for `enqcmds' |
| 1191 | FXRSTOR | `fxrstor zmmword ptr [eax]` | True | line.s: Assembler messages: | line.s:3: Error: operand size mismatch for `fxrstor' |
| 1192 | FXRSTOR64 | `fxrstor64 zmmword ptr [eax]` | True | line.s: Assembler messages: | line.s:3: Error: operand size mismatch for `fxrstor64' |
| 1193 | FXSAVE | `fxsave zmmword ptr [eax]` | True | line.s: Assembler messages: | line.s:3: Error: operand size mismatch for `fxsave' |
| 1194 | FXSAVE64 | `fxsave64 zmmword ptr [eax]` | True | line.s: Assembler messages: | line.s:3: Error: operand size mismatch for `fxsave64' |
| 1434 | JMP | `jmp word ptr [eax]` | False | line.s: Assembler messages: | line.s:3: Error: operand type mismatch for `jmp' |
| 1516 | LAR | `lar ecx, rcx` | True | line.s: Assembler messages: | line.s:3: Error: register type mismatch for `lar' |
| 1536 | LDTILECFG | `ldtilecfg zmmword ptr [eax]` | True | line.s: Assembler messages: | line.s:3: Error: operand size mismatch for `ldtilecfg' |
| 1571 | LSL | `lsl rcx, ecx` | True | line.s: Assembler messages: | line.s:3: Error: register type mismatch for `lsl' |
| 4462 | STTILECFG | `sttilecfg zmmword ptr [eax]` | True | line.s: Assembler messages: | line.s:3: Error: operand size mismatch for `sttilecfg' |
| 4537 | SYSEXIT | `sysexit` | True | line.s: Assembler messages: | line.s:3: Error: ambiguous operand size for `sysexit' |


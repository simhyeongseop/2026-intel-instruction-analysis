# Clang vs GNU as 비교 (9단계 clang_compare)

as = GNU as (기존 5단계 assembler), clang = clang 통합 어셈블러(8단계).
둘 다 같은 out/tests.s를 한 줄씩 개별 어셈블한 결과를 combo_id로 맞댄 것이다.

**원칙(CLAUDE.md 6절): 차이 ≠ 버그.** 아래 분류는 사실 확인까지만이고,
SDM 위반 여부 판단은 별도로 원문 대조가 필요하다.

## 카테고리별 건수

| 카테고리 | 건수 | 의미 |
|---|---|---|
| both_ok_same_bytes | 18843 | 둘 다 성공, 바이트(hex) 인코딩이 완전히 같음 |
| both_ok_diff_bytes | 111 | 둘 다 성공, 바이트 인코딩이 다름 |
| as_only | 66 | as만 성공, clang은 거부 |
| clang_only | 12 | clang만 성공, as는 거부 |
| both_reject | 88 | as/clang 둘 다 거부 |
| parse_error | 0 | 둘 다 성공했다고 나왔는데 objdump가 바이트를 못 뽑음 (조사 필요) |

## both_ok_diff_bytes 사례 (최대 30건)

as와 clang이 둘 다 받아줬는데 실제 바이트(hex)가 다름 — 이 카테고리가
가장 흥미로운 대상이다. `note`는 이 라운드에서 직접 objdump/코드로 확인한 것만 채움.

| combo_id | mnemonic | asm_line | as_bytes | clang_bytes | as_objdump | clang_objdump |
|---|---|---|---|---|---|---|
| 419 | call | `call dword ptr [eax]` | `6766ff18` | `67ff18` | `call   DWORD PTR [eax]` | `call   FWORD PTR [eax]` |
| 1332 | iret | `iret` | `cf` | `66cf` | `iret` | `iretw` |
| 1436 | jmp | `jmp dword ptr [eax]` | `6766ff28` | `67ff28` | `jmp    DWORD PTR [eax]` | `jmp    FWORD PTR [eax]` |
| 1572 | lsl | `lsl rcx, word ptr [eax]` | `670f0308` | `67480f0308` | `lsl    ecx,WORD PTR [eax]` | `lsl    rcx,WORD PTR [eax]` |
| 1674 | mov | `mov cx, ds` | `668cd9` | `8cd9` | `mov    cx,ds` | `mov    ecx,ds` |
| 1676 | mov | `mov cx, ds` | `668cd9` | `8cd9` | `mov    cx,ds` | `mov    ecx,ds` |
| 1678 | mov | `mov rcx, ds` | `8cd9` | `488cd9` | `mov    ecx,ds` | `mov    rcx,ds` |
| 1680 | mov | `mov ds, cx` | `8ed9` | `668ed9` | `mov    ds,ecx` | `mov    ds,cx` |
| 1682 | mov | `mov ds, rcx` | `8ed9` | `488ed9` | `mov    ds,ecx` | `mov    ds,rcx` |
| 1684 | mov | `mov al, ds:0x123456789abcdef0` | `a0f0debc9a78563412` | `3e8a0425f0debc9a` | `movabs al,ds:0x123456789abcdef0` | `ds mov al,BYTE PTR ds:0xffffffff9abcdef0` |
| 1685 | mov | `mov al, ds:0x123456789abcdef0` | `a0f0debc9a78563412` | `3e8a0425f0debc9a` | `movabs al,ds:0x123456789abcdef0` | `ds mov al,BYTE PTR ds:0xffffffff9abcdef0` |
| 1686 | mov | `mov ax, ds:0x123456789abcdef0` | `66a1f0debc9a78563412` | `3e668b0425f0debc9a` | `movabs ax,ds:0x123456789abcdef0` | `ds mov ax,WORD PTR ds:0xffffffff9abcdef0` |
| 1687 | mov | `mov eax, ds:0x123456789abcdef0` | `a1f0debc9a78563412` | `3e8b0425f0debc9a` | `movabs eax,ds:0x123456789abcdef0` | `ds mov eax,DWORD PTR ds:0xffffffff9abcdef0` |
| 1688 | mov | `mov rax, ds:0x123456789abcdef0` | `48a1f0debc9a78563412` | `3e488b0425f0debc9a` | `movabs rax,ds:0x123456789abcdef0` | `ds mov rax,QWORD PTR ds:0xffffffff9abcdef0` |
| 1689 | mov | `mov ds:0x123456789abcdef0, al` | `a2f0debc9a78563412` | `3e880425f0debc9a` | `movabs ds:0x123456789abcdef0,al` | `ds mov BYTE PTR ds:0xffffffff9abcdef0,al` |
| 1690 | mov | `mov ds:0x123456789abcdef0, al` | `a2f0debc9a78563412` | `3e880425f0debc9a` | `movabs ds:0x123456789abcdef0,al` | `ds mov BYTE PTR ds:0xffffffff9abcdef0,al` |
| 1691 | mov | `mov ds:0x123456789abcdef0, ax` | `66a3f0debc9a78563412` | `3e66890425f0debc9a` | `movabs ds:0x123456789abcdef0,ax` | `ds mov WORD PTR ds:0xffffffff9abcdef0,ax` |
| 1692 | mov | `mov ds:0x123456789abcdef0, eax` | `a3f0debc9a78563412` | `3e890425f0debc9a` | `movabs ds:0x123456789abcdef0,eax` | `ds mov DWORD PTR ds:0xffffffff9abcdef0,eax` |
| 1693 | mov | `mov ds:0x123456789abcdef0, rax` | `48a3f0debc9a78563412` | `3e48890425f0debc9a` | `movabs ds:0x123456789abcdef0,rax` | `ds mov QWORD PTR ds:0xffffffff9abcdef0,rax` |
| 3293 | pop | `pop fs` | `0fa1` | `660fa1` | `pop    fs` | `popw   fs` |
| 3294 | pop | `pop fs` | `0fa1` | `660fa1` | `pop    fs` | `popw   fs` |
| 3295 | pop | `pop fs` | `0fa1` | `660fa1` | `pop    fs` | `popw   fs` |
| 3296 | pop | `pop gs` | `0fa9` | `660fa9` | `pop    gs` | `popw   gs` |
| 3297 | pop | `pop gs` | `0fa9` | `660fa9` | `pop    gs` | `popw   gs` |
| 3298 | pop | `pop gs` | `0fa9` | `660fa9` | `pop    gs` | `popw   gs` |
| 3895 | push | `push fs` | `0fa0` | `660fa0` | `push   fs` | `pushw  fs` |
| 3896 | push | `push gs` | `0fa8` | `660fa8` | `push   gs` | `pushw  gs` |
| 4048 | rep ins | `rep ins byte ptr [eax], dx` | `67f36c` | `f3676c` | `rep ins BYTE PTR es:[edi],dx` | `rep ins BYTE PTR es:[edi],dx` |
| 4049 | rep ins | `rep ins word ptr [eax], dx` | `6766f36d` | `f367666d` | `rep ins WORD PTR es:[edi],dx` | `rep ins WORD PTR es:[edi],dx` |
| 4050 | rep ins | `rep ins dword ptr [eax], dx` | `67f36d` | `f3676d` | `rep ins DWORD PTR es:[edi],dx` | `rep ins DWORD PTR es:[edi],dx` |

## as_only 사례 (최대 15건)

| combo_id | mnemonic | asm_line | expected_valid | clang_error |
|---|---|---|---|---|
| 323 | bndcl | `bndcl bnd0, dword ptr [rax]` | False | line.s:3:1: error: invalid instruction mnemonic 'bndcl' | bndcl bnd0, dword ptr [rax] | ^~~~~ |
| 324 | bndcl | `bndcl bnd0, rcx` | True | line.s:3:1: error: invalid instruction mnemonic 'bndcl' | bndcl bnd0, rcx | ^~~~~ |
| 325 | bndcl | `bndcl bnd0, qword ptr [rax]` | True | line.s:3:1: error: invalid instruction mnemonic 'bndcl' | bndcl bnd0, qword ptr [rax] | ^~~~~ |
| 327 | bndcu | `bndcu bnd0, dword ptr [rax]` | False | line.s:3:1: error: invalid instruction mnemonic 'bndcu' | bndcu bnd0, dword ptr [rax] | ^~~~~ |
| 328 | bndcu | `bndcu bnd0, rcx` | True | line.s:3:1: error: invalid instruction mnemonic 'bndcu' | bndcu bnd0, rcx | ^~~~~ |
| 329 | bndcu | `bndcu bnd0, qword ptr [rax]` | True | line.s:3:1: error: invalid instruction mnemonic 'bndcu' | bndcu bnd0, qword ptr [rax] | ^~~~~ |
| 331 | bndcn | `bndcn bnd0, dword ptr [rax]` | False | line.s:3:1: error: invalid instruction mnemonic 'bndcn' | bndcn bnd0, dword ptr [rax] | ^~~~~ |
| 332 | bndcn | `bndcn bnd0, rcx` | True | line.s:3:1: error: invalid instruction mnemonic 'bndcn' | bndcn bnd0, rcx | ^~~~~ |
| 333 | bndcn | `bndcn bnd0, qword ptr [rax]` | True | line.s:3:1: error: invalid instruction mnemonic 'bndcn' | bndcn bnd0, qword ptr [rax] | ^~~~~ |
| 334 | bndldx | `bndldx bnd0, [rax]` | True | line.s:3:1: error: invalid instruction mnemonic 'bndldx' | bndldx bnd0, [rax] | ^~~~~~ |
| 335 | bndmk | `bndmk bnd0, dword ptr [rax]` | False | line.s:3:1: error: invalid instruction mnemonic 'bndmk' | bndmk bnd0, dword ptr [rax] | ^~~~~ |
| 336 | bndmk | `bndmk bnd0, qword ptr [rax]` | True | line.s:3:1: error: invalid instruction mnemonic 'bndmk' | bndmk bnd0, qword ptr [rax] | ^~~~~ |
| 337 | bndmov | `bndmov bnd0, bnd0` | False | line.s:3:1: error: invalid instruction mnemonic 'bndmov' | bndmov bnd0, bnd0 | ^~~~~~ |
| 339 | bndmov | `bndmov bnd0, bnd0` | True | line.s:3:1: error: invalid instruction mnemonic 'bndmov' | bndmov bnd0, bnd0 | ^~~~~~ |
| 340 | bndmov | `bndmov bnd0, xmmword ptr [rax]` | True | line.s:3:1: error: invalid instruction mnemonic 'bndmov' | bndmov bnd0, xmmword ptr [rax] | ^~~~~~ |

## clang_only 사례 (최대 15건)

| combo_id | mnemonic | asm_line | expected_valid | as_error |
|---|---|---|---|---|
| 417 | call | `call word ptr [eax]` | False | line.s: Assembler messages: | line.s:3: Error: operand type mismatch for `call' |
| 1434 | jmp | `jmp word ptr [eax]` | False | line.s: Assembler messages: | line.s:3: Error: operand type mismatch for `jmp' |
| 1516 | lar | `lar ecx, rcx` | True | line.s: Assembler messages: | line.s:3: Error: register type mismatch for `lar' |
| 1571 | lsl | `lsl rcx, ecx` | True | line.s: Assembler messages: | line.s:3: Error: register type mismatch for `lsl' |
| 4537 | sysexit | `sysexit` | True | line.s: Assembler messages: | line.s:3: Error: ambiguous operand size for `sysexit' |
| 4538 | sysexit | `sysexit` | True | line.s: Assembler messages: | line.s:3: Error: ambiguous operand size for `sysexit' |
| 4539 | sysret | `sysret` | True | line.s: Assembler messages: | line.s:3: Error: ambiguous operand size for `sysret' |
| 4540 | sysret | `sysret` | True | line.s: Assembler messages: | line.s:3: Error: ambiguous operand size for `sysret' |
| 7830 | call | `call word ptr [rax+rbx*4+0x10]` | False | line.s: Assembler messages: | line.s:3: Error: operand type mismatch for `call' |
| 7831 | call | `call word ptr [rip+0x10]` | False | line.s: Assembler messages: | line.s:3: Error: operand type mismatch for `call' |
| 9024 | jmp | `jmp word ptr [rax+rbx*4+0x10]` | False | line.s: Assembler messages: | line.s:3: Error: operand type mismatch for `jmp' |
| 9025 | jmp | `jmp word ptr [rip+0x10]` | False | line.s: Assembler messages: | line.s:3: Error: operand type mismatch for `jmp' |


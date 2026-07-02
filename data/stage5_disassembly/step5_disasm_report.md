# Stage 5 역어셈블 비교 리포트

## 1. 목적

Stage 4에서 accept된 assembly가 실제로 의도한 instruction form/opcode로 조립되었는지 확인한다.
원본 assembly와 `objdump -d -M intel` 결과를 정규화한 뒤 1:1로 비교한다.

## 2. 입력 및 출력

- 원본 assembly: `/home/wltjq/data/stage4_tests/test_all_instructions.s`
- object file: `/home/wltjq/data/stage5_disassembly/test_all_stage5.o`
- objdump 원문: `/home/wltjq/data/stage5_disassembly/step5_objdump_intel.txt`

## 3. 요약

- 전체 비교 instruction: 8810
- exact match: 7102
- alias: 1511
- alignment 재동기화 필요 행: 438
- 추가 확인 필요: 116

## 4. 카테고리별 개수

| Category | Count |
|---|---:|
| exact_match | 7102 |
| alias | 1511 |
| relative_target_resolved | 67 |
| register_width_changed | 52 |
| far_pointer_size_repr_changed | 30 |
| operand_size_changed | 18 |
| mnemonic_changed | 16 |
| moffset_size_inferred | 8 |
| generic_memory_size_inferred | 6 |

## 5. Alignment 상태

| Alignment status | Count |
|---|---:|
| aligned | 8372 |
| replace | 438 |

> 일부 구간에서 source/disassembly stream이 insert/delete/replace로 재정렬되었습니다. 해당 구간은 주변 instruction까지 함께 확인해야 합니다.

## 6. 교수님 피드백 기준 그룹

| Category | Source form | Count | Example source | Example objdump | Error judgment |
|---|---|---:|---|---|---|
| `far_pointer_size_repr_changed` | `LFS r64,m16:64` | 10 | `lfs r9, TBYTE PTR [rax]` | `lfs r9,FWORD PTR [rax]` | review: TBYTE/FWORD representation |
| `far_pointer_size_repr_changed` | `LGS r64,m16:64` | 10 | `lgs rbx, TBYTE PTR [rip + 0x1000]` | `lgs rbx,FWORD PTR [rip+0x1000] # 0x663f` | review: TBYTE/FWORD representation |
| `far_pointer_size_repr_changed` | `LSS r64,m16:64` | 10 | `lss r11, TBYTE PTR [rip + 0x1000]` | `lss r11,FWORD PTR [rip+0x1000] # 0x64bf` | review: TBYTE/FWORD representation |
| `register_width_changed` | `MOV Sreg, r16` | 10 | `mov cs, di` | `mov cs,edi` | review: encoding/register-width |
| `register_width_changed` | `MOV Sreg, r64` | 10 | `mov ss, rbx` | `mov ss,ebx` | review: encoding/register-width |
| `register_width_changed` | `MOV r64/m16, Sreg` | 9 | `mov r8, fs` | `mov r8d,fs` | review: encoding/register-width |
| `register_width_changed` | `LKGS r16` | 6 | `lkgs ax` | `lkgs eax` | review: encoding/register-width |
| `register_width_changed` | `LLDT r16` | 6 | `lldt ax` | `lldt eax` | review: encoding/register-width |
| `register_width_changed` | `LTR r16` | 6 | `ltr di` | `ltr edi` | review: encoding/register-width |
| `register_width_changed` | `LSL r64, r32/m16` | 4 | `lsl r13, WORD PTR [rbx]` | `lsl r13d,WORD PTR [rbx]` | review: encoding/register-width |
| `mnemonic_changed` | `REPE CMPS m16, m16` | 1 | `repe cmpsw` | `repz cmps WORD PTR ds:[rsi],WORD PTR es:[rdi]` | review |
| `mnemonic_changed` | `REPE CMPS m32, m32` | 1 | `repe cmpsd` | `repz cmps DWORD PTR ds:[rsi],DWORD PTR es:[rdi]` | review |
| `mnemonic_changed` | `REPE CMPS m64, m64` | 1 | `repe cmpsq` | `repz cmps QWORD PTR ds:[rsi],QWORD PTR es:[rdi]` | review |
| `mnemonic_changed` | `REPE CMPS m8, m8` | 1 | `repe cmpsb` | `repz cmps BYTE PTR ds:[rsi],BYTE PTR es:[rdi]` | review |
| `mnemonic_changed` | `REPE SCAS m16` | 1 | `repe scasw` | `repz scas ax,WORD PTR es:[rdi]` | review |
| `mnemonic_changed` | `REPE SCAS m32` | 1 | `repe scasd` | `repz scas eax,DWORD PTR es:[rdi]` | review |
| `mnemonic_changed` | `REPE SCAS m64` | 1 | `repe scasq` | `repz scas rax,QWORD PTR es:[rdi]` | review |
| `mnemonic_changed` | `REPE SCAS m8` | 1 | `repe scasb` | `repz scas al,BYTE PTR es:[rdi]` | review |
| `mnemonic_changed` | `REPNE CMPS m16, m16` | 1 | `repne cmpsw` | `repnz cmps WORD PTR ds:[rsi],WORD PTR es:[rdi]` | review |
| `mnemonic_changed` | `REPNE CMPS m32, m32` | 1 | `repne cmpsd` | `repnz cmps DWORD PTR ds:[rsi],DWORD PTR es:[rdi]` | review |
| `mnemonic_changed` | `REPNE CMPS m64, m64` | 1 | `repne cmpsq` | `repnz cmps QWORD PTR ds:[rsi],QWORD PTR es:[rdi]` | review |
| `mnemonic_changed` | `REPNE CMPS m8, m8` | 1 | `repne cmpsb` | `repnz cmps BYTE PTR ds:[rsi],BYTE PTR es:[rdi]` | review |
| `mnemonic_changed` | `REPNE SCAS m16` | 1 | `repne scasw` | `repnz scas ax,WORD PTR es:[rdi]` | review |
| `mnemonic_changed` | `REPNE SCAS m32` | 1 | `repne scasd` | `repnz scas eax,DWORD PTR es:[rdi]` | review |
| `mnemonic_changed` | `REPNE SCAS m64` | 1 | `repne scasq` | `repnz scas rax,QWORD PTR es:[rdi]` | review |
| `mnemonic_changed` | `REPNE SCAS m8` | 1 | `repne scasb` | `repnz scas al,BYTE PTR es:[rdi]` | review |
| `operand_size_changed` | `REP INS m16, DX` | 1 | `rep insw` | `rep ins WORD PTR es:[rdi],dx` | review |
| `operand_size_changed` | `REP INS m32, DX` | 1 | `rep insd` | `rep ins DWORD PTR es:[rdi],dx` | review |
| `operand_size_changed` | `REP INS m8, DX` | 1 | `rep insb` | `rep ins BYTE PTR es:[rdi],dx` | review |
| `operand_size_changed` | `REP LODS AL` | 1 | `rep lodsb` | `rep lods al,BYTE PTR ds:[rsi]` | review |
| `operand_size_changed` | `REP LODS AX` | 1 | `rep lodsw` | `rep lods ax,WORD PTR ds:[rsi]` | review |
| `operand_size_changed` | `REP LODS EAX` | 1 | `rep lodsd` | `rep lods eax,DWORD PTR ds:[rsi]` | review |
| `operand_size_changed` | `REP LODS RAX` | 1 | `rep lodsq` | `rep lods rax,QWORD PTR ds:[rsi]` | review |
| `operand_size_changed` | `REP MOVS m16, m16` | 1 | `rep movsw` | `rep movs WORD PTR es:[rdi],WORD PTR ds:[rsi]` | review |
| `operand_size_changed` | `REP MOVS m32, m32` | 1 | `rep movsd` | `rep movs DWORD PTR es:[rdi],DWORD PTR ds:[rsi]` | review |
| `operand_size_changed` | `REP MOVS m64, m64` | 1 | `rep movsq` | `rep movs QWORD PTR es:[rdi],QWORD PTR ds:[rsi]` | review |
| `operand_size_changed` | `REP MOVS m8, m8` | 1 | `rep movsb` | `rep movs BYTE PTR es:[rdi],BYTE PTR ds:[rsi]` | review |
| `operand_size_changed` | `REP OUTS DX, m16` | 1 | `rep outsw` | `rep outs dx,WORD PTR ds:[rsi]` | review |
| `operand_size_changed` | `REP OUTS DX, m32` | 1 | `rep outsd` | `rep outs dx,DWORD PTR ds:[rsi]` | review |
| `operand_size_changed` | `REP OUTS DX, m8` | 1 | `rep outsb` | `rep outs dx,BYTE PTR ds:[rsi]` | review |

## 7. 추가 확인 필요 예시

| Index | Align | Category | Source form | Source | Objdump | Opcode bytes |
|---:|---|---|---|---|---|---|
| 4565 | replace | far_pointer_size_repr_changed | `LSS r64,m16:64` | `lss r11, TBYTE PTR [rip + 0x1000]` | `lss r11,FWORD PTR [rip+0x1000] # 0x64bf` | `4c 0f b2 1d 00 10 00` |
| 4566 | replace | far_pointer_size_repr_changed | `LSS r64,m16:64` | `lss rcx, TBYTE PTR [rax + rbx*1 + 0x10]` | `lss rcx,FWORD PTR [rax+rbx*1+0x10]` | `48 0f b2 4c 18 10` |
| 4567 | replace | far_pointer_size_repr_changed | `LSS r64,m16:64` | `lss rbx, TBYTE PTR [rax + rbx*1 + 0x10]` | `lss rbx,FWORD PTR [rax+rbx*1+0x10]` | `48 0f b2 5c 18 10` |
| 4568 | replace | far_pointer_size_repr_changed | `LSS r64,m16:64` | `lss rbx, TBYTE PTR [rbx]` | `lss rbx,FWORD PTR [rbx]` | `48 0f b2 1b` |
| 4569 | replace | far_pointer_size_repr_changed | `LSS r64,m16:64` | `lss rsi, TBYTE PTR [rip + 0x1000]` | `lss rsi,FWORD PTR [rip+0x1000] # 0x64d7` | `48 0f b2 35 00 10 00` |
| 4570 | replace | far_pointer_size_repr_changed | `LSS r64,m16:64` | `lss rax, TBYTE PTR [rax]` | `lss rax,FWORD PTR [rax]` | `48 0f b2 00` |
| 4571 | replace | far_pointer_size_repr_changed | `LSS r64,m16:64` | `lss r9, TBYTE PTR [rax + rbx*1 + 0x10]` | `lss r9,FWORD PTR [rax+rbx*1+0x10]` | `4c 0f b2 4c 18 10` |
| 4572 | replace | far_pointer_size_repr_changed | `LSS r64,m16:64` | `lss r12, TBYTE PTR [rax + rbx*4 + 0x100]` | `lss r12,FWORD PTR [rax+rbx*4+0x100]` | `4c 0f b2 a4 98 00 01` |
| 4573 | replace | far_pointer_size_repr_changed | `LSS r64,m16:64` | `lss r12, TBYTE PTR [rip + 0x1000]` | `lss r12,FWORD PTR [rip+0x1000] # 0x64f2` | `4c 0f b2 25 00 10 00` |
| 4574 | replace | far_pointer_size_repr_changed | `LSS r64,m16:64` | `lss r8, TBYTE PTR [rax + rbx*1 + 0x10]` | `lss r8,FWORD PTR [rax+rbx*1+0x10]` | `4c 0f b2 44 18 10` |
| 4595 | replace | far_pointer_size_repr_changed | `LFS r64,m16:64` | `lfs r9, TBYTE PTR [rax]` | `lfs r9,FWORD PTR [rax]` | `4c 0f b4 08` |
| 4596 | replace | far_pointer_size_repr_changed | `LFS r64,m16:64` | `lfs rsi, TBYTE PTR [rax + rbx*4 + 0x100]` | `lfs rsi,FWORD PTR [rax+rbx*4+0x100]` | `48 0f b4 b4 98 00 01` |
| 4597 | replace | far_pointer_size_repr_changed | `LFS r64,m16:64` | `lfs rdi, TBYTE PTR [rax + rbx*4 + 0x100]` | `lfs rdi,FWORD PTR [rax+rbx*4+0x100]` | `48 0f b4 bc 98 00 01` |
| 4598 | replace | far_pointer_size_repr_changed | `LFS r64,m16:64` | `lfs rbx, TBYTE PTR [rip + 0x1000]` | `lfs rbx,FWORD PTR [rip+0x1000] # 0x6594` | `48 0f b4 1d 00 10 00` |
| 4599 | replace | far_pointer_size_repr_changed | `LFS r64,m16:64` | `lfs r9, TBYTE PTR [rbx]` | `lfs r9,FWORD PTR [rbx]` | `4c 0f b4 0b` |
| 4600 | replace | far_pointer_size_repr_changed | `LFS r64,m16:64` | `lfs r12, TBYTE PTR [rax + rbx*4 + 0x100]` | `lfs r12,FWORD PTR [rax+rbx*4+0x100]` | `4c 0f b4 a4 98 00 01` |
| 4601 | replace | far_pointer_size_repr_changed | `LFS r64,m16:64` | `lfs r9, TBYTE PTR [rip + 0x1000]` | `lfs r9,FWORD PTR [rip+0x1000] # 0x65a9` | `4c 0f b4 0d 00 10 00` |
| 4602 | replace | far_pointer_size_repr_changed | `LFS r64,m16:64` | `lfs r12, TBYTE PTR [rax]` | `lfs r12,FWORD PTR [rax]` | `4c 0f b4 20` |
| 4603 | replace | far_pointer_size_repr_changed | `LFS r64,m16:64` | `lfs r10, TBYTE PTR [rip + 0x1000]` | `lfs r10,FWORD PTR [rip+0x1000] # 0x65b5` | `4c 0f b4 15 00 10 00` |
| 4604 | replace | far_pointer_size_repr_changed | `LFS r64,m16:64` | `lfs r11, TBYTE PTR [rip + 0x1000]` | `lfs r11,FWORD PTR [rip+0x1000] # 0x65bd` | `4c 0f b4 1d 00 10 00` |
| 4625 | replace | far_pointer_size_repr_changed | `LGS r64,m16:64` | `lgs rbx, TBYTE PTR [rip + 0x1000]` | `lgs rbx,FWORD PTR [rip+0x1000] # 0x663f` | `48 0f b5 1d 00 10 00` |
| 4626 | replace | far_pointer_size_repr_changed | `LGS r64,m16:64` | `lgs r8, TBYTE PTR [rax + rbx*4 + 0x100]` | `lgs r8,FWORD PTR [rax+rbx*4+0x100]` | `4c 0f b5 84 98 00 01` |
| 4627 | replace | far_pointer_size_repr_changed | `LGS r64,m16:64` | `lgs r11, TBYTE PTR [rip + 0x1000]` | `lgs r11,FWORD PTR [rip+0x1000] # 0x6650` | `4c 0f b5 1d 00 10 00` |
| 4628 | replace | far_pointer_size_repr_changed | `LGS r64,m16:64` | `lgs r12, TBYTE PTR [rax + rbx*1 + 0x10]` | `lgs r12,FWORD PTR [rax+rbx*1+0x10]` | `4c 0f b5 64 18 10` |
| 4629 | replace | far_pointer_size_repr_changed | `LGS r64,m16:64` | `lgs rdi, TBYTE PTR [rip + 0x100]` | `lgs rdi,FWORD PTR [rip+0x100] # 0x575e` | `48 0f b5 3d 00 01 00` |
| 4630 | replace | far_pointer_size_repr_changed | `LGS r64,m16:64` | `lgs rsi, TBYTE PTR [rip + 0x100]` | `lgs rsi,FWORD PTR [rip+0x100] # 0x5766` | `48 0f b5 35 00 01 00` |
| 4631 | replace | far_pointer_size_repr_changed | `LGS r64,m16:64` | `lgs rdx, TBYTE PTR [rip + 0x1000]` | `lgs rdx,FWORD PTR [rip+0x1000] # 0x666e` | `48 0f b5 15 00 10 00` |
| 4632 | replace | far_pointer_size_repr_changed | `LGS r64,m16:64` | `lgs rax, TBYTE PTR [rax + rbx*4 + 0x100]` | `lgs rax,FWORD PTR [rax+rbx*4+0x100]` | `48 0f b5 84 98 00 01` |
| 4633 | replace | far_pointer_size_repr_changed | `LGS r64,m16:64` | `lgs rsi, TBYTE PTR [rax]` | `lgs rsi,FWORD PTR [rax]` | `48 0f b5 30` |
| 4634 | replace | far_pointer_size_repr_changed | `LGS r64,m16:64` | `lgs rdx, TBYTE PTR [rip + 0x100]` | `lgs rdx,FWORD PTR [rip+0x100] # 0x5783` | `48 0f b5 15 00 01 00` |
| 4672 | replace | register_width_changed | `LKGS r16` | `lkgs ax` | `lkgs eax` | `f2 0f 00 f0` |
| 4673 | replace | register_width_changed | `LKGS r16` | `lkgs dx` | `lkgs edx` | `f2 0f 00 f2` |
| 4674 | replace | register_width_changed | `LKGS r16` | `lkgs bx` | `lkgs ebx` | `f2 0f 00 f3` |
| 4675 | replace | register_width_changed | `LKGS r16` | `lkgs di` | `lkgs edi` | `f2 0f 00 f7` |
| 4676 | replace | register_width_changed | `LKGS r16` | `lkgs cx` | `lkgs ecx` | `f2 0f 00 f1` |
| 4677 | replace | register_width_changed | `LKGS r16` | `lkgs si` | `lkgs esi` | `f2 0f 00 f6` |
| 4684 | replace | register_width_changed | `LLDT r16` | `lldt ax` | `lldt eax` | `0f 00 d0` |
| 4685 | replace | register_width_changed | `LLDT r16` | `lldt di` | `lldt edi` | `0f 00 d7` |
| 4686 | replace | register_width_changed | `LLDT r16` | `lldt si` | `lldt esi` | `0f 00 d6` |
| 4687 | replace | register_width_changed | `LLDT r16` | `lldt cx` | `lldt ecx` | `0f 00 d1` |

## 8. 분류 기준

- `exact_match`: 원본과 역어셈블 결과가 정규화 후 동일하다.
- `alias`: 의미상 같은 명령어가 별칭 또는 축약 표기로 출력된 정상 케이스다.
- `relative_target_resolved`: `.` 같은 상대주소가 objdump에서 실제 target address로 출력된 정상 케이스다.
- `generic_memory_size_inferred`: SDM form uses generic `m`; objdump inferred/printed a concrete PTR size.
- `effective_address_size_directive_changed`: `LEA` uses an effective address, so PTR size text is not semantic.
- `moffset_size_inferred`: moffset size was inferred from the register operand and printed by objdump.
- `far_pointer_size_repr_changed`: far-memory pointer text changed, especially `m16:64` TBYTE/FWORD cases; review separately.
- `bug_candidate`: opcode byte 기준으로 기대 immediate width보다 짧게 조립된 것으로 보이는 케이스다.
- `immediate_repr_changed`: immediate/displacement 값 표기가 달라졌다. 값/크기 변화 여부를 확인해야 한다.
- `operand_size_changed`: memory operand size가 바뀌었을 가능성이 있다.
- `register_width_changed`: register width가 바뀌었을 가능성이 있다.
- `mnemonic_changed`: mnemonic 자체가 달라졌다.
- `operand_changed`: mnemonic은 같지만 operand 구조가 달라졌다.
- `missing_disassembly` / `extra_disassembly`: 원본과 역어셈블 instruction 개수가 다르다.

## 9. Alignment 기준

- `aligned`: 정규화된 instruction stream에서 같은 위치로 매칭된 행이다.
- `replace`: source와 disassembly가 같은 구간에 있으나 내용이 달라 paired 비교한 행이다.
- `delete` / `insert`: 한쪽 stream에만 존재하는 행이다.
- `replace_delete` / `replace_insert`: replace block 안에서 한쪽이 더 길어 남은 행이다.

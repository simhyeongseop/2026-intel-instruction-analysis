# N.E./N.S./Invalid 케이스 실제 CPU 실행 결과 (12단계)

SDM이 mode_support=Invalid/N.E./N.S.로 명시했는데 `as`가 실제로 어셈블에 성공한 케이스들을 실제로 실행해봤다. 레지스터는 커널이 준 초기값 그대로
(레지스터 덤프로 확인하진 않았으나 유효하다고 보장되지 않는 값)이고 따로 설정하지 않았다 - '무슨 일이 일어나는지 관찰'이 목적이지
'특정 결과를 재현'하려는 게 아니다.

## 결과 분포

| outcome | 건수 |
|---|---|
| exit0 | 16 |
| SIGSEGV | 13 |

## 전체 케이스

| combo_id | mnemonic | asm_line | mode_support | outcome |
|---|---|---|---|---|
| 323 | bndcl | `bndcl bnd0, dword ptr [rax]` | N.E. | **exit0** |
| 327 | bndcu | `bndcu bnd0, dword ptr [rax]` | N.E. | **exit0** |
| 331 | bndcn | `bndcn bnd0, dword ptr [rax]` | N.E. | **exit0** |
| 335 | bndmk | `bndmk bnd0, dword ptr [rax]` | N.E. | **exit0** |
| 337 | bndmov | `bndmov bnd0, bnd0` | N.E. | **exit0** |
| 21095 | bndmov | `bndmov bnd0, bnd1` | N.E. | **exit0** |
| 341 | bndmov | `bndmov bnd0, bnd0` | N.E. | **exit0** |
| 21097 | bndmov | `bndmov bnd0, bnd1` | N.E. | **exit0** |
| 419 | call | `call dword ptr [eax]` | N.E. | **SIGSEGV** |
| 7832 | call | `call dword ptr [rax+rbx*4+0x10]` | N.E. | **SIGSEGV** |
| 7833 | call | `call dword ptr [rip+0x10]` | N.E. | **SIGSEGV** |
| 970 | dec | `dec cx` | N.E. | **exit0** |
| 971 | dec | `dec ecx` | N.E. | **exit0** |
| 1308 | inc | `inc cx` | N.E. | **exit0** |
| 1309 | inc | `inc ecx` | N.E. | **exit0** |
| 1436 | jmp | `jmp dword ptr [eax]` | N.S. | **SIGSEGV** |
| 9026 | jmp | `jmp dword ptr [rax+rbx*4+0x10]` | N.S. | **SIGSEGV** |
| 9027 | jmp | `jmp dword ptr [rip+0x10]` | N.S. | **SIGSEGV** |
| 1511 | lahf | `lahf` | Invalid | **exit0** |
| 1541 | leave | `leave` | N.E. | **SIGSEGV** |
| 1544 | lgdt | `lgdt [eax]` | N.E. | **SIGSEGV** |
| 9104 | lgdt | `lgdt [rax+rbx*4+0x10]` | N.E. | **SIGSEGV** |
| 9105 | lgdt | `lgdt [rip+0x10]` | N.E. | **SIGSEGV** |
| 1545 | lidt | `lidt [eax]` | N.E. | **SIGSEGV** |
| 9106 | lidt | `lidt [rax+rbx*4+0x10]` | N.E. | **SIGSEGV** |
| 9107 | lidt | `lidt [rip+0x10]` | N.E. | **SIGSEGV** |
| 3294 | pop | `pop fs` | N.E. | **exit0** |
| 3297 | pop | `pop gs` | N.E. | **exit0** |
| 4122 | sahf | `sahf` | Invalid | **exit0** |


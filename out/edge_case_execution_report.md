# N.E./N.S./Invalid 케이스 실제 CPU 실행 결과 (12단계)

SDM이 mode_support=Invalid/N.E./N.S.로 명시했는데 `as`가 실제로 어셈블에 성공한 케이스들을 실제로 실행해봤다. 레지스터는 커널이 준 초기값 그대로
(레지스터 덤프로 확인하진 않았으나 유효하다고 보장되지 않는 값)이고 따로 설정하지 않았다 - '무슨 일이 일어나는지 관찰'이 목적이지
'특정 결과를 재현'하려는 게 아니다.

## 결과 분포

| outcome | 건수 |
|---|---|
| exit0 | 14 |
| SIGSEGV | 5 |

## 전체 케이스

| combo_id | mnemonic | asm_line | mode_support | outcome |
|---|---|---|---|---|
| 323 | BNDCL | `bndcl bnd0, dword ptr [rax]` | N.E. | **exit0** |
| 327 | BNDCU | `bndcu bnd0, dword ptr [rax]` | N.E. | **exit0** |
| 331 | BNDCN | `bndcn bnd0, dword ptr [rax]` | N.E. | **exit0** |
| 335 | BNDMK | `bndmk bnd0, dword ptr [rax]` | N.E. | **exit0** |
| 337 | BNDMOV | `bndmov bnd0, bnd0` | N.E. | **exit0** |
| 341 | BNDMOV | `bndmov bnd0, bnd0` | N.E. | **exit0** |
| 419 | CALL | `call dword ptr [eax]` | N.E. | **SIGSEGV** |
| 970 | DEC | `dec cx` | N.E. | **exit0** |
| 971 | DEC | `dec ecx` | N.E. | **exit0** |
| 1308 | INC | `inc cx` | N.E. | **exit0** |
| 1309 | INC | `inc ecx` | N.E. | **exit0** |
| 1436 | JMP | `jmp dword ptr [eax]` | N.S. | **SIGSEGV** |
| 1511 | LAHF | `lahf` | Invalid | **exit0** |
| 1541 | LEAVE | `leave` | N.E. | **SIGSEGV** |
| 1544 | LGDT | `lgdt [eax]` | N.E. | **SIGSEGV** |
| 1545 | LIDT | `lidt [eax]` | N.E. | **SIGSEGV** |
| 3294 | POP | `pop fs` | N.E. | **exit0** |
| 3297 | POP | `pop gs` | N.E. | **exit0** |
| 4122 | SAHF | `sahf` | Invalid | **exit0** |


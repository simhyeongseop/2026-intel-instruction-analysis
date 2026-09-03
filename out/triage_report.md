# Triage 리포트 (7단계)

- 전체 대상: 1585건 (컴파일 에러 + mismatch + roundtrip 차이, combo_id 기준 중복 제거)
- verdict 분포: bug=4, false_alarm=1557, unsure=24

## 진짜 의심되는 버그 후보 (verdict=bug)

도구(as/objdump) 직접 재현 + SDM PDF 원문 대조까지 마친 것만 bug로 표시했다.

### UDB (source 4605/4597)
- 분류: gas_missing_mnemonic
- objdump/error: line.s: Assembler messages: | line.s:3: Error: no such instruction: `udb'
- 원인: SDM p.1436에 'D6 UDB' 오피코드가 64비트 모드 Valid로 명시돼 있으나(UD0/UD1/UD2와 같은 계열) GNU as는 'udb'라는 니모닉 자체를 모른다('no such instruction: udb'). 2026-09-03 codex 재검증에서도 CONFIRMED(SDM Exceptions 섹션에도 'UDB does so only in 64-bit mode'로 UDB를 직접 언급 - 오탈자 아님).

### LSS (source 1535/1527)
- 분류: objdump_farptr_size_ignores_rexw
- objdump/error: lss    rcx,FWORD PTR [eax]
- 원인: 2026-08-25 확인(10단계 reassemble_check + codex 교차검증), 2026-09-03 정밀도 정정(codex 재검토): 이전엔 register_width/name_changed로 unsure 처리돼 있었다. `lss rcx, m16:64`(REX.W + 0F B2 /r)를 as가 SDM 그대로 정확히 인코딩(67 48 0f b2 08, ModRM reg=1=rcx)했는데 objdump가 메모리 크기를 REX.W로 승격된 r64 폼에서만 항상 FWORD PTR(6바이트, m16:32 크기)로 표시한다 - m16:64는 10바이트라 TBYTE PTR이어야 한다(r16/r32 폼은 각각 DWORD/FWORD로 정확히 표시됨, REX.W 유무와 무관하게 항상 틀린 게 아니라 REX.W 승격 폼에서만 오표기됨). 그 표시 텍스트를 그대로 다시 어셈블하면 as가 "incorrect register `rcx' used with `l' suffix"로 거부하는 것이 간접 증거(as 자신은 rcx엔 FWORD(l)가 아니라 TBYTE가 맞다고 알고 있음). 추가 증거: LLVM 19.1.1의 llvm-objdump는 같은 바이트를 Intel 모드에서 크기 키워드 없이 `lss rcx, [eax]`로, AT&T 모드는 `lssq (%eax), %rcx`(64비트 폭을 접미사로 암시)로 표시해 이 오표기를 하지 않음 - 독립된 2번째 디스어셈블러도 안 하는 GNU objdump만의 결함. as의 인코딩이 아니라 objdump의 디스어셈블 표시 결함.

### LFS (source 1540/1532)
- 분류: objdump_farptr_size_ignores_rexw
- objdump/error: lfs    rcx,FWORD PTR [eax]
- 원인: combo 1527(LSS)과 동일 패턴, LFS(REX.W + 0F B4 /r).

### LGS (source 1543/1535)
- 분류: objdump_farptr_size_ignores_rexw
- objdump/error: lgs    rcx,FWORD PTR [eax]
- 원인: combo 1527(LSS)과 동일 패턴, LGS(REX.W + 0F B5 /r).

## 그룹별 건수

| 분류(category) | 건수 | verdict 분포 |
|---|---|---|
| numeric_repr | 810 | false_alarm=810 |
| mnemonic_alias | 274 | false_alarm=274 |
| size_directive_inferred/omitted | 91 | false_alarm=91 |
| implicit_operand_display | 87 | false_alarm=87 |
| relative_target_absolute_display | 42 | false_alarm=42 |
| compile_error_expected_rejection_unclassified | 41 | false_alarm=41 |
| fpu_stack_register_display | 41 | false_alarm=41 |
| compile_error_operand_size_mismatch | 33 | false_alarm=33 |
| generator_did_not_target_invalid_variant | 33 | false_alarm=33 |
| encoding_form_annotation | 22 | false_alarm=22 |
| combiner_raw_notation_literal | 19 | false_alarm=19 |
| implicit_operand_added_by_generator | 15 | false_alarm=15 |
| register_width/name_changed | 11 | unsure=11 |
| imm_value_truncated_by_generator | 10 | false_alarm=10 |
| duplicate_encoding_row_same_syntax | 9 | false_alarm=9 |
| combiner_implicit_operand_as_explicit | 7 | false_alarm=7 |
| operand_count/order_changed | 7 | false_alarm=7 |
| mismatch_assembler_more_permissive | 6 | unsure=6 |
| gas_ambiguous_bare_mnemonic | 4 | unsure=4 |
| objdump_farptr_size_ignores_rexw | 3 | bug=3 |
| sib_addressing_display | 3 | false_alarm=3 |
| ambiguous_syntax_resolved_to_valid_far_form | 2 | false_alarm=2 |
| cpuid_conditional_availability_not_captured | 2 | false_alarm=2 |
| ambiguous_syntax_resolved_to_valid_symmetric_form | 2 | false_alarm=2 |
| extractor_artifact_stray_text | 2 | false_alarm=2 |
| sdm_gather_scatter_vsib_width_asymmetry | 2 | unsure=2 |
| encoding_falls_back_to_nop | 2 | false_alarm=2 |
| gas_register_width_stricter_than_manual | 1 | unsure=1 |
| gas_missing_mnemonic | 1 | bug=1 |
| combiner_mode_invalid_register_choice | 1 | false_alarm=1 |
| sdm_table_typo_memory_size | 1 | false_alarm=1 |
| size_directive_name_changed | 1 | false_alarm=1 |

## 그룹별 대표 샘플

### numeric_repr (810건)

- `ADC` (source 15/6, verdict=false_alarm): adc    al,0x1
- `ADC` (source 19/10, verdict=false_alarm): adc    cl,0x1
- `ADC` (source 20/11, verdict=false_alarm): adc    BYTE PTR [eax],0x1

원인: 즉시값 표기가 10진(1)->16진(0x1)으로 바뀐 것뿐, 값 자체는 동일 - 버그 아님.

### mnemonic_alias (274건)

- `CMOVC` (source 475/466, verdict=false_alarm): cmovb  cx,cx
- `CMOVC` (source 476/467, verdict=false_alarm): cmovb  cx,WORD PTR [eax]
- `CMOVC` (source 477/468, verdict=false_alarm): cmovb  ecx,ecx

원인: 조건부 분기/이동/비교(jnz->jne, cmovnge->cmovl 등)나 sal->shl, wait->fwait, popfq->popf, xacquire/xrelease->repnz/repz 같은 동일 오피코드의 다른 이름(alias) - 버그 아님.

### size_directive_inferred/omitted (91건)

- `CALL` (source 433/424, verdict=false_alarm): call   FWORD PTR [eax]
- `CALL` (source 434/425, verdict=false_alarm): call   FWORD PTR [eax]
- `CALL` (source 435/426, verdict=false_alarm): call   FWORD PTR [eax]

원인: 소스에 크기 지시자(byte/word/... ptr)를 생략했는데 objdump가 채워서 보여주거나, 반대로 오퍼랜드 크기가 고정된 명령이라 objdump가 불필요한 크기 지시자를 생략함 - 버그 아님.

### implicit_operand_display (87건)

- `CMPS` (source 721/712, verdict=false_alarm): cmps   BYTE PTR ds:[esi],BYTE PTR es:[edi]
- `CMPS` (source 722/713, verdict=false_alarm): cmps   WORD PTR ds:[esi],WORD PTR es:[edi]
- `CMPS` (source 723/714, verdict=false_alarm): cmps   DWORD PTR ds:[esi],DWORD PTR es:[edi]

원인: string 명령어(movs/lods/stos/scas/cmps/ins/outs/xlat)는 소스에 오퍼랜드를 안 쓰거나 크기 접미사(movsb 등)로만 써도 objdump는 실제 암묵 오퍼랜드(es:[rdi], ds:[rsi] 등)를 explicit하게 풀어서 보여줌 - alias/표기 차이, 버그 아님.

### relative_target_absolute_display (42건)

- `CALL` (source 424/415, verdict=false_alarm): call   0x0
- `JA` (source 1343/1335, verdict=false_alarm): ja     0x0
- `JAE` (source 1344/1336, verdict=false_alarm): jae    0x0

원인: 상대 분기 대상이 소스에서는 라벨(.Ltarget)이었는데 objdump는 절대주소(0x0 등)로 보여줌 - objdump가 라벨을 복원할 방법이 없어서 생기는 표기 차이, 버그 아님.

### compile_error_expected_rejection_unclassified (41건)

- `AAA` (source 9/0, verdict=false_alarm): line.s: Assembler messages: | line.s:3: Error: `aaa' is not supported in 64-bit mode
- `AAD` (source 10/1, verdict=false_alarm): line.s: Assembler messages: | line.s:3: Error: `aad' is not supported in 64-bit mode
- `AAD` (source 11/2, verdict=false_alarm): line.s: Assembler messages: | line.s:3: Error: `aad' is not supported in 64-bit mode

원인: 매뉴얼상으로도 이 조합은 Invalid/N.E./N.S.(mode_support=Invalid)로 규정돼 있어 그대로 거부된 것 - 불일치 아님, 정상 동작.

### fpu_stack_register_display (41건)

- `FADD` (source 1056/1048, verdict=false_alarm): fadd   st,st(0)
- `FADD` (source 1057/1049, verdict=false_alarm): fadd   st,st(0)
- `FADDP` (source 1058/1050, verdict=false_alarm): faddp  st(0),st

원인: x87 스택 레지스터의 암묵 st(0)를 objdump가 짧게 'st'로 표기하거나(예: fadd st,st(0)), 반대로 소스에 없는 두 번째 스택 레지스터(st(1) 등)를 명시적으로 보여줌 - 표기 관례 차이, 버그 아님.

### compile_error_operand_size_mismatch (33건)

- `AESDEC256KL` (source 152/143, verdict=false_alarm): line.s: Assembler messages: | line.s:3: Error: operand size mismatch for `aesdec256kl'
- `AESENC256KL` (source 180/171, verdict=false_alarm): line.s: Assembler messages: | line.s:3: Error: operand size mismatch for `aesenc256kl'
- `BNDCL` (source 331/322, verdict=false_alarm): line.s: Assembler messages: | line.s:3: Error: operand size mismatch for `bndcl'

원인: m512/m512byte처럼 고정 크기인 legacy 메모리 오퍼랜드에 combiner가 불필요한 크기 접두어(zmmword ptr)를 붙여서 발생 - 직접 확인: 크기 접두어 없이 '[eax]'만 쓰면 정상 어셈블됨(false_alarm)

### generator_did_not_target_invalid_variant (33건)

- `CALL` (source 423/414, verdict=false_alarm): (as 성공 - 매뉴얼상 Invalid/N.E./N.S.인데 성공) | roundtrip objdump: call   0x0
- `JA` (source 1376/1368, verdict=false_alarm): (as 성공 - 매뉴얼상 Invalid/N.E./N.S.인데 성공) | roundtrip objdump: ja     0x0
- `JAE` (source 1378/1370, verdict=false_alarm): (as 성공 - 매뉴얼상 Invalid/N.E./N.S.인데 성공) | roundtrip objdump: jae    0x0

원인: SDM상 rel16(16비트 상대주소, N.S.) 폼을 테스트하려던 행이었지만 generator가 크기 힌트 없이 '.Ltarget' 라벨만 사용해 as가 기본으로 유효한 rel32를 선택함 - 무효 폼을 실제로 인코딩하도록 강제한 게 아니므로 '성공'은 당연함(false_alarm). [roundtrip 차이도 있음: relative_target_absolute_display - 상대 분기 대상이 소스에서는 라벨(.Ltarget)이었는데 objdump는 절대주소(0x0 등)로 보여줌 - objdump가 라벨을 복원할 방법이 없어서 생기는 표기 차이, 버그 아님.]

### encoding_form_annotation (22건)

- `VPSLLDQ` (source 3439/3431, verdict=false_alarm): {evex} vpslldq xmm0,XMMWORD PTR [eax],0x1
- `VPSLLDQ` (source 3441/3433, verdict=false_alarm): {evex} vpslldq ymm0,YMMWORD PTR [eax],0x1
- `VPSLLW` (source 3487/3479, verdict=false_alarm): {evex} vpsllw xmm0,XMMWORD PTR [eax],0x1

원인: 동일한 텍스트 니모닉이 VEX/EVEX 두 가지로 인코딩될 수 있어 objdump가 EVEX로 인코딩된 쪽에 '{evex}' 태그를 붙여 구분함 - 인코딩 선택 표시일 뿐, 버그 아님.

### combiner_raw_notation_literal (19건)

- `VPAND` (source 2511/2503, verdict=false_alarm): line.s: Assembler messages: | line.s:3: Error: invalid use of register
- `VP2INTERSECTD` (source 5942/5934, verdict=false_alarm): line.s: Assembler messages: | line.s:3: Error: invalid use of register
- `VP2INTERSECTD` (source 5943/5935, verdict=false_alarm): line.s: Assembler messages: | line.s:3: Error: invalid use of register

원인: isa_db 원문 자체에 'ymm3/.m256'처럼 불필요한 점(.)이 있음 - PDF 원문(p.923) pdfplumber 추출 결과에도 동일하게 나타나 그대로 as 입력이 됨(국소 1건, PDF 텍스트 추출 특성으로 추정)

### implicit_operand_added_by_generator (15건)

- `BNDCL` (source 334/325, verdict=false_alarm): bndcl  bnd0,[rax]
- `BNDCU` (source 338/329, verdict=false_alarm): bndcu  bnd0,[rax]
- `BNDCN` (source 342/333, verdict=false_alarm): bndcn  bnd0,[rax]

원인: combiner가 SDM의 <EDX>,<EAX> 같은 암묵 오퍼랜드를 실제 오퍼랜드로 잘못 방출했는데, 이 명령어(umwait/tpause 등)는 as가 초과 오퍼랜드를 에러 없이 그냥 무시함 - compile_error 쪽의 combiner_implicit_operand_as_explicit와 같은 뿌리의 combiner 한계.

### register_width/name_changed (11건)

- `LKGS` (source 1556/1548, verdict=unsure): lkgs   ecx
- `LLDT` (source 1558/1550, verdict=unsure): lldt   ecx
- `LSL` (source 1580/1572, verdict=unsure): lsl    ecx,WORD PTR [eax]

원인: 레지스터 폭 표기가 바뀜(예: mov ds,cx -> mov ds,ecx, lldt cx -> lldt ecx, movsxd cx,cx -> movsxd cx,ecx). 해당 opcode가 레지스터 폭에 무관하게 동일하게 동작하는지 아직 as 소스/SDM 각주까지 다 대조하지 못해 판단보류.

### imm_value_truncated_by_generator (10건)

- `MOV` (source 1692/1684, verdict=false_alarm): mov    al,BYTE PTR ds:0x1000
- `MOV` (source 1693/1685, verdict=false_alarm): mov    al,BYTE PTR ds:0x1000
- `MOV` (source 1694/1686, verdict=false_alarm): mov    ax,WORD PTR ds:0x1000

원인: generator가 목적지 크기에 안 맞는 고정 즉시값(0x1000 등)을 그대로 써서 as가 조용히 잘라(truncate) 인코딩함 - 테스트케이스 생성 결함(generator), 진짜 8/16비트 truncation 버그가 아니라 애초에 잘못된 입력값 - DEVLOG 2026-07-24 참고.

### duplicate_encoding_row_same_syntax (9건)

- `BNDMOV` (source 346/337, verdict=false_alarm): (as 성공 - 매뉴얼상 Invalid/N.E./N.S.인데 성공)
- `BNDMOV` (source 350/341, verdict=false_alarm): (as 성공 - 매뉴얼상 Invalid/N.E./N.S.인데 성공)
- `DEC` (source 979/970, verdict=false_alarm): (as 성공 - 매뉴얼상 Invalid/N.E./N.S.인데 성공)

원인: SDM 표에 텍스트 니모닉+오퍼랜드가 똑같은데 오피코드/모드지원이 다른 행이 2개 이상 있음(예: DEC ecx의 legacy 1바이트 opcode '48+rd'는 64비트 모드 N.E.지만 ModRM 기반 'FF /1'은 Valid). 파이프라인은 텍스트만 어셈블하므로 as는 항상 인코딩 가능한(Valid) 쪽을 선택함 - 실제 불일치가 아니라 표 중복 표기 때문.

### combiner_implicit_operand_as_explicit (7건)

- `AESDECWIDE128KL` (source 165/156, verdict=false_alarm): line.s: Assembler messages: | line.s:3: Error: number of operands mismatch for `aesdecwide128kl'
- `AESDECWIDE256KL` (source 166/157, verdict=false_alarm): line.s: Assembler messages: | line.s:3: Error: number of operands mismatch for `aesdecwide256kl'
- `AESENCWIDE128KL` (source 193/184, verdict=false_alarm): line.s: Assembler messages: | line.s:3: Error: number of operands mismatch for `aesencwide128kl'

원인: SDM의 <XMM0-7>/<EAX> 같은 암묵 오퍼랜드 표기를 combiner(expand_implicit)가 실제 명시 오퍼랜드로 방출해서 개수가 안 맞음 - combiner 한계

### operand_count/order_changed (7건)

- `XCHG` (source 7141/7133, verdict=false_alarm): xchg   cx,ax
- `XCHG` (source 7143/7135, verdict=false_alarm): xchg   ecx,eax
- `XCHG` (source 7144/7136, verdict=false_alarm): xchg   rcx,rax

원인: 오퍼랜드 순서만 바뀜(예: xchg ax,cx -> xchg cx,ax). XCHG처럼 대칭적인 명령이라 결과는 동일 - 버그 아님.

### mismatch_assembler_more_permissive (6건)

- `BNDCL` (source 332/323, verdict=unsure): (as 성공 - 매뉴얼상 Invalid/N.E./N.S.인데 성공) | roundtrip objdump: bndcl  bnd0,[rax]
- `BNDCU` (source 336/327, verdict=unsure): (as 성공 - 매뉴얼상 Invalid/N.E./N.S.인데 성공) | roundtrip objdump: bndcu  bnd0,[rax]
- `BNDCN` (source 340/331, verdict=unsure): (as 성공 - 매뉴얼상 Invalid/N.E./N.S.인데 성공) | roundtrip objdump: bndcn  bnd0,[rax]

원인: 매뉴얼상 Invalid/N.E./N.S.인데 as가 받아줌 - 원인 미확인, 형섭 직접 확인 필요 [roundtrip 차이도 있음: implicit_operand_added_by_generator - combiner가 SDM의 <EDX>,<EAX> 같은 암묵 오퍼랜드를 실제 오퍼랜드로 잘못 방출했는데, 이 명령어(umwait/tpause 등)는 as가 초과 오퍼랜드를 에러 없이 그냥 무시함 - compile_error 쪽의 combiner_implicit_operand_as_explicit와 같은 뿌리의 combiner 한계.]

### gas_ambiguous_bare_mnemonic (4건)

- `SYSEXIT` (source 4545/4537, verdict=unsure): line.s: Assembler messages: | line.s:3: Error: ambiguous operand size for `sysexit'
- `SYSEXIT` (source 4546/4538, verdict=unsure): line.s: Assembler messages: | line.s:3: Error: ambiguous operand size for `sysexit'
- `SYSRET` (source 4547/4539, verdict=unsure): line.s: Assembler messages: | line.s:3: Error: ambiguous operand size for `sysret'

원인: SYSEXIT/SYSRET을 매뉴얼 그대로(오퍼랜드 없이) 써도 as가 크기를 못 정해 거부함 - 'rex64 sysexit' 같은 프리픽스 트릭을 쓰면 성공(직접 확인). 매뉴얼 문법 그대로는 실패라서 판단보류.

### objdump_farptr_size_ignores_rexw (3건)

- `LSS` (source 1535/1527, verdict=bug): lss    rcx,FWORD PTR [eax]
- `LFS` (source 1540/1532, verdict=bug): lfs    rcx,FWORD PTR [eax]
- `LGS` (source 1543/1535, verdict=bug): lgs    rcx,FWORD PTR [eax]

원인: 2026-08-25 확인(10단계 reassemble_check + codex 교차검증), 2026-09-03 정밀도 정정(codex 재검토): 이전엔 register_width/name_changed로 unsure 처리돼 있었다. `lss rcx, m16:64`(REX.W + 0F B2 /r)를 as가 SDM 그대로 정확히 인코딩(67 48 0f b2 08, ModRM reg=1=rcx)했는데 objdump가 메모리 크기를 REX.W로 승격된 r64 폼에서만 항상 FWORD PTR(6바이트, m16:32 크기)로 표시한다 - m16:64는 10바이트라 TBYTE PTR이어야 한다(r16/r32 폼은 각각 DWORD/FWORD로 정확히 표시됨, REX.W 유무와 무관하게 항상 틀린 게 아니라 REX.W 승격 폼에서만 오표기됨). 그 표시 텍스트를 그대로 다시 어셈블하면 as가 "incorrect register `rcx' used with `l' suffix"로 거부하는 것이 간접 증거(as 자신은 rcx엔 FWORD(l)가 아니라 TBYTE가 맞다고 알고 있음). 추가 증거: LLVM 19.1.1의 llvm-objdump는 같은 바이트를 Intel 모드에서 크기 키워드 없이 `lss rcx, [eax]`로, AT&T 모드는 `lssq (%eax), %rcx`(64비트 폭을 접미사로 암시)로 표시해 이 오표기를 하지 않음 - 독립된 2번째 디스어셈블러도 안 하는 GNU objdump만의 결함. as의 인코딩이 아니라 objdump의 디스어셈블 표시 결함.

### sib_addressing_display (3건)

- `TILELOADD` (source 4576/4568, verdict=false_alarm): tileloadd tmm0,[eax+eiz*1]
- `TILELOADDT1` (source 4577/4569, verdict=false_alarm): tileloaddt1 tmm0,[eax+eiz*1]
- `TILESTORED` (source 4579/4571, verdict=false_alarm): tilestored [eax+eiz*1],tmm0

원인: AMX(tile) 명령어는 항상 SIB 인덱스가 필요해서 소스에 인덱스가 없어도 objdump가 '[eax+eiz*1]'처럼 명시적으로 보여줌 - 표기 차이, 버그 아님.

### ambiguous_syntax_resolved_to_valid_far_form (2건)

- `CALL` (source 428/419, verdict=false_alarm): (as 성공 - 매뉴얼상 Invalid/N.E./N.S.인데 성공)
- `JMP` (source 1444/1436, verdict=false_alarm): (as 성공 - 매뉴얼상 Invalid/N.E./N.S.인데 성공)

원인: 2026-08-25 정정(8단계 clang_compare + codex 교차검증으로 발견): 원래 이 항목은 'SDM이 N.E.로 명시한 CALL/JMP r/m32(FF /2, FF /4)를 as가 조용히 받아준다'는 bug로 기록돼 있었으나, ModRM 바이트를 직접 디코딩해보니 틀린 진단이었다. combo 419 (`call dword ptr [eax]` -> `67 66 ff 18`)의 ModRM=0x18=0b00_011_000, reg=3 -> FF /3(far call, m16:16/m16:32)이지 FF /2(near call r/m32)가 아니다. combo 1436도 동일 패턴(ModRM=0x28, reg=5 -> FF /5 far jmp, FF /4 near jmp 아님). isa_db.csv 확인 결과 FF /3 CALL m16:16/m16:32 / FF /5 JMP m16:16/m16:32는 SDM상 64비트 모드 Valid다 (64비트 모드에서 인코딩 안 되는 건 근접 r/m32 폼뿐 - CALL FF/2 r/m32는 N.E., JMP FF/4 r/m32는 N.S.로 표기가 다르지만 둘 다 인코딩 불가라는 실질은 같다). 즉 `as`는 인코딩 불가 폼을 만든 게 아니라, 모호한 Intel 문법 'call/jmp dword ptr [mem]'을 66 프리픽스로 far m16:16(4바이트, 'dword ptr' 표기와 크기가 정확히 맞음)으로 유효하게 해석한 것이다. clang은 66 프리픽스 없이 far m16:32(6바이트, FWORD)로 가서 오히려 'dword ptr' 표기와는 크기가 안 맞지만, 그래도 근접(N.E./N.S.) 폼은 아니다 - SDM 위반이 아니라 generator가 만든 모호한 테스트 케이스가 의도(근접 r/m32)와 다른(그러나 둘 다 유효한) far 폼으로 해석된 것이다. as/clang 모두 근접 N.E./N.S. 폼을 만들지 않는다는 점에서 일치.

### cpuid_conditional_availability_not_captured (2건)

- `LAHF` (source 1519/1511, verdict=false_alarm): (as 성공 - 매뉴얼상 Invalid/N.E./N.S.인데 성공)
- `SAHF` (source 4130/4122, verdict=false_alarm): (as 성공 - 매뉴얼상 Invalid/N.E./N.S.인데 성공)

원인: SDM p.650/p.1304: LAHF/SAHF는 64비트 모드 열에 'Invalid'라고 적혀 있지만 각주와 설명문에 'CPUID.80000001H:ECX.LAHF_SAHF_64[0]=1이면 64비트 모드에서도 Valid'라고 명시돼 있음(현대 CPU/as는 이 플래그를 사실상 항상 지원) - mode_support 컬럼이 조건부 허용 각주를 반영하지 못해 생긴 불일치, 실제 as 동작은 매뉴얼의 조건부 허용과 일치.

### ambiguous_syntax_resolved_to_valid_symmetric_form (2건)

- `LAR` (source 1524/1516, verdict=false_alarm): line.s: Assembler messages: | line.s:3: Error: register type mismatch for `lar'
- `LSL` (source 1579/1571, verdict=false_alarm): line.s: Assembler messages: | line.s:3: Error: register type mismatch for `lsl'

원인: 2026-09-03 정정(codex + 최신 clang 19/20 교차검증 재검토): 원래 'SDM p.651 LAR r32, r64/m16(각주1)로 r64 소스를 명시 허용하는데 `lar ecx, rcx`를 as가 거부'라는 bug로 기록돼 있었으나 재검토 결과 근거가 잘못됐다. (1) PDF 문자 단위 폰트크기로 각주 위치를 정밀 확인한 결과 각주 '1'은 실제로 2번째 행(LAR r32, r32/m16)에 붙어있고 3번째 행(REX.W 행)에는 원래 각주가 없다 - isa_db.csv가 각주 숫자를 3번째 행 텍스트 끝에 잘못 붙여 'r64/m161'로 저장한 추출 오류. (2) 바이트 레벨 재현: `lar ecx, rcx`(SDM 문자 그대로 dest=r32/source=r64)를 clang 18/19/20에 줘도 실제 인코딩은 `0f 02 c9`(REX.W 없음) → objdump가 `lar ecx,ecx`로 역어셈블 - clang도 요청받은 rcx를 조용히 ecx로 깎아 인코딩할 뿐, SDM 표 그대로의 비대칭 폼을 실제로 만들지 않는다. (3) `lar rcx, rcx`(양쪽 다 r64로 대칭)는 clang이 REX.W를 포함해 `48 0f 02 c9`(`lar rcx,rcx`)로 정확히 인코딩하지만, as는 AT&T `larq %rcx,%rcx`까지 포함해 어떤 문법으로도 REX.W를 만들지 않는다(`0f 02 c9`만 나옴). 즉 실제로 존재 가능한 폼은 'LAR r64, r64/m16'(대칭)이고, SDM 표의 'LAR r32, r64/m16'(비대칭, dest만 r32) 표기는 REX.W가 두 GPR 오퍼랜드 폭을 독립적으로 지정할 수 없다는 인코딩 구조상 애초에 as/clang 어느 쪽으로도 실현 불가능한 폼으로 보인다(p.651 Description 'zero-extended to 64 bits and loaded into the destination operand'도 dest가 사실은 r64라는 뜻이라 표의 'r32'와 모순 - VPMOVQD와 같은 SDM 오탈자 패턴). CALL/JMP·DEC/INC·LEAVE·LGDT/LIDT·BNDCL에 이어 이 프로젝트가 이미 확인한 '문법으로 구분 안 되는 SDM 표 행을 그대로 테스트해서 엉뚱한 걸 검증하게 됨' 패턴의 7번째 사례. codex 교차검증도 동일 결론(false_alarm)에 동의. **신규 발견(별도 combo 없음, 향후 추가 후보)**: as는 LAR에 REX.W 폼 자체를(대칭 `lar rcx,rcx`까지 포함) 전혀 구현하지 않는다 - 이건 clang과 다른 진짜 as 한계일 수 있으나 현재 combos.csv엔 이 대칭 폼을 테스트하는 combo가 없어 이번 라운드에선 판정하지 않음.

### extractor_artifact_stray_text (2건)

- `VREDUCESD` (source 6961/6953, verdict=false_alarm): line.s: Assembler messages: | line.s:3: Error: invalid operands (*UND* and *UND* sections) for `/'
- `VREDUCESD` (source 6962/6954, verdict=false_alarm): line.s: Assembler messages: | line.s:3: Error: invalid operands (*UND* and *UND* sections) for `/'

원인: PDF 추출 과정에서 설명 문단 문구가 오퍼랜드 칸에 겹쳐 들어간 것으로 보임(같은 페이지 설명문에도 'imm8/r imm8 field'로 동일하게 중복 등장, PDF p.2155 직접 대조) - 국소 1건

### sdm_gather_scatter_vsib_width_asymmetry (2건)

- `VSCATTERDPD` (source 7043/7035, verdict=unsure): line.s: Assembler messages: | line.s:3: Error: invalid VSIB address for `vscatterdpd'
- `VSCATTERDPD` (source 7044/7036, verdict=unsure): line.s: Assembler messages: | line.s:3: Error: invalid VSIB address for `vscatterdpd'

원인: SDM PDF p.2202(325383-090-sdm-vol-2abcd.pdf, 200dpi 렌더링 대조)에 VSCATTERDPD의 ymm 폼이 실제로 'vm32y {k1}, ymm1'로 인쇄돼 있다 - combiner가 vm32x를 vm32y로 잘못 뽑은 추출 오류가 아니라 PDF 원문 자체가 vm32y다. `as`로 직접 재현: `vscatterdpd [eax + xmm1] {k1}, xmm0`(combo 7034)는 성공하지만 이 combo의 `[eax + ymm1] {k1}, ymm0`은 'invalid VSIB address'로 실패한다. 한편 유사 명령 VGATHERDPD(PDF p.1824)는 ymm 데이터인데도 SDM이 vm32x를 그대로 유지해서 GATHER는 vm32x 유지, SCATTER는 vm32y로 확장하는 비대칭 표기를 보인다 - 이 비대칭이 SDM의 의도적 설계인지 오탈자인지 도구(as/objdump)만으로는 판단할 수 없어 unsure로 둔다. 형섭이 PDF 원문과 인텔 공식 정오표를 직접 확인해서 SDM 오탈자인지, as가 SDM에 명시된 폼을 구현하지 않은 버그인지 확정해야 한다.

### encoding_falls_back_to_nop (2건)

- `PREFETCHIT0` (source 3342/3334, verdict=false_alarm): nop    DWORD PTR [eax]
- `PREFETCHIT1` (source 3343/3335, verdict=false_alarm): nop    DWORD PTR [eax]

원인: PREFETCHIT0/1은 SDM상 RIP-relative 메모리만 유효하고, 그 외 주소 형식이면 NOP로 취급된다고 명시돼 있음. generator가 RIP-relative가 아닌 [eax]를 써서 objdump가 'nop'으로 보여주는 것은 SDM에 문서화된 정상 동작(generator가 올바른 폼을 테스트 못한 것) - 버그 아님.

### gas_register_width_stricter_than_manual (1건)

- `MOV` (source 1691/1683, verdict=unsure): line.s: Assembler messages: | line.s:3: Error: operand type mismatch for `mov'

원인: 2026-09-03 재검토(codex 교차검증, 형섭 요청으로 최신 clang 19/20 포함): 원래 'SDM REX.W+8E/r MOV Sreg,r/m64가 메모리도 Valid로 명시하는데 as가 qword ptr을 거부'라는 bug로 기록돼 있었으나, clang 18.1.3/19.1.1/20.1.2 넷 다 `mov ds, qword ptr [eax]`를 'invalid operand for instruction'으로 똑같이 거부함을 확인(word ptr만 성공, as와 완전히 동일). 레지스터 폼(`mov ds, rax`)은 clang이 REX.W를 포함해 정확히 구현하는데(`48 8e d8`) as는 REX.W를 조용히 버려서(`8e d8`, combo 1682) 이 부분은 as만의 진짜 한계로 보이지만, 메모리 폼(이 combo 1683)은 as/clang(사실상 GNU binutils와 LLVM, 독립 구현 2종) 양쪽 다 거부해서 원래 판정의 근거('as만 매뉴얼보다 엄격')가 흔들린다. 다만 codex는 'clang 3버전은 전부 LLVM 계열이라 독립성이 약하고, SDM 정의상 r/m64는 명시적으로 64비트 메모리를 포함하며 반대방향 행(REX.W+8C/r MOV r64/m16,Sreg)은 이미 표기에서 레지스터/메모리 폭을 r64/m16으로 명확히 구분해뒀으니 8E/r 행의 r/m64가 단순 축약 오탈자라 보기엔 근거가 약하다'고 지적 - 실제 페이지 경계 매핑을 이용한 실기 실행 검증(11/12단계 방식) 전까지는 unsure가 안전하다는 의견. LAR/LSL/VPMOVQD와 달리 SDM 내부 모순(각주 오귀속, 형제행 비교, Description 불일치)같은 결정적 증거가 없어 bug 유지도 과하지만 false_alarm 확정도 이르다고 판단해 unsure로 낮춘다.

### gas_missing_mnemonic (1건)

- `UDB` (source 4605/4597, verdict=bug): line.s: Assembler messages: | line.s:3: Error: no such instruction: `udb'

원인: SDM p.1436에 'D6 UDB' 오피코드가 64비트 모드 Valid로 명시돼 있으나(UD0/UD1/UD2와 같은 계열) GNU as는 'udb'라는 니모닉 자체를 모른다('no such instruction: udb'). 2026-09-03 codex 재검증에서도 CONFIRMED(SDM Exceptions 섹션에도 'UDB does so only in 64-bit mode'로 UDB를 직접 언급 - 오탈자 아님).

### combiner_mode_invalid_register_choice (1건)

- `UMONITOR` (source 4607/4599, verdict=false_alarm): line.s: Assembler messages: | line.s:3: Error: 16-bit addressing unavailable for `umonitor'

원인: r16/r32/r64 중 대표값으로 r16을 골랐는데, 64비트 모드에서는 주소 레지스터로 16비트를 쓸 수 없다는 모드 제약을 combiner가 반영하지 못함 - combiner 한계

### sdm_table_typo_memory_size (1건)

- `VPMOVQD` (source 6548/6540, verdict=false_alarm): line.s: Assembler messages: | line.s:3: Error: operand size mismatch for `vpmovqd'

원인: 2026-09-03 정정(형섭 요청으로 codex + 최신 clang 19/20 교차검증 재검토): 원래 'SDM p.2054가 VPMOVQD(EVEX.128) 대상 메모리를 xmm1/m128로 명시하는데 as는 qword ptr(m64)만 받아준다'는 bug로 기록돼 있었으나, PDF p.2054/2055 원문을 직접 대조한 결과 이건 SDM 오피코드 표 자체의 오탈자였다. 근거: (1) 같은 표의 형제 명령어 VPMOVSQD/VPMOVUSQD의 EVEX.128 행은 둘 다 'xmm1/m64'로 정확히 적혀 있음(VPMOVQD 행만 m128로 다름). (2) p.2055 Description: 'The destination operand is a YMM/XMM/XMM register or a 256/128/64-bit memory location' - EVEX.128(2-element)에 대응하는 크기가 64비트라고 명시. (3) Operation pseudocode도 KL=2(128비트 버전)일 때 32비트씩 2번, 총 64비트만 DEST에 씀. (4) 실측: as(2.42)/clang 18.1.3/19.1.1/20.1.2 네 어셈블러 전부 `vpmovqd qword ptr [eax], xmm0`는 성공, `xmmword ptr`은 전부 거부 - 완전히 일치. (5) EVEX.256 폼(`vpmovqd xmmword ptr [eax], ymm0`, 표기상 m128이 맞는 폼)은 as가 정상적으로 받아줘서, as가 무조건 좁게 구현한 게 아니라 폭별로 정확히 구분하고 있음을 확인. codex 교차검증도 동일 결론(bug→false_alarm)에 동의함.

### size_directive_name_changed (1건)

- `CMPXCHG16B` (source 750/741, verdict=false_alarm): cmpxchg16b OWORD PTR [eax]

원인: 같은 128비트를 가리키는 크기 지시자 이름이 다름(xmmword ptr <-> OWORD PTR, cmpxchg16b) - 표기 관례 차이, 버그 아님.

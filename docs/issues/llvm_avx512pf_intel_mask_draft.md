<!-- 초안(2026-10-12). 제출 전 사용자 확인. 재현: LLVM 23.1.3 공식 바이너리(~/opt/llvm-23.1.3), GNU Binutils 2.47 -->

**Title:** [X86][AsmParser] AVX512PF gather/scatter prefetch instructions cannot be assembled in Intel syntax (mask operand position)

**Labels (suggested):** `backend:X86`, `llvm:asmparser`

### Summary

None of the 16 AVX512PF instructions (`VGATHERPF0/1{D,Q}P{S,D}`, `VSCATTERPF0/1{D,Q}P{S,D}`) can be assembled in Intel syntax. They assemble fine in AT&T syntax. The Intel text that LLVM's own disassembler prints for these instructions cannot be assembled either, so an Intel-syntax disassemble/assemble round trip fails.

### Reproducer (llvm-mc 23.1.3)

Intel syntax, operand order as in the Intel SDM (`VGATHERPF0DPS vm32z {k1}`):

```
$ printf '.intel_syntax noprefix\nvgatherpf0dps [rax+zmm0] {k1}\n' | llvm-mc -triple=x86_64 -show-encoding
<stdin>:2:1: error: invalid operand for instruction
```

AT&T syntax works:

```
$ printf 'vgatherpf0dps (%%rax,%%zmm0) {%%k1}\n' | llvm-mc -triple=x86_64 -show-encoding
	vgatherpf0dps	(%rax,%zmm0) {%k1}      # encoding: [0x62,0xf2,0x7d,0x49,0xc6,0x0c,0x00]
```

Disassembling those bytes in Intel syntax prints the mask first. The assembler rejects that output:

```
$ echo "0x62,0xf2,0x7d,0x49,0xc6,0x0c,0x00" | llvm-mc -triple=x86_64 --disassemble --output-asm-variant=1
	vgatherpf0dps	{k1}, dword ptr [rax + zmm0]

$ printf '.intel_syntax noprefix\nvgatherpf0dps {k1}, dword ptr [rax + zmm0]\n' | llvm-mc -triple=x86_64 -show-encoding
<stdin>:2:17: error: unknown token in expression
        vgatherpf0dps   {k1}, dword ptr [rax + zmm0]
                        ^
```

Other Intel spellings I tried also fail with `invalid operand for instruction`:
- `dword ptr [rax+zmm0] {k1}`
- `zmmword ptr [rax+zmm0] {k1}`
- `dword ptr [rax+zmm0*4] {k1}`
- `[rax+zmm0]{k1}`

The result is the same for all 16 instructions: each AT&T form assembles, and each Intel form is rejected. The four `*DPD` forms use `ymm0` as the VSIB index (`vm32y`); the other twelve use `zmm0`. The bytes differ by instruction. Both the unsized Intel memory form and the form with the appropriate `dword ptr`/`qword ptr` size were tested.

The `zmmword ptr` spelling above is only an additional rejected spelling, not evidence that a correctly sized operand is rejected.

### Expected

`vgatherpf0dps dword ptr [rax+zmm0] {k1}` (memory operand followed by the mask) should assemble to `62 f2 7d 49 c6 0c 00`. This is the order used by the Intel SDM, Vol. 2D, "VGATHERPF0DPS/VGATHERPF0QPS/VGATHERPF0DPD/VGATHERPF0QPD", p. 8-12 (order no. 325383-093US): `EVEX.512.66.0F38.W0 C6 /1 /vsib  VGATHERPF0DPS vm32z {k1}`.

For reference, GNU as (version output: `GNU Binutils 2.47.20260726`) accepts `vgatherpf0dps dword ptr [rax+zmm0]{k1}` and emits the same bytes. objdump prints `vgatherpf0dps DWORD PTR [rax+zmm0*1]{k1}`.

Ordinary gathers with a mask attached to a register operand, such as `vgatherdps zmm0 {k1}, [rax+zmm1]`, assemble fine in Intel syntax. So does `vscatterdps [rax+zmm1] {k1}, zmm0`, which attaches the mask to a memory operand.

### Likely cause

[`llvm/lib/Target/X86/X86InstrAVX512.td`](https://github.com/llvm/llvm-project/blob/0d261d1ca552c95a8f007e061c787ac7132fbcbc/llvm/lib/Target/X86/X86InstrAVX512.td#L10434-L10440) (llvmorg-23.1.3, `avx512_gather_scatter_prefetch`):

```
def m  : AVX5128I<opc, F, (outs), (ins KRC:$mask, memop:$src),
          !strconcat(OpcodeStr, "\t{$src {${mask}}|{${mask}}, $src}"), []>,
```

- The AT&T variant places the mask after the memory operand, in the order shown by the SDM.
- The Intel variant is `{${mask}}, $src`, with the mask as a separate leading operand. The Intel parser sends a leading `{...}` operand to its rounding/SAE parser, which rejects `{k1}`. A trailing `mem {k1}` is parsed by `HandleAVX512Operand`, but does not match the operand order in this Intel instruction definition.

PR #122051 mentioned this in passing: "these vector scatter and gather prefetch instructions also have an unusual k mask operand position but I have not addressed this with this patch as I am unsure how to change the Intel format in the tablegen file." I could not find an issue that tracks it.

The `llvmorg-23.1.3` test tree contains `llvm/test/MC/X86/avx512pf-64-att.s`, but no sibling `avx512pf-64-intel.s`. This filename check does not establish the absence of all Intel coverage in other test files.

### Possible fix

Change the Intel variant to `$src {${mask}}`, as in the AT&T variant and the SDM. Then add an Intel-syntax MC test that covers assembling, disassembling, and reassembling the printed output, with the appropriate YMM/ZMM index for each of the 16 instructions. Existing AT&T tests should also continue to pass. This is a proposed fix; a patched LLVM build has not been tested.

### Environment

- LLVM 23.1.3 (official Linux x86-64 release binary). The same behavior was observed with LLVM 18.1.3.
- x86_64 Linux

### Local verification evidence (2026-10-12)

The independent recheck is recorded in [the verification note](llvm_avx512pf_intel_mask_verification.md), with all 16 inputs, bytes, return codes, and raw diagnostics in `out/avx512pf_review_20261012/`. It covers assembly and disassembly only, not CPU execution.

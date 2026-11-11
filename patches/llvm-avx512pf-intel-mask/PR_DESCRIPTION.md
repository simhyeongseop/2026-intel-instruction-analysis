Title: [X86][AsmParser] Fix Intel mask position for AVX512PF prefetch instructions

AVX512PF gather/scatter prefetch instructions reject a memory operand followed by
a mask decorator in Intel syntax. LLVM also prints the mask as a leading operand,
producing Intel disassembly that cannot be reassembled.

Move the mask after the memory operand in the Intel assembly variant of
`avx512_gather_scatter_prefetch`. Preserve the AT&T variant and the outer dialect
selection so the literal mask braces survive TableGen processing.

Add Intel MC tests for all 16 mnemonics, using the 32 existing AT&T encoding
expectations. Cover sized/unsized memory, high VSIB registers, YMM/ZMM indices,
k1-k7, scaled addressing, compressed displacement, assembly output round trips,
and object disassembly. Add diagnostics for missing/zero masks, zeroing,
incorrect VSIB widths, and incorrect memory size.

Validation: built X86 LLVM MC tools from main
`74a120bff99f527087d231e14844b384a7dc1131` with assertions enabled. All 8 targeted
lit tests passed, including existing AVX512 Intel/AT&T and gather tests.

Fixes #233852.

Related discussion: https://github.com/llvm/llvm-project/pull/122051#issuecomment-2576984459

Assisted-by: Codex

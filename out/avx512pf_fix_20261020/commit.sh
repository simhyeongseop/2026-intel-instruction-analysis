#!/usr/bin/env bash
set -euo pipefail
cd "$HOME/opt/build/llvm-avx512pf-fix-20261020/source"
git diff --check
git switch -c codex/fix-avx512pf-intel-mask
git add -- llvm/lib/Target/X86/X86InstrAVX512.td \
  llvm/test/MC/X86/avx512pf-64-intel.s \
  llvm/test/MC/X86/avx512pf-intel-errors.s
git -c user.name=simhyeongseop -c user.email=202002513@o.cnu.ac.kr commit \
  -m '[X86][AsmParser] Fix Intel mask position for AVX512PF prefetch instructions' \
  -m 'Place the mask after the memory operand in the Intel variant, preserving the AT&T variant and literal mask braces. Add encoding, assembly round-trip, disassembly, and invalid-operand MC tests for AVX512PF prefetch instructions.' \
  -m 'Fixes #233852.' \
  -m 'Assisted-by: Codex'
git show --stat --oneline HEAD

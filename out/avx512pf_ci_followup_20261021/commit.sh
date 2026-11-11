#!/usr/bin/env bash
set -euo pipefail
cd "$HOME/opt/build/llvm-avx512pf-fix-20261020/source"
test "$(git branch --show-current)" = codex/fix-avx512pf-intel-mask
git diff --check
git add -- llvm/test/MC/Disassembler/X86/apx/evex-format.txt \
  llvm/test/MC/X86/apx/evex-format-intel.s
git -c user.name=simhyeongseop -c user.email=202002513@o.cnu.ac.kr commit \
  -m '[X86] Update APX prefetch tests for corrected Intel mask position' \
  -m 'Update the existing disassembler expectation and enable the previously disabled Intel assembly case with the correct dword memory operand. All 10 targeted MC tests pass.' \
  -m 'Assisted-by: Codex'
git rev-parse HEAD

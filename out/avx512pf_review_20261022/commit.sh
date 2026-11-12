#!/usr/bin/env bash
set -euo pipefail
cd "$HOME/opt/build/llvm-avx512pf-fix-20261020/source"
test "$(git branch --show-current)" = codex/fix-avx512pf-intel-mask
git diff --check
git add -- llvm/test/MC/X86/avx512pf-64-intel.s
git -c user.name=simhyeongseop -c user.email=202002513@o.cnu.ac.kr commit \
  -m '[X86] Refine AVX512PF Intel tests after review' \
  -m 'Explain the assembly round-trip check and remove the llvm-objdump RUN line. All 10 targeted MC tests pass.' \
  -m 'Assisted-by: Codex'
git rev-parse HEAD

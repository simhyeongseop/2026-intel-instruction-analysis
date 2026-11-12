#!/usr/bin/env bash
set -euo pipefail
task="$HOME/opt/build/llvm-avx512pf-fix-20261020"
tests="$task/source/llvm/test/MC/X86"
output=/mnt/c/Users/wltjq/OneDrive/assembler-testing/out/avx512pf_fix_20261020
"$task/build/bin/llvm-lit" -v -o "$output/lit_results.json" \
  "$tests/avx512pf-64-intel.s" "$tests/avx512pf-64-att.s" \
  "$tests/avx512pf-intel-errors.s" \
  "$tests/avx512-intel.s" "$tests/avx512-att.s" \
  "$tests/avx512-intel-errors.s" "$tests/avx512-att-errors.s" \
  "$tests/gather.s" > "$output/lit_results.log" 2>&1

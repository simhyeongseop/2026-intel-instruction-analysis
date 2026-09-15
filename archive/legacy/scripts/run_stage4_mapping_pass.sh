#!/usr/bin/env bash
set -u

# Rebuild Stage 3/4 after operand-mapping fixes, then run assembler triage.
# Run from the repository root inside Ubuntu/WSL:
#   bash scripts/run_stage4_mapping_pass.sh

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR" || exit 1

echo "== Environment =="
python3 --version
as --version | head -n 1
if command -v gcc >/dev/null 2>&1; then gcc --version | head -n 1; else echo "gcc: not found"; fi
if command -v clang >/dev/null 2>&1; then clang --version | head -n 1; else echo "clang: not found"; fi
echo

echo "== Stage 3: operand grouping =="
python3 src/stage3_operand_grouping/step3_operand_grouping.py
echo

echo "== Stage 4: assembly testcase generation =="
python3 src/stage4_test_generation/step4_test_generator.py
echo

echo "== Stage 4: assembler/compiler check =="
python3 src/stage4_test_generation/step4_compile_and_analyze.py
echo

echo "== Stage 4: error triage =="
python3 src/stage4_test_generation/step4_error_triage.py
echo

echo "== Quick audit =="
grep -n "=== INVLPG m ===" -A4 data/stage4_tests/test_all_instructions.s || true
grep -n "=== LEA r64, m ===" -A4 data/stage4_tests/test_all_instructions.s || true
grep -n "=== LAR r16, r16/m16 ===" -A8 data/stage4_tests/test_all_instructions.s || true
grep -n "=== REP OUTS DX, m8 ===" -A3 data/stage4_tests/test_all_instructions.s || true
echo

echo "Done."
echo "Generated:"
echo "  data/stage3_operands/step3_operand_groups.csv"
echo "  data/stage3_operands/step3_coverage_report.csv"
echo "  data/stage4_tests/test_all_instructions.s"
echo "  data/stage4_tests/step4_error_lines.csv"
echo "  data/stage4_tests/step4_error_triage.csv"
echo "  data/stage4_tests/step4_triage_report.md"

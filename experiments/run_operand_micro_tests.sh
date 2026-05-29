#!/usr/bin/env bash
set -u

# Micro experiments for the meeting-7 feedback.
# This script assembles each case separately, then disassembles successful
# object files with objdump in Intel syntax. It does not link or execute them.

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_DIR="$ROOT_DIR/out_operand_micro_tests"
mkdir -p "$OUT_DIR"

run_case() {
  local name="$1"
  local body="$2"
  local src="$OUT_DIR/${name}.s"
  local as_obj="$OUT_DIR/${name}.as.o"
  local gcc_obj="$OUT_DIR/${name}.gcc.o"
  local clang_obj="$OUT_DIR/${name}.clang.o"

  cat > "$src" <<EOF_CASE
.intel_syntax noprefix
.text
.global ${name}
${name}:
    ${body}
    ret
EOF_CASE

  echo
  echo "============================================================"
  echo "CASE: ${name}"
  echo "SOURCE: ${body}"
  echo "------------------------------------------------------------"

  if as --64 -mintel64 "$src" -o "$as_obj" >"$OUT_DIR/${name}.as.log" 2>&1; then
    echo "[as] OK"
    echo "[objdump/as]"
    objdump -drw -M intel "$as_obj" | sed -n "/<${name}>:/,/^$/p"
  else
    echo "[as] FAIL"
    cat "$OUT_DIR/${name}.as.log"
  fi

  if command -v gcc >/dev/null 2>&1; then
    if gcc -c -Wa,--64 -Wa,-mintel64 "$src" -o "$gcc_obj" >"$OUT_DIR/${name}.gcc.log" 2>&1; then
      echo "[gcc] OK"
      echo "[objdump/gcc]"
      objdump -drw -M intel "$gcc_obj" | sed -n "/<${name}>:/,/^$/p"
    else
      echo "[gcc] FAIL"
      cat "$OUT_DIR/${name}.gcc.log"
    fi
  else
    echo "[gcc] SKIP: gcc not found"
  fi

  if command -v clang >/dev/null 2>&1; then
    if clang -c "$src" -o "$clang_obj" >"$OUT_DIR/${name}.clang.log" 2>&1; then
      echo "[clang] OK"
      echo "[objdump/clang]"
      objdump -drw -M intel "$clang_obj" | sed -n "/<${name}>:/,/^$/p"
    else
      echo "[clang] FAIL"
      cat "$OUT_DIR/${name}.clang.log"
    fi
  else
    echo "[clang] SKIP: clang not found"
  fi
}

run_case invlpg_bare "invlpg [rax]"
run_case invlpg_qword "invlpg QWORD PTR [rax]"

run_case lea_bare "lea rax, [rbx]"
run_case lea_qword "lea rax, QWORD PTR [rbx]"

run_case lss_tbyte "lss rax, TBYTE PTR [rax]"
run_case lss_fword "lss rax, FWORD PTR [rax]"
run_case lss_qword "lss rax, QWORD PTR [rax]"

run_case lfs_tbyte "lfs rax, TBYTE PTR [rax]"
run_case lgs_tbyte "lgs rax, TBYTE PTR [rax]"

run_case moffs_load "mov al, [0x1000]"
run_case moffs_store "mov [0x1000], al"

run_case alias_sal "sal eax, 1"
run_case alias_xchg_nop "xchg eax, eax"

run_case reg_width_lldt16 "lldt ax"
run_case reg_width_lldt32 "lldt eax"

echo
echo "Done. Generated files are in: $OUT_DIR"
echo "Tip: compare SOURCE lines with the objdump/as blocks above."

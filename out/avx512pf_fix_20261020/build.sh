#!/usr/bin/env bash
set -euo pipefail
task="$HOME/opt/build/llvm-avx512pf-fix-20261020"
evidence=/mnt/c/Users/wltjq/OneDrive/assembler-testing/out/avx512pf_fix_20261020
python3 "$evidence/prepare_patch.py" "$task/source"
"$task/tools/cmake/data/bin/cmake" \
  -S "$task/source/llvm" -B "$task/build" -G Ninja \
  -DCMAKE_MAKE_PROGRAM="$task/tools/bin/ninja" \
  -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS_RELEASE="-O1 -DNDEBUG" \
  -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_ASSERTIONS=ON \
  -DLLVM_INCLUDE_TESTS=ON -DLLVM_INCLUDE_BENCHMARKS=OFF \
  -DLLVM_ENABLE_ZLIB=OFF -DLLVM_ENABLE_ZSTD=OFF \
  -DLLVM_PARALLEL_COMPILE_JOBS=3 -DLLVM_PARALLEL_LINK_JOBS=1 \
  > "$task/configure.log" 2>&1
"$task/tools/cmake/data/bin/cmake" --build "$task/build" \
  --target llvm-mc llvm-objdump llvm-config llvm-readobj FileCheck not count --parallel 3 \
  > "$task/build.log" 2>&1

#!/bin/bash
# 사용: probe.sh 'insn' ...  각 입력을 GNU as / llvm-mc(Intel)로 조립한 결과를 한 줄씩 낸다
AS=~/opt/binutils-2.47/bin/as
OBJDUMP=~/opt/binutils-2.47/bin/objdump
MC=~/opt/llvm-23.1.3/bin/llvm-mc
T=$(mktemp -d)
for insn in "$@"; do
  printf '.intel_syntax noprefix\n.code64\n.Ltarget16:\n%s\n' "$insn" > $T/a.s
  if $AS --64 -mintel64 -o $T/a.o $T/a.s 2> $T/err; then
    gnu=$($OBJDUMP -d -M intel $T/a.o | awk -F'\t' '/^ +[0-9a-f]+:/{b=b $2} END{gsub(/ /,"",b); print b}')
  else gnu="ERR: $(grep -o 'Error: .*' $T/err | head -1)"; fi
  out=$($MC -triple=x86_64 -x86-asm-syntax=intel -output-asm-variant=1 -show-encoding $T/a.s 2>&1)
  if echo "$out" | grep -q 'error'; then mc="ERR: $(echo "$out" | grep -o 'error: .*' | head -1)"
  else mc=$(echo "$out" | grep -o 'encoding: \[[^]]*\]' | tr -d '\n'); fi
  printf '%-40s | GNU %-28s | LLVM %s\n' "$insn" "$gnu" "$mc"
done
rm -rf $T

import json
import subprocess
from pathlib import Path

root = Path.home() / 'opt/build/llvm-avx512pf-fix-20261020'
source = root / 'source'
out = Path(__file__).resolve().parent
td = source / 'llvm/lib/Target/X86/X86InstrAVX512.td'
original = td.read_text()
old = r'\t{$src {${mask}}|$src {${mask}}}'
suggested = r'\t$src {${mask}}'
assert original.count(old) == 1

def build(name):
    with (out / (name + '_build.log')).open('w') as log:
        subprocess.run([str(root / 'tools/cmake/data/bin/cmake'), '--build',
                        str(root / 'build'), '--target', 'llvm-mc', '--parallel', '3'],
                       stdout=log, stderr=subprocess.STDOUT, check=True)

try:
    td.write_text(original.replace(old, suggested))
    build('suggested')
    results = []
    for dialect, text in [('intel', 'vgatherpf0dps [rax+zmm0] {k1}\n'),
                          ('att', 'vgatherpf0dps (%rax,%zmm0) {%k1}\n')]:
        command = [str(root / 'build/bin/llvm-mc'), '-triple=x86_64',
                   '-x86-asm-syntax=' + dialect, '-show-encoding']
        result = subprocess.run(command, input=text, text=True, capture_output=True)
        results.append(dict(command=command, input=text, returncode=result.returncode,
                            stdout=result.stdout, stderr=result.stderr))
    (out / 'suggested_results.json').write_text(json.dumps(results, indent=2))
    print(json.dumps(results, indent=2), flush=True)
finally:
    td.write_text(original)

test = source / 'llvm/test/MC/X86/avx512pf-64-intel.s'
lines = test.read_text().splitlines()
lines = [line for line in lines if not (line.startswith('// RUN:') and 'llvm-objdump' in line)]
lines.insert(1, '// Check that the printed Intel assembly can be reassembled with the same encoding.')
test.write_text('\n'.join(lines) + '\n')
build('final')
names = ['avx512pf-64-intel.s', 'avx512pf-64-att.s', 'avx512pf-intel-errors.s',
         'avx512-intel.s', 'avx512-att.s', 'avx512-intel-errors.s',
         'avx512-att-errors.s', 'gather.s', 'apx/evex-format-intel.s']
tests = [source / 'llvm/test/MC/X86' / name for name in names]
tests.append(source / 'llvm/test/MC/Disassembler/X86/apx/evex-format.txt')
result = subprocess.run([str(root / 'build/bin/llvm-lit'), '-v', '-o',
                         str(out / 'lit_results.json'), *map(str, tests)],
                        text=True, capture_output=True)
(out / 'lit_results.log').write_text(result.stdout + result.stderr)
print(result.stdout, flush=True)
subprocess.run(['git', '-C', str(source), 'diff', '--check'], check=True)
diff = subprocess.check_output(['git', '-C', str(source), 'diff'], text=True)
(out / 'revision.patch').write_text(diff)
raise SystemExit(result.returncode)

"""고정된 재심 사례의 소스/옵션/바이트/환경과 CPU 경계 실험을 재현한다."""
import argparse
from datetime import datetime, timezone
import json
from pathlib import Path
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from pipeline import toolchain as T
from pipeline.instruction_check import HEADER, assemble, command, environment, sha256


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=ROOT / 'out/review/cases.json')
    parser.add_argument('--skip-cpu', action='store_true')
    args = parser.parse_args()
    cases = []
    for name in ('lss', 'lfs', 'lgs'):
        cases += ['%s cx, dword ptr [eax]' % name, '%s ecx, fword ptr [eax]' % name,
                  '%s rcx, tbyte ptr [eax]' % name, '%s rcx, fword ptr [eax]' % name]
    cases += ['mov ds, %s' % op for op in ('ax', 'eax', 'rax', 'word ptr [rax]', 'qword ptr [rax]')]
    cases += ['lar rcx, rcx', 'lsl rcx, rcx', 'lar ecx, rcx', 'lsl rcx, ecx',
              'udb', 'ud0', 'ud0 eax, eax', 'ud1 eax, eax', 'ud2', '.byte 0xd6']
    rows = []
    for code in cases:
        source = HEADER + code + '\n'
        row = {'source': code, 'as': assemble(source), 'clang': assemble(source, tool='clang')}
        if code.startswith(('lss ', 'lfs ', 'lgs ')):
            row['as_without_mintel64'] = assemble(source, options=['--64'])
        rows.append(row)
        print('%-32s as=%-8s %-14s clang=%s %s' % (code, row['as']['status'], row['as']['bytes'],
              row['clang']['status'], row['clang']['bytes']), flush=True)
    report = {'created_utc': datetime.now(timezone.utc).isoformat(), 'environment': environment(),
              'pdf_sha256': sha256(ROOT / 'intel_manual.pdf'), 'cases': rows}
    failed = any(row[tool].get('observation_status') in
                 ('process_crash', 'timeout', 'unavailable', 'resource_failure', 'tool_failed')
                 or (row[tool]['status'] == 'accepted' and not row[tool]['inspection_complete'])
                 for row in rows for tool in ('as', 'clang'))
    if not args.skip_cpu:
        src = ROOT / 'tests/review_cpu_cases.c'
        report['cpu_source_sha256'] = sha256(src)
        with tempfile.TemporaryDirectory(prefix='asm_review_cpu_') as folder:
            binary = str(Path(folder, 'review'))
            compile_result = command([T.CLANG, '-O0', '-Wall', '-Wextra', '-Werror', str(src), '-o', binary])
            report['cpu_compile'] = compile_result
            failed = failed or compile_result['returncode'] != 0
            if compile_result['returncode'] == 0:
                run = command([binary], timeout=45)
                report['cpu_run'] = run
                report['cpu_cases'] = [json.loads(line) for line in run['stdout'].splitlines()]
                failed = failed or run['returncode'] != 0
                print(run['stdout'], flush=True)
            else:
                print(compile_result['stderr'], flush=True)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(args.output)
    return int(failed)


if __name__ == '__main__':
    raise SystemExit(main())

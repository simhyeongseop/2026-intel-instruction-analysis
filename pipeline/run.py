"""현재 파이프라인 실행기. --list, --only, --until, --execute, --python을 지원한다."""
import argparse
from datetime import datetime, timezone
import json
import os
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from pipeline.instruction_check import environment, sha256

STAGES = [
    ('extractor', 'pipeline/m1_extract.py'), ('tokenizer', 'pipeline/m2_tokenize.py'),
    ('combiner', 'pipeline/m3_combine.py'), ('generator', 'pipeline/m4_generate.py'),
    ('assembler', 'pipeline/m5_assemble.py'), ('roundtrip', 'pipeline/m6_roundtrip.py'),
    ('triage', 'pipeline/m7_triage.py'), ('clang_assemble', 'pipeline/m8_clang_assemble.py'),
    ('clang_compare', 'pipeline/m9_clang_compare.py'), ('reassemble_check', 'pipeline/m10_reassemble_check.py'),
    ('execute', 'pipeline/m11_execute.py'), ('execute_edge_cases', 'pipeline/m12_execute_edge_cases.py'),
    ('lint', 'pipeline/m13_lint.py'),
]
INPUTS = {
    'extractor': ['intel_manual.pdf'], 'tokenizer': ['data/db/isa_db.csv'],
    'combiner': ['data/db/tokens.csv'], 'generator': ['data/db/combos.csv'],
    'assembler': ['out/tests.s'], 'roundtrip': ['out/asm_result.csv'],
    'triage': ['out/asm_result.csv', 'out/roundtrip.csv'],
    'clang_assemble': ['out/tests.s'], 'clang_compare': ['out/asm_result.csv', 'out/clang_result.csv'],
    'reassemble_check': ['out/roundtrip.csv'], 'execute': [],
    'execute_edge_cases': ['out/asm_result.csv'], 'lint': ['out/asm_result.csv', 'data/db/isa_db.csv', 'data/cases.csv'],
}
OUTPUTS = {
    'extractor': ['data/db/isa_db.csv', 'data/db/coverage_report.md'],
    'tokenizer': ['data/db/tokens.csv', 'data/db/extraction_issues.csv'],
    'combiner': ['data/db/combos.csv'],
    'generator': ['out/tests.s', 'out/generator_skipped.csv'], 'assembler': ['out/asm_result.csv'],
    'roundtrip': ['out/roundtrip.csv'], 'triage': ['out/triage.csv', 'out/triage_report.md'],
    'clang_assemble': ['out/clang_result.csv'], 'clang_compare': ['out/clang_compare.csv', 'out/clang_compare_report.md'],
    'reassemble_check': ['out/reassemble_check.csv', 'out/reassemble_check_report.md'],
    'execute': ['out/address_test_result.csv'],
    'execute_edge_cases': ['out/edge_case_execution.csv', 'out/edge_case_execution_report.md'],
    'lint': ['out/lint/results.csv', 'out/lint/report.md', 'out/lint/manifest.json'],
}
CPU_STAGES = {'execute', 'execute_edge_cases'}


def plan_stages(start='extractor', only=None, until=None, execute=False):
    names = [name for name, _ in STAGES]
    if only:
        return [(name, script, name in CPU_STAGES and not execute) for name, script in STAGES if name == only]
    first, last = names.index(start), names.index(until) if until else len(names) - 1
    if last < first:
        raise ValueError('--until은 시작 단계 이후여야 합니다.')
    return [(name, script, name in CPU_STAGES and not execute) for name, script in STAGES[first:last+1]]


def hashes(paths):
    return {p: sha256(ROOT / p) for p in paths if (ROOT / p).is_file()}


def main(argv=None):
    if hasattr(sys.stdout, 'reconfigure'):
        sys.stdout.reconfigure(encoding='utf-8')
    parser = argparse.ArgumentParser(description=__doc__)
    names = [name for name, _ in STAGES]
    parser.add_argument('start', nargs='?', default='extractor', choices=names)
    selection = parser.add_mutually_exclusive_group()
    selection.add_argument('--only', choices=names)
    selection.add_argument('--until', choices=names)
    parser.add_argument('--list', action='store_true')
    parser.add_argument('--execute', action='store_true', help='11/12단계 고정 CPU 실험도 실행')
    parser.add_argument('--python', default=sys.executable, help='단계 실행용 Python (1단계는 pdfplumber 필요)')
    args = parser.parse_args(argv)
    if args.list:
        for number, (name, script) in enumerate(STAGES, 1):
            print('%2d %-20s %s%s' % (number, name, script, ' [--execute 필요]' if name in CPU_STAGES else ''))
        return 0
    try:
        plan = plan_stages(args.start, args.only, args.until, args.execute)
    except ValueError as error:
        parser.error(str(error))
    (ROOT / 'out/runs').mkdir(parents=True, exist_ok=True)
    now = datetime.now(timezone.utc)
    manifest_path = ROOT / 'out/runs' / (now.strftime('%Y%m%dT%H%M%S%fZ') + '.json')
    manifest = {'schema_version': 1, 'started_utc': now.isoformat(), 'environment': environment(),
                'code_hashes': hashes([p.relative_to(ROOT).as_posix() for p in sorted((ROOT / 'pipeline').glob('*.py'))]),
                'steps': [], 'completed': False}
    failed = 0
    for name, script, skipped in plan:
        step = {'stage': name, 'script': script, 'input_hashes': hashes(INPUTS[name])}
        manifest['steps'].append(step)
        if skipped:
            step.update(status='skipped', reason='CPU 실행은 --execute로 선택')
        else:
            missing = [p for p in INPUTS[name] if not (ROOT / p).is_file()]
            if missing:
                step.update(status='failed', error='입력 없음: ' + ', '.join(missing))
                failed = 2
            else:
                print('[%s] 시작' % name, flush=True)
                step['command'] = [args.python, script]
                try:
                    run = subprocess.run(step['command'], cwd=ROOT, capture_output=True, text=True,
                                         env=dict(os.environ, PYTHONIOENCODING='utf-8', LC_ALL='C'),
                                         encoding='utf-8', errors='replace')
                    step.update(returncode=run.returncode, stdout=run.stdout, stderr=run.stderr,
                                status='completed' if run.returncode == 0 else 'failed')
                    if run.stdout:
                        print(run.stdout, end='', flush=True)
                    if run.stderr:
                        print(run.stderr, file=sys.stderr, end='', flush=True)
                    failed = run.returncode
                except OSError as error:
                    step.update(status='failed', error=str(error))
                    failed = 2
                step['output_hashes'] = hashes(OUTPUTS[name])
        manifest_path.write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
        if failed:
            print('[%s] 중단: %s' % (name, step.get('error', '단계 실행 실패')), flush=True)
            break
    manifest.update(completed=failed == 0, finished_utc=datetime.now(timezone.utc).isoformat())
    manifest_path.write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print('실행 기록: ' + str(manifest_path))
    return failed


if __name__ == '__main__':
    raise SystemExit(main())

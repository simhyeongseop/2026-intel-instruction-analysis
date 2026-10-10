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

# 현재 파이프라인(2026-10-11 생성기 재작성): 추출 -> 생성 -> 도구별 판정 -> 역어셈블러별 대조.
# 예전 5~13단계(m5_assemble ... m13_lint)는 삭제한 생성기의 out/tests.s를 입력으로 쓰므로 여기서 뺐다.
STAGES = [
    ('extractor', 'pipeline/m1_extract.py'), ('generator', 'pipeline/m2_generate.py'),
    ('check', 'pipeline/m3_check.py'), ('disasm', 'pipeline/m4_disasm.py'),
]
INPUTS = {
    'extractor': ['intel_manual.pdf'],
    'generator': ['data/db/isa_db.csv', 'out/sdm_review_093/compare/rows_status.csv'],
    'check': ['out/cases/cases.csv'],
    'disasm': ['out/cases/check_results.csv', 'out/cases/cases.csv'],
}
OUTPUTS = {
    'extractor': ['data/db/isa_db.csv', 'data/db/coverage_report.md'],
    'generator': ['out/cases/cases.csv', 'out/cases/cases.s', 'out/cases/generate_summary.json'],
    'check': ['out/cases/check_results.csv', 'out/cases/check_rows.csv', 'out/cases/check_summary.json'],
    'disasm': ['out/cases/disasm_results.csv', 'out/cases/disasm_summary.json'],
}
# --execute를 주면 이 단계에 그대로 넘긴다(레지스터 전용 케이스를 격리 실행).
EXECUTE_OPTION_STAGES = {'check'}
CPU_STAGES = set()


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
    parser.add_argument('--execute', action='store_true', help='판정 단계에서 레지스터 전용 케이스를 CPU로 격리 실행')
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
                step['command'] = [args.python, script] + (['--execute'] if args.execute and name in EXECUTE_OPTION_STAGES else [])
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

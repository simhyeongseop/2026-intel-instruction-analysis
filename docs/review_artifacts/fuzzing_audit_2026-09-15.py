"""Reproduce review observations without modifying the implementation or running input bytes.

From the repository root on Ubuntu:
  python3 docs/review_artifacts/fuzzing_audit_2026-09-15.py
Output: out/review/fuzzing_audit_2026-09-15.json
Mocks below test reporting behavior; they are not actual assembler crashes.
"""
import copy
import csv
from collections import Counter
from contextlib import redirect_stdout
from datetime import datetime, timezone
import io
import json
from pathlib import Path
import subprocess
import sys
import tempfile
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from pipeline import instruction_check as ic
from pipeline import m13_lint
from pipeline.operand_forms import load_db


def read_csv(name):
    with (ROOT / name).open(encoding='utf-8', newline='') as stream:
        return list(csv.DictReader(stream))


def main():
    db = load_db()
    lint = read_csv('out/lint/results.csv')
    triage = read_csv('out/triage.csv')
    combos = read_csv('data/db/combos.csv')
    assembly = read_csv('out/asm_result.csv')
    mismatch = [r for r in lint if r['status'] == 'accepted'
                and r['opcode_fields'] == 'different_encoding']
    report = {
        'created_utc': datetime.now(timezone.utc).isoformat(),
        'scope': 'read-only saved-data audit, bounded assembly probes, injected reporting failures',
        'environment': ic.environment(),
        'git_head': subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip(),
        'working_tree_note': 'HEAD alone does not identify the reviewed working tree; see file hashes.',
        'file_hashes': {p: ic.sha256(ROOT / p) for p in (
            'pipeline/instruction_check.py', 'pipeline/operand_forms.py', 'pipeline/m13_lint.py',
            'pipeline/review_verdicts.py', 'scripts/review_cases.py', 'scripts/run_ubuntu_tests.sh',
            'data/db/isa_db.csv', 'data/db/combos.csv', 'out/asm_result.csv',
            'out/triage.csv', 'out/lint/results.csv', 'out/lint/manifest.json',
            'docs/review_artifacts/fuzzing_audit_2026-09-15.py')},
        'counts': {
            'db_rows': len(db), 'combo_rows': len(combos), 'assembly_rows': len(assembly),
            'represented_db_rows': len({r['row_id'] for r in assembly}),
            'assembly_unique_sources': len({r['asm_line'] for r in assembly}),
            'lint_rows': len(lint), 'lint_unique_sources': len({r['asm_line'] for r in lint}),
            'lint_status': dict(Counter(r['status'] for r in lint)),
            'lint_sdm_form': dict(Counter(r['sdm_form'] for r in lint)),
            'generated_opcode_fields': dict(Counter(r['opcode_fields'] for r in lint if r['group'] == 'generated')),
            'accepted_opcode_fields': dict(Counter(r['opcode_fields'] for r in lint if r['status'] == 'accepted')),
            'partial_sdm_final_status': dict(Counter(r['status'] for r in lint if r['sdm_form'] == 'incomplete')),
            'triage_verdict': dict(Counter(r['verdict'] for r in triage)),
            'triage_review_status': dict(Counter(r['review_status'] for r in triage)),
        },
        'accepted_different_encoding': mismatch,
    }
    # Confirm that row-aware API and batch output assign different statuses.
    sample = next(r for r in mismatch if r['asm_line'] == 'add ecx, ecx')
    report['live_expected_row_probe'] = {
        'saved_batch': sample,
        'without_expected_row': ic.check_instruction(sample['asm_line'], db),
        'with_expected_row': ic.check_instruction(sample['asm_line'], db,
                                                 expected_row=db[int(sample['row_id'])]),
    }
    report['live_partial_probes'] = [ic.check_instruction(s, db) for s in (
        'rep nop', 'mov eax, dword ptr [rax]')]
    # Isolate crash classification without crashing a real tool.
    report['injected_assembler_results'] = []
    for rc, stderr in ((-11, 'injected SIGSEGV'), (-6, 'injected SIGABRT'),
                       (1, 'input syntax diagnostic')):
        fake = {'command': ['as'], 'returncode': rc, 'stdout': '',
                'stderr': stderr, 'failure': None}
        with patch.object(ic, 'command', return_value=fake):
            result = ic.check_instruction('mov eax, ebx', db, compare_clang=False)
        report['injected_assembler_results'].append({'injected_returncode': rc, 'result': result})
    timeout = subprocess.TimeoutExpired(['as'], 1, output=b'partial output', stderr=b'partial diagnostic')
    with patch.object(ic.subprocess, 'run', side_effect=timeout):
        report['injected_timeout'] = ic.command(['as'], timeout=1)
    # Check the optional assembler inspection path using otherwise genuine data.
    original_assemble = ic.assemble

    def failed_option_inspection(*args, **kwargs):
        result = original_assemble(*args, **kwargs)
        if kwargs.get('options') == ['--64']:
            result['inspection_complete'] = False
            result['inspection']['objdump'].update(returncode=1, stderr='injected decode failure')
        return result

    with patch.object(ic, 'assemble', side_effect=failed_option_inspection):
        report['injected_option_inspection'] = ic.check_instruction('mov eax, ebx', db)
    # Simulate a decoder failure in every inspected row, using a temporary batch output.
    fake_result = copy.deepcopy(ic.check_instruction('mov eax, ebx', db))
    fake_result['status'] = 'incomplete'
    for tool in ('gnu_as', 'clang'):
        fake_result[tool]['inspection_complete'] = False
        fake_result[tool]['inspection']['objdump'].update(returncode=1, stderr='injected decode failure')
    fake_result['roundtrip'] = {'status': 'not_checked'}
    with tempfile.TemporaryDirectory(prefix='fuzzing_audit_') as folder:
        argv = ['m13_lint.py', '--output-dir', folder]
        with patch.object(sys, 'argv', argv), patch.object(m13_lint, 'check_instruction', return_value=fake_result), redirect_stdout(io.StringIO()):
            rc = m13_lint.main()
        manifest = json.loads(Path(folder, 'manifest.json').read_text(encoding='utf-8'))
        counts = manifest['status_counts']
        # Same checks as the current run_ubuntu_tests.sh lint_manifest_check.
        shell_check_passes = (not manifest.get('truncated') and not manifest.get('tool_error')
            and manifest.get('generated_cases') == 7276 and manifest.get('supplemental_cases') == 7
            and not (set(counts) - {'accepted', 'needs_review', 'rejected', 'incomplete'})
            and sum(counts.values()) == 7283)
        report['injected_batch_inspection_failure'] = {
            'exit_code': rc, 'manifest': manifest, 'current_shell_checks_pass': shell_check_passes}
    output = ROOT / 'out/review/fuzzing_audit_2026-09-15.json'
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(json.dumps({'counts': report['counts'],
                     'injected_crash_statuses': [x['result']['status'] for x in report['injected_assembler_results']],
                     'batch_exit': report['injected_batch_inspection_failure']['exit_code'],
                     'batch_shell_checks_pass': shell_check_passes}, ensure_ascii=False, indent=2))
    print(output)


if __name__ == '__main__':
    main()

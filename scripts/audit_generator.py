"""Regenerate a versioned snapshot and audit inputs/encodings without CPU execution.

Historical default DB/result files are inputs only. `--assemble all` deduplicates
identical source lines per tool, then fans out observations to their SDM rows.
"""
import argparse
from collections import Counter
from concurrent.futures import ThreadPoolExecutor
import csv
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from pipeline import m2_tokenize, m3_combine, m4_generate
from pipeline.encoding_audit import check_encoding
from pipeline.generation_contract import REVISION
from pipeline.instruction_check import assemble, environment, sha256
from pipeline.input_quality import blocking_issues
from pipeline.m5_assemble import ASM_HEADER


def write_csv(path, rows, columns=None):
    with path.open('w', encoding='utf-8', newline='') as stream:
        writer = csv.DictWriter(stream, fieldnames=columns or list(rows[0]) if rows else columns or [])
        writer.writeheader()
        writer.writerows(rows)


def code(row):
    return m4_generate.build_line(row).partition('  # ')[0]


def lineage(before, after):
    by_id = {str(r['combo_id']): r for r in after}
    old_ids = {str(r['combo_id']) for r in before}
    rows = []
    for old in before:
        new = by_id.get(str(old['combo_id']))
        rows.append(dict(old_combo_id=old['combo_id'], new_combo_id=new['combo_id'] if new else '',
            row_id=old['row_id'], status='same_source_legacy_form_unverified' if new and not old.get('form_hash') else
            'preserved' if new else 'retired', old_source=code(old), new_source=code(new) if new else '',
            new_form_hash=new.get('form_hash', '') if new else ''))
    for new in after:
        if str(new['combo_id']) not in old_ids:
            rows.append(dict(old_combo_id='', new_combo_id=new['combo_id'], row_id=new['row_id'],
                status='new_identity', old_source='', new_source=code(new), new_form_hash=new['form_hash']))
    return rows


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output-dir', type=Path, default=ROOT / 'out/generator_audit_2026-09-28')
    parser.add_argument('--assemble', choices=('none', 'changed', 'all'), default='changed')
    parser.add_argument('--workers', type=int, default=4)
    parser.add_argument('--reuse-audit', type=Path, help='Recheck saved raw observations without reassembly')
    parser.add_argument('--previous-combos', type=Path, default=Path(m3_combine.OUT_CSV),
                        help='Prior combo snapshot for stable IDs/lineage (default: historical data/db/combos.csv)')
    args = parser.parse_args(argv)
    reused_hash = sha256(args.reuse_audit) if args.reuse_audit else None
    output = args.output_dir.resolve()
    if output in (ROOT, ROOT / 'data/db', ROOT / 'out'):
        parser.error('Use a dedicated snapshot directory to preserve historical outputs')
    output.mkdir(parents=True, exist_ok=True)
    isa = m2_tokenize.read_isa_db(m2_tokenize.IN_CSV)
    old = m3_combine.read_tokens(args.previous_combos)
    historical_snapshot = output / 'legacy_combos.csv'
    if not historical_snapshot.exists():
        write_csv(historical_snapshot, old)
    tokens, issues = [], []
    for index, row in enumerate(isa):
        part, found = m2_tokenize.tokenize_row(row, index, len(tokens))
        tokens.extend(part)
        issues.extend(found)
    if blocking_issues(issues):
        raise ValueError('Input extraction gate failed: %d blocking issues' % len(blocking_issues(issues)))
    combos = m3_combine.generate_combo_rows(tokens, old)
    m2_tokenize.write_tokens(tokens, output / 'tokens.csv')
    write_csv(output / 'combos.csv', combos, m3_combine.OUT_COLUMNS)
    m4_generate.write_asm(combos, [], output / 'tests.s')
    mapping = lineage(old, combos)
    write_csv(output / 'lineage.csv', mapping)
    historical_sources = {code(r) for r in old}
    selected = combos if args.assemble == 'all' else [r for r in combos if code(r) not in historical_sources]
    if args.assemble == 'none':
        selected = []
    sources = list(dict.fromkeys(code(r) for r in selected))
    print('rows=%d tokens=%d combos=%d input=%s selected=%d unique_sources=%d' %
          (len(isa), len(tokens), len(combos), dict(Counter(r['input_status'] for r in combos)), len(selected), len(sources)), flush=True)
    jobs = [(tool, source) for source in sources for tool in ('as', 'clang')]
    observations = {}
    if args.reuse_audit:
        with args.reuse_audit.open(encoding='utf-8', newline='') as stream:
            for row in csv.DictReader(stream):
                observations[(row['tool'], row['source'])] = dict(bytes=row['bytes'],
                    observation_status=row['observation_status'],
                    assembly={'stderr': row['diagnostics']},
                    inspection_complete=row['inspection_complete'] == 'True',
                    relocations=None if row['relocations'] == '' else row['relocations'] == 'True')
    pending = [job for job in jobs if job not in observations]
    def observe(job):
        tool, source = job
        return job, assemble(ASM_HEADER + source + '\n', tool)
    # Persist raw facts before decoding any SDM template; a checker failure must
    # not throw away hours of tool evidence. Keep the cache in a separate file.
    raw_columns = ['tool', 'source', 'observation_status', 'bytes', 'diagnostics', 'inspection_complete', 'relocations']
    raw_path = output / 'raw_observations.csv'
    if args.reuse_audit and args.reuse_audit.resolve() == raw_path:
        raw_path = output / 'reused_raw_observations.csv'
    with raw_path.open('w', encoding='utf-8', newline='') as raw_stream:
        raw_writer = csv.DictWriter(raw_stream, fieldnames=raw_columns)
        raw_writer.writeheader()
        def save(job, observation):
            tool, source = job
            raw_writer.writerow(dict(tool=tool, source=source, observation_status=observation['observation_status'],
                bytes=observation['bytes'], diagnostics=observation['assembly']['stderr'],
                inspection_complete=observation.get('inspection_complete', False), relocations=observation.get('relocations')))
        for job in jobs:
            if job in observations:
                save(job, observations[job])
        with ThreadPoolExecutor(max_workers=max(1, args.workers)) as pool:
            for number, (job, observation) in enumerate(pool.map(observe, pending), 1):
                observations[job] = observation
                save(job, observation)
                if number % 1000 == 0:
                    raw_stream.flush()
                    print('assembled %d/%d tool/source observations' % (number, len(pending)), flush=True)
    audits = []
    for row in selected:
        for tool in ('as', 'clang'):
            observed = observations[(tool, code(row))]
            encoded = check_encoding(observed['bytes'], row, observed.get('relocations'))
            if observed['bytes'] and not observed.get('inspection_complete'):
                encoded.update(row_reach='unverified', coverage_eligible=False)
            warned = bool(observed['assembly']['stderr']) and observed['observation_status'] == 'accepted'
            if warned:
                encoded['coverage_eligible'] = False
            audits.append(dict(combo_id=row['combo_id'], row_id=row['row_id'], tool=tool,
                source=code(row), opcode=row['opcode'], input_status=row['input_status'],
                test_kind=row['test_kind'], mode_support=row['mode_support'],
                input_violations=row['input_violations'], input_unverified=row['input_unverified'],
                observation_status=observed['observation_status'], bytes=observed['bytes'],
                diagnostics=observed['assembly']['stderr'], has_warning=warned,
                observation_review='needs_review' if warned else 'not_requested',
                encoding_status=encoded['status'], row_reach=encoded['row_reach'],
                coverage_eligible=encoded['coverage_eligible'], checked_fields=';'.join(encoded['checked_fields']),
                unverified_fields=';'.join(encoded['unverified_fields']),
                inspection_complete=observed.get('inspection_complete', False), relocations=observed.get('relocations'),
                source_hash=row['source_hash'], form_hash=row['form_hash'], constraint_hash=row['constraint_hash']))
    write_csv(output / 'encoding_audit.csv', audits)
    summary = dict(generator_revision=REVISION, assemble_scope=args.assemble,
        isa_rows=len(isa), tokens=len(tokens), combos=len(combos),
        input_status=dict(Counter(r['input_status'] for r in combos)),
        test_kind=dict(Counter(r['test_kind'] for r in combos)),
        lineage=dict(Counter(r['status'] for r in mapping)), unique_sources=len(sources),
        assembly_observations=len(jobs), audited_combo_observations=len(audits),
        newly_assembled_observations=len(pending),
        reused_observations_sha256=reused_hash,
        raw_observations_sha256=sha256(raw_path),
        result_counts={tool: dict(Counter(r['observation_status'] for r in audits if r['tool'] == tool)) for tool in ('as', 'clang')},
        warning_counts={tool: sum(r['has_warning'] for r in audits if r['tool'] == tool) for tool in ('as', 'clang')},
        row_reach={tool: dict(Counter(r['row_reach'] for r in audits if r['tool'] == tool)) for tool in ('as', 'clang')},
        coverage_eligible={tool: sum(r['coverage_eligible'] for r in audits if r['tool'] == tool) for tool in ('as', 'clang')},
        negative_observations={tool: dict(Counter(r['observation_status'] for r in audits if r['tool'] == tool and r['test_kind'] == 'negative')) for tool in ('as', 'clang')},
        source_hashes={'isa_db': sha256(m2_tokenize.IN_CSV), 'historical_combos': sha256(args.previous_combos)},
        code_hashes={path: sha256(ROOT / path) for path in ('pipeline/m2_tokenize.py', 'pipeline/m3_combine.py',
            'pipeline/m4_generate.py', 'pipeline/generation_contract.py', 'pipeline/encoding_audit.py',
            'pipeline/operand_forms.py', 'pipeline/instruction_check.py', 'scripts/audit_generator.py')},
        environment=environment(), cpu_executed=False)
    (output / 'manifest.json').write_text(json.dumps(summary, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(json.dumps({k: v for k, v in summary.items() if k not in ('environment', 'source_hashes')}, ensure_ascii=False), flush=True)
    return 0


if __name__ == '__main__':
    raise SystemExit(main())

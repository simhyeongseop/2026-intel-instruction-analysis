"""Independent, frozen expectations for the thirteen description corrections."""
import collections
import csv
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OLD = ROOT / 'out/generator_audit_2026-09-28'
NEW = ROOT / 'out/generator_audit_2026-09-29_description_fix'
EXPECTED_IDS = {'6540', '18282', '18283', '18284', '24567', '7035', '7036',
                '424', '426', '1441', '1443', '4538', '4540'}


def read(path):
    with path.open(newline='', encoding='utf-8') as stream:
        return list(csv.DictReader(stream))


def source(row):
    body = (row.get('asm_mnemonic') or row['mnemonic']).lower()
    if row['operands']:
        body += ' ' + row['operands']
    return ((row.get('asm_prefix') or '') + ' ' + body).strip()


def check_bytes(row_id, raw):
    """Check actual prefix semantics and opcode fields, not generator metadata."""
    data = bytes.fromhex(raw.replace(' ', ''))
    if row_id in ('2697', '2699'):
        assert data == bytes.fromhex('480f35' if row_id == '2697' else '480f07')
        return
    if row_id in ('231', '233', '923', '925'):
        i, rex, operand16, rex_count = 0, 0, False, 0
        while data[i] in (0x66, 0x67) or 0x40 <= data[i] <= 0x4f:
            prefix = data[i]
            if 0x40 <= prefix <= 0x4f:
                rex, rex_count = prefix, rex_count + 1
            else:
                rex = 0  # A later legacy prefix makes an earlier REX ineffective.
                operand16 |= prefix == 0x66
            i += 1
        assert rex_count <= 1
        assert data[i:] == bytes.fromhex('ff18' if row_id in ('231', '233') else 'ff28')
        width = 64 if rex & 8 else 16 if operand16 else 32
        assert width == (16 if row_id in ('231', '923') else 64)
        return
    if data[0] == 0x67:
        data = data[1:]
    assert data[0] == 0x62
    vl = (data[3] >> 5) & 3
    if row_id == '3789':
        assert vl == 0 and data[4] == 0x35 and not data[2] & 0x80
        assert data[5] >> 6 != 3  # This review targets memory destinations only.
    else:
        assert row_id in ('4045', '4046')
        assert vl == (1 if row_id == '4045' else 2)
        assert data[4:] == bytes.fromhex('a20408') and data[2] & 0x80


def main():
    old = {(r['row_id'], r['combo_index']): r for r in read(OLD / 'combos.csv')}
    new = {(r['row_id'], r['combo_index']): r for r in read(NEW / 'combos.csv')}
    assert len(old) == len(new) == 23199 and old.keys() == new.keys()
    for key, before in old.items():
        assert all(before[field] == new[key][field] for field in
                   ('raw_instruction', 'opcode', 'description', 'form_hash'))
        if source(before) == source(new[key]):
            assert before['combo_id'] == new[key]['combo_id']
    changed = [(before, new[key]) for key, before in old.items() if source(before) != source(new[key])]
    assert {before['combo_id'] for before, _ in changed} == EXPECTED_IDS
    observations = read(NEW / 'encoding_audit.csv')
    indexed = {(r['combo_id'], r['tool']): r for r in observations}
    assert len(indexed) == len(observations) == 46398
    details = []
    for before, after in changed:
        row_id = after['row_id']
        if row_id == '3789':
            assert source(after) == source(before).replace('xmmword ptr', 'qword ptr')
        elif row_id in ('4045', '4046'):
            src, dst = ('ymm1', 'xmm1') if row_id == '4045' else ('zmm1', 'ymm1')
            assert source(after) == source(before).replace(src, dst)
        elif row_id in ('2697', '2699'):
            assert source(after) == source(before) + 'q'
        for tool in ('as', 'clang'):
            observed = indexed[after['combo_id'], tool]
            assert observed['source'] == source(after)
            assert observed['observation_status'] == 'accepted'
            assert not observed['diagnostics'], observed
            check_bytes(after['row_id'], observed['bytes'])
        details.append({'old_combo_id': before['combo_id'], 'new_combo_id': after['combo_id'],
                        'row_id': after['row_id'], 'before': source(before), 'after': source(after)})
    outcomes = collections.Counter()
    for after in new.values():
        a, c = (indexed[after['combo_id'], tool] for tool in ('as', 'clang'))
        if a['observation_status'] == c['observation_status'] == 'accepted':
            key = 'both_accepted_same' if a['bytes'] == c['bytes'] else 'both_accepted_different'
        else:
            key = a['observation_status'] + '/' + c['observation_status']
        outcomes[key] += 1
    report = {'status': 'PASS', 'combos': len(new), 'changed_sources': len(changed),
              'unchanged_sources': len(new) - len(changed), 'corrected_cases': details,
              'outcomes': dict(outcomes), 'cpu_executed': False,
              'audit_sha256': hashlib.sha256((NEW / 'encoding_audit.csv').read_bytes()).hexdigest()}
    (NEW / 'independent_validation.json').write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(json.dumps(report, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()

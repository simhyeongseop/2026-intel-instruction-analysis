"""Independent snapshot checks: run from any directory; never executes instructions.

Uses raw byte positions for the three repaired encoding families, rather than
the generator's validator/encoding checker. Other ISA families are not certified.
"""
import csv
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SNAPSHOT = ROOT / 'out/generator_audit_2026-09-28'
HISTORICAL = {
    'data/db/isa_db.csv': 'e36b9c6c72f9ba3b76f4d84073a4f0b28b01ea37da3dea70087d5d33699e7f8f',
    'data/db/combos.csv': 'a014f1ea70239f8edf5831c1bc767b2a40cb94fa6d15b021414a8d1c636ce7e8',
    'data/db/tokens.csv': '1eb582297264ffb4bdeb53702d3eee1ff2182c50867b629e196ee7b3ae900c3a',
    'out/tests.s': 'ecf5b8ef057f4c65e76d5d858f5295ed409aa506b671fe8991932b06ac634300',
    'out/asm_result.csv': 'c3c9e3c7405093926f10739227cce8df36b45cb5b9cac41f8950340b569060b2',
    'out/clang_compare.csv': 'dd0e537ab1d6d30895b8ae1f483501e20938e75a6e7f3aaba4c0d99330136376',
    'out/triage.csv': '355a582c5ea646c973dc25a2598c228f7e341cbb78f2a2d43a58e63f0481b966',
}


def read_csv(path):
    with path.open(encoding='utf-8', newline='') as stream:
        return list(csv.DictReader(stream))


def source(row):
    return ' '.join(part for part in (row.get('asm_prefix', ''),
        row.get('asm_mnemonic') or row['mnemonic'].lower(), row['operands']) if part)


def main():
    for path, expected in HISTORICAL.items():
        assert hashlib.sha256((ROOT / path).read_bytes()).hexdigest() == expected, path
    manifest = json.loads((SNAPSHOT / 'manifest.json').read_text())
    for path, expected in manifest['code_hashes'].items():
        assert hashlib.sha256((ROOT / path).read_bytes()).hexdigest() == expected, path
    combos = read_csv(SNAPSHOT / 'combos.csv')
    observations = read_csv(SNAPSHOT / 'encoding_audit.csv')
    old = {row['combo_id']: row for row in read_csv(ROOT / 'data/db/combos.csv')}
    by_id = {row['combo_id']: row for row in combos}
    assert len(by_id) == len(combos)
    assert len({row['row_id'] for row in combos}) == manifest['isa_rows']
    for row in combos:
        previous = old.get(row['combo_id'])
        if previous:
            assert row['row_id'] == previous['row_id'] and source(row) == source(previous), row['combo_id']
    assert len(observations) == 2 * len(combos)
    keys = {(row['combo_id'], row['tool']) for row in observations}
    assert len(keys) == len(observations)
    counts = {'cr8': 0, 'rel32': 0, 'canonical_moffs': 0, 'eligible': 0}
    for observed in observations:
        row = by_id[observed['combo_id']]
        assert observed['source'] == source(row)
        if observed['coverage_eligible'] == 'True':
            assert row['input_status'] == 'checked' and row['mode_support'] == 'Valid', row
            assert row['test_kind'] not in ('edge', 'negative'), row
            assert observed['has_warning'] == 'False' and observed['inspection_complete'] == 'True', observed
            counts['eligible'] += 1
        if 'CR8' in row['operand_types']:
            expected = '440f22c1' if row['operand_types'].startswith('CR8') else '440f20c1'
            assert observed['bytes'] == expected, observed
            counts['cr8'] += 1
        if 'rel32' in row['operand_types']:
            data = bytes.fromhex(observed['bytes'])
            assert data and observed['observation_status'] == 'accepted', observed
            # CALL/JMP near, Jcc near, and XBEGIN are the current rel32 families.
            opcode = data[:-4]
            assert opcode in (b'\xe8', b'\xe9', b'\xc7\xf8') or (
                len(opcode) == 2 and opcode[0] == 0x0f and 0x80 <= opcode[1] <= 0x8f), observed
            assert len(data) + int.from_bytes(data[-4:], 'little', signed=True) == 4096, observed
            counts['rel32'] += 1
        if row.get('asm_mnemonic') == 'movabs':
            data = bytes.fromhex(observed['bytes'])
            assert int.from_bytes(data[-8:], 'little') == 0x100000000, observed
            assert data[-9] in (0xa0, 0xa1, 0xa2, 0xa3), observed
            if 'REX.W' in row['opcode']:
                assert 0x48 in data[:-9], observed
            counts['canonical_moffs'] += 1
    assert counts['cr8'] == 4 and counts['rel32'] == 68 and counts['canonical_moffs'] == 20, counts
    print(json.dumps({'status': 'passed', 'combos': len(combos), 'observations': len(observations),
        'preserved_historical_files': len(HISTORICAL), 'independent_byte_checks': counts}, indent=2))


if __name__ == '__main__':
    main()

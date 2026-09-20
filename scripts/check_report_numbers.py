"""발표자료에 쓰는 수치를 산출물에서 다시 계산한다.

사람이 문서에 옮겨 적은 숫자와 `out/`·`data/db/`의 실제 파일을 대조하는 것이 목적이다.
--check 문서경로 를 주면 그 문서의 숫자 표기를 찾아 일치 여부를 보고한다.

여기서 세는 것은 도구의 관측(수용 여부·바이트·분류)이지 실행 의미의 확정이 아니다.
"""
import argparse
import collections
import csv
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent


def read_rows(path):
    with open(path, newline='', encoding='utf-8') as handle:
        return list(csv.DictReader(handle))


def count_field(rows, field):
    return collections.Counter(row[field] for row in rows)


def count_inputs():
    """생성 입력의 규모와 주소·즉시값·마스크 변형 사용량."""
    rows = read_rows(ROOT / 'data/db/combos.csv')
    operands = [row['operands'] for row in rows]
    sib = re.compile(r'\[\w+\s*\+\s*\w+\*[1248]')
    mask = re.compile(r'\{k[1-7]\}')
    same_slot = 0
    for row in rows:
        parts = [part.strip() for part in row['operands'].split(',') if part.strip()]
        if len(parts) > 1 and len(set(parts)) == 1:
            same_slot += 1
    return {
        'combos': len(rows),
        'rip_relative': sum(1 for o in operands if 'rip' in o),
        'sib': sum(1 for o in operands if sib.search(o)),
        'avx512_mask': sum(1 for o in operands if mask.search(o)),
        'broadcast': sum(1 for o in operands if '{1to' in o),
        'all_operands_identical': same_slot,
        'variants': collections.Counter(
            tag.strip()
            for row in rows
            for tag in row['note'].split(';')
            if tag.strip().startswith('variant:')
        ),
    }


def count_assemble():
    rows = read_rows(ROOT / 'out/asm_result.csv')
    result = count_field(rows, 'actual_result')
    # 매뉴얼이 Valid라고 적은 행인데 as가 거부한 것 — 우리 입력 결함을 재는 지표다.
    valid_rejected = [
        row for row in rows
        if row['actual_result'] == 'error' and row['expected_valid'] == 'True'
    ]
    return {
        'total': len(rows),
        'ok': result['ok'],
        'error': result['error'],
        'crashed': result['crashed'],
        'timeout': result['timeout'],
        'valid_rejected': len(valid_rejected),
        'expected_rejected': result['error'] - len(valid_rejected),
        'valid_rejected_mnemonics': sorted({row['mnemonic'] for row in valid_rejected}),
    }


def count_triage():
    rows = read_rows(ROOT / 'out/triage.csv')
    unsure = collections.Counter(
        row['category'] for row in rows if row['verdict'] == 'unsure')
    false_alarm = collections.Counter(
        row['category'] for row in rows if row['verdict'] == 'false_alarm')
    return {
        'rows': len(rows),
        'false_alarm_categories': dict(false_alarm),
        'verdict': dict(count_field(rows, 'verdict')),
        'review_status': dict(count_field(rows, 'review_status')),
        'unsure_categories': dict(unsure),
    }


def count_clang():
    rows = read_rows(ROOT / 'out/clang_compare.csv')
    clang = read_rows(ROOT / 'out/clang_result.csv')
    return {
        'category': dict(count_field(rows, 'category')),
        'clang_result': dict(count_field(clang, 'actual_result')),
    }


def count_roundtrip():
    rows = read_rows(ROOT / 'out/roundtrip.csv')
    reassemble = read_rows(ROOT / 'out/reassemble_check.csv')
    return {
        'compare': dict(count_field(rows, 'result')),
        'reassemble': dict(count_field(reassemble, 'category')),
    }


def count_lint():
    manifest = json.loads((ROOT / 'out/lint/manifest.json').read_text(encoding='utf-8'))
    return {
        'generated_cases': manifest['generated_cases'],
        'supplemental_cases': manifest['supplemental_cases'],
        'unique_sources': manifest['unique_sources'],
        'status_counts': manifest['status_counts'],
        'opcode_field_counts': manifest['opcode_field_counts'],
        'tool_error': manifest['tool_error'],
        'tools': {
            name: probe['version'][0]
            for name, probe in manifest['environment']['tools'].items()
        },
    }


def count_encoding_causes():
    """지정한 SDM 행을 시험하지 못한 건들을 원인별로 나눈다.

    "몇 건이 안 됐다"만으로는 고칠 수 있는 것과 구조적 한계가 섞인다.
    관측한 바이트와 지정 opcode 문자열만 보고 나누며, 의미 동등성은 판정하지 않는다.
    """
    path = ROOT / 'out/lint/observations.jsonl'
    records = [json.loads(line) for line in path.open(encoding='utf-8')]
    missed = [
        record for record in records
        if any(finding.get('code') == 'target_encoding_not_exercised'
               for finding in record.get('findings', []))
    ]

    def has_rex_w(byte_text):
        """주소·오퍼랜드 크기 프리픽스를 걷어내고 REX.W(48~4F)가 있는지 본다."""
        rest = byte_text.lower()
        while rest[:2] in ('67', '66', 'f2', 'f3'):
            rest = rest[2:]
        return len(rest) >= 2 and 0x48 <= int(rest[:2], 16) <= 0x4f

    causes = collections.Counter()
    examples = {}
    for record in missed:
        expected = record['expected_encoding']['expected']
        observed = record['gnu_as']['bytes']
        if re.search(r'c[wdb]$', expected):
            cause = 'branch_displacement_shortened'
        elif expected.upper().startswith('REX.W') and not has_rex_w(observed):
            cause = 'rex_w_not_emitted'
        else:
            cause = 'same_syntax_other_row'
        causes[cause] += 1
        examples.setdefault(cause, f'{record["source"]} | 지정 {expected} | 실제 {observed}')
    return {'total': len(missed), 'causes': dict(causes), 'examples': examples}


def count_checklist():
    rows = read_rows(ROOT / 'review/false_alarm_checklist.csv')
    filled = sum(1 for row in rows if (row.get('내_판단') or '').strip())
    return {'rows': len(rows), 'filled': filled}


def collect():
    return {
        'inputs': count_inputs(),
        'assemble': count_assemble(),
        'triage': count_triage(),
        'clang': count_clang(),
        'roundtrip': count_roundtrip(),
        'lint': count_lint(),
        'checklist': count_checklist(),
        'encoding_causes': count_encoding_causes(),
    }


def flatten(data, prefix=''):
    """문서 대조에 쓰도록 {'경로': 정수} 형태로 편다."""
    flat = {}
    for key, value in data.items():
        name = f'{prefix}.{key}' if prefix else key
        if isinstance(value, dict):
            flat.update(flatten(value, name))
        elif isinstance(value, int):
            flat[name] = value
    return flat


# 문서에 나오는 표기 → 위 flatten 경로. 문서를 고칠 때 이 표도 함께 본다.
DOC_KEYS = {
    '입력줄': 'inputs.combos',
    'as수용': 'assemble.ok',
    'as거부': 'assemble.error',
    'valid거부': 'assemble.valid_rejected',
    'clang수용': 'clang.clang_result.ok',
    'clang거부': 'clang.clang_result.error',
    '바이트같음': 'clang.category.both_ok_same_bytes',
    '바이트다름': 'clang.category.both_ok_diff_bytes',
    'as만수용': 'clang.category.as_only',
    'clang만수용': 'clang.category.clang_only',
    '둘다거부': 'clang.category.both_reject',
    'bug': 'triage.verdict.bug',
    'false_alarm': 'triage.verdict.false_alarm',
    'unsure': 'triage.verdict.unsure',
    'not_reassessed': 'triage.review_status.not_reassessed',
    'accepted': 'lint.status_counts.accepted',
    'needs_review': 'lint.status_counts.needs_review',
    'rejected': 'lint.status_counts.rejected',
    'not_checked': 'lint.opcode_field_counts.not_checked',
    'different_encoding': 'lint.opcode_field_counts.different_encoding',
    'rip': 'inputs.rip_relative',
    'sib': 'inputs.sib',
    '마스크': 'inputs.avx512_mask',
    '브로드캐스트': 'inputs.broadcast',
    '체크리스트행': 'checklist.rows',
    '체크리스트기입': 'checklist.filled',
    '미타격합계': 'encoding_causes.total',
    '미타격_대칭행': 'encoding_causes.causes.same_syntax_other_row',
    '미타격_분기축약': 'encoding_causes.causes.branch_displacement_shortened',
    '미타격_rexw': 'encoding_causes.causes.rex_w_not_emitted',
    '기대된거부': 'assemble.expected_rejected',
    '왕복같음': 'roundtrip.compare.same',
    '왕복다름': 'roundtrip.compare.different',
    '재조립동일': 'roundtrip.reassemble.byte_roundtrip_same',
    '표기_숫자': 'triage.false_alarm_categories.numeric_repr',
    '표기_별명': 'triage.false_alarm_categories.mnemonic_alias',
    '표기_브로드캐스트': 'triage.false_alarm_categories.broadcast_display',
    '표기_숨은오퍼랜드': 'triage.false_alarm_categories.implicit_operand_display',
}


def check_document(path, flat):
    """문서 안의 `<!-- num:키 -->` 주석 뒤 숫자가 실제 값과 같은지 본다."""
    text = Path(path).read_text(encoding='utf-8')
    pattern = re.compile(r'<!--\s*num:([^\s]+)\s*-->\s*([0-9,]+)')
    seen = mismatch = 0
    for match in pattern.finditer(text):
        key, written = match.group(1), int(match.group(2).replace(',', ''))
        target = DOC_KEYS.get(key, key)
        if target not in flat:
            print(f'FAIL {key}: 산출물에서 계산하지 않는 값')
            mismatch += 1
            continue
        seen += 1
        if flat[target] != written:
            print(f'FAIL {key}: 문서 {written:,} != 산출물 {flat[target]:,}')
            mismatch += 1
    print(f'{path}: 대조 {seen}건, 불일치 {mismatch}건')
    return mismatch


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='append', default=[],
                        help='숫자를 대조할 문서 경로')
    parser.add_argument('--json', action='store_true', help='전체 수치를 JSON으로 출력')
    args = parser.parse_args()

    data = collect()
    flat = flatten(data)

    if args.json or not args.check:
        print(json.dumps(data, ensure_ascii=False, indent=2, sort_keys=True))

    mismatch = sum(check_document(path, flat) for path in args.check)
    return 1 if mismatch else 0


if __name__ == '__main__':
    sys.exit(main())

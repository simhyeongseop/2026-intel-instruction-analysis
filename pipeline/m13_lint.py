"""13단계: 명령어 검사 도구를 전체 입력과 명명된 추가 사례에 적용한다."""
import argparse
from collections import Counter
import csv
from datetime import datetime, timezone
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from pipeline.instruction_check import (check_instruction, environment, evaluate_expected,
                                        sha256)
from pipeline.operand_forms import check_opcode_template, load_db


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--limit', type=int, default=0, help='시험용 명령어 수 제한. 0이면 전량 검사')
    parser.add_argument('--output-dir', type=Path, default=ROOT / 'out/lint')
    parser.add_argument('--syntax', choices=('intel',), default='intel')
    parser.add_argument('--display-syntax', choices=('intel', 'att'), default='intel')
    parser.add_argument('--encoding-policy', choices=('allow_equivalent',), default='allow_equivalent')
    args = parser.parse_args()
    if args.limit < 0:
        parser.error('limit은 0 이상이어야 합니다.')
    rows = load_db()
    with (ROOT / 'out/asm_result.csv').open(encoding='utf-8') as stream:
        source_rows = list(csv.DictReader(stream))
    with (ROOT / 'data/cases.csv').open(encoding='utf-8') as stream:
        extra_rows = list(csv.DictReader(stream))
    items = [{'case_id': 'combo_' + row['combo_id'], 'asm_line': row['asm_line'],
              'row_id': row['row_id'], 'group': 'generated'} for row in source_rows]
    items += [dict(row, group='supplemental', row_id='') for row in extra_rows]
    total = len(items)
    if args.limit:
        items = items[:args.limit]
    output = args.output_dir
    output.mkdir(parents=True, exist_ok=True)
    cached, results = {}, []
    tool_error = False
    validation_failures = Counter()
    with (output / 'observations.jsonl').open('w', encoding='utf-8') as detail:
        for index, item in enumerate(items):
            code = item['asm_line']
            cache_key = (code, args.syntax, args.display_syntax)
            if cache_key not in cached:
                result = check_instruction(code, rows, syntax=args.syntax,
                                           display_syntax=args.display_syntax)
                cached[cache_key] = result
            result = cached[cache_key]
            expected = (rows[int(item['row_id'])] if item['row_id'] else
                        {'row_id': item['case_id'], 'opcode': item['expected_opcode']})
            evaluated = evaluate_expected(result, expected, args.encoding_policy)
            detail.write(json.dumps(evaluated, ensure_ascii=False) + '\n')
            tool_error = tool_error or evaluated.get('validation_status') == 'tool_failed' or any(
                evaluated.get(t, {}).get('observation_status') in
                ('timeout', 'unavailable', 'resource_failure', 'tool_failed', 'process_crash')
                for t in ('gnu_as', 'clang'))
            if evaluated.get('validation_status') not in (None, 'not_requested', 'checked', 'unsupported'):
                validation_failures[evaluated['validation_status']] += 1
            results.append({
                'case_id': item['case_id'], 'group': item['group'], 'row_id': item['row_id'],
                'asm_line': code, 'status': evaluated['status'], 'validation_status': evaluated.get('validation_status', 'not_checked'),
                'policy_decision': evaluated.get('policy_decision', 'not_requested'),
                'syntax': args.syntax, 'display_syntax': args.display_syntax,
                'sdm_form': evaluated.get('sdm', {}).get('status', 'not_checked'),
                'as_status': evaluated.get('gnu_as', {}).get('status', 'not_checked'),
                'as_observation_status': evaluated.get('gnu_as', {}).get('observation_status', 'not_checked'),
                'as_bytes': evaluated.get('gnu_as', {}).get('bytes', ''),
                'clang_status': evaluated.get('clang', {}).get('status', 'not_checked'),
                'clang_observation_status': evaluated.get('clang', {}).get('observation_status', 'not_checked'),
                'clang_bytes': evaluated.get('clang', {}).get('bytes', ''),
                'comparison': evaluated.get('comparison', 'not_checked'),
                'roundtrip': evaluated.get('roundtrip', {}).get('status', 'not_checked'),
                'expected_opcode': expected['opcode'], 'opcode_fields': evaluated.get('expected_encoding', {}).get('status', 'not_checked'),
                'opcode_checked_fields': ';'.join(evaluated.get('expected_encoding', {}).get('checked_fields', [])),
                'encoding_target_match': evaluated.get('encoding_target_match', 'not_requested'),
                'findings': ';'.join(f['code'] for f in evaluated['findings']),
                'semantic_status': 'not_verified',
            })
            if (index + 1) % 500 == 0:
                print('lint %d/%d (고유 소스 %d)' % (index + 1, len(items), len(cached)), flush=True)
    if results:
        with (output / 'results.csv').open('w', encoding='utf-8', newline='') as stream:
            writer = csv.DictWriter(stream, fieldnames=list(results[0]))
            writer.writeheader()
            writer.writerows(results)
    generated = [r for r in results if r['group'] == 'generated']
    counts = dict(Counter(r['status'] for r in results))
    opcode_counts = dict(Counter(r['opcode_fields'] for r in generated))
    manifest = {'schema_version': 2, 'created_utc': datetime.now(timezone.utc).isoformat(),
                'environment': environment(), 'input_hashes': {p: sha256(ROOT / p) for p in (
                    'data/db/isa_db.csv', 'out/asm_result.csv', 'data/cases.csv')},
                'code_hashes': {p: sha256(ROOT / p) for p in ('pipeline/m13_lint.py', 'pipeline/instruction_check.py', 'pipeline/operand_forms.py')},
                'generated_cases': len(generated), 'supplemental_cases': len(results) - len(generated),
                'unique_sources': len(cached), 'truncated': len(items) < total,
                'status_counts': counts, 'opcode_field_counts': opcode_counts,
                'encoding_policy': args.encoding_policy, 'syntax': args.syntax,
                'display_syntax': args.display_syntax,
                'validation_failures': dict(validation_failures),
                'semantic_coverage': 'not_measured', 'tool_error': tool_error,
                'output_hashes': {p: sha256(output / p) for p in ('results.csv', 'observations.jsonl') if (output / p).exists()}}
    (output / 'manifest.json').write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    lines = ['# 명령어 검사 결과 (13단계)', '',
             '생성 테스트 %d개 + 추가 사례 %d개, 고유 소스 %d개.' % (len(generated), len(results)-len(generated), len(cached)), '',
             '## 검사 상태', '', '| 상태 | 수 |', '|---|---:|']
    lines += ['| %s | %d |' % p for p in sorted(counts.items())]
    lines += ['', 'accepted는 지정 도구가 수용하고 수행한 제한 검사에서 검토 항목이 없다는 뜻이다.',
              'needs_review는 버그 수가 아니며 incomplete/tool_error는 검사 완료로 세지 않는다.',
              'syntax는 입력 문법, display_syntax는 역어셈블 표시 문법이다. 현재 입력 syntax는 intel만 지원한다.',
              'encoding_policy=allow_equivalent여도 의미 동등성 근거가 없으면 target_encoding_not_exercised로 검토한다.',
              '', '## 지정한 SDM 행의 legacy opcode 필드 대조', '', '| 결과 | 수 |', '|---|---:|']
    lines += ['| %s | %d |' % p for p in sorted(opcode_counts.items())]
    lines += ['', 'fields_match도 전체 인코딩 행/실행 의미 일치가 아니다. VEX/EVEX, +r, CPUID,',
              '오퍼랜드 제약 및 모드 해석 등은 부분 검사 범위 밖이다. 의미 검증 커버리지는 아직 산출하지 않는다.',
              '', '## 추가 사례', '', '| 사례 | 상태 | opcode 필드 | 관측 |', '|---|---|---|---|']
    lines += ['| %s | %s | %s | %s |' % (r['case_id'], r['status'], r['opcode_fields'], r['findings'])
              for r in results if r['group'] == 'supplemental']
    lines += ['', '원시 명령행/표준출력/에러는 observations.jsonl, 버전/해시는 manifest.json, 행별 요약은 results.csv.',
              '기존 5~10단계 저장 결과를 덮어쓰지 않고 이 실행의 관측을 별도로 보존한다.',
              '입력 명령어를 CPU에서 실행하지 않았다.', '']
    (output / 'report.md').write_text('\n'.join(lines), encoding='utf-8')
    print(json.dumps(counts, ensure_ascii=False))
    print(output / 'report.md')
    return 2 if tool_error else 0


if __name__ == '__main__':
    raise SystemExit(main())

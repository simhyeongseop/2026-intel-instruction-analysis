#!/usr/bin/env python3
"""Intel syntax 명령어 검사 CLI. 예: python scripts/asm_linter.py 'mov eax, ebx'

줄마다 후보 SDM 행을 찾고, 파이프라인 3·4단계와 같은 기준으로 판정한다(pipeline/sdm_judge.py).
SDM 대 각 어셈블러(GNU as, clang), SDM 대 각 역어셈블러(objdump, llvm-mc). 도구끼리는 비교하지 않는다.
"""
import argparse
from collections import Counter
from datetime import datetime, timezone
import json
from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))
from pipeline.instruction_check import check_instruction, environment, sha256
from pipeline.operand_forms import DB_PATH, load_db

DEMO = ['mov eax, ebx', 'mov eax, rbx', 'lss rcx, tbyte ptr [eax]',
        'lss rcx, fword ptr [eax]', 'mov ds, qword ptr [eax]', 'lar rcx, rcx', 'udb']
STATUS_TEXT = {'accepted': '수용됨 (실행 의미는 미검증)', 'rejected': 'GNU as 거부',
               'needs_review': '추가 확인 필요', 'incomplete': '검사 미완료',
               'tool_error': '도구 실행 오류', 'diagnostic_rejection': '문법 진단 거부',
               'process_crash': '프로세스 비정상 종료',
               'timeout': '도구 timeout', 'unavailable': '도구 없음',
               'resource_failure': '자원 오류', 'skipped': '설정/라벨'}
SUMMARY_TEXT = {'sdm_match': '모든 도구가 SDM과 일치', 'sdm_difference': 'SDM과 다른 도구가 있음',
                'no_sdm_row': '형태가 맞는 SDM 행 없음'}
EXPECTED_TEXT = {'reach': '64비트 모드 유효 행이 있음(조립돼야 함)', 'reject': '후보가 모두 64비트 무효(거부돼야 함)',
                 'unknown': '후보 행 없음'}


def print_candidates(row):
    """후보 SDM 행: 형태 match / partial(검사기 범위 밖 칸), 64비트 모드, 행 상태(원문 검토)."""
    sdm = row['sdm']
    found = sdm['rows']
    expected = row.get('sdm_judgment', {}).get('expected')
    print('  후보 SDM 행 %d개%s%s' % (len(found), ' (REP 따로 붙인 형식)' if sdm.get('rep_separate') else '',
                                   (' - ' + EXPECTED_TEXT[expected]) if expected else ''))
    for c in found[:6]:
        print('    %5s  %-36s %-26s %-6s %s%s' % (c['row_id'], c['instruction'][:36], c['opcode'][:26],
                                              c['mode_support'], c['row_status'],
                                              '' if c['form'] == 'match' else ' (형태 일부 미대조)'))
    if len(found) > 6:
        print('    ... %d개 더' % (len(found) - 6))


def source_records(text):
    """줄 번호 보존. GAS의 세미콜론은 주석이 아닌 문장 구분자다."""
    blocked = False
    for number, line in enumerate(text.splitlines(), 1):
        line = line.split('#', 1)[0]
        # 지원 범위에서 문자열 리터럴은 금지하므로 #를 주석으로 처리할 수 있다.
        if '"' in line or "'" in line or '/*' in line or '*/' in line:
            yield number, line, 'unsupported'
            blocked = True
            continue
        for part in line.split('#', 1)[0].split(';'):
            code = part.strip()
            if not code:
                continue
            code = re.sub(r'^(?:[A-Za-z_.$][\w.$]*|\d+):\s*', '', code).strip()
            if not code or code in ('.intel_syntax noprefix', '.text'):
                yield number, part.strip(), 'skipped' if not blocked else 'unsupported'
            elif code.startswith('.'):
                # 매크로·모드·섹션 변경을 무시한 뒤 정상이라고 잘못 판정하지 않는다.
                blocked = True
                yield number, code, 'unsupported'
            else:
                yield number, code, 'unsupported' if blocked else 'instruction'


def exit_code(results):
    if any(r['status'] in ('incomplete', 'tool_error', 'process_crash', 'timeout',
                           'unavailable', 'resource_failure') for r in results):
        return 2
    if not any(r['status'] != 'skipped' for r in results):
        return 2
    return 1 if any(r['status'] in ('rejected', 'needs_review') for r in results) else 0


def print_text(report):
    for row in report['results']:
        if row['status'] == 'skipped':
            continue
        print('[%s] %s' % (STATUS_TEXT[row['status']], row['source']))
        if 'reason' in row:
            print('  ' + row['reason'])
        if 'sdm' in row:
            print_candidates(row)
        judgment = row.get('sdm_judgment')
        for tool, label in (('gnu_as', 'GNU as'), ('clang', 'clang')):
            record = row.get(tool)
            if not record:
                continue
            verdict = judgment['assemblers'].get(tool, {}) if judgment else {}
            print('  %-8s %-18s %s%s' % (label, verdict.get('verdict', record['status']), record['bytes'] or '-',
                                         ('  -> 행 ' + ', '.join(map(str, verdict['rows']))) if verdict.get('rows') else ''))
            if record['assembly']['stderr']:
                print('    ' + record['assembly']['stderr'].strip().replace('\n', '\n    '))
            if verdict.get('note'):
                print('    ' + verdict['note'])
        for name, label in (('objdump', 'objdump'), ('llvm', 'llvm-mc')):
            decoded = (judgment or {}).get('disassemblers', {}).get(name)
            if decoded:
                print('  %-8s %-18s %s  (%s 바이트, 행 %s)' % (label, decoded['verdict'], decoded['text'] or '-',
                                                            'GNU' if decoded['from'] == 'gnu_as' else 'clang',
                                                            decoded['row_id']))
        if judgment:
            print('  SDM 대조: %s (인코딩 필드 대조, 실행 의미 아님)' % SUMMARY_TEXT[judgment['summary']])
        for note in row['findings']:
            print('  [%s] %s' % (note['type'], note['message']))
        if 'expected_encoding' in row:
            print('  지정 행 opcode: ' + row['expected_encoding']['status'])
    print('집계: ' + ', '.join('%s=%d' % p for p in report['counts'].items()))
    print('종료 코드 %d. 0도 전체 ISA 적합성이나 CPU 실행 안전성을 보증하지 않습니다.' % report['exit_code'])


def main(argv=None):
    if hasattr(sys.stdout, 'reconfigure'):
        sys.stdout.reconfigure(encoding='utf-8')
    parser = argparse.ArgumentParser(description=__doc__)
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('code', nargs='?', help='따옴표로 묶은 명령어 한 줄')
    group.add_argument('-f', '--file', type=Path, help='.s 파일 (각 명령어를 독립 검사)')
    group.add_argument('--stdin', action='store_true', help='표준 입력으로 .s 텍스트 읽기')
    group.add_argument('--demo', action='store_true')
    parser.add_argument('--static-only', action='store_true')
    parser.add_argument('--no-clang', action='store_true')
    parser.add_argument('--format', choices=('text', 'json', 'jsonl'), default='text')
    parser.add_argument('--output', type=Path, help='리포트 파일')
    parser.add_argument('--db', type=Path, default=DB_PATH)
    parser.add_argument('--expect-row', help='SDM DB의 0-based 행 ID; 제한된 legacy opcode 필드 대조')
    parser.add_argument('--limit', type=int, default=0, help='검사할 명령어 수 (0=제한 없음)')
    parser.add_argument('--timeout', type=float, default=10)
    parser.add_argument('--syntax', choices=('intel',), default='intel')
    parser.add_argument('--display-syntax', choices=('intel', 'att'), default='intel')
    args = parser.parse_args(argv)
    if args.timeout <= 0 or args.limit < 0:
        parser.error('timeout은 양수, limit은 0 이상이어야 합니다.')
    try:
        rows = load_db(args.db)
        if args.expect_row is not None:
            expected = next((r for r in rows if r['row_id'] == args.expect_row), None)
            if expected is None:
                parser.error('존재하지 않는 row_id입니다.')
        else:
            expected = None
        text = ('\n'.join(DEMO) if args.demo else args.file.read_text(encoding='utf-8-sig')
                if args.file else sys.stdin.read() if args.stdin else args.code)
    except (OSError, ValueError) as error:
        parser.error(str(error))
    records, results = list(source_records(text)), []
    checked = 0
    truncated = False
    for number, code, kind in records:
        if kind != 'skipped' and args.limit and checked >= args.limit:
            truncated = True
            break
        if kind == 'instruction':
            row = check_instruction(code, rows, args.static_only, not args.no_clang,
                                    args.timeout, expected, args.syntax, args.display_syntax)
            checked += 1
        else:
            row = {'source': code, 'status': 'skipped' if kind == 'skipped' else 'incomplete',
                   'findings': [], 'semantic_status': 'not_verified'}
            if kind != 'skipped':
                checked += 1
                row['reason'] = '미지원 지시자/문법 또는 그 뒤의 상태에 의존하는 입력입니다.'
        row['line'] = number
        results.append(row)
    counts = dict(Counter(row['status'] for row in results))
    report = {'schema_version': 1, 'created_utc': datetime.now(timezone.utc).isoformat(),
              'scope': 'independent_instruction_x86_64', 'syntax': args.syntax,
              'display_syntax': args.display_syntax,
              'source_sha256': __import__('hashlib').sha256(text.encode()).hexdigest(),
              'db_sha256': sha256(args.db), 'environment': environment(),
              'settings': {'static_only': args.static_only, 'clang': not args.no_clang, 'timeout': args.timeout,
                           'syntax': args.syntax, 'display_syntax': args.display_syntax},
              'truncated': truncated, 'counts': counts, 'results': results,
              'exit_code': 2 if truncated else exit_code(results)}
    if args.format == 'text':
        if args.output:
            parser.error('--output에는 --format json 또는 jsonl을 함께 사용하세요.')
        print_text(report)
    else:
        if args.format == 'json':
            output = json.dumps(report, ensure_ascii=False, indent=2) + '\n'
        else:
            metadata = {k: v for k, v in report.items() if k != 'results'}
            output = json.dumps({'record_type': 'summary', **metadata}, ensure_ascii=False) + '\n'
            output += ''.join(json.dumps({'record_type': 'instruction', **row}, ensure_ascii=False) + '\n' for row in results)
        if args.output:
            args.output.parent.mkdir(parents=True, exist_ok=True)
            args.output.write_text(output, encoding='utf-8')
        else:
            sys.stdout.write(output)
    return report['exit_code']


if __name__ == '__main__':
    raise SystemExit(main())

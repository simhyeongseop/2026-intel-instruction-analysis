"""한 명령어의 수용·바이트·역어셈블 관측. 입력 명령어를 CPU에서 실행하지 않는다."""
import hashlib
import os
import platform
import re
import shutil
import subprocess
import tempfile
import copy
from functools import lru_cache
from pathlib import Path

from pipeline import toolchain as T
from pipeline.operand_forms import (check_opcode_template, compare_forms, legacy_fields,
                                    parse_instruction)

AS_OPTIONS = ['--64', '-mintel64']
HEADER = '.intel_syntax noprefix\n.text\n.Ltarget:\n'
SUPPORTED_SYNTAX = {'intel'}
SUPPORTED_DISPLAY_SYNTAX = {'intel', 'att'}


def sha256(path):
    digest = hashlib.sha256()
    with open(path, 'rb') as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b''):
            digest.update(block)
    return digest.hexdigest()


def command(args, cwd=None, timeout=10):
    """프로세스 결과를 분류하고 stdout/stderr를 보존한다."""
    def text_output(value):
        if value is None:
            return ''
        if isinstance(value, bytes):
            return value.decode('utf-8', errors='replace')
        return str(value)

    env = dict(os.environ, LC_ALL='C')
    try:
        run = subprocess.run(args, cwd=cwd, env=env, capture_output=True,
                             text=True, encoding='utf-8', errors='replace', timeout=timeout)
        status = 'process_crash' if run.returncode < 0 else 'completed'
        return {'command': list(args), 'returncode': run.returncode,
                'stdout': run.stdout, 'stderr': run.stderr, 'failure': None,
                'status': status}
    except subprocess.TimeoutExpired as error:
        return {'command': list(args), 'returncode': None, 'stdout': '',
                'stderr': text_output(error.stderr) or 'tool timeout',
                'stdout_partial': text_output(error.output), 'failure': 'timeout',
                'status': 'timeout'}
    except FileNotFoundError as error:
        return {'command': list(args), 'returncode': None, 'stdout': '',
                'stderr': str(error), 'failure': 'unavailable', 'errno': error.errno,
                'status': 'unavailable'}
    except PermissionError as error:
        return {'command': list(args), 'returncode': None, 'stdout': '',
                'stderr': str(error), 'failure': 'tool_failed', 'errno': error.errno,
                'status': 'tool_failed'}
    except OSError as error:
        failure = 'resource_failure' if error.errno in (12, 24) else 'tool_failed'
        return {'command': list(args), 'returncode': None, 'stdout': '',
                'stderr': str(error), 'failure': failure, 'errno': error.errno,
                'status': failure}


def process_status(run):
    """command() 결과를 accepted/diagnostic_rejection 또는 실패 사건으로 분류한다."""
    if run.get('failure'):
        return run['failure']
    if run.get('returncode', 0) < 0:
        return 'process_crash'
    return 'accepted' if run.get('returncode') == 0 else 'diagnostic_rejection'


@lru_cache(maxsize=32)
def tool_info(name):
    path = shutil.which(T.ALL.get(name, name))   # pipeline/toolchain.py의 경로
    if not path:
        return {'available': False, 'name': name}
    result = command([path, '--version'])
    return {'available': result['returncode'] == 0, 'path': str(Path(path).resolve()),
            # 판 번호(2.47, 23.1.3 …)가 든 첫 줄. llvm-mc는 첫 줄이 'LLVM (http://llvm.org/):'다
            'version': ([l.strip() for l in (result['stdout'] or result['stderr']).splitlines()
                         if re.search(r'\d+\.\d+', l)] or (result['stdout'] or result['stderr']).splitlines())[0:1],
            'sha256': sha256(path), 'probe': result}


def environment(tool_names=('as', 'ld', 'objdump', 'objcopy', 'readelf', 'clang', 'llvm-mc')):
    result = {'platform': platform.platform(), 'machine': platform.machine(),
              'python': platform.python_version(),
              'tools': {name: tool_info(name) for name in tool_names}}
    cpuinfo = Path('/proc/cpuinfo')
    if cpuinfo.exists():
        text = cpuinfo.read_text(errors='replace')
        result['cpu'] = {key: re.search(r'^%s\s*:\s*(.*)$' % key, text, re.M).group(1)
                         for key in ('vendor_id', 'model name', 'flags')
                         if re.search(r'^%s\s*:' % key, text, re.M)}
    return result


def decode_lines(text):
    result = []
    for line in text.splitlines():
        match = re.match(r'^\s*([0-9a-f]+):\s+((?:[0-9a-f]{2}\s+)+)\s*(\S.*)$', line)
        if match:
            result.append({'offset': int(match.group(1), 16),
                           'bytes': ''.join(match.group(2).split()),
                           'text': match.group(3).strip()})
    return result


def assemble(source, tool='as', options=None, timeout=10, display_syntax='intel'):
    """단일 .text 전체 바이트를 objcopy로 읽는다. objdump 첫 줄만 잘라 읽지 않는다."""
    with tempfile.TemporaryDirectory(prefix='asmcheck_') as folder:
        Path(folder, 'input.s').write_text(source, encoding='utf-8', newline='\n')
        if tool == 'as':
            args = [T.AS] + (AS_OPTIONS if options is None else options)
        else:
            args = [T.CLANG, '-target', 'x86_64-linux-gnu', '-c', '-x', 'assembler']
        run = command(args + ['-o', 'input.o', 'input.s'], folder, timeout)
        observed_status = process_status(run)
        result = {'status': ('rejected' if observed_status == 'diagnostic_rejection' else observed_status),
                  'observation_status': observed_status,
                  'assembly': run, 'source': source, 'bytes': '', 'instructions': [],
                  'relocations': None, 'inspection_complete': False,
                  'validation_status': 'not_requested', 'display_syntax': display_syntax}
        if observed_status != 'accepted':
            return result
        if not Path(folder, 'input.o').exists():
            result.update(status='accepted', validation_status='tool_failed',
                          inspection_failure='object_missing', reason='오브젝트 파일이 생성되지 않음')
            return result
        extract = command([T.OBJCOPY, '-O', 'binary', '--only-section=.text', 'input.o', 'text.bin'], folder, timeout)
        decode = command([T.OBJDUMP, '-d', '-w', '-M', display_syntax, '--insn-width=16', 'input.o'], folder, timeout)
        reloc = command([T.READELF, '-rW', 'input.o'], folder, timeout)
        result['inspection'] = {'objcopy': extract, 'objdump': decode, 'readelf': reloc}
        if extract['returncode'] == 0 and Path(folder, 'text.bin').exists():
            result['bytes'] = Path(folder, 'text.bin').read_bytes().hex()
        if decode['returncode'] == 0:
            result['instructions'] = decode_lines(decode['stdout'])
        if reloc['returncode'] == 0:
            result['relocations'] = bool(re.search(r'\bR_X86_64_\w+', reloc['stdout']))
        contiguous = bool(result['instructions'])
        end = 0
        for instruction in result['instructions']:
            contiguous = contiguous and instruction['offset'] == end
            end += len(instruction['bytes']) // 2
        result['inspection_complete'] = (
            all(x['returncode'] == 0 for x in (extract, decode, reloc))
            and contiguous and end * 2 == len(result['bytes'])
            and ''.join(x['bytes'] for x in result['instructions']) == result['bytes'])
        result['validation_status'] = 'checked' if result['inspection_complete'] else 'tool_failed'
        if not result['inspection_complete']:
            result['inspection_failure'] = 'inspection_incomplete'
        return result


def finding(code, kind, message, confidence='observed'):
    return {'code': code, 'type': kind, 'confidence': confidence, 'message': message}


def static_findings(parsed):
    findings = []
    name, ops = parsed['mnemonic'], parsed['operands']
    if name in ('lss', 'lfs', 'lgs', 'lds', 'les') and len(ops) == 2:
        dest, memory = ops
        if dest['family'] == 'gpr' and memory['kind'] == 'mem' and memory['bits'] is not None:
            if memory['bits'] != dest['bits'] + 16:
                findings.append(finding('far_pointer_size', 'input_form_difference',
                    '원거리 포인터는 목적지 오프셋 폭 + 셀렉터 16비트. 입력 크기 표기를 확인하세요.'))
    if name == 'mov' and len(ops) == 2 and ops[0]['family'] == 'sreg':
        if ops[1]['kind'] == 'mem' and ops[1]['bits'] not in (None, 16):
            findings.append(finding('mov_sreg_memory_notation', 'spec_ambiguity',
                'GNU as의 word ptr 지원과 SDM r/m64 표기를 구분해야 합니다. 실제 접근 폭 근거는 재심 기록 참조.'))
    if name == 'udb':
        findings.append(finding('udb_support', 'support_gap',
            'SDM에서 D6는 UDB로 정의됩니다. 니모닉 지원 여부는 현재 도구 실측을 보세요. 미지원만으로 버그가 되지 않습니다.'))
    return findings


def observed_findings(parsed, result):
    findings = []
    if result['status'] != 'accepted' or not result['bytes']:
        return findings
    data, pos, rex, _ = legacy_fields(result['bytes'])
    ops, mnemonic = parsed['operands'], parsed['mnemonic']
    if (mnemonic in ('lss', 'lfs', 'lgs') and len(ops) == 2
            and ops[0]['family'] == 'gpr' and ops[0]['bits'] == 64
            and rex is not None and rex & 8 and len(data) > pos + 2
            and data[pos:pos+2] in (b'\x0f\xb2', b'\x0f\xb4', b'\x0f\xb5')
            and data[pos+2] >> 6 != 3):
        if any('FWORD PTR' in line['text'] for line in result['instructions']):
            findings.append(finding('far_pointer_display', 'disassembly_defect',
                'REX.W far-pointer의 80비트 메모리를 objdump가 FWORD PTR(48비트)로 표시했습니다.', 'supported'))
    if (mnemonic in ('lar', 'lsl') and len(ops) == 2 and ops[0]['family'] == 'gpr'
            and ops[0]['bits'] == 64 and data[pos:pos+2] in (b'\x0f\x02', b'\x0f\x03')
            and not (rex is not None and rex & 8)):
        findings.append(finding('lar_lsl_rex_selection', 'equivalent_representation',
            'r64 입력에서 REX.W가 생략됐습니다. SDM은 32/64비트 동작이 같다고 명시합니다. '
            'REX.W 형식 자체를 시험하려 했다면 해당 형식은 검사되지 않았습니다.', 'supported'))
    return findings


def roundtrip(original, parsed, timeout=10, display_syntax='intel'):
    if display_syntax != 'intel':
        return {'status': 'not_checked', 'reason': '표시 문법 왕복은 현재 Intel 입력 경로만 지원'}
    if not original['inspection_complete']:
        return {'status': 'not_checked', 'reason': '바이트/역어셈블 검사 미완료'}
    if len(original['instructions']) != 1:
        return {'status': 'not_checked', 'reason': '단일 명령어로 해독되지 않음'}
    if original['relocations']:
        return {'status': 'context_required', 'reason': '링크 시 해결할 재배치가 있음'}
    name = parsed['mnemonic']
    if name.startswith('j') or name.startswith('loop') or name in ('call', 'xbegin'):
        return {'status': 'context_required', 'reason': '분기 주소·라벨 문맥을 독립 줄로 복원하지 않음'}
    text = original['instructions'][0]['text']
    # objdump 주석만 제거한다. 명령어 자체는 변환하지 않는다.
    text = text.split('#', 1)[0].strip()
    back = assemble(HEADER + text + '\n', timeout=timeout)
    if back['observation_status'] in ('timeout', 'unavailable', 'resource_failure', 'tool_failed', 'process_crash'):
        status = back['observation_status']
    elif back['status'] == 'accepted' and not back['inspection_complete']:
        status = 'inspection_failure'
    elif back['status'] != 'accepted':
        status = 'reassembly_rejected'
    elif back['relocations']:
        status = 'context_required'
    else:
        status = 'same_bytes' if original['bytes'] == back['bytes'] else 'different_bytes'
    return {'status': status, 'result': back, 'meaning_verified': False}


def check_instruction(code, rows, static_only=False, compare_clang=True, timeout=10,
                      expected_row=None, syntax='intel', display_syntax='intel'):
    """CLI·퍼징·13단계가 공유하는 API. 판정은 관측과 검증 범위를 함께 돌려준다."""
    result = {'source': code, 'status': 'incomplete', 'findings': [], 'semantic_status': 'not_verified',
              'syntax': syntax, 'display_syntax': display_syntax,
              'validation_status': 'not_requested',
              'observation_id': hashlib.sha256(
                  ('\0'.join((code, syntax, display_syntax))).encode('utf-8')
              ).hexdigest()}
    if syntax not in SUPPORTED_SYNTAX or display_syntax not in SUPPORTED_DISPLAY_SYNTAX:
        result['reason'] = '지원하지 않는 source/display syntax입니다.'
        result['validation_status'] = 'unsupported'
        return result
    if any(c in code for c in '\n\r;#"\'\\\x00') or not re.fullmatch(r'[\x20-\x7e\t]+', code):
        result['reason'] = '한 명령어만 지원합니다. 지시자·문자열·여러 문장·제어문자는 검사 범위 밖입니다.'
        return result
    parsed = parse_instruction(code)
    if parsed is None:
        result['reason'] = '파서가 처리하지 못하는 문법입니다.'
        return result
    result['parsed'] = parsed
    result['sdm'] = compare_forms(parsed, rows)
    result['findings'] = static_findings(parsed)
    if static_only:
        result['reason'] = '정적 형태 비교만 수행. 어셈블러 수용과 바이트는 미검사.'
        return result
    result['gnu_as'] = assemble(HEADER + code + '\n', timeout=timeout, display_syntax=display_syntax)
    as_result = result['gnu_as']
    if compare_clang:
        result['clang'] = assemble(HEADER + code + '\n', tool='clang', timeout=timeout,
                                   display_syntax=display_syntax)
        clang = result['clang']
        if (as_result['status'] == clang['status'] == 'accepted'
                and as_result['inspection_complete'] and clang['inspection_complete']):
            if as_result['relocations'] or clang['relocations']:
                result['comparison'] = 'context_required'
            else:
                result['comparison'] = 'same_bytes' if as_result['bytes'] == clang['bytes'] else 'different_bytes'
        elif any(clang.get('observation_status') in ('timeout', 'unavailable', 'resource_failure', 'tool_failed', 'process_crash')
                 for clang in (as_result, clang)):
            result['comparison'] = 'not_checked'
        else:
            result['comparison'] = 'as_%s_clang_%s' % (as_result['status'], clang['status'])
    result['status'] = as_result['status']
    if as_result.get('observation_status') in ('timeout', 'unavailable', 'resource_failure', 'tool_failed', 'process_crash'):
        result['validation_status'] = as_result['observation_status']
        return result
    if as_result['status'] == 'accepted':
        result['findings'].extend(observed_findings(parsed, as_result))
        result['roundtrip'] = roundtrip(as_result, parsed, timeout, display_syntax)
        result['option_comparison'] = assemble(HEADER + code + '\n', options=['--64'], timeout=timeout,
                                               display_syntax=display_syntax)
        if not as_result['inspection_complete'] or len(as_result['instructions']) != 1:
            result['status'] = 'incomplete'
            result['validation_status'] = 'tool_failed'
        elif as_result['relocations']:
            result['status'] = 'needs_review'
        elif (result['findings'] or as_result['assembly']['stderr'].strip()
              or result['sdm']['status'] != 'form_match'
              or result['roundtrip']['status'] != 'same_bytes'
              or (compare_clang and result.get('comparison') != 'same_bytes')):
            result['status'] = 'needs_review'
    if compare_clang and (result['clang'].get('observation_status') in
                          ('timeout', 'unavailable', 'resource_failure', 'tool_failed', 'process_crash')
                          or (result['clang']['status'] == 'accepted' and not result['clang']['inspection_complete'])):
        result['status'] = 'incomplete'
        result['validation_status'] = 'tool_failed'
    if result.get('roundtrip', {}).get('status') in ('tool_error', 'inspection_failure', 'timeout', 'unavailable', 'resource_failure', 'process_crash'):
        result['status'] = 'incomplete'
        result['validation_status'] = 'tool_failed'
    if result.get('option_comparison', {}).get('validation_status') == 'tool_failed':
        result['status'] = 'incomplete'
        result['validation_status'] = 'tool_failed'
    if result.get('validation_status') == 'not_requested':
        result['validation_status'] = 'checked' if result.get('status') in ('accepted', 'needs_review') else result.get('status')
    if expected_row is not None:
        result = evaluate_expected(result, expected_row)
    return result


def evaluate_expected(result, expected_row, encoding_policy='allow_equivalent'):
    """기존 관측을 바꾸지 않고 기대 행과 정책을 적용한다."""
    evaluated = copy.deepcopy(result)
    if evaluated.get('gnu_as', {}).get('status') != 'accepted':
        evaluated['expected_encoding'] = {'status': 'not_applicable', 'meaning_verified': False,
                                          'reason': '조립 성공 관측이 없어 기대 인코딩을 비교하지 않음'}
        evaluated['policy_decision'] = 'review' if evaluated.get('status') in ('process_crash', 'timeout', 'tool_error', 'incomplete') else 'reject'
        evaluated['encoding_policy'] = encoding_policy
        return evaluated
    expected = check_opcode_template(evaluated['gnu_as'].get('bytes', ''), expected_row)
    evaluated['expected_encoding'] = expected
    if expected['status'] == 'fields_match':
        evaluated['encoding_target_match'] = 'fields_match'
        evaluated['policy_decision'] = 'pass'
    elif expected['status'] == 'different_encoding':
        evaluated['encoding_target_match'] = 'different_encoding'
        evaluated['findings'].append(finding('target_encoding_not_exercised', 'encoding_selection',
                                              '지정한 SDM 행과 다른 인코딩을 관측했습니다. 의미 동등성은 별도 근거가 필요합니다.'))
        evaluated['policy_decision'] = 'review' if encoding_policy == 'allow_equivalent' else 'review'
        if evaluated.get('status') == 'accepted':
            evaluated['status'] = 'needs_review'
    else:
        evaluated['encoding_target_match'] = 'unknown'
        evaluated['policy_decision'] = 'review'
        if evaluated.get('status') == 'accepted':
            evaluated['status'] = 'needs_review'
    evaluated['encoding_policy'] = encoding_policy
    return evaluated

"""SDM의 추상 오퍼랜드와 실제 입력을 비교한다. 부분 일치는 의미 검증이 아니다."""
import csv
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DB_PATH = ROOT / 'data/db/isa_db.csv'
PTR_BITS = {'byte': 8, 'word': 16, 'dword': 32, 'fword': 48, 'qword': 64,
            'tbyte': 80, 'oword': 128, 'xmmword': 128, 'ymmword': 256, 'zmmword': 512}
GPR = {}
for bits, names in ((8, 'al bl cl dl ah bh ch dh spl bpl sil dil'),
                    (16, 'ax bx cx dx si di bp sp'),
                    (32, 'eax ebx ecx edx esi edi ebp esp'),
                    (64, 'rax rbx rcx rdx rsi rdi rbp rsp')):
    GPR.update(dict.fromkeys(names.split(), bits))
for number in range(8, 16):
    for suffix, bits in (('b', 8), ('w', 16), ('d', 32), ('', 64)):
        GPR['r%d%s' % (number, suffix)] = bits
SREG = {'cs', 'ds', 'es', 'fs', 'gs', 'ss'}
PREFIXES = {'lock', 'rep', 'repe', 'repz', 'repne', 'repnz', 'bnd',
            'data16', 'addr32', 'rex64', 'xacquire', 'xrelease', 'notrack'}


def load_db(path=DB_PATH):
    with open(path, encoding='utf-8-sig', newline='') as stream:
        rows = list(csv.DictReader(stream))
    required = {'mnemonic', 'operands', 'opcode', 'mode_support', 'source_page'}
    if not rows or not required.issubset(rows[0]):
        raise ValueError('ISA DB가 비어 있거나 필수 열이 없습니다.')
    # 원본 CSV에는 row_id가 없다. m2와 같은 0-based 데이터 행 번호.
    for index, row in enumerate(rows):
        row['row_id'] = str(index)
    return rows


def operand(text):
    low = text.strip().lower()
    decorations = re.findall(r'\{[^}]*\}', low)
    bare = re.sub(r'\{[^}]*\}', '', low).strip()
    result = {'text': text.strip(), 'kind': 'unknown', 'bits': None,
              'family': None, 'decorations': decorations}
    size = re.match(r'^(\w+)\s+ptr\b', bare)
    if '[' in bare or size:
        result.update(kind='mem', bits=PTR_BITS.get(size.group(1)) if size else None)
        result['address_registers'] = [r for r in re.findall(r'\b[a-z]+\d*\b', bare)
                                       if r in GPR or re.fullmatch(r'[xyz]mm\d+', r)]
    elif bare in GPR:
        result.update(kind='reg', bits=GPR[bare], family='gpr')
    elif bare in SREG:
        result.update(kind='reg', bits=16, family='sreg')
    else:
        match = re.fullmatch(r'(xmm|ymm|zmm|mm|k|bnd|tmm|cr|dr)(\d+)', bare)
        if match:
            family, index = match.group(1), int(match.group(2))
            limits = {'xmm': 32, 'ymm': 32, 'zmm': 32, 'mm': 8, 'k': 8,
                      'bnd': 4, 'tmm': 8, 'cr': 16, 'dr': 16}
            if index < limits[family]:
                result.update(kind='reg', family=family,
                              bits={'xmm': 128, 'ymm': 256, 'zmm': 512, 'mm': 64}.get(family))
        elif re.fullmatch(r'st(?:\([0-7]\)|[0-7])?', bare):
            result.update(kind='reg', bits=80, family='st')
        elif re.fullmatch(r'[+-]?(?:0x[0-9a-f]+|\d+)', bare):
            result.update(kind='imm', value=int(bare, 16 if '0x' in bare else 10))
        elif re.fullmatch(r'[a-z_.$][\w.$]*', bare):
            result.update(kind='symbol')
    return result


def parse_instruction(code):
    parts = code.strip().split(None, 1)
    prefixes = []
    while parts and parts[0].lower() in PREFIXES:
        prefixes.append(parts[0].lower())
        parts = parts[1].split(None, 1) if len(parts) > 1 else []
    if not parts or not re.fullmatch(r'[A-Za-z][A-Za-z0-9_]*', parts[0]):
        return None
    tail = parts[1] if len(parts) > 1 else ''
    # 괄호 안의 쉼표를 허용하는 전체 GAS 파서는 아니다. 모르면 범위 밖으로 남긴다.
    if any(tail.count(a) != tail.count(b) for a, b in [('(', ')'), ('[', ']'), ('{', '}')]):
        return None
    return {'mnemonic': parts[0].lower(), 'prefixes': prefixes,
            'operands': [operand(p) for p in tail.split(',')] if tail.strip() else []}


def match_token(token, op):
    """True=형태 일치, False=형태 불일치, None=이 검사기의 범위 밖."""
    token = token.strip().lower()
    if '{' in token or op['decorations']:
        return None  # 마스크/브로드캐스트/반올림 제약을 확인했다고 주장하지 않는다.
    if token in GPR or token in SREG:
        return op['text'].lower() == token
    if token == 'sreg':
        return op['family'] == 'sreg'
    match = re.fullmatch(r'r(8|16|32|64)', token)
    if match:
        return op['family'] == 'gpr' and op['bits'] == int(match.group(1))
    match = re.fullmatch(r'r/m(8|16|32|64)', token)
    if match:
        if op['kind'] == 'mem' and op['bits'] is None:
            return None
        return (op['kind'] == 'mem' or op['family'] == 'gpr') and op['bits'] == int(match.group(1))
    match = re.fullmatch(r'(xmm|ymm|zmm|mm|k|bnd|tmm)\d*', token)
    if match:
        return op['family'] == match.group(1)
    match = re.fullmatch(r'(xmm|ymm|zmm|mm)\d*/m(\d+)', token)
    if match:
        if op['family'] == match.group(1):
            return True
        if op['kind'] == 'mem' and op['bits'] is None:
            return None
        return op['kind'] == 'mem' and op['bits'] == int(match.group(2))
    match = re.fullmatch(r'r(\d+)/m(\d+)', token)
    if match:
        if op['family'] == 'gpr':
            return op['bits'] == int(match.group(1))
        if op['kind'] == 'mem' and op['bits'] is None:
            return None
        return op['kind'] == 'mem' and op['bits'] == int(match.group(2))
    match = re.fullmatch(r'm(\d+)(?::(\d+))?', token)
    if match:
        if op['kind'] != 'mem':
            return False
        if op['bits'] is None:
            return None
        return op['bits'] == sum(int(x) for x in match.groups() if x)
    if token == 'm':
        return op['kind'] == 'mem'
    match = re.fullmatch(r'imm(8|16|32|64)', token)
    if match:
        if op['kind'] != 'imm':
            return None if op['kind'] == 'symbol' else False
        bits = int(match.group(1))
        return -(1 << (bits - 1)) <= op['value'] < (1 << bits)
    if re.fullmatch(r'rel(?:8|16|32)', token):
        return None  # 링크 시 결정되는 거리는 문자열만으로 판정하지 않는다.
    if token in ('1', '3'):
        return op.get('value') == int(token)
    return None


def compare_forms(parsed, rows):
    mnemonic = parsed['mnemonic'].upper()
    # 접두어와 명시적/암묵적 오퍼랜드 문법은 별도다. 후보 표시는 제공하되 확정하지 않는다.
    candidates = [r for r in rows if r['mnemonic'].upper() == mnemonic]
    compatible, partial = [], []
    for row in candidates:
        tokens = [t.strip() for t in row['operands'].split(',') if t.strip()]
        if len(tokens) != len(parsed['operands']):
            continue
        values = [match_token(token, op) for token, op in zip(tokens, parsed['operands'])]
        if False in values:
            continue
        info = {k: row[k] for k in ('row_id', 'instruction', 'opcode', 'mode_support', 'source_page')}
        (partial if None in values else compatible).append(info)
    status = 'form_match' if compatible else 'incomplete' if partial else 'no_form_match' if candidates else 'mnemonic_not_found'
    if parsed['prefixes'] and status == 'form_match':
        status = 'incomplete'
    return {'status': status, 'matches': compatible, 'partial_matches': partial,
            'meaning_verified': False,
            'note': 'DB 표의 오퍼랜드 형태만 비교. 모드·접두어·별칭·즉시값 확장·CPU 조건은 별도 확인.'}


def legacy_fields(hex_bytes):
    data = bytes.fromhex(hex_bytes)
    pos, rex, prefixes = 0, None, []
    while pos < len(data):
        byte = data[pos]
        if byte in (0x66, 0x67, 0xf0, 0xf2, 0xf3, 0x26, 0x2e, 0x36, 0x3e, 0x64, 0x65):
            prefixes.append(byte)
            rex = None
        elif 0x40 <= byte <= 0x4f:
            rex = byte
        else:
            break
        pos += 1
    return data, pos, rex, prefixes


def check_opcode_template(hex_bytes, row):
    """제한된 legacy opcode 필드만 대조. 전체 명령어 행/실행 의미 일치 판정은 아님."""
    template = row['opcode'].strip()
    result = {'row_id': row['row_id'], 'expected': template, 'status': 'not_checked',
              'checked_fields': [], 'meaning_verified': False}
    if not hex_bytes:
        result['reason'] = '기계어 없음'
        return result
    # VEX/EVEX, +r, 특수 표기는 아직 해독하지 않는다.
    tokens = re.sub(r'(?<=[0-9A-F])/', ' /', template.replace('REX.W +', 'REX.W')).split()
    allowed = re.compile(r'(?:[0-9A-F]{2}|REX.W|/r|/[0-7]|ib|iw|id|io|cb|cw|cd|cp|NP)')
    if not tokens or any(not allowed.fullmatch(t) for t in tokens):
        result['reason'] = '지원하지 않는 opcode 템플릿'
        return result
    data, pos, rex, prefixes = legacy_fields(hex_bytes)
    expected = [int(t, 16) for t in tokens if re.fullmatch(r'[0-9A-F]{2}', t)]
    # 명시적 mandatory prefix는 opcode 비교 전에 분리한다.
    good = True
    while expected and expected[0] in (0x66, 0xf2, 0xf3):
        good = expected.pop(0) in prefixes and good
        result['checked_fields'].append('mandatory_prefix')
    if not expected:
        result['reason'] = 'opcode 바이트 없음'
        return result
    good = data[pos:pos + len(expected)] == bytes(expected) and good
    result['checked_fields'].append('opcode_bytes')
    if 'REX.W' in tokens:
        good = rex is not None and bool(rex & 8) and good
        result['checked_fields'].append('REX.W')
    extension = next((t for t in tokens if re.fullmatch(r'/[0-7]', t)), None)
    if extension:
        modpos = pos + len(expected)
        good = modpos < len(data) and (data[modpos] >> 3) & 7 == int(extension[1]) and good
        result['checked_fields'].append('ModRM.reg')
    result['status'] = 'fields_match' if good else 'different_encoding'
    result['reason'] = '미확인: 오퍼랜드 제약, 모드, /r 필드, 즉시값·주소·CPUID·동작'
    return result

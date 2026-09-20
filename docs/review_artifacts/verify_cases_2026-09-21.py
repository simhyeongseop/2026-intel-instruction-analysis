"""예외 사례를 로컬 도구(as 2.42~2.47, clang 18)와 Godbolt(2.42/2.45/trunk, clang trunk)에서
같은 입력으로 돌려 관측을 모은다. 판정하지 않고 관측만 기록한다."""
import json, subprocess, sys, os, tempfile

SP = os.path.dirname(os.path.abspath(__file__))
BU = os.path.join(SP, 'binutils')
LOCAL = [
    ('as 2.42(시스템)', '/usr/bin/as', '/usr/bin/objdump'),
    ('as 2.45', f'{BU}/build-2.45/gas/as-new', f'{BU}/build-2.45/binutils/objdump'),
    ('as 2.46.1', f'{BU}/build-2.46.1/gas/as-new', f'{BU}/build-2.46.1/binutils/objdump'),
    ('as 2.47', f'{BU}/build-2.47/gas/as-new', f'{BU}/build-2.47/binutils/objdump'),
]
GODBOLT = [('GB gas 2.42', 'gnuas142'), ('GB gas 2.45', 'gnuas151'),
           ('GB gas trunk', 'gnuassnapshot'), ('GB clang trunk', 'llvmas_trunk')]

CASES = [
    ('1B-vpmovqd', 'vpmovqd xmmword ptr [eax], xmm0'),
    ('1B-sysexit', 'sysexit'),
    ('1B-movds',   'mov ds, qword ptr [eax]'),
    ('1B-lar',     'lar ecx, rcx'),
    ('1B-vscatter','vscatterdpd [eax + ymm1] {k1}, ymm0'),
    ('1B-udb',     'udb'),
    ('4-adc',      'adc ecx, ecx'),
    ('4-ja',       'ja .Ltarget'),
    ('4-lar-mem',  'lar ecx, word ptr [eax]'),
    ('5-lss-sib',  'lss rcx, tbyte ptr [rax+rbx*4+0x10]'),
    ('5-bndcl',    'bndcl bnd0, dword ptr [rax]'),
    ('6-lss',      'lss rcx, tbyte ptr [rax]'),
    ('6-lfs',      'lfs rcx, tbyte ptr [rax]'),
    ('6-lgs',      'lgs rcx, tbyte ptr [rax]'),
    ('6-reasm',    'lss rcx,FWORD PTR [rax]'),
]
HEADER = '.intel_syntax noprefix\n.text\n.Ltarget:\n'


def local(asm, objdump, code):
    with tempfile.TemporaryDirectory() as d:
        s, o = os.path.join(d, 'a.s'), os.path.join(d, 'a.o')
        open(s, 'w').write(HEADER + code + '\n')
        run = subprocess.run([asm, '--64', '-mintel64', '-o', o, s],
                             capture_output=True, text=True)
        if run.returncode != 0:
            msg = [l for l in run.stderr.splitlines() if 'Error' in l]
            return {'ok': False, 'err': (msg[0].split(': ', 1)[-1] if msg else run.stderr.strip())[:70]}
        dis = subprocess.run([objdump, '-d', '-M', 'intel', o], capture_output=True, text=True).stdout
        lines = [l for l in dis.splitlines() if '\t' in l and ':\t' in l]
        if not lines:
            return {'ok': True, 'bytes': '', 'text': ''}
        parts = lines[0].split('\t')
        return {'ok': True, 'bytes': parts[1].strip(),
                'text': (parts[2].strip() if len(parts) > 2 else '')}


def godbolt(compiler, code):
    body = json.dumps({'source': HEADER + code + '\n',
                       'options': {'userArguments': '-mintel64',
                                   'filters': {'intel': True, 'directives': True, 'labels': True}},
                       'lang': 'assembly', 'allowStoreCodeDebug': False})
    out = subprocess.run(['curl', '-s', '-m', '90',
                          f'https://godbolt.org/api/compiler/{compiler}/compile',
                          '-H', 'Content-Type: application/json',
                          '-H', 'Accept: application/json', '-d', body],
                         capture_output=True, text=True).stdout
    try:
        d = json.loads(out)
    except Exception:
        return {'ok': None, 'err': 'API 응답 파싱 실패'}
    if d.get('code') != 0:
        errs = [l.get('text', '') for l in d.get('stderr', []) if 'rror' in l.get('text', '')]
        return {'ok': False, 'err': (errs[0].split(': ', 1)[-1] if errs else '거부')[:70]}
    text = [l.get('text', '').strip() for l in d.get('asm', [])
            if l.get('text', '').strip() and not l.get('text', '').strip().endswith(':')]
    return {'ok': True, 'text': text[0] if text else ''}


if __name__ == '__main__':
    result = {}
    for name, code in CASES:
        row = {'source': code, 'local': {}, 'godbolt': {}}
        for label, asm, od in LOCAL:
            row['local'][label] = local(asm, od, code) if os.path.exists(asm) else {'ok': None}
        for label, cid in GODBOLT:
            row['godbolt'][label] = godbolt(cid, code)
        result[name] = row
        print(name, 'done', file=sys.stderr, flush=True)
    json.dump(result, open(os.path.join(SP, 'verify_cases.json'), 'w'),
              ensure_ascii=False, indent=1)
    print('저장: verify_cases.json', file=sys.stderr)

"""왕복 결과를 재검토 판단으로 다시 묶는다. 단위: 케이스 x 경로(왕복 한 번)."""
import csv, collections, json, os, sys
R = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', '..', 'out', 'round2_20261111', 'roundtrip_chain') + os.sep
diff = collections.defaultdict(dict)
for r in csv.DictReader(open(R + 'diff_cases.csv', encoding='utf-8')):
    diff[(r['case_id'], r['family'], r['path'])][r['comparison']] = r
lt = {(r['case_id'], r['family'], r['path']): r for r in csv.DictReader(open(R + 'ltarget_check.csv', encoding='utf-8'))}

def category(key, cmp):
    a = cmp.get('as0–as2'); b = cmp.get('b0–b1'); c = cmp.get('as1–as2')
    ins = (a or b or c)['instruction']
    if b and b['status'] == '미대조':
        if key in lt:
            return '설계: 라벨 분기(다시 해 보니 일치)' if lt[key]['b0_b1'] == '같음' and lt[key]['as1_as2'] == '같음' else '설계: 라벨 분기(다시 해도 다름)'
        return 'GNU: objdump FWORD 출력'
    for x in (b, c):
        if x and x['status'] == '다름':
            if ins.startswith('VPCMP'): return '문제 아님: 같은 명령(VPCMP)'
            if ins.startswith('MOV Sreg'): return '문제 아님: 같은 동작(MOV Sreg)'
            if ins.startswith(('CALL', 'JMP')): return 'LLVM: 먼 CALL/JMP'
            if ins.startswith(('PUSHF', 'POPF')): return 'LLVM: 크기 사라짐/바뀜'
            return '?? ' + ins
    if a and a['status'] == '다름':
        m = a['meaning']
        if m.startswith('같은 바이트'): return '적는 법만 다름(바이트 같음)'
        if m.startswith('AT&T 소스 거부'):
            if key[1] == 'gnu': return '설계: AT&T 변환 {rn-sae} 자리'
            if ins.startswith(('CALL', 'JMP')): return 'LLVM: 먼 CALL/JMP'
            return '?? ' + ins
        if m.startswith('AT&T 소스는 다른'):
            if ins == 'IRET': return '매뉴얼이 둘 다 허용(IRET)'
            if ins.startswith(('CALL', 'JMP')): return 'LLVM: 먼 CALL/JMP'
            return 'LLVM: 크기 사라짐/바뀜'
        return '?? ' + m
    return '?? ' + ins

table = collections.Counter()
for key, cmp in diff.items():
    table[(key[1], key[2], category(key, cmp))] += 1
chain = list(csv.DictReader(open(R + 'chain_table.csv', encoding='utf-8')))
paths = [('gnu', 'att'), ('gnu', 'intel'), ('llvm', 'att'), ('llvm', 'intel')]
total = {}
for r in chain:
    if r['comparison'] == 'as0–as2':
        total[(r['family'], r['path'])] = int(r['같음']) + int(r['다름']) + int(r['미대조'])
cats = sorted({k[2] for k in table})
out = {}
for p in paths:
    row = {c: table[(p[0], p[1], c)] for c in cats}
    row['완전 일치'] = total[p] - sum(row.values())
    out['%s %s' % p] = row
json.dump(out, sys.stdout, ensure_ascii=False, indent=1)

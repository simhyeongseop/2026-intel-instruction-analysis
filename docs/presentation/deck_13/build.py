"""13회 발표 PPT 생성. 수치는 chain_table.csv와 review_table.json(재검토 분류)에서 읽는다."""
import csv, json, os
from pptx import Presentation
from pptx.util import Inches, Pt, Emu
from pptx.dml.color import RGBColor
from pptx.enum.shapes import MSO_SHAPE, MSO_CONNECTOR
from pptx.enum.text import PP_ALIGN, MSO_ANCHOR
from pptx.oxml.ns import qn
from PIL import Image

HERE = os.path.dirname(os.path.abspath(__file__))
R = os.path.join(HERE, '..', '..', '..', 'out', 'round2_20261111', 'roundtrip_chain') + os.sep
OUT = os.path.join(HERE, '..', '13회_왕복비교.pptx')

INK, MUTED, LINE = '1F2933', '6B7280', 'D5D9E0'
DARK, PAPER = '18212B', 'FFFFFF'
RED, BLUE, AMBER, SOFT = 'C62828', '1565C0', 'B7791F', 'F3F5F8'
REDBG, BLUEBG, AMBERBG = 'FDECEC', 'E8F0FB', 'FBF3E4'
KO, CODE = 'Malgun Gothic', 'Consolas'


def rgb(h):
    return RGBColor.from_string(h)


def style_run(run, size, color=INK, bold=False, code=False):
    f = run.font
    f.size = Pt(size)
    f.bold = bold
    f.color.rgb = rgb(color)
    f.name = CODE if code else KO
    rpr = run._r.get_or_add_rPr()
    for tag in ('a:ea', 'a:cs'):
        el = rpr.find(qn(tag))
        if el is None:
            el = rpr.makeelement(qn(tag), {})
            rpr.append(el)
        el.set('typeface', KO)


def text(slide, x, y, w, h, paras, size=18, color=INK, bold=False, align=PP_ALIGN.LEFT,
         anchor=MSO_ANCHOR.TOP, code=False, spacing=6):
    """paras: 문자열, 또는 줄 목록. 줄은 문자열이거나 (글, 옵션) 조각 목록."""
    box = slide.shapes.add_textbox(Inches(x), Inches(y), Inches(w), Inches(h))
    tf = box.text_frame
    tf.word_wrap = True
    tf.vertical_anchor = anchor
    for m in ('margin_left', 'margin_right', 'margin_top', 'margin_bottom'):
        setattr(tf, m, 0)
    if isinstance(paras, str):
        paras = [paras]
    for i, line in enumerate(paras):
        p = tf.paragraphs[0] if i == 0 else tf.add_paragraph()
        p.alignment = align
        p.space_after = Pt(spacing)
        pieces = [(line, {})] if isinstance(line, str) else line
        for t, o in pieces:
            r = p.add_run()
            r.text = t
            style_run(r, o.get('size', size), o.get('color', color), o.get('bold', bold), o.get('code', code))
    return box


def box(slide, x, y, w, h, fill, label=None, size=16, color=INK, bold=False, shape=MSO_SHAPE.ROUNDED_RECTANGLE,
        line=None, code=False, align=PP_ALIGN.CENTER):
    s = slide.shapes.add_shape(shape, Inches(x), Inches(y), Inches(w), Inches(h))
    if shape == MSO_SHAPE.ROUNDED_RECTANGLE:
        s.adjustments[0] = 0.12
    s.fill.solid()
    s.fill.fore_color.rgb = rgb(fill)
    if line:
        s.line.color.rgb = rgb(line)
        s.line.width = Pt(1.25)
    else:
        s.line.fill.background()
    s.shadow.inherit = False
    if label is not None:
        tf = s.text_frame
        tf.word_wrap = True
        tf.vertical_anchor = MSO_ANCHOR.MIDDLE
        for m in ('margin_left', 'margin_right'):
            setattr(tf, m, Inches(0.08))
        lines = label if isinstance(label, list) else [label]
        for i, line_ in enumerate(lines):
            p = tf.paragraphs[0] if i == 0 else tf.add_paragraph()
            p.alignment = align
            pieces = [(line_, {})] if isinstance(line_, str) else line_
            for t, o in pieces:
                r = p.add_run()
                r.text = t
                style_run(r, o.get('size', size), o.get('color', color), o.get('bold', bold), o.get('code', code))
    return s


def hline(slide, x1, y1, x2, y2, color=MUTED, width=2.0):
    c = slide.shapes.add_connector(MSO_CONNECTOR.STRAIGHT, Inches(x1), Inches(y1), Inches(x2), Inches(y2))
    c.line.color.rgb = rgb(color)
    c.line.width = Pt(width)
    return c


def arrow(slide, x, y, w, h=0.32, color=MUTED):
    s = slide.shapes.add_shape(MSO_SHAPE.RIGHT_ARROW, Inches(x), Inches(y), Inches(w), Inches(h))
    s.fill.solid()
    s.fill.fore_color.rgb = rgb(color)
    s.line.fill.background()
    s.shadow.inherit = False
    return s


def picture(slide, path, x, y, max_w, max_h):
    pw, ph = Image.open(path).size
    scale = min(max_w / pw, max_h / ph)
    w, h = pw * scale, ph * scale
    slide.shapes.add_picture(path, Inches(x), Inches(y), Inches(w), Inches(h))
    return w, h


prs = Presentation()
prs.slide_width, prs.slide_height = Inches(13.333), Inches(7.5)
BLANK = prs.slide_layouts[6]
page = [0]


def new_slide(title=None, dark=False, notes=''):
    s = prs.slides.add_slide(BLANK)
    bg = s.background.fill
    bg.solid()
    bg.fore_color.rgb = rgb(DARK if dark else PAPER)
    page[0] += 1
    if title:
        text(s, 0.6, 0.45, 12.1, 0.8, title, size=34, bold=True, color=PAPER if dark else INK)
    if page[0] > 1:
        text(s, 12.2, 7.0, 0.8, 0.3, str(page[0]), size=11, color=MUTED, align=PP_ALIGN.RIGHT)
    if notes:
        s.notes_slide.notes_text_frame.text = notes
    return s


def tag(s, label, kind):
    fill, color = {'red': (REDBG, RED), 'blue': (BLUEBG, BLUE), 'amber': (AMBERBG, AMBER)}[kind]
    box(s, 0.6, 1.3, 7.2, 0.5, fill, label, size=16, color=color, bold=True, align=PP_ALIGN.LEFT)


def manual(s, lines, y=6.35):
    text(s, 0.6, y, 12.1, 0.6, [[('매뉴얼  ', {'bold': True, 'color': MUTED}), (lines, {'color': MUTED})]], size=13)


def why(s, lines, x=8.55, y=2.05, w=4.2):
    text(s, x, y, w, 0.4, '왜', size=16, bold=True, color=MUTED)
    text(s, x, y + 0.45, w, 3.8, lines, size=18, spacing=14)


# ---------------- 데이터 ----------------
chain = {}
for r in csv.DictReader(open(R + 'chain_table.csv', encoding='utf-8')):
    chain[(r['family'], r['path'], r['comparison'])] = r
review = json.load(open(os.path.join(HERE, 'review_table.json'), encoding='utf-8'))
PATHS = [('gnu', 'att', 'GNU · AT&T'), ('gnu', 'intel', 'GNU · Intel'), ('llvm', 'att', 'LLVM · AT&T'), ('llvm', 'intel', 'LLVM · Intel')]
n = lambda v: f'{int(v):,}'

# 1 제목
s = new_slide(dark=True, notes='지난 미팅에서 말씀하신 대로 비교를 세 가지로 나눠 전체에 다시 돌렸습니다. 결과가 어떻게 나왔고 왜 그렇게 나왔는지 보고드리겠습니다.')
text(s, 0.9, 2.3, 11.5, 1.0, 'Intel · AT&T 왕복 비교 결과', size=44, bold=True, color=PAPER)
text(s, 0.9, 3.35, 11.5, 0.6, 'as0 → b0 → as1 → b1 → as2', size=26, color='AFC3D6', code=True)
text(s, 0.9, 5.6, 11.5, 0.9, ['(이름) · 2026-11', 'GNU Binutils 2.47 · LLVM 23.1.3 · Intel SDM 325383-093'], size=16, color='9AA5B1')

# 2 설계 ① 비교 세 가지
s = new_slide('실험 설계 ① 세 가지를 비교했다', notes=
    '소스를 조립해 바이트를 만들고, 풀고, 다시 조립하고, 다시 풉니다. 여기서 세 쌍을 비교했습니다. '
    'as0–as2는 처음 소스와 마지막 글자, b0–b1은 바이트, as1–as2는 두 번 푼 글자입니다.')
names = [('as0', '소스'), ('b0', '바이트'), ('as1', '글자'), ('b1', '바이트'), ('as2', '글자')]
steps = ['조립', '풀기', '다시 조립', '다시 풀기']
bw, gap, x0, y0 = 1.75, 0.85, 0.75, 2.35
cx = []
for i, (k, v) in enumerate(names):
    x = x0 + i * (bw + gap)
    fill = 'E6ECF2' if v == '바이트' else 'FFFFFF'
    box(s, x, y0, bw, 1.1, fill, [[(k, {'size': 24, 'bold': True, 'code': True})], [(v, {'size': 14, 'color': MUTED})]], line='9AA5B1')
    cx.append(x + bw / 2)
    if i < 4:
        arrow(s, x + bw + 0.1, y0 + 0.4, gap - 0.2)
        text(s, x + bw - 0.15, y0 + 1.15, gap + 0.3, 0.35, steps[i], size=13, color=MUTED, align=PP_ALIGN.CENTER)
# as0–as2: 위쪽, b0–b1·as1–as2: 아래쪽 두 층. 이름표는 선 바깥쪽에 둬 다른 선과 겹치지 않게 한다.
top = 1.75
hline(s, cx[0], y0, cx[0], top, BLUE, 2.5); hline(s, cx[4], y0, cx[4], top, BLUE, 2.5); hline(s, cx[0], top, cx[4], top, BLUE, 2.5)
text(s, cx[0] + 0.15, top - 0.42, 7, 0.4, [[('as0–as2   ', {'bold': True, 'code': True, 'color': BLUE}), ('처음 소스 = 마지막 글자?', {})]], size=16)
for (a, b, k, label, col, yl) in [(1, 3, 'b0–b1', '바이트 그대로?', RED, 4.35), (2, 4, 'as1–as2', '같은 명령?', AMBER, 5.35)]:
    hline(s, cx[a], y0 + 1.1, cx[a], yl, col, 2.5); hline(s, cx[b], y0 + 1.1, cx[b], yl, col, 2.5); hline(s, cx[a], yl, cx[b], yl, col, 2.5)
    text(s, cx[a] + 0.15, yl + 0.1, 2.2, 0.8, [[(k, {'bold': True, 'code': True, 'color': col})], label], size=16, spacing=2)

# 3 설계 ② 네 길
s = new_slide('실험 설계 ② 네 길로 돌렸다', notes=
    '도구는 GNU와 LLVM 두 묶음이고, 푸는 문법은 AT&T와 Intel 두 가지라 길이 네 개입니다. 같은 묶음 도구끼리만 왕복합니다. '
    '소스는 매뉴얼 표에서 만든 106,601개이고, 도구가 받은 것 210,215건을 왕복했습니다.')
gx, gy, cw, ch = 2.6, 1.95, 3.0, 1.45
text(s, gx, gy - 0.5, cw, 0.4, 'AT&T로 풀기', size=16, bold=True, align=PP_ALIGN.CENTER)
text(s, gx + cw + 0.2, gy - 0.5, cw, 0.4, 'Intel로 풀기', size=16, bold=True, align=PP_ALIGN.CENTER)
for i, (fam, tools) in enumerate([('GNU', 'as · objdump'), ('LLVM', 'clang · llvm-mc')]):
    y = gy + i * (ch + 0.2)
    text(s, 0.6, y + 0.25, 1.9, 1.0, [[(fam, {'bold': True, 'size': 22})], [(tools, {'size': 13, 'color': MUTED, 'code': True})]], size=16)
    for j, syn in enumerate(['AT&T', 'Intel']):
        box(s, gx + j * (cw + 0.2), y, cw, ch, 'E6ECF2' if i == 0 else 'EEF2E6', f'{fam} · {syn}', size=20, bold=True)
text(s, 9.3, 2.0, 3.6, 0.9, '106,601', size=44, bold=True, color=INK)
text(s, 9.3, 2.85, 3.6, 0.5, '매뉴얼 표에서 만든 소스', size=15, color=MUTED)
text(s, 9.3, 3.75, 3.6, 0.9, '210,215', size=44, bold=True, color=INK)
text(s, 9.3, 4.6, 3.6, 0.5, '도구가 받은 것 → 두 길씩 왕복', size=15, color=MUTED)
text(s, 0.6, 5.6, 12, 0.5, '같은 묶음의 도구끼리만 왕복한다 (GNU 바이트는 GNU로, LLVM 바이트는 LLVM으로)', size=15, color=MUTED)

# 4 처음 결과
s = new_slide('처음 결과: 글자는 많이 다르고, 바이트는 거의 같다', notes=
    '세 비교의 일치·불일치·미대조 수입니다. 글자 비교는 불일치가 많고 바이트 비교는 불일치가 아주 적습니다. '
    '미대조는 비교를 하지 못한 것입니다. 이 숫자가 왜 나왔는지 하나씩 보겠습니다.')
cols = ['길', 'as0–as2\n일치', 'as0–as2\n불일치', 'b0–b1\n일치', 'b0–b1\n불일치', 'as1–as2\n일치', 'as1–as2\n불일치', '미대조']
rows = []
for fam, path, label in PATHS:
    a, b, c = (chain[(fam, path, k)] for k in ('as0–as2', 'b0–b1', 'as1–as2'))
    rows.append([label, n(a['같음']), n(a['다름']), n(b['같음']), n(b['다름']), n(c['같음']), n(c['다름']), n(a['미대조'])])


def table(s, x, y, w, colw, header, body, size=15, hsize=13, red=(), blue=(), amber=(), rowh=0.5, head_fill=SOFT):
    t = s.shapes.add_table(len(body) + 1, len(header), Inches(x), Inches(y), Inches(w), Inches(rowh * (len(body) + 1))).table
    for j, cw_ in enumerate(colw):
        t.columns[j].width = Inches(cw_)
    for i in range(len(body) + 1):
        t.rows[i].height = Inches(rowh if i else rowh * 1.4)
        for j in range(len(header)):
            cell = t.cell(i, j)
            cell.fill.solid()
            cell.fill.fore_color.rgb = rgb(head_fill if i == 0 else PAPER)
            cell.margin_left = cell.margin_right = Inches(0.06)
            cell.vertical_anchor = MSO_ANCHOR.MIDDLE
            val = header[j] if i == 0 else body[i - 1][j]
            tf = cell.text_frame
            tf.word_wrap = True
            for k, part in enumerate(str(val).split('\n')):
                p = tf.paragraphs[0] if k == 0 else tf.add_paragraph()
                p.alignment = PP_ALIGN.LEFT if j == 0 else (PP_ALIGN.CENTER if i == 0 else PP_ALIGN.RIGHT)
                r = p.add_run()
                r.text = part
                col = INK
                if i and (i - 1, j) in red: col = RED
                if i and (i - 1, j) in blue: col = BLUE
                if i and (i - 1, j) in amber: col = AMBER
                style_run(r, hsize if i == 0 else size, col if i else INK, bold=(i == 0 or (i and ((i - 1, j) in red or (i - 1, j) in blue or (i - 1, j) in amber))))
    tbl = t._tbl
    tblpr = tbl.tblPr
    tblpr.set('bandRow', '0')
    tblpr.set('firstRow', '0')
    return t


table(s, 0.6, 1.55, 12.1, [1.9, 1.45, 1.45, 1.45, 1.45, 1.45, 1.45, 1.5], cols, rows,
      red={(3, 4), (3, 6), (2, 4), (2, 6)}, rowh=0.62)
box(s, 0.6, 5.35, 3.85, 0.95, SOFT, [[('글자 불일치  ', {'color': MUTED, 'size': 14}), ('186,677', {'bold': True, 'size': 24})]], align=PP_ALIGN.LEFT)
box(s, 4.73, 5.35, 3.85, 0.95, SOFT, [[('바이트 불일치  ', {'color': MUTED, 'size': 14}), ('294', {'bold': True, 'size': 24, 'color': RED})]], align=PP_ALIGN.LEFT)
box(s, 8.86, 5.35, 3.85, 0.95, SOFT, [[('미대조  ', {'color': MUTED, 'size': 14}), ('503', {'bold': True, 'size': 24})]], align=PP_ALIGN.LEFT)

# 5 왜: 지도
s = new_slide('왜 이렇게 나왔나 — 세 갈래로 나눠 봤다', notes=
    '미대조, 글자만 다른 것, 바이트나 뜻까지 다른 것으로 나눠 보겠습니다. 글자 불일치 186,677건 가운데 186,137건은 바이트가 같고, '
    '나머지 540건이 실제로 볼 것입니다.')
tiles = [('미대조', '503', '비교를 못 한 것', ['라벨 분기 → 6장', 'objdump FWORD → 7장'], 'E6ECF2', INK),
         ('글자만 다름', '186,137', '바이트는 같다', ['적는 법 차이 → 8장'], BLUEBG, BLUE),
         ('바이트·뜻까지 다름', '540', '실제로 볼 것', ['VPCMP → 9장', '먼 CALL/JMP → 10장', '크기 → 11·12장', '{rn-sae} → 13장', 'iret → 14장'], REDBG, RED)]
for i, (h, num, sub, items, fill, col) in enumerate(tiles):
    x = 0.6 + i * 4.13
    box(s, x, 1.6, 3.85, 4.6, fill)
    text(s, x + 0.3, 1.85, 3.3, 0.45, h, size=20, bold=True, color=col)
    text(s, x + 0.3, 2.35, 3.3, 0.9, num, size=44, bold=True, color=col)
    text(s, x + 0.3, 3.25, 3.3, 0.4, sub, size=14, color=MUTED)
    text(s, x + 0.3, 3.85, 3.3, 2.3, items, size=15, spacing=6)


def capture_slide(title, tag_label, kind, img, why_lines, manual_line, notes, img_max_h=4.3):
    s = new_slide(title, notes=notes)
    tag(s, tag_label, kind)
    path = os.path.join(HERE, 'cap', img)
    pw, ph = Image.open(path).size
    if pw / ph > 3.0:   # 넓은 캡처: 위에 가로 전체, 아래에 '왜' 세 칸
        w, h = picture(s, path, 0.6, 2.05, 12.1, 3.1)
        y = 2.05 + h + 0.3
        text(s, 0.6, y, 0.6, 0.4, '왜', size=16, bold=True, color=MUTED)
        for i, line in enumerate(why_lines):
            text(s, 1.2 + i * 3.85, y, 3.6, 1.0, line, size=16)
    else:
        picture(s, path, 0.6, 2.05, 7.7, img_max_h)
        why(s, why_lines)
    manual(s, manual_line)
    return s


# 6 미대조 ① 라벨
capture_slide('미대조 ① 같은 파일 안 라벨로 뛰는 분기', '우리 설계 · 다시 해 보니 416건 모두 일치', 'blue', 'c1_m.png',
    ['풀면 라벨이 숫자 주소(0x0)가 된다', '그대로 다시 조립하면 다른 명령 → 그래서 비교를 빼 두었다', '숫자를 라벨로 되돌리니 모두 일치'],
    'JA rel8 = 77 cb (짧은 상대 분기). 밖의 라벨 분기(교수님 지시)는 처음부터 모두 비교됐고 모두 일치',
    '미대조 중 하나는 같은 파일 안 라벨로 뛰는 분기입니다. 풀면 라벨이 숫자 주소가 돼서 그대로 다시 조립하면 다른 명령이 됩니다. '
    '그래서 처음에는 비교에서 뺐는데, 숫자를 라벨로 되돌려 다시 해 보니 네 길 416건이 모두 일치했습니다. '
    '교수님이 말씀하신 밖의 라벨 분기는 처음부터 다 비교됐고 모두 일치합니다.')

# 7 미대조 ② FWORD
capture_slide('미대조 ② objdump 글자를 as가 받지 않는다', 'GNU objdump 문제 · 87건 (지난번 보고와 같은 계열)', 'red', 'c2_m.png',
    ['10바이트 포인터인데 objdump가 FWORD(6바이트)로 적는다', 'as는 64비트 레지스터 + FWORD를 거부 (매뉴얼대로)', 'TBYTE로 적으면 같은 바이트로 다시 조립된다'],
    'LSS r64,m16:64 = REX.W 0F B2 /r, "80-bit pointer (16-bit selector, 64-bit offset)"',
    '두 번째 미대조는 GNU Intel 길에서만 나온 87건입니다. LSS처럼 10바이트 포인터를 읽는 명령을 objdump가 FWORD, 6바이트로 적습니다. '
    'as는 64비트 레지스터에 FWORD를 붙이면 거부하는데, 이건 매뉴얼에 맞는 동작입니다. 지난번에 보고드린 LSS 문제와 같습니다.', img_max_h=2.4)

# 8 적는 법
s = capture_slide('글자 불일치는 거의 다 적는 법 차이', '문제 아님 · 186,137건이 바이트 같음', 'blue', 'c3_m.png',
    ['풀 때 도구가 자기 방식으로 다시 적는다', '16진수 → 10진수, 다른 이름(cmovng → cmovle), 0 붙이기', 'LLVM이 많은 이유: 숫자를 10진수로 적는다'],
    'CMOVNG와 CMOVLE는 같은 표 행(0F 4E /r). ADC AL, imm8 = 14 ib',
    '글자 불일치 18만여 건 가운데 186,137건은 바이트가 같습니다. 16진수를 10진수로 적거나, 같은 명령의 다른 이름을 쓰거나, 0을 붙여 적는 것입니다. '
    'LLVM 쪽이 많은 것은 숫자를 10진수로 적기 때문입니다.', img_max_h=3.0)

# 9 VPCMP
capture_slide('바이트 불일치 ① VPCMP — 바이트는 달라도 같은 명령', '문제 아님 · 길마다 12건', 'blue', 'c4_m.png',
    ['조건이 0이면 짧은 이름 vpcmpeqb로 푼다', 'vpcmpeqb는 자기 바이트(0F 74)를 가진 명령이기도 하다', '매뉴얼의 동작 설명이 같다'],
    'VPCMPB Table 5-19 "VPCMPEQ* reg1, reg2, reg3 = VPCMP* reg1, reg2, reg3, 0"',
    '바이트가 다른데 문제가 아닌 경우입니다. 비교 조건이 0이면 도구가 vpcmpeqb라는 짧은 이름으로 풉니다. '
    '그 이름은 따로 바이트가 있는 명령이라 다시 조립하면 바이트가 달라집니다. 매뉴얼은 둘을 같다고 적고, 동작 설명도 같습니다.', img_max_h=2.4)

# 10 먼 CALL
capture_slide('바이트 불일치 ② LLVM 먼 호출이 가까운 호출로', 'LLVM 문제 · 434건 (지난번 보고 계열)', 'red', 'c5_m.png',
    ['Intel로 풀 때 "먼"과 크기를 적지 않는다', '다시 조립하면 가까운 호출(FF /2)', 'AT&T로 풀면 lcalll로 적어 일치'],
    'CALL m16:32 = FF /3 (먼 호출), CALL r/m64 = FF /2 (가까운 호출)',
    '가장 많은 것은 지난번에 보고드린 먼 호출입니다. 먼 호출을 풀면 그냥 call [rax]가 되고, 다시 조립하면 가까운 호출이 됩니다. '
    '바이트도 뜻도 달라지는 진짜 불일치입니다. AT&T로 풀면 lcall로 적어서 문제가 없습니다. 434건은 Intel 길 242, AT&T 길 192입니다.', img_max_h=3.2)

# 11 크기 사라짐
capture_slide('바이트 불일치 ③ LLVM Intel로 풀면 크기가 사라진다', 'LLVM 문제 · 새로 찾음', 'red', 'c6_m.png',
    ['66 9C(2바이트 넣기) → pushf → 9C(8바이트)', '0F A0(64비트) → push fs → 66 0F A0(16비트)', 'AT&T로 풀면 pushfw로 적어 일치'],
    'PUSHF: "16-bit operation is supported using the operand size override prefix 66H" (64비트 모드)',
    '66 9C는 스택에 2바이트를 넣는 명령인데 Intel로 풀면 그냥 pushf입니다. 다시 조립하면 8바이트를 넣는 9C가 됩니다. '
    'push fs는 멀쩡한 64비트 명령이 왕복 한 번에 16비트로 바뀝니다. 같은 LLVM도 AT&T로 풀면 일치합니다.', img_max_h=4.0)

# 12 clang Intel 16비트
capture_slide('바이트 불일치 ④ 같은 소스인데 clang Intel만 16비트', 'LLVM 문제 · 새로 찾음 (pushf는 2017년에 고쳐짐, #31383)', 'red', 'c7_m.png',
    ['LLVM 정의 "push{w}\\t{%fs|fs}": 크기 글자가 AT&T에만 있다', 'Intel 글자는 16·32·64비트가 모두 push fs', '그중 16비트 정의를 고른다'],
    'PUSH FS = 0F A0, "operand size (16, 32, or 64 bits) determines ... decremented (2, 4 or 8)", 64비트 기본은 64',
    '이번에는 조립하는 쪽입니다. clang이 Intel 문법일 때만 push fs를 16비트로 조립합니다. 스택이 8이 아니라 2만 움직이는 것을 CPU에서 확인했습니다. '
    '원인은 LLVM 명령 정의입니다. 크기 글자가 AT&T 쪽에만 있어서 Intel에서는 세 크기가 모두 같은 글자가 되고, 16비트 정의가 골라집니다. '
    'pushf는 2017년에 같은 문제가 보고되어 고쳐졌는데 push fs와 iret은 그대로입니다. 13건(AT&T 길)이 이 경우이고 mov cx, es 5건은 반대로 66이 빠집니다.', img_max_h=4.15)

# 13 rn-sae
capture_slide('바이트 불일치 ⑤ {rn-sae}를 어디에 쓰나', '우리 변환 잘못 40건(고침) · 도구 차이 10행(오류 아님)', 'amber', 'c8_m.png',
    ['40건: 우리가 AT&T로 옮길 때 자리를 틀리게 놓았다', '전부 바꿔 4,344번: 288행 중 10행만 두 도구가 다르다', '틀린 바이트 0건, 매뉴얼은 자리를 정하지 않는다'],
    'VCVTSI2SD xmm1, xmm2, r/m64{er} = EVEX.LLIG.F2.0F.W1 2A /r',
    '이 40건은 도구가 아니라 우리 변환이 틀린 것이었고 고쳤습니다. 고치면서 자리를 전부 바꿔 넣어 봤습니다. '
    '정수 레지스터에서 바꾸는 명령 10행만 clang Intel이 매뉴얼 표 모양을 받지 않습니다. 받으면 바이트는 항상 맞습니다. 매뉴얼이 자리를 정하지 않아 오류라고 하지는 않습니다.', img_max_h=2.6)

# 14 iret
s = new_slide('iret — 매뉴얼이 둘 다 된다고 한다, 그래서 위험하다', notes=
    'iret은 누가 틀렸다고 할 수 없습니다. 매뉴얼이 둘 다 된다고 적었습니다. 그래서 우리도 소스를 바꾸지 않았습니다. '
    '다만 64비트 코드에서 iret이라고 쓰면 GNU는 32비트, clang Intel은 16비트가 됩니다. 인터럽트가 쌓는 프레임은 8바이트 칸 다섯 개입니다. '
    '이걸 32비트로 읽으면 돌아갈 주소의 위쪽 4바이트를 CS로 읽습니다. CPU에서 사용자 모드로 확인했습니다. 커널 안에서는 아직 확인하지 못했습니다.')
box(s, 0.6, 1.3, 12.1, 0.55, SOFT, [[('매뉴얼  ', {'bold': True, 'color': MUTED, 'size': 14}),
    ('"most assemblers use the IRET mnemonic interchangeably for both operand sizes"', {'size': 15, 'code': True})]], align=PP_ALIGN.LEFT)
# 왼쪽: 같은 소스 → 바이트
y = 2.2
text(s, 0.6, y, 4.2, 0.4, '같은 iret 한 줄', size=16, bold=True, color=MUTED)
for i, (tool, byte, bits, col) in enumerate([('GNU', 'CF', '32비트', RED), ('clang Intel', '66 CF', '16비트', RED), ('모두 같은 철자', '48 CF', 'iretq · 64비트', BLUE)]):
    yy = y + 0.55 + i * 0.95
    box(s, 0.6, yy, 1.9, 0.75, SOFT, tool, size=15, bold=True)
    arrow(s, 2.6, yy + 0.22, 0.45)
    box(s, 3.15, yy, 1.6, 0.75, PAPER, [[(byte, {'code': True, 'bold': True, 'size': 18, 'color': col})], [(bits, {'size': 12, 'color': MUTED})]], line=LINE)
# 오른쪽: 프레임 그림
fx = 5.6
text(s, fx, y, 3.3, 0.4, '스택에 쌓인 것 (8바이트 칸)', size=15, bold=True, color=MUTED)
text(s, fx + 3.6, y, 3.6, 0.4, 'CF(4바이트 칸)로 읽으면', size=15, bold=True, color=RED)
slots = ['RIP', 'CS', 'RFLAGS', 'RSP', 'SS']
reads = [('EIP', '아래 4바이트'), ('CS', '= RIP 위 4바이트'), ('EFLAGS', ''), ('ESP', ''), ('SS', ''), (None, ''), (None, ''), (None, ''), (None, ''), (None, '')]
sh = 0.72
for i, k in enumerate(slots):
    box(s, fx, y + 0.5 + i * sh, 3.1, sh - 0.06, 'E6ECF2', k, size=15, bold=True, code=True, shape=MSO_SHAPE.RECTANGLE)
for i, (k, note) in enumerate(reads):
    yy = y + 0.5 + i * sh / 2
    if k:
        col = REDBG if k == 'CS' else BLUEBG
        box(s, fx + 3.6, yy, 1.5, sh / 2 - 0.04, col, k, size=12, bold=True, code=True, shape=MSO_SHAPE.RECTANGLE,
            color=RED if k == 'CS' else INK)
        if note:
            text(s, fx + 5.2, yy + 0.04, 2.3, 0.3, note, size=11, color=RED if k == 'CS' else MUTED)
    else:
        box(s, fx + 3.6, yy, 1.5, sh / 2 - 0.04, PAPER, '안 읽음', size=10, color=MUTED, shape=MSO_SHAPE.RECTANGLE, line=LINE)
for i in range(5):
    hline(s, fx + 3.1, y + 0.5 + i * sh + 0.15, fx + 3.6, y + 0.5 + i * sh + 0.15, LINE, 1.0)
text(s, 0.6, 5.55, 4.6, 1.2, [[('위험한 때', {'bold': True})], '컴파일러를 바꿀 때 · 푼 글자를 다시 조립할 때', 'CPU 관측: 같은 40바이트가 IRETQ로는 오류, CF로는 정상 복귀'],
     size=13, spacing=4)

# 15 재검토 결과표
s = new_slide('재검토한 결과표', notes=
    '처음 표를 재검토해 다시 묶었습니다. 완전 일치와 적는 법만 다른 것이 거의 전부입니다. 문제 아님은 VPCMP와 MOV Sreg처럼 바이트는 달라도 같은 명령, 같은 동작인 것입니다. '
    '우리 설계 쪽은 라벨 분기 104건과 {rn-sae} 변환 40건입니다. iret 1건은 매뉴얼이 둘 다 허용합니다. 남는 도구 문제는 LLVM 434+15건과 GNU 87건입니다. '
    '이와 별도로 3단계 판정에서 mov cx, es 같은 13건을 잘못 일치로 두던 것을 고쳤습니다.')
hdr = ['길', '완전 일치', '적는 법만\n다름', '문제 아님\n(같은 명령·동작)', '우리 설계\n(라벨·변환)', '매뉴얼\n둘 다 허용', 'LLVM 문제', 'GNU 문제']
body = []
tot = [0] * 7
for fam, path, label in PATHS:
    v = review[f'{fam} {path}']
    row = [v['완전 일치'], v['적는 법만 다름(바이트 같음)'],
           v['문제 아님: 같은 명령(VPCMP)'] + v['문제 아님: 같은 동작(MOV Sreg)'],
           v['설계: 라벨 분기(다시 해 보니 일치)'] + v['설계: AT&T 변환 {rn-sae} 자리'],
           v['매뉴얼이 둘 다 허용(IRET)'], v['LLVM: 먼 CALL/JMP'] + v['LLVM: 크기 사라짐/바뀜'], v['GNU: objdump FWORD 출력']]
    tot = [a + b for a, b in zip(tot, row)]
    body.append([label] + [n(x) for x in row])
body.append(['합계'] + [n(x) for x in tot])
red = {(i, j) for i in range(5) for j in (6, 7) if body[i][j] != '0'}
blue = {(i, j) for i in range(5) for j in (1, 2, 3) if body[i][j] != '0'}
amber = {(i, j) for i in range(5) for j in (4, 5) if body[i][j] != '0'}
table(s, 0.6, 1.45, 12.1, [1.75, 1.45, 1.5, 1.85, 1.55, 1.3, 1.35, 1.35], hdr, body, size=15, red=red, blue=blue, amber=amber, rowh=0.55)
legend = [('파랑', BLUE, '바이트·뜻 같음'), ('빨강', RED, '도구 문제 (뜻이 바뀌거나 받지 못함)')]
text(s, 0.6, 5.35, 12.1, 0.4, [[('파랑 ', {'bold': True, 'color': BLUE}), ('바이트·뜻이 같다    ', {'color': MUTED}),
                                ('주황 ', {'bold': True, 'color': AMBER}), ('우리 설계·매뉴얼 허용    ', {'color': MUTED}),
                                ('빨강 ', {'bold': True, 'color': RED}), ('도구 문제: 뜻이 바뀌거나 글자를 받지 못한다', {'color': MUTED})]], size=14)
text(s, 0.6, 5.85, 12.1, 0.9, ['LLVM 문제 = 먼 CALL/JMP 434 + 크기 15 · 우리 설계 = 라벨 분기 416(다시 해 보니 일치) + {rn-sae} 변환 40(고침)',
                               '이 표와 별도로 3단계 판정 13건을 고쳤다 (mov cx, es 등을 일치로 두던 것)'], size=13, color=MUTED, spacing=4)

# 16 정리
s = new_slide('정리와 여쭐 것', dark=True, notes=
    '정리하면 미대조는 다시 해 보면 일치하거나 이미 아는 문제이고, 글자 불일치는 거의 다 적는 법 차이입니다. '
    '실제로 뜻이 달라지는 것은 LLVM의 Intel 문법 몇 개 명령과 GNU objdump FWORD입니다. LLVM에 같은 보고가 있는지 찾아봤는데 찾지 못했습니다. '
    '어디까지 보고할지 말씀 주시면 진행하겠습니다. 커널 안 iret 실험은 가상 머신이 필요해 다음 실험으로 넘기겠습니다.')
share = (tot[0] + tot[1]) / sum(tot)
cards = [(f'{share * 100:.1f}%', '일치하거나 적는 법만 다름', f'{n(tot[0] + tot[1])} / {n(sum(tot))} 왕복'),
         ('2건', 'LLVM 문제 새로 찾음', 'clang Intel 16비트 · Intel 출력 크기 사라짐'),
         ('?', '어디까지 보고할까요', '같은 보고는 못 찾음 (#31383 선례)')]
for i, (big, h, sub) in enumerate(cards):
    x = 0.6 + i * 4.13
    box(s, x, 1.7, 3.85, 3.4, '243240')
    text(s, x + 0.3, 1.95, 3.3, 1.1, big, size=48, bold=True, color='F2C46D' if i == 2 else PAPER)
    text(s, x + 0.3, 3.15, 3.3, 0.5, h, size=18, bold=True, color=PAPER)
    text(s, x + 0.3, 3.7, 3.3, 1.2, sub, size=14, color='AFC3D6')
text(s, 0.6, 5.6, 12.1, 0.5, '다음 실험: 커널 안 iret (가상 머신) · 검사 도구에 "도구마다 크기가 다른 철자" 경고', size=16, color='AFC3D6')

prs.save(OUT)
print('saved', OUT, len(prs.slides), 'slides')

"""터미널 출력(.txt)을 발표용 PNG로. 줄 끝 표시 §R(빨강)·§B(파랑)는 색만 정하고 그림에는 넣지 않는다."""
import sys
from PIL import Image, ImageDraw, ImageFont
MONO = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf", 26)
HANGUL = ImageFont.truetype("/usr/share/fonts/opentype/noto/NotoSansCJK-Regular.ttc", 25, index=1)
BG, FG, CMD, BLUE, RED, NOTE = "#16181d", "#d8dce3", "#ffffff", "#6cb6ff", "#ff6b6b", "#8b93a1"
CELL, LINE, PAD = MONO.getlength("M"), 40, 30

def is_hangul(ch):
    return ord(ch) > 0x2000

def advance(ch):
    return HANGUL.getlength(ch) if is_hangul(ch) else CELL

def render(path, out):
    rows = []
    for raw in open(path, encoding="utf-8").read().splitlines():
        color = FG
        if raw.endswith("§R"): raw, color = raw[:-2].rstrip(), RED
        elif raw.endswith("§B"): raw, color = raw[:-2].rstrip(), BLUE
        elif raw.startswith("$ "): color = CMD
        elif "error" in raw.lower(): color = RED
        rows.append((raw, color))
    width = max(sum(advance(c) for c in l) for l, _ in rows)
    img = Image.new("RGB", (int(width + 2 * PAD), len(rows) * LINE + 2 * PAD), BG)
    d = ImageDraw.Draw(img)
    for i, (line, color) in enumerate(rows):
        x, y = PAD, PAD + i * LINE
        code, comment = line, ""
        if line.startswith("$ ") and "#" in line:
            k = line.index("#"); code, comment = line[:k], line[k:]
        for part, col in ((code, color), (comment, NOTE)):
            for ch in part:
                h = is_hangul(ch)
                d.text((x, y + (1 if h else 0)), ch, font=HANGUL if h else MONO, fill=col)
                x += advance(ch)
    img.save(out)
    return img.size

for p in sys.argv[1:]:
    print(p, render(p, p[:-4] + ".png"))

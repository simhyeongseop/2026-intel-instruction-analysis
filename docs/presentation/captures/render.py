"""터미널 출력(.txt)을 발표용 PNG로 그린다. 판정 줄 색: SDM 일치=파랑, 거부·다름·실패=빨강."""
import re
import sys
from PIL import Image, ImageDraw, ImageFont

MONO = ImageFont.truetype("C:/Windows/Fonts/consola.ttf", 22)
HANGUL = ImageFont.truetype("C:/Windows/Fonts/malgun.ttf", 20)
BG, FG, CMD, BLUE, RED = "#111111", "#e6e6e6", "#ffffff", "#5aa9ff", "#ff5c5c"
CELL, LINE, PAD = MONO.getlength("M"), 32, 28


def color_of(line):
    if line.startswith("$ "):
        return CMD
    if "SDM 일치" in line or "수용됨" in line:
        return BLUE
    if re.search(r"거부|다름|디코드 실패|다른 행으로 수용|error", line):
        return RED
    return FG


def is_hangul(ch):
    return ord(ch) > 0x2000 and ch != "—"


def advance(ch):
    return HANGUL.getlength(ch) if is_hangul(ch) else CELL


def render(path):
    lines = [l.replace("\t", "    ")[:110] for l in open(path, encoding="utf-8").read().splitlines()]
    width = max(sum(advance(c) for c in l) for l in lines)
    image = Image.new("RGB", (int(width + 2 * PAD), len(lines) * LINE + 2 * PAD), BG)
    draw = ImageDraw.Draw(image)
    for row, line in enumerate(lines):
        x, y, color = PAD, PAD + row * LINE, color_of(line)
        for ch in line:
            wide = is_hangul(ch)
            draw.text((x, y + (2 if wide else 0)), ch, font=HANGUL if wide else MONO, fill=color)
            x += advance(ch)
    image.save(path[:-4] + ".png")


for name in sys.argv[1:]:
    render(name)

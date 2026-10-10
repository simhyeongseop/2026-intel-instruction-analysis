"""총론 3.1.1.1~3.1.1.5의 표기 정의를 원문 그대로 옮겨 data/rules/sdm_symbols.csv를 만든다.

    python3 scripts/build_sdm_symbols.py

해석 열은 없다. 각 항목은 '• 기호 — 정의' 글머리 하나이고, 다음 글머리나 소제목 직전까지의 원문을 담는다.
쪽 머리말·꼬리말과 표 회전 글자(retsigeR 등)는 원문 본문이 아니므로 뺀다. 뺀 줄 수를 같이 적는다.
"""

import csv
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from pipeline import manual_index  # noqa: E402

OUT = "data/rules/sdm_symbols.csv"

# 3.1.1.1 ~ 3.1.1.5 (파일 102~109쪽). 3.1.1.6이 시작되면 멈춘다.
FIRST_PAGE, LAST_PAGE = 102, 109
SECTION_HEAD = re.compile(r"^3\.1\.1\.(\d+)\s+(.*)$")
ENTRY = re.compile(r"^(?:•\s*)?(?P<symbol>[^—•]{1,70}?)\s*—\s*(?P<rest>.*)$")
NOISE = re.compile(r"^(INSTRUCTION SET REFERENCE, A-L|Vol\. 2A 3-\d+|3-\d+ Vol\. 2A|retsigeR|B\.XER|dleiFgeR( retsigeR)?)$")
STOP_AT = "3.1.1.6"
# 글머리가 아니지만 독립된 원문 단위로 시작하는 줄. (시작 문자열, 붙일 이름)
STANDALONE = [
    (re.compile(r"^(Table \d+-\d+)\. "), None),          # 표 제목: 이름은 표 번호
    (re.compile(r"^NOTES?$"), "NOTE"),
    (re.compile(r"^In the instruction encoding, the MODRM byte"), "MODRM 표기"),
    (re.compile(r"^VEX\.\[128,256\]"), "VEX 표기 형식"),
    (re.compile(r"^EVEX\.\[128,256,512"), "EVEX 표기 형식"),
    (re.compile(r"^The 64-bit mode support is to the left"), "64비트 모드 열 표기"),
    (re.compile(r"^The Compatibility/Legacy Mode support is to the right"), "호환/레거시 모드 열 표기"),
]


def page_lines(index):
    for file_page in range(FIRST_PAGE, LAST_PAGE + 1):
        for line in index.pages_by_number[file_page]["lines"]:
            yield file_page, line.strip()


def collect(index):
    entries = []
    section = ""
    current = None
    after_bullet = False
    dropped = 0
    for file_page, line in page_lines(index):
        if not line:
            continue
        if NOISE.match(line):
            dropped += 1
            continue
        head = SECTION_HEAD.match(line)
        if head:
            if line.startswith(STOP_AT):
                break
            section = "3.1.1.%s %s" % (head.group(1), head.group(2))
            current = None
            continue
        standalone = None
        for regex, name in STANDALONE:
            found = regex.match(line)
            if found:
                standalone = name or found.group(1)
                break
        if standalone:
            current = {
                "symbol": standalone,
                "section": section,
                "file_page": file_page,
                "printed_page": index.pages_by_number[file_page]["printed_page"],
                "lines": [line],
                "pages": [file_page],
            }
            entries.append(current)
            after_bullet = False
            continue
        if line == "•":
            after_bullet = True
            continue
        starts_entry = after_bullet or line.startswith("•")
        after_bullet = False
        matched = ENTRY.match(line) if starts_entry else None
        if matched:
            current = {
                "symbol": matched.group("symbol").strip(),
                "section": section,
                "file_page": file_page,
                "printed_page": index.pages_by_number[file_page]["printed_page"],
                "lines": [line.lstrip("• ").strip()],
                "pages": [file_page],
            }
            entries.append(current)
            continue
        if starts_entry and current is not None:
            # '기호 — 정의' 모양이 아닌 글머리는 앞 항목의 하위 설명이다(예: VEX.L 해석 조건).
            current["lines"].append("• " + line.lstrip("• ").strip())
            if file_page not in current["pages"]:
                current["pages"].append(file_page)
            continue
        if current is None:
            # 절 제목 바로 뒤의 도입 문장. 빠뜨리지 않고 절 본문 항목으로 담는다.
            current = {
                "symbol": "(본문) " + section.split(" ")[0],
                "section": section,
                "file_page": file_page,
                "printed_page": index.pages_by_number[file_page]["printed_page"],
                "lines": [],
                "pages": [file_page],
            }
            entries.append(current)
        current["lines"].append(line)
        if file_page not in current["pages"]:
            current["pages"].append(file_page)
    return entries, dropped


def check_complete(index, entries):
    """범위 안의 원문 줄(잡음 제외)이 모두 정확히 한 번 항목에 들어갔는지 센다."""
    expected = []
    for _, line in page_lines(index):
        if line.startswith(STOP_AT):
            break
        if line and line != "•" and not NOISE.match(line) and not SECTION_HEAD.match(line):
            expected.append(line.lstrip("• ").strip())
    stored = [l.lstrip("• ").strip() for e in entries for l in e["lines"]]
    return len(expected), len(stored), sorted(expected) == sorted(stored)


def main():
    index = manual_index.ManualIndex()
    entries, dropped = collect(index)
    fields = ["symbol_id", "symbol", "source_text", "file_pages", "printed_page", "section", "pdf_sha256"]
    sha = index.manifest["pdf"]["sha256"]
    with open(OUT, "w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=fields)
        writer.writeheader()
        for number, entry in enumerate(entries, 1):
            writer.writerow({
                "symbol_id": "SYM%03d" % number,
                "symbol": entry["symbol"],
                "source_text": " ".join(entry["lines"]),
                "file_pages": ";".join(str(p) for p in entry["pages"]),
                "printed_page": entry["printed_page"],
                "section": entry["section"],
                "pdf_sha256": sha,
            })
    expected, stored, same = check_complete(index, entries)
    print("항목 %d개 -> %s (머리말·꼬리말·회전 글자 %d줄 제외)" % (len(entries), OUT, dropped))
    print("원문 줄 %d / 저장 줄 %d / 전부 한 번씩: %s" % (expected, stored, same))
    if not same:
        raise SystemExit("원문 줄이 빠지거나 중복됐다")


if __name__ == "__main__":
    main()

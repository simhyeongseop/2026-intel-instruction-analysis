"""인코딩 표의 각주 번호를 지우지 않고 표시한 원문 셀을 뽑는다.

    ~/pdftools_venv/bin/python scripts/extract_table_footnotes.py [--output out/sdm_evidence_093/table_cells.jsonl]

1단계(m1_extract)와 같은 표 찾기·셀 조립·행 파싱을 그대로 쓴다. 다른 점은 하나다:
m1이 지우는 위첨자 각주 숫자를 '^숫자'로 남긴 셀도 함께 만든다(예: 'MOV r/m8^1, r8^1').
각주를 지운 쪽 파싱 결과가 data/db/isa_db.csv와 순서까지 같아야 같은 행으로 연결한다. 다르면 멈춘다.
"""

import argparse
import csv
import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from pipeline import m1_extract as m1  # noqa: E402


def footnote_flags(chars):
    """m1.strip_footnote_digit_chars와 같은 기준으로 각주 숫자인 글자를 표시한다."""
    if len(chars) < 2:
        return [False] * len(chars)
    import collections
    sizes = collections.Counter(round(c["size"], 2) for c in chars)
    body_size = max(sizes.items(), key=lambda item: (item[1], item[0]))[0]
    threshold = body_size * m1.FOOTNOTE_SIZE_RATIO
    flags = [c["text"].isdigit() and c["size"] < threshold for c in chars]
    return flags if not all(flags) else [False] * len(chars)


def marked_cells(page_chars, row_bbox, cell_bboxes, skip_col):
    """m1.extract_row_cells와 같지만 각주 숫자를 '^숫자'로 바꿔 남긴다."""
    row_chars = m1._chars_in_bbox(page_chars, row_bbox)
    cells = []
    for col_i, cell_bbox in enumerate(cell_bboxes):
        if cell_bbox is None:
            cells.append(None)
            continue
        chars = m1._chars_in_bbox(row_chars, cell_bbox)
        if not chars:
            cells.append("")
            continue
        if col_i != skip_col:
            flags = footnote_flags(chars)
            chars = [dict(c, text="^" + c["text"]) if flag else c for c, flag in zip(chars, flags)]
        cells.append(m1.chars_to_text(chars, y_tolerance=m1.LINE_Y_TOLERANCE))
    return cells


def rows_from_page(page, page_no):
    """(각주 지운 파싱 행, 각주 표시 원문 셀) 쌍 목록."""
    pairs = []
    try:
        tables = page.find_tables()
    except Exception:
        return pairs
    page_chars = page.chars
    for table in tables:
        if not table.rows:
            continue
        header = m1.extract_row_cells(page_chars, table.rows[0].bbox, table.rows[0].cells, skip_col=None)
        roles = m1.classify_columns(header)
        if roles is None:
            continue
        for row_obj in table.rows[1:]:
            raw_row = m1.extract_row_cells(page_chars, row_obj.bbox, row_obj.cells, skip_col=roles["description_idx"])
            if raw_row is None or all(c is None for c in raw_row):
                continue
            if raw_row[0] and str(raw_row[0]).strip().upper().startswith("NOTES"):
                continue
            parsed = m1.parse_row(raw_row, roles, page_no)
            if not parsed:
                continue
            marked = marked_cells(page_chars, row_obj.bbox, row_obj.cells, skip_col=roles["description_idx"])
            pairs.append((parsed, {"cells": marked, "roles": {k: v for k, v in roles.items()}}))
    return pairs


def main():
    import pdfplumber

    parser = argparse.ArgumentParser()
    parser.add_argument("--pdf", default="intel_manual.pdf")
    parser.add_argument("--isa-db", default="data/db/isa_db.csv")
    parser.add_argument("--output", default="out/sdm_evidence_093/table_cells.jsonl")
    args = parser.parse_args()

    with open(args.isa_db, encoding="utf-8") as handle:
        isa_rows = list(csv.DictReader(handle))
    pairs = []
    with pdfplumber.open(args.pdf) as pdf:
        for i in range(m1.INSTR_REF_START, min(m1.INSTR_REF_END, len(pdf.pages))):
            page = pdf.pages[i]
            pairs.extend(rows_from_page(page, i + 1))
            page.close()
            if (i + 1) % 200 == 0:
                print("  %d쪽" % (i + 1), flush=True)

    # 같은 행인지 확인: 각주를 지운 파싱 결과가 isa_db와 순서·값이 같아야 한다.
    if len(pairs) != len(isa_rows):
        raise SystemExit("행 수가 다르다: 추출 %d / isa_db %d" % (len(pairs), len(isa_rows)))
    for row_id, ((parsed, _), isa) in enumerate(zip(pairs, isa_rows)):
        for key in ("opcode", "instruction", "op_en", "mode_support", "source_page"):
            if str(parsed[key]) != str(isa[key]):
                raise SystemExit("행 %d의 %s가 다르다: %r / %r" % (row_id, key, parsed[key], isa[key]))

    os.makedirs(os.path.dirname(args.output), exist_ok=True)
    with open(args.output, "w", encoding="utf-8") as handle:
        for row_id, (parsed, marked) in enumerate(pairs):
            handle.write(json.dumps({"row_id": row_id, "source_page": parsed["source_page"],
                                     "marked_cells": marked["cells"], "roles": marked["roles"]},
                                    ensure_ascii=False) + "\n")
    print("행 %d개, isa_db와 순서·값 일치 -> %s" % (len(pairs), args.output))


if __name__ == "__main__":
    main()

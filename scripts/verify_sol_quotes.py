"""Sol 8개 part의 인용문이 SDM 원문(쪽 텍스트)·총론 기호 정의에 실제로 있는지 확인한다.

    python3 scripts/verify_sol_quotes.py [--review-dir out/sdm_review_2026-10-09]

쪽 인용은 적힌 쪽의 앞 1쪽 ~ 뒤 2쪽 텍스트에서 찾는다(인용이 쪽 경계를 넘는 경우).
결과: review-dir/compare/quote_check.csv(인용마다 한 줄), quote_check_summary.json.
"""

import argparse
import collections
import csv
import glob
import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from pipeline import manual_index, quote_check  # noqa: E402

SYMBOLS_CSV = "data/rules/sdm_symbols.csv"
TABLE_CELLS = "out/sdm_evidence_2026-10-09/table_cells.jsonl"


def load_table_cells(path=TABLE_CELLS):
    """쪽 번호 -> 그 쪽 표 행들의 셀 원문(행마다 한 줄, 칸은 ' | '로 잇는다)."""
    by_page = collections.defaultdict(list)
    with open(path, encoding="utf-8") as handle:
        for line in handle:
            record = json.loads(line)
            cells = record["marked_cells"]
            by_page[record["source_page"]].append(" | ".join(cells) + "\n" + " ".join(cells))
    return by_page


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--review-dir", default="out/sdm_review_2026-10-09")
    args = parser.parse_args()

    index = manual_index.ManualIndex()
    with open(SYMBOLS_CSV, encoding="utf-8") as handle:
        symbols = {row["symbol_id"]: row["source_text"] for row in csv.DictReader(handle)}

    table_cells = load_table_cells()
    results = {}
    usage = collections.Counter()
    for path in sorted(glob.glob(os.path.join(args.review_dir, "sol_part[0-9].csv"))):
        part = os.path.basename(path)[len("sol_"):-len(".csv")]
        with open(path, encoding="utf-8") as handle:
            for row in csv.DictReader(handle):
                for ref, quote in quote_check.parse_quotes(row["source_quotes"]):
                    key = (part, ref, quote)
                    usage[key] += 1
                    if key in results:
                        continue
                    kind, where, subsection = quote_check.parse_ref(ref)
                    if kind == "sym":
                        source = symbols.get(where, "")
                        pages = ""
                    else:
                        first, last = where
                        window = range(first - 1, last + 3)
                        source = "\n".join(index.page_text(p) for p in window)
                        if quote_check.is_table_ref(subsection):
                            source += "\n" + "\n".join(c for p in window for c in table_cells.get(p, []))
                        pages = "%d-%d" % (first, last)
                    level = quote_check.match_level(quote, source) if source else None
                    if level is None and source and kind == "page" and quote_check.is_table_ref(subsection):
                        level = quote_check.table_label_level(quote, source)
                    results[key] = {
                        "part": part, "first_row_id": row["row_id"], "ref": ref, "ref_kind": kind,
                        "subsection": subsection, "pages_searched": pages,
                        "result": level or ("not_found" if source else "no_source"),
                        "quote": quote,
                    }

    rows = list(results.values())
    for row in rows:
        row["uses"] = usage[(row["part"], row["ref"], row["quote"])]
    out_dir = os.path.join(args.review_dir, "compare")
    os.makedirs(out_dir, exist_ok=True)
    fields = ["part", "first_row_id", "ref", "ref_kind", "subsection", "pages_searched", "result", "uses", "quote"]
    with open(os.path.join(out_dir, "quote_check.csv"), "w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=fields)
        writer.writeheader()
        writer.writerows(rows)

    summary = {"unique_quotes": len(rows), "quote_uses": sum(usage.values()), "by_part": {}}
    for part in sorted({r["part"] for r in rows}):
        mine = [r for r in rows if r["part"] == part]
        summary["by_part"][part] = dict(collections.Counter(r["result"] for r in mine).most_common())
    summary["total"] = dict(collections.Counter(r["result"] for r in rows).most_common())
    with open(os.path.join(out_dir, "quote_check_summary.json"), "w", encoding="utf-8") as handle:
        json.dump(summary, handle, ensure_ascii=False, indent=1)
    print(json.dumps(summary, ensure_ascii=False, indent=1))


if __name__ == "__main__":
    main()

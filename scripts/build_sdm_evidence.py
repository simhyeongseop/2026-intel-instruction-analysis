"""ISA 행별 원문 근거 묶음을 만든다.

    python3 scripts/build_sdm_evidence.py [--output-dir out/sdm_evidence_2026-10-09]
"""

import argparse
import collections
import csv
import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from pipeline import manual_index, sdm_evidence  # noqa: E402


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--isa-db", default="data/db/isa_db.csv")
    parser.add_argument("--output-dir", default="out/sdm_evidence_2026-10-09")
    parser.add_argument("--table-cells", default="out/sdm_evidence_2026-10-09/table_cells.jsonl",
                        help="scripts/extract_table_footnotes.py 결과")
    args = parser.parse_args()

    index = manual_index.ManualIndex()
    with open(args.isa_db, encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle))
    with open(args.table_cells, encoding="utf-8") as handle:
        cell_records = [json.loads(line) for line in handle]
    records = sdm_evidence.evidence_for_rows(index, rows, cell_records)
    os.makedirs(args.output_dir, exist_ok=True)
    with open(os.path.join(args.output_dir, "rows.jsonl"), "w", encoding="utf-8") as handle:
        for record in records:
            handle.write(json.dumps(record, ensure_ascii=False) + "\n")
    summary = {
        "rows": len(records),
        "pdf_sha256": index.manifest["pdf"]["sha256"],
        "index_revision": index.manifest["index_revision"],
        "rows_with_footnotes": sum(1 for r in records if r["footnote_numbers"]),
        "rows_with_missing_footnote_text": sum(1 for r in records if r["footnotes_missing"]),
        "op_en_status": collections.Counter(r["op_en_status"] for r in records),
        "rows_without_description": sum(1 for r in records if not r["description"]),
        "rows_without_section": sum(1 for r in records if not r["section_id"]),
    }
    with open(os.path.join(args.output_dir, "summary.json"), "w", encoding="utf-8") as handle:
        json.dump(summary, handle, ensure_ascii=False, indent=1)
    print(json.dumps(summary, ensure_ascii=False, indent=1))


if __name__ == "__main__":
    main()

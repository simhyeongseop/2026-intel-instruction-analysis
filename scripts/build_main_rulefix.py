"""주 에이전트 독립 판정(main_symbol_spec.csv)을 고친 종류 규칙(KIND_PHRASES_FIXED)으로 다시 계산한다.

    python3 scripts/build_main_rulefix.py [--review-dir out/sdm_review_2026-10-09]

원본 파일은 2026-10-09 독립 기록이므로 고치지 않는다. 원본의 table_symbol을 그대로 쓰고,
총론 정의가 있는 줄(status=defined)만 같은 모듈로 다시 계산해 main_symbol_spec_rulefix.csv에 쓴다.
"""

import argparse
import collections
import csv
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from pipeline import sdm_symbol_spec as spec  # noqa: E402

COLUMNS = ["kind", "kind_phrase", "data_width", "width_phrase", "register_set", "symbol_id", "lookup"]


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--review-dir", default="out/sdm_review_2026-10-09")
    args = parser.parse_args()

    source = os.path.join(args.review_dir, "main_symbol_spec.csv")
    target = os.path.join(args.review_dir, "main_symbol_spec_rulefix.csv")
    with open(source, encoding="utf-8", newline="") as handle:
        reader = csv.DictReader(handle)
        fields = reader.fieldnames
        rows = list(reader)

    by_name = spec.load_symbols()
    changed = collections.Counter()
    for row in rows:
        if row["status"] != "defined":
            continue
        old = spec.spec_for_symbol(by_name, row["table_symbol"])
        # 원본 규칙으로 다시 계산한 값이 원본 파일과 같아야 수정 규칙의 차이만 남는다.
        if any((old.get(c) or "") != row[c] for c in COLUMNS):
            raise SystemExit("원본 규칙 재계산이 원본 파일과 다름: row %s" % row["row_id"])
        new = spec.spec_for_symbol(by_name, row["table_symbol"], spec.KIND_PHRASES_FIXED)
        for column in COLUMNS:
            value = new.get(column) or ""
            if value != row[column]:
                changed[(column, row[column], value, row["symbol_id"])] += 1
                row[column] = value

    with open(target, "w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=fields)
        writer.writeheader()
        writer.writerows(rows)
    for (column, old, new, symbol_id), count in changed.most_common():
        print("%5d  %s  %s: %r -> %r" % (count, symbol_id, column, old, new))
    print("바뀐 칸 합계", sum(changed.values()))


if __name__ == "__main__":
    main()

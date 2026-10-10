"""090판 기준 검토 결과·하드코딩을 093판 행 번호와 쪽 번호로 옮긴다.

    python3 scripts/migrate_review_to_093.py [--check-only]

입력: out/sdm_093/edition_diff.csv(행 대응), out/manual_index_090(090 쪽 텍스트), out/manual_index(093 쪽 텍스트)
쪽 대응: 꼬리말(인쇄 쪽 번호 줄)을 뺀 쪽 본문이 두 판에서 똑같고 093판에서 하나뿐이면 짝짓는다.
          짝이 없는 쪽은 가장 가까운 앞쪽의 차이(offset)를 쓴다(앞쪽이 없으면 뒤쪽).
검증: isa_db 행의 090 쪽 -> 093 쪽(판 비교의 old_page/new_page)이 쪽 대응과 맞는지 센다.
출력:
- out/sdm_093/page_map.csv, out/sdm_093/migration_report.json
- out/sdm_review_093/: sol_partN(.csv, _sections.csv), main_symbol_spec(.csv, _rulefix.csv, _record.txt 복사)
- data/rules/source_conflict_cases.csv, encoding_check_overrides.csv, unreachable_forms.csv (row_id·쪽 번호를 093으로)
090판 기록은 git(dbf3732)과 out/sdm_review_2026-10-09에 그대로 남는다.
"""

import argparse
import collections
import csv
import json
import os
import re
import shutil
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline import manual_index, sdm_paths  # noqa: E402

FOOTER = re.compile(r"^(?:.*\bVol\. ?\d[A-D]? ?\d+-\d+.*|\d+-\d+ ?Vol\. ?\d[A-D]?.*|INSTRUCTION SET REFERENCE.*)$")
PAGE_REF = re.compile(r'\[(?P<prefix>파일\s*)?(?P<a>\d+)(?P<suffix>쪽)?(?:(?P<dash>\s*[-–~]\s*)(?P<prefix2>파일\s*)?(?P<b>\d+)(?P<suffix2>쪽)?)?(?P<rest>(?:\s+[^\]\[]*)?)\]\s*"')


def read_csv(path):
    with open(path, encoding="utf-8", newline="") as handle:
        return list(csv.DictReader(handle))


def write_csv(path, rows, fields=None):
    with open(path, "w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=fields or list(rows[0].keys()))
        writer.writeheader()
        writer.writerows(rows)


def body(index, page):
    lines = [l.strip() for l in index.page_text(page).splitlines()]
    return re.sub(r"\s+", "", "\n".join(l for l in lines if l and not FOOTER.match(l)))


def build_page_map(old_index, new_index, row_pages=()):
    """090 쪽 -> 093 쪽. 기준점: (1) 본문이 같고 093에서 하나뿐인 쪽 중 주변 기준점과 offset이 맞는 것,
    (2) isa 행의 표 쪽 쌍(row_pages). 기준점이 없는 쪽은 앞쪽(없으면 뒤쪽) offset을 쓴다."""
    old_pages = [r["file_page"] for r in old_index.pages]
    new_by_body = collections.defaultdict(list)
    for record in new_index.pages:
        new_by_body[body(new_index, record["file_page"])].append(record["file_page"])
    exact = {}
    for page in old_pages:
        text = body(old_index, page)
        if text and len(new_by_body.get(text, [])) == 1:
            exact[page] = new_by_body[text][0]
    # 짧은 쪽이 다른 절의 같은 문구와 우연히 같아지는 경우를 버린다: 앞뒤 5개 기준점 offset의 중앙값과 5쪽 넘게 다르면 제외
    pages = sorted(exact)
    kept = {}
    for i, page in enumerate(pages):
        around = [exact[q] - q for q in pages[max(0, i - 5):i] + pages[i + 1:i + 6]]
        median = sorted(around)[len(around) // 2] if around else exact[page] - page
        if abs((exact[page] - page) - median) <= 5:
            kept[page] = exact[page]
    anchors, how = dict(kept), {p: "본문 동일" for p in kept}
    for old_page, new_page in row_pages:
        if old_page not in anchors:
            anchors[old_page], how[old_page] = new_page, "isa 행 쪽"
    mapping = {}
    previous = None
    for page in old_pages:
        if page in anchors:
            mapping[page] = anchors[page]
            previous = anchors[page] - page
        elif previous is not None:
            mapping[page], how[page] = page + previous, "앞쪽 offset"
    following = None
    for page in reversed(old_pages):
        if page in anchors:
            following = anchors[page] - page
        elif page not in mapping and following is not None:
            mapping[page], how[page] = page + following, "뒤쪽 offset"
    return mapping, how


def map_number(page_map, number):
    return page_map.get(int(number), int(number))


def remap_quotes(text, page_map):
    """Sol 인용 앵커 [쪽 소제목] "의 쪽 번호만 바꾼다. SYM과 비트 범위([3:0])는 건드리지 않는다."""
    def replace(match):
        a = str(map_number(page_map, match.group("a")))
        out = "[" + (match.group("prefix") or "") + a + (match.group("suffix") or "")
        if match.group("b"):
            out += match.group("dash") + (match.group("prefix2") or "") + str(map_number(page_map, match.group("b"))) + \
                (match.group("suffix2") or "")
        return out + match.group("rest") + "]" + match.group(0)[match.group(0).rindex("]") + 1:]
    return PAGE_REF.sub(replace, text)


def remap_page_numbers(text, page_map, pattern=r"(?<![\d.:-])(\d{2,4})(?=쪽|\s*/\s*\d|-\d|$|\s*,)"):
    """하드코딩 파일의 쪽 표기('758쪽', '423-425', '1670 / 1683')를 093 쪽으로."""
    return re.sub(pattern, lambda m: str(map_number(page_map, m.group(1))), text)


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--check-only", action="store_true")
    args = parser.parse_args()

    old_index = manual_index.ManualIndex(sdm_paths.EDITION_090_INDEX_DIR)
    new_index = manual_index.ManualIndex()
    diff = read_csv(sdm_paths.EDITION_DIFF)
    pairs = collections.Counter((int(r["old_page"]), int(r["new_page"])) for r in diff if r["old_page"] and r["new_page"])
    best = {}
    for (old_page, new_page), count in pairs.most_common():
        best.setdefault(old_page, new_page)
    page_map, how = build_page_map(old_index, new_index, sorted(best.items()))
    row_map = {int(r["old_row_id"]): int(r["new_row_id"]) for r in diff if r["old_row_id"] != "" and r["new_row_id"] != ""}
    page_check = collections.Counter(
        "맞음" if page_map.get(int(r["old_page"])) == int(r["new_page"]) else "다름"
        for r in diff if r["old_page"] and r["new_page"])
    report = {
        "pages_090": len(old_index.pages), "pages_093": len(new_index.pages),
        "page_map_how": dict(collections.Counter(how.values())),
        "isa_row_page_check": dict(page_check),
        "row_map": len(row_map), "edition_diff": dict(collections.Counter(r["status"] for r in diff)),
    }
    os.makedirs("out/sdm_093", exist_ok=True)
    write_csv("out/sdm_093/page_map.csv", [{"page_090": p, "page_093": q, "how": how[p]} for p, q in sorted(page_map.items())])
    if args.check_only:
        print(json.dumps(report, ensure_ascii=False, indent=1))
        return

    # 검토 결과
    src, dst = sdm_paths.EDITION_090_REVIEW_DIR, sdm_paths.REVIEW_DIR
    os.makedirs(dst, exist_ok=True)
    moved = collections.Counter()
    for n in range(1, 9):
        rows = read_csv(os.path.join(src, "sol_part%d.csv" % n))
        for row in rows:
            row["row_id"] = row_map[int(row["row_id"])]
            new_quotes = remap_quotes(row["source_quotes"], page_map)
            moved["quote_fields_changed"] += new_quotes != row["source_quotes"]
            row["source_quotes"] = new_quotes
        write_csv(os.path.join(dst, "sol_part%d.csv" % n), rows)
        sections = read_csv(os.path.join(src, "sol_part%d_sections.csv" % n))
        for section in sections:
            section["pages"] = remap_page_numbers(section["pages"], page_map, r"(\d{2,4})")
            section["rows"] = "090 row_id 기준: " + section["rows"]
        write_csv(os.path.join(dst, "sol_part%d_sections.csv" % n), sections)
        moved["sol_rows"] += len(rows)
    for name in ("main_symbol_spec.csv", "main_symbol_spec_rulefix.csv"):
        rows = read_csv(os.path.join(src, name))
        for row in rows:
            row["row_id"] = row_map[int(row["row_id"])]
        write_csv(os.path.join(dst, name), rows)
    shutil.copy(os.path.join(src, "main_symbol_spec_record.txt"), os.path.join(dst, "main_symbol_spec_record_090.txt"))

    # 하드코딩 파일
    for name, page_fields in (("source_conflict_cases.csv", ("source_pages", "exception_says", "note")),
                              ("encoding_check_overrides.csv", ("evidence", "reason")),
                              ("unreachable_forms.csv", ("evidence",))):
        path = os.path.join("data/rules", name)
        rows = read_csv(path)
        if "edition" in rows[0] and rows[0]["edition"] == sdm_paths.EDITION:
            continue  # 이미 옮김
        for row in rows:
            row["row_id"] = row_map[int(row["row_id"])]
            for field in page_fields:
                row[field] = re.sub(r"(\d{2,4})쪽", lambda m: "%d쪽" % map_number(page_map, m.group(1)), row[field])
                row[field] = re.sub(r"PDF (\d{2,4})(?!\d)", lambda m: "PDF %d" % map_number(page_map, m.group(1)), row[field])
            if "source_pages" in row:
                row["source_pages"] = remap_page_numbers(row["source_pages"], page_map, r"(\d{2,4})")
            row["edition"] = sdm_paths.EDITION
        write_csv(path, rows)
        moved[name] = len(rows)
    report["moved"] = dict(moved)
    report["new_rows_093_unreviewed"] = [int(r["new_row_id"]) for r in diff if r["status"] == "added"]
    report["changed_rows_093"] = [{"new_row_id": int(r["new_row_id"]), "fields": r["changed_fields"]}
                                  for r in diff if r["status"] == "changed"]
    with open("out/sdm_093/migration_report.json", "w", encoding="utf-8") as handle:
        json.dump(report, handle, ensure_ascii=False, indent=1)
    print(json.dumps({k: v for k, v in report.items() if k not in ("changed_rows_093",)}, ensure_ascii=False, indent=1))


if __name__ == "__main__":
    main()

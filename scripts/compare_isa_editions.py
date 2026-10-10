"""두 판의 isa_db.csv(1단계 추출)를 행 단위로 비교한다.

    python3 scripts/compare_isa_editions.py --old data/db/isa_db.csv --new out/sdm_093/isa_db.csv --out out/sdm_093/edition_diff.csv

같은 행: opcode와 instruction 칸이 같다(공백·각주 숫자 차이는 무시). 같은 키가 한 판에 여러 번 나오면 순서대로 짝짓는다.
분류: same(쪽 번호 외 모든 칸 같음) / changed(같은 행인데 다른 칸이 바뀜) / added / removed.
짝이 없는 행끼리는 opcode에서 접두어 표기(NFx, NP)만 다르고 instruction이 같으면 같은 행으로 다시 짝짓는다
(093판 MOVBE에 NFx가 붙은 경우). 이때 changed_fields에 opcode를 적는다.
old_row_id·new_row_id로 090판 근거(판정·하드코딩)를 093판 행에 옮길 때 쓴다.
"""

import argparse
import collections
import csv
import re

COMPARED = ("opcode", "mnemonic", "operands", "op_en", "mode_support", "cpuid_flag", "description")


def read_csv(path):
    with open(path, encoding="utf-8", newline="") as handle:
        return list(csv.DictReader(handle))


def norm(text):
    return re.sub(r"\s+", "", text or "")


def key(row):
    return norm(row["opcode"]), norm(row["instruction"])


def pair_rows(old_rows, new_rows):
    """같은 키끼리 등장 순서대로 짝짓는다. 반환: (old_index|None, new_index|None) 목록."""
    old_by_key, new_by_key = collections.defaultdict(list), collections.defaultdict(list)
    for index, row in enumerate(old_rows):
        old_by_key[key(row)].append(index)
    for index, row in enumerate(new_rows):
        new_by_key[key(row)].append(index)
    pairs = []
    for k in list(old_by_key) + [k for k in new_by_key if k not in old_by_key]:
        olds, news = old_by_key.get(k, []), new_by_key.get(k, [])
        for i in range(max(len(olds), len(news))):
            pairs.append((olds[i] if i < len(olds) else None, news[i] if i < len(news) else None))
    # 접두어 표기만 다른 행 다시 짝짓기
    loose = lambda row: (re.sub(r"^(NFx|NP)", "", norm(row["opcode"])), norm(row["instruction"]))
    lone_new = collections.defaultdict(list)
    for o, n in pairs:
        if o is None:
            lone_new[loose(new_rows[n])].append(n)
    joined = {}
    for o, n in pairs:
        if n is None and lone_new.get(loose(old_rows[o])):
            joined[o] = lone_new[loose(old_rows[o])].pop(0)
    used = set(joined.values())
    result = []
    for o, n in pairs:
        if n is None and o in joined:
            result.append((o, joined[o]))
        elif not (o is None and n in used):
            result.append((o, n))
    return result


def classify(old, new):
    if old is None:
        return "added", []
    if new is None:
        return "removed", []
    changed = [f for f in COMPARED if norm(old[f]) != norm(new[f])]
    return ("changed" if changed else "same"), changed


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--old", required=True)
    parser.add_argument("--new", required=True)
    parser.add_argument("--out", required=True)
    args = parser.parse_args()
    old_rows, new_rows = read_csv(args.old), read_csv(args.new)
    out = []
    for old_index, new_index in pair_rows(old_rows, new_rows):
        old = old_rows[old_index] if old_index is not None else None
        new = new_rows[new_index] if new_index is not None else None
        status, fields = classify(old, new)
        base = new or old
        out.append({
            "status": status, "old_row_id": "" if old_index is None else old_index,
            "new_row_id": "" if new_index is None else new_index,
            "mnemonic": base["mnemonic"], "opcode": base["opcode"], "instruction": base["instruction"],
            "changed_fields": ";".join(fields),
            "old_values": " | ".join("%s=%s" % (f, old[f]) for f in fields) if old else "",
            "new_values": " | ".join("%s=%s" % (f, new[f]) for f in fields) if new else "",
            "old_page": old["source_page"] if old else "", "new_page": new["source_page"] if new else "",
        })
    out.sort(key=lambda r: (int(r["new_row_id"]) if r["new_row_id"] != "" else 10 ** 6 + int(r["old_row_id"])))
    with open(args.out, "w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(out[0].keys()))
        writer.writeheader()
        writer.writerows(out)
    counts = collections.Counter(r["status"] for r in out)
    print("old", len(old_rows), "new", len(new_rows), dict(counts))
    print("changed fields", dict(collections.Counter(f for r in out for f in r["changed_fields"].split(";") if f)))


if __name__ == "__main__":
    main()

"""093판에서 표나 본문이 바뀐 행의 재확인 상태를 정한다.

    python3 scripts/build_edition_review.py

대상: edition_diff의 changed 행 + Sol 인용이 093판 원문에서 새로 사라진 행(090판에서도 못 찾던 인용은 제외).
결과: data/rules/edition_093_review.csv (row_id, mnemonic, reason, missing_quotes, result, evidence)
- 재확인 완료(인용 093 원문 확인): 그 행의 Sol 인용이 093판 원문에 모두 있다. 바뀐 칸은 Sol 근거에 쓰이지 않았다.
- 재확인 필요: 인용이 093판에서 사라졌다. 093판 문장으로 다시 판단해야 한다.
- MANUAL에 적은 행은 사람이 093판 원문을 읽고 정한 결과다(근거 인용 포함).
"""

import collections
import csv
import glob
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from pipeline import quote_check  # noqa: E402

REVIEW = "out/sdm_review_093/compare/quote_check.csv"
OLD_NOT_FOUND = "out/sdm_review_2026-10-09/compare/quote_not_found_review.csv"
DIFF = "out/sdm_093/edition_diff.csv"
OUT = "data/rules/edition_093_review.csv"

# 093판 원문을 읽고 정한 행(row_id: (result, evidence)).
MANUAL = {
    989: ("재확인 완료: 093판 표 64-Bit Mode 열이 Valid로 정정되어 Description의 CPUID 조건과 충돌하지 않음",
          '093판 650쪽 표 "9F LAHF ZO Valid1 Valid"(각주 1 붙음); Description "It is valid in 64-bit mode only if '
          'CPUID.80000001H:ECX.LAHF_SAHF_64[0] = 1."'),
    2468: ("재확인 완료: 093판 표 64-Bit Mode 열이 Valid로 정정되어 Description의 CPUID 조건과 충돌하지 않음",
           '093판 1304쪽 표 "9E SAHF ZO Valid1 Valid"(각주 1 붙음); Description "It is valid in 64-bit mode only if '
           'CPUID.80000001H:ECX.LAHF_SAHF_64[0] = 1."'),
}


def read_csv(path):
    with open(path, encoding="utf-8", newline="") as handle:
        return list(csv.DictReader(handle))


def main():
    old_missing = {(r["part"], r["quote"]) for r in read_csv(OLD_NOT_FOUND)}
    lost = {(q["part"], q["ref"], q["quote"]) for q in read_csv(REVIEW)
            if q["result"] == "not_found" and (q["part"], q["quote"]) not in old_missing}
    # 같은 인용을 여러 행이 쓰므로 Sol 파일 전체에서 그 인용을 쓰는 행을 모두 찾는다.
    missing = collections.defaultdict(list)
    for path in sorted(glob.glob("out/sdm_review_093/sol_part[0-9].csv")):
        part = os.path.basename(path)[len("sol_"):-len(".csv")]
        for line in read_csv(path):
            for ref, quote in quote_check.parse_quotes(line["source_quotes"]):
                text = ref + ' "' + quote[:120] + '"'
                if (part, ref, quote) in lost and text not in missing[int(line["row_id"])]:
                    missing[int(line["row_id"])].append(text)
    rerun_path = "out/sdm_review_093/sol_rerun_093.csv"
    rerun_rows = {int(r["row_id"]) for r in read_csv(rerun_path)} if os.path.exists(rerun_path) else set()
    diff = {int(r["new_row_id"]): r for r in read_csv(DIFF) if r["new_row_id"] != ""}
    targets = sorted({rid for rid, r in diff.items() if r["status"] == "changed"} | set(missing))
    out = []
    for row_id in targets:
        row = diff[row_id]
        reasons = []
        if row["status"] == "changed":
            reasons.append("표 칸 변경: " + row["changed_fields"])
        if missing.get(row_id):
            reasons.append("Sol 인용이 093판에서 사라짐 %d개" % len(missing[row_id]))
        if row_id in rerun_rows:
            result, evidence = "재확인 완료(Sol 093 재추출)", "out/sdm_review_093/sol_rerun_093.csv"
        elif row_id in MANUAL:
            result, evidence = MANUAL[row_id]
        elif missing.get(row_id):
            result, evidence = "재확인 필요", ""
        else:
            result, evidence = "재확인 완료(인용 093 원문 확인)", "Sol 인용 전부 093판 원문에 있음(scripts/verify_sol_quotes.py)"
        out.append({"row_id": row_id, "mnemonic": row["mnemonic"], "instruction": row["instruction"],
                    "reason": "; ".join(reasons), "missing_quotes": " | ".join(missing.get(row_id, [])),
                    "result": result, "evidence": evidence})
    with open(OUT, "w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(out[0].keys()))
        writer.writeheader()
        writer.writerows(out)
    print(len(out), dict(collections.Counter(o["result"][:12] for o in out)))
    for o in out:
        if o["result"] == "재확인 필요":
            print(" ", o["row_id"], o["instruction"][:40], "|", o["reason"])


if __name__ == "__main__":
    main()

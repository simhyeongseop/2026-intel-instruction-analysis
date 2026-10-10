"""SDM 원문 재검토 결과(행 상태·1단계 추출 결함)를 최신 생성 케이스에 연결한다.

    python3 scripts/map_review_to_combos.py [--combos out/generator_audit_2026-10-10_093/combos.csv]

행 상태는 Sol 추출의 공통 기준(uniform_status)과 행 전체 조건에서 정한다(sdm_review_compare.row_status).
'원문 확정' 행에서 나온 케이스라도 고른 대표값이 원문 제약을 지키는지는 이 연결로 확인되지 않는다.
결과: review-dir/compare/combo_impact.csv(케이스마다 한 줄), rows_status.csv, combo_impact_summary.json.

사용자 결정 3(2026-10-10): 원문끼리 충돌한 행은 표 기준으로 생성하고, 예외 목록(data/rules/source_conflict_cases.csv)에
등록해 따로 대조한다. 등록된 행 중 모든 형식이 대조를 통과한 행(check_source_conflicts.py의 verdict)은 충돌을
'예외 등록·실측 확인'으로 바꾼다. 원문 없음 등 다른 상태가 남은 행은 그 상태를 쓴다.
"""

import argparse
import collections
import csv
import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from pipeline import sdm_review_compare as cmp  # noqa: E402


def read_csv(path):
    with open(path, encoding="utf-8", newline="") as handle:
        return list(csv.DictReader(handle))


def write_csv(path, rows):
    with open(path, "w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(rows[0].keys()))
        writer.writeheader()
        writer.writerows(rows)


CONFLICT_CASES = "data/rules/source_conflict_cases.csv"
CONFLICT_RESULTS = "out/sdm_review_093/conflict_tests/results.csv"
ROW_CASES = "out/sdm_review_093/conflict_tests/row_cases.csv"
ROW_PASS = ("통과", "통과(GNU 단독·도달 불가 포함)", "음성 확인")
CORRECTIONS = "data/rules/extraction_corrections.csv"
REACH_RESULTS = "out/sdm_review_093/conflict_tests/all_results.csv"
REACHED = ("통과", "통과(GNU 단독)", "도달 불가(별칭)", "도달 불가(문법)")
DEFECT_CASES = "out/sdm_review_093/conflict_tests/defect_cases.csv"


EDITION_DIFF = "out/sdm_093/edition_diff.csv"
EDITION_REVIEW = "data/rules/edition_093_review.csv"
UNREVIEWED = "미검토(093 신규)"
RECHECK = "093 변경·재확인 필요"


def edition_rows():
    """093판에서 새로 생긴 행과, 093판 원문으로 다시 판단해야 하는 행(edition_093_review.csv의 '재확인 필요')."""
    if not os.path.exists(EDITION_DIFF):
        return set(), set()
    added = {int(r["new_row_id"]) for r in read_csv(EDITION_DIFF) if r["status"] == "added"}
    recheck = set()
    if os.path.exists(EDITION_REVIEW):
        recheck = {int(r["row_id"]) for r in read_csv(EDITION_REVIEW) if r["result"] == "재확인 필요"}
    return added, recheck


def verified_defect_rows():
    """추출 결함 행 중 보정값이 PDF로 확인(또는 PDF 원문 오기로 판정)되고 기존 케이스가 대조를 통과한 행."""
    if not (os.path.exists(CORRECTIONS) and os.path.exists(DEFECT_CASES)):
        return set()
    corrections = collections.defaultdict(list)
    for entry in read_csv(CORRECTIONS):
        corrections[int(entry["row_id"])].append(not entry["check"].startswith("확인 실패"))
    passed = {int(c["row_id"]) for c in read_csv(DEFECT_CASES) if c["row_verdict"] in ROW_PASS}
    return {row_id for row_id, checks in corrections.items() if all(checks) and row_id in passed}
RESOLVED = "예외 등록·실측 확인"


def resolved_conflict_rows():
    """예외 목록에서 '표 기준 생성'으로 정했고 모든 형식이 대조를 통과한(verdict=통과) 행 -> case_id."""
    if not (os.path.exists(CONFLICT_CASES) and os.path.exists(CONFLICT_RESULTS)):
        return {}
    decided = {r["case_id"]: r for r in read_csv(CONFLICT_CASES) if r["decision"] == "표 기준 생성"}
    verdicts = collections.defaultdict(list)
    for result in read_csv(CONFLICT_RESULTS):
        verdicts[result["case_id"]].append(result["verdict"])
    resolved = {int(case["row_id"]): case_id for case_id, case in decided.items()
                if verdicts[case_id] and all(v == "통과" for v in verdicts[case_id])}
    # 남은 충돌 행 전체 대조(check_conflict_rows.py): 행 판정이 통과·음성 확인인 행.
    if os.path.exists(ROW_CASES):
        for case in read_csv(ROW_CASES):
            if case["row_verdict"] in ROW_PASS:
                resolved.setdefault(int(case["row_id"]), case["case_id"])
    # 원칙(표)과 어긋나 예외로 정한 행: 실측이 예외 쪽 원문과 맞을 때만.
    for case in read_csv(CONFLICT_CASES):
        if case["decision"].startswith("예외") and os.path.exists(ROW_CASES):
            row = next((c for c in read_csv(ROW_CASES) if c["row_id"] == case["row_id"]), None)
            if row and "exit0" in row["row_verdict"]:
                resolved[int(case["row_id"])] = case["case_id"]
    return resolved


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--review-dir", default="out/sdm_review_093")
    parser.add_argument("--combos", default="out/generator_audit_2026-10-10_093/combos.csv")
    parser.add_argument("--isa-db", default="data/db/isa_db.csv")
    args = parser.parse_args()

    isa = read_csv(args.isa_db)
    sol = cmp.load_sol(args.review_dir)
    operand_statuses = collections.defaultdict(list)
    row_condition = {}
    reasons = collections.defaultdict(list)
    for (row_id, index), line in sol.items():
        if index == 0:
            row_condition[row_id] = line["status"]
            if line["status"] in ("원문 충돌", "추출 불완전"):
                reasons[row_id].append("행 조건 " + line["status"])
        else:
            status = cmp.uniform_status(line)
            operand_statuses[row_id].append(status)
            if status != "원문 확정":
                reasons[row_id].append("%d번 %s: %s" % (index, line["table_symbol"], status))

    resolved = resolved_conflict_rows()
    defects_verified = verified_defect_rows()
    added_093, recheck_093 = edition_rows()
    sol_rows_seen = {row_id for row_id, _ in sol}  # operand_statuses는 defaultdict라 'in'으로 기록 여부를 볼 수 없다
    rows = []
    for row_id, isa_row in enumerate(isa):
        condition = row_condition.get(row_id, "")
        status = cmp.row_status(operand_statuses[row_id], condition)
        if row_id in resolved and status == "원문 충돌":
            # 등록·통과한 예외 행: 충돌(행 조건·오퍼랜드)만 해소로 보고, 원문 없음 같은 다른 상태는 그대로 둔다.
            cleared = ["원문 확정" if s == "원문 충돌" else s for s in operand_statuses[row_id]]
            remaining = cmp.row_status(cleared, "" if condition == "원문 충돌" else condition)
            status = RESOLVED if remaining == "원문 확정" else remaining
        if row_id in added_093 and row_id not in sol_rows_seen:
            status = UNREVIEWED  # Sol 기록이 없는 093 신규 행. 빈 상태 목록을 확정으로 세지 않는다.
        elif row_id in recheck_093:
            status = RECHECK
        rows.append({
            "row_id": row_id, "mnemonic": isa_row["mnemonic"], "instruction": isa_row["instruction"],
            "row_status": status, "exception_case": resolved.get(row_id, ""),
            "extraction_defects": "; ".join(cmp.extraction_defects(isa_row)),
            "extraction_status": ("" if not cmp.extraction_defects(isa_row) else
                                  "보정·대조 확인" if row_id in defects_verified else "미보정"),
            "reasons": "; ".join(reasons[row_id]),
        })

    combos = read_csv(args.combos)
    reach = {r["combo_id"]: r for r in read_csv(REACH_RESULTS)} if os.path.exists(REACH_RESULTS) else {}
    impact = []
    for combo in combos:
        row = rows[int(combo["row_id"])]
        impact.append({
            "combo_id": combo["combo_id"], "row_id": combo["row_id"], "mnemonic": combo["mnemonic"],
            "operands": combo["operands"], "test_kind": combo["test_kind"], "input_status": combo["input_status"],
            "row_status": row["row_status"], "extraction_defects": row["extraction_defects"],
            "extraction_status": row["extraction_status"],
            "trusted_spec": "예" if row["row_status"] in ("원문 확정", RESOLVED)
                            and row["extraction_status"] in ("", "보정·대조 확인") else "",
            "reach_verdict": reach.get(combo["combo_id"], {}).get("verdict", ""),
            "reach_ok": "예" if reach.get(combo["combo_id"]) and (
                reach[combo["combo_id"]]["verdict"] in REACHED or (
                    reach[combo["combo_id"]]["verdict"] == "음성 케이스"
                    and "accepted" not in (reach[combo["combo_id"]]["gnu_status"],
                                           reach[combo["combo_id"]]["clang_status"]))) else "",
        })

    out_dir = os.path.join(args.review_dir, "compare")
    write_csv(os.path.join(out_dir, "rows_status.csv"), rows)
    write_csv(os.path.join(out_dir, "combo_impact.csv"), impact)

    def count(items, *fields):
        return {" / ".join(k): v for k, v in collections.Counter(
            tuple(x[f] or "-" for f in fields) for x in items).most_common()}

    summary = {
        "combos_file": args.combos,
        "isa_rows": len(rows),
        "rows_by_status": count(rows, "row_status"),
        "rows_with_extraction_defect": sum(1 for r in rows if r["extraction_defects"]),
        "extraction_defect_types": dict(collections.Counter(
            d for r in rows for d in filter(None, r["extraction_defects"].split("; "))).most_common()),
        "combos": len(impact),
        "combos_by_row_status": count(impact, "row_status"),
        "combos_with_extraction_defect": sum(1 for c in impact if c["extraction_defects"]),
        "combos_by_extraction_status": count(impact, "extraction_status"),
        "combos_trusted_spec": sum(1 for c in impact if c["trusted_spec"]),
        "combos_reach_ok": sum(1 for c in impact if c["reach_ok"]),
        "combos_trusted_and_reached": sum(1 for c in impact if c["trusted_spec"] and c["reach_ok"]),
        "combos_by_reach_verdict": count(impact, "reach_verdict"),
        "combos_by_row_status_and_input_status": count(impact, "row_status", "input_status"),
    }
    with open(os.path.join(out_dir, "combo_impact_summary.json"), "w", encoding="utf-8") as handle:
        json.dump(summary, handle, ensure_ascii=False, indent=1)
    print(json.dumps(summary, ensure_ascii=False, indent=1))


if __name__ == "__main__":
    main()

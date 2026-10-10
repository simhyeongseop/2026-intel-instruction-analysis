"""주 에이전트 독립 판정과 Sol 원문 추출 8개 part를 대조한다.

    python3 scripts/compare_sdm_review.py [--review-dir out/sdm_review_093]

결과는 review-dir/compare/ 아래에 쓴다.
- operands.csv: 오퍼랜드 줄마다 표기·종류·폭 대조와 확인 필요 이유
- row_conditions_review.csv: Sol 행 전체 조건(0번 줄) 중 원문 충돌·없음·불완전
- summary.json: 분류별 개수, 입력 파일 sha256
"""

import argparse
import collections
import csv
import hashlib
import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from pipeline import sdm_review_compare as cmp  # noqa: E402


def sha256(path):
    with open(path, "rb") as handle:
        return hashlib.sha256(handle.read()).hexdigest()


def write_csv(path, rows, fields):
    with open(path, "w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=fields, extrasaction="ignore")
        writer.writeheader()
        writer.writerows(rows)


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--review-dir", default="out/sdm_review_093")
    args = parser.parse_args()

    main_path = os.path.join(args.review_dir, "main_symbol_spec.csv")
    main_rows = cmp.load_main(main_path)
    sol_rows = cmp.load_sol(args.review_dir)
    lines = cmp.compare_all(main_rows, sol_rows)
    # 사용자 결정 5: 고친 종류 규칙으로 다시 계산한 main(별도 파일)과의 종류 대조를 함께 남긴다.
    rulefix_path = os.path.join(args.review_dir, "main_symbol_spec_rulefix.csv")
    rulefix_rows = cmp.load_main(rulefix_path) if os.path.exists(rulefix_path) else {}
    for line in lines:
        key = (line["row_id"], line["operand_index"])
        fixed, sol = rulefix_rows.get(key), sol_rows.get(key)
        line["kind_result_rulefix"] = cmp.compare_kind(fixed, sol) if fixed and sol else ""
    row_review = cmp.row_level_review(sol_rows)

    out_dir = os.path.join(args.review_dir, "compare")
    os.makedirs(out_dir, exist_ok=True)
    write_csv(os.path.join(out_dir, "operands.csv"), lines, list(lines[0].keys()))
    row_fields = ["row_id", "part", "mnemonic", "opcode", "sdm_instruction", "status",
                  "other_constraints", "mode_64_text", "source_quotes", "note"]
    write_csv(os.path.join(out_dir, "row_conditions_review.csv"), row_review, row_fields)

    inputs = [main_path] + ([rulefix_path] if rulefix_rows else []) + sorted(
        os.path.join(args.review_dir, "sol_part%d.csv" % n) for n in range(1, 9))
    summary = {
        "inputs_sha256": {os.path.basename(p): sha256(p) for p in inputs},
        "main_rows": len({k[0] for k in main_rows}),
        "sol_rows": len({k[0] for k in sol_rows}),
        "operand_lines": len(lines),
        "needs_review_lines": sum(1 for x in lines if x["needs_review"]),
        "row_condition_review": len(row_review),
    }
    for field in ("symbol_result", "kind_result", "kind_result_rulefix", "width_result", "sol_status", "uniform_status"):
        summary[field] = dict(collections.Counter(x[field] for x in lines).most_common())
    changed = collections.Counter((x["part"], x["sol_status"], x["uniform_status"]) for x in lines
                                  if x["sol_status"] != x["uniform_status"])
    summary["status_changed_by_part"] = {"%s: %s -> %s" % k: v for k, v in sorted(changed.items())}
    reasons = collections.Counter()
    for x in lines:
        for reason in filter(None, x["review_reasons"].split("; ")):
            reasons[reason] += 1
    summary["review_reasons"] = dict(reasons.most_common())
    with open(os.path.join(out_dir, "summary.json"), "w", encoding="utf-8") as handle:
        json.dump(summary, handle, ensure_ascii=False, indent=1)
    print(json.dumps(summary, ensure_ascii=False, indent=1))


if __name__ == "__main__":
    main()

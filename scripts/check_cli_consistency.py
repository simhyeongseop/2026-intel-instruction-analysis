"""검사 CLI 판정(pipeline/sdm_judge.py)이 파이프라인 3단계와 같은지 저장된 결과로 대조한다.

    python3 scripts/check_cli_consistency.py [--sample N] [--seed S]

생성 케이스마다 저장된 도구 관측(check_results.csv의 수용 여부·바이트)을 CLI 판정에 넣는다. 다시 조립하지 않는다.
- 그 케이스를 만든 SDM 행이 CLI 후보에 들어 있는가
- 3단계가 'SDM 일치'로 본 관측을 CLI도 같은 행으로 'SDM 일치'로 보는가
다른 것이 있으면 목록을 출력하고 종료 코드 1.
"""

import argparse
import collections
import csv
import os
import random
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline import sdm_judge as J  # noqa: E402
from pipeline.operand_forms import parse_instruction  # noqa: E402

TOOLS = (("gnu_as", "as"), ("clang", "clang"))


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--results", default=os.path.join(ROOT, "out/cases/check_results.csv"))
    parser.add_argument("--sample", type=int, default=0, help="0이면 전체")
    parser.add_argument("--seed", type=int, default=1)
    args = parser.parse_args()
    with open(args.results, encoding="utf-8", newline="") as handle:
        results = list(csv.DictReader(handle))
    if args.sample:
        random.seed(args.seed)
        results = random.sample(results, min(args.sample, len(results)))
    counts, differences = collections.Counter(), []
    for case in results:
        parsed = parse_instruction(case["source"])
        if not parsed:
            counts["입력 해석 실패"] += 1
            differences.append((case["case_id"], case["source"], "입력 해석 실패"))
            continue
        cand = J.candidates(parsed)
        row = int(case["row_id"])
        if row in [c["row_id"] for c in cand["rows"]]:
            counts["생성 행이 후보에 있음"] += 1
        else:
            counts["생성 행이 후보에 없음"] += 1
            differences.append((case["case_id"], case["source"], "후보 없음", [c["row_id"] for c in cand["rows"]][:4]))
        expected = J.expected_of(cand["rows"])
        for tool, name in TOOLS:
            if case["verdict_" + name] != "SDM 일치":
                continue
            observed = {"status": case["status_" + name], "bytes": case["bytes_" + name], "relocations": None,
                        "assembly": {"stderr": case["diagnostic_" + name]}}
            judged = J.judge_assembler(tool, observed, cand, expected, J.operands_text(parsed))
            same = judged["verdict"] == "SDM 일치" and row in judged["rows"]
            counts["3단계 SDM 일치 -> CLI 같은 행 SDM 일치" if same else "3단계 SDM 일치 -> CLI 다름"] += 1
            if not same:
                differences.append((case["case_id"], case["source"], tool, judged["verdict"], judged["rows"][:3]))
    for key, value in counts.items():
        print("%s: %d" % (key, value))
    for entry in differences[:50]:
        print("  ", entry)
    return 1 if differences else 0


if __name__ == "__main__":
    raise SystemExit(main())

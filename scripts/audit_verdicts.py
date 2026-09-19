"""triage 판정이 지금도 근거대로 재현되는지 표본으로 감사한다.

판정을 새로 내리지 않는다. 기록된 관측(수용/거부, 에러 문구)을 그 자리에서 다시 관측해
어긋나는 것만 골라낸다. 어긋난 행은 "판정이 틀렸다"가 아니라 "근거가 더 이상 그대로가
아니다"라는 뜻이므로 사람이 다시 봐야 한다.

bug / tool_defect_candidate 처럼 강한 판정은 표본이 아니라 전수로 확인한다.

사용: python3 scripts/audit_verdicts.py [--sample 40]
"""

import argparse
import csv
from pathlib import Path
import random
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from pipeline.instruction_check import assemble

OUT_MD = ROOT / "out/review/verdict_audit.md"
HEADER = ".intel_syntax noprefix\n.Ltarget:\n"
STRONG_VERDICTS = {"bug"}


def read_csv(path):
    with open(path, newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))


def read_source_lines(path):
    lines = {}
    with open(path, encoding="utf-8") as f:
        for line in f:
            if "# combo_id=" not in line:
                continue
            code, tag = line.split("#", 1)
            lines[tag.split("combo_id=")[1].split()[0]] = code.strip()
    return lines


def combo_id(row):
    return row["source"].split("/")[-1]


def error_text(result):
    messages = [x for x in result["assembly"]["stderr"].splitlines() if "Error" in x]
    return messages[-1].split(":", 3)[-1].strip() if messages else ""


def recheck(row, sources):
    """기록과 현재 관측을 비교한다. (상태, 설명) 반환."""
    line = sources.get(combo_id(row))
    if line is None:
        return "재현불가", "현재 tests.s 에 이 combo 의 줄이 없다"

    result = assemble(HEADER + line + "\n")
    now = "ok" if result["status"] == "accepted" else "error"
    recorded = row["compile_result"]
    if recorded and now != recorded:
        return "어긋남", f"기록 {recorded} → 지금 {now} (`{line}`)"

    recorded_error = row["objdump_or_error"]
    if now == "error" and "Error:" in recorded_error:
        was = recorded_error.split("Error:")[-1].strip()
        current = error_text(result)
        if current and was and current.split()[0] != was.split()[0]:
            return "어긋남", f"에러 문구가 다르다: 기록 `{was[:50]}` → 지금 `{current[:50]}`"
    return "일치", ""


def pick(rows, sample, seed):
    """강한 판정은 전수, 나머지는 표본."""
    strong = [r for r in rows if r["verdict"] in STRONG_VERDICTS]
    others = [r for r in rows if r["verdict"] not in STRONG_VERDICTS]
    random.Random(seed).shuffle(others)
    return strong + others[:sample]


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--sample", type=int, default=40)
    parser.add_argument("--seed", type=int, default=20260919)
    args = parser.parse_args()

    rows = read_csv(ROOT / "out/triage.csv")
    sources = read_source_lines(ROOT / "out/tests.s")
    picked = pick(rows, args.sample, args.seed)

    counts = {"일치": 0, "어긋남": 0, "재현불가": 0}
    problems = []
    for row in picked:
        status, detail = recheck(row, sources)
        counts[status] += 1
        if status != "일치":
            problems.append((status, row, detail))

    body = ["# 판정 감사", "",
            f"확인 {len(picked)}건 (강한 판정 전수 + 표본 {args.sample}건)", "",
            f"- 근거대로 재현됨: {counts['일치']}건",
            f"- **어긋남: {counts['어긋남']}건** (사람이 다시 볼 것)",
            f"- 재현 불가: {counts['재현불가']}건", ""]
    if problems:
        body += ["## 다시 봐야 할 것", ""]
        for status, row, detail in problems:
            body += [f"### combo {combo_id(row)} · {row['mnemonic']} · {status}",
                     f"- 판정: {row['verdict']} / 분류: {row['category']}",
                     f"- 재심 상태: {row['review_status']}",
                     f"- 내용: {detail}", ""]

    OUT_MD.parent.mkdir(parents=True, exist_ok=True)
    OUT_MD.write_text("\n".join(body) + "\n", encoding="utf-8")
    for key, value in counts.items():
        print(f"{key}: {value}건")
    print(f"보고서: {OUT_MD}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

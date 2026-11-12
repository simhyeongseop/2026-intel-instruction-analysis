"""반올림·SAE 장식({rn-sae}, {sae})의 오퍼랜드 위치를 바꿔 가며 GNU as·clang의 수용과 바이트를 대조한다.

    python3 scripts/probe_rounding_position.py [--checks out/round2_20261111/cases/check_results.csv]
                                               [--out out/round2_20261111/rounding_position]

SDM 표는 장식을 한 오퍼랜드에 붙여 적는다(예: VCVTSI2SD xmm1, xmm2, r/m64{er}; VCMPPD ..., zmm3/m512/m64bcst{sae}, imm8).
도구 문법에서는 장식이 쉼표로 나뉜 별도 오퍼랜드이고, 받는 위치가 도구·문법마다 다르다(2026-10-13 ER_SAE_SUPPORT.md,
2026-11-11 HANDOFF). 3단계에서 ER/SAE 입력이 있는 행마다 대표 케이스 하나({rn-sae} 우선)를 골라, 장식을 모든 위치
(맨 앞 ~ 맨 뒤)에 넣은 Intel·AT&T 소스를 두 도구로 조립한다. 기준 바이트는 3단계 GNU as 바이트(SDM 일치 확인된 것).
출력: positions.csv(행 × 문법 × 위치 × 도구), summary.json, manifest.json. 받았는데 기준과 다른 바이트면 'accepted_other'.
"""

import argparse
import collections
import csv
import json
import os
import re
import sys
from concurrent.futures import ThreadPoolExecutor
from datetime import datetime, timezone

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline.instruction_check import assemble, environment, sha256  # noqa: E402

csv.field_size_limit(10 ** 9)
DECORATION = re.compile(r"\{(?:r[nduz]-)?sae\}")
HEADER = {"intel": ".intel_syntax noprefix\n", "att": ".att_syntax prefix\n"}
TOOLS = ("as", "clang")


def split_operands(text):
    """'vaddpd zmm0, zmm1, zmm2, {rn-sae}' -> ('vaddpd', ['zmm0', 'zmm1', 'zmm2'], '{rn-sae}', 3).
    마지막 값은 장식이 있던 위치(장식을 뺀 오퍼랜드 목록에서 그 앞 오퍼랜드 개수)."""
    mnemonic, rest = text.split(None, 1)
    parts = [p.strip() for p in re.split(r",(?![^\[]*\])", rest)]
    where = next(i for i, p in enumerate(parts) if DECORATION.fullmatch(p))
    decoration = parts.pop(where)
    return mnemonic, parts, decoration, where


def placements(text):
    """장식을 0..n 위치에 넣은 소스 목록 [(위치, 원래 위치인가, 소스)]."""
    mnemonic, parts, decoration, where = split_operands(text)
    out = []
    for index in range(len(parts) + 1):
        operands = parts[:index] + [decoration] + parts[index:]
        out.append((index, index == where, "%s %s" % (mnemonic, ", ".join(operands))))
    return out


def kind(operand):
    """오퍼랜드 종류 표시: gpr / vec / mem / imm / mask."""
    operand = operand.strip().lower().lstrip("%$")
    if re.fullmatch(r"[xyz]mm\d+(\{.*\})?", operand):
        return "vec"
    if re.fullmatch(r"k\d(\{.*\})?", operand):
        return "mask"
    if "[" in operand or "(" in operand:
        return "mem"
    if re.fullmatch(r"-?(0x)?[0-9a-f]+", operand):
        return "imm"
    return "gpr"


def shape(text):
    """장식을 뺀 Intel 오퍼랜드 종류와 장식 원래 위치. 예: 'vec,vec,gpr|@3'."""
    _, parts, _, where = split_operands(text)
    return ",".join(kind(p) for p in parts) + "|@%d" % where


def pick_cases(checks):
    """행마다 대표 케이스 하나. {rn-sae}가 있으면 그것, 없으면 {sae}. 두 도구 수용 여부와 무관하게 GNU 바이트가 있어야 한다."""
    chosen = {}
    for row in checks:
        if not DECORATION.search(row["source"]) or not row["bytes_as"] or not row.get("source_att"):
            continue
        if "[" in row["source"]:
            continue
        old = chosen.get(row["row_id"])
        better = "{rn-sae}" in row["source"] and (old is None or "{rn-sae}" not in old["source"])
        if old is None or better:
            chosen[row["row_id"]] = row
    return [chosen[k] for k in sorted(chosen, key=int)]


def run(job):
    tool, syntax, source = job
    result = assemble(HEADER[syntax] + source + "\n", tool, display_syntax=syntax)
    ok = result["observation_status"] == "accepted"
    return job, ok, result["bytes"] if ok else "", " ".join((result["assembly"].get("stderr") or "").split())[-100:]


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--checks", default=os.path.join(ROOT, "out/round2_20261111/cases/check_results.csv"))
    parser.add_argument("--out", default=os.path.join(ROOT, "out/round2_20261111/rounding_position"))
    parser.add_argument("--workers", type=int, default=8)
    args = parser.parse_args()
    with open(args.checks, encoding="utf-8", newline="") as handle:
        cases = pick_cases(csv.DictReader(handle))
    plan = []
    for case in cases:
        for syntax, text in (("intel", case["source"]), ("att", case["source_att"])):
            for index, original, source in placements(text):
                plan.append((case, syntax, index, original, source))
    jobs = sorted({(tool, syntax, source) for _, syntax, _, _, source in plan for tool in TOOLS})
    with ThreadPoolExecutor(max_workers=args.workers) as pool:
        done = {job: (ok, data, error) for job, ok, data, error in pool.map(run, jobs)}
    rows, summary = [], collections.Counter()
    for case, syntax, index, original, source in plan:
        for tool in TOOLS:
            ok, data, error = done[(tool, syntax, source)]
            outcome = ("rejected" if not ok else "same_bytes" if data == case["bytes_as"] else "accepted_other")
            rows.append({"row_id": case["row_id"], "instruction": case["instruction"], "shape": shape(case["source"]),
                         "syntax": syntax, "position": index, "generated_position": "예" if original else "",
                         "tool": tool, "source": source, "outcome": outcome, "bytes": data,
                         "reference": case["bytes_as"], "error": error})
            summary[(shape(case["source"]), syntax, index, tool, outcome)] += 1
    os.makedirs(args.out, exist_ok=True)
    with open(os.path.join(args.out, "positions.csv"), "w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(rows[0].keys()))
        writer.writeheader()
        writer.writerows(rows)
    table = collections.defaultdict(dict)
    for (shape_key, syntax, index, tool, outcome), count in sorted(summary.items()):
        table["%s %s 위치%d" % (shape_key, syntax, index)]["%s:%s" % (tool, outcome)] = count
    with open(os.path.join(args.out, "summary.json"), "w", encoding="utf-8") as handle:
        json.dump({"rows": len(cases), "assemblies": len(jobs), "table": table}, handle, ensure_ascii=False, indent=1)
    manifest = {"finished_utc": datetime.now(timezone.utc).isoformat(), "command": sys.argv,
                "input": {args.checks: sha256(args.checks)}, "environment": environment(),
                "code": {"scripts/probe_rounding_position.py": sha256(os.path.abspath(__file__))}}
    with open(os.path.join(args.out, "manifest.json"), "w", encoding="utf-8") as handle:
        json.dump(manifest, handle, ensure_ascii=False, indent=1)
    print(json.dumps({"rows": len(cases), "assemblies": len(jobs),
                      "accepted_other": sum(1 for r in rows if r["outcome"] == "accepted_other")}, ensure_ascii=False))


if __name__ == "__main__":
    main()

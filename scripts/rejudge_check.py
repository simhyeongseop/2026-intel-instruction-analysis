"""3단계 판정만 다시 계산한다(판정 규칙을 고친 뒤 지정한 니모닉의 케이스만).

    python3 scripts/rejudge_check.py --cases out/round2_20261111/cases --mnemonics MOV POP PUSH

pipeline/m3_check.py의 judge()를 그대로 쓴다. 도구는 지정한 케이스만 다시 조립한다(같은 판 도구여야 한다).
바꾸는 열: verdict_<도구>, reached_row_<도구>, diagnostic_<도구>. 조립 바이트가 저장된 값과 다르면 멈춘다
(도구·입력이 달라졌다는 뜻이라 판정만 바꾸면 안 된다).
원본은 check_results.before_rejudge_<날짜>.csv로 남기고, check_rows.csv·check_summary.json을 다시 쓴다.
5단계 결과(--roundtrip 폴더)가 있으면 roundtrip_results.csv의 sdm_verdict 열도 같은 값으로 고친다.
변경 목록과 해시는 rejudge_manifest.json.
"""

import argparse
import collections
import json
import os
import shutil
import sys
from datetime import datetime, timezone

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline import m3_check as M3  # noqa: E402
from pipeline.instruction_check import environment, sha256  # noqa: E402

FAMILY_TOOL = {"gnu": "as", "llvm": "clang"}


def rejudge(results, cases, mnemonics, asm, isa, overrides, unreachable):
    """results를 제자리에서 고친다. 바뀐 (case_id, 도구, 이전, 이후) 목록을 돌려준다."""
    by_id = {c["case_id"]: c for c in cases}
    changed = []
    for result in results:
        if result["mnemonic"] not in mnemonics:
            continue
        case = by_id[result["case_id"]]
        for tool in M3.TOOLS:
            judged = M3.judge(case, tool, asm, isa, overrides, unreachable)
            if judged["bytes"] != result["bytes_" + tool]:
                raise SystemExit("바이트가 저장값과 다름: %s %s %s != %s"
                                 % (result["case_id"], tool, judged["bytes"], result["bytes_" + tool]))
            before = (result["verdict_" + tool], result["reached_row_" + tool])
            after = (judged["verdict"], judged["reached_row"])
            if before != after:
                changed.append({"case_id": result["case_id"], "tool": tool, "instruction": result["instruction"],
                                "source": result["source"], "bytes": judged["bytes"],
                                "before": " ".join(before).strip(), "after": " ".join(after).strip()})
                result["verdict_" + tool], result["reached_row_" + tool] = after
                result["diagnostic_" + tool] = judged["diagnostic"]
    return changed


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--cases", required=True)
    parser.add_argument("--mnemonics", nargs="+", required=True)
    parser.add_argument("--roundtrip", help="5단계 결과 폴더(roundtrip_results.csv의 sdm_verdict를 맞춘다)")
    parser.add_argument("--workers", type=int, default=8)
    args = parser.parse_args()
    path = os.path.join(args.cases, "check_results.csv")
    stamp = datetime.now(timezone.utc).strftime("%Y%m%d")
    backup = os.path.join(args.cases, "check_results.before_rejudge_%s.csv" % stamp)
    if not os.path.exists(backup):
        shutil.copyfile(path, backup)
    input_hash = sha256(backup)

    cases = M3.read_csv(os.path.join(args.cases, "cases.csv"))
    results = M3.read_csv(backup)
    isa = M3.read_csv(os.path.join(ROOT, "data/db/isa_db.csv"))
    overrides = {int(r["row_id"]): r for r in M3.read_csv(M3.OVERRIDES)}
    unreachable = {int(r["row_id"]): r for r in M3.read_csv(M3.UNREACHABLE)}
    asm = M3.Assembler()
    chosen = [c for c in cases if c["mnemonic"] in args.mnemonics]
    asm.prefill([(tool, c["source"], "intel") for c in chosen for tool in M3.TOOLS], args.workers)
    changed = rejudge(results, cases, set(args.mnemonics), asm, isa, overrides, unreachable)

    M3.write_csv(path, results)
    M3.write_csv(os.path.join(args.cases, "check_rows.csv"), M3.row_summary(results))
    with open(os.path.join(args.cases, "check_summary.json"), "w", encoding="utf-8") as handle:
        json.dump(M3.summarize(results), handle, ensure_ascii=False, indent=1)

    roundtrip_changed = 0
    if args.roundtrip:
        rt_path = os.path.join(args.roundtrip, "roundtrip_results.csv")
        rt_backup = os.path.join(args.roundtrip, "roundtrip_results.before_rejudge_%s.csv" % stamp)
        if not os.path.exists(rt_backup):
            shutil.copyfile(rt_path, rt_backup)
        verdicts = {(r["case_id"], tool): r["verdict_" + tool] for r in results for tool in M3.TOOLS}
        rows = M3.read_csv(rt_backup)
        for row in rows:
            new = verdicts.get((row["case_id"], FAMILY_TOOL[row["family"]]), row["sdm_verdict"])
            if new != row["sdm_verdict"]:
                row["sdm_verdict"] = new
                roundtrip_changed += 1
        M3.write_csv(rt_path, rows)

    counts = collections.Counter("%s: %s -> %s" % (c["tool"], c["before"], c["after"]) for c in changed)
    manifest = {"finished_utc": datetime.now(timezone.utc).isoformat(), "command": sys.argv,
                "input": {backup: input_hash}, "environment": environment(),
                "code": {p: sha256(os.path.join(ROOT, p)) for p in
                         ("scripts/rejudge_check.py", "pipeline/m3_check.py", "pipeline/encoding_audit.py",
                          "pipeline/operand_size_prefix.py")},
                "mnemonics": args.mnemonics, "cases_rejudged": len(chosen), "changed": changed,
                "changed_counts": dict(counts), "roundtrip_sdm_verdict_changed": roundtrip_changed}
    with open(os.path.join(args.cases, "rejudge_manifest.json"), "w", encoding="utf-8") as handle:
        json.dump(manifest, handle, ensure_ascii=False, indent=1)
    print(json.dumps({"cases_rejudged": len(chosen), "changed_counts": dict(counts),
                      "roundtrip_sdm_verdict_changed": roundtrip_changed}, ensure_ascii=False, indent=1))


if __name__ == "__main__":
    main()

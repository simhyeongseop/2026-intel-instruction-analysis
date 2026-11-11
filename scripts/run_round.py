"""새 라운드 전체 실행(2026-11-11 설계): 2단계(경계값·시드 랜덤) -> 3단계 -> 4단계 -> 5단계를 별도 폴더에 실행한다.

    python3 scripts/run_round.py --out out/round2_20261111 [--seed 20261111] [--random 3] [--workers 8]

기존 out/cases와 out/roundtrip_*는 건드리지 않는다. 폴더에 manifest.json(명령, 코드·입력 해시, 도구 판, 시간)을 남긴다.
"""

import argparse
import json
import os
import subprocess
import sys
from datetime import datetime, timezone

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline.instruction_check import environment, sha256  # noqa: E402

CODE = ["pipeline/m2_generate.py", "pipeline/case_rules.py", "pipeline/att_syntax.py", "pipeline/m3_check.py",
        "pipeline/encoding_audit.py", "pipeline/instruction_check.py", "pipeline/m4_disasm.py",
        "pipeline/disasm_rules.py", "pipeline/m5_roundtrip.py", "pipeline/fp_controls.py",
        "pipeline/operand_size_prefix.py", "scripts/run_round.py"]
INPUTS = ["data/db/isa_db.csv", "out/sdm_review_093/compare/rows_status.csv", "data/rules/encoding_check_overrides.csv",
          "data/rules/unreachable_forms.csv", "data/rules/source_conflict_cases.csv"]


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--out", required=True)
    parser.add_argument("--seed", type=int, default=20261111)
    parser.add_argument("--random", type=int, default=3)
    parser.add_argument("--workers", type=int, default=8)
    args = parser.parse_args()
    out = os.path.abspath(args.out)
    cases = os.path.join(out, "cases")
    steps = [
        ["pipeline/m2_generate.py", "--values", "--seed", str(args.seed), "--random", str(args.random), "--out", cases],
        ["pipeline/m3_check.py", "--cases", cases, "--workers", str(args.workers)],
        ["pipeline/m4_disasm.py", "--cases", cases, "--workers", str(args.workers)],
        ["pipeline/m5_roundtrip.py", "--cases", cases, "--out", os.path.join(out, "roundtrip"),
         "--workers", str(args.workers)],
    ]
    os.makedirs(out, exist_ok=True)
    manifest = {"started_utc": datetime.now(timezone.utc).isoformat(), "command": sys.argv,
                "values": {"seed": args.seed, "random": args.random},
                "code": {p: sha256(os.path.join(ROOT, p)) for p in CODE},
                "inputs": {p: sha256(os.path.join(ROOT, p)) for p in INPUTS}, "steps": []}
    for step in steps:
        started = datetime.now(timezone.utc).isoformat()
        with open(os.path.join(out, os.path.basename(step[0]).replace(".py", ".log")), "w", encoding="utf-8") as log:
            code = subprocess.run([sys.executable] + [os.path.join(ROOT, step[0])] + step[1:], cwd=ROOT,
                                  stdout=log, stderr=subprocess.STDOUT).returncode
        manifest["steps"].append({"script": step[0], "args": step[1:], "started_utc": started,
                                  "finished_utc": datetime.now(timezone.utc).isoformat(), "returncode": code})
        if code:
            break
    manifest["finished_utc"] = datetime.now(timezone.utc).isoformat()
    manifest["completed"] = all(s["returncode"] == 0 for s in manifest["steps"]) and len(manifest["steps"]) == len(steps)
    manifest["environment"] = environment()
    with open(os.path.join(out, "manifest.json"), "w", encoding="utf-8") as handle:
        json.dump(manifest, handle, ensure_ascii=False, indent=1)
    print(json.dumps({k: manifest[k] for k in ("completed", "started_utc", "finished_utc")}, ensure_ascii=False))
    return 0 if manifest["completed"] else 1


if __name__ == "__main__":
    sys.exit(main())

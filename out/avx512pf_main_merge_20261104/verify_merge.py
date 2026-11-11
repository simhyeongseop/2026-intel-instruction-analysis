"""PR #233869 머지 커밋(7b9c6d7) llvm-mc로 AVX512PF Intel 16케이스를 다시 본다.

기대 바이트는 3단계에서 GNU as가 낸 SDM 일치 바이트(LLVM과 독립). 대조군은 LLVM 23.1.3(거부해야 함).
보는 것: Intel 소스 수용, 바이트 = 기대, Intel 출력을 다시 조립한 바이트 = 기대.
"""
import csv
import hashlib
import json
import os
import re
import subprocess
import sys

ROOT = "/mnt/c/Users/wltjq/OneDrive/assembler-testing"
HERE = os.path.join(ROOT, "out/avx512pf_main_merge_20261104")
MAIN = os.path.expanduser("~/opt/build/llvm-main-7b9c6d7/build/bin/llvm-mc")
OLD = os.path.expanduser("~/opt/llvm-23.1.3/bin/llvm-mc")


def mc(tool, text):
    run = subprocess.run([tool, "-triple", "x86_64", "-x86-asm-syntax=intel", "-output-asm-variant=1",
                          "--show-encoding"], input=text + "\n", capture_output=True, text=True, timeout=20)
    lines = [l for l in run.stdout.splitlines() if "encoding:" in l]
    if run.returncode != 0 or len(lines) != 1:
        return False, "", "", " ".join(run.stderr.split())[-200:]
    insn, enc = lines[0].split("#", 1)
    data = "".join(b[2:] for b in re.findall(r"0x[0-9a-f]{2}", enc))
    return True, insn.strip(), data, ""


def sha256(path):
    with open(path, "rb") as f:
        return hashlib.sha256(f.read()).hexdigest()


def main():
    cases = [r for r in csv.DictReader(open(os.path.join(ROOT, "out/cases/check_results.csv"), encoding="utf-8"))
             if r["mnemonic"].startswith(("VGATHERPF", "VSCATTERPF"))]
    rows = []
    for case in cases:
        ok, text, data, err = mc(MAIN, case["source"])
        again = mc(MAIN, text) if ok else (False, "", "", "")
        old = mc(OLD, case["source"])
        rows.append({"case_id": case["case_id"], "source": case["source"], "expected": case["bytes_as"],
                     "main_accepted": ok, "main_bytes": data, "main_text": text, "main_error": err,
                     "byte_match": ok and data == case["bytes_as"],
                     "reassembled_bytes": again[2], "roundtrip_match": again[0] and again[2] == case["bytes_as"],
                     "old_accepted": old[0], "old_error": old[3]})
    summary = {"cases": len(rows),
               "main_accept_and_match": sum(r["byte_match"] for r in rows),
               "main_roundtrip_match": sum(r["roundtrip_match"] for r in rows),
               "old_rejected": sum(not r["old_accepted"] for r in rows)}
    with open(os.path.join(HERE, "results.json"), "w", encoding="utf-8") as f:
        json.dump({"summary": summary, "rows": rows}, f, ensure_ascii=False, indent=1)
    version = lambda t: subprocess.run([t, "--version"], capture_output=True, text=True).stdout.split("\n")[1].strip()
    with open(os.path.join(HERE, "manifest.json"), "w", encoding="utf-8") as f:
        json.dump({"merge_commit": "7b9c6d7c19f40b8a693e5810e21d32e4a08778ec", "pr": 233869, "issue": 233852,
                   "main_llvm_mc": {"path": MAIN, "version": version(MAIN), "sha256": sha256(MAIN)},
                   "control_llvm_mc": {"path": OLD, "version": version(OLD), "sha256": sha256(OLD)},
                   "input_sha256": sha256(os.path.join(ROOT, "out/cases/check_results.csv")),
                   "script_sha256": sha256(__file__), "summary": summary}, f, ensure_ascii=False, indent=1)
    print(json.dumps(summary))
    for r in rows:
        if not (r["byte_match"] and r["roundtrip_match"] and not r["old_accepted"]):
            print("확인 필요:", r["case_id"], r["source"], r["main_text"], r["main_error"])
    return 0 if summary["main_roundtrip_match"] == summary["main_accept_and_match"] == len(rows) else 1


if __name__ == "__main__":
    sys.exit(main())

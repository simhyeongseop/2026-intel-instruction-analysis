"""Compare original and patched LLVM on the new, independently encoded cases."""

import argparse
import json
import re
import subprocess
from datetime import datetime, timezone
from pathlib import Path


def run(mc, source, intel):
    command = [str(mc), "-triple=x86_64", "-show-encoding"]
    if intel:
        command += ["-x86-asm-syntax=intel", "-output-asm-variant=1"]
    result = subprocess.run(command, input=source, text=True, capture_output=True)
    return dict(command=command, source=source, returncode=result.returncode,
                stdout=result.stdout, stderr=result.stderr)


def encodings(result):
    return re.findall(r"encoding: (\[[^\n]+\])", result["stdout"])


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--old-mc", type=Path, required=True)
    parser.add_argument("--new-mc", type=Path, required=True)
    parser.add_argument("--source", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    if args.output.exists():
        raise SystemExit("Refusing to overwrite evidence")
    tests = args.source / "llvm/test/MC/X86"
    intel = (tests / "avx512pf-64-intel.s").read_text()
    att = (tests / "avx512pf-64-att.s").read_text()
    expected = re.findall(r"// CHECK: encoding: (\[[^\n]+\])", att)
    results = {}
    for name, mc in (("original", args.old_mc), ("patched", args.new_mc)):
        results[name + "_version"] = subprocess.run(
            [str(mc), "--version"], text=True, capture_output=True
        ).stdout
        results[name + "_intel"] = run(mc, intel, True)
        results[name + "_att"] = run(mc, att, False)
    patched = results["patched_intel"]
    results["patched_roundtrip"] = run(args.new_mc, patched["stdout"], True)
    invalid = {
        "missing_mask": "vgatherpf0dps [rax+zmm0]",
        "zero_mask": "vgatherpf0dps [rax+zmm0] {k0}",
        "zeroing": "vgatherpf0dps [rax+zmm0] {k1} {z}",
        "wrong_dps_index": "vgatherpf0dps [rax+ymm0] {k1}",
        "wrong_dpd_index": "vgatherpf0dpd [rax+zmm0] {k1}",
        "wrong_memory_size": "vgatherpf0dps qword ptr [rax+zmm0] {k1}",
    }
    for name, source in invalid.items():
        results[name] = run(args.new_mc, source + "\n", True)
    checks = {
        "original_intel_rejects_32": results["original_intel"]["returncode"] != 0
            and results["original_intel"]["stderr"].count("error:") == 32,
        "original_att_bytes": encodings(results["original_att"]) == expected,
        "patched_intel_bytes": patched["returncode"] == 0
            and encodings(patched) == expected,
        "patched_att_unchanged": results["patched_att"]["returncode"] == 0
            and encodings(results["patched_att"]) == expected,
        "patched_roundtrip_bytes": results["patched_roundtrip"]["returncode"] == 0
            and encodings(results["patched_roundtrip"]) == expected,
        "invalid_operands_rejected": all(results[name]["returncode"] != 0
            for name in invalid),
    }
    report = dict(completed_utc=datetime.now(timezone.utc).isoformat(),
                  expected_case_count=len(expected), checks=checks, results=results,
                  scope="Focused assembly/encoding/round-trip; no CPU execution")
    args.output.write_text(json.dumps(report, indent=2))
    print(json.dumps(checks, indent=2))
    if not all(checks.values()):
        raise SystemExit(1)


if __name__ == "__main__":
    main()

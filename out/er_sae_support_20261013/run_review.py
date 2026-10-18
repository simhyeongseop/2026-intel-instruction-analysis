"""Fresh ER/SAE tool observations; regression against preserved baseline evidence."""
import json
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
OUT = Path(__file__).resolve().parent
sys.path.insert(0, str(REPO))
from pipeline import m2_generate as G, m3_check as C, sdm_judge as J
from pipeline import instruction_check as I


def save(name, value):
    (OUT / name).write_text(json.dumps(value, ensure_ascii=False, indent=2), encoding="utf-8")


def main():
    if (OUT / "manifest.json").exists():
        raise SystemExit("Existing snapshot; preserve it and run in a new directory.")
    baseline_files = [REPO / "out/cases" / name for name in
                      ("cases.csv", "check_results.csv", "disasm_results.csv")]
    manifest = dict(started_utc=datetime.now(timezone.utc).isoformat(), completed=False,
                    environment=I.environment(),
                    scope="Fresh assembly/disassembly for added ER/SAE cases; no CPU execution. "
                          "Baseline regression uses saved observations, not fresh baseline assembly.",
                    baseline_hashes={str(p.relative_to(REPO)): I.sha256(p) for p in baseline_files},
                    code_hashes={str(p.relative_to(REPO)): I.sha256(p)
                                 for p in (REPO / "pipeline").glob("*.py")}, steps=[])
    save("manifest.json", manifest)

    def step(name, args):
        print("START " + name, flush=True)
        result = subprocess.run([sys.executable] + args, cwd=REPO, capture_output=True,
                                text=True, encoding="utf-8", errors="replace")
        (OUT / (name + ".stdout.txt")).write_text(result.stdout, encoding="utf-8")
        (OUT / (name + ".stderr.txt")).write_text(result.stderr, encoding="utf-8")
        manifest["steps"].append(dict(name=name, command=[sys.executable] + args,
                                      returncode=result.returncode))
        save("manifest.json", manifest)
        print("DONE " + name + " rc=" + str(result.returncode), flush=True)
        if result.returncode:
            print(result.stdout[-3000:] + result.stderr[-3000:], flush=True)
            raise SystemExit(result.returncode)

    step("tests", ["-m", "unittest", "discover", "-s", "tests", "-p", "test_*.py", "-q"])
    baseline = G.read_csv(baseline_files[0])
    generated = G.generate(G.load_rows())
    G.write_outputs(generated, str(OUT / "generated"))
    old = {c["case_id"]: c for c in baseline}
    retained = {c["case_id"]: c for c in generated if c["case_id"] in old}
    changes = [{"case_id": key, "fields": [field for field in before
               if str(before[field]) != str(retained[key][field])]}
               for key, before in old.items() if key not in retained or
               any(str(before[field]) != str(retained[key][field]) for field in before)]
    additions = [c for c in generated if c["case_id"] not in old]
    G.write_outputs(additions, str(OUT / "added"))
    isa = C.read_csv(G.ISA_DB)
    overrides = {int(r["row_id"]): r for r in C.read_csv(C.OVERRIDES)}
    lost = []
    matched = 0
    for record in C.read_csv(baseline_files[1]):
        case = old[record["case_id"]]
        row_id = int(case["row_id"])
        for tool in C.TOOLS:
            if record["verdict_" + tool] not in ("SDM 일치", "SDM 일치(강제 접두어)"):
                continue
            status = C.encoding(record["bytes_" + tool], C.check_row(isa[row_id], case),
                                False, overrides.get(row_id))
            matched += status == "fields_match"
            if status != "fields_match":
                lost.append(dict(case_id=case["case_id"], tool=tool, status=status))
    regression = dict(baseline_cases=len(baseline), generated_cases=len(generated),
                      added_cases=len(additions), added_rows=len({c["row_id"] for c in additions}),
                      changed_existing_cases=changes, retained_encoding_matches=matched,
                      lost_encoding_matches=lost)
    save("baseline_regression.json", regression)
    if changes or lost:
        raise SystemExit("Baseline changed; inspect baseline_regression.json")
    print(json.dumps(regression, ensure_ascii=False), flush=True)
    step("baseline_cli", ["scripts/check_cli_consistency.py"])
    step("added_check", ["pipeline/m3_check.py", "--cases", str(OUT / "added"), "--workers", "12"])
    step("added_disasm", ["pipeline/m4_disasm.py", "--cases", str(OUT / "added"), "--workers", "12"])
    step("added_cli", ["scripts/check_cli_consistency.py", "--results", str(OUT / "added/check_results.csv")])

    sources = [
        "vaddpd zmm0, zmm1, zmm2, {rn-sae}",
        "vaddpd zmm0, zmm1, zmm2, {rd-sae}",
        "vcomisd xmm0, xmm1, {sae}",
        "vcmppd k1, zmm0, zmm1, {sae}, 0x12",
        "vcvtps2ph ymm0, zmm1, {sae}, 0x12",
        "vaddpd ymm0, ymm1, ymm2, {rn-sae}",
        "vaddpd zmm0, zmm1, zmmword ptr [rax], {rn-sae}",
        "vaddpd zmm0, zmm1, zmm2, {sae}",
        "vcomisd xmm0, qword ptr [rax], {sae}",
        "vaddpd zmm0, {rd-sae}, zmm1, zmm2",
        "vaddpd zmm0, zmm1, zmm2, {rd-sae}, {rn-sae}",
    ]
    save("focused_cli.json", [I.check_instruction(source, isa) for source in sources])
    if any(I.sha256(path) != manifest["baseline_hashes"][str(path.relative_to(REPO))]
           for path in baseline_files):
        raise SystemExit("Preserved baseline evidence changed")
    manifest.update(completed=True, finished_utc=datetime.now(timezone.utc).isoformat(),
                    output_hashes={str(p.relative_to(OUT)): I.sha256(p) for p in OUT.rglob("*")
                                   if p.is_file() and p.name != "manifest.json"})
    save("manifest.json", manifest)
    print("COMPLETE " + str(OUT), flush=True)


if __name__ == "__main__":
    main()

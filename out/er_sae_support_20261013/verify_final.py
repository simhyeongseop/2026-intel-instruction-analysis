"""Verify final code against preserved observations; no fresh assembly or CPU run."""
import json
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path

OUT = Path(__file__).resolve().parent
REPO = OUT.parents[1]
sys.path.insert(0, str(REPO))
from pipeline import m2_generate as G, m3_check as C, m4_disasm as D
from pipeline import instruction_check as I


def main():
    target = OUT / "final_validation_v2"
    target.mkdir(exist_ok=True)
    path = target / "manifest.json"
    if path.exists():
        raise SystemExit("Preserve existing final validation")
    manifest = dict(started_utc=datetime.now(timezone.utc).isoformat(), completed=False,
                    scope="Final code: full tests, CLI consistency, saved byte/text regression. "
                          "Fresh tool observations are in the parent snapshot; no CPU execution.",
                    code_hashes={str(p.relative_to(REPO)): I.sha256(p)
                                 for p in (REPO / "pipeline").glob("*.py")}, steps=[])
    inputs = [REPO / "out/cases" / name for name in
              ("cases.csv", "check_results.csv", "disasm_results.csv")]
    inputs += [OUT / "added" / name for name in
               ("cases.csv", "check_results.csv", "disasm_results.csv")]
    manifest["input_hashes"] = {str(p.relative_to(REPO)): I.sha256(p) for p in inputs}

    def save():
        path.write_text(json.dumps(manifest, ensure_ascii=False, indent=2), encoding="utf-8")

    save()
    jobs = [
        ("tests", ["-m", "unittest", "discover", "-s", "tests", "-p", "test_*.py", "-q"]),
        ("baseline_cli", ["scripts/check_cli_consistency.py"]),
        ("added_cli", ["scripts/check_cli_consistency.py", "--results", str(OUT / "added/check_results.csv")]),
    ]
    for name, args in jobs:
        print("START " + name, flush=True)
        run = subprocess.run([sys.executable] + args, cwd=REPO, text=True,
                             capture_output=True, encoding="utf-8")
        (target / (name + ".stdout.txt")).write_text(run.stdout, encoding="utf-8")
        (target / (name + ".stderr.txt")).write_text(run.stderr, encoding="utf-8")
        manifest["steps"].append(dict(name=name, returncode=run.returncode))
        save()
        if run.returncode:
            print(run.stdout + run.stderr)
            raise SystemExit(run.returncode)
        print("DONE " + name, flush=True)

    isa = C.read_csv(G.ISA_DB)
    overrides = {int(row["row_id"]): row for row in C.read_csv(C.OVERRIDES)}
    by_opcode, reversible = D.prepare(isa)
    checks, errors = {}, []
    for label, folder in (("baseline", REPO / "out/cases"), ("added", OUT / "added")):
        cases = {c["case_id"]: c for c in C.read_csv(folder / "cases.csv")}
        counts = dict(encoding_matches=0, disasm_matches=0)
        for record in C.read_csv(folder / "check_results.csv"):
            case = cases[record["case_id"]]
            row_id = int(case["row_id"])
            for tool in C.TOOLS:
                if record["verdict_" + tool] not in ("SDM 일치", "SDM 일치(강제 접두어)"):
                    continue
                status = C.encoding(record["bytes_" + tool], C.check_row(isa[row_id], case),
                                    False, overrides.get(row_id))
                counts["encoding_matches"] += status == "fields_match"
                if status != "fields_match":
                    errors.append((label, case["case_id"], tool, status))
        for record in C.read_csv(folder / "disasm_results.csv"):
            case = cases[record["case_id"]]
            row_id = int(case["row_id"])
            row = isa[row_id]
            for tool in D.DISASSEMBLERS:
                verdict = record["verdict_" + tool]
                if verdict not in ("SDM 일치", "SDM 일치(reg 칸 레지스터 폭 표기)"):
                    continue
                text = record["text_" + tool]
                # m4.judge의 FWAIT + FN* 결합과 같은 원문 규칙으로 저장 텍스트를 읽는다.
                if row["opcode"].startswith("9B ") and text.startswith("wait | fn"):
                    text = text.split(" | ", 1)[1].replace("fn", "f", 1)
                _, main, rest = D.split_mnemonic(text)
                names, _ = D.expected_names(case, row, by_opcode)
                last = D.source_operands(case)[-1] if D.source_operands(case) else ""
                value = D.D.number(last)
                folded = main not in names and value is not None and any(
                    D.D.pseudo_op(name, value) == main for name in names)
                same = D.compare_operands(case, rest, folded, row_id in reversible, row,
                                          reg_width_free="reg 칸" in verdict)
                counts["disasm_matches"] += same
                if not same:
                    errors.append((label, case["case_id"], tool, "disasm lost"))
        checks[label] = counts
    # 거부 40개는 LLVM이 출력한 RC-before-GPR 철자를 실제로 다시 검사한다.
    refused = {r["case_id"] for r in C.read_csv(OUT / "added/check_results.csv")
               if r["verdict_clang"] == "거부"}
    layouts = [I.check_instruction(r["text_llvm"].strip(), isa)
               for r in C.read_csv(OUT / "added/disasm_results.csv") if r["case_id"] in refused]
    (OUT / "layout_observations.json").write_text(
        json.dumps(layouts, ensure_ascii=False, indent=2), encoding="utf-8")
    layout_matches = sum(r["sdm_judgment"]["assemblers"]["clang"]["verdict"] == "SDM 일치"
                         for r in layouts)
    manifest["llvm_before_gpr_layout_matches"] = layout_matches
    if layout_matches != 40:
        errors.append(("layout", "LLVM", layout_matches))
    manifest["regression"] = checks
    manifest["errors"] = errors
    if errors:
        save()
        raise SystemExit("Regression: " + str(errors[:10]))
    manifest.update(completed=True, finished_utc=datetime.now(timezone.utc).isoformat())
    save()
    print(json.dumps(checks), flush=True)
    print("COMPLETE final validation", flush=True)


if __name__ == "__main__":
    main()

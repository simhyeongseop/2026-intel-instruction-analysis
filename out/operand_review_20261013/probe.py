"""Record assembly observations only; no CPU execution or SDM verdict inferred."""
import importlib.util
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent
REPO = ROOT.parents[1]
sys.path.insert(0, str(REPO))
from pipeline.operand_forms import parse_instruction
from pipeline.sdm_judge import candidates


def main():
    spec = importlib.util.spec_from_file_location(
        "previous_probe", REPO / "out/avx512pf_review_20261012/reproduce.py")
    probe = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(probe)
    probe.ROOT = ROOT / "avx512pf"
    probe.ROOT.mkdir(exist_ok=True)
    probe.main()
    probe.OBSERVATIONS.clear()
    sources = [
        "vaddpd zmm0, zmm1, zmm2",
        *[f"vaddpd zmm0, zmm1, zmm2, {{{mode}-sae}}"
          for mode in ("rn", "rd", "ru", "rz")],
        "vaddpd ymm0, ymm1, ymm2, {rn-sae}",
        "vaddpd zmm0, zmm1, zmmword ptr [rax], {rn-sae}",
        "vaddpd zmm0, zmm1, zmm2, {sae}",
        "vcomisd xmm0, xmm1, {sae}",
        "vcomisd xmm0, qword ptr [rax], {sae}",
    ]
    rows = []
    for index, source in enumerate(sources):
        llvm = probe.assemble(f"rounding/{index}/llvm", source, intel=True)
        obj = ROOT / f"rounding_{index}.o"
        gas = probe.run(f"rounding/{index}/gnu", [str(probe.BIN / "as"),
                        "--64", "-o", str(obj)],
                        ".intel_syntax noprefix\n.text\n" + source + "\n")
        if gas["returncode"] == 0:
            probe.run(f"rounding/{index}/objdump", [str(probe.BIN / "objdump"),
                      "-d", "-Mintel", str(obj)])
        rows.append(dict(source=source, llvm_rc=llvm["returncode"],
                         gnu_rc=gas["returncode"], llvm_hex=probe.encoding(llvm).hex(),
                         cli_candidates=candidates(parse_instruction(source))))
    (ROOT / "rounding_observations.json").write_text(
        json.dumps(probe.OBSERVATIONS, indent=2), encoding="utf-8")
    (ROOT / "rounding_summary.json").write_text(
        json.dumps(rows, indent=2, ensure_ascii=False), encoding="utf-8")
    pages = []
    for line in (REPO / "out/manual_index_vol1/pages.jsonl").read_text(encoding="utf-8").splitlines():
        page = json.loads(line)
        if page["file_page"] in (394,):
            pages.append(page)
    (ROOT / "sdm_mask_text.json").write_text(
        json.dumps(pages, indent=2, ensure_ascii=False), encoding="utf-8")
    print(json.dumps(rows, ensure_ascii=False))


if __name__ == "__main__":
    main()

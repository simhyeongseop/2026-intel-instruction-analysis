"""Update the existing disassembler expectation found by upstream CI."""

import json
import re
import subprocess
from pathlib import Path


ROOT = Path.home() / "opt/build/llvm-avx512pf-fix-20261020"
SOURCE = ROOT / "source"
OUTPUT = Path(__file__).resolve().parent
TEST = "llvm/test/MC/Disassembler/X86/apx/evex-format.txt"


def main():
    path = SOURCE / TEST
    before = "# INTEL: vscatterpf0dps\t{k1}, dword ptr [r16 + zmm0]"
    after = "# INTEL: vscatterpf0dps\tdword ptr [r16 + zmm0] {k1}"
    text = path.read_text()
    if text.count(before) == 1:
        path.write_text(text.replace(before, after))
    elif text.count(after) != 1:
        raise ValueError("Expected exactly one outdated disassembler check")
    assembly_path = SOURCE / "llvm/test/MC/X86/apx/evex-format-intel.s"
    old_example = """## AsmParser is buggy for this KNC instruction
# C;HECK: vscatterpf0dps\t{k1}, zmmword ptr [r16 + zmm0]
# C;HECK: encoding: [0x62,0xfa,0x7d,0x49,0xc6,0x2c,0x00]
#         vscatterpf0dps\t{k1}, zmmword ptr [r16 + zmm0]"""
    new_example = """# CHECK: vscatterpf0dps\tdword ptr [r16 + zmm0] {k1}
# CHECK: encoding: [0x62,0xfa,0x7d,0x49,0xc6,0x2c,0x00]
         vscatterpf0dps\tdword ptr [r16 + zmm0] {k1}"""
    assembly = assembly_path.read_text()
    if assembly.count(old_example) == 1:
        assembly_path.write_text(assembly.replace(old_example, new_example))
    elif assembly.count(new_example) != 1:
        raise ValueError("Expected the disabled APX prefetch example")
    scan = subprocess.run(
        ["git", "-C", str(SOURCE), "grep", "-n", "-e", "vgatherpf",
         "-e", "vscatterpf", "--", "llvm/test"],
        text=True, capture_output=True, check=True,
    )
    (OUTPUT / "prefetch_test_references.txt").write_text(scan.stdout)
    remaining = [line for line in scan.stdout.splitlines()
                 if re.search(r"v(?:gather|scatter)pf\w+\s+\{k\d\},", line)]
    if remaining:
        raise ValueError(remaining)
    names = [
        "avx512pf-64-intel.s", "avx512pf-64-att.s", "avx512pf-intel-errors.s",
        "avx512-intel.s", "avx512-att.s", "avx512-intel-errors.s",
        "avx512-att-errors.s", "gather.s", "apx/evex-format-intel.s",
    ]
    tests = [SOURCE / "llvm/test/MC/X86" / name for name in names]
    tests.append(path)
    command = [str(ROOT / "build/bin/llvm-lit"), "-v", "-o",
               str(OUTPUT / "lit_results.json"), *map(str, tests)]
    result = subprocess.run(command, text=True, capture_output=True)
    (OUTPUT / "lit_results.log").write_text(result.stdout + result.stderr)
    print(result.stdout)
    if result.returncode:
        raise SystemExit(result.returncode)
    patch = subprocess.run(["git", "-C", str(SOURCE), "diff", "--", TEST,
                            "llvm/test/MC/X86/apx/evex-format-intel.s"],
                           text=True, capture_output=True, check=True)
    (OUTPUT / "expected_output_update.patch").write_text(patch.stdout)
    manifest = dict(scope="Existing disassembler expectation and disabled assembly case; targeted tests only",
                    old_head="b836e813e18e475bb9472762b994a97675654103",
                    linux_job="https://github.com/llvm/llvm-project/actions/runs/39442994517/job/118714069723",
                    windows_job="https://github.com/llvm/llvm-project/actions/runs/39442994517/job/118714069500",
                    lit_tests=10, lit_returncode=result.returncode,
                    remaining_old_mask_expectations=remaining)
    (OUTPUT / "manifest.json").write_text(json.dumps(manifest, indent=2))


if __name__ == "__main__":
    main()

"""Focused assembly/disassembly probe; never executes generated machine code."""

import csv
import hashlib
import json
import re
import subprocess
from datetime import datetime, timezone
from pathlib import Path


ROOT = Path(__file__).resolve().parent
MC = str(Path.home() / "opt/llvm-23.1.3/bin/llvm-mc")
BIN = Path.home() / "opt/binutils-2.47/bin"
OBSERVATIONS = []


def run(label, argv, source=""):
    result = subprocess.run(argv, input=source, text=True, capture_output=True)
    record = dict(label=label, argv=argv, stdin=source,
                  returncode=result.returncode, stdout=result.stdout,
                  stderr=result.stderr)
    OBSERVATIONS.append(record)
    return record


def assemble(label, source, intel=False, features=False):
    argv = [MC, "-triple=x86_64", "-show-encoding"]
    if features:
        argv.append("-mattr=+avx512f,+avx512pf")
    prefix = ".intel_syntax noprefix\n" if intel else ""
    return run(label, argv, prefix + source + "\n")


def encoding(result):
    match = re.search(r"encoding: \[([^]]+)\]", result["stdout"])
    return bytes(int(part.strip(), 16) for part in match[1].split(",")) if match else b""


def main():
    # An existing run is evidence: do not overwrite it on a second invocation.
    if (ROOT / "observations.json").exists():
        raise SystemExit("Existing snapshot; use a new directory for another run.")
    started = datetime.now(timezone.utc).isoformat()
    versions = [run("version", [tool, "--version"])
                for tool in (MC, str(BIN / "as"), str(BIN / "objdump"))]
    rows = []
    for operation in ("gather", "scatter"):
        for hint in (0, 1):
            for suffix in ("dps", "qps", "dpd", "qpd"):
                mnemonic = f"v{operation}pf{hint}{suffix}"
                index = "ymm0" if suffix == "dpd" else "zmm0"
                size = "qword" if suffix.endswith("d") else "dword"
                plain = f"{mnemonic} [rax+{index}] {{k1}}"
                sized = f"{mnemonic} {size} ptr [rax+{index}] {{k1}}"
                att = assemble(mnemonic + "/att", f"{mnemonic} (%rax,%{index}) {{%k1}}")
                raw = encoding(att)
                intel = assemble(mnemonic + "/intel", plain, intel=True)
                intel_sized = assemble(mnemonic + "/intel_sized", sized, intel=True)
                enabled = assemble(mnemonic + "/intel_features", sized, intel=True, features=True)
                disasm = run(mnemonic + "/disasm", [MC, "-triple=x86_64", "--disassemble",
                             "--output-asm-variant=1"], ",".join(f"0x{x:02x}" for x in raw) + "\n")
                printed = next((line.strip() for line in disasm["stdout"].splitlines()
                                if line.strip().startswith(mnemonic)), "")
                roundtrip = assemble(mnemonic + "/roundtrip", printed, intel=True)
                obj = ROOT / (mnemonic + ".o")
                binary = ROOT / (mnemonic + ".bin")
                gas = run(mnemonic + "/gnu", [str(BIN / "as"), "--64", "-o", str(obj)],
                          ".intel_syntax noprefix\n.text\n" + sized + "\n")
                copied = run(mnemonic + "/objcopy", [str(BIN / "objcopy"), "-O", "binary",
                             "--only-section=.text", str(obj), str(binary)])
                run(mnemonic + "/objdump", [str(BIN / "objdump"), "-d", "-Mintel", str(obj)])
                gnu_bytes = binary.read_bytes() if copied["returncode"] == 0 else b""
                rows.append(dict(mnemonic=mnemonic, index=index,
                                 att_rc=att["returncode"], intel_rc=intel["returncode"],
                                 intel_sized_rc=intel_sized["returncode"],
                                 intel_features_rc=enabled["returncode"],
                                 att_hex=raw.hex(), intel_disasm=printed,
                                 roundtrip_rc=roundtrip["returncode"],
                                 gnu_rc=gas["returncode"], gnu_hex=gnu_bytes.hex(),
                                 byte_agreement=bool(raw) and raw == gnu_bytes))
    for number, operand in enumerate(("dword ptr [rax+zmm0] {k1}",
                                      "zmmword ptr [rax+zmm0] {k1}",
                                      "dword ptr [rax+zmm0*4] {k1}", "[rax+zmm0]{k1}")):
        assemble(f"spelling/{number}", "vgatherpf0dps " + operand, intel=True)
    for source in ("vgatherdps zmm0 {k1}, [rax+zmm1]",
                   "vscatterdps [rax+zmm1] {k1}, zmm0"):
        assemble("control/" + source.split()[0], source, intel=True)
    manifest = dict(started_utc=started, completed_utc=datetime.now(timezone.utc).isoformat(),
                    scope="16 AVX512PF mnemonics, 64-bit assembly/disassembly only; no CPU execution or patched build",
                    versions=versions, llvm_mc_sha256=hashlib.sha256(Path(MC).read_bytes()).hexdigest(),
                    observations="observations.json", summary="summary.csv")
    (ROOT / "observations.json").write_text(json.dumps(OBSERVATIONS, indent=2), encoding="utf-8")
    (ROOT / "manifest.json").write_text(json.dumps(manifest, indent=2), encoding="utf-8")
    with (ROOT / "summary.csv").open("w", encoding="utf-8", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)
    print(json.dumps(rows, indent=2))


if __name__ == "__main__":
    main()

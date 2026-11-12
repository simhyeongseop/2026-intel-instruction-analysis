"""Prepare a focused LLVM source change and tests; preserve the upstream bytes."""

import re
import sys
from pathlib import Path


def intel_case(source):
    match = re.fullmatch(
        r"(v\w+)\s+([0-9]*)(\(%(r\w+),%([yz]mm\d+)(?:,(\d+))?\))\{%k(\d)\}",
        source,
    )
    if not match:
        raise ValueError(source)
    mnemonic, displacement, _, base, index, scale, mask = match.groups()
    size = "qword" if mnemonic.endswith("pd") else "dword"
    address = f"{base} + {scale + '*' if scale else ''}{index}"
    if displacement:
        address += f" + {displacement}"
    operand = f"[{address}] {{k{mask}}}"
    printed = f"{mnemonic} {size} ptr {operand}"
    # Check both unsized and explicitly sized operands for every mnemonic.
    typed = f"{size} ptr " if displacement else ""
    return f"{mnemonic} {typed}{operand}", printed


def write_tests(root):
    directory = root / "llvm/test/MC/X86"
    original = (directory / "avx512pf-64-att.s").read_text()
    cases = re.findall(
        r"// CHECK: encoding: (\[[^\n]+\])\n([^/\n][^\n]+)", original
    )
    if len(cases) != 32:
        raise ValueError(f"Expected 32 upstream cases, found {len(cases)}")
    header = """// RUN: llvm-mc -triple x86_64 -x86-asm-syntax=intel -output-asm-variant=1 --show-encoding %s | FileCheck %s --check-prefixes=CHECK,ENCODING
// RUN: llvm-mc -triple x86_64 -x86-asm-syntax=intel -output-asm-variant=1 --show-encoding %s | llvm-mc -triple x86_64 -x86-asm-syntax=intel -output-asm-variant=1 --show-encoding | FileCheck %s --check-prefixes=CHECK,ENCODING
// RUN: llvm-mc -triple x86_64 -x86-asm-syntax=intel -filetype=obj %s | llvm-objdump -d --no-show-raw-insn --no-print-imm-hex --x86-asm-syntax=intel - | FileCheck %s

// Cover every gather/scatter prefetch mnemonic with unsized and sized memory,
// high VSIB registers, k1-k7, scaled indices, and compressed displacement.
// Expected bytes are taken from avx512pf-64-att.s.
"""
    blocks = [header]
    for encoding, source in cases:
        assembly, printed = intel_case(source)
        blocks.append(
            f"\n// CHECK: {printed}\n// ENCODING-SAME: encoding: {encoding}\n{assembly}\n"
        )
    (directory / "avx512pf-64-intel.s").write_text("".join(blocks))


def write_error_tests(root):
    cases = [
        ("vgatherpf0dps [rax+zmm0]", "invalid operand for instruction"),
        ("vgatherpf0dps [rax+zmm0] {k0}", "Register k0 can't be used as write mask"),
        ("vgatherpf0dps [rax+zmm0] {k1} {z}", "invalid operand for instruction"),
        ("vgatherpf0dps [rax+ymm0] {k1}", "invalid operand for instruction"),
        ("vgatherpf0dpd [rax+zmm0] {k1}", "invalid operand for instruction"),
        ("vgatherpf0dps qword ptr [rax+zmm0] {k1}", "invalid operand for instruction"),
    ]
    text = "// RUN: not llvm-mc -triple x86_64 -x86-asm-syntax=intel %s -o /dev/null 2>&1 | FileCheck %s\n"
    text += "\n// Masks remain mandatory and nonzero; zeroing is not supported.\n"
    text += "// The VSIB register width and explicit memory size must still match.\n"
    for source, message in cases:
        text += "\n// CHECK: :[[@LINE+2]]:{{[0-9]+}}: error: " + message + "\n"
        text += f"// CHECK-NEXT: {source}\n{source}\n"
    (root / "llvm/test/MC/X86/avx512pf-intel-errors.s").write_text(text)


def main():
    root = Path(sys.argv[1])
    definition = root / "llvm/lib/Target/X86/X86InstrAVX512.td"
    text = definition.read_text()
    before = r'!strconcat(OpcodeStr, "\t{$src {${mask}}|{${mask}}, $src}")'
    after = r'!strconcat(OpcodeStr, "\t{$src {${mask}}|$src {${mask}}}")'
    first_attempt = r'!strconcat(OpcodeStr, "\t$src {${mask}}")'
    comment_suggestion = r'!strconcat(OpcodeStr, "\t$src {$mask}")'
    if text.count(before) == 1:
        definition.write_text(text.replace(before, after))
    elif text.count(first_attempt) == 1:
        definition.write_text(text.replace(first_attempt, after))
    elif text.count(comment_suggestion) == 1:
        definition.write_text(text.replace(comment_suggestion, after))
    elif text.count(after) != 1:
        raise ValueError("Expected exactly one prefetch assembly definition")
    write_tests(root)
    write_error_tests(root)


if __name__ == "__main__":
    main()

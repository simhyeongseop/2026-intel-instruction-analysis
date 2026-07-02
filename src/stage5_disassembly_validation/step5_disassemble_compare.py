"""
Step 5: objdump disassembly comparison

Stage 4 checks whether generated Intel-syntax assembly is accepted by
assemblers/compilers. Stage 5 checks what the accepted source was actually
assembled into by disassembling the object file and comparing it with the
original source.

Default pipeline:
  data/stage4_tests/test_all_instructions.s
    -> as --64 -mintel64
    -> data/stage5_disassembly/test_all_stage5.o
    -> objdump -d -M intel
    -> compare source instructions with disassembled instructions

Outputs:
  data/stage5_disassembly/step5_objdump_intel.txt
  data/stage5_disassembly/step5_disasm_compare.csv
  data/stage5_disassembly/step5_disasm_report.md
"""

from __future__ import annotations

import argparse
import csv
import difflib
import platform
import re
import shlex
import subprocess
from dataclasses import dataclass
from pathlib import Path


BASE = Path(__file__).parent.parent.parent
STAGE4_DIR = BASE / "data" / "stage4_tests"
STAGE5_DIR = BASE / "data" / "stage5_disassembly"

DEFAULT_SRC_ASM = STAGE4_DIR / "test_all_instructions.s"
DEFAULT_OBJECT = STAGE5_DIR / "test_all_stage5.o"
DEFAULT_OBJDUMP = STAGE5_DIR / "step5_objdump_intel.txt"
DEFAULT_COMPARE_CSV = STAGE5_DIR / "step5_disasm_compare.csv"
DEFAULT_REPORT = STAGE5_DIR / "step5_disasm_report.md"

IS_WINDOWS = platform.system() == "Windows"


@dataclass(frozen=True)
class SourceInstruction:
    index: int
    line_num: int
    form: str
    text: str


@dataclass(frozen=True)
class DisassembledInstruction:
    index: int
    address: str
    opcode_bytes: str
    text: str


def fallback_wsl_path(path: Path) -> str:
    """Fallback used by the existing Stage 4 scripts."""
    s = str(path.resolve()).replace("\\", "/")
    if len(s) >= 2 and s[1] == ":":
        drive = s[0].lower()
        return f"/mnt/host/{drive}{s[2:]}"
    return s


def to_wsl_path(path: Path) -> str:
    """Convert a Windows path to a WSL path when running on Windows."""
    if not IS_WINDOWS:
        return str(path)

    try:
        result = subprocess.run(
            ["wsl", "wslpath", "-a", str(path.resolve())],
            capture_output=True,
            text=True,
            encoding="utf-8",
            errors="replace",
        )
    except FileNotFoundError:
        return fallback_wsl_path(path)

    converted = result.stdout.strip()
    if result.returncode == 0 and converted:
        return converted
    return fallback_wsl_path(path)


def run_native_or_wsl(args: list[str]) -> tuple[str, str, int]:
    """Run a command directly on Unix-like OSes or through WSL on Windows."""
    if IS_WINDOWS:
        command = ["wsl", *args]
    else:
        command = args

    try:
        result = subprocess.run(
            command,
            capture_output=True,
            text=True,
            encoding="utf-8",
            errors="replace",
        )
    except FileNotFoundError as exc:
        missing = "wsl" if IS_WINDOWS else args[0]
        raise RuntimeError(f"Required command not found: {missing}") from exc

    return result.stdout, result.stderr, result.returncode


def build_object_file(src_asm: Path, object_path: Path) -> None:
    """Assemble the Stage 4 source with GNU as in Intel64 mode."""
    object_path.parent.mkdir(parents=True, exist_ok=True)

    src_arg = to_wsl_path(src_asm) if IS_WINDOWS else str(src_asm)
    out_arg = to_wsl_path(object_path) if IS_WINDOWS else str(object_path)
    stdout, stderr, rc = run_native_or_wsl(
        ["as", "--64", "-mintel64", src_arg, "-o", out_arg]
    )

    if rc != 0:
        output = (stdout + stderr).strip()
        raise RuntimeError(
            "Failed to assemble Stage 4 source with GNU as.\n"
            f"command: as --64 -mintel64 {shlex.quote(src_arg)} -o {shlex.quote(out_arg)}\n"
            f"returncode: {rc}\n{output}"
        )


def run_objdump(object_path: Path) -> str:
    """Run objdump in Intel syntax mode and return raw output."""
    object_arg = to_wsl_path(object_path) if IS_WINDOWS else str(object_path)
    stdout, stderr, rc = run_native_or_wsl(["objdump", "-d", "-M", "intel", object_arg])

    if rc != 0:
        output = (stdout + stderr).strip()
        raise RuntimeError(
            "Failed to disassemble object file with objdump.\n"
            f"command: objdump -d -M intel {shlex.quote(object_arg)}\n"
            f"returncode: {rc}\n{output}"
        )

    return stdout


def parse_source_instructions(src_asm: Path) -> list[SourceInstruction]:
    """
    Extract only executable instruction lines from the generated Stage 4 source.

    Form comments such as "// === ADC r64, imm32 ===" are preserved as metadata
    so suspicious rows can be traced back to the SDM-derived instruction form.
    """
    rows: list[SourceInstruction] = []
    current_form = ""
    pending_prefix: tuple[int, str, str] | None = None
    prefix_only = {"lock", "rep", "repe", "repz", "repne", "repnz"}

    for line_num, raw_line in enumerate(src_asm.read_text(encoding="utf-8").splitlines(), 1):
        line = raw_line.strip()
        if not line:
            continue

        form_match = re.match(r"//\s*===\s*(?P<form>.*?)\s*===", line)
        if form_match:
            current_form = form_match.group("form").strip()
            continue

        if line.startswith(("//", "#", ".")):
            continue

        if re.fullmatch(r"(?:\d+|[A-Za-z_.$][\w.$]*):", line):
            continue

        if line.lower() in prefix_only:
            pending_prefix = (line_num, current_form, line)
            continue

        if pending_prefix is not None:
            prefix_line_num, prefix_form, prefix_text = pending_prefix
            rows.append(
                SourceInstruction(
                    index=len(rows) + 1,
                    line_num=prefix_line_num,
                    form=f"{prefix_form} + {current_form}".strip(" +"),
                    text=f"{prefix_text} {line}",
                )
            )
            pending_prefix = None
            continue

        rows.append(
            SourceInstruction(
                index=len(rows) + 1,
                line_num=line_num,
                form=current_form,
                text=line,
            )
        )

    if pending_prefix is not None:
        prefix_line_num, prefix_form, prefix_text = pending_prefix
        rows.append(
            SourceInstruction(
                index=len(rows) + 1,
                line_num=prefix_line_num,
                form=prefix_form,
                text=prefix_text,
            )
        )

    return rows


def parse_objdump_instructions(objdump_text: str) -> list[DisassembledInstruction]:
    """
    Extract address, opcode bytes, and instruction text from objdump output.

    A typical line looks like:
      12:  48 83 d0 ff           adc    rax,0xffffffffffffffff
    objdump may use tabs or spaces depending on the binutils version, so the
    parser accepts both layouts.
    """
    rows: list[DisassembledInstruction] = []
    pattern = re.compile(
        r"^\s*(?P<addr>[0-9a-fA-F]+):\s+"
        r"(?P<bytes>(?:[0-9a-fA-F]{2}\s+)+)"
        r"(?P<text>\S.*)$"
    )

    for raw_line in objdump_text.splitlines():
        if not re.match(r"^\s*[0-9a-fA-F]+:", raw_line):
            continue

        parts = raw_line.split("\t")
        if len(parts) >= 3:
            address = parts[0].strip().rstrip(":")
            opcode_bytes = " ".join(parts[1].split())
            text = re.sub(r"\s+", " ", parts[2].strip())
        else:
            match = pattern.match(raw_line)
            if not match:
                continue
            address = match.group("addr")
            opcode_bytes = " ".join(match.group("bytes").split())
            text = re.sub(r"\s+", " ", match.group("text").strip())

        # objdump wraps long opcode byte sequences onto continuation lines.
        # Those lines have an address and bytes but no actual instruction text.
        if re.fullmatch(r"(?:[0-9a-fA-F]{2}\s*)+", text):
            continue

        rows.append(
            DisassembledInstruction(
                index=len(rows) + 1,
                address=address,
                opcode_bytes=opcode_bytes,
                text=text,
            )
        )

    return rows


def normalize_instruction(text: str) -> str:
    """Normalize superficial syntax differences before comparison."""
    normalized = text.lower().strip()
    normalized = re.sub(r"\s+#\s*0x[0-9a-f]+$", "", normalized)
    normalized = normalized.replace("short ", "")
    normalized = normalized.replace("offset flat:", "")
    normalized = re.sub(r"\b(?:cs|ds|es|fs|gs|ss):(?=\[)", "", normalized)
    normalized = re.sub(r"\s+", " ", normalized)
    normalized = re.sub(r"\s*,\s*", ",", normalized)
    normalized = re.sub(r"\[\s*", "[", normalized)
    normalized = re.sub(r"\s*\]", "]", normalized)
    normalized = re.sub(r"\s*\+\s*", "+", normalized)
    normalized = re.sub(r"(?<=[\]a-z0-9])\s+-\s+(?=[a-z0-9])", "-", normalized)
    normalized = re.sub(r"\s*\*\s*", "*", normalized)
    normalized = re.sub(r"\b0x0+([0-9a-f]+)\b", r"0x\1", normalized)
    return normalized


def split_mnemonic_operands(text: str) -> tuple[str, str]:
    normalized = normalize_instruction(text)
    if " " not in normalized:
        return normalized, ""
    mnemonic, operands = normalized.split(" ", 1)
    return mnemonic, operands


def ptr_sizes(text: str) -> list[str]:
    return re.findall(
        r"\b(byte|word|dword|qword|fword|tbyte|oword|xmmword|ymmword|zmmword) ptr\b",
        normalize_instruction(text),
    )


def register_widths(text: str) -> list[int]:
    reg_width = {
        "al": 8, "cl": 8, "dl": 8, "bl": 8,
        "ah": 8, "ch": 8, "dh": 8, "bh": 8,
        "ax": 16, "cx": 16, "dx": 16, "bx": 16,
        "si": 16, "di": 16, "sp": 16, "bp": 16,
        "eax": 32, "ecx": 32, "edx": 32, "ebx": 32,
        "esi": 32, "edi": 32, "esp": 32, "ebp": 32,
        "rax": 64, "rcx": 64, "rdx": 64, "rbx": 64,
        "rsi": 64, "rdi": 64, "rsp": 64, "rbp": 64,
    }
    reg_pattern = re.compile(
        r"\b(?:[re]?[abcd]x|[re]?[sd]i|[re]?[sb]p|[abcd][lh]|r(?:[8-9]|1[0-5])[bwd]?)\b"
    )

    widths: list[int] = []
    for reg in reg_pattern.findall(normalize_instruction(text)):
        if reg in reg_width:
            widths.append(reg_width[reg])
        elif re.fullmatch(r"r(?:[8-9]|1[0-5])b", reg):
            widths.append(8)
        elif re.fullmatch(r"r(?:[8-9]|1[0-5])w", reg):
            widths.append(16)
        elif re.fullmatch(r"r(?:[8-9]|1[0-5])d", reg):
            widths.append(32)
        elif re.fullmatch(r"r(?:[8-9]|1[0-5])", reg):
            widths.append(64)

    return widths


def replace_numbers(text: str) -> str:
    """Replace numeric literals to detect representation-only differences."""
    return re.sub(r"(?<![a-z0-9_])-?(?:0x[0-9a-f]+|\d+)", "#", normalize_instruction(text))


def canonical_mnemonic(mnemonic: str) -> str:
    """Collapse common x86 spelling aliases used by assemblers/disassemblers."""
    condition_aliases = {
        "c": "b",
        "nae": "b",
        "b": "b",
        "nc": "ae",
        "nb": "ae",
        "ae": "ae",
        "z": "e",
        "e": "e",
        "nz": "ne",
        "ne": "ne",
        "na": "be",
        "be": "be",
        "nbe": "a",
        "a": "a",
        "nge": "l",
        "l": "l",
        "nl": "ge",
        "ge": "ge",
        "ng": "le",
        "le": "le",
        "nle": "g",
        "g": "g",
        "pe": "p",
        "p": "p",
        "po": "np",
        "np": "np",
    }

    for prefix in ("cmov", "set"):
        if mnemonic.startswith(prefix) and len(mnemonic) > len(prefix):
            cc = mnemonic[len(prefix):]
            if cc in condition_aliases:
                return prefix + condition_aliases[cc]

    if mnemonic.startswith("j") and mnemonic not in {"jmp", "jrcxz", "jecxz", "jcxz"}:
        cc = mnemonic[1:]
        if cc in condition_aliases:
            return "j" + condition_aliases[cc]

    alias_map = {
        "repnz": "repne",
        "repz": "repe",
        "retq": "ret",
        "xlatb": "xlat",
        "fwait": "wait",
        "movabs": "mov",
        "popfq": "popf",
        "pushfq": "pushf",
        "cmpsd": "cmps",
        "lodsb": "lods",
        "lodsw": "lods",
        "lodsd": "lods",
        "lodsq": "lods",
        "insb": "ins",
        "insw": "ins",
        "insd": "ins",
        "outsb": "outs",
        "outsw": "outs",
        "outsd": "outs",
        "stosb": "stos",
        "stosw": "stos",
        "stosd": "stos",
        "stosq": "stos",
        "scasb": "scas",
        "scasw": "scas",
        "scasd": "scas",
        "scasq": "scas",
        "movsb": "movs",
        "movsw": "movs",
        "movsq": "movs",
        "cmpsb": "cmps",
        "cmpsw": "cmps",
        "cmpsq": "cmps",
        "movsl": "movsd",
        "cmpsl": "cmpsd",
        "stosl": "stosd",
        "lodsl": "lodsd",
        "scasl": "scasd",
        "cltq": "cdqe",
        "cwtd": "cwd",
        "cltd": "cdq",
        "cqto": "cqo",
        "sal": "shl",
        "setz": "sete",
        "setnz": "setne",
        "jz": "je",
        "jnz": "jne",
        "jnae": "jb",
        "jc": "jb",
        "jnb": "jae",
        "jnc": "jae",
        "jna": "jbe",
        "jnbe": "ja",
        "jpe": "jp",
        "jpo": "jnp",
        "loopz": "loope",
        "loopnz": "loopne",
    }
    return alias_map.get(mnemonic, mnemonic)


def canonical_for_alignment(text: str) -> str:
    """A softer key used only to keep source/disassembly streams aligned."""
    mnemonic, operands = split_mnemonic_operands(text)
    if mnemonic in {"lock", "rep", "repe", "repne"} and operands:
        inner_mnemonic, inner_operands = split_mnemonic_operands(operands)
        return f"{mnemonic} {canonical_mnemonic(inner_mnemonic)} {replace_numbers(inner_operands)}".strip()
    return f"{canonical_mnemonic(mnemonic)} {replace_numbers(operands)}".strip()


def is_known_alias(source_text: str, disasm_text: str) -> bool:
    src_mnemonic, src_operands = split_mnemonic_operands(source_text)
    dis_mnemonic, dis_operands = split_mnemonic_operands(disasm_text)
    src_canon = canonical_mnemonic(src_mnemonic)
    dis_canon = canonical_mnemonic(dis_mnemonic)

    if src_canon == dis_canon and replace_numbers(src_operands) == replace_numbers(dis_operands):
        return True

    string_aliases = {"cmps", "ins", "lods", "movs", "outs", "scas", "stos", "xlat"}
    if src_canon in string_aliases and dis_canon == src_canon:
        return True

    if src_mnemonic == "movsd" and not src_operands and dis_mnemonic == "movs":
        return True

    if src_mnemonic == "push" and src_operands == "-1" and dis_mnemonic == "push" and dis_operands in {
        "0xffffffffffffffff",
        "0xffffffff",
    }:
        return True

    if src_mnemonic == "xchg" and dis_mnemonic == "nop" and src_operands in {"rax,rax", "eax,eax"}:
        return True

    alias_pairs = {
        ("xlat", "xlatb"),
        ("ret", "retq"),
        ("retq", "ret"),
        ("sysret", "sysretq"),
        ("sysexit", "sysexitq"),
        ("iretq", "iret"),
        ("iretd", "iret"),
    }
    if (src_mnemonic, dis_mnemonic) in alias_pairs and src_operands == dis_operands:
        return True

    string_prefixes = ("cmps", "movs", "lods", "stos", "scas", "ins", "outs")
    if src_mnemonic in string_prefixes and dis_mnemonic.startswith(src_mnemonic):
        return True

    return False


def normalize_x87_operands(operands: str) -> str:
    return normalize_instruction(operands).replace("st(0)", "st")


def is_x87_operand_alias(source_text: str, disasm_text: str) -> bool:
    src_mnemonic, src_operands = split_mnemonic_operands(source_text)
    dis_mnemonic, dis_operands = split_mnemonic_operands(disasm_text)
    if src_mnemonic != dis_mnemonic:
        return False

    x87_prefixes = ("fadd", "fcmov", "fcom", "fucom", "fdiv", "fdivr", "fmul", "fsub", "fsubr", "fxch")
    if not src_mnemonic.startswith(x87_prefixes):
        return False

    if not src_operands and dis_operands in {"st(1),st", "st(1)"}:
        return True
    return normalize_x87_operands(src_operands) == normalize_x87_operands(dis_operands)


def split_operands(operands: str) -> list[str]:
    if not operands:
        return []
    return [part.strip() for part in operands.split(",")]


def is_implicit_operand_alias(source_text: str, disasm_text: str) -> bool:
    src_mnemonic, src_operands = split_mnemonic_operands(source_text)
    dis_mnemonic, dis_operands = split_mnemonic_operands(disasm_text)
    if canonical_mnemonic(src_mnemonic) != canonical_mnemonic(dis_mnemonic):
        return False

    if not src_operands and dis_operands == "1" and src_mnemonic in {"rcl", "rcr", "rol", "ror", "sal", "sar", "shl", "shr"}:
        return True
    if src_mnemonic in {"rcl", "rcr", "rol", "ror", "sal", "sar", "shl", "shr"}:
        return dis_operands == f"{src_operands},1"
    if src_mnemonic == "push" and src_operands == "-1" and dis_operands in {"0xffffffffffffffff", "0xffffffff"}:
        return True
    return False


def is_xchg_operand_order_alias(source_text: str, disasm_text: str) -> bool:
    src_mnemonic, src_operands = split_mnemonic_operands(source_text)
    dis_mnemonic, dis_operands = split_mnemonic_operands(disasm_text)
    if src_mnemonic != "xchg" or dis_mnemonic != "xchg":
        return False
    src_parts = split_operands(src_operands)
    dis_parts = split_operands(dis_operands)
    return len(src_parts) == 2 and len(dis_parts) == 2 and src_parts == list(reversed(dis_parts))


def is_relative_target_resolution(source_form: str, source_text: str, disasm_text: str) -> bool:
    """objdump prints relative labels such as '.' as concrete target addresses."""
    if "rel" not in source_form.lower():
        return False
    src_mnemonic, src_operands = split_mnemonic_operands(source_text)
    dis_mnemonic, dis_operands = split_mnemonic_operands(disasm_text)
    if canonical_mnemonic(src_mnemonic) != canonical_mnemonic(dis_mnemonic):
        return False
    source_is_symbolic = bool(
        src_operands == "."
        or re.fullmatch(r"\d+[fb]", src_operands)
        or re.fullmatch(r"[A-Za-z_.$][\w.$]*", src_operands)
    )
    disasm_is_address = bool(re.fullmatch(r"(?:0x)?[0-9a-f]+(?: <.*>)?", dis_operands))
    return source_is_symbolic and disasm_is_address


def expected_immediate_bits(source_form: str, source_text: str) -> int | None:
    matches = re.findall(r"\bimm(8|16|32|64)\b", f"{source_form} {source_text}".lower())
    if not matches:
        return None
    return max(int(match) for match in matches)


def actual_immediate_bits_from_opcode(opcode_bytes: str) -> int | None:
    """
    Best-effort immediate width inference from opcode bytes.

    This is deliberately conservative. It primarily catches the important
    6회 미팅 사례: imm32 form이 opcode 83 (sign-extended imm8 group)로
    조립되는 경우.
    """
    byte_values = [int(b, 16) for b in opcode_bytes.split() if re.fullmatch(r"[0-9a-fA-F]{2}", b)]
    if not byte_values:
        return None

    i = 0
    prefixes = {0x66, 0x67, 0xf2, 0xf3, 0x2e, 0x36, 0x3e, 0x26, 0x64, 0x65}
    while i < len(byte_values) and (byte_values[i] in prefixes or 0x40 <= byte_values[i] <= 0x4f):
        i += 1
    if i >= len(byte_values):
        return None

    opcode = byte_values[i]
    if opcode in {0x6a, 0x80, 0x82, 0x83, 0xc6, 0xcd, 0xeb}:
        return 8
    if opcode in {0x68, 0x81, 0xc7, 0xe8, 0xe9}:
        return 16 if 0x66 in byte_values[:i] else 32
    if 0xb0 <= opcode <= 0xb7:
        return 8
    if 0xb8 <= opcode <= 0xbf:
        if any(0x48 <= b <= 0x4f for b in byte_values[:i]):
            return 64
        return 16 if 0x66 in byte_values[:i] else 32
    return None


def parse_last_numeric_literal(text: str) -> int | None:
    """Return the last numeric literal in an instruction, usually the immediate."""
    matches = re.findall(r"-?(?:0x[0-9a-fA-F]+|\d+)", normalize_instruction(text))
    if not matches:
        return None

    literal = matches[-1]
    try:
        if literal.startswith("-0x"):
            return -int(literal[3:], 16)
        if literal.startswith("0x"):
            return int(literal, 16)
        return int(literal, 10)
    except ValueError:
        return None


def signed_value_for_width(value: int, bits: int | None) -> int:
    """Interpret an unsigned literal as signed in the source operand width."""
    if bits is None or value < 0:
        return value
    modulo = 1 << bits
    sign_bit = 1 << (bits - 1)
    masked = value & (modulo - 1)
    return masked - modulo if masked >= sign_bit else masked


def fits_in_signed_imm8(source_text: str, expected_bits: int | None = None) -> bool:
    """
    Check whether the source immediate can legally use sign-extended imm8.

    x86 assemblers may encode forms such as ADD r64, imm32 with opcode 83 when
    the concrete immediate fits in signed imm8. That is a valid shorter encoding,
    not a bug candidate.
    """
    value = parse_last_numeric_literal(source_text)
    if value is None:
        return False
    signed_value = signed_value_for_width(value, expected_bits)
    return -128 <= signed_value <= 127


def is_immediate_width_bug_candidate(source_form: str, source_text: str, opcode_bytes: str) -> bool:
    expected = expected_immediate_bits(source_form, source_text)
    actual = actual_immediate_bits_from_opcode(opcode_bytes)
    if actual == 8 and fits_in_signed_imm8(source_text, expected):
        return False
    return expected is not None and actual is not None and actual < expected


def form_has_generic_memory_operand(source_form: str) -> bool:
    """Return True for SDM operand token "m", but not m8/m16/moffs/etc."""
    return bool(re.search(r"(?<![a-z0-9_:])m(?![a-z0-9_:])", source_form.lower()))


def form_has_far_pointer_memory(source_form: str) -> bool:
    return bool(re.search(r"\bm16:(?:16|32|64)\b", source_form.lower()))


def form_has_moffset(source_form: str) -> bool:
    return "moffs" in source_form.lower() or "moffset" in source_form.lower()


def classify_difference(
    source_text: str | None,
    disasm_text: str | None,
    source_form: str = "",
    opcode_bytes: str = "",
) -> str:
    if source_text is None:
        return "extra_disassembly"
    if disasm_text is None:
        return "missing_disassembly"

    if is_immediate_width_bug_candidate(source_form, source_text, opcode_bytes):
        return "bug_candidate"

    source_norm = normalize_instruction(source_text)
    disasm_norm = normalize_instruction(disasm_text)
    if source_norm == disasm_norm:
        return "exact_match"

    if is_known_alias(source_text, disasm_text):
        return "alias"

    if is_x87_operand_alias(source_text, disasm_text):
        return "alias"

    if is_implicit_operand_alias(source_text, disasm_text):
        return "alias"

    if is_xchg_operand_order_alias(source_text, disasm_text):
        return "alias"

    if is_relative_target_resolution(source_form, source_text, disasm_text):
        return "relative_target_resolved"

    src_mnemonic, src_operands = split_mnemonic_operands(source_text)
    dis_mnemonic, dis_operands = split_mnemonic_operands(disasm_text)
    if src_mnemonic != dis_mnemonic:
        return "mnemonic_changed"

    source_ptr_sizes = ptr_sizes(source_text)
    disasm_ptr_sizes = ptr_sizes(disasm_text)
    if source_ptr_sizes != disasm_ptr_sizes:
        if form_has_far_pointer_memory(source_form):
            return "far_pointer_size_repr_changed"
        if src_mnemonic == "lea" and form_has_generic_memory_operand(source_form):
            return "effective_address_size_directive_changed"
        if form_has_generic_memory_operand(source_form):
            return "generic_memory_size_inferred"
        if form_has_moffset(source_form):
            return "moffset_size_inferred"
        return "operand_size_changed"

    if register_widths(source_text) != register_widths(disasm_text):
        return "register_width_changed"

    if replace_numbers(source_text) == replace_numbers(disasm_text):
        return "immediate_repr_changed"

    if src_operands != dis_operands:
        return "operand_changed"

    return "bug_candidate"


def make_compare_row(
    row_index: int,
    src: SourceInstruction | None,
    dis: DisassembledInstruction | None,
    alignment_status: str,
) -> dict[str, str | int]:
    category = classify_difference(
        src.text if src else None,
        dis.text if dis else None,
        src.form if src else "",
        dis.opcode_bytes if dis else "",
    )
    return {
        "index": row_index,
        "alignment_status": alignment_status,
        "category": category,
        "source_index": src.index if src else "",
        "disasm_index": dis.index if dis else "",
        "source_line_num": src.line_num if src else "",
        "source_form": src.form if src else "",
        "source_text": src.text if src else "",
        "source_normalized": normalize_instruction(src.text) if src else "",
        "disasm_address": dis.address if dis else "",
        "disasm_opcode_bytes": dis.opcode_bytes if dis else "",
        "disasm_text": dis.text if dis else "",
        "disasm_normalized": normalize_instruction(dis.text) if dis else "",
    }


def compare_rows(
    source_rows: list[SourceInstruction],
    disasm_rows: list[DisassembledInstruction],
) -> list[dict[str, str | int]]:
    """
    Align the two instruction streams before comparing.

    A naive source_rows[i] <-> disasm_rows[i] comparison is fragile: if one
    side has an inserted/missing instruction, every later row becomes shifted.
    SequenceMatcher gives us insert/delete/replace blocks so later equal blocks
    can be resynchronized.
    """
    results: list[dict[str, str | int]] = []
    source_keys = [canonical_for_alignment(row.text) for row in source_rows]
    disasm_keys = [canonical_for_alignment(row.text) for row in disasm_rows]
    matcher = difflib.SequenceMatcher(None, source_keys, disasm_keys, autojunk=False)

    for tag, i1, i2, j1, j2 in matcher.get_opcodes():
        if tag == "equal":
            for src, dis in zip(source_rows[i1:i2], disasm_rows[j1:j2]):
                results.append(make_compare_row(len(results) + 1, src, dis, "aligned"))
            continue

        if tag == "delete":
            for src in source_rows[i1:i2]:
                results.append(make_compare_row(len(results) + 1, src, None, "delete"))
            continue

        if tag == "insert":
            for dis in disasm_rows[j1:j2]:
                results.append(make_compare_row(len(results) + 1, None, dis, "insert"))
            continue

        source_block = source_rows[i1:i2]
        disasm_block = disasm_rows[j1:j2]
        paired_count = min(len(source_block), len(disasm_block))
        for offset in range(paired_count):
            results.append(
                make_compare_row(
                    len(results) + 1,
                    source_block[offset],
                    disasm_block[offset],
                    "replace",
                )
            )
        for src in source_block[paired_count:]:
            results.append(make_compare_row(len(results) + 1, src, None, "replace_delete"))
        for dis in disasm_block[paired_count:]:
            results.append(make_compare_row(len(results) + 1, None, dis, "replace_insert"))

    return results


def write_csv(rows: list[dict[str, str | int]], output_path: Path) -> None:
    output_path.parent.mkdir(parents=True, exist_ok=True)
    fieldnames = [
        "index",
        "alignment_status",
        "category",
        "source_index",
        "disasm_index",
        "source_line_num",
        "source_form",
        "source_text",
        "source_normalized",
        "disasm_address",
        "disasm_opcode_bytes",
        "disasm_text",
        "disasm_normalized",
    ]
    with output_path.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def count_categories(rows: list[dict[str, str | int]]) -> dict[str, int]:
    counts: dict[str, int] = {}
    for row in rows:
        category = str(row["category"])
        counts[category] = counts.get(category, 0) + 1
    return counts


def count_field(rows: list[dict[str, str | int]], field: str) -> dict[str, int]:
    counts: dict[str, int] = {}
    for row in rows:
        value = str(row[field])
        counts[value] = counts.get(value, 0) + 1
    return counts


def write_report(
    rows: list[dict[str, str | int]],
    output_path: Path,
    src_asm: Path,
    object_path: Path,
    objdump_path: Path,
) -> None:
    counts = count_categories(rows)
    alignment_counts = count_field(rows, "alignment_status")
    exact_count = counts.get("exact_match", 0)
    alias_count = counts.get("alias", 0)
    benign_categories = {
        "exact_match",
        "alias",
        "relative_target_resolved",
        "generic_memory_size_inferred",
        "effective_address_size_directive_changed",
        "moffset_size_inferred",
    }
    suspicious_rows = [row for row in rows if str(row["category"]) not in benign_categories]
    alignment_warning_count = sum(
        count
        for status, count in alignment_counts.items()
        if status != "aligned"
    )

    lines = [
        "# Stage 5 역어셈블 비교 리포트",
        "",
        "## 1. 목적",
        "",
        "Stage 4에서 accept된 assembly가 실제로 의도한 instruction form/opcode로 조립되었는지 확인한다.",
        "원본 assembly와 `objdump -d -M intel` 결과를 정규화한 뒤 1:1로 비교한다.",
        "",
        "## 2. 입력 및 출력",
        "",
        f"- 원본 assembly: `{src_asm}`",
        f"- object file: `{object_path}`",
        f"- objdump 원문: `{objdump_path}`",
        "",
        "## 3. 요약",
        "",
        f"- 전체 비교 instruction: {len(rows)}",
        f"- exact match: {exact_count}",
        f"- alias: {alias_count}",
        f"- alignment 재동기화 필요 행: {alignment_warning_count}",
        f"- 추가 확인 필요: {len(suspicious_rows)}",
        "",
        "## 4. 카테고리별 개수",
        "",
        "| Category | Count |",
        "|---|---:|",
    ]

    for category, count in sorted(counts.items(), key=lambda item: (-item[1], item[0])):
        lines.append(f"| {category} | {count} |")

    lines.extend([
        "",
        "## 5. Alignment 상태",
        "",
        "| Alignment status | Count |",
        "|---|---:|",
    ])

    for status, count in sorted(alignment_counts.items(), key=lambda item: (-item[1], item[0])):
        lines.append(f"| {status} | {count} |")

    if alignment_warning_count:
        lines.extend([
            "",
            "> 일부 구간에서 source/disassembly stream이 insert/delete/replace로 재정렬되었습니다. "
            "해당 구간은 주변 instruction까지 함께 확인해야 합니다.",
        ])

    triage_counts: dict[tuple[str, str], int] = {}
    triage_examples: dict[tuple[str, str], dict[str, str | int]] = {}
    for row in suspicious_rows:
        key = (str(row["category"]), str(row["source_form"]))
        triage_counts[key] = triage_counts.get(key, 0) + 1
        triage_examples.setdefault(key, row)

    lines.extend([
        "",
        "## 6. 교수님 피드백 기준 그룹",
        "",
        "| Category | Source form | Count | Example source | Example objdump | Error judgment |",
        "|---|---|---:|---|---|---|",
    ])

    if triage_counts:
        for (category, source_form), count in sorted(
            triage_counts.items(),
            key=lambda item: (-item[1], item[0][0], item[0][1]),
        )[:40]:
            example = triage_examples[(category, source_form)]
            source_text = str(example["source_text"]).replace("|", "\\|")
            disasm_text = str(example["disasm_text"]).replace("|", "\\|")
            form_text = source_form.replace("|", "\\|")
            if category == "far_pointer_size_repr_changed":
                judgment = "review: TBYTE/FWORD representation"
            elif category == "register_width_changed":
                judgment = "review: encoding/register-width"
            else:
                judgment = "review"
            lines.append(
                f"| `{category}` | `{form_text}` | {count} | `{source_text}` | `{disasm_text}` | {judgment} |"
            )
    else:
        lines.append("| - | - | 0 | - | - | no review items |")

    lines.extend([
        "",
        "## 7. 추가 확인 필요 예시",
        "",
    ])

    if suspicious_rows:
        lines.extend([
            "| Index | Align | Category | Source form | Source | Objdump | Opcode bytes |",
            "|---:|---|---|---|---|---|---|",
        ])
        for row in suspicious_rows[:40]:
            source_form = str(row["source_form"]).replace("|", "\\|")
            source_text = str(row["source_text"]).replace("|", "\\|")
            disasm_text = str(row["disasm_text"]).replace("|", "\\|")
            opcode_bytes = str(row["disasm_opcode_bytes"]).replace("|", "\\|")
            lines.append(
                f"| {row['index']} | {row['alignment_status']} | {row['category']} | `{source_form}` | "
                f"`{source_text}` | `{disasm_text}` | `{opcode_bytes}` |"
            )
    else:
        lines.append("- 추가 확인이 필요한 mismatch가 없습니다.")

    lines.extend([
        "",
        "## 8. 분류 기준",
        "",
        "- `exact_match`: 원본과 역어셈블 결과가 정규화 후 동일하다.",
        "- `alias`: 의미상 같은 명령어가 별칭 또는 축약 표기로 출력된 정상 케이스다.",
        "- `relative_target_resolved`: `.` 같은 상대주소가 objdump에서 실제 target address로 출력된 정상 케이스다.",
        "- `generic_memory_size_inferred`: SDM form uses generic `m`; objdump inferred/printed a concrete PTR size.",
        "- `effective_address_size_directive_changed`: `LEA` uses an effective address, so PTR size text is not semantic.",
        "- `moffset_size_inferred`: moffset size was inferred from the register operand and printed by objdump.",
        "- `far_pointer_size_repr_changed`: far-memory pointer text changed, especially `m16:64` TBYTE/FWORD cases; review separately.",
        "- `bug_candidate`: opcode byte 기준으로 기대 immediate width보다 짧게 조립된 것으로 보이는 케이스다.",
        "- `immediate_repr_changed`: immediate/displacement 값 표기가 달라졌다. 값/크기 변화 여부를 확인해야 한다.",
        "- `operand_size_changed`: memory operand size가 바뀌었을 가능성이 있다.",
        "- `register_width_changed`: register width가 바뀌었을 가능성이 있다.",
        "- `mnemonic_changed`: mnemonic 자체가 달라졌다.",
        "- `operand_changed`: mnemonic은 같지만 operand 구조가 달라졌다.",
        "- `missing_disassembly` / `extra_disassembly`: 원본과 역어셈블 instruction 개수가 다르다.",
        "",
        "## 9. Alignment 기준",
        "",
        "- `aligned`: 정규화된 instruction stream에서 같은 위치로 매칭된 행이다.",
        "- `replace`: source와 disassembly가 같은 구간에 있으나 내용이 달라 paired 비교한 행이다.",
        "- `delete` / `insert`: 한쪽 stream에만 존재하는 행이다.",
        "- `replace_delete` / `replace_insert`: replace block 안에서 한쪽이 더 길어 남은 행이다.",
        "",
    ])

    output_path.write_text("\n".join(lines), encoding="utf-8")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Stage 5 objdump disassembly comparison")
    parser.add_argument("--src", type=Path, default=DEFAULT_SRC_ASM, help="Stage 4 assembly source")
    parser.add_argument("--object", type=Path, default=DEFAULT_OBJECT, help="Object file path")
    parser.add_argument(
        "--reuse-object",
        action="store_true",
        help="Use an existing object file instead of running GNU as",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()

    src_asm = args.src
    object_path = args.object

    if not src_asm.exists():
        raise FileNotFoundError(f"Stage 4 assembly source not found: {src_asm}")

    STAGE5_DIR.mkdir(parents=True, exist_ok=True)

    print("=" * 60)
    print("Step 5: objdump disassembly comparison")
    print("=" * 60)
    print(f"[source] {src_asm}")
    print(f"[object] {object_path}")

    if args.reuse_object and object_path.exists():
        print("[1] Reusing existing object file")
    else:
        print("[1] Assembling source with GNU as")
        build_object_file(src_asm, object_path)

    print("[2] Running objdump -d -M intel")
    objdump_text = run_objdump(object_path)
    DEFAULT_OBJDUMP.write_text(objdump_text, encoding="utf-8")

    print("[3] Parsing source and disassembly")
    source_rows = parse_source_instructions(src_asm)
    disasm_rows = parse_objdump_instructions(objdump_text)
    print(f"    source instructions: {len(source_rows)}")
    print(f"    disassembled instructions: {len(disasm_rows)}")

    print("[4] Comparing and triaging differences")
    rows = compare_rows(source_rows, disasm_rows)
    write_csv(rows, DEFAULT_COMPARE_CSV)
    write_report(rows, DEFAULT_REPORT, src_asm, object_path, DEFAULT_OBJDUMP)

    counts = count_categories(rows)
    print("[done] Stage 5 comparison complete")
    print(f"    objdump: {DEFAULT_OBJDUMP}")
    print(f"    csv: {DEFAULT_COMPARE_CSV}")
    print(f"    report: {DEFAULT_REPORT}")
    print("    categories: " + ", ".join(f"{k}={v}" for k, v in sorted(counts.items())))


if __name__ == "__main__":
    main()

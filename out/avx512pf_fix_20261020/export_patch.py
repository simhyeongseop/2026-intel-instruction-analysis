"""Export only the intended upstream changes, without staging or committing."""

import difflib
import subprocess
import sys
from pathlib import Path


FILES = (
    "llvm/lib/Target/X86/X86InstrAVX512.td",
    "llvm/test/MC/X86/avx512pf-64-intel.s",
    "llvm/test/MC/X86/avx512pf-intel-errors.s",
)


def main():
    source = Path(sys.argv[1])
    destination = Path(sys.argv[2])
    destination.mkdir(parents=True, exist_ok=True)
    patch = []
    for name in FILES:
        path = source / name
        if not path.exists():
            continue
        original = subprocess.run(
            ["git", "-C", str(source), "show", f"HEAD:{name}"],
            text=True, capture_output=True,
        )
        before = original.stdout if original.returncode == 0 else ""
        after = path.read_text()
        patch.append(f"diff --git a/{name} b/{name}\n")
        if original.returncode != 0:
            patch.append("new file mode 100644\n")
        patch.extend(difflib.unified_diff(
            before.splitlines(keepends=True), after.splitlines(keepends=True),
            fromfile=f"a/{name}" if original.returncode == 0 else "/dev/null",
            tofile=f"b/{name}",
        ))
        if name.endswith(".s"):
            (destination / path.name).write_text(after)
    patch_path = destination / "llvm-avx512pf-intel-mask.patch"
    patch_path.write_text("".join(patch))
    subprocess.run(["git", "-C", str(source), "apply", "--reverse", "--check",
                    str(patch_path.resolve())], check=True)
    print(patch_path)


if __name__ == "__main__":
    main()

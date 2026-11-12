"""오퍼랜드 크기를 니모닉이 정하는 명령(매뉴얼이 '어셈블러마다 다를 수 있다'고 적은 것)의 도구별 해석 대조.

    python3 scripts/probe_size_mnemonics.py [--out out/round2_20261111/size_mnemonics]

매뉴얼 근거(SDM Vol.2 093판, scripts/manual_lookup.py로 조회):
- IRET: "most assemblers use the IRET mnemonic interchangeably for both operand sizes"(파일 608쪽)
- CBW/CWDE, CWD/CDQ, PUSHF/PUSHFD, POPF/POPFD: "Some assemblers may force the operand size ...
  Others may treat these mnemonics as synonyms"(파일 256, 375, 1231, 1110쪽)
- 표에 크기 행이 따로 없거나(PUSH FS) 같은 문법의 크기 행이 여럿인 것(POP FS, RETF)도 같이 본다.

각 철자를 GNU as·clang으로 Intel·AT&T 문법에서 조립한다(64비트). 나온 바이트마다 같은 계열 역어셈블러로
두 문법 출력을 얻고, 그 출력을 같은 도구·문법으로 다시 조립해 바이트가 돌아오는지 본다.
출력: probe_assemble.csv(철자 × 도구 × 문법), probe_disasm.csv(바이트 × 계열 × 문법), manifest.json.
CPU 실행은 하지 않는다. 의미(오퍼랜드 크기)는 매뉴얼의 접두어 규칙으로 바이트에서 읽는다(size_of_bytes).
"""

import argparse
import csv
import json
import os
import sys
from datetime import datetime, timezone

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline import m5_roundtrip as M  # noqa: E402
from pipeline.instruction_check import assemble, environment, sha256  # noqa: E402

# (묶음, Intel 철자, AT&T 철자). 빈 칸은 그 문법에 해당 철자가 없음.
SPELLINGS = [
    ("IRET", "iret", "iret"), ("IRET", "iretw", "iretw"), ("IRET", "iretd", "iretl"),
    ("IRET", "iretd", "iretd"), ("IRET", "iretq", "iretq"),
    ("CBW", "cbw", "cbtw"), ("CBW", "cwde", "cwtl"), ("CBW", "cdqe", "cltq"),
    ("CBW", "cbw", "cbw"), ("CBW", "cwde", "cwde"),
    ("CWD", "cwd", "cwtd"), ("CWD", "cdq", "cltd"), ("CWD", "cqo", "cqto"),
    ("PUSHF", "pushf", "pushf"), ("PUSHF", "pushfw", "pushfw"), ("PUSHF", "pushfd", "pushfl"),
    ("PUSHF", "pushfq", "pushfq"),
    ("POPF", "popf", "popf"), ("POPF", "popfw", "popfw"), ("POPF", "popfd", "popfl"), ("POPF", "popfq", "popfq"),
    ("PUSH Sreg", "push fs", "push %fs"), ("PUSH Sreg", "push gs", "push %gs"),
    ("PUSH Sreg", "pushw fs", "pushw %fs"), ("PUSH Sreg", "pushq fs", "pushq %fs"),
    ("POP Sreg", "pop fs", "pop %fs"), ("POP Sreg", "pop gs", "pop %gs"),
    ("POP Sreg", "popw fs", "popw %fs"), ("POP Sreg", "popq fs", "popq %fs"),
    ("RETF", "retf", "lret"), ("RETF", "retfw", "lretw"), ("RETF", "retfd", "lretl"), ("RETF", "retfq", "lretq"),
    ("MOV r,Sreg", "mov cx, es", "mov %es, %cx"), ("MOV r,Sreg", "mov ecx, es", "mov %es, %ecx"),
    ("MOV r,Sreg", "mov rcx, es", "mov %es, %rcx"),
    ("MOV Sreg,r", "mov es, cx", "mov %cx, %es"), ("MOV Sreg,r", "mov es, ecx", "mov %ecx, %es"),
]
TOOLS = (("gnu", "as"), ("llvm", "clang"))


def size_of_bytes(hex_bytes):
    """접두어로 읽는 오퍼랜드 크기(64비트 모드). Vol.1 Table 3-4: REX.W -> 64, 66 -> 16, 없으면 기본.
    기본 크기는 명령마다 다르므로(IRET·RETF·CBW 32, PUSH/POP·PUSHF 64) 여기서는 접두어만 적는다."""
    data = bytes.fromhex(hex_bytes)
    prefix = []
    for byte in data:
        if byte == 0x66:
            prefix.append("66")
        elif 0x40 <= byte <= 0x4f:
            prefix.append("REX.W" if byte & 8 else "REX")
        else:
            break
    return "+".join(prefix) or "없음"


def assemble_one(tool, syntax, text):
    header = M.SYNTAX_HEADER[syntax]
    result = assemble(header + text + "\n", tool, display_syntax=syntax)
    ok = result["observation_status"] == "accepted"
    error = " ".join((result["assembly"].get("stderr") or "").split())[-120:]
    return ok, result["bytes"] if ok else "", "" if ok else error


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--out", default=os.path.join(ROOT, "out/round2_20261111/size_mnemonics"))
    args = parser.parse_args()
    os.makedirs(args.out, exist_ok=True)
    rows, seen = [], set()
    for group, intel, att in SPELLINGS:
        for family, tool in TOOLS:
            for syntax, text in (("intel", intel), ("att", att)):
                if not text or (tool, syntax, text) in seen:
                    continue
                seen.add((tool, syntax, text))
                ok, hex_bytes, error = assemble_one(tool, syntax, text)
                rows.append({"group": group, "family": family, "syntax": syntax, "source": text,
                             "accepted": "예" if ok else "아니오", "bytes": hex_bytes,
                             "prefix": size_of_bytes(hex_bytes) if hex_bytes else "", "error": error})
    disasm = []
    for hex_bytes in sorted({(r["group"], r["bytes"]) for r in rows if r["bytes"]}):
        group, hex_bytes = hex_bytes
        for family, tool in TOOLS:
            for syntax in ("intel", "att"):
                texts, whole = M.disassemble(family, hex_bytes, syntax)
                texts = [M.clean(t) for t in texts]
                ok, again, error = assemble_one(tool, syntax, "\n".join(texts)) if whole else (False, "", "풀지 못함")
                disasm.append({"group": group, "bytes": hex_bytes, "prefix": size_of_bytes(hex_bytes),
                               "family": family, "syntax": syntax, "text": " | ".join(texts),
                               "reassembled": again if ok else "거부: " + error,
                               "round_trip": "같음" if ok and again == hex_bytes else "다름"})
    for name, items in (("probe_assemble.csv", rows), ("probe_disasm.csv", disasm)):
        with open(os.path.join(args.out, name), "w", encoding="utf-8", newline="") as handle:
            writer = csv.DictWriter(handle, fieldnames=list(items[0].keys()))
            writer.writeheader()
            writer.writerows(items)
    manifest = {"finished_utc": datetime.now(timezone.utc).isoformat(), "command": sys.argv,
                "environment": environment(),
                "code": {p: sha256(os.path.join(ROOT, p)) for p in
                         ("scripts/probe_size_mnemonics.py", "pipeline/m5_roundtrip.py", "pipeline/instruction_check.py")},
                "assemble_rows": len(rows), "disasm_rows": len(disasm)}
    with open(os.path.join(args.out, "manifest.json"), "w", encoding="utf-8") as handle:
        json.dump(manifest, handle, ensure_ascii=False, indent=1)
    print(json.dumps({"assemble_rows": len(rows), "disasm_rows": len(disasm)}, ensure_ascii=False))


if __name__ == "__main__":
    main()

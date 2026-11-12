""".Ltarget 상대 분기(5단계 '분기 대상 미대조')를 라벨로 되돌려 다시 조립해 b0와 비교한다.

    python3 scripts/check_ltarget_roundtrip.py [--dir out/round2_20261111/roundtrip_chain]

5단계는 같은 파일 라벨(.Ltarget, .Ltarget16/32 = .Ltarget+4096)로 조립한 분기를 '미대조'로 둔다.
역어셈블 출력이 숫자(objdump: 시작 0 기준 절대 주소, llvm-mc: 다음 명령 기준 변위)라 그대로 다시
조립하면 다른 대상이 되기 때문이다. 여기서는 그 숫자를 대상 주소로 바꾼 뒤 '.Ltarget+주소'로 써서
b0와 같은 위치(시작 0, .Ltarget = 0)에서 다시 조립한다(b1). b1을 다시 풀어 as2를 as1과 비교한다.
입력: <dir>/roundtrip_results.csv. 출력: <dir>/ltarget_check.csv, <dir>/ltarget_check_manifest.json.
외부 기호(ext_target) 분기는 5단계가 이미 비교한다. 이 검사는 rel8/rel16 행에 닿기 위해 남긴 .Ltarget 변형용이다.
"""

import argparse
import collections
import csv
import json
import os
import re
import sys
from datetime import datetime, timezone

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline import m5_roundtrip as M  # noqa: E402
from pipeline.instruction_check import assemble, environment, sha256  # noqa: E402

csv.field_size_limit(10 ** 9)
BRANCH = re.compile(r"^(.*?\b(?:j[a-z]+|call[qlw]?|loop[a-z]*|xbegin[a-z]*))\s+(-?(?:0x)?[0-9a-f]+)$")


def to_label(family, text, length):
    """'ja 0x0'(objdump) / 'ja -2'(llvm-mc) -> 'ja .Ltarget'. length: b0 바이트 수. 분기가 아니면 None."""
    match = BRANCH.match(text)
    if not match:
        return None
    number = int(match.group(2), 16 if "0x" in match.group(2) else 10)
    target = number if family == "gnu" else length + number
    return match.group(1) + (" .Ltarget+%d" % target if target else " .Ltarget")


def check(family, b0, syntax):
    first, whole = M.disassemble(family, b0, syntax)
    first = [M.clean(t) for t in first]
    labeled = [to_label(family, t, len(b0) // 2) for t in first]
    out = {"as1": " | ".join(first), "as1_label": "", "b1": "", "as2": "", "b0_b1": "", "as1_as2": ""}
    if not whole or None in labeled:
        out["b0_b1"] = out["as1_as2"] = "라벨 변환 불가"
        return out
    out["as1_label"] = " | ".join(labeled)
    source = M.SYNTAX_HEADER[syntax] + ".Ltarget:\n" + "".join(t + "\n" for t in labeled)
    result = assemble(source, M.FAMILIES[family], display_syntax=syntax)
    if result["observation_status"] != "accepted":
        out["b0_b1"] = out["as1_as2"] = "재조립 거부"
        return out
    out["b1"] = result["bytes"]
    second = [M.clean(t) for t in M.disassemble(family, out["b1"], syntax)[0]]
    out["as2"] = " | ".join(second)
    out["b0_b1"] = "같음" if out["b1"] == b0 else "다름"
    out["as1_as2"] = "같음" if second == first else "다름"
    return out


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--dir", default=os.path.join(ROOT, "out/round2_20261111/roundtrip_chain"))
    args = parser.parse_args()
    source = os.path.join(args.dir, "roundtrip_results.csv")
    with open(source, encoding="utf-8", newline="") as handle:
        rows = [r for r in csv.DictReader(handle) if r["verdict_intel"] == M.RELATIVE or r["verdict_att"] == M.RELATIVE]
    items, counts = [], collections.Counter()
    for row in rows:
        for syntax in ("att", "intel"):
            item = {"case_id": row["case_id"], "family": row["family"], "path": syntax,
                    "instruction": row["instruction"], "source": row["source"], "b0": row["b0"]}
            item.update(check(row["family"], row["b0"], syntax))
            items.append(item)
            counts["%s/%s b0–b1 %s, as1–as2 %s" % (row["family"], syntax, item["b0_b1"], item["as1_as2"])] += 1
    with open(os.path.join(args.dir, "ltarget_check.csv"), "w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(items[0].keys()))
        writer.writeheader()
        writer.writerows(items)
    manifest = {"finished_utc": datetime.now(timezone.utc).isoformat(), "command": sys.argv,
                "input": {source: sha256(source)}, "environment": environment(),
                "code": {p: sha256(os.path.join(ROOT, p)) for p in
                         ("scripts/check_ltarget_roundtrip.py", "pipeline/m5_roundtrip.py")},
                "counts": dict(sorted(counts.items()))}
    with open(os.path.join(args.dir, "ltarget_check_manifest.json"), "w", encoding="utf-8") as handle:
        json.dump(manifest, handle, ensure_ascii=False, indent=1)
    print(json.dumps(manifest["counts"], ensure_ascii=False, indent=1))


if __name__ == "__main__":
    main()

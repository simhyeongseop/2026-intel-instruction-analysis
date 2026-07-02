"""축 A(step6_diff_axisA.csv) 분석: 주소지정 형태별 divergence 원인 규명."""
import csv
import re
from collections import Counter
from pathlib import Path

CSV = Path(__file__).parent.parent / "data" / "stage6_differential" / "step6_diff_axisA.csv"


def addr(s):
    m = re.search(r"\[(.*?)\]", s)
    return m.group(0) if m else "?"


rows = list(csv.DictReader(CSV.open(encoding="utf-8-sig")))

# support_diff: A5(base-less SIB) / A7(absolute)에서 누가 accept 하는가
sub = [r for r in rows if r["category"] == "support_diff"
       and ("rbx*8" in r["source"] or "[0x1000]" in r["source"])]
who = Counter("as_only" if r["as_ok"] == "True" else "llvm_only" for r in sub)
print("[A5/A7 support_diff] 누가 accept:", dict(who))
seen = set()
for r in sub:
    m = r["source"].split()[0]
    if m in seen:
        continue
    seen.add(m)
    tool = "as" if r["as_ok"] == "True" else "llvm"
    print(f"  {tool:4} only | {r['source']}")

# semantic_divergence: 주소지정과 무관하게 기존 클러스터인지 확인
print("\n[semantic_divergence] mnemonic:",
      dict(Counter(r["source"].split()[0] for r in rows
                   if r["category"] == "semantic_divergence")))

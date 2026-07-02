"""
Stage 6 (신규): 바이트 레벨 차등 인코딩 분석 (독립 오라클 + 동등성 판정)

동기 (교수님 비판 수용)
-----------------------
- as(binutils)와 objdump는 같은 코드베이스 → self-consistency만 증명. 오라클이 아님.
- 독립 구현: as(binutils) vs llvm-mc(LLVM). 의미 판정: iced-x86(독립 디코더).
- 지표는 "통과율"이 아니라 불일치 (특히 (c),(d)).

각 명령어에 대해:
  as    --64 -mintel64      → 바이트 A (+ accept/reject)
  llvm-mc --show-encoding   → 바이트 B (+ accept/reject)
  iced-x86 로 A, B 를 각각 디코드 → 의미 semA, semB

분류 (triage taxonomy)
  a) byte_identical      : 둘 다 accept, A == B
  b) equiv_encoding      : 둘 다 accept, A != B, 그러나 semA == semB  (동등 인코딩; 버그 아님)
  c) support_diff        : 한쪽만 accept                              (어셈블러 지원 범위 차이)
  d) semantic_divergence : 둘 다 accept, A != B, semA != semB         ← RED FLAG (버그/모호성 후보)
  e) both_reject         : 둘 다 reject
  f) decode_disagree     : accept 했으나 iced 가 (invalid) 로 디코드   (어셈블러 vs 디코더 불일치)

핵심 지표 = (d) + (c) + (f) 의 수. (a),(b),(e) 는 참고.

SDM opcode 열의 역할
--------------------
매뉴얼 opcode 열(VEX.128.66.0F.W0 58 /r 등)은 '템플릿'이지 구체 바이트가 아니다.
따라서 정밀 per-instance 오라클은 iced/llvm-mc 로 삼고, SDM 은 향후 '구조적 sanity
check'(opcode 바이트/프리픽스/W 비트 일치 여부)로만 사용한다. (v1 범위 밖, 별도 표기)
"""

import argparse
import csv
import re
import subprocess
from collections import Counter
from pathlib import Path

BASE = Path(__file__).parent.parent.parent
DEFAULT_SRC = BASE / "data" / "stage3_operands" / "step3_generated.s"
OUT_DIR = BASE / "data" / "stage6_differential"
LLVM_MC = "/usr/lib/llvm-20/bin/llvm-mc"


# ── WSL 차등 어셈블 (as + llvm-mc), 명령어별 바이트 수집 ────────────────
DIFF_SH = r'''
set -u
HDR='.intel_syntax noprefix'
OUT=/tmp/diff_out.tsv
: > "$OUT"
i=0
while IFS= read -r line; do
  i=$((i+1))
  printf '%s\n%s\n' "$HDR" "$line" > /tmp/one.s
  if as --64 -mintel64 /tmp/one.s -o /tmp/one.o 2>/dev/null; then
    objcopy -O binary -j .text /tmp/one.o /tmp/one.bin 2>/dev/null
    A=$(xxd -p /tmp/one.bin 2>/dev/null | tr -d '\n'); aok=1
  else A=""; aok=0; fi
  if printf '%s\n%s\n' "$HDR" "$line" | LLVMMC --assemble --arch=x86-64 \
        --show-encoding --x86-asm-syntax=intel > /tmp/l.txt 2>/dev/null; then
    B=$(sed -n 's/.*encoding: \[\([^]]*\)\].*/\1/p' /tmp/l.txt \
        | tr -d ' ' | sed 's/0x//g; s/,//g' | tr -d '\n'); lok=1
  else B=""; lok=0; fi
  printf '%s\t%s\t%s\t%s\t%s\n' "$i" "$aok" "$A" "$lok" "$B" >> "$OUT"
done < /tmp/instrs.txt
'''


def run_differential(instrs: list[str]) -> list[dict]:
    text = "\n".join(instrs) + "\n"
    # CRLF 변환 방지를 위해 bytes(LF)로 stdin 전달
    subprocess.run(["wsl", "bash", "-c", "cat > /tmp/instrs.txt"],
                   input=text.encode("utf-8"), capture_output=True)
    script = DIFF_SH.replace("LLVMMC", LLVM_MC)
    subprocess.run(["wsl", "bash", "-c", "cat > /tmp/diff.sh"],
                   input=script.encode("utf-8"), capture_output=True)
    subprocess.run(["wsl", "bash", "/tmp/diff.sh"], capture_output=True, timeout=1800)
    r = subprocess.run(["wsl", "cat", "/tmp/diff_out.tsv"],
                       capture_output=True, text=True, encoding="utf-8", errors="replace")
    rows = []
    for ln in r.stdout.splitlines():
        parts = ln.split("\t")
        if len(parts) != 5:
            continue
        idx, aok, ah, lok, bh = parts
        rows.append({"idx": int(idx), "as_ok": aok == "1", "as_hex": ah.strip(),
                     "llvm_ok": lok == "1", "llvm_hex": bh.strip()})
    return rows


# ── iced-x86 디코드 (독립 오라클) ──────────────────────────────────────
def make_decoder():
    from iced_x86 import Decoder, Formatter, FormatterSyntax
    fmt = Formatter(FormatterSyntax.INTEL)

    def decode(hexstr: str) -> str | None:
        if not hexstr:
            return None
        try:
            b = bytes.fromhex(hexstr)
        except ValueError:
            return None
        dec = Decoder(64, b)
        parts = []
        for ins in dec:
            if ins.is_invalid:
                return "(invalid)"
            parts.append(fmt.format(ins))
        return "; ".join(parts) if parts else "(empty)"

    return decode


def norm_sem(s: str | None) -> str:
    if s is None:
        return ""
    s = s.lower()
    s = re.sub(r"0x0+([0-9a-f])", r"0x\1", s)
    s = re.sub(r"\s+", " ", s).strip()
    s = re.sub(r"\s*,\s*", ",", s)
    return s


def classify(row: dict, decode) -> tuple[str, str, str]:
    a, b = row["as_ok"], row["llvm_ok"]
    if not a and not b:
        return "both_reject", "", ""
    if a != b:
        return "support_diff", "", ""     # (c)
    # 둘 다 accept
    sa, sb = decode(row["as_hex"]), decode(row["llvm_hex"])
    if sa == "(invalid)" or sb == "(invalid)":
        return "decode_disagree", sa or "", sb or ""   # (f)
    if row["as_hex"] == row["llvm_hex"]:
        return "byte_identical", sa or "", sb or ""     # (a)
    if norm_sem(sa) == norm_sem(sb):
        return "equiv_encoding", sa or "", sb or ""      # (b)
    return "semantic_divergence", sa or "", sb or ""     # (d) RED FLAG


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--src", default=str(DEFAULT_SRC))
    ap.add_argument("--out", default="step6_diff.csv",
                    help="출력 CSV 파일명 (OUT_DIR 기준). 축별 측정 시 분리 저장용")
    ap.add_argument("--limit", type=int, default=0, help="앞 N개만 (0=전체)")
    args = ap.parse_args()

    OUT_DIR.mkdir(parents=True, exist_ok=True)
    lines = Path(args.src).read_text(encoding="utf-8").splitlines()
    instrs = [l.strip() for l in lines if l.startswith("    ")]
    if args.limit:
        instrs = instrs[:args.limit]
    print(f"[Stage 6] 차등 대상 {len(instrs)}개 (as vs llvm-mc, iced 판정)")

    rows = run_differential(instrs)
    print(f"  결과 수집: {len(rows)}행")
    decode = make_decoder()

    cats = Counter()
    out_rows = []
    for r in rows:
        src = instrs[r["idx"] - 1] if r["idx"] - 1 < len(instrs) else ""
        cat, sa, sb = classify(r, decode)
        cats[cat] += 1
        out_rows.append({"idx": r["idx"], "source": src, "category": cat,
                         "as_ok": r["as_ok"], "as_hex": r["as_hex"],
                         "llvm_ok": r["llvm_ok"], "llvm_hex": r["llvm_hex"],
                         "iced_as": sa, "iced_llvm": sb})

    with (OUT_DIR / args.out).open("w", newline="", encoding="utf-8-sig") as f:
        w = csv.DictWriter(f, fieldnames=["idx", "source", "category", "as_ok", "as_hex",
                                          "llvm_ok", "llvm_hex", "iced_as", "iced_llvm"])
        w.writeheader()
        w.writerows(out_rows)

    n = len(out_rows)
    print(f"\n=== 분류 (n={n}) ===")
    order = ["byte_identical", "equiv_encoding", "support_diff",
             "semantic_divergence", "decode_disagree", "both_reject"]
    for k in order:
        if cats.get(k):
            print(f"  {cats[k]:5d}  {k}")
    flags = cats.get("semantic_divergence", 0) + cats.get("support_diff", 0) + cats.get("decode_disagree", 0)
    print(f"\n  >>> 핵심 지표(불일치) = (c)support_diff {cats.get('support_diff',0)}"
          f" + (d)semantic_divergence {cats.get('semantic_divergence',0)}"
          f" + (f)decode_disagree {cats.get('decode_disagree',0)} = {flags}")

    # red flag 샘플 출력
    for tag in ["semantic_divergence", "decode_disagree", "support_diff"]:
        ex = [r for r in out_rows if r["category"] == tag][:8]
        if ex:
            print(f"\n  [{tag}] 샘플:")
            for e in ex:
                print(f"    {e['source'][:34]:34} as={e['as_hex'] or '-':16} llvm={e['llvm_hex'] or '-':16}"
                      f" | iced_as={e['iced_as'][:20]} / iced_llvm={e['iced_llvm'][:20]}")
    print(f"\n[저장] {OUT_DIR}/{args.out}")


if __name__ == "__main__":
    main()

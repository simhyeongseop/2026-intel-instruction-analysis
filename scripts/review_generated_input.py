"""생성된 입력을 사람이 직접 확인할 수 있게 표로 뽑는다.

"이 줄이 매뉴얼대로 만들어졌는가"는 도구가 대신 판단할 수 없다. 그래서 이 스크립트는
판정을 하지 않고, 판단에 필요한 것만 한자리에 모아 준다:
  - 매뉴얼 원문(raw_instruction)과 PDF 쪽수
  - 매뉴얼의 기대(mode_support)
  - 우리가 생성한 줄, 수정 전 줄(바뀐 경우)
  - as 가 실제로 내놓은 결과와 바이트
  - 그 자리에서 다시 돌려볼 수 있는 명령

사용:
  python3 scripts/review_generated_input.py --changed          # 이번에 값이 바뀐 줄 전부
  python3 scripts/review_generated_input.py --kind memory_rip --sample 10
"""

import argparse
import csv
from pathlib import Path
import random
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from pipeline.instruction_check import assemble

OUT_MD = ROOT / "out/review/input_review.md"
HEADER = ".intel_syntax noprefix\n.Ltarget:\n"
VARIANT_RE = re.compile(r"variant:(\w+)")


def read_csv(path):
    with open(path, newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))


def source_line(row):
    return f"{row['mnemonic'].lower()} {row['operands']}".strip()


def changed_rows(combos, baseline):
    """기준선과 값이 달라진 combo (수정으로 바뀐 줄)."""
    before = {(r["row_id"], r["combo_index"]): r["operands"] for r in baseline}
    out = []
    for row in combos:
        key = (row["row_id"], row["combo_index"])
        if key in before and before[key] != row["operands"]:
            out.append((row, f"{row['mnemonic'].lower()} {before[key]}".strip()))
    return out


def variant_rows(combos, kind, sample, seed):
    """변형 combo 중 표본."""
    picked = [r for r in combos
              if (m := VARIANT_RE.search(r["note"])) and (kind is None or m.group(1) == kind)]
    random.Random(seed).shuffle(picked)
    return [(r, "") for r in picked[:sample]]


def observe(line):
    """as 관측. 판정하지 않고 상태와 바이트만 가져온다."""
    result = assemble(HEADER + line + "\n")
    error = ""
    if result["status"] != "accepted":
        messages = [x for x in result["assembly"]["stderr"].splitlines() if "Error" in x]
        error = messages[-1].split(":", 3)[-1].strip() if messages else result["status"]
    return result["status"], result["bytes"], error, result["observation_status"]


def render(row, before_line):
    """확인용 항목 하나를 Markdown 으로."""
    line = source_line(row)
    status, text_bytes, error, observed = observe(line)
    variant = VARIANT_RE.search(row["note"])
    lines = [
        f"### combo {row['combo_id']} · {row['mnemonic']}"
        + (f" · 변형 {variant.group(1)}" if variant else ""),
        "",
        f"- 매뉴얼 원문: `{row['raw_instruction']}`  (PDF {row['source_page']}쪽)",
        f"- 매뉴얼 기대: {row['mode_support']} (expected_valid={row['expected_valid']})",
    ]
    if before_line:
        lines.append(f"- 수정 전: `{before_line}`")
    lines += [
        f"- 생성된 줄: `{line}`",
        f"- as 결과: **{status}**" + (f" / 바이트 `{' '.join(re.findall('..', text_bytes))}`" if text_bytes else "")
        + (f" / 오류 `{error}`" if error else ""),
    ]
    if observed not in ("accepted", "diagnostic_rejection"):
        lines.append(f"- ⚠ 관측 상태: {observed} (정상 거부가 아니다)")
    lines += [
        "- 재현: `printf '.intel_syntax noprefix\\n.Ltarget:\\n" + line + "\\n' > /tmp/x.s && as --64 -mintel64 /tmp/x.s -o /tmp/x.o`",
        "- 판단: ☐ 맞음  ☐ 틀림  ☐ 보류 →  메모: ",
        "",
    ]
    return lines


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--changed", action="store_true", help="수정으로 값이 바뀐 줄")
    parser.add_argument("--kind", help="변형 종류 (memory_sib, memory_rip, imm_max, avx512_mask, avx512_bcst)")
    parser.add_argument("--sample", type=int, default=5, help="변형 종류별 표본 수")
    parser.add_argument("--seed", type=int, default=20260919)
    args = parser.parse_args()

    combos = read_csv(ROOT / "data/db/combos.csv")
    baseline = read_csv(ROOT / "tests/baseline/combos_2026-09-15.csv")

    items = []
    if args.changed:
        items += changed_rows(combos, baseline)
    if args.kind or not args.changed:
        kinds = [args.kind] if args.kind else sorted(
            {m.group(1) for r in combos if (m := VARIANT_RE.search(r["note"]))})
        for kind in kinds:
            items += variant_rows(combos, kind, args.sample, args.seed)

    body = ["# 생성 입력 확인표", "",
            "판정은 들어 있지 않다. 각 항목을 보고 직접 ☐ 에 표시하면 된다.", "",
            f"항목 {len(items)}개", ""]
    for row, before in items:
        body += render(row, before)

    OUT_MD.parent.mkdir(parents=True, exist_ok=True)
    OUT_MD.write_text("\n".join(body) + "\n", encoding="utf-8")
    print(f"항목 {len(items)}개 -> {OUT_MD}")


if __name__ == "__main__":
    main()

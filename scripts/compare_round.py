"""수정 전후를 대조해서 "내 수정이 무엇을 바꿨는지"를 보여준다.

가장 중요한 것은 **수용 -> 거부** 로 바뀐 줄이다. 그건 이번 수정이 깨뜨린 것일 수 있다.
반대로 거부 -> 수용은 의도한 개선이지만, 그것도 그냥 좋은 소식으로 넘기지 않고 목록으로 남긴다.

비교 기준은 수정 전에 저장해 둔 스냅샷이다:
  tests/baseline/asm_result_2026-08-24.csv

사용: python3 scripts/compare_round.py
"""

import csv
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
BEFORE = ROOT / "tests/baseline/asm_result_2026-08-24.csv"
AFTER = ROOT / "out/asm_result.csv"
OUT_MD = ROOT / "out/review/round_diff.md"


def read_csv(path):
    with open(path, newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))


def index_by_combo(rows):
    return {r["combo_id"]: r for r in rows}


def transitions(before, after):
    """공통 combo 의 수용 상태 변화."""
    moved = {"ok->error": [], "error->ok": [], "line_changed": [], "same": 0}
    for combo_id, old in before.items():
        new = after.get(combo_id)
        if new is None:
            continue
        if old["actual_result"] != new["actual_result"]:
            moved[f"{old['actual_result']}->{new['actual_result']}"].append((combo_id, old, new))
        else:
            moved["same"] += 1
        if old["asm_line"] != new["asm_line"]:
            moved["line_changed"].append((combo_id, old, new))
    return moved


def section(title, items, limit=40):
    lines = [f"## {title} ({len(items)}건)", ""]
    if not items:
        lines += ["없음", ""]
        return lines
    lines += ["| combo | 수정 전 | 수정 후 | 수정 후 결과 |", "|---|---|---|---|"]
    for combo_id, old, new in items[:limit]:
        note = new.get("error_message", "")[:60] or new["actual_result"]
        lines.append(f"| {combo_id} | `{old['asm_line']}` | `{new['asm_line']}` | {note} |")
    if len(items) > limit:
        lines.append(f"| … | 외 {len(items) - limit}건 | | |")
    lines.append("")
    return lines


def main():
    if not AFTER.is_file():
        print("out/asm_result.csv 가 없다. 5단계를 먼저 실행한다.")
        return 1
    before = index_by_combo(read_csv(BEFORE))
    after = index_by_combo(read_csv(AFTER))
    moved = transitions(before, after)
    new_ids = set(after) - set(before)

    body = ["# 수정 전후 비교", "",
            f"- 수정 전: {len(before):,}행 (기준선 스냅샷)",
            f"- 수정 후: {len(after):,}행 (신규 {len(new_ids):,}행은 이번에 추가한 변형)",
            f"- 결과가 같은 공통 combo: {moved['same']:,}행", ""]
    body += section("⚠ 수용 → 거부 (이번 수정이 깨뜨렸을 수 있음)", moved["ok->error"])
    body += section("거부 → 수용 (의도한 개선인지 확인)", moved["error->ok"])
    body += section("줄 내용이 바뀐 것", moved["line_changed"])

    OUT_MD.parent.mkdir(parents=True, exist_ok=True)
    OUT_MD.write_text("\n".join(body) + "\n", encoding="utf-8")
    print(f"수용→거부 {len(moved['ok->error'])}건 / 거부→수용 {len(moved['error->ok'])}건 "
          f"/ 줄 변경 {len(moved['line_changed'])}건 / 신규 {len(new_ids):,}행")
    print(f"보고서: {OUT_MD}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

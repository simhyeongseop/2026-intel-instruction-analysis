"""파이프라인 '절차상 오류'를 자동으로 점검한다.

이 도구는 명령어가 맞는지 틀리는지를 보지 않는다. 그건 사람이 판단할 일이다.
여기서 보는 것은 "결과 파일들이 서로 같은 입력에서 나왔는가", "판정이 남아 있는가"
처럼 사람이 눈으로 세기 어려운 절차상 문제다.

실행: python3 scripts/check_pipeline_health.py
종료 코드: FAIL 이 하나라도 있으면 1
"""

import csv
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
REPORT = ROOT / "out/review/health_report.md"


def read_csv(path):
    if not path.is_file():
        return None
    with open(path, newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))


def read_source_lines(path):
    """out/tests.s 에서 combo_id -> 명령어 줄."""
    lines = {}
    if not path.is_file():
        return lines
    with open(path, encoding="utf-8") as f:
        for line in f:
            if "# combo_id=" not in line:
                continue
            code, tag = line.split("#", 1)
            lines[tag.split("combo_id=")[1].split()[0]] = code.strip()
    return lines


def check_generated_matches_combos(results, combos, sources):
    """3단계 결과와 4단계 소스가 같은 세대인가."""
    combo_ids = {r["combo_id"] for r in combos}
    missing = combo_ids - set(sources)
    extra = set(sources) - combo_ids
    if missing or extra:
        results.append(("FAIL", f"combos.csv 와 tests.s 세대 불일치 (소스 없음 {len(missing)}, 여분 {len(extra)})"))
    else:
        results.append(("OK", f"combos.csv ↔ tests.s 일치 ({len(combo_ids):,}행)"))


def check_stage_is_current(results, name, rows, sources):
    """5단계 이후 산출물이 현재 tests.s 에서 나온 것인가.

    combo_id 만 보면 옛 결과를 못 잡는다. 소스 문자열까지 대조한다.
    """
    if rows is None:
        results.append(("WARN", f"{name} 없음 - 해당 단계를 아직 실행하지 않았다"))
        return
    stale = [r["combo_id"] for r in rows
             if r.get("asm_line") and sources.get(r["combo_id"], "") != r["asm_line"]]
    missing = [r["combo_id"] for r in rows if r["combo_id"] not in sources]
    if stale or missing:
        results.append(("FAIL", f"{name} 이 현재 tests.s 기준이 아니다 "
                                f"(소스 다름 {len(stale):,}, 사라진 combo {len(missing):,}) - 재실행 필요"))
    elif len(rows) < len(sources):
        results.append(("WARN", f"{name} 행 수 {len(rows):,} < 소스 {len(sources):,} - 일부만 실행됐다"))
    else:
        results.append(("OK", f"{name} 이 현재 tests.s 기준 ({len(rows):,}행)"))


def check_ids_stable(results, combos):
    """과거 판정이 참조하는 combo_id 가 그대로인가."""
    baseline = read_csv(ROOT / "tests/baseline/combos_2026-09-15.csv")
    if baseline is None:
        results.append(("WARN", "기준선 스냅샷 없음 - ID 안정성을 확인할 수 없다"))
        return
    current = {(r["row_id"], r["combo_index"]): r["combo_id"] for r in combos}
    moved = [r["combo_id"] for r in baseline
             if current.get((r["row_id"], r["combo_index"])) != r["combo_id"]]
    if moved:
        results.append(("FAIL", f"combo_id 가 이동한 행 {len(moved):,}건 - 과거 판정과 어긋난다"))
    else:
        results.append(("OK", f"기준선 {len(baseline):,}행의 combo_id 유지"))


def check_review_sources(results, combos):
    """재심 판정이 소스 문자열까지 고정한 사례가 그대로인가."""
    sys.path.insert(0, str(ROOT))
    from pipeline.review_verdicts import REVIEW
    current = {r["combo_id"]: f"{r['mnemonic'].lower()} {r['operands']}".strip() for r in combos}
    broken = [cid for cid, case in REVIEW.items()
              if current.get(cid, "").replace(" ", "") != case[0].replace(" ", "")]
    if broken:
        results.append(("FAIL", f"재심 고정 사례 소스가 바뀌었다: {broken} - triage 가 ValueError 로 멈춘다"))
    else:
        results.append(("OK", f"재심 고정 사례 {len(REVIEW)}건의 소스 유지"))


def check_open_judgements(results):
    """사람이 아직 판정하지 않고 남겨둔 것이 얼마나 되는가."""
    triage = read_csv(ROOT / "out/triage.csv")
    if triage:
        pending = sum(1 for r in triage if r.get("review_status") == "not_reassessed")
        unsure = sum(1 for r in triage if r.get("verdict") == "unsure")
        results.append(("WARN" if pending else "OK",
                        f"triage 미재심 {pending:,}건 / unsure {unsure:,}건 (확정으로 보고하지 말 것)"))
    checklist = read_csv(ROOT / "review/false_alarm_checklist.csv")
    if checklist:
        blank = sum(1 for r in checklist if not (r.get("내_판단") or "").strip())
        results.append(("WARN" if blank else "OK", f"체크리스트 판정 미기입 {blank:,}/{len(checklist):,}행"))


def check_objects(results):
    """6·9·10단계를 다시 돌릴 수 있는 상태인가."""
    for name in ("objects", "clang_objects"):
        folder = ROOT / "out" / name
        count = len(list(folder.glob("*.o"))) if folder.is_dir() else 0
        results.append(("WARN" if count == 0 else "OK", f"out/{name}: 오브젝트 {count:,}개"))


def check_last_run(results):
    """마지막 실행에서 어느 단계가 돌았고 어느 단계가 생략됐는가."""
    runs = sorted((ROOT / "out/runs").glob("*.json"))
    if not runs:
        results.append(("WARN", "실행 기록 없음"))
        return
    record = json.loads(runs[-1].read_text(encoding="utf-8"))
    stages = [f"{s['stage']}({s['status']})" for s in record.get("steps", [])]
    results.append(("OK", f"마지막 실행 {runs[-1].name}: {', '.join(stages) or '단계 없음'}"))


def write_report(results):
    REPORT.parent.mkdir(parents=True, exist_ok=True)
    lines = ["# 파이프라인 건전성 점검", "",
             "이 표는 절차상 오류만 본다. 명령어의 옳고 그름은 사람이 판단한다.", ""]
    lines += ["| 상태 | 내용 |", "|---|---|"]
    lines += [f"| {status} | {message} |" for status, message in results]
    REPORT.write_text("\n".join(lines) + "\n", encoding="utf-8")


def main():
    combos = read_csv(ROOT / "data/db/combos.csv") or []
    sources = read_source_lines(ROOT / "out/tests.s")

    results = []
    check_generated_matches_combos(results, combos, sources)
    check_ids_stable(results, combos)
    check_review_sources(results, combos)
    check_stage_is_current(results, "asm_result.csv(5단계)", read_csv(ROOT / "out/asm_result.csv"), sources)
    check_stage_is_current(results, "clang_result.csv(8단계)", read_csv(ROOT / "out/clang_result.csv"), sources)
    check_objects(results)
    check_open_judgements(results)
    check_last_run(results)

    for status, message in results:
        print(f"[{status:<4}] {message}")
    write_report(results)
    print(f"\n보고서: {REPORT}")
    return 1 if any(s == "FAIL" for s, _ in results) else 0


if __name__ == "__main__":
    sys.exit(main())

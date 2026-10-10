"""전체 도달 지도(conflict_tests/all_results.csv)에서 생성기 재작성 때 고칠 행을 유형별로 모은다.

    python3 scripts/build_generator_issues.py

결과: out/sdm_review_093/compare/generator_issues.csv
유형은 기계 규칙으로 정한다(아래 classify). 예외 목록(source_conflict_cases.csv)에 '예외'로 등록한 행은 뺀다.
"""

import collections
import csv
import os
import re

RESULTS = "out/sdm_review_093/conflict_tests/all_results.csv"
CASES = "out/sdm_review_093/conflict_tests/all_cases.csv"
OUT = "out/sdm_review_093/compare/generator_issues.csv"
PASSED = ("통과", "통과(GNU 단독)", "음성 케이스", "도달 불가(별칭)", "도달 불가(문법)")
FIX = {
    "imm1_shift_alias": "C0/C1 시프트·회전 행에 imm8=1을 쓰지 않는다(두 도구 모두 D0/D1 1비트 행을 고름)",
    "evex_not_forced": "EVEX 행인데 {evex}로도 표 행에 도달하지 못함. 형식별 강제 방법 확인 필요",
    "operand_size_prefix": "16비트 즉시값 행(66 접두어 필요)을 니모닉 접미사(pushw 등)로 지정해야 함",
    "far_return": "far RET(CB/CA)은 'ret'이 아니라 'retf/lret'으로 써야 함",
    "negative_source_alias": "64비트 무효 인코딩의 음성 케이스가 같은 니모닉의 유효 행으로 조립됨. 니모닉 소스로 음성 시험을 만들 수 없음",
    "known_tool_case": "기존에 기록한 도구 사례(MOV Sreg REX.W 메모리: 사용자 확인 대기)",
    "tool_unsupported": "생성기 문제 아님: 표 기준으로 정했으나 GNU as 2.42·clang 18이 이 명령을 모름"
                        "(source_conflict_cases '표 기준 생성(도구 미지원)'). 새 도구 버전으로 다시 대조",
    "other": "개별 확인 필요",
}
TOOL_UNSUPPORTED_ROWS = {r["row_id"] for r in csv.DictReader(open("data/rules/source_conflict_cases.csv", encoding="utf-8"))
                         if r["decision"] == "표 기준 생성(도구 미지원)"}


def read_csv(path):
    with open(path, encoding="utf-8", newline="") as handle:
        return list(csv.DictReader(handle))


def classify(row, bad):
    opcode, source = row["opcode"], bad[0]["tested_source"]
    if bad[0]["row_id"] in TOOL_UNSUPPORTED_ROWS and all(
            r["gnu_status"] != "accepted" and r["clang_status"] != "accepted" for r in bad):
        return "tool_unsupported"
    if re.match(r"(REX\.W \+ )?C[01] /[0-7] ib$", opcode) and re.search(r",\s*1$", source):
        return "imm1_shift_alias"
    if opcode.startswith("EVEX") and bad[0]["gnu_bytes"].startswith(("c4", "c5", "67c4", "67c5")):
        return "evex_not_forced"
    if re.search(r"\biw\b", opcode) and opcode.split()[0] in ("68", "6A"):
        return "operand_size_prefix"
    if opcode.split()[0] in ("CB", "CA"):
        return "far_return"
    if all(r["test_kind"] == "negative" for r in bad):
        return "negative_source_alias"
    if row["mnemonic"] == "MOV":
        return "known_tool_case"
    return "other"


def main():
    exceptions = {r["row_id"] for r in read_csv("data/rules/source_conflict_cases.csv") if r["decision"].startswith("예외")}
    by_row = collections.defaultdict(list)
    for result in read_csv(RESULTS):
        by_row[result["row_id"]].append(result)
    isa = read_csv("data/db/isa_db.csv")
    out = []
    for case in read_csv(CASES):
        if case["row_id"] in exceptions or case["row_verdict"] in ("통과", "통과(GNU 단독·도달 불가 포함)", "음성 확인"):
            continue
        results = by_row[case["row_id"]]
        bad = [r for r in results if r["verdict"] not in PASSED] or \
              [r for r in results if r["test_kind"] == "negative" and "accepted" in (r["gnu_status"], r["clang_status"])]
        row = isa[int(case["row_id"])]
        kind = classify(row, bad)
        out.append({"row_id": case["row_id"], "mnemonic": row["mnemonic"], "opcode": row["opcode"],
                    "instruction": row["instruction"], "mode_support": row["mode_support"], "issue": kind,
                    "fix_hint": FIX[kind], "failing_cases": len(bad),
                    "example_source": bad[0]["tested_source"], "example_gnu_bytes": bad[0]["gnu_bytes"]})
    with open(OUT, "w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(out[0].keys()))
        writer.writeheader()
        writer.writerows(out)
    print(len(out), dict(collections.Counter(o["issue"] for o in out)))


if __name__ == "__main__":
    main()

"""3단계 판정: 생성 케이스를 GNU as, clang으로 따로 조립하고 각각을 SDM 기대 결과와 비교한다.

    python3 pipeline/m3_check.py [--cases out/cases] [--workers 8] [--execute]

판정 기준(사용자 결정 2026-10-11): SDM 대 GNU, SDM 대 clang을 따로 본다. 두 도구를 서로 비교하지 않는다.
두 도구의 바이트가 같은지는 기록하지 않는다.

도구별 판정(verdict_as, verdict_clang)
- expected=reach
  - SDM 일치: 받아들였고 바이트가 표 행 인코딩과 맞음(pipeline.encoding_audit, data/rules/encoding_check_overrides.csv)
  - SDM 일치(강제 접두어): 원래 소스는 다른 인코딩이었고, 그 도구의 의사 접두어({evex} 등)로 표 행에 도달
  - 별칭 행 도달: 같은 소스를 내는 다른 표 행(alias_rows)의 인코딩이 나옴. 소스로 이 행을 지정할 수 없음
  - 다른 인코딩: 받아들였지만 이 행도 별칭 행도 아님
  - 도달 불가(등록): 거부·다른 인코딩인데 data/rules/unreachable_forms.csv에 근거와 함께 등록한 형식(LAR r32, r64 등)
  - 인코딩 미대조: 받아들였지만 대조 도구가 이 opcode 표기를 읽지 못함
  - 모르는 명령: 도구가 니모닉 자체를 모름(GNU "no such instruction", clang "invalid instruction mnemonic")
  - 거부: 도구가 그 밖의 이유로 거부함
- expected=reject: SDM 일치(거부) / SDM과 다름(수용)
- expected=alias_no_test: 시험 불가(별칭). 받아들였는지와 나온 바이트만 기록한다
--execute: SDM 일치한 레지스터 전용 케이스를 이 CPU가 지원하면 격리 실행한다(SIGILL = #UD 관측, 기록만).
"""

import argparse
import collections
import csv
import json
import os
import re
import sys
import tempfile
from concurrent.futures import ThreadPoolExecutor

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline.encoding_audit import check_encoding  # noqa: E402
from pipeline.instruction_check import assemble  # noqa: E402
from pipeline.m2_generate import ASM_HEADER  # noqa: E402

OVERRIDES = os.path.join(ROOT, "data/rules/encoding_check_overrides.csv")
UNREACHABLE = os.path.join(ROOT, "data/rules/unreachable_forms.csv")
CONFLICT_CASES = os.path.join(ROOT, "data/rules/source_conflict_cases.csv")
TOOLS = ("as", "clang")
# 도구가 문서로 제공하는 인코딩 지정 의사 접두어. clang은 {load}/{store}를 받지 않는다(2026-10-10 관측).
FORCING = {"as": ["{evex} ", "{vex3} ", "{vex} ", "{load} ", "{store} ", "{evex} {load} ", "{evex} {store} ", "rex64 "],
           "clang": ["{evex} ", "{vex3} ", "{vex} "]}
NOT_ON_THIS_CPU = re.compile(r"AVX512|AVX10|AMX|FRED|HRESET|AVX-VNNI-INT|KL\b|AESKLE|APX", re.I)
FLAG_NAMES = {"SSE4_1": "sse4_1", "SSE4_2": "sse4_2", "BMI1": "bmi1", "BMI2": "bmi2", "PCLMULQDQ": "pclmulqdq",
              "SSE": "sse", "SSE2": "sse2", "SSE3": "pni", "SSSE3": "ssse3", "AVX": "avx", "AVX2": "avx2",
              "MOVBE": "movbe", "PREFETCHW": "3dnowprefetch", "LAHF": "lahf_lm", "MMX": "mmx", "FMA": "fma",
              "F16C": "f16c", "POPCNT": "popcnt", "LZCNT": "abm", "VPCLMULQDQ": "vpclmulqdq"}


def read_csv(path):
    with open(path, encoding="utf-8", newline="") as handle:
        return list(csv.DictReader(handle))


def write_csv(path, rows):
    with open(path, "w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(rows[0].keys()))
        writer.writeheader()
        writer.writerows(rows)


def encoding(hex_bytes, row, relocations, override):
    """한 표 행 기준 인코딩 대조: fields_match / different_encoding / not_checked."""
    if not hex_bytes:
        return "not_checked"
    if override and override["byte_pattern"]:
        return "fields_match" if re.match(override["byte_pattern"], hex_bytes) else "different_encoding"
    checked = dict(row, opcode=override["check_opcode"]) if override and override["check_opcode"] else row
    return check_encoding(hex_bytes, checked, relocations)["status"]


class Assembler:
    """같은 (도구, 소스)는 한 번만 조립한다."""

    def __init__(self):
        self.cache = {}

    def run(self, tool, source):
        if (tool, source) not in self.cache:
            result = assemble(ASM_HEADER + source + "\n", tool)
            self.cache[(tool, source)] = {
                "status": result["observation_status"], "bytes": result["bytes"],
                "relocations": result.get("relocations"),
                "diagnostic": " ".join((result["assembly"].get("stderr") or "").split())[-200:],
            }
        return self.cache[(tool, source)]

    def prefill(self, jobs, workers):
        jobs = [j for j in dict.fromkeys(jobs) if j not in self.cache]
        with ThreadPoolExecutor(max_workers=max(1, workers)) as pool:
            for job, _ in zip(jobs, pool.map(lambda j: self.run(*j), jobs)):
                pass


def check_row(isa_row, case):
    """대조 도구에 넘길 행: 표 opcode와 표 기호(operand_types), 실제 오퍼랜드(operands: CR8·moffs 값 대조용)."""
    return dict(isa_row, operand_types=isa_row["operands"], operands=case["operands"])


def judge(case, tool, asm, isa, overrides, unreachable=None):
    """한 도구의 판정과 근거 필드."""
    row = check_row(isa[int(case["row_id"])], case)
    observed = asm.run(tool, case["source"])
    out = {"status": observed["status"], "bytes": observed["bytes"], "tested_source": case["source"],
           "reached_row": "", "diagnostic": observed["diagnostic"] if observed["status"] != "accepted" else ""}
    own = encoding(observed["bytes"], row, observed["relocations"], overrides.get(int(case["row_id"])))
    if case["expected"] == "reject":
        out["verdict"] = "SDM 일치(거부)" if observed["status"] != "accepted" else "SDM과 다름(수용)"
        return out
    if case["expected"] == "alias_no_test":
        out["verdict"] = "시험 불가(별칭)"
        return out
    if observed["status"] != "accepted":
        unknown = re.search(r"no such instruction|invalid instruction mnemonic", observed["diagnostic"])
        out["verdict"] = "모르는 명령" if unknown else "거부"
        return out if unknown else registered(out, case, unreachable)
    if own == "fields_match":
        out["verdict"] = "SDM 일치"
        return out
    if own == "not_checked":
        out["verdict"] = "인코딩 미대조"
        return out
    for prefix in FORCING[tool]:
        trial = asm.run(tool, prefix + case["source"])
        if trial["status"] == "accepted" and encoding(trial["bytes"], row, trial["relocations"],
                                                       overrides.get(int(case["row_id"]))) == "fields_match":
            out.update(verdict="SDM 일치(강제 접두어)", tested_source=prefix + case["source"], bytes=trial["bytes"])
            return out
    for other in case["alias_rows"].split():
        if encoding(observed["bytes"], check_row(isa[int(other)], case), observed["relocations"],
                    overrides.get(int(other))) == "fields_match":
            out.update(verdict="별칭 행 도달", reached_row=other)
            return out
    out["verdict"] = "다른 인코딩"
    return registered(out, case, unreachable)


def registered(out, case, unreachable):
    """data/rules/unreachable_forms.csv에 근거와 함께 등록한 형식(별칭 opcode, 도구가 받지 않는 표 문법)."""
    entry = (unreachable or {}).get(int(case["row_id"]))
    if entry and ("[" in case["source"]) == (entry["form"] == "memory"):
        out["verdict"] = "도달 불가(등록)"
        out["diagnostic"] = (out["diagnostic"] + " | " if out["diagnostic"] else "") + entry["reason"][:120]
    return out


def cpu_flags():
    try:
        with open("/proc/cpuinfo", encoding="utf-8") as handle:
            for line in handle:
                if line.startswith("flags"):
                    return set(line.split(":", 1)[1].split())
    except OSError:
        pass
    return set()


def why_not_runnable(case, flags):
    if "[" in case["source"] or ".Ltarget" in case["source"]:
        return "메모리·분기 형식"
    if case["opcode"].startswith("EVEX") or NOT_ON_THIS_CPU.search(case["cpuid_flag"]):
        return "이 CPU에 없는 기능"
    names = [t for t in re.split(r"[^A-Za-z0-9_]+", case["cpuid_flag"]) if t and t not in ("AND", "OR")]
    unknown = [t for t in names if t not in FLAG_NAMES]
    if unknown:
        return "CPUID 표기 대응 없음(%s)" % ",".join(unknown)
    missing = [t for t in names if FLAG_NAMES[t] not in flags]
    return "CPU 미지원(%s)" % ",".join(missing) if missing else ""


def run_on_cpu(results, cases, flags):
    """SDM 일치(GNU)한 레지스터 전용 케이스를 격리 실행한다. CPUID 칸이 있는 행의 SIGILL만 #UD 관측으로 적는다."""
    from pipeline import m11_execute as m11
    with tempfile.TemporaryDirectory(prefix="m3_run_") as folder:
        for result, case in zip(results, cases):
            if not result["verdict_as"].startswith("SDM 일치") or case["expected"] != "reach":
                continue
            reason = why_not_runnable(case, flags)
            if reason:
                result["run"] = "실행 안 함: " + reason
                continue
            data = result["bytes_as"]
            body = ".byte " + ", ".join("0x" + data[i:i + 2] for i in range(0, len(data), 2))
            status, error, _ = m11.build_and_run({"name": "c" + case["case_id"].replace("-", "_"),
                                                  "body": body + m11.EXIT_CLEAN}, folder)
            result["run"] = status if not error else status + ": " + error
            if status == "SIGILL" and case["cpuid_flag"].strip():
                result["run"] += " (#UD 관측: CPUID 기능 있음)"


def summarize(results):
    per_tool = {tool: dict(collections.Counter(r["verdict_" + tool] for r in results)) for tool in TOOLS}
    trusted = [r for r in results if r["spec_trusted"] == "예"]
    ok = ("SDM 일치", "SDM 일치(강제 접두어)", "SDM 일치(거부)")
    return {
        "cases": len(results), "spec_trusted": len(trusted),
        "expected": dict(collections.Counter(r["expected"] for r in results)),
        "verdicts": per_tool,
        "sdm_match": {tool: sum(r["verdict_" + tool] in ok for r in results) for tool in TOOLS},
        "spec_trusted_and_sdm_match": {tool: sum(r["verdict_" + tool] in ok for r in trusted) for tool in TOOLS},
    }


def row_summary(results):
    rows = collections.OrderedDict()
    for r in results:
        rows.setdefault(r["row_id"], []).append(r)
    out = []
    for row_id, mine in rows.items():
        entry = {"row_id": row_id, "mnemonic": mine[0]["mnemonic"], "instruction": mine[0]["instruction"],
                 "opcode": mine[0]["opcode"], "expected": "/".join(sorted({m["expected"] for m in mine})),
                 "cases": len(mine)}
        for tool in TOOLS:
            counts = collections.Counter(m["verdict_" + tool] for m in mine)
            entry["verdicts_" + tool] = "; ".join("%s %d" % kv for kv in counts.most_common())
        out.append(entry)
    return out


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--cases", default=os.path.join(ROOT, "out/cases"))
    parser.add_argument("--workers", type=int, default=8)
    parser.add_argument("--execute", action="store_true")
    args = parser.parse_args()

    cases = read_csv(os.path.join(args.cases, "cases.csv"))
    isa = read_csv(os.path.join(ROOT, "data/db/isa_db.csv"))
    overrides = {int(r["row_id"]): r for r in read_csv(OVERRIDES)}
    unreachable = {int(r["row_id"]): r for r in read_csv(UNREACHABLE)}
    unsupported = {r["row_id"] for r in read_csv(CONFLICT_CASES) if r["decision"] == "표 기준 생성(도구 미지원)"}
    asm = Assembler()
    asm.prefill([(tool, c["source"]) for c in cases for tool in TOOLS], args.workers)
    results = []
    for case in cases:
        result = {k: case[k] for k in ("case_id", "row_id", "mnemonic", "instruction", "opcode", "cpuid_flag",
                                       "row_status", "spec_trusted", "expected", "alias_rows", "variant", "source")}
        for tool in TOOLS:
            judged = judge(case, tool, asm, isa, overrides, unreachable)
            for key in ("verdict", "status", "bytes", "tested_source", "reached_row", "diagnostic"):
                result["%s_%s" % (key, tool)] = judged[key]
        result["note"] = "도구 미지원 등록 행(source_conflict_cases)" if case["row_id"] in unsupported else ""
        result["run"] = ""
        results.append(result)
    if args.execute:
        run_on_cpu(results, cases, cpu_flags())
    write_csv(os.path.join(args.cases, "check_results.csv"), results)
    write_csv(os.path.join(args.cases, "check_rows.csv"), row_summary(results))
    summary = summarize(results)
    if args.execute:
        summary["run"] = dict(collections.Counter(r["run"].split(" (")[0] for r in results if r["run"]))
    with open(os.path.join(args.cases, "check_summary.json"), "w", encoding="utf-8") as handle:
        json.dump(summary, handle, ensure_ascii=False, indent=1)
    print(json.dumps(summary, ensure_ascii=False, indent=1))


if __name__ == "__main__":
    main()

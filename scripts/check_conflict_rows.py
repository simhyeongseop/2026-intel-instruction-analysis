"""남은 원문 충돌 행을 '표(원칙) 기준 생성 + 예외 등록 + 대조' 원칙으로 검사한다(사용자 결정 2026-10-10).

    python3 scripts/check_conflict_rows.py [--execute] [--workers 4] [--target conflicts|defects]

--target all: 전체 isa 행(최신 snapshot의 모든 케이스). 결과는 all_results.csv, all_cases.csv.
--target defects: 1단계 추출 결함 행(sdm_review_compare.extraction_defects)을 같은 방식으로 대조한다.
  결과는 defect_results.csv, defect_cases.csv에 쓴다(보정값: data/rules/extraction_corrections.csv).

대상: Sol 공통 기준(sdm_review_compare)으로 '원문 충돌'인 행 중, check_source_conflicts.py가 따로 다루는
VEX.L·EVEX 문단 사례(source_conflict_cases.csv의 vex_l, evex_desc)를 뺀 행. 영향 연결 결과에 의존하지 않는다. 시험 형식은 기존 생성기가 표 기준으로 만든
최신 snapshot의 케이스를 그대로 쓴다(code(row) = 실제 생성 소스).
케이스마다:
- GNU as / clang 조립, 두 바이트가 같은지
- 두 바이트가 표 opcode 칸과 맞는지(pipeline.encoding_audit.check_encoding, fields_match)
- --execute: 레지스터만 쓰는 형식이고 이 CPU가 CPUID 기능을 지원하면 격리된 자식 프로세스로 실행(SIGILL = #UD)
표 행에 도달하지 못한 케이스(인코딩 대조가 different_encoding)는 의사 접두어로 그 행의 인코딩을 강제해 다시 조립한다:
  {evex}, {vex3}, {store}, {load}, rex64와 그 조합(VARIANTS 순서). {store}/{load}는 clang이 받지 않고,
  clang은 rex64를 받지만 REX.W를 내지 않는다(2026-10-10 관측). 그래서 이런 행은 GNU에서만 도달할 수 있다.
대조 도구가 읽지 못하는 표 opcode 표기와 원문 누락(ib 등)은 data/rules/encoding_check_overrides.csv에
근거와 함께 하드코딩한 대조용 opcode(check_opcode) 또는 손으로 해석한 바이트 패턴(byte_pattern)으로 대조한다.
판정(verdict):
- 통과: GNU·clang 모두 표 행에 도달(fields_match), 바이트 같음, 지원 CPU에서 SIGILL 아님
- 통과(GNU 단독): GNU만 표 행에 도달. clang은 의사 접두어 거부·다른 인코딩·거부 중 하나이며 clang_note에 남긴다
- 조립 일치(인코딩 미대조): 인코딩 대조 도구가 이 형식을 다루지 못함(not_checked). 통과로 세지 않는다
- 불일치: GNU도 어떤 형식으로도 표 행에 도달하지 못함, 또는 지원 CPU에서 SIGILL
- 도달 불가(문법): 같은 목록의 형식인데 GNU가 표 문법 자체를 거부(LAR r32, r64 등, 근거는 목록의 evidence)
- 도달 불가(별칭): data/rules/unreachable_forms.csv에 하드코딩한 별칭 opcode 쌍의 해당 형식(form 칸: memory/register). 니모닉 문법으로
  표 행을 지정할 수 없음(10월 9일 결정 2의 방향 쌍과 같은 처리). 행 판정에서는 막지 않는다
- 음성 케이스: test_kind=negative(모드 무효 등). 행 판정에 쓰지 않는다. 음성 케이스만 있는 행은 두 도구가
  모두 거부하면 '음성 확인'이다. 두 도구가 받으면 실행 가능한 경우 CPU로 실행해 기록한다
store_zeroing 유형은 표가 적은 '메모리 목적지 + {k1}{z}'를 따로 만들어 두 도구가 받는지 본다(probe).
결과: out/sdm_review_093/conflict_tests/row_results.csv, row_cases.csv(행별 유형과 판정 요약)
"""

import argparse
import collections
import csv
import glob
import os
import re
import sys
import tempfile
from concurrent.futures import ThreadPoolExecutor

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)
sys.path.insert(0, os.path.join(ROOT, "scripts"))

from pipeline import m11_execute as m11  # noqa: E402
from pipeline.encoding_audit import check_encoding  # noqa: E402
from pipeline.instruction_check import assemble  # noqa: E402
from pipeline.m5_assemble import ASM_HEADER  # noqa: E402
from pipeline.sdm_review_compare import extraction_defects  # noqa: E402

REVIEW = "out/sdm_review_093"
COMBOS = "out/generator_audit_2026-10-10_093/combos.csv"
OUT_DIR = os.path.join(REVIEW, "conflict_tests")

# Sol 메모의 낱말로 충돌 유형을 나눈다(기록용 분류이며 판정에 쓰지 않는다). 위에서부터 처음 맞는 것.
CONFLICT_TYPES = [
    ("store_zeroing", r"Store.?Form|store형은 병합"),
    ("mask_not_writemask", r"not used as a writemask|writemask로 정의하나"),
    ("moffs_meaning", r"moffs"),
    ("vex_l", r"VEX\.L"),
    ("vex_w", r"VEX\.W\s*=\s*1"),
    ("string_memory_symbol", r"string instructions|SYM04[12]"),
    ("mode_validity", r"Compat/Leg|64-Bit Mode 열|compatibility mode|64비트 모드 유효성"),
    ("op_en_mismatch", r"Op/En"),
    ("table_typo", r"오기|mm128|레지스터 번호"),
    ("broadcast_description", r"broadcast"),
    ("evex_description", r"ZMM|512"),
    ("description_width", r"Description.*(bit|비트|바이트)|(\d+-bit|\d+비트).*Description|SYM040"),
]
# 이 CPU에서 실행해 볼 수 없는 기능 표기(CPUID 칸)
NOT_ON_THIS_CPU = re.compile(r"AVX512|AVX10|AMX|FRED|HRESET|AVX-VNNI-INT|KL\b|AESKLE", re.I)
FLAG_NAMES = {"SSE4_1": "sse4_1", "SSE4_2": "sse4_2", "BMI1": "bmi1", "BMI2": "bmi2", "PCLMULQDQ": "pclmulqdq",
              "SSE": "sse", "SSE2": "sse2", "SSE3": "pni", "SSSE3": "ssse3", "AVX": "avx", "AVX2": "avx2",
              "MOVBE": "movbe", "PREFETCHW": "3dnowprefetch", "LAHF": "lahf_lm", "MMX": "mmx", "FMA": "fma",
              "F16C": "f16c", "POPCNT": "popcnt", "LZCNT": "abm", "VPCLMULQDQ": "vpclmulqdq"}


def code(row):
    """과거 생성 결과(combos.csv) 한 줄의 소스. 삭제한 m4_generate.build_line과 같은 철자(검토 기록 재현용)."""
    mnemonic = row.get("asm_mnemonic") or row["mnemonic"].lower()
    text = mnemonic + (" " + row["operands"] if row["operands"] else "")
    return (row["asm_prefix"] + " " + text) if row.get("asm_prefix") else text


def read_csv(path):
    with open(path, encoding="utf-8", newline="") as handle:
        return list(csv.DictReader(handle))


def classify(text):
    for name, pattern in CONFLICT_TYPES:
        if re.search(pattern, text):
            return name
    return "other"


def cpu_flags():
    try:
        with open("/proc/cpuinfo", encoding="utf-8") as handle:
            for line in handle:
                if line.startswith("flags"):
                    return set(line.split(":", 1)[1].split())
    except OSError:
        pass
    return set()


def runnable(combo, source, flags):
    """실행해 볼 수 있으면 '', 아니면 그 이유."""
    if "[" in source or ".Ltarget" in source:
        return "메모리·분기 형식(실행 안 함)"
    if combo["opcode"].startswith("EVEX") or NOT_ON_THIS_CPU.search(combo["cpuid_flag"]):
        return "이 CPU에 없는 기능(%s)" % (combo["cpuid_flag"] or "EVEX")
    names = [t for t in re.split(r"[^A-Za-z0-9_]+", combo["cpuid_flag"]) if t and t not in ("AND", "OR")]
    unknown = [t for t in names if t not in FLAG_NAMES]
    if unknown:
        return "CPUID 표기 대응 없음(%s)" % ",".join(unknown)
    missing = [t for t in names if FLAG_NAMES[t] not in flags]
    return "CPU 미지원(%s)" % ",".join(missing) if missing else ""


VARIANTS = ["", "{evex} ", "{vex3} ", "{store} ", "{load} ", "{evex} {store} ", "{evex} {load} ", "rex64 "]
OVERRIDES = "data/rules/encoding_check_overrides.csv"
UNREACHABLE = "data/rules/unreachable_forms.csv"


def encoding_status(hex_bytes, combo, relocations, override):
    """표 opcode 또는 하드코딩한 대조용 opcode/바이트 패턴으로 인코딩을 대조한다."""
    if override and override["byte_pattern"]:
        if not hex_bytes:
            return "not_checked"
        return "fields_match" if re.match(override["byte_pattern"], hex_bytes) else "different_encoding"
    checked = dict(combo, opcode=override["check_opcode"]) if override else combo
    return check_encoding(hex_bytes, checked, relocations)["status"]


def verdict(combo, gnu, clang, sigill_counts, unreachable=False):
    if combo["test_kind"] == "negative":
        return "음성 케이스"
    if unreachable and gnu["encoding"] == "different_encoding":
        return "도달 불가(별칭)"
    if unreachable and gnu["observation_status"] != "accepted":
        return "도달 불가(문법)"
    if sigill_counts:
        return "불일치"
    if gnu["observation_status"] != "accepted" or gnu["encoding"] == "different_encoding":
        return "불일치"
    if gnu["encoding"] != "fields_match":
        return "조립 일치(인코딩 미대조)" if gnu["bytes"] == clang["bytes"] else "불일치"
    if clang["observation_status"] == "accepted" and clang["bytes"] == gnu["bytes"]:
        return "통과"
    return "통과(GNU 단독)"


def target_rows():
    """Sol 원문 상태로 계산한 충돌 행에서 따로 등록한 VEX.L·EVEX 문단 사례를 뺀다."""
    from pipeline import sdm_review_compare as cmp
    sol = cmp.load_sol(REVIEW)
    operand, condition = collections.defaultdict(list), {}
    for (row_id, index), line in sol.items():
        if index == 0:
            condition[row_id] = line["status"]
        else:
            operand[row_id].append(cmp.uniform_status(line))
    handled = {int(r["row_id"]) for r in read_csv("data/rules/source_conflict_cases.csv")
               if r["conflict_type"] in ("vex_l", "evex_desc")}
    return {row_id for row_id in set(operand) | set(condition)
            if cmp.row_status(operand[row_id], condition.get(row_id, "")) == "원문 충돌" and row_id not in handled}


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--execute", action="store_true")
    parser.add_argument("--workers", type=int, default=4)
    parser.add_argument("--target", choices=("conflicts", "defects", "all"), default="conflicts")
    args = parser.parse_args()

    if args.target == "all":
        with open("data/db/isa_db.csv", encoding="utf-8") as handle:
            conflict_rows = set(range(sum(1 for _ in csv.DictReader(handle))))
    elif args.target == "defects":
        with open("data/db/isa_db.csv", encoding="utf-8") as handle:
            conflict_rows = {i for i, r in enumerate(csv.DictReader(handle)) if extraction_defects(r)}
    else:
        conflict_rows = target_rows()
    if not conflict_rows:
        raise SystemExit("대상 충돌 행이 없다. 결과 파일을 바꾸지 않는다.")
    notes = collections.defaultdict(list)
    for path in sorted(glob.glob(os.path.join(REVIEW, "sol_part[0-9].csv"))):
        for line in read_csv(path):
            if int(line["row_id"]) in conflict_rows and line["status"] == "원문 충돌":
                notes[int(line["row_id"])].append(" ".join(
                    x for x in (line["note"], line["other_constraints"], line["data_width"]) if x))
    combos = [c for c in read_csv(COMBOS) if int(c["row_id"]) in conflict_rows]
    cache = {}

    def observe(tool, source):
        if (tool, source) not in cache:
            cache[(tool, source)] = assemble(ASM_HEADER + source + "\n", tool)
        return cache[(tool, source)]

    overrides = {int(r["row_id"]): r for r in read_csv(OVERRIDES)}
    unreachable = {int(r["row_id"]): r for r in read_csv(UNREACHABLE)}

    def tool_result(tool, source, combo):
        observed = observe(tool, source)
        override = overrides.get(int(combo["row_id"]))
        return {"observation_status": observed["observation_status"], "bytes": observed["bytes"],
                "encoding": encoding_status(observed["bytes"], combo, observed.get("relocations"), override),
                "diagnostic": " ".join((observed["assembly"].get("stderr") or "").split())[-160:]}

    # 첫 시도(원래 소스)는 한꺼번에 병렬로 조립해 둔다.
    with ThreadPoolExecutor(max_workers=max(1, args.workers)) as pool:
        firsts = sorted({code(c) for c in combos})
        for (tool, source), result in zip([(t, x) for x in firsts for t in ("as", "clang")],
                                          pool.map(lambda job: assemble(ASM_HEADER + job[1] + "\n", job[0]),
                                                   [(t, x) for x in firsts for t in ("as", "clang")])):
            cache[(tool, source)] = result

    flags = cpu_flags()
    results = []
    with tempfile.TemporaryDirectory(prefix="conflict_rows_") as tmp_dir:
        for combo in combos:
            original = code(combo)
            chosen, gnu = original, tool_result("as", original, combo)
            if gnu["encoding"] == "different_encoding" or gnu["observation_status"] != "accepted":
                for prefix in VARIANTS[1:]:
                    trial = tool_result("as", prefix + original, combo)
                    if trial["encoding"] == "fields_match":
                        chosen, gnu = prefix + original, trial
                        break
            clang = tool_result("clang", chosen, combo)
            run, sigill_counts = "", False
            reason = runnable(combo, original, flags)
            negative_accepted = combo["test_kind"] == "negative" and gnu["observation_status"] == "accepted"
            if args.execute and not reason and gnu["bytes"] and (combo["test_kind"] != "negative" or negative_accepted):
                body = ".byte " + ", ".join("0x" + gnu["bytes"][i:i + 2] for i in range(0, len(gnu["bytes"]), 2))
                status, error, _ = m11.build_and_run({"name": "c%s" % combo["combo_id"], "body": body + m11.EXIT_CLEAN},
                                                     tmp_dir)
                run = status if not error else status + ": " + error
                # CPUID 기능이 적혀 있고 이 CPU가 지원할 때만 SIGILL을 #UD 판정에 쓴다.
                sigill_counts = status == "SIGILL" and bool(combo["cpuid_flag"].strip())
            elif args.execute:
                run = "실행 안 함: " + (reason or "음성 케이스")
            clang_note = ""
            if gnu["encoding"] == "fields_match" and not (clang["observation_status"] == "accepted"
                                                          and clang["bytes"] == gnu["bytes"]):
                clang_note = ("거부: " + clang["diagnostic"]) if clang["observation_status"] != "accepted" else \
                    "다른 바이트 %s (%s)" % (clang["bytes"], clang["encoding"])
            results.append({
                "case_id": "ROW-%s" % combo["row_id"], "row_id": combo["row_id"], "combo_id": combo["combo_id"],
                "mnemonic": combo["mnemonic"], "test_kind": combo["test_kind"], "source": original,
                "tested_source": chosen, "forced": "예" if chosen != original else "",
                "gnu_status": gnu["observation_status"], "clang_status": clang["observation_status"],
                "gnu_bytes": gnu["bytes"], "clang_bytes": clang["bytes"],
                "gnu_encoding": gnu["encoding"], "clang_encoding": clang["encoding"],
                "encoding_override": "예" if int(combo["row_id"]) in overrides else "",
                "run": run, "clang_note": clang_note,
                "verdict": verdict(combo, gnu, clang, sigill_counts,
                                   int(combo["row_id"]) in unreachable and
                                   ("[" in original) == (unreachable[int(combo["row_id"])]["form"] == "memory")),
                "gnu_diagnostic": gnu["diagnostic"] if gnu["observation_status"] != "accepted" else "",
            })

    by_row = collections.defaultdict(list)
    for result in results:
        by_row[int(result["row_id"])].append(result)
    isa = read_csv("data/db/isa_db.csv")
    probes = {}
    for result in results:
        row_id = int(result["row_id"])
        if row_id in probes or "[" not in result["source"] or "{k1}" not in result["source"]:
            continue
        if "{z}" in result["source"]:
            continue
        probe = result["source"].replace("{k1}", "{k1}{z}", 1)
        answers = [observe(t, probe) for t in ("as", "clang")]
        probes[row_id] = "%s -> as %s, clang %s" % (probe, answers[0]["observation_status"], answers[1]["observation_status"])
    cases = []
    for row_id in sorted(conflict_rows):
        mine = [r for r in by_row[row_id] if r["verdict"] != "음성 케이스"]
        counts = collections.Counter(r["verdict"] for r in by_row[row_id])
        passed = ("통과", "통과(GNU 단독)", "도달 불가(별칭)", "도달 불가(문법)")
        negatives = [r for r in by_row[row_id] if r["verdict"] == "음성 케이스"]
        negative_verdict = ("음성 확인" if all(r["gnu_status"] != "accepted" and r["clang_status"] != "accepted"
                                            for r in negatives) else "음성 불일치(도구 수용: 실행 %s)" %
                            ",".join(sorted({r["run"] or "없음" for r in negatives})))
        row_verdict = (("통과" if all(r["verdict"] == "통과" for r in mine) else "통과(GNU 단독·도달 불가 포함)")
                       if mine and all(r["verdict"] in passed for r in mine)
                       else negative_verdict if not mine and by_row[row_id]
                       else "케이스 없음" if not by_row[row_id] else "미통과")
        cases.append({
            "case_id": "ROW-%d" % row_id, "row_id": row_id, "mnemonic": isa[row_id]["mnemonic"],
            "instruction": isa[row_id]["instruction"], "opcode": isa[row_id]["opcode"],
            "conflict_type": classify(" ".join(notes[row_id])), "row_verdict": row_verdict,
            "verdict_counts": "; ".join("%s %d" % kv for kv in counts.most_common()),
            "store_zeroing_probe": probes.get(row_id, "") if classify(" ".join(notes[row_id])) == "store_zeroing" else "",
            "sol_conflict_note": " | ".join(dict.fromkeys(notes[row_id]))[:600],
        })

    os.makedirs(OUT_DIR, exist_ok=True)
    names = {"conflicts": ("row_results.csv", "row_cases.csv"), "defects": ("defect_results.csv", "defect_cases.csv"),
             "all": ("all_results.csv", "all_cases.csv")}[args.target]
    for name, rows in zip(names, (results, cases)):
        with open(os.path.join(OUT_DIR, name), "w", encoding="utf-8", newline="") as handle:
            writer = csv.DictWriter(handle, fieldnames=list(rows[0].keys()))
            writer.writeheader()
            writer.writerows(rows)
    print("rows", len(cases), "combos", len(results), "forced", sum(1 for r in results if r["forced"]))
    print("combo verdicts", dict(collections.Counter(r["verdict"] for r in results)))
    print("row verdicts", dict(collections.Counter(c["row_verdict"] for c in cases)))
    print("types", dict(collections.Counter((c["conflict_type"], c["row_verdict"]) for c in cases)))
    print("runs", dict(collections.Counter(r["run"].split(":")[0] for r in results)))


if __name__ == "__main__":
    main()

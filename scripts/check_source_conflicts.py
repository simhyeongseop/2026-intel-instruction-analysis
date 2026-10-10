"""원문끼리 충돌하는 예외 사례(data/rules/source_conflict_cases.csv)를 어셈블러와 CPU로 대조한다.

    python3 scripts/check_source_conflicts.py            # 조립과 바이트 확인만
    python3 scripts/check_source_conflicts.py --execute  # CPU 실행까지(격리된 자식 프로세스, 타임아웃)

asm_intel 칸은 ' ; '로 형식 여러 개를 담을 수 있다(레지스터·메모리·broadcast 형식). 형식마다 한 줄씩 결과를 쓴다.
- vex_l: 표 형식(어셈블러가 낸 바이트)과 VEX.L 비트만 뒤집은 바이트를 둘 다 실행한다. 통과 = GNU/Clang 바이트 같음 +
  표 형식 정상 종료(--execute).
- evex_desc: 통과 = GNU/Clang 바이트 같음 + EVEX L'L이 표의 벡터 길이(EVEX.128=0, EVEX.256=1, LLIG는 보지 않음)와 같음.
  CPU에 avx512f가 없으면 실행하지 않고 그 사실을 적는다.
SIGILL은 #UD로 본다. 정상 종료(exit0)는 그 CPU에서 #UD가 나지 않았다는 관측일 뿐이며 ISA 전체 의미의 증거는 아니다.
대조군: ud2(#UD 기대), AVX2 vpaddw ymm(정상 기대).
결과: out/sdm_review_093/conflict_tests/results.csv
"""

import argparse
import csv
import os
import re
import subprocess
import sys
import tempfile

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from pipeline import cpu_run  # noqa: E402

CASES_CSV = "data/rules/source_conflict_cases.csv"
OUT_CSV = "out/sdm_review_093/conflict_tests/results.csv"
CLANG_CMD = ["clang", "-c", "-x", "assembler", "--target=x86_64-linux-gnu"]
CONTROLS = [
    {"case_id": "CTRL-UD2", "row_id": "", "mnemonic": "UD2", "asm_intel": "ud2", "table_form": ""},
    {"case_id": "CTRL-AVX2", "row_id": "", "mnemonic": "VPADDW", "asm_intel": "vpaddw ymm1, ymm2, ymm3", "table_form": ""},
]


def text_bytes(tool_cmd, asm, tmp_dir, name):
    """조립해서 .text 바이트를 돌려준다. 실패하면 (None, 오류문)."""
    src = os.path.join(tmp_dir, name + ".s")
    obj = os.path.join(tmp_dir, name + ".o")
    raw = os.path.join(tmp_dir, name + ".bin")
    with open(src, "w", encoding="utf-8", newline="\n") as handle:
        handle.write(".intel_syntax noprefix\n.text\n" + asm + "\n")
    result = subprocess.run(tool_cmd + ["-o", obj, src], capture_output=True, text=True, timeout=20)
    if result.returncode != 0:
        return None, result.stderr.strip()
    subprocess.run(["objcopy", "-O", "binary", "-j", ".text", obj, raw], check=True, timeout=20)
    with open(raw, "rb") as handle:
        return handle.read(), ""


def vex_l(code):
    """VEX 접두어의 L 비트. C4(3바이트)는 셋째 바이트, C5(2바이트)는 둘째 바이트의 비트 2."""
    if code[0] == 0xC4:
        return (code[2] >> 2) & 1
    if code[0] == 0xC5:
        return (code[1] >> 2) & 1
    return None


def evex_ll(code):
    """EVEX 접두어(62 P0 P1 P2)의 L'L = P2의 비트 6:5. EVEX가 아니면 None."""
    return (code[3] >> 5) & 3 if code and code[0] == 0x62 else None


def expected_ll(table_form):
    matched = re.search(r"EVEX\.(128|256|512)\.", table_form)
    return {"128": 0, "256": 1, "512": 2}[matched.group(1)] if matched else None


def cpu_flags():
    try:
        with open("/proc/cpuinfo", encoding="utf-8") as handle:
            for line in handle:
                if line.startswith("flags"):
                    return set(line.split(":", 1)[1].split())
    except OSError:
        pass
    return set()


def flip_vex_l(code):
    code = bytearray(code)
    code[2 if code[0] == 0xC4 else 1] ^= 0x04
    return bytes(code)


def run_bytes(code, tmp_dir, name):
    body = ".byte " + ", ".join("0x%02x" % b for b in code)
    status, error, _ = cpu_run.build_and_run({"name": name, "body": body + cpu_run.EXIT_CLEAN}, tmp_dir)
    return status if not error else status + ": " + error


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--execute", action="store_true", help="CPU에서 실행한다")
    args = parser.parse_args()

    with open(CASES_CSV, encoding="utf-8") as handle:
        cases = list(csv.DictReader(handle)) + CONTROLS
    flags = cpu_flags()
    rows = []
    with tempfile.TemporaryDirectory(prefix="conflict_") as tmp_dir:
        for case in cases:
            kind = case.get("conflict_type", "control")
            for number, asm in enumerate(case["asm_intel"].split(" ; "), 1):
                name = "%s_%d" % (case["case_id"].replace("-", "_"), number)
                gnu, gnu_err = text_bytes(cpu_run.AS_CMD, asm, tmp_dir, name + "_gnu")
                clang, clang_err = text_bytes(CLANG_CMD, asm, tmp_dir, name + "_clang")
                same = bool(gnu and clang and gnu == clang)
                row = {
                    "case_id": case["case_id"], "form": number, "row_id": case["row_id"],
                    "mnemonic": case["mnemonic"], "conflict_type": kind, "asm_intel": asm,
                    "gnu_bytes": gnu.hex(" ") if gnu else "거부: " + gnu_err,
                    "clang_bytes": clang.hex(" ") if clang else "거부: " + clang_err,
                    "same_bytes": "예" if same else "",
                    "vex_l": "" if not gnu or vex_l(gnu) is None else vex_l(gnu),
                    "evex_ll": "" if not gnu or evex_ll(gnu) is None else evex_ll(gnu),
                    "expected_ll": "",
                    "run_table_form": "", "flipped_bytes": "", "run_flipped_l": "", "verdict": "",
                }
                if kind == "evex_desc":
                    want = expected_ll(case["table_form"])
                    row["expected_ll"] = "" if want is None else want
                    row["run_table_form"] = "" if "avx512f" in flags else "실행 안 함: CPU에 avx512f 없음"
                    ll_ok = want is None or (gnu is not None and evex_ll(gnu) == want)
                    row["verdict"] = "통과" if same and ll_ok else "불일치"
                if args.execute and gnu and (kind != "evex_desc" or "avx512f" in flags):
                    row["run_table_form"] = run_bytes(gnu, tmp_dir, name + "_run")
                    if vex_l(gnu) is not None and kind == "vex_l":
                        flipped = flip_vex_l(gnu)
                        row["flipped_bytes"] = flipped.hex(" ")
                        row["run_flipped_l"] = run_bytes(flipped, tmp_dir, name + "_flip")
                if kind == "vex_l":
                    row["verdict"] = "통과" if same and row["run_table_form"] == "exit0" else \
                        ("조립만" if same and not args.execute else "불일치")
                rows.append(row)

    os.makedirs(os.path.dirname(OUT_CSV), exist_ok=True)
    with open(OUT_CSV, "w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(rows[0].keys()))
        writer.writeheader()
        writer.writerows(rows)
    for row in rows:
        print(" | ".join(str(row[k]) for k in ("case_id", "form", "mnemonic", "same_bytes", "vex_l", "evex_ll",
                                                 "expected_ll", "run_table_form", "run_flipped_l", "verdict", "gnu_bytes")))


if __name__ == "__main__":
    main()

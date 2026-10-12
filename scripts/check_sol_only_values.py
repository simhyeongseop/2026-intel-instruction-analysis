"""결정 6: main에 총론 정의가 없고 Sol만 값을 붙인 오퍼랜드 줄을 2단계 생성 값과 대조한다.

    python3 scripts/check_sol_only_values.py

입력:
- out/sdm_review_093/compare/operands.csv 에서 kind_result가 'main 총론 정의 없음·Sol 값 있음'인 줄
- out/cases/cases.csv (2단계 생성 결과)

줄마다(행, 오퍼랜드 순번) 생성 케이스의 그 칸을 모아
- 종류: Sol 종류(register/memory/register_or_memory/mask/immediate)와 생성 종류(reg/mem/bcst/imm …)가 맞는가
- 폭: Sol 폭 문장에 숫자가 있으면, 생성 소스 문자열의 폭(레지스터 이름·ptr 크기)이
  그 숫자이거나 표 기호에 적힌 그 칸의 폭(xmm=128, m64, m32bcst의 32)인가
결과는 out/sdm_review_093/compare/sol_only_check.csv 이고, 다른 줄이 있으면 종료 코드 1.
"""

import collections
import csv
import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OPERANDS = os.path.join(ROOT, "out/sdm_review_093/compare/operands.csv")
CASES = os.path.join(ROOT, "out/cases/cases.csv")
OUTPUT = os.path.join(ROOT, "out/sdm_review_093/compare/sol_only_check.csv")
TARGET = "main 총론 정의 없음·Sol 값 있음"

# Sol 종류마다 생성 종류로 허용하는 것
KIND_ALLOWED = {
    "register": {"reg"},
    "memory": {"mem"},
    "register_or_memory": {"reg", "mem", "bcst"},
    "mask": {"reg"},
    "immediate": {"imm"},
}
# Sol 종류가 register_or_memory면 생성 쪽에 레지스터와 메모리가 모두 있어야 한다
KIND_REQUIRED = {"register_or_memory": {"reg", "mem"}}

PTR_BITS = {"byte": 8, "word": 16, "dword": 32, "qword": 64, "tbyte": 80,
            "xmmword": 128, "ymmword": 256, "zmmword": 512}


def register_bits(name):
    """레지스터 이름의 폭. 모르면 None."""
    name = name.lower()
    for prefix, bits in (("xmm", 128), ("ymm", 256), ("zmm", 512), ("tmm", None)):
        if name.startswith(prefix):
            return bits
    if re.fullmatch(r"k[0-7]", name):
        return None  # 마스크 레지스터 폭은 대조하지 않음
    if re.fullmatch(r"r(1[0-5]|[89])d|e[a-ds][xip]|e[sd]i|esp|ebp", name):
        return 32
    if re.fullmatch(r"r(1[0-5]|[89])|r[a-ds][xip]|r[sd]i|rsp|rbp", name):
        return 64
    if re.fullmatch(r"r(1[0-5]|[89])w|[a-d]x|[sd]i|sp|bp", name):
        return 16
    if re.fullmatch(r"r(1[0-5]|[89])b|[a-d][lh]|[sd]il|spl|bpl", name):
        return 8
    return None


def text_bits(text):
    """생성 오퍼랜드 문자열의 폭: (종류, 폭). 브로드캐스트는 원소 폭."""
    text = re.sub(r"\{[kz0-9]+\}", "", text).strip()
    match = re.match(r"(\w+) ptr ", text)
    if match:
        return PTR_BITS.get(match.group(1))
    if text.startswith("["):
        return None
    return register_bits(text)


def split_operands(operands):
    """', '로 나누고, 끝에 붙은 {sae}·{rn-sae} 같은 장식 칸은 뺀다."""
    pieces = [p.strip() for p in operands.split(",")] if operands else []
    return [p for p in pieces if p and not p.startswith("{")]


def sol_numbers(width):
    """Sol 폭 문장 속 비트 수. '바이트'가 붙은 수는 8배."""
    numbers = set()
    for value, unit in re.findall(r"(\d+)\s*(바이트|byte)?", width):
        numbers.add(int(value) * 8 if unit else int(value))
    return numbers


def symbol_bits(symbol, kind):
    """표 기호 자체에 적힌 칸 폭: 'xmm2/m64/m32bcst'에서 reg 128, mem 64, bcst 32."""
    found = set()
    for token in re.sub(r"\{[^}]*\}", "", symbol).replace(" ", "").split("/"):
        token = token.lower()
        if kind == "bcst" and re.fullmatch(r"m(\d+)bcst", token):
            found.add(int(token[1:-4]))
        elif kind == "mem" and re.fullmatch(r"m\d+", token):
            found.add(int(token[1:]))
        elif kind == "reg":
            for prefix, bits in (("xmm", 128), ("ymm", 256), ("zmm", 512)):
                if token.startswith(prefix):
                    found.add(bits)
            if token == "reg":   # SYM039: r16, r32, or r64
                found.update((16, 32, 64))
            match = re.fullmatch(r"r(8|16|32|64)[ab]?", token)
            if match:
                found.add(int(match.group(1)))
    return found


def gathered(cases, index):
    """행의 생성 케이스에서 index번째(1부터) 칸의 (종류, 폭) 모음."""
    kinds, widths, problems = set(), set(), []
    for case in cases:
        evidence = [e for e in case["evidence"].split("; ") if e]
        pieces = split_operands(case["operands"])
        if index > len(evidence):
            problems.append("근거 칸 수 %d" % len(evidence))
            continue
        kind = evidence[index - 1].rsplit("=", 1)[1].split("(", 1)[0]
        kinds.add(kind)
        if len(pieces) == len(evidence):
            bits = text_bits(pieces[index - 1])
            if bits:
                widths.add((kind, bits))
        else:
            problems.append("소스 칸 수 %d, 근거 칸 수 %d" % (len(pieces), len(evidence)))
    return kinds, widths, problems


def judge(sol, kinds, widths, problems):
    if not kinds:
        return "생성 케이스 없음", ""
    if sol["sol_kind"] == "register" and kinds == {"string_mem"}:
        # REP LODS AL 등: 표의 누산기 대신 GNU가 받는 메모리 철자로 생성함(m2_generate note에 기록)
        return "철자 선택(누산기 -> 메모리 철자)", "생성 폭 %s, Sol %s" % (sorted(b for _, b in widths), sol["sol_width"])
    allowed = KIND_ALLOWED.get(sol["sol_kind"])
    notes = []
    if allowed is None:
        notes.append("Sol 종류 미분류")
    else:
        extra = kinds - allowed - {"fixed", "literal"}
        if extra:
            notes.append("종류 다름: 생성 %s" % ",".join(sorted(extra)))
        missing = KIND_REQUIRED.get(sol["sol_kind"], set()) - kinds
        if missing:
            notes.append("생성에 없는 종류: %s" % ",".join(sorted(missing)))
    numbers = sol_numbers(sol["sol_width"])
    # 생성 폭은 Sol 폭 문장의 수이거나, 표 기호 자체에 적힌 그 칸의 폭이어야 한다
    wrong = sorted("%s %d" % (kind, bits) for kind, bits in widths
                   if bits not in numbers and bits not in symbol_bits(sol["sol_symbol"], kind))
    if numbers and wrong:
        notes.append("폭 다름: 생성 %s, Sol %s" % (wrong, sorted(numbers)))
    if problems:
        notes.append("칸 대응 확인 필요(%s)" % problems[0])
    if notes:
        return "다름", "; ".join(notes)
    if not numbers:
        return "종류 일치(Sol 폭 없음)", ""
    return "일치", ""


def main():
    with open(CASES, encoding="utf-8", newline="") as handle:
        by_row = collections.defaultdict(list)
        for case in csv.DictReader(handle):
            by_row[case["row_id"]].append(case)
    with open(OPERANDS, encoding="utf-8", newline="") as handle:
        targets = [r for r in csv.DictReader(handle) if r["kind_result"] == TARGET]
    out, counts = [], collections.Counter()
    for sol in targets:
        kinds, widths, problems = gathered(by_row[sol["row_id"]], int(sol["operand_index"]))
        result, note = judge(sol, kinds, widths, problems)
        counts[result] += 1
        out.append({"row_id": sol["row_id"], "operand_index": sol["operand_index"], "mnemonic": sol["mnemonic"],
                    "sol_symbol": sol["sol_symbol"], "sol_kind": sol["sol_kind"], "sol_width": sol["sol_width"],
                    "uniform_status": sol["uniform_status"], "generated_kinds": ",".join(sorted(kinds)),
                    "generated_widths": ",".join("%s %d" % w for w in sorted(widths)), "result": result, "note": note})
    with open(OUTPUT, "w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(out[0]))
        writer.writeheader()
        writer.writerows(out)
    print("대상 %d줄" % len(targets))
    for key, value in counts.most_common():
        print("  %s: %d" % (key, value))
    print("결과:", os.path.relpath(OUTPUT, ROOT))
    return 1 if counts["다름"] or counts["생성 케이스 없음"] else 0


if __name__ == "__main__":
    sys.exit(main())

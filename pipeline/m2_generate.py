"""2단계 생성기: SDM 표 행 + 원문 검토 결과 -> 테스트 케이스(cases.csv)와 도구 입력 소스.

    python3 pipeline/m2_generate.py [--out out/cases]

입력
- data/db/isa_db.csv: SDM 093판 표 행(1단계)
- out/sdm_review_093: 오퍼랜드별 원문 검토(Sol) -> 표 기호와 순서
- out/sdm_review_093/compare/rows_status.csv: 행 상태(원문 확정, 완화, 예외 등록 ...)
값은 pipeline/case_rules.py의 표로만 고른다. 케이스마다 오퍼랜드 근거를 남긴다.

케이스의 SDM 기대 결과(expected)
- reach: 64비트 모드 유효 행. 조립 결과가 이 표 행의 인코딩이어야 한다
- reject: 64비트 모드 무효 행(Invalid/N.E./N.S.). 도구가 거부해야 한다
- alias_no_test: 무효 행인데 같은 소스가 유효한 다른 행의 케이스와 같다. 소스로는 거부 시험을 만들 수 없다
같은 소스를 내는 유효 행이 여럿이면 alias_rows에 적는다(판정 단계가 도구별로 어느 행에 도달했는지 본다).
"""

import argparse
import collections
import csv
import json
import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline import case_rules as R  # noqa: E402
from pipeline.operand_size_prefix import required_size  # noqa: E402
from pipeline import sdm_review_compare as cmp  # noqa: E402

ISA_DB = os.path.join(ROOT, "data/db/isa_db.csv")
REVIEW_DIR = os.path.join(ROOT, "out/sdm_review_093")
ROW_STATUS = os.path.join(REVIEW_DIR, "compare/rows_status.csv")
OUT_DIR = os.path.join(ROOT, "out/cases")
TRUSTED = ("원문 확정", "예외 등록·실측 확인", "원문 확정(완화 A: Vol.1)", "원문 확정(완화 B: 결합)",
           "원문상 가변(완화 C)", "원문 확정(완화 D: 타 명령 절 정의)", "예외 등록·도구 미지원")
ASM_HEADER = (".intel_syntax noprefix\n.Ltarget:\n"
              ".set .Ltarget32, .Ltarget + 4096\n.set .Ltarget16, .Ltarget + 4096\n")
COLUMNS = ["case_id", "row_id", "mnemonic", "instruction", "opcode", "mode_support", "cpuid_flag", "row_status",
           "spec_trusted", "expected", "alias_rows", "variant", "source", "operands", "shape", "evidence", "notes"]


def read_csv(path):
    with open(path, encoding="utf-8", newline="") as handle:
        return list(csv.DictReader(handle))


# ---------- 레지스터 고르기 (선택 규칙) ----------

def physical(name):
    """같은 물리 레지스터인지 비교할 열쇠. al/ax/eax/rax -> ('gpr', 0), xmm3/ymm3/zmm3 -> ('vec', 3)."""
    if name in R.GPR_NUMBER:
        return ("gpr", R.GPR_NUMBER[name])
    vector = re.fullmatch(r"[xyz]mm(\d+)", name)
    if vector:
        return ("vec", int(vector.group(1)))
    return ("other", name)


class RowRegisters:
    """한 표 행에서 레지스터를 고른다: 원문 목록 순서대로, 이미 쓴 물리 레지스터와 빼기로 정한 것은 건너뛴다."""

    def __init__(self, excluded):
        self.used = set(physical(name) for name in excluded)

    def take(self, family, even=False):
        source, names = R.REGISTER_LISTS[family]
        for name in names:
            number = re.search(r"(\d+)\)?$", name)
            if even and not (number and int(number.group(1)) % 2 == 0):
                continue
            if physical(name) not in self.used:
                self.used.add(physical(name))
                return name, source
        raise ValueError("고를 레지스터가 없음: " + family)

    def take_writemask(self):
        for name in R.WRITEMASKS[1]:
            if physical(name) not in self.used:
                self.used.add(physical(name))
                return name
        raise ValueError("쓰기 마스크가 없음")


def excluded_registers(mnemonic, rows_of_mnemonic):
    """선택 규칙(2026-10-09 결정): 같은 니모닉 표에 고정 오퍼랜드로 나온 레지스터와 주소 레지스터(rax, rbx)는 뺀다."""
    names = {R.ADDRESS_BASE, R.ADDRESS_INDEX}
    for symbols in rows_of_mnemonic:
        for symbol in symbols:
            part = R.clean_symbol(symbol)
            fixed = R.fixed_register(part)
            if fixed:
                names.add(fixed)
            implicit = re.fullmatch(r"<([A-Za-z]+)(\d*)(?:-\d+)?>", part)
            if implicit:
                names.add((implicit.group(1) + implicit.group(2)).lower())
    return names


# ---------- 오퍼랜드 하나 -> 대안 목록 ----------

def operand_choices(symbol, row, regs):
    """표 기호 하나 -> [(형식, 소스 조각 템플릿, 근거)]. 메모리 주소 자리는 '{addr}'로 남긴다.

    빈 목록은 소스에 적지 않는 암묵 오퍼랜드(<XMM0> 등)다.
    """
    mnemonic, opcode = row["name"], row["opcode"]
    part = R.clean_symbol(symbol)
    correction = R.DESCRIPTION_CORRECTIONS.get((mnemonic, opcode, part))
    notes = []
    if correction:
        part = correction[0]
        notes.append("Description 보정: " + correction[1])
    if re.fullmatch(r"<[^>]+>", part):
        return [], ["암묵 오퍼랜드는 소스에 적지 않음(as 관측: 적으면 operand 수 불일치)"]
    if part in R.IMMEDIATES:
        source, value, _ = R.IMMEDIATES[part]
        return [("imm", value, source)], notes
    if re.fullmatch(r"-?\d+", part):
        return [("literal", part, "표에 적힌 값")], notes
    relative = re.fullmatch(r"rel(8|16|32)", part)
    if relative:
        label = ".Ltarget" if relative.group(1) == "8" else ".Ltarget" + relative.group(1)
        return [("rel", label, "SYM023/024")], notes
    if part in R.FAR_POINTER_IMMEDIATE:
        return [("far_ptr", R.FAR_POINTER_IMMEDIATE[part], "SYM025")], notes
    moffs = re.fullmatch(r"moffs(8|16|32|64)", part)
    if moffs:
        return [("moffs", "%s ptr [0x123456789abcdef0]" % R.SIZE_KEYWORD[int(moffs.group(1))], "SYM049")], notes
    if mnemonic in R.STRING_NAMES and part in R.STRING_ACCUMULATOR_BITS and row["string_memory_accumulator"]:
        keyword = R.SIZE_KEYWORD[R.STRING_ACCUMULATOR_BITS[part]]
        return [("string_mem", "%s ptr [rsi]" % keyword, "SYM041/042 DS:(E)SI")], \
            notes + ["누산기 표기를 GNU가 받는 메모리 철자로 씀(as 관측: 'rep lods al' 거부)"]
    fixed = R.fixed_register(part)
    if fixed:
        return [("fixed", fixed, "표에 적힌 레지스터")], notes
    if part in ("reg",):
        # SYM039: 폭이 의미에 무관한 범용 레지스터. 명령 절이 폭을 정하면(원문 검토 data_width=64) 그것을,
        # 아니면 W1/REX.W 행은 64, 그 밖은 64비트 모드 기본 피연산자 크기 32(VOL1_DEFAULTS)
        stated = row["widths"].get(symbol, "").strip()
        width = "r64" if stated == "64" or re.search(r"\bW1\b|REX\.W", opcode) else "r32"
        name, source = regs.take(width)
        return [("reg", name, "SYM039 + " + ("명령 절 64" if stated == "64" else R.VOL1_DEFAULTS[0]))], notes
    pieces = [part] if R.is_memory(part) else part.split("/")   # 'm14/28byte'는 표기 하나
    register_parts = [p for p in pieces if not R.is_memory(p)]
    memory_parts = [p for p in pieces if R.is_memory(p)]
    choices = []
    if mnemonic in R.ADDRESS_REGISTER_MNEMONICS and register_parts:
        register_parts = ["r64"]
        notes.append("주소를 담는 레지스터: 64비트 기본 주소 크기(%s)의 r64" % R.VOL1_DEFAULTS[0])
    for piece in register_parts:
        if piece == "r":   # r/m8 등: 짝 메모리 폭의 범용 레지스터(SYM035~038)
            width = re.match(r"m(\d+)", memory_parts[0]).group(1)
            piece = "r" + width
        if piece == "reg":
            piece = "r32"
        family = R.register_family(piece)
        if family is None:
            raise ValueError("모르는 레지스터 표기 %r (row %s)" % (piece, row["row_id"]))
        name, source = regs.take(family, even=piece.startswith("k") and "+1" in part)
        if family == "zmm" or family == "xmm" or family == "ymm":
            block = re.fullmatch(r"[xyz]mm(\d+)\+3", piece)
            if block:  # zmm2+3: 표에 적힌 첫 레지스터부터 4개 묶음(번호는 표 그대로)
                name = piece.split("+")[0]
        choices.append(("reg", name, source))
    for piece in memory_parts:
        choices.extend(memory_choices(piece, pieces, row, regs))
    return choices, notes


def memory_choices(piece, pieces, row, regs):
    """메모리 표기 하나 -> 대안들. 브로드캐스트는 같은 표기의 일반 메모리 폭 / 원소 폭으로 원소 수를 센다."""
    mnemonic = row["name"]
    bcst = re.fullmatch(r"m(16|32|64)bcst", piece)
    if bcst:
        element = int(bcst.group(1))
        plain = [int(p[1:]) for p in pieces if re.fullmatch(r"m\d+", p)]
        if not plain or plain[0] % element:
            return []
        return [("bcst", "%s ptr {addr}{1to%d}" % (R.SIZE_KEYWORD[element], plain[0] // element),
                 R.evidence_of(piece))]
    vsib = re.fullmatch(r"vm(32|64)([xyz])", piece)
    if vsib:
        index, _ = regs.take({"x": "xmm", "y": "ymm", "z": "zmm"}[vsib.group(2)])
        return [("vsib", "[rax+%s]" % index, "SYM075/076")]
    return [("mem", R.memory_text(piece, "{addr}", mnemonic), R.evidence_of(piece))]


# ---------- 행 하나 -> 케이스들 ----------

def address_forms(row, case_operands):
    """메모리 자리에 쓸 주소 형태 이름들. 원문이 주소를 정하는 명령은 그 하나만."""
    name = row["name"]
    if name in R.STRING_NAMES or name == "XLAT":
        return []
    if name in ("PREFETCHIT0", "PREFETCHIT1"):
        return ["rip"]                                    # VOL2_PREFETCHI
    if any("sibmem" in s for s in row["symbols"]):
        return ["sib"]                                    # Vol.2 51 2.4: ModR/M + SIB
    if name in R.RIP_UNDEFINED or any(R.clean_symbol(s) == "mib" for s in row["symbols"]):
        return ["base", "sib"]                            # RIP_UNDEFINED, SYM068(SIB 형식)
    return ["base", "sib", "rip"]


def fill_address(text, row, form):
    name = row["name"]
    if name in R.STRING_NAMES:
        return text
    if name == "XLAT":
        return text.replace("{addr}", "[rbx]")          # XLAT 절: DS:(E/R)BX
    return text.replace("{addr}", R.ADDRESS_FORMS[form])


def string_addresses(row, operands):
    """문자열 명령의 메모리 자리를 원문 고정 주소(rsi/rdi)로 바꾼다."""
    addresses = iter(R.STRING_ADDRESSES[row["name"]])
    return [op.replace("{addr}", next(addresses)) if "{addr}" in op else op for op in operands]


def build_row_cases(row, regs):
    """한 행 -> [(variant, operand 텍스트 목록, 근거 목록, notes)]."""
    per_operand, notes = [], []
    for symbol in row["symbols"]:
        choices, note = operand_choices(symbol, row, regs)
        notes.extend(note)
        if choices:
            per_operand.append((symbol, choices))
    masks = {}
    for index, (symbol, _) in enumerate(per_operand):
        decor = R.decorations(symbol)
        if "{k1}" in decor or "{k2}" in decor:
            masks[index] = (regs.take_writemask(), "{z}" in decor)
    keep_mask = "GATHER" in row["name"] or "SCATTER" in row["name"]   # SYM072: gather는 aaa != 0
    cases = []

    def add(variant, picks, form="base", with_mask=keep_mask):
        texts, evidence, shapes = [], [], []
        for index, ((symbol, _), (kind, text, source)) in enumerate(zip(per_operand, picks)):
            if index in masks and with_mask:
                mask, zeroing = masks[index]
                is_memory_dest = "[" in text or "{addr}" in text
                text += " {%s}" % mask + ("{z}" if zeroing and not is_memory_dest and not keep_mask else "")
            texts.append(text)
            shapes.append(shape_of(kind, text))
            evidence.append("%s=%s(%s)" % (R.clean_symbol(symbol) or symbol, kind, source))
        if row["name"] in R.STRING_NAMES:
            texts = string_addresses(row, texts)
        texts = [fill_address(t, row, form) for t in texts]
        shapes = [fill_address(t, row, form) for t in shapes]
        cases.append((variant, texts, evidence, shapes))

    if not per_operand:
        cases.append(("base", [], [], []))
        return cases, notes
    width = max(len(c) for _, c in per_operand)
    for alt in range(width):
        picks = [c[alt] if alt < len(c) else c[0] for _, c in per_operand]
        kinds = {p[0] for p in picks}
        label = "base" if alt == 0 else "alt%d" % alt
        has_address = any("{addr}" in p[1] for p in picks)
        forms = address_forms(row, picks) if has_address else []
        if not forms:
            add(label, picks)
        else:
            for form in forms:
                if "bcst" in kinds and form != forms[0]:
                    continue                              # 브로드캐스트는 주소 형태 하나만
                add(label if form == forms[0] else label + ":" + form, picks, form)
    base = [c[0] for _, c in per_operand]
    if any(k == "imm" for k, _, _ in base):
        maxed = [(k, R.IMMEDIATES[R.clean_symbol(s)][2] if k == "imm" else t, src)
                 for (s, _), (k, t, src) in zip(per_operand, base)]
        add("imm_max", maxed)
    if masks and not keep_mask:
        for alt in range(width):
            picks = [c[alt] if alt < len(c) else c[0] for _, c in per_operand]
            add("mask" if alt == 0 else "mask:alt%d" % alt, picks, address_forms(row, picks)[:1][0]
                if any("{addr}" in p[1] for p in picks) and address_forms(row, picks) else "base", with_mask=True)
    return cases, notes


REGISTER_NAME = re.compile(r"\b(?:[xyz]?mm|k|tmm|bnd)\d+\b|\bst\(\d\)")


def shape_of(kind, text):
    """별칭 비교용 모양: 고른 레지스터의 번호를 지운다(표에 적힌 고정 레지스터는 그대로)."""
    text = re.sub(r"\{k\d\}", "{k}", text)
    if kind in ("fixed", "imm", "literal", "rel", "moffs", "far_ptr", "string_mem"):
        return text
    text = REGISTER_NAME.sub(lambda m: re.sub(r"\d", "", m.group(0)), text)
    for family in ("r8", "r16", "r32", "r64"):
        if kind == "reg" and text in R.REGISTER_LISTS[family][1]:
            return family
    return text


def source_line(row, operands, variant_prefix=""):
    prefix, mnemonic = row["asm_prefix"], row["asm_mnemonic"] or row["source_mnemonic"]
    text = mnemonic + (" " + ", ".join(operands) if operands else "")
    return (prefix + " " + text).strip() if prefix else text


def load_rows():
    isa = read_csv(ISA_DB)
    sol = cmp.load_sol(REVIEW_DIR)
    symbols = collections.defaultdict(list)
    widths = collections.defaultdict(dict)
    for (row_id, index), line in sorted(sol.items()):
        if index:
            symbols[row_id].append(line["table_symbol"])
            widths[row_id][line["table_symbol"]] = line["data_width"]
    status = {int(r["row_id"]): r["row_status"] for r in read_csv(ROW_STATUS)}
    rows = []
    for row_id, isa_row in enumerate(isa):
        instruction = " ".join(isa_row["instruction"].split())
        mine = symbols.get(row_id, [])
        first = mine[0].split()[0] if mine else None
        cut = instruction.find(" " + first) if first else -1
        source_mnemonic = (instruction[:cut] if cut > 0 else instruction if not mine else isa_row["mnemonic"]).strip()
        name = source_mnemonic.split()[-1].upper()
        rows.append({
            "row_id": row_id, "isa": isa_row, "symbols": mine, "widths": widths[row_id], "name": name,
            "opcode": isa_row["opcode"],
            "source_mnemonic": source_mnemonic.lower(), "status": status.get(row_id, ""),
            "string_memory_accumulator": name == "LODS" and source_mnemonic.upper().startswith("REP"),
            "asm_prefix": "", "asm_mnemonic": "",
        })
    return rows


def apply_row_spelling(row):
    """ROW_SPELLINGS: 도구 문법으로 그 행을 지정하는 접두어·니모닉·고정 오퍼랜드."""
    opcode = re.sub(r"REX\.W\s*\+\s*", "REX.W ", row["opcode"])
    symbol = R.clean_symbol(row["symbols"][0]) if row["symbols"] else ""
    rule = R.ROW_SPELLINGS.get((row["name"], " ".join(opcode.split()), symbol))
    notes = []
    if rule:
        row["asm_prefix"], row["asm_mnemonic"] = rule[0], rule[1]
        notes.append("행 지정 철자: " + rule[3])
    spelling = R.OPERANDLESS_16BIT_SPELLINGS.get(row["name"])
    if spelling and not row["symbols"] and required_size(row["isa"]) == 16:
        row["asm_prefix"], row["asm_mnemonic"] = spelling[0], spelling[1]
        notes.append("16비트 행 철자: " + spelling[2])
    if row["name"] == "XBEGIN" and symbol == "rel16":
        row["asm_prefix"] = "data16"
        notes.append("XBEGIN rel16: 64비트 모드에서 유효(표), data16으로 16비트 꼬리를 고름")
    if any(re.fullmatch(r"moffs\d+", R.clean_symbol(s)) for s in row["symbols"]):
        row["asm_mnemonic"] = "movabs"
        has_rax = any(R.clean_symbol(s) == "RAX" for s in row["symbols"])
        row["asm_prefix"] = "rex64" if "REX.W" in row["opcode"] and not has_rax else ""
        notes.append("moffs: 64비트 절대 주소는 movabs 철자(GNU), REX.W 행은 rex64")
    return rule[2] if rule else "", notes


def generate(rows):
    by_mnemonic = collections.defaultdict(list)
    for row in rows:
        by_mnemonic[row["name"]].append(row["symbols"])
    cases = []
    for row in rows:
        fixed_operand, notes = apply_row_spelling(row)
        regs = RowRegisters(excluded_registers(row["name"], by_mnemonic[row["name"]]))
        if fixed_operand:
            built = [("base", [fixed_operand], ["%s=mem(SYM046)" % R.clean_symbol(row["symbols"][0])], [fixed_operand])]
            more = []
        else:
            built, more = build_row_cases(row, regs)
        valid = row["isa"]["mode_support"] == "Valid"
        for number, (variant, operands, evidence, shapes) in enumerate(built):
            cases.append({
                "case_id": "%d-%d" % (row["row_id"], number), "row_id": row["row_id"],
                "mnemonic": row["isa"]["mnemonic"], "instruction": row["isa"]["instruction"],
                "opcode": row["opcode"], "mode_support": row["isa"]["mode_support"],
                "cpuid_flag": row["isa"]["cpuid_flag"], "row_status": row["status"],
                "spec_trusted": "예" if row["status"] in TRUSTED else "",
                "expected": "reach" if valid else "reject", "alias_rows": "", "variant": variant,
                "source": source_line(row, operands), "operands": ", ".join(operands),
                "evidence": "; ".join(evidence),
                "shape": source_line(row, shapes),
                "notes": "; ".join(dict.fromkeys(notes + more)),
            })
    mark_aliases(cases)
    return cases


def alias_key(case):
    """같은 문법인지 비교하는 열쇠. 먼 라벨(.Ltarget16/.Ltarget32)은 같은 라벨 문법으로 본다."""
    return re.sub(r"\.Ltarget(16|32)\b", ".LtargetFAR", case["shape"]).lower()


def mark_aliases(cases):
    groups = collections.defaultdict(list)
    for case in cases:
        groups[alias_key(case)].append(case)
    for group in groups.values():
        rows = sorted({c["row_id"] for c in group})
        if len(rows) < 2:
            continue
        valid_rows = sorted({c["row_id"] for c in group if c["expected"] == "reach"})
        for case in group:
            others = [r for r in rows if r != case["row_id"]]
            case["alias_rows"] = " ".join(str(r) for r in others)
            if case["expected"] == "reject" and valid_rows:
                case["expected"] = "alias_no_test"


def write_outputs(cases, out_dir):
    os.makedirs(out_dir, exist_ok=True)
    with open(os.path.join(out_dir, "cases.csv"), "w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=COLUMNS)
        writer.writeheader()
        writer.writerows(cases)
    with open(os.path.join(out_dir, "cases.s"), "w", encoding="utf-8", newline="\n") as handle:
        handle.write("# 생성: pipeline/m2_generate.py. 한 줄씩 따로 조립한다(판정: pipeline/m3_check.py)\n")
        handle.write(ASM_HEADER)
        for case in cases:
            handle.write("%s  # case=%s row=%s expected=%s\n" % (case["source"], case["case_id"], case["row_id"],
                                                                 case["expected"]))
    summary = {
        "cases": len(cases), "rows": len({c["row_id"] for c in cases}),
        "expected": dict(collections.Counter(c["expected"] for c in cases)),
        "spec_trusted": sum(c["spec_trusted"] == "예" for c in cases),
        "variants": dict(collections.Counter(c["variant"].split(":")[0] for c in cases)),
    }
    with open(os.path.join(out_dir, "generate_summary.json"), "w", encoding="utf-8") as handle:
        json.dump(summary, handle, ensure_ascii=False, indent=1)
    return summary


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--out", default=OUT_DIR)
    args = parser.parse_args()
    summary = write_outputs(generate(load_rows()), args.out)
    print(json.dumps(summary, ensure_ascii=False))


if __name__ == "__main__":
    main()

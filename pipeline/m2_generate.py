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
import random
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline import case_rules as R  # noqa: E402
from pipeline.operand_size_prefix import required_size  # noqa: E402
from pipeline import fp_controls as FP  # noqa: E402
from pipeline import att_syntax as ATT  # noqa: E402
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
           "spec_trusted", "expected", "alias_rows", "variant", "source", "source_att", "operands", "shape", "evidence",
           "notes"]


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
        return [("rel", R.EXTERNAL_TARGET, "SYM023/024 + 외부 기호(재배치)"),
                ("rel", label, "SYM023/024 + 같은 파일 라벨")], notes
    if part in R.FAR_POINTER_IMMEDIATE:
        return [("far_ptr", R.FAR_POINTER_IMMEDIATE[part], "SYM025")], notes
    moffs = re.fullmatch(r"moffs(8|16|32|64)", part)
    if moffs:
        return [("moffs", "%s ptr [0x123456789abcdef0]" % R.SIZE_KEYWORD[int(moffs.group(1))], "SYM049")], notes
    if mnemonic in R.STRING_NAMES and part in R.STRING_ACCUMULATOR_BITS and row["string_memory_accumulator"]:
        keyword = R.SIZE_KEYWORD[R.STRING_ACCUMULATOR_BITS[part]]
        return [("string_mem", "%s ptr [rsi]" % keyword, "SYM041/042 DS:(E)SI")], \
            notes + ["누산기 대신 원천 메모리를 적음(Vol.2 685 LODS: explicit-operands form은 source를 적고 "
                     "destination은 자동 선택)"]
    fixed = R.fixed_register(part)
    if fixed:
        return [("fixed", fixed, "표에 적힌 레지스터")], notes
    if part in ("reg",):
        # SYM039: 폭이 의미에 무관한 범용 레지스터. 명령 절이 폭을 정하면(원문 검토 data_width=64) 그것을,
        # 아니면 W1/REX.W 행은 64, 그 밖은 64비트 모드 기본 피연산자 크기 32(VOL1_DEFAULTS)
        stated = row["widths"].get(symbol, "").strip()
        width = "r64" if stated == "64" or re.search(r"\bW1\b|REX\.W", opcode) else "r32"
        name, source = regs.take(width)
        choices = [("reg", name, "SYM039 + " + ("명령 절 64" if stated == "64" else R.VOL1_DEFAULTS[0]))]
        return choices + wide_register(row, regs, width), notes
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
        from_reg = piece == "reg"
        if from_reg:   # reg/m16 등: SYM039(r16·r32·r64 중 하나)에서 64비트 모드 기본 크기 32를 고름
            piece = "r32"
        family = R.register_family(piece)
        if family is None:
            raise ValueError("모르는 레지스터 표기 %r (row %s)" % (piece, row["row_id"]))
        name, source = regs.take(family, even=piece.startswith("k") and "+1" in part)
        if from_reg:
            source = "SYM039 + " + R.VOL1_DEFAULTS[0]
        if family == "zmm" or family == "xmm" or family == "ymm":
            block = re.fullmatch(r"[xyz]mm(\d+)\+3", piece)
            if block:  # zmm2+3: 표에 적힌 첫 레지스터부터 4개 묶음(번호는 표 그대로)
                name = piece.split("+")[0]
        choices.append(("reg", name, source))
    for piece in memory_parts:
        for kind, text, source in memory_choices(piece, pieces, row, regs):
            choices.append((kind, text, R.RM_SYMBOLS.get(part, source) if kind == "mem" else source))
    if "reg" in pieces:
        choices += wide_register(row, regs, "r32")
    return choices, notes


def wide_register(row, regs, chosen):
    """reg 칸의 r64 대안. 대표값이 r32이고 원문이 r64를 허용하는 행만(case_rules.REG_R64). 변형 목록 끝에 붙인다."""
    if chosen != "r32" or row["name"] not in R.REG_R64:
        return []
    name, _ = regs.take("r64")
    return [("reg", name, R.REG_R64[row["name"]])]


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


ALL_ADDRESSES = dict(R.ADDRESS_FORMS, **R.ADDRESS_BOUNDARY, **R.RIP_BOUNDARY, **R.EVEX_DISP_BOUNDARY)


def fill_address(text, row, form):
    """form: 주소 형태 이름(ALL_ADDRESSES) 또는 '['로 시작하는 주소 그대로(랜덤 변형)."""
    name = row["name"]
    if name in R.STRING_NAMES:
        return text
    if name == "XLAT":
        return text.replace("{addr}", "[rbx]")          # XLAT 절: DS:(E/R)BX
    return text.replace("{addr}", form if form.startswith("[") else ALL_ADDRESSES[form])


def string_addresses(row, operands):
    """문자열 명령의 메모리 자리를 원문 고정 주소(rsi/rdi)로 바꾼다."""
    addresses = iter(R.STRING_ADDRESSES[row["name"]])
    return [op.replace("{addr}", next(addresses)) if "{addr}" in op else op for op in operands]


def build_row_cases(row, regs, excluded=None, extra=None):
    """한 행 -> [(variant, operand 텍스트 목록, 근거 목록, notes)].

    excluded: 그 행에서 값 오퍼랜드로 쓰지 않는 레지스터(excluded_registers). extra: {'seed': .., 'random': N}이면
    대표 변형 뒤에 경계값·랜덤 변형(add_value_variants)을 붙인다. None이면 이전과 같은 케이스만 만든다.
    """
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

    def add(variant, picks, form="base", with_mask=keep_mask, mask_names=None):
        texts, evidence, shapes = [], [], []
        for index, ((symbol, _), (kind, text, source)) in enumerate(zip(per_operand, picks)):
            if index in masks and with_mask:
                mask, zeroing = masks[index]
                mask = (mask_names or {}).get(index, mask)
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
    add_fp_controls(row, per_operand, base, masks, keep_mask, add, cases)
    if extra is not None:
        add_value_variants(row, per_operand, masks, keep_mask, set(excluded or ()), add, extra)
    return cases, notes


# ---------- 경계값·랜덤 변형 (2026-11-11 교수님 미팅: 문법마다 1개가 아니라 값을 늘려 트리아지) ----------

FIXED_FAMILIES = ("ST(i)", "Sreg", "CR0–CR7", "DR0–DR7")   # 값 범위가 의미를 바꾸는 레지스터는 대표값 유지


def register_family_of(name):
    """고른 레지스터 이름 -> case_rules.REGISTER_LISTS 이름. xmm16~31 등 EVEX 확장도 같은 계열."""
    vector = re.fullmatch(r"([xyz]mm)(\d+)", name)
    if vector:
        return vector.group(1)
    for family, (_, names) in R.REGISTER_LISTS.items():
        if name in names:
            return family
    return None


def register_pool(family, row):
    """경계·랜덤 변형에서 고를 수 있는 레지스터. EVEX 행의 벡터는 32개(R.EVEX_VECTOR), r8은 ah~bh 제외."""
    if family is None or family in FIXED_FAMILIES:
        return []
    if family in ("xmm", "ymm", "zmm") and row["opcode"].startswith("EVEX"):
        return ["%s%d" % (family, n) for n in range(R.EVEX_VECTOR[1])]
    names = list(R.REGISTER_LISTS[family][1])
    if family == "zmm" and not row["opcode"].startswith("EVEX"):
        names = names[:16]
    return [n for n in names if n not in R.HIGH_BYTE[1]]


def variable_register(symbol, kind):
    """값을 바꿔도 되는 레지스터 자리인가. 짝·묶음 레지스터(k1+1, zmm2+3)는 표 규칙이 있어 그대로 둔다."""
    return kind == "reg" and "+" not in R.clean_symbol(symbol)


class Picker:
    """한 변형 안에서 물리 레지스터가 겹치지 않게 고른다."""

    def __init__(self, excluded):
        self.used = set(physical(name) for name in excluded)

    def free(self, names):
        return [n for n in names if physical(n) not in self.used]

    def mark(self, name):
        self.used.add(physical(name))
        return name


def signed_hex(value):
    return "-0x%x" % -value if value < 0 else "0x%x" % value


def random_immediate(symbol, rng):
    """SYM030~033 범위의 부호 있는 값. 더 좁은 폭(IMMEDIATE_NARROWER)에 들어가는 값은 다시 뽑는다."""
    bits, narrow = R.IMMEDIATE_RANGE[symbol], R.IMMEDIATE_NARROWER[symbol]
    while True:
        value = rng.randint(-(1 << (bits - 1)), (1 << (bits - 1)) - 1)
        if not narrow or not -(1 << (narrow - 1)) <= value < (1 << (narrow - 1)):
            return signed_hex(value)


GPR64 = ["rax", "rcx", "rdx", "rbx", "rsp", "rbp", "rsi", "rdi"] + ["r%d" % n for n in range(8, 16)]


def random_displacement(rng):
    width = rng.choice([0, 8, 32])
    if not width:
        return 0
    return rng.randint(-(1 << (width - 1)), (1 << (width - 1)) - 1)


def address_text(base=None, index=None, scale=1, disp=0):
    parts = ([base] if base else []) + (["%s*%d" % (index, scale)] if index else [])
    text = "+".join(parts)
    if disp or not parts:
        text += ("-0x%x" % -disp if disp < 0 else ("+" if parts else "") + "0x%x" % disp)
    return "[" + text + "]"


def random_address(forms, needs_index, rng, picker):
    """랜덤 주소. forms: address_forms() 결과(rip만, base·sib, 셋 다). 주소 레지스터는 값 레지스터와 겹치지 않게 표시."""
    if forms == ["rip"] or ("rip" in forms and not needs_index and rng.random() < 0.15):
        disp = rng.randint(-(1 << 31), (1 << 31) - 1)
        return "[rip%s]" % ("-0x%x" % -disp if disp < 0 else "+0x%x" % disp)
    base = picker.mark(rng.choice(picker.free(GPR64)))
    index = None
    if needs_index or rng.random() < 0.5:
        index = picker.mark(rng.choice([r for r in picker.free(GPR64) if r != "rsp"]))
        if not needs_index and rng.random() < 0.2:
            base = None                                   # 기준 없는 SIB(색인만, disp32)
    disp = random_displacement(rng)
    if base is None and not disp:
        disp = rng.randint(1, 0x7fffffff)
    return address_text(base, index, rng.choice([1, 2, 4, 8]) if index else 1, disp)


def vsib_text(template_or_none, index, rng=None, picker=None):
    """VSIB 주소. 템플릿(VSIB_BOUNDARY) 또는 랜덤 기준·배율·변위."""
    if template_or_none:
        return template_or_none.replace("{v}", index)
    base = picker.mark(rng.choice(picker.free(GPR64)))
    return address_text(base, index, rng.choice([1, 2, 4, 8]), random_displacement(rng))


def needs_sib(row):
    return any("sibmem" in s for s in row["symbols"]) or any(R.clean_symbol(s) == "mib" for s in row["symbols"])


def boundary_addresses(row, forms):
    """주소 경계 이름 목록(case_rules.ADDRESS_BOUNDARY 등). 원문이 주소 형태를 정한 행은 그 안에서만."""
    if not forms:
        return []
    if forms == ["rip"]:
        return list(R.RIP_BOUNDARY)
    if needs_sib(row):
        return list(R.SIB_REQUIRED_BOUNDARY)
    names = list(R.ADDRESS_BOUNDARY)
    if "rip" in forms:
        names += list(R.RIP_BOUNDARY)
    if row["opcode"].startswith("EVEX"):
        names += list(R.EVEX_DISP_BOUNDARY)
    return names


def add_value_variants(row, per_operand, masks, keep_mask, excluded, add, extra):
    """경계값 변형(hi, h8, imm:값, addr:이름)과 시드 랜덤 변형(randN)을 붙인다. 오퍼랜드 형식은 대표 변형과 같다."""
    symbols = [s for s, _ in per_operand]
    base = [c[0] for _, c in per_operand]
    mask_with = keep_mask or bool(masks)
    # hi: 각 레지스터 자리에 목록 끝(번호가 가장 큰) 레지스터, 쓰기 마스크 k7(REX.R/B·EVEX.R'/V' 경계)
    picker, picks, changed = Picker(excluded), [], False
    for symbol, (kind, text, source) in zip(symbols, base):
        if variable_register(symbol, kind):
            pool = picker.free(register_pool(register_family_of(text), row))
            if pool:
                text, changed = picker.mark(pool[-1]), True
        picks.append((kind, text, source))
    picks = [(k, vsib_text("[rax+{v}]", picker.mark(picker.free(register_pool(re.search(r"([xyz]mm)\d+", t).group(1),
                                                                                 row))[-1])), s)
             if k == "vsib" else (k, t, s) for k, t, s in picks]
    changed = changed or any(k == "vsib" for k, _, _ in picks)
    if changed:
        add("hi", picks, first_form(row, picks), with_mask=mask_with,
            mask_names={i: picker.mark(picker.free(R.WRITEMASKS[1])[-1]) for i in masks})
    # h8: ah~bh(SYM026). REX와 같이 쓸 수 없으므로 r64·REX.W가 없는 행만
    families = [register_family_of(t) for k, t, _ in base if k == "reg"]
    if "r8" in families and "r64" not in families and "REX" not in row["opcode"]:
        picker, picks = Picker(excluded), []
        for symbol, (kind, text, source) in zip(symbols, base):
            if variable_register(symbol, kind) and register_family_of(text) == "r8":
                free = picker.free(R.HIGH_BYTE[1])
                text = picker.mark(free[0]) if free else text
            elif kind == "reg":
                picker.mark(text)
            picks.append((kind, text, source))
        if picks != base:
            add("h8", picks, first_form(row, picks))
    # imm:값 -- 모든 즉시값 자리에 그 기호의 경계값 k번째
    imm_symbols = [R.clean_symbol(s) for s, (k, _, _) in zip(symbols, base) if k == "imm"]
    if imm_symbols:
        count = max(len(R.IMMEDIATE_BOUNDARY[s]) for s in imm_symbols)
        for k in range(count):
            picks = [(kind, R.IMMEDIATE_BOUNDARY[R.clean_symbol(s)][k % len(R.IMMEDIATE_BOUNDARY[R.clean_symbol(s)])]
                      if kind == "imm" else text, source) for s, (kind, text, source) in zip(symbols, base)]
            add("imm:" + "/".join(t for kind, t, _ in picks if kind == "imm"), picks, first_form(row, picks))
    # addr:이름 -- 메모리 자리가 있는 첫 대안(일반 메모리 우선)에 주소 경계
    memory_alt = first_memory_alt(per_operand)
    if memory_alt is not None:
        picks = [c[memory_alt] if memory_alt < len(c) else c[0] for _, c in per_operand]
        vsib_at = [i for i, (k, _, _) in enumerate(picks) if k == "vsib"]
        if vsib_at:
            for name, template in R.VSIB_BOUNDARY.items():
                index = re.search(r"[xyz]mm\d+", picks[vsib_at[0]][1]).group(0)
                trial = list(picks)
                trial[vsib_at[0]] = ("vsib", vsib_text(template, index), picks[vsib_at[0]][2])
                add("addr:" + name, trial, "base", with_mask=keep_mask)
        else:
            for name in boundary_addresses(row, address_forms(row, picks)):
                add("addr:" + name, picks, name)
    # randN -- 시드 랜덤(행 번호·순번으로 재현). 대안·레지스터·즉시값·주소·마스크를 함께 뽑는다
    width = max(len(c) for _, c in per_operand)
    for number in range(extra.get("random", 0)):
        rng = random.Random("%s:%s:%d" % (extra.get("seed", 0), row["row_id"], number))
        alt = rng.randrange(width)
        picks = [c[alt] if alt < len(c) else c[0] for _, c in per_operand]
        picker = Picker(excluded)
        for symbol, (kind, text, _) in zip(symbols, picks):   # 고정 레지스터·문자열 주소 레지스터는 먼저 표시
            if not variable_register(symbol, kind):
                for name in re.findall(r"[a-z]+\d*[a-z]?", text):
                    if name in R.GPR_NUMBER:
                        picker.mark(name)
        forms = address_forms(row, picks) if any("{addr}" in t for _, t, _ in picks) else []
        address = random_address(forms, needs_sib(row), rng, picker) if forms else "base"
        chosen = []
        for symbol, (kind, text, source) in zip(symbols, picks):
            if variable_register(symbol, kind):
                pool = picker.free(register_pool(register_family_of(text), row))
                text = picker.mark(rng.choice(pool)) if pool else text
            elif kind == "imm":
                text = random_immediate(R.clean_symbol(symbol), rng)
            elif kind == "vsib":
                family = re.search(r"([xyz]mm)\d+", text).group(1)
                text = vsib_text(None, picker.mark(rng.choice(picker.free(register_pool(family, row)))), rng, picker)
            chosen.append((kind, text, source))
        with_mask = keep_mask or (bool(masks) and rng.random() < 0.5)
        names = {i: picker.mark(rng.choice(picker.free(R.WRITEMASKS[1]))) for i in masks}
        add("rand%d" % number, chosen, address, with_mask=with_mask, mask_names=names)


def first_memory_alt(per_operand):
    """메모리 자리가 있는 첫 대안 번호(일반 메모리·VSIB 우선, 없으면 브로드캐스트). 없으면 None."""
    width = max(len(c) for _, c in per_operand)
    for wanted in (("mem", "vsib", "string_mem", "moffs"), ("bcst",)):
        for alt in range(width):
            picks = [c[alt] if alt < len(c) else c[0] for _, c in per_operand]
            if any(k in wanted and ("{addr}" in t or k == "vsib") for k, t, _ in picks):
                return alt
    return None


def first_form(row, picks):
    forms = address_forms(row, picks) if any("{addr}" in t for _, t, _ in picks) else []
    return forms[0] if forms else "base"


def add_fp_controls(row, per_operand, base, masks, keep_mask, add, cases):
    """대표 레지스터 형식에 ER 네 모드/SAE 변형을 기존 케이스 뒤에 추가한다."""
    symbols = [symbol for symbol, _ in per_operand]
    for index, symbol in enumerate(symbols):
        controls = tuple(FP.ROUNDING) if "{er}" in symbol else ("{sae}",) if "{sae}" in symbol else ()
        for control in controls:
            for with_mask in ([keep_mask, True] if masks and not keep_mask else [keep_mask]):
                label = ("er:" + control[1:-1] if control in FP.ROUNDING else "sae") + (":mask" if with_mask else "")
                add(label, base, with_mask=with_mask)
                variant, texts, evidence, shapes = cases.pop()
                trial = list(texts)
                trial.insert(index + 1, control)
                if FP.form_error(row["opcode"], symbols, ", ".join(trial)):
                    continue
                texts.insert(index + 1, control)
                shapes.insert(index + 1, control)
                evidence.append(control + "=" + FP.EVIDENCE)
                cases.append((variant, texts, evidence, shapes))


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
    # XBEGIN rel16의 data16, moffs의 movabs·rex64 철자는 2026-11-11에 뺐다(매뉴얼 문법만, case_rules.ROW_SPELLINGS 주석).
    # 64비트 절대 주소 'mov al, byte ptr [0x123456789abcdef0]'는 두 도구 모두 A0 moffs로 조립한다(2026-11-11 관측).
    return rule[2] if rule else "", notes


def generate(rows, extra=None):
    """extra: {'seed': 정수, 'random': 행마다 랜덤 변형 수}. None이면 경계·랜덤 변형 없이 대표 변형만."""
    by_mnemonic = collections.defaultdict(list)
    for row in rows:
        by_mnemonic[row["name"]].append(row["symbols"])
    cases = []
    for row in rows:
        fixed_operand, notes = apply_row_spelling(row)
        excluded = excluded_registers(row["name"], by_mnemonic[row["name"]])
        regs = RowRegisters(excluded)
        if fixed_operand:
            built = [("base", [fixed_operand], ["%s=mem(SYM046)" % R.clean_symbol(row["symbols"][0])], [fixed_operand])]
            more = []
        else:
            built, more = build_row_cases(row, regs, excluded, extra)
        valid = row["isa"]["mode_support"] == "Valid"
        seen = set()     # 같은 행에서 같은 소스가 된 변형은 처음 것만
        built = [b for b in built if not (source_line(row, b[1]) in seen or seen.add(source_line(row, b[1])))]
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
    mark_far_pointer_aliases(cases)
    ambiguous = ATT.ambiguous_keys(c["source"] for c in cases)
    for case in cases:   # 원본 Intel 소스를 AT&T로 직접 바꾼 소스(pipeline/att_syntax.py). 못 바꾸면 비우고 이유를 notes에
        try:
            case["source_att"] = ATT.convert(case["source"], ambiguous)
        except ATT.Unsupported as error:
            case["source_att"] = ""
            case["notes"] = "; ".join(filter(None, [case["notes"], "AT&T 변환 안 함: " + str(error)]))
    return cases


def alias_key(case):
    """같은 문법인지 비교하는 열쇠. 먼 라벨(.Ltarget16/.Ltarget32)은 같은 라벨 문법으로 본다.
    숫자는 값으로 비교한다(경계값 '0x1'과 1비트 시프트 행의 표 값 '1'은 같은 소스, 2026-11-11)."""
    key = re.sub(r"\.Ltarget(16|32)\b", ".LtargetFAR", case["shape"]).lower()
    return re.sub(r"(?<![\w.])(-?)(0x[0-9a-f]+|\d+)\b", lambda m: str(int(m.group(1) + m.group(2), 0)), key)


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


def mark_far_pointer_aliases(cases):
    """FAR_POINTER_MEMORY_ALIASES: 무효 행의 메모리 형식이 유효한 m16:16 행과 같은 문법이면 거부 시험을 만들지 않는다.
    m16:16 행의 소스(data16 ... fword ptr)는 도구 철자라 모양 비교(mark_aliases)로는 찾지 못한다."""
    row_of = {c["instruction"]: c["row_id"] for c in cases}
    for case in cases:
        rule = R.FAR_POINTER_MEMORY_ALIASES.get(case["instruction"])
        if not rule or "[" not in case["source"] or rule[0] not in row_of:
            continue
        case["alias_rows"] = " ".join(filter(None, [case["alias_rows"], str(row_of[rule[0]])]))
        if case["expected"] == "reject":
            case["expected"] = "alias_no_test"
        case["notes"] = "; ".join(filter(None, [case["notes"], "같은 문법의 유효 행 %s: %s" % rule]))


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
    parser.add_argument("--values", action="store_true",
                        help="경계값·시드 랜덤 변형을 붙인다(2026-11-11 설계). 없으면 대표 변형만")
    parser.add_argument("--seed", type=int, default=20261111)
    parser.add_argument("--random", type=int, default=3, help="--values일 때 행마다 랜덤 변형 수")
    args = parser.parse_args()
    extra = {"seed": args.seed, "random": args.random} if args.values else None
    summary = write_outputs(generate(load_rows(), extra), args.out)
    summary["values"] = extra
    with open(os.path.join(args.out, "generate_summary.json"), "w", encoding="utf-8") as handle:
        json.dump(summary, handle, ensure_ascii=False, indent=1)
    print(json.dumps(summary, ensure_ascii=False))


if __name__ == "__main__":
    main()

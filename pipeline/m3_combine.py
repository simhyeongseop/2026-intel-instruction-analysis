"""
3단계 combiner: tokens.csv -> combos.csv

2단계(tokenizer)가 오퍼랜드 단위로 쪼개놓은 "타입 토큰"(예: r/m32, imm8, xmm2/m128)을
실제 어셈블리에 쓸 수 있는 "구체적인 값"(concrete instance)의 후보로 펼친다.

예: ADD 명령어, row_id 하나에 operand_token 이 ["r/m32", "r32"] 라면
    -> combo 0: ["dword ptr [eax]", "ecx"]   (r/m32 를 메모리로 선택)
    -> combo 1: ["ecx", "ecx"]                (r/m32 를 레지스터로 선택)

원칙(CLAUDE.md, 작업 지시):
- "대표 후보 1개씩"만 둔다. r32 -> 레지스터 1종(ecx), m32 -> 메모리 1종([eax]) 처럼.
  다양한 레지스터/메모리 형태를 다 만들지 않는다 (조합 폭발 방지, 나중 확장 과제).
- r/m32 같은 "슬래시 대안"만 예외적으로 여러 조합(레지스터 버전 / 메모리 버전)으로 늘린다.
- 오퍼랜드 타입 -> 후보 값 매핑은 아래 REG_RULES / MEM_SIZE_MAP 같은 "간단한 딕셔너리"로 둔다.
  형섭이 필요하면 이 딕셔너리만 보고 고칠 수 있게 한다.
- 64비트 모드에서 무효한 form(mode_support 가 Invalid/N.E./N.S.)도 조합은 만들되
  expected_valid=False 로 표시한다(생성은 하고 구분만 한다).
- operand_kind="other"(k1+1, xmm2+3 같은 특이 표기)는 무리해서 펼치지 않고 원문 그대로
  하나의 후보로 남긴다. note 컬럼에 이유를 남긴다.
"""

import csv
import re
from itertools import zip_longest

IN_CSV = "data/db/tokens.csv"
OUT_CSV = "data/db/combos.csv"

OUT_COLUMNS = [
    "combo_id", "mnemonic", "row_id", "combo_index",
    "operand_types", "operands", "operand_count",
    "expected_valid", "mode_support", "cpuid_flag",
    "note", "raw_instruction", "source_page",
]

# ---------- 오퍼랜드 타입 -> 대표 후보 값 매핑 (형섭이 여기만 보고 고치면 됨) ----------

DECORATION_RE = re.compile(r"\{[^}]*\}")  # {k1}, {z}, {er}, {sae} 제거

# 레지스터 "타입 이름" -> 대표 레지스터 1개.
# 정규식은 위에서부터 순서대로 매치를 시도한다(먼저 매치되면 그걸 쓴다).
REG_RULES = [
    (re.compile(r"^AL$"), "al"), (re.compile(r"^AH$"), "ah"),
    (re.compile(r"^AX$"), "ax"), (re.compile(r"^EAX$"), "eax"), (re.compile(r"^RAX$"), "rax"),
    (re.compile(r"^CL$"), "cl"), (re.compile(r"^DX$"), "dx"),
    (re.compile(r"^CS$"), "cs"), (re.compile(r"^SS$"), "ss"), (re.compile(r"^DS$"), "ds"),
    (re.compile(r"^ES$"), "es"), (re.compile(r"^FS$"), "fs"), (re.compile(r"^GS$"), "gs"),
    (re.compile(r"^r8[ab]?$"), "cl"),
    (re.compile(r"^r16$"), "cx"),
    (re.compile(r"^r32[ab]?$"), "ecx"),
    (re.compile(r"^r64[ab]?$"), "rcx"),
    (re.compile(r"^r$"), "ecx"),          # r/m8 등에서 사이즈 정보 없는 bare 'r' (fallback)
    (re.compile(r"^reg$"), "ecx"),
    (re.compile(r"^Sreg$"), "ds"),
    (re.compile(r"^xmm\d*$"), "xmm0"),
    (re.compile(r"^ymm\d*$"), "ymm0"),
    (re.compile(r"^zmm\d*$"), "zmm0"),
    (re.compile(r"^mm\d*$"), "mm0"),
    (re.compile(r"^k\d+$"), "k1"),
    (re.compile(r"^bnd\d*$"), "bnd0"),
    (re.compile(r"^tmm\d+$"), "tmm0"),
    (re.compile(r"^ST(\(.*\))?$"), "st(0)"),
    (re.compile(r"^CR\d+.*$"), "cr0"),
    (re.compile(r"^DR\d+.*$"), "dr0"),
]

# bare 'r' (예: "r/m32" 를 '/'로 나누면 register 쪽이 그냥 'r'만 남음) 를 만났을 때,
# 짝인 메모리 쪽 크기(m8/m16/m32/m64)를 보고 사이즈를 맞춰주기 위한 표.
BARE_R_SIZE_TO_REG = {"8": "cl", "16": "cx", "32": "ecx", "64": "rcx"}

# 메모리 오퍼랜드 크기(mN) -> Intel syntax 크기 접두어. 대표 주소는 항상 [eax] 하나로 고정.
MEM_SIZE_RE = re.compile(r"^m(128|256|384|512|80|8|16|32|64)(?!\d)")
MEM_SIZE_TO_PTR = {
    "8": "byte ptr", "16": "word ptr", "32": "dword ptr", "64": "qword ptr",
    "80": "tbyte ptr", "128": "xmmword ptr", "256": "ymmword ptr", "512": "zmmword ptr",
    "384": None,  # 딱 맞는 Intel 키워드가 없음 -> 크기 접두어 없이 기본 주소만 사용
}
MEM_DEFAULT = "[eax]"

IMM_MAP = {"imm8": "1", "imm16": "0x100", "imm32": "0x10000", "imm64": "0x100000000"}
LITERAL_NUM_RE = re.compile(r"^-?\d+$")

FAR_PTR_MAP = {"ptr16:16": "0x10:0x1234", "ptr16:32": "0x10:0x12345678"}


def strip_decorations(token):
    """{k1}, {z}, {er}, {sae} 같은 마스크/라운딩 표기 제거."""
    return DECORATION_RE.sub("", token).strip()


def register_candidate(atom):
    """레지스터 타입 이름(atom) 하나 -> 대표 레지스터 값. 모르면 원문 소문자로 fallback."""
    for pattern, value in REG_RULES:
        if pattern.match(atom):
            return value
    return atom.lower()


def memory_candidate(atom):
    """메모리 타입 이름(atom) 하나 -> 대표 메모리 오퍼랜드 문자열."""
    m = MEM_SIZE_RE.match(atom)
    if m:
        ptr_kw = MEM_SIZE_TO_PTR.get(m.group(1))
        if ptr_kw:
            return f"{ptr_kw} {MEM_DEFAULT}"
    return MEM_DEFAULT  # 크기를 못 알아낸 경우(m2byte, m16:16, vm32x, mem, mib 등) 기본값


def is_memory_atom(part):
    """'/'로 나눈 조각 하나가 메모리 표기인지 대충 판단."""
    if part in ("mem", "sibmem", "mib"):
        return True
    if re.match(r"^m\d", part):
        return True
    if re.match(r"^vm(32|64)[xyz]$", part):
        return True
    return False


def expand_reg_or_mem(clean_token):
    """r/m32, xmm2/m128, xmm2/m128/m32bcst 같은 reg-or-mem 토큰을
    [레지스터 대표값, 메모리 대표값] 두 개의 후보로 나눈다."""
    parts = [p.strip() for p in clean_token.replace(" ", "").split("/") if p.strip()]
    mem_parts = [p for p in parts if is_memory_atom(p)]
    reg_parts = [p for p in parts if not is_memory_atom(p)]

    mem_part = mem_parts[0] if mem_parts else None
    reg_part = reg_parts[0] if reg_parts else None

    mem_candidate = memory_candidate(mem_part) if mem_part else MEM_DEFAULT

    if reg_part == "r" and mem_part:
        # bare 'r' -> 짝인 메모리 크기에 맞춰 레지스터 사이즈를 고른다.
        size_match = re.match(r"^m(\d+)", mem_part)
        size = size_match.group(1) if size_match else None
        reg_candidate = BARE_R_SIZE_TO_REG.get(size, "ecx")
    elif reg_part:
        reg_candidate = register_candidate(reg_part)
    else:
        reg_candidate = "ecx"

    return [reg_candidate, mem_candidate]


def expand_implicit(token):
    """<EAX>, <XMM0-7> 같은 암묵 오퍼랜드 표기 -> 대표 레지스터 이름 하나."""
    match = re.search(r"<([^>]+)>", token)
    if not match:
        return [token], "implicit_malformed_token"
    inside = match.group(1).split("-")[0].strip()
    return [inside.lower()], ""


def expand_token(token, kind):
    """오퍼랜드 토큰 하나(원문) -> (후보 리스트, 참고 note).
    kind 는 tokenizer 가 이미 분류해둔 operand_kind 힌트."""
    clean = strip_decorations(token)

    if kind == "immediate":
        if LITERAL_NUM_RE.match(clean):
            return [clean], ""
        return [IMM_MAP.get(clean, "1")], ""

    if kind == "relative":
        return [".Ltarget"], ""

    if kind == "moffs":
        return ["0x1000"], ""

    if kind == "far_ptr":
        return [FAR_PTR_MAP.get(clean, "0x10:0x1234")], ""

    if kind == "implicit":
        return expand_implicit(token)

    if kind == "register":
        # r16/r32/r64, xmm2/mm128 처럼 순수 레지스터 대안이면 첫 후보만 대표로 쓴다.
        first = clean.split("/")[0].strip()
        return [register_candidate(first)], ""

    if kind == "memory":
        return [memory_candidate(clean)], ""

    if kind == "reg_or_mem":
        return expand_reg_or_mem(clean), ""

    # kind == "other" (k1+1, xmm2+3, imm8/r 등): 무리해서 펼치지 않고 원문 그대로 남긴다.
    return [token], "other_kept_raw"


def expected_valid(mode_support):
    """mode_support 가 Valid 인 경우만 64비트 모드에서 유효하다고 표시."""
    return mode_support == "Valid"


def read_tokens(path):
    with open(path, newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))


def group_by_row(token_rows):
    """row_id 순서를 보존하면서, 같은 row_id 의 오퍼랜드 행들을 묶는다."""
    groups = {}
    order = []
    for row in token_rows:
        rid = row["row_id"]
        if rid not in groups:
            groups[rid] = []
            order.append(rid)
        groups[rid].append(row)
    return [(rid, groups[rid]) for rid in order]


def build_combos_for_row(operand_rows):
    """한 row_id 의 오퍼랜드 행들 -> combo 리스트.
    각 combo 는 {"operand_types": [...], "operands": [...], "note": "..."} 형태."""
    first = operand_rows[0]
    if first["operand_kind"] == "none":
        return [{"operand_types": [], "operands": [], "note": ""}]

    per_position_candidates = []  # 오퍼랜드 자리마다 후보 리스트
    operand_types = []
    notes = []
    for row in operand_rows:
        candidates, note = expand_token(row["operand_token"], row["operand_kind"])
        per_position_candidates.append(candidates)
        operand_types.append(row["operand_token"])
        if note:
            notes.append(f"op{row['operand_index']}:{note}")

    # 자리마다 후보 개수가 다르면(reg_or_mem=2개, 나머지=1개), 짧은 자리는 첫 후보를
    # 반복해서 채운다(broadcast). 이러면 전수 곱집합 없이 "대표 조합 몇 개"만 생긴다.
    max_len = max(len(c) for c in per_position_candidates)
    combos = []
    for i in range(max_len):
        operands = [c[i] if i < len(c) else c[0] for c in per_position_candidates]
        combos.append({
            "operand_types": operand_types,
            "operands": operands,
            "note": "; ".join(notes),
        })
    return combos


def main():
    token_rows = read_tokens(IN_CSV)
    print(f"입력 행 수(오퍼랜드 단위): {len(token_rows)}")

    out_rows = []
    combo_id = 0
    for row_id, operand_rows in group_by_row(token_rows):
        common = operand_rows[0]
        combos = build_combos_for_row(operand_rows)
        for idx, combo in enumerate(combos):
            out_rows.append({
                "combo_id": combo_id,
                "mnemonic": common["mnemonic"],
                "row_id": row_id,
                "combo_index": idx,
                "operand_types": ", ".join(combo["operand_types"]),
                "operands": ", ".join(combo["operands"]),
                "operand_count": len(combo["operands"]),
                "expected_valid": expected_valid(common["mode_support"]),
                "mode_support": common["mode_support"],
                "cpuid_flag": common["cpuid_flag"],
                "note": combo["note"],
                "raw_instruction": common["raw_instruction"],
                "source_page": common["source_page"],
            })
            combo_id += 1

    with open(OUT_CSV, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=OUT_COLUMNS)
        writer.writeheader()
        for row in out_rows:
            writer.writerow(row)

    print(f"원본 명령어(row_id) 수: {len(group_by_row(token_rows))}")
    print(f"출력 조합(combo) 수: {len(out_rows)}")
    print(f"CSV 저장: {OUT_CSV}")


if __name__ == "__main__":
    main()

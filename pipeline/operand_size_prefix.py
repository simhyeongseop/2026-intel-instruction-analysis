"""레거시 행의 66H(오퍼랜드 크기 접두어) 요구: 같은 opcode 칸을 쓰는 표 행끼리 오퍼랜드 크기로만 갈리는 경우.

근거
- Vol.1 Table 3-4(파일 83쪽, 인쇄 3-19): 64비트 모드에서 REX.W=0이면 66H 없음 = 32비트, 66H 있음 = 16비트.
- Vol.2 2.2.1.7(파일 42쪽): 가까운 분기와 RSP를 암묵적으로 쓰는 명령은 기본 64비트(66H이 있으면 16비트).
같은 opcode 칸(REX.W 없음)에 r/m16 행과 r/m32(또는 기본 64비트 r/m64) 행이 함께 있으면, 바이트에서 둘을 가르는 것은
66H뿐이다. 그래서 16비트 행은 66H가 있어야 하고 32·64비트 행은 66H가 없어야 한다.
16비트가 명령 자체로 고정되어 갈라지는 짝 행이 없는 행(ENTER, RET imm16, LLDT 등)은 대상이 아니다.
opcode 칸에 66이 필수 접두어로 적힌 행도 대상이 아니다.
"""

import csv
import os
import re

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ISA_DB = os.path.join(ROOT, "data/db/isa_db.csv")

# 오퍼랜드 칸의 크기 있는 기호: 같은 종류(kind)끼리 크기가 다르면 오퍼랜드 크기로 갈리는 행이다.
SIZED = {
    "r16": ("r", 16), "r32": ("r", 32), "r64": ("r", 64),
    "r/m16": ("r/m", 16), "r/m32": ("r/m", 32), "r/m64": ("r/m", 64),
    "AX": ("acc", 16), "EAX": ("acc", 32), "RAX": ("acc", 64),
    "imm16": ("imm", 16), "imm32": ("imm", 32),
    "m16": ("m", 16), "m32": ("m", 32), "m64": ("m", 64),
    "m16:16": ("far", 16), "m16:32": ("far", 32),
    "rel16": ("rel", 16), "rel32": ("rel", 32),
}
# 오퍼랜드 없는 행(CBW, MOVSW, PUSHF, LEAVE ...)은 Description 칸에서 가장 먼저 나오는 크기 표현(대개 목적지)으로 읽는다.
# 예: CWDE "EAX := sign-extend of AX." -> 32, CWD "DX:AX := sign-extend of AX." -> 16.
DESCRIPTION_SIZE = [
    (16, r"16-bit operand size|lower 16 bits|\bword\b|\b(AX|SP|BP|DX:AX)\b"),
    (32, r"32-bit operand size|\bdword\b|\bdoubleword\b|\b(EAX|ESP|EBP|EDX:EAX|EFLAGS)\b"),
    (64, r"64-bit operand size|\bquadword\b|\b(RAX|RSP|RBP|RDX:RAX|RFLAGS)\b"),
]

_RULES = None
_REX_W_KEYS = None


def opcode_key(opcode):
    """같은 opcode 칸인지 보는 열쇠: 공백, '+rw/+rd', 'iw/id', 'cw/cd' 차이를 지운다."""
    text = " ".join(re.sub(r"(?<=[0-9A-F])/", " /", opcode).split())
    text = re.sub(r"\+\s*r[wd]\b", "+r", text)
    text = re.sub(r"\b(iw|id)\b", "i*", text)
    return re.sub(r"\b(cw|cd)\b", "c*", text)


def symbols(row):
    out = []
    for part in row["operands"].split(","):
        part = re.sub(r"\s+", "", part)
        part = re.sub(r"^((?:r/m|r|m)(?:8|16|32|64))\d$", r"\1", part)   # 각주 숫자: r/m642 -> r/m64
        out.append(part)
    return [p for p in out if p]


def description_size(row):
    found = []
    for bits, pattern in DESCRIPTION_SIZE:
        match = re.search(pattern, row.get("description", ""))
        if match:
            found.append((match.start(), bits))
    return min(found)[1] if found else None


def row_size(row, siblings):
    """오퍼랜드 크기로 형제 행과 갈리면 그 크기(16/32/64), 아니면 None."""
    mine = symbols(row)
    if not mine:
        bits = description_size(row)
        others = {description_size(s) for s in siblings if not symbols(s)}
        return bits if bits and others - {bits, None} else None
    for other in siblings:
        theirs = symbols(other)
        if len(theirs) != len(mine):
            continue
        for a, b in zip(mine, theirs):
            if a in SIZED and b in SIZED and SIZED[a][0] == SIZED[b][0] and SIZED[a][1] != SIZED[b][1]:
                return SIZED[a][1]
    return None


def build_rules(isa):
    """(opcode, instruction, description) -> 16 / 32 / 64. LEAVE처럼 문법이 같은 행은 Description으로 가른다. 16이면 66H 필수, 32·64면 66H 없어야 함."""
    groups = {}
    for row in isa:
        opcode = row["opcode"]
        if opcode.startswith(("VEX", "EVEX")) or "REX.W" in opcode or re.match(r"66\b", opcode.strip()):
            continue
        groups.setdefault(opcode_key(opcode), []).append(row)
    rules = {}
    for rows in groups.values():
        for row in rows:
            bits = row_size(row, [r for r in rows if r is not row])
            if bits:
                rules[row_key(row)] = bits
    return rules


def rex_w_free_key(opcode):
    """'REX.W + FF /3' -> 'FF /3'의 열쇠. REX.W가 없으면 None."""
    if not re.match(r"\s*REX\.W\b", opcode):
        return None
    return opcode_key(re.sub(r"^\s*REX\.W\s*\+?\s*", "", opcode))


def forbids_rex_w(row):
    """같은 opcode 칸에 'REX.W +' 행이 따로 있는 레거시 행: REX.W가 있으면 그 64비트 행이다(Vol.1 Table 3-4).

    예: FF /3 CALL m16:32 와 REX.W FF /3 CALL m16:64, 01 /r ADD r/m32 와 REX.W 01 /r ADD r/m64.
    """
    global _REX_W_KEYS
    opcode = row.get("opcode", "")
    if opcode.startswith(("VEX", "EVEX")) or "REX.W" in opcode:
        return False
    if _REX_W_KEYS is None:
        with open(ISA_DB, encoding="utf-8", newline="") as handle:
            _REX_W_KEYS = {k for k in (rex_w_free_key(r["opcode"]) for r in csv.DictReader(handle)) if k}
    return opcode_key(opcode) in _REX_W_KEYS


def row_key(row):
    return (row.get("opcode", ""), row.get("instruction", ""), row.get("description", ""))


def required_size(row):
    global _RULES
    if _RULES is None:
        with open(ISA_DB, encoding="utf-8", newline="") as handle:
            _RULES = build_rules(list(csv.DictReader(handle)))
    return _RULES.get(row_key(row))

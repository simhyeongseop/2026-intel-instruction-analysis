"""원문이 값을 정하지 않는 곳의 기계적 선택 규칙 (2026-10-09 사용자 결정).

1. 대표 레지스터: 원문 목록 순서대로 고르되, 같은 절 표에 고정 오퍼랜드로 나온 레지스터는 뺀다.
   예: ADD 절에는 'ADD AL, imm8' 행이 있으므로 r8 대표값은 AL이 아니라 다음 항목 CL이다.
2. 방향 쌍: 같은 절에서 니모닉이 같고 Op/En이 MR과 RM이며 오퍼랜드 기호가 서로 뒤바뀐 행끼리 묶는다.
   두 오퍼랜드를 레지스터로 썼을 때 같은 종류(r/m8 과 r8)여야 소스 문자열이 같아져 행을 정할 수 없다.
   종류가 다르면(r/m16 과 Sreg) 문자열 순서로 행이 정해지므로 짝이 아니다.

여기에는 원문 해석이 없다. 원문 목록 문자열과 같은 절의 표 행만 입력으로 쓴다.
"""

import re

RANGE = re.compile(r"\b([A-Za-z]+)(\d+)([A-Za-z]?)\s*(?:through|[-–])\s*\1?(\d+)\3?\b")
NAME = re.compile(r"\b(?:[A-Z]{1,3}[A-Z0-9]*|[a-z]\d)\b")
NOT_REGISTERS = {"REX", "R", "W", "B", "X", "OR", "AND", "WITH", "IN", "MODE"}


def expand_register_list(text):
    """원문 목록 문자열 -> 레지스터 이름 목록(원문 순서, 대문자). 범위 표기는 펼친다.

    'XMM0 through XMM7; XMM8 through XMM15 ...' -> XMM0..XMM15
    'RAX, RBX, ..., RSP, R8–R15'                 -> RAX, RBX, ..., RSP, R8..R15
    '(R8B - R15B)'                                -> R8B..R15B
    """
    names = []
    position = 0
    text = text or ""
    while position < len(text):
        ranged = RANGE.match(text, position)
        if ranged and (ranged.start() == position):
            prefix, first, suffix, last = ranged.group(1), int(ranged.group(2)), ranged.group(3), int(ranged.group(4))
            for number in range(first, last + 1):
                names.append(("%s%d%s" % (prefix, number, suffix)).upper())
            position = ranged.end()
            continue
        word = NAME.match(text, position)
        if word and word.start() == position:
            token = word.group(0).upper()
            if token not in NOT_REGISTERS and not token.isdigit():
                names.append(token)
            position = word.end()
            continue
        position += 1
    seen, ordered = set(), []
    for name in names:
        if name not in seen:
            seen.add(name)
            ordered.append(name)
    return ordered


def fixed_registers(section_rows):
    """같은 절 표 행의 오퍼랜드 중 레지스터 이름이 그대로 적힌 것(AL, DX, <XMM0> 등)."""
    found = set()
    for row in section_rows:
        for operand in (row.get("operands") or "").split(","):
            name = operand.strip().strip("<>").upper()
            if re.match(r"^(?:[ER]?[A-D]X|[A-D][LH]|[ER]?[SD]I|[ER]?[SB]P|[XYZ]MM\d+|ST\(0\)|ST|CS|DS|ES|FS|GS|SS)$", name):
                found.add(name)
    return found


def pick_register(source_list_text, excluded):
    """원문 목록 순서에서 제외 집합에 없는 첫 레지스터. (선택, 펼친 목록) 반환."""
    ordered = expand_register_list(source_list_text)
    for name in ordered:
        if name not in excluded:
            return name, ordered
    return "", ordered


def modrm_order(op_en_line):
    """Operand Encoding 원문 줄에서 오퍼랜드 1·2의 ModRM 자리. 'ModRM:r/m (w) ModRM:reg (r) ...' -> ('r/m', 'reg')."""
    roles = re.findall(r"ModRM:(reg|r/m)", op_en_line or "")
    return tuple(roles[:2]) if len(roles) >= 2 else None


def register_form(symbol):
    """'r/m8' -> 'r8', 'xmm2/m128' -> 'xmm'. 레지스터로 쓸 때의 종류(번호·장식은 뗀다)."""
    symbol = re.sub(r"\s*\{[^}]*\}", "", symbol).strip()
    head = symbol.split("/")[0]
    if head == "r" and "/m" in symbol:
        return "r" + re.sub(r"\D", "", symbol.split("/m", 1)[1])
    return re.sub(r"\d+$", "", head) if re.match(r"^(xmm|ymm|zmm|mm|k)\d*$", head) else head


def direction_pairs(section_rows):
    """방향만 다른 행 짝 목록: (reg가 둘째 오퍼랜드인 행, reg가 첫째 오퍼랜드인 행, 같은 opcode인지).

    입력 행에는 row_id, mnemonic, opcode, operands, op_en_line(Operand Encoding 원문 줄)이 있어야 한다.
    Op/En 글자(MR, RM, A, B ...)는 절마다 뜻이 다르므로 쓰지 않고, 원문 줄의 ModRM 자리만 본다.
    """
    def operand_list(row):
        return [o.strip() for o in (row.get("operands") or "").split(",") if o.strip()]

    store_like, load_like = [], []
    for row in section_rows:
        operands = operand_list(row)
        order = modrm_order(row.get("op_en_line", ""))
        if len(operands) != 2 or order is None:
            continue
        if register_form(operands[0]) != register_form(operands[1]):
            continue   # 종류가 다르면 문자열 순서로 행이 정해진다(예: r/m16, Sreg)
        if order == ("r/m", "reg"):
            store_like.append(row)
        elif order == ("reg", "r/m"):
            load_like.append(row)
    def opcode_without_direction_byte(opcode):
        """'/r' 바로 앞 opcode 바이트를 뺀 나머지. 방향 쌍은 이 나머지(접두, VEX/EVEX 필드)가 같아야 한다.
        'VEX.128.0F.WIG 29 /r' -> 'VEX.128.0F.WIG /r', '88 /r' -> '/r'."""
        return re.sub(r"\b[0-9A-F]{2}\s+(/r)", r"\1", opcode.strip())

    def forms(row):
        return [register_form(o) for o in operand_list(row)]

    pairs = []
    for first in store_like:
        for second in load_like:
            # 기호 문자열이 아니라 '레지스터로 쓸 때의 종류'로 비교한다.
            # 예: MOVSS xmm2/m32, xmm1(11) 과 MOVSS xmm1, xmm2(10), EVEX 장식 위치가 다른 VMOVAPS 행.
            same_family = opcode_without_direction_byte(first["opcode"]) == opcode_without_direction_byte(second["opcode"])
            if first["mnemonic"] == second["mnemonic"] and same_family and forms(first) == list(reversed(forms(second))):
                pairs.append((first["row_id"], second["row_id"], first["opcode"] == second["opcode"]))
    return pairs

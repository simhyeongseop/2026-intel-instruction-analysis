"""역어셈블 대조 규칙: SDM이 정의한 의사 니모닉(pseudo-op)과 역어셈블 텍스트 읽기.

의사 니모닉은 즉시값을 니모닉에 넣은 표기다(예: VCMPPD ..., 12H = VCMPLE_OQPD). SDM 표만 옮긴다.
tests/test_m4_disasm.py가 표 값이 적힌 쪽 원문에 실제로 있는지 확인한다.
"""

import re

# Vol.2 288쪽 Table 3-9 "Pseudo-Op and CMPPD Implementation"(CMPPS/SD/SS 표 3-11·3-13·3-15도 같은 값)
CMP_LEGACY = ("Vol.2 288 Table 3-9", ["EQ", "LT", "LE", "UNORD", "NEQ", "NLT", "NLE", "ORD"])
# Vol.2 289쪽 VCMPPD 의사 니모닉 표(0~1FH). VCMPPS/SD/SS/PH/SH도 같은 술어 순서(290쪽 Operation, 1490쪽)
CMP_VEX = ("Vol.2 289", ["EQ", "LT", "LE", "UNORD", "NEQ", "NLT", "NLE", "ORD", "EQ_UQ", "NGE", "NGT", "FALSE",
                         "NEQ_OQ", "GE", "GT", "TRUE", "EQ_OS", "LT_OQ", "LE_OQ", "UNORD_S", "NEQ_US", "NLT_UQ",
                         "NLE_UQ", "ORD_S", "EQ_US", "NGE_UQ", "NGT_UQ", "FALSE_OS", "NEQ_OS", "GE_OQ", "GT_OQ",
                         "TRUE_US"])
# Vol.2 1927쪽 Table 5-19 "Pseudo-Op and VPCMP* Implementation". 5번은 PDF에 'VPPCMPNLT*'로 인쇄(오기)
VPCMP = ("Vol.2 1927 Table 5-19", {0: "EQ", 1: "LT", 2: "LE", 4: "NEQ", 5: "NLT", 6: "NLE"})
# Vol.2 946쪽 Table 4-15 "Pseudo-Op and PCLMULQDQ Implementation"
PCLMUL = ("Vol.2 946 Table 4-15", {0x00: "LQLQ", 0x01: "HQLQ", 0x10: "LQHQ", 0x11: "HQHQ"})

# Vol.2 31쪽 2.1.1: "REPNE/REPNZ prefix is encoded using F2H", "REP or REPE/REPZ is encoded using F3H".
# 접두어 단독 행(XACQUIRE F2, XRELEASE F3)과 REP 계열은 바이트로만 구분한다.
PREFIX_BYTE_NAMES = ("Vol.2 31 2.1.1", {"rep": "f3", "repe": "f3", "repz": "f3", "repne": "f2", "repnz": "f2",
                                        "xrelease": "f3", "xacquire": "f2", "lock": "f0"})
# Vol.2 506쪽 FSTCW: "The assembler issues two instructions for the FSTCW instruction (an FWAIT instruction
# followed by an FNSTCW instruction)". 9B로 시작하는 FSTSW·FSAVE·FSTENV·FCLEX·FINIT 행도 같은 짝이다.
FWAIT_PAIR = ("Vol.2 506", "an FWAIT instruction followed by an FNSTCW instruction")
# 도구 관례 철자: SDM 니모닉과 다르지만 같은 명령을 가리키는 도구 쪽 이름. SDM 일치로 세지 않고 따로 센다.
TOOL_SPELLINGS = {"movabs": "mov", "pushw": "push", "sysretd": "sysret", "sysexitd": "sysexit", "xbeginw": "xbegin",
                  "lcall": "call", "ljmp": "jmp", "fcompi": "fcomip", "fucompi": "fucomip",
                  "leavew": "leave", "iretw": "iret",
                  # CMPccXADD(Vol.2 281~285쪽)는 조건마다 이름 하나만 적는다. binutils 2.47·LLVM 23은 같은 조건 subcode의
                  # 다른 이름으로 출력한다. 조건 subcode(opcode 하위 4비트)가 같은 동의어는 Vol.1 Table B-1(파일 539쪽)에
                  # 있지만 그 표의 적용 대상은 CMOVcc·FCMOVcc·Jcc·SETcc라서 SDM 일치로 세지 않는다.
                  "cmpaxadd": "cmpnbexadd", "cmpaexadd": "cmpnbxadd", "cmpgxadd": "cmpnlexadd",
                  "cmpgexadd": "cmpnlxadd", "cmpnexadd": "cmpnzxadd", "cmpexadd": "cmpzxadd"}
# 원문 폭: 먼 포인터 m16:16/32/64는 오프셋 + 셀렉터(SYM046) = 32/48/80비트
FAR_POINTER_BITS = {"m16:16": 32, "m16:32": 48, "m16:64": 80}
# 먼 CALL/JMP(FF /3, FF /5)는 가까운 CALL/JMP r/m64(FF /2, FF /4)와 니모닉이 같다. 크기 표기도 l 접두 철자도 없으면
# 텍스트가 가까운 분기를 가리킨다(LLVM 'call [rax]'를 다시 조립하면 ff10). 먼 포인터로 이름 붙인 것으로 보지 않는다.
NEAR_AND_FAR = ("call", "jmp")

SIZE_WORDS = {"byte": 8, "word": 16, "dword": 32, "fword": 48, "qword": 64, "tbyte": 80, "xmmword": 128,
              "oword": 128, "ymmword": 256, "zmmword": 512}


def pseudo_op(base, imm):
    """SDM 표의 의사 니모닉 이름(소문자) 또는 None. base: 'vcmppd', 'cmpss', 'vpcmpub', 'pclmulqdq' ..."""
    cmp = re.fullmatch(r"(v?)cmp(ps|pd|ss|sd|ph|sh)", base)
    if cmp:
        table = CMP_VEX[1] if cmp.group(1) else CMP_LEGACY[1]
        return ("%scmp%s%s" % (cmp.group(1), table[imm].lower(), cmp.group(2))) if 0 <= imm < len(table) else None
    vpcmp = re.fullmatch(r"vpcmp(u?)(b|w|d|q)", base)
    if vpcmp:
        name = VPCMP[1].get(imm)
        return "vpcmp%s%s%s" % (name.lower(), vpcmp.group(1), vpcmp.group(2)) if name else None
    clmul = re.fullmatch(r"(v?)pclmulqdq", base)
    if clmul:
        name = PCLMUL[1].get(imm)
        return "%spclmul%sdq" % (clmul.group(1), name.lower()) if name else None
    return None


def number(text):
    text = text.strip().lower()
    try:
        return int(text, 0)
    except ValueError:
        return None


def split_operands(text):
    """쉼표로 나누되 [] {} () 안의 쉼표는 나누지 않는다."""
    parts, depth, current = [], 0, ""
    for char in text:
        if char in "[{(":
            depth += 1
        elif char in "]})":
            depth -= 1
        if char == "," and depth == 0:
            parts.append(current)
            current = ""
        else:
            current += char
    if current.strip():
        parts.append(current)
    return [p.strip() for p in parts]


def address(inner):
    """'rax+rbx*4+0x10', 'rax + 4*rbx + 16', 'rip+0x10' -> (base, index, scale, disp)."""
    inner = inner.replace(" ", "").lower()
    base, index, scale, disp = None, None, 1, 0
    for sign, term in re.findall(r"([+-]?)([^+-]+)", inner):
        scaled = re.fullmatch(r"([a-z0-9]+)\*(\d)|(\d)\*([a-z0-9]+)", term)
        value = number(term)
        if scaled:
            index = scaled.group(1) or scaled.group(4)
            scale = int(scaled.group(2) or scaled.group(3))
        elif value is not None:
            disp += -value if sign == "-" else value
        elif base is None:
            base = term
        else:
            index = term
    return base, index, scale, disp


def operand(text):
    """오퍼랜드 하나 -> 비교용 dict. 크기 키워드·세그먼트·장식·주소를 따로 읽는다."""
    text = text.strip().lower()
    decorations = set(re.findall(r"\{([^}]*)\}", text))
    text = re.sub(r"\s*\{[^}]*\}", "", text).strip()
    count = next((d for d in decorations if d.startswith("1to")), None)
    decorations.discard(count)
    size = re.match(r"(\w+)\s+(ptr|bcst)\s+", text)
    bits, bcst = None, False
    if size and size.group(1) in SIZE_WORDS:
        bits, bcst = SIZE_WORDS[size.group(1)], size.group(2) == "bcst"
        text = text[size.end():]
    absolute = re.fullmatch(r"[cdefgs]s:(0x[0-9a-f]+|\d+)", text)
    if absolute:                                  # objdump moffs 표기 'ds:0x...' = 절대 주소 메모리
        return {"kind": "mem", "bits": bits, "bcst": False, "count": None,
                "address": (None, None, 1, number(absolute.group(1))), "decor": decorations}
    text = re.sub(r"\b[cdefgs]s:", "", text)          # 세그먼트 표기(기본 세그먼트)는 비교하지 않는다
    if "[" in text:
        return {"kind": "mem", "bits": bits, "bcst": bcst or bool(count), "count": count,
                "address": address(text[text.index("[") + 1:text.rindex("]")]), "decor": decorations}
    if bits and number(text) is not None:          # moffs: 'ds:0x...' 또는 'byte ptr [0x...]'
        return {"kind": "mem", "bits": bits, "bcst": False, "count": None,
                "address": (None, None, 1, number(text)), "decor": decorations}
    value = number(text)
    if value is not None:
        return {"kind": "imm", "value": value & 0xffffffffffffffff, "decor": decorations}
    if text == "st":
        text = "st(0)"
    return {"kind": "reg", "name": text.replace(" ", ""), "decor": decorations}


def same_operand(source, decoded):
    """생성 소스의 오퍼랜드와 역어셈블 오퍼랜드가 같은 것을 가리키는가."""
    if source["kind"] != decoded["kind"] or source["decor"] != decoded["decor"]:
        return False
    if source["kind"] == "reg":
        return source["name"] == decoded["name"]
    if source["kind"] == "imm":
        return source["value"] == decoded["value"]
    if source["address"] != decoded["address"] or source["bcst"] != decoded["bcst"]:
        return False
    if source["bits"] and decoded["bits"] and source["bits"] != decoded["bits"]:
        return False
    return not (source["count"] and decoded["count"] and source["count"] != decoded["count"])

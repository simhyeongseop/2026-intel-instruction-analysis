"""Intel 소스 -> AT&T 소스 변환(2026-11-11 교수님 미팅: 왕복이 어긋날 때 역어셈블 문제인지 재조립 문제인지 가르기 위해
원본 Intel 소스를 AT&T 문법으로 직접 바꿔 같은 도구로 조립하고 바이트를 비교한다).

생성기(m2_generate)가 만드는 Intel 철자만 다룬다. 모르는 모양은 Unsupported로 알리고 짐작해서 바꾸지 않는다.
규칙의 근거는 GNU as 매뉴얼 9.16 'i386-Dependent'(binutils 2.47):
- i386-Variations "AT&T Syntax versus Intel Syntax":
  - 레지스터 '%', 즉시값 '$', 오퍼랜드 순서 반대. 'bound, invlpga, and instructions with 2 immediate operands,
    such as the enter instruction, do not have reversed order'
  - 메모리 크기는 니모닉 끝 글자(b, w, l, q)로 정한다. Intel은 'byte ptr' 등을 메모리 오퍼랜드에 붙인다
  - 메모리 'section:disp(base, index, scale)', 간접 분기·호출은 '*'
  - 먼 분기·호출·복귀는 'lcall', 'ljmp', 'lret' / 즉시 먼 포인터는 '$section, $offset'
- i386-Mnemonics: movsx/movzx는 'movs'/'movz' + 원천·목적 크기 글자(movsbl, movzwq ...), movsxd(r64)는 movslq.
  cvtsi2ss·cvtsi2sd 등 정수->실수 변환의 메모리 원천은 l/q, 부동소수점(x87) 메모리는 s(32)·l(64)·t(80),
  정수 x87(fi*)는 s(16)·l(32)·ll(64). 오퍼랜드 크기가 레지스터로 정해지면 글자를 붙이지 않아도 된다
- i386-SIMD/AVX512: 마스크 '{%k1}', '{z}', 브로드캐스트 '{1toN}', 반올림 '{rn-sae}'.
  메모리 폭이 레지스터로 정해지지 않는 벡터 변환(vcvtpd2ps 등)은 x/y/z 글자
변환 결과는 도구로 조립해 Intel 소스의 바이트와 비교하는 입력일 뿐이다. 변환이 틀릴 수 있으므로 어긋나면 변환부터 의심한다.
"""

import re

GPR_SIZES = {}
for _bits, _names in ((8, "al cl dl bl ah ch dh bh spl bpl sil dil"), (16, "ax cx dx bx sp bp si di"),
                      (32, "eax ecx edx ebx esp ebp esi edi"), (64, "rax rcx rdx rbx rsp rbp rsi rdi")):
    for _name in _names.split():
        GPR_SIZES[_name] = _bits
for _n in range(8, 16):
    GPR_SIZES.update({"r%db" % _n: 8, "r%dw" % _n: 16, "r%dd" % _n: 32, "r%d" % _n: 64})
VECTOR_BITS = {"xmm": 128, "ymm": 256, "zmm": 512}
OTHER_REGISTER = re.compile(r"^(?:[xyz]mm\d+|mm\d|k\d|bnd\d|tmm\d|st(?:\(\d\))?|[c-gs]s|cr\d+|dr\d)$")
KEYWORD_BITS = {"byte": 8, "word": 16, "dword": 32, "fword": 48, "qword": 64, "tbyte": 80,
                "xmmword": 128, "ymmword": 256, "zmmword": 512}
GPR_SUFFIX = {8: "b", 16: "w", 32: "l", 64: "q"}
PREFIX_WORDS = {"rep", "repe", "repne", "repz", "repnz", "lock", "xacquire", "xrelease"}
# 두 즉시값 명령(매뉴얼: 순서를 뒤집지 않음). 생성기가 만드는 것 중 즉시값이 둘인 것은 enter, extrq, insertq
NOT_REVERSED = {"bound", "invlpga"}
SHIFTS = {"rcl", "rcr", "rol", "ror", "sal", "sar", "shl", "shr"}
X87_INTEGER = {"fiadd", "ficom", "ficomp", "fidiv", "fidivr", "fild", "fimul", "fist", "fistp", "fisttp",
               "fisub", "fisubr"}
X87_REAL = {"fadd", "fcom", "fcomp", "fdiv", "fdivr", "fld", "fmul", "fst", "fstp", "fsub", "fsubr"}
X87_INTEGER_SUFFIX = {16: "s", 32: "l", 64: "ll"}
X87_REAL_SUFFIX = {32: "s", 64: "l", 80: "t"}
INT_TO_FLOAT = re.compile(r"^v?cvt(?:t?)u?si2s[sdh]$")
# 매뉴얼 'AT&T Syntax bugs': 두 레지스터 오퍼랜드의 비가환 x87 연산에서 원천이 %st, 목적이 %st(i)이면
# AT&T 니모닉의 뜻이 반대다('fsub %st,%st(3)'은 %st(3) = %st - %st(3)). 같은 연산을 내려면 r을 바꾼다.
X87_REVERSED = {"fsub": "fsubr", "fsubr": "fsub", "fdiv": "fdivr", "fdivr": "fdiv",
                "fsubp": "fsubrp", "fsubrp": "fsubp", "fdivp": "fdivrp", "fdivrp": "fdivp"}
# 오퍼랜드 없는 doubleword 철자: Intel 'd' = AT&T 'l'(매뉴얼 i386-Mnemonics의 크기 글자). 'cmpsd'·'movsd'는 AT&T에서
# SSE 명령 이름과 겹친다
DWORD_NAMES = {"cmpsd": "cmpsl", "lodsd": "lodsl", "movsd": "movsl", "scasd": "scasl", "stosd": "stosl",
               "insd": "insl", "outsd": "outsl", "iretd": "iretl", "popad": "popal", "pushad": "pushal",
               "popfd": "popfl", "pushfd": "pushfl"}
FAR_SUFFIX = {"dword": "w", "fword": "l", "tbyte": "q"}   # m16:16 / m16:32 / m16:64
VECTOR_SUFFIX = {128: "x", 256: "y", 512: "z"}


class Unsupported(ValueError):
    """생성기 밖의 Intel 철자. 변환하지 않고 이유를 남긴다."""


def split_operands(text):
    return [part.strip() for part in text.split(",")] if text.strip() else []


def number(text):
    return re.fullmatch(r"-?(?:0x[0-9a-fA-F]+|\d+)", text) is not None


def register(name):
    if name in GPR_SIZES or OTHER_REGISTER.match(name):
        return "%" + name
    raise Unsupported("레지스터가 아님: " + name)


def memory(address):
    """'[rax+rbx*4+0x10]' -> '0x10(%rax,%rbx,4)'. 색인은 범용·벡터(VSIB) 레지스터."""
    inside = address[1:-1].replace(" ", "")
    terms = re.findall(r"[+-]?[^+-]+", inside)
    base = index = None
    scale, disp = 1, ""
    for term in terms:
        sign, body = ("-", term[1:]) if term.startswith("-") else ("", term.lstrip("+"))
        if "*" in body:
            index, factor = body.split("*")
            scale = int(factor)
        elif number(body):
            disp = sign + body
        elif sign:
            raise Unsupported("레지스터를 뺄 수 없음: " + address)
        elif base is None and (body in GPR_SIZES or body == "rip") and not re.fullmatch(r"[xyz]mm\d+", body):
            base = body
        elif index is None:
            index = body                                  # [rax+xmm1]: 배율 없는 VSIB 색인
        else:
            raise Unsupported("주소 항이 많음: " + address)
    if base is None and index is None:
        return disp or "0"
    inner = ("%" + base if base else "") + ("," + register(index) + "," + str(scale) if index else "")
    return disp + "(" + inner + ")"


def parse(operand):
    """Intel 오퍼랜드 하나 -> 사전(kind, text, size, decorations)."""
    decorations = re.findall(r"\{[^}]*\}", operand)
    body = re.sub(r"\s*\{[^}]*\}", "", operand).strip()
    if not body and decorations:
        return {"kind": "control", "text": decorations[0], "decor": []}
    keyword = re.match(r"(\w+) ptr\s+", body)
    if keyword:
        size = keyword.group(1).lower()
        if size not in KEYWORD_BITS:
            raise Unsupported("크기 키워드: " + size)
        body = body[keyword.end():]
    else:
        size = None
    if body.startswith("[") and body.endswith("]"):
        bcst = [d for d in decorations if d.startswith("{1to")]
        masks = [d for d in decorations if not d.startswith("{1to")]
        return {"kind": "mem", "text": memory(body), "size": size, "bcst": bcst, "decor": masks}
    if size:
        raise Unsupported("크기 키워드 뒤가 메모리가 아님: " + operand)
    far = re.fullmatch(r"(0x[0-9a-f]+|\d+):(0x[0-9a-f]+|\d+)", body)
    if far:
        return {"kind": "far", "text": "$%s,$%s" % far.groups(), "decor": []}
    if number(body):
        return {"kind": "imm", "text": "$" + body, "decor": decorations}
    if body in GPR_SIZES or OTHER_REGISTER.match(body):
        return {"kind": "reg", "name": body, "text": register(body), "decor": decorations}
    if re.fullmatch(r"[A-Za-z_.][\w.]*", body):
        return {"kind": "label", "text": body, "decor": decorations}
    raise Unsupported("오퍼랜드: " + operand)


def decorate(op):
    """마스크는 '{%k1}', 영(z)·브로드캐스트·반올림은 그대로."""
    out = op["text"] + "".join(op.get("bcst", []))
    for d in op["decor"]:
        out += "{%" + d[1:-1] + "}" if re.fullmatch(r"\{k\d\}", d) else d
    return out


def register_family(name):
    if name in GPR_SIZES:
        return "r%d" % GPR_SIZES[name]
    for pattern, family in ((r"[xyz]mm\d+", None), (r"k\d", "k"), (r"mm\d", "mm"), (r"st(\(\d\))?", "st"),
                            (r"[c-gs]s", "sreg"), (r"cr\d+", "cr"), (r"dr\d", "dr"), (r"bnd\d", "bnd"), (r"tmm\d", "tmm")):
        if re.fullmatch(pattern, name):
            return family or name[:3]
    return name


def operand_key(mnemonic, ops):
    """크기 글자가 필요한지 볼 열쇠: 니모닉 + 오퍼랜드 종류(레지스터는 계열, 메모리 M, 즉시값 I, 라벨 L)."""
    kinds = []
    for op in ops:
        if op["kind"] == "reg":
            kinds.append(register_family(op["name"]))
        elif op["kind"] != "control":
            kinds.append({"mem": "M", "imm": "I", "label": "L", "far": "F"}[op["kind"]])
    return mnemonic, tuple(kinds)


def memory_bits(op):
    """메모리 오퍼랜드 폭. 브로드캐스트는 원소 폭 x 원소 수. 키워드가 없으면 None."""
    if not op["size"]:
        return None
    bits = KEYWORD_BITS[op["size"]]
    if op.get("bcst"):
        bits *= int(re.search(r"to(\d+)", op["bcst"][0]).group(1))
    return bits


def ambiguous_keys(sources):
    """같은 열쇠(operand_key)인데 메모리 폭이 둘 이상인 것 = AT&T에서 니모닉 글자로 폭을 정해야 하는 것.
    매뉴얼: 레지스터 오퍼랜드로 크기를 정할 수 있으면 글자가 없어도 된다(그 밖에는 글자로 정한다).
    생성기의 Intel 소스 전체(SDM 표 행 전부)에서 센다."""
    widths = {}
    for source in sources:
        try:
            mnemonic, ops = split_source(source)[1:]
        except Unsupported:
            continue
        for op in ops:
            if op["kind"] == "mem" and memory_bits(op):
                widths.setdefault(operand_key(mnemonic, ops), set()).add(memory_bits(op))
    return {key for key, found in widths.items() if len(found) > 1}


def suffix(mnemonic, ops, ambiguous):
    """니모닉 끝 글자. 메모리 폭이 레지스터로 정해지지 않는 열쇠(ambiguous_keys)에만 붙인다."""
    memories = [o for o in ops if o["kind"] == "mem" and memory_bits(o)]
    if not memories or operand_key(mnemonic, ops) not in ambiguous:
        return ""
    if memories[0].get("bcst"):
        return ""      # '{1toN}'이 원소 폭과 개수를 정한다(clang은 글자와 같이 쓰면 거부, 2026-11-11 관측)
    bits = KEYWORD_BITS[memories[0]["size"]]
    if mnemonic in X87_INTEGER:
        return X87_INTEGER_SUFFIX.get(bits, "")
    if mnemonic in X87_REAL:
        return X87_REAL_SUFFIX.get(bits, "")
    if INT_TO_FLOAT.match(mnemonic):
        return GPR_SUFFIX.get(bits, "")
    simd = memories[0].get("bcst") or bits >= 128 or any(
        o["kind"] == "reg" and register_family(o["name"]) in ("xmm", "ymm", "zmm", "k", "mm") for o in ops)
    if simd:
        return VECTOR_SUFFIX.get(memory_bits(memories[0]), "")
    return GPR_SUFFIX.get(bits, "")


def split_source(source):
    """(접두어 목록, 니모닉, 오퍼랜드 사전 목록)."""
    words = source.split()
    prefixes = []
    while words and words[0] in PREFIX_WORDS:
        prefixes.append(words.pop(0))
    if not words:
        return prefixes, "", []
    pieces = source.split(None, len(prefixes) + 1)
    return prefixes, words[0].lower(), [parse(o) for o in split_operands(pieces[-1] if len(pieces) > len(prefixes) + 1
                                                                        else "")]


def convert(source, ambiguous=frozenset()):
    """Intel 한 줄 -> AT&T 한 줄. ambiguous: ambiguous_keys(생성 소스 전체). 모르는 철자는 Unsupported."""
    prefixes, mnemonic, ops = split_source(source)
    if not mnemonic:
        if prefixes:
            return " ".join(prefixes)                     # 접두어만 있는 행(LOCK 등)
        raise Unsupported("니모닉 없음")
    if any(o["kind"] == "far" for o in ops):
        name = {"call": "lcall", "jmp": "ljmp"}.get(mnemonic)
        if not name:
            raise Unsupported("먼 포인터 즉시값: " + source)
        return " ".join(prefixes + [name, ops[0]["text"]])
    if mnemonic in ("call", "jmp") and ops and ops[0]["kind"] in ("reg", "mem"):
        op = ops[0]
        if op["kind"] == "mem" and op["size"] in FAR_SUFFIX:
            return " ".join(prefixes + ["l" + mnemonic + FAR_SUFFIX[op["size"]], "*" + op["text"]])
        letter = "w" if (op["kind"] == "mem" and op["size"] == "word") else ""
        return " ".join(prefixes + [mnemonic + letter, "*" + op["text"]])
    if mnemonic == "retf":
        return " ".join(prefixes + ["lret"] + ([", ".join(o["text"] for o in ops)] if ops else []))
    if mnemonic in ("movsx", "movzx") and len(ops) == 2:
        source_bits = KEYWORD_BITS[ops[1]["size"]] if ops[1]["kind"] == "mem" else GPR_SIZES.get(ops[1].get("name"))
        target_bits = GPR_SIZES.get(ops[0].get("name"))
        if source_bits not in GPR_SUFFIX or target_bits not in GPR_SUFFIX:
            raise Unsupported("movsx/movzx 크기: " + source)
        mnemonic = mnemonic[:4] + GPR_SUFFIX[source_bits] + GPR_SUFFIX[target_bits]
        letter = ""
    elif mnemonic == "movsxd" and ops and GPR_SIZES.get(ops[0].get("name")) == 64:
        mnemonic, letter = "movslq", ""
    else:
        letter = suffix(mnemonic, ops, ambiguous)
    if mnemonic in ("in", "out", "ins", "outs"):
        for op in ops:
            if op.get("name") == "dx":
                op["text"] = "(%dx)"
    if not ops and mnemonic in DWORD_NAMES:
        return " ".join(prefixes + [DWORD_NAMES[mnemonic]])
    if not ops and mnemonic in X87_REVERSED and mnemonic.endswith("p"):
        mnemonic = X87_REVERSED[mnemonic]     # 오퍼랜드 없는 fsubp = 'fsubp %st, %st(1)'(같은 매뉴얼 항목)
    if (mnemonic in X87_REVERSED and len(ops) == 2 and ops[1].get("name") in ("st", "st(0)")
            and re.fullmatch(r"st\([1-7]\)", ops[0].get("name", ""))):
        mnemonic = X87_REVERSED[mnemonic]
    immediates = sum(o["kind"] == "imm" for o in ops)
    ordered = ops if (mnemonic in NOT_REVERSED or immediates >= 2) else list(reversed(ops))
    text = ", ".join(decorate(o) for o in ordered)
    return " ".join(prefixes + [mnemonic + letter] + ([text] if text else []))

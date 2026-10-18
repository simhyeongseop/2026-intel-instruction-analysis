"""총론 기호 정의(sdm_symbols.csv) 원문에서 오퍼랜드 명세를 기계적으로 읽는다.

판단 규칙은 '원문 문장에 어떤 단어가 있는가'뿐이다. 어느 문구로 정했는지(matched_phrase)를 함께 돌려준다.
명령 절 원문(Description 등)은 보지 않는다. 그 대조는 Sol 추출이 맡는다.
"""

import csv
import re

SYMBOLS_CSV = "data/rules/sdm_symbols.csv"

# 원문 문구 -> 종류. 위에서부터 처음 맞는 것을 쓴다.
KIND_PHRASES = [
    ("VSIB memory addressing", "vector_memory"),
    ("far pointer", "far_pointer"),
    ("relative address", "relative"),
    ("register or memory operand", "register_or_memory"),
    ("register or a ", "register_or_memory"),
    ("either the contents of a", "register_or_memory"),
    ("ZMM register, a 512-bit memory location", "register_or_memory"),
    ("immediate", "immediate"),
    ("mask register", "mask"),
    ("operand in memory", "memory"),
    ("memory operand", "memory"),
    ("in memory", "memory"),
    ("memory variable", "memory"),
    ("register", "register"),
]

# 2026-10-10 수정 규칙(사용자 결정 5): SYM065 "A YMM register or 256-bit memory operand",
# SYM070 "A ZMM register or 512-bit memory operand"가 위 목록의 "register or memory operand"·"register or a "에
# 걸리지 않고 "memory operand"로 떨어지던 결함을 고친다. 원래 목록(KIND_PHRASES)은 2026-10-09 독립 판정
# main_symbol_spec.csv의 재현을 위해 그대로 둔다.
KIND_PHRASES_FIXED = [
    ("register or 256-bit memory operand", "register_or_memory"),
    ("register or 512-bit memory operand", "register_or_memory"),
] + KIND_PHRASES

# 원문의 크기 표현 -> 비트. 문장에서 가장 먼저 나오는 것을 쓴다. 'mode' 앞의 크기(64-bit mode)는 데이터 폭이 아니다.
WIDTH_WORDS = {"double quadword": "128", "quadword": "64", "doubleword": "32", "word": "16", "byte": "8"}
WIDTH_RE = re.compile(r"\b(double quadword|quadword|doubleword|word|byte|\d+-bit|\d+-byte|\d+ bits)\b(?! mode)")
MULTI_WIDTH_RE = re.compile(r"\b(\d+)-, (\d+)- or (\d+)-bit\b")
# 이름에 적힌 숫자가 크기라고 원문이 직접 말하는 묶음 정의.
NAME_SIZE_SENTENCES = [
    "sizes are indicated on the left and the right side of the ampersand",
    "The number shown with moffs indicates its size",
    "composed of two numbers",
    "(respectively)",
    "symbol applies to instructions with an operand-size attribute",
    "symbol is used when the instruction's operand-size attribute",
]

FOOTNOTE = re.compile(r"\^\d+")
DECORATION = re.compile(r"\s*\{[^}]*\}")


def load_symbols(path=SYMBOLS_CSV):
    """기호 이름 -> 정의 행. 'r16, r32'처럼 묶인 이름은 하나씩 풀어 같은 정의를 가리키게 한다."""
    with open(path, encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle))
    by_name = {}
    for row in rows:
        if row["symbol"].startswith("(") or " " in row["symbol"].replace(", ", ",").replace(" & ", "&").replace(" or ", ","):
            # 본문·표·표기 형식 항목과 문장형 이름은 기호가 아니다.
            if not re.match(r"^[\w/:&(),+<>{}\-. ]+$", row["symbol"]):
                continue
        vsib = re.match(r"^(vm32|vm64)\{x,\s*y,\s*z\}$", row["symbol"])
        if vsib:
            names = [vsib.group(1) + suffix for suffix in "xyz"]
        else:
            names = re.split(r",\s*|\s+or\s+|\s*&\s*(?=m\d)", row["symbol"])
        for name in names:
            name = name.strip()
            if name:
                by_name.setdefault(name, row)
    return by_name


def clean_symbol(table_symbol):
    """표 원문 기호에서 각주(^n)와 장식({k1}{z}, {er})을 뗀다. 번호(xmm1)는 그대로 둔다."""
    return DECORATION.sub("", FOOTNOTE.sub("", table_symbol or "")).strip()


def lookup(by_name, symbol):
    """정의를 찾는 순서: 그대로 -> 번호 뗀 이름(xmm1 -> xmm, k2 -> k1 정의) . 찾은 방법도 돌려준다."""
    if symbol in by_name:
        return by_name[symbol], "exact"
    plain = re.sub(r"^(xmm|ymm|zmm|mm|bnd|tmm)\d+", r"\1", symbol)
    plain = re.sub(r"/(xmm|ymm|zmm|mm)\d+", r"/\1", plain)
    if plain in by_name:
        return by_name[plain], "number_removed"
    if re.match(r"^k\d$", symbol) and "k1" in by_name:
        return by_name["k1"], "number_removed"
    return None, "no_definition"


def first_phrase(text, table):
    lower = text.lower()
    for phrase, value in table:
        if phrase.lower() in lower:
            return value, phrase
    return "", ""


def width_from_text(symbol, text):
    """데이터 폭과 근거 문구. 이름 숫자가 크기라는 문장이 있으면 이름에서 읽는다."""
    for sentence in NAME_SIZE_SENTENCES:
        if sentence in text:
            return "&".join(re.findall(r"\d+", symbol)) if "&" in symbol or ":" in symbol else \
                "".join(re.findall(r"\d+", symbol)), sentence
    multi = MULTI_WIDTH_RE.search(text)
    if multi:
        return "|".join(multi.groups()), multi.group(0)
    found = WIDTH_RE.search(text)
    if not found:
        return "", ""
    words = found.group(1)
    if words in WIDTH_WORDS:
        return WIDTH_WORDS[words], words
    number = int(re.match(r"\d+", words).group(0))
    return (str(number * 8) if "byte" in words else str(number)), words


def register_list(text):
    """'registers are: AL, CL, ...' 또는 ': AL, CL, ...; or ...' 뒤의 나열을 원문 그대로 꺼낸다."""
    matched = re.search(r"registers?(?: are)?:\s*([^.]*)", text)
    if matched:
        return matched.group(1).strip()
    matched = re.search(r"\(([A-Z]{2,3}(?:, [A-Z0-9]{2,4}){3,}[^)]*)\)", text)
    return matched.group(1).strip() if matched else ""


def spec_for_symbol(by_name, table_symbol, kind_phrases=KIND_PHRASES):
    symbol = clean_symbol(table_symbol)
    if not symbol:
        return {"symbol": symbol, "status": "none", "kind": "none"}
    row, how = lookup(by_name, symbol)
    if row is None:
        return {"symbol": symbol, "status": "no_definition", "lookup": how}
    text = row["source_text"]
    kind, kind_phrase = first_phrase(text, kind_phrases)
    width, width_phrase = width_from_text(symbol, text)
    return {
        "symbol": symbol,
        "status": "defined",
        "lookup": how,
        "symbol_id": row["symbol_id"],
        "kind": kind,
        "kind_phrase": kind_phrase,
        "data_width": width,
        "width_phrase": width_phrase,
        "register_set": register_list(text),
    }

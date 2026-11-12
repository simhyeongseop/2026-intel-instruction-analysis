"""5단계 세 비교(as0–as2, b0–b1, as1–as2)에서 '다름'·'미대조'인 케이스를 원인별로 분류한다.

    python3 scripts/classify_roundtrip_diffs.py [--dir out/round2_20261111/roundtrip_chain]

입력: <dir>/roundtrip_results.csv (m5_roundtrip.py 결과). 도구를 다시 실행하지 않는다.
출력: <dir>/diff_cases.csv (케이스 × 경로 × 비교 한 줄, 분류), <dir>/diff_summary.json, <dir>/manifest_diff.json

as0–as2 '다름' 분류: 아래 표기 규칙(NORMALIZERS)을 모두 적용하면 두 문자열이 같아지는지 본 뒤,
규칙을 하나씩 빼 보며 꼭 필요한 규칙만 남긴다(최소 집합). 남은 규칙 이름을 '+'로 이어 분류로 쓴다.
모든 규칙을 써도 다르면 '기타(표기 규칙으로 설명 안 됨)'. 이 분류는 표기 차이 설명이며 의미 판정이 아니다.

b0–b1·as1–as2 '다름'과 '미대조'는 수가 적어 m5 판정 열과 명령 종류로 분류한다(KNOWN 표).
"""

import argparse
import collections
import csv
import json
import os
import re
import sys
from datetime import datetime, timezone

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline.instruction_check import sha256  # noqa: E402
from pipeline.m5_roundtrip import text_key  # noqa: E402

csv.field_size_limit(10 ** 9)

# ---------- 문자열 하나에 적용하는 표기 규칙 ----------

NUMBER = re.compile(r"(?<![\w.%])(-?)(0x[0-9a-f]+|\d+)(?![\w.])")


def decimal(text):
    """숫자 진법: 0x12 -> 18 (부호 유지)."""
    def to_int(match):
        token = match.group(2)
        return match.group(1) + str(int(token, 16) if token.startswith("0x") else int(token))
    return NUMBER.sub(to_int, text)


def zero_disp(text):
    """생략 변위: Intel [r13+0x0] -> [r13], AT&T 0x0(%rbp) -> (%rbp). 진법과 무관하게 0만 지운다."""
    text = re.sub(r"\+(?:0x)?0+\]", "]", text)
    return re.sub(r"(?<![\w$])(?:0x)?0+\(", "(", text)


def scale(text):
    """주소 스케일 표기: [rax+8*rbx] -> [rax+rbx*8], *1 생략, AT&T (,%rbx,1) -> (,%rbx)."""
    text = re.sub(r"(?<=[\[+])(\d)\*([a-z0-9]+)", r"\2*\1", text)
    text = re.sub(r"\*1(?=[\]+\-])", "", text)
    return re.sub(r",1\)", ")", text)


SIZE_WORDS = r"(?:byte|word|dword|qword|tbyte|fword|xmmword|ymmword|zmmword|oword|mmword)"


def mem_size(text):
    """메모리 크기·브로드캐스트·세그먼트 표기: 'dword ptr', 'word bcst', '{1to8}' 제거, 'ds:16' -> '[16]'."""
    text = re.sub(SIZE_WORDS + r" (?:ptr|bcst) ?", "", text)
    text = re.sub(r"\{1to\d+\}", "", text)
    text = re.sub(r"(?<![a-z\[])ds:((?:0x)?[0-9a-f]+)(?![\w\]])", r"[\1]", text)
    return re.sub(r"(?<![a-z])ds:", "", text)


def wrap64(text):
    """64비트로 감긴 변위: [rip+18446744073709551488] -> [rip-128] (decimal 뒤, 2**63 이상만)."""
    def back(match):
        value = int(match.group(1))
        return "-%d" % ((1 << 64) - value) if value >= 1 << 63 else match.group(0)
    return re.sub(r"\+(\d{19,20})(?=\])", back, text)


def rounding(text):
    """반올림·SAE 위치: 'zmm2,{ru-sae}' -> 'zmm2{ru-sae}', AT&T '{rn-sae},' 앞뒤 쉼표."""
    text = re.sub(r",(\{(?:r[nduz]-)?sae\})", r"\1", text)
    return re.sub(r"(\{(?:r[nduz]-)?sae\}),", r"\1", text)


# 조건 코드 별칭(SDM Jcc/SETcc/CMOVcc 표의 같은 opcode 이름) -> 대표 이름
CONDITION = {"nae": "b", "c": "b", "nb": "ae", "nc": "ae", "e": "z", "ne": "nz", "na": "be", "nbe": "a",
             "nge": "l", "nl": "ge", "ng": "le", "nle": "g", "pe": "p", "po": "np"}
CC_PREFIX = re.compile(r"^((?:[a-z]+ )*?)(j|set|cmov|cmp)([a-z]+?)([bwlq]?|xadd)( |$)")


def condition_alias(text):
    """조건 코드 별칭: cmovnl -> cmovge, jnb -> jae, sete -> setz 등을 한 이름으로."""
    match = CC_PREFIX.match(text)
    if not match:
        return text
    cc = match.group(3)
    if match.group(2) == "cmp" and match.group(4) != "xadd":     # CMPccXADD만
        return text
    if cc not in CONDITION and cc + match.group(4) in CONDITION:     # 'jnb'의 b는 크기 글자가 아니다
        cc, suffix = cc + match.group(4), ""
    else:
        suffix = match.group(4)
    if cc not in CONDITION and cc not in CONDITION.values():
        return text
    return match.group(1) + match.group(2) + CONDITION.get(cc, cc) + suffix + match.group(5) + text[match.end():]


def port_paren(text):
    """AT&T 포트 표기: (%dx) -> %dx."""
    return text.replace("(%dx)", "%dx")


MNEMONIC_ALIAS = {"sal": "shl", "movabs": "mov", "ljmpl": "ljmp", "lcalll": "lcall", "fwait": "wait",
                  "repnz": "repne", "repz": "repe", "fcompi": "fcomip", "fucompi": "fucomip"}


def mnemonic_alias(text):
    """같은 opcode의 다른 이름(SDM 표·도구 관례): sal=shl(D0 /4), movabs=mov(64비트 즉시값·절대 주소)."""
    head, sep, rest = text.partition(" ")
    for short in ("sal", "movabs"):
        if head.startswith(short) and len(head) <= len(short) + 1:
            return MNEMONIC_ALIAS[short] + head[len(short):] + sep + rest
    return MNEMONIC_ALIAS.get(head, head) + sep + rest


def encoding_hint(text):
    """도구가 출력에 붙인 인코딩 표시: '{evex} ', 'rex.w ' 같은 접두 표기 제거."""
    return re.sub(r"^(?:\{(?:evex|vex|vex2|vex3)\} ?|rex\.?w? )", "", text)


GPR = {}
for names in (("rax", "eax", "ax", "al"), ("rcx", "ecx", "cx", "cl"), ("rdx", "edx", "dx", "dl"),
              ("rbx", "ebx", "bx", "bl"), ("rsp", "esp", "sp", "spl"), ("rbp", "ebp", "bp", "bpl"),
              ("rsi", "esi", "si", "sil"), ("rdi", "edi", "di", "dil")):
    for name in names[:3]:
        GPR[name] = names[0]
for number in range(8, 16):
    for suffix in ("", "d", "w"):
        GPR["r%d%s" % (number, suffix)] = "r%d" % number


def gpr_width(text):
    """GPR 폭 표기: 같은 번호 레지스터의 r64·r32·r16 이름을 하나로(lsl rcx -> ecx 같은 표기 차이)."""
    return re.sub(r"(?<![\w])%?(" + "|".join(sorted(GPR, key=len, reverse=True)) + r")(?![\w])",
                  lambda m: m.group(0).replace(m.group(1), GPR[m.group(1)]), text)


def x87_st0(text):
    """x87 레지스터 표기: st(0) -> st."""
    return re.sub(r"st\(0\)", "st", text)


NORMALIZERS = {
    "숫자 진법": decimal,
    "생략 변위 0": zero_disp,
    "주소 스케일 표기": scale,
    "메모리 크기·브로드캐스트 표기": mem_size,
    "반올림·SAE 위치": rounding,
    "조건 코드 별칭": condition_alias,
    "AT&T 포트 괄호": port_paren,
    "니모닉 별칭(sal·movabs 등)": mnemonic_alias,
    "x87 st(0) 표기": x87_st0,
    "숫자 폭 감기(부호·2의 보수)": wrap64,
    "인코딩 표시({evex}·rex.w)": encoding_hint,
    "GPR 폭 표기(r64·r32·r16)": gpr_width,
}
ORDER = ("숫자 진법", "숫자 폭 감기(부호·2의 보수)", "생략 변위 0", "주소 스케일 표기",
         "메모리 크기·브로드캐스트 표기", "반올림·SAE 위치", "조건 코드 별칭", "AT&T 포트 괄호",
         "니모닉 별칭(sal·movabs 등)", "x87 st(0) 표기", "인코딩 표시({evex}·rex.w)", "GPR 폭 표기(r64·r32·r16)")

# ---------- 두 문자열을 함께 보는 규칙 ----------

PAIR_RULES = ("AT&T 크기 글자", "암묵·생략 오퍼랜드", "비교 술어 의사 명령", "소스 두 오퍼랜드 순서 바뀜",
              "XCHG 오퍼랜드 순서",
              "FWAIT 분리(fstsw -> wait|fnstsw)")


def split_insn(text):
    """'rep movsb a,b' -> (니모닉 부분 'rep movsb', [오퍼랜드...]). 괄호·대괄호 안 쉼표는 나누지 않는다."""
    head, _, rest = text.partition(" ")
    while rest and re.match(r"^(?:rep|repe|repz|repne|repnz|lock|notrack|bnd|data16|addr32|rex[.\w]*)\b", head) \
            and " " in rest:
        more, _, rest = rest.partition(" ")
        head += " " + more
    if head in ("rep", "repe", "repz", "repne", "repnz", "lock") and rest and " " not in rest:
        head, rest = head + " " + rest, ""
    operands, depth, current = [], 0, ""
    for char in rest:
        if char in "([{":
            depth += 1
        elif char in ")]}":
            depth -= 1
        if char == "," and depth == 0:
            operands.append(current)
            current = ""
        else:
            current += char
    if current:
        operands.append(current)
    return head, operands


WRAP_NUMBER = re.compile(r"(?<![\w%])(?:\$)?-?\d+(?![\w(])")


def numbers_wrap_equal(a, b):
    """숫자만 다르고, 각 숫자 쌍이 8·16·32·64비트 중 한 폭에서 같은 값(2의 보수)이면 참.
    대상은 즉시값처럼 홀로 선 숫자(레지스터 번호, 변위 'N(' 제외)."""
    if WRAP_NUMBER.sub("#", a) != WRAP_NUMBER.sub("#", b):
        return False
    pairs = [(int(x.lstrip("$")), int(y.lstrip("$"))) for x, y in zip(WRAP_NUMBER.findall(a), WRAP_NUMBER.findall(b))]
    return any(x != y for x, y in pairs) and all(
        any((x - y) % (1 << w) == 0 for w in (8, 16, 32, 64)) for x, y in pairs)


def implicit_equal(a, b):
    """한쪽 오퍼랜드가 다른 쪽 앞 또는 뒤에 오퍼랜드를 더한 것뿐이면 참(fmulp -> fmulp st(1),st, shl $1 생략 등)."""
    (ha, oa), (hb, ob) = split_insn(a), split_insn(b)
    if ha != hb or oa == ob:
        return False
    short, long_ = (oa, ob) if len(oa) < len(ob) else (ob, oa)
    extra = len(long_) - len(short)
    return extra > 0 and (long_[extra:] == short or long_[:len(short)] == short)


PREDICATE_HEAD = re.compile(r"^(v?p?cmp)")


def predicate_equal(a, b):
    """비교 술어 의사 명령: 'vcmpps 18,x,y,z' <-> 'vcmple_oqps x,y,z', 'vpcmpb k0,x,y,0' <-> 'vpcmpeqb k0,x,y'."""
    (ha, oa), (hb, ob) = split_insn(a), split_insn(b)
    if ha == hb or not PREDICATE_HEAD.match(ha) or not PREDICATE_HEAD.match(hb):
        return False
    if PREDICATE_HEAD.match(ha).group(1) != PREDICATE_HEAD.match(hb).group(1):
        return False
    for (h1, o1), (h2, o2) in (((ha, oa), (hb, ob)), ((hb, ob), (ha, oa))):
        if len(o1) == len(o2) + 1 and re.fullmatch(r"\$?-?\d+", o1[0]) and o1[1:] == o2:
            return True                        # AT&T: 술어가 첫 오퍼랜드
        if len(o1) == len(o2) + 1 and re.fullmatch(r"-?\d+", o1[-1]) and o1[:-1] == o2:
            return True                        # Intel: 술어가 마지막 오퍼랜드
    return False


def att_suffix_pair(a, b):
    """AT&T 크기 글자만 다르면 긴 쪽 니모닉에서 글자를 뗀다."""
    (ha, oa), (hb, ob) = split_insn(a), split_insn(b)
    if ha != hb and hb[:-1] == ha and hb[-1] in "bwlqst":
        return a, join_insn(ha, ob)
    if ha != hb and ha[:-1] == hb and ha[-1] in "bwlqst":
        return join_insn(hb, oa), b
    return a, b


def swap_equal(a, b):
    """같은 니모닉, 첫 오퍼랜드 같고 뒤 두 오퍼랜드만 서로 바뀜. 교환 가능한 연산인지는 보지 않는다
    (LLVM이 VEX2 인코딩을 위해 교환 가능 연산의 오퍼랜드를 바꾸는 경우; 교환 불가 명령이면 따로 검토)."""
    (ha, oa), (hb, ob) = split_insn(a), split_insn(b)
    if ha != hb or len(oa) != 3 or len(ob) != 3:
        return False
    return (oa[0] == ob[0] and oa[1:] == ob[2:0:-1]) or (oa[2] == ob[2] and oa[:2] == ob[1::-1])   # Intel, AT&T


def xchg_equal(a, b):
    """XCHG 두 오퍼랜드 순서만 바뀜(교환 연산, 같은 opcode)."""
    (ha, oa), (hb, ob) = split_insn(a), split_insn(b)
    return ha == hb and ha.startswith("xchg") and len(oa) == 2 and oa == ob[::-1]


def join_insn(head, operands):
    return head + (" " + ",".join(operands) if operands else "")


def tidy(text):
    """니모닉 뒤 공백을 하나 둔다(text_key가 '(' '[' '-' 앞 공백을 지우므로 오퍼랜드를 나누려면 필요)."""
    prefixes = r"(?:(?:rep|repe|repz|repne|repnz|lock|notrack|bnd|data16|addr32|wait) )*"
    return re.sub(r"^(" + prefixes + r"[a-z][\w.]*)(?=[\[(\-$%*{])", r"\1 ", text)


def normalize(text, rules):
    text = tidy(text_key(text))
    for name in ORDER:
        if name in rules:
            text = tidy(NORMALIZERS[name](text))
    return text


def same_line(x, y, rules):
    if x == y:
        return True
    if "AT&T 크기 글자" in rules:
        x, y = att_suffix_pair(x, y)
        if x == y:
            return True
    if "숫자 폭 감기(부호·2의 보수)" in rules and numbers_wrap_equal(x, y):
        return True
    return any(name in rules and PAIR_FUNCTIONS[name](x, y)
               for name in ("암묵·생략 오퍼랜드", "비교 술어 의사 명령", "소스 두 오퍼랜드 순서 바뀜", "XCHG 오퍼랜드 순서"))


PAIR_FUNCTIONS = {"암묵·생략 오퍼랜드": implicit_equal, "비교 술어 의사 명령": predicate_equal,
                  "소스 두 오퍼랜드 순서 바뀜": swap_equal, "XCHG 오퍼랜드 순서": xchg_equal}


def equal_with(a, b, rules):
    """규칙 집합으로 두 명령(여러 줄은 ' | '로 이어짐)이 같다고 볼 수 있는가. 줄마다 따로 본다."""
    parts_a, parts_b = a.split(" | "), b.split(" | ")
    fwait = "FWAIT 분리(fstsw -> wait|fnstsw)" in rules
    if fwait and len(parts_b) == len(parts_a) + 1 and parts_b[0].strip() in ("wait", "fwait"):
        parts_b = parts_b[1:]
        parts_b[0] = re.sub(r"^fn", "f", parts_b[0])
    if fwait and len(parts_a) == len(parts_b) + 1 and parts_a[0].strip() in ("wait", "fwait"):
        parts_a = parts_a[1:]
        parts_a[0] = re.sub(r"^fn", "f", parts_a[0])
    if len(parts_a) != len(parts_b):
        return False
    return all(same_line(normalize(x, rules), normalize(y, rules), rules) for x, y in zip(parts_a, parts_b))


ALL_RULES = ORDER + PAIR_RULES
OTHER = "기타(표기 규칙으로 설명 안 됨)"


def classify_text(as0, as2):
    """as0–as2 '다름'의 최소 규칙 집합 이름."""
    rules = set(ALL_RULES)
    if not equal_with(as0, as2, rules):
        return OTHER
    for name in ALL_RULES:                       # 하나씩 빼도 같으면 그 규칙은 필요 없다
        if equal_with(as0, as2, rules - {name}):
            rules.discard(name)
    return "+".join(name for name in ALL_RULES if name in rules)


# ---------- b0–b1, as1–as2, 미대조 ----------

KNOWN = [
    # (조건, 분류) — 위에서부터 첫 일치
    (lambda r, s: r["verdict_" + s] == "분기 대상 미대조",
     "미대조: 같은 파일 라벨(.Ltarget) 상대 분기 — 역어셈블 출력이 절대 주소라 다시 조립해 비교할 수 없음"),
    (lambda r, s: r["verdict_" + s] == "역어셈블 실패", "미대조: 역어셈블 실패"),
    (lambda r, s: r["verdict_" + s] == "재조립 거부" and r["instruction"].split()[0] in ("LSS", "LFS", "LGS"),
     "미대조(재조립 거부): GNU objdump가 L*S r64, m16:64를 'FWORD PTR'로 출력 → GNU as가 r64와 함께 거부"),
    (lambda r, s: r["verdict_" + s] == "재조립 거부" and r[s].startswith("rex."),
     "미대조(재조립 거부): GNU objdump가 먼 간접 CALL/JMP m16:64를 'rex.W? call/jmp FWORD PTR'로 출력"
     " → GNU as 'same type of prefix used twice'"),
    (lambda r, s: r["verdict_" + s] == "재조립 거부", "미대조(재조립 거부): 기타"),
    (lambda r, s: r["verdict_" + s] == "재배치 생김", "미대조: 다시 조립에서 재배치 생김"),
    (lambda r, s: r["instruction"].split()[0] in ("CALL", "JMP") and r["cmp_as1_as2_" + s] == "다름",
     "LLVM 메모리 간접 CALL/JMP: 크기 표기(word·dword·fword·tbyte) 소스를 먼 간접(FF /3·/5)으로 조립,"
     " as1은 크기 없는 'call/jmp [mem]' → 다시 조립하면 가까운 간접(FF /2·/4)"),
    (lambda r, s: r["instruction"].split()[0] in ("PUSHF", "POPF") and r["cmp_as1_as2_" + s] == "다름",
     "PUSHF/POPF 16비트: LLVM Intel이 66 9C/9D를 폭 없는 'pushf/popf'로 출력 → 다시 조립하면 64비트(9C/9D)"),
    (lambda r, s: r["instruction"].startswith("MOV Sreg") and r["cmp_as1_as2_" + s] == "다름",
     "MOV Sreg, r16: as1 'movw %cx,%es'(66) → 다시 조립하면 접두어 없는 형식, as2 'movl'"),
    (lambda r, s: r["instruction"].split()[0].startswith("VPCMP") and r["cmp_b0_b1_" + s] == "다름",
     "VPCMP 술어 0(EQ): 역어셈블이 VPCMPEQ*로 출력 → 다시 조립하면 VPCMPEQ* 전용 인코딩(명령 같음)"),
]


def known(row, syntax):
    for test, name in KNOWN:
        if test(row, syntax):
            return name
    return "기타(검토 필요)"


LLVM_FAR_TEXT = ("LLVM 메모리 간접 CALL/JMP: 크기 표기 소스가 먼 간접(FF /3·/5)으로 조립되어"
                 " AT&T as2가 lcall/ljmp (b0–b1·as1–as2 표의 같은 문제)")

COMPARISONS = (("as0–as2", "cmp_as0_as2"), ("b0–b1", "cmp_b0_b1"), ("as1–as2", "cmp_as1_as2"))

# as0–as2 '다름'의 의미 확인(2026-11-11 사용자 요청). 표기 규칙과 따로, 바이트로 본다.
SAME_BYTES = "같은 바이트(동작 같음)"
ATT_REJECTED = "AT&T 소스 거부(의미 대조 불가)"
ATT_OTHER_BYTES = "AT&T 소스는 다른 바이트(의미 차이 가능, 사례 확인)"
ROUND_DIFF = "왕복 바이트 다름(b0–b1 표에서 사례 확인)"
UNKNOWN = "판단 불가"


def meaning(row, syntax):
    """as0와 as2가 같은 도구에서 같은 바이트를 뜻하는가.
    as1 -> b1 == b0이고 as2 == as1이면 as2도 b0로 조립된다. Intel 경로의 as0는 b0를 만든 소스다.
    AT&T 경로의 as0(source_att)는 같은 도구로 따로 조립한 결과(syntax_check)가 b0와 같아야 한다."""
    b0_b1, as1_as2 = row["cmp_b0_b1_" + syntax], row["cmp_as1_as2_" + syntax]
    if b0_b1 == "다름":
        return ROUND_DIFF
    if b0_b1 != "같음" or as1_as2 != "같음":
        return UNKNOWN
    if syntax == "intel":
        return SAME_BYTES
    check = row.get("syntax_check", "")
    if check == "같은 바이트":
        return SAME_BYTES
    if check in ("AT&T만 거부", "둘 다 거부"):
        return ATT_REJECTED
    if check == "바이트 다름":
        return ATT_OTHER_BYTES
    return UNKNOWN


def classify_rows(rows):
    out = []
    for row in rows:
        for syntax in ("att", "intel"):
            for name, key in COMPARISONS:
                status = row["%s_%s" % (key, syntax)]
                if status not in ("다름", "미대조"):
                    continue
                if status == "다름" and name == "as0–as2":
                    reason = classify_text(row["as0_" + syntax], row["as2_" + syntax])
                    if reason == OTHER and row["family"] == "llvm" and re.match(r"l(?:call|jmp)", row["as2_" + syntax]) \
                            and not re.match(r"l(?:call|jmp)", row["as0_" + syntax]):
                        reason = LLVM_FAR_TEXT
                else:
                    reason = known(row, syntax)
                out.append({"case_id": row["case_id"], "family": row["family"], "path": syntax,
                            "comparison": name, "status": status, "class": reason,
                            "meaning": meaning(row, syntax) if status == "다름" and name == "as0–as2" else "",
                            "sdm_verdict": row["sdm_verdict"], "syntax_check": row.get("syntax_check", ""),
                            "instruction": row["instruction"], "as0": row["as0_" + syntax],
                            "as1": row["as1_" + syntax], "as2": row["as2_" + syntax],
                            "b0": row["b0"], "b1": row["b1_" + syntax], "verdict": row["verdict_" + syntax]})
    return out


def summarize(items):
    summary = {}
    for item in items:
        key = "%s/%s" % (item["family"], item["path"])
        bucket = summary.setdefault(key, {}).setdefault(item["comparison"], {}).setdefault(item["status"], {})
        bucket[item["class"]] = bucket.get(item["class"], 0) + 1
    for paths in summary.values():
        for comparisons in paths.values():
            for status, counts in comparisons.items():
                comparisons[status] = dict(sorted(counts.items(), key=lambda kv: -kv[1]))
    for item in items:   # as0–as2 '다름'의 의미 확인 집계
        if item["meaning"]:
            key = "%s/%s" % (item["family"], item["path"])
            bucket = summary[key].setdefault("as0–as2 의미", {})
            bucket[item["meaning"]] = bucket.get(item["meaning"], 0) + 1
    return summary


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--dir", default=os.path.join(ROOT, "out/round2_20261111/roundtrip_chain"))
    args = parser.parse_args()
    source = os.path.join(args.dir, "roundtrip_results.csv")
    with open(source, encoding="utf-8", newline="") as handle:
        rows = list(csv.DictReader(handle))
    items = classify_rows(rows)
    with open(os.path.join(args.dir, "diff_cases.csv"), "w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(items[0].keys()))
        writer.writeheader()
        writer.writerows(items)
    summary = summarize(items)
    with open(os.path.join(args.dir, "diff_summary.json"), "w", encoding="utf-8") as handle:
        json.dump(summary, handle, ensure_ascii=False, indent=1)
    manifest = {"finished_utc": datetime.now(timezone.utc).isoformat(), "command": sys.argv,
                "input": {source: sha256(source)},
                "code": {p: sha256(os.path.join(ROOT, p)) for p in
                         ("scripts/classify_roundtrip_diffs.py", "pipeline/m5_roundtrip.py")}}
    with open(os.path.join(args.dir, "manifest_diff.json"), "w", encoding="utf-8") as handle:
        json.dump(manifest, handle, ensure_ascii=False, indent=1)
    print(json.dumps(summary, ensure_ascii=False, indent=1))


if __name__ == "__main__":
    main()

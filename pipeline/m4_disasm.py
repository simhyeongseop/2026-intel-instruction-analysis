"""4단계 역어셈블 대조: SDM 행 바이트를 GNU objdump와 LLVM 역어셈블러로 따로 풀어 SDM과 비교한다.

    python3 pipeline/m4_disasm.py [--cases out/cases] [--workers 8]

대상: 3단계에서 SDM 일치(reach)한 케이스의 바이트(GNU 바이트 우선, 없으면 clang 바이트).
역어셈블러
- objdump: GNU objdump(경로·판은 pipeline/toolchain.py) `-D -b binary -m i386:x86-64 -M intel`. 다시 조립은 GNU as
- llvm: llvm-mc(pipeline/toolchain.py) `--disassemble --output-asm-variant=1`(llvm-objdump와 같은 MC 역어셈블러). 다시 조립은 clang
두 역어셈블러를 서로 비교하지 않는다(2026-10-11 결정). 각각을 SDM 행과 비교한다.

판정(verdict_objdump, verdict_llvm): 역어셈블러가 SDM 행의 명령을 생성 때 의도한 오퍼랜드로 이름 붙였는가
- SDM 일치: 명령 하나로 바이트를 다 풀었고, 니모닉이 SDM 니모닉이고, 오퍼랜드가 생성 소스와 같은 것을 가리킴
  (레지스터 이름, 즉시값, 메모리 크기·주소·브로드캐스트, 마스크 장식. 기본 세그먼트 표기는 보지 않는다)
- SDM 일치(분기 대상 미대조): rel 형식. 대상이 주소로 출력되므로 니모닉까지만 본다
- 디코드 실패: 명령 하나로 풀리지 않음(잘못된 인코딩, 여러 명령, 바이트 남음)
- 니모닉 다름: 같은 opcode 칸의 SDM 표 행 니모닉, SDM 의사 니모닉 표(disasm_rules), 생성 철자 어디에도 없음
- 니모닉 다름(도구 관례 철자): 그중 도구 쪽 관례 이름(movabs, lcall, fcompi …, disasm_rules.TOOL_SPELLINGS)
- SDM 일치(같은 opcode 표 행의 표기): 같은 opcode의 오퍼랜드 없는 표 행 이름으로 출력(XLAT m8 -> XLATB)
- SDM 일치(먼 포인터 크기 표기 미대조): 먼 CALL·JMP(m16:N) 바이트를 크기 표기 없이 출력함(LLVM 'call [rax]').
  SDM에는 m16:N의 어셈블리 크기 표기 문법이 없어 대조할 기준이 없다(예전 판정 '오퍼랜드 다름(먼 포인터 표시 없음)' 철회)
- SDM 일치(reg 칸 레지스터 폭 표기): 표 기호가 reg(SYM039 "r16, r32, or r64")인 칸에서 같은 번호의 다른 폭
  범용 레지스터로 출력(movmskpd rdx -> edx, 같은 바이트)
대조 규칙(disasm_rules, 근거 쪽 포함): FWAIT 짝(9B 행 = FWAIT + FN*), F2/F3 접두어 이름(2.1.1),
의사 니모닉 표, 암묵 오퍼랜드(<XMM0>, 문자열 누산기, 리터럴 1) 생략·출력, 메모리 폭은 원문 폭(m16:N 포함)과 비교
- SDM 일치(암묵 오퍼랜드 미대조): 표 행에 오퍼랜드가 없는데(OUTSB 등) 역어셈블러가 암묵 오퍼랜드를 출력함
- 오퍼랜드 다름: 오퍼랜드 수나 값이 생성 소스와 다름. 같은 opcode 칸에 순서만 뒤집힌 표 행이 있으면(XCHG) 두 순서를 다 받는다
재조립(참고, reassembled_*): 역어셈블 텍스트를 같은 계열 어셈블러로 다시 조립한 결과. 텍스트에는 {evex}나
방향(02/00) 정보가 남지 않으므로 같은 문법의 다른 인코딩이 나오는 것이 정상이다. 판정에 쓰지 않는다.
"""

import argparse
import collections
import csv
import json
import os
import re
import subprocess
import sys
import tempfile
from concurrent.futures import ThreadPoolExecutor

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline import disasm_rules as D  # noqa: E402
from pipeline import toolchain as T  # noqa: E402
from pipeline import case_rules as R  # noqa: E402
from pipeline.instruction_check import assemble  # noqa: E402

DISASSEMBLERS = {"objdump": "as", "llvm": "clang"}   # 역어셈블러 -> 다시 조립할 어셈블러
# 니모닉 앞에 오는 접두어 낱말(인코딩 접두어·의사 접두어). REP 계열은 SDM 니모닉의 일부라 따로 센다.
PREFIX_WORDS = {"data16", "data32", "addr32", "addr16", "rex", "rex64", "bnd", "notrack", "{evex}", "{vex}", "{vex3}",
                "{vex2}", "{disp8}", "{disp32}", "{load}", "{store}", "{rex}", "{rex2}", "{nf}", "cs", "ds", "es", "fs",
                "gs", "ss"}
REP_WORDS = D.PREFIX_BYTE_NAMES[1]


def read_csv(path):
    with open(path, encoding="utf-8", newline="") as handle:
        return list(csv.DictReader(handle))


def write_csv(path, rows):
    with open(path, "w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(rows[0].keys()))
        writer.writeheader()
        writer.writerows(rows)


# ---------- 역어셈블 ----------

def disassemble_objdump(hex_bytes):
    """[(명령 텍스트, 바이트 수)] 목록. 출력 줄 '   0:\\t48 8b c1 \\tmov rax,rcx'."""
    with tempfile.TemporaryDirectory(prefix="m4_") as folder:
        path = os.path.join(folder, "b.bin")
        with open(path, "wb") as handle:
            handle.write(bytes.fromhex(hex_bytes))
        run = subprocess.run([T.OBJDUMP, "-D", "-w", "-b", "binary", "-m", "i386:x86-64", "-M", "intel",
                              "--insn-width=16", path], capture_output=True, text=True, timeout=20)
    out = []
    for line in run.stdout.splitlines():
        match = re.match(r"^\s*[0-9a-f]+:\t((?:[0-9a-f]{2} )+)\s*\t?(.*)$", line)
        if match:
            out.append((match.group(2).strip(), len(match.group(1).split())))
    return out


def disassemble_llvm(hex_bytes):
    """llvm-mc는 바이트 수를 따로 내지 않는다. 명령 텍스트 목록과 경고(잘못된 인코딩)만 돌려준다."""
    text = " ".join("0x" + hex_bytes[i:i + 2] for i in range(0, len(hex_bytes), 2))
    run = subprocess.run([T.LLVM_MC, "--disassemble", "-triple=x86_64-unknown-linux-gnu", "--output-asm-variant=1"],
                         input=text, capture_output=True, text=True, timeout=20)
    lines = [l.strip() for l in run.stdout.splitlines() if l.strip() and not l.strip().startswith(".")]
    return join_prefix_lines(lines), "invalid instruction encoding" in run.stderr or "potentially undefined" in run.stderr


def join_prefix_lines(lines):
    """llvm-mc는 lock·xacquire·xrelease를 다음 명령과 다른 줄에 낸다('lock' / 'add ...').
    접두어 낱말만 있는 줄은 뒤 명령 줄과 합친다. 뒤에 명령이 없으면(접두어 단독 행 'f0') 그대로 둔다."""
    out, pending = [], []
    for line in lines:
        if all(w.lower() in REP_WORDS for w in line.split()) and line.split():
            pending.append(line)
            continue
        out.append(" ".join(pending + [line]))
        pending = []
    return out + pending


def strip_comment(text):
    return re.sub(r"\s*(#|//).*$", "", re.sub(r"<[^>]*>", "", text)).strip()


def split_mnemonic(text):
    """('rep', 'ins', 오퍼랜드): REP 계열 낱말, 본 니모닉, 나머지. 인코딩 접두어 낱말은 건너뛴다."""
    words = strip_comment(text).replace("\t", " ").split()
    reps = []
    index = 0
    while index < len(words) and (words[index].lower() in PREFIX_WORDS or words[index].lower() in REP_WORDS
                                  or re.fullmatch(r"rex\.w?r?x?b?", words[index].lower())):
        if words[index].lower() in REP_WORDS:
            reps.append(REP_WORDS[words[index].lower()])
        index += 1
    if index >= len(words):              # 'lock'처럼 접두어 낱말 하나뿐인 행: 본 니모닉 자리에 그 바이트
        return reps, (reps[-1] if reps else ""), ""
    return reps, words[index].lower(), " ".join(words[index + 1:])


# ---------- SDM 니모닉 목록 ----------

def base_name(row):
    """표 행의 본 니모닉: 'REP INS m8, DX' -> 'ins', 'LOCK' -> 'f0'(접두어 단독 행은 바이트로)."""
    words = row["instruction"].split()
    if words[0].upper() in ("REP", "REPE", "REPZ", "REPNE", "REPNZ") and len(words) > 1:
        return words[1].lower()
    name = row["mnemonic"].split()[-1].lower()
    return REP_WORDS.get(name, name)


def opcode_key(opcode):
    """니모닉 동의어를 찾는 opcode 열쇠. REP 계열(F2/F3 + 문자열 opcode)은 접두어를 뗀 문자열 opcode와 같이 본다
    (SDM 표: 'F3 6C REP INS m8, DX'와 '6C INSB'는 같은 문자열 명령)."""
    key = re.sub(r"REX\.W\s*\+\s*", "REX.W ", " ".join(opcode.split()))
    return re.sub(r"^F[23]\s+(?=(?:REX\.W )?[0-9A-F]{2}$)", "", key)


def sdm_mnemonics(isa):
    """opcode 열쇠 -> 그 칸을 쓰는 모든 표 행의 본 니모닉. JE/JZ, SAL/SHL, INS/INSB 같은 SDM 동의어."""
    names = collections.defaultdict(set)
    for row in isa:
        names[opcode_key(row["opcode"])].add(base_name(row))
    return names


def expected_names(case, isa_row, by_opcode):
    """이 케이스가 허용하는 본 니모닉과 꼭 있어야 할 REP 계열 낱말."""
    source_words = case["source"].split()
    source_main = [w for w in source_words if w.lower() not in PREFIX_WORDS and w.lower() not in REP_WORDS]
    names = set(by_opcode[opcode_key(isa_row["opcode"])])
    if source_main and source_main[0].lower() not in D.TOOL_SPELLINGS:
        names.add(source_main[0].lower())            # 생성 철자(retf, sysretq 등). 도구 관례 철자(movabs)는 SDM 이름이 아님
    reps = [REP_WORDS[w.lower()] for w in source_words if w.lower() in REP_WORDS]
    return names, reps


# ---------- 판정 ----------

def source_operands(case):
    """생성 소스의 오퍼랜드(접두어·니모닉을 뗀 cases.csv의 operands 칸)."""
    return D.split_operands(case["operands"]) if case.get("operands") else []


def decoded_operands(text):
    """역어셈블 오퍼랜드. LLVM은 마스크를 '{k1}, ymmword ptr [...]'처럼 따로 쓰므로 다음 오퍼랜드의 장식으로 붙인다."""
    parts, pending = [], ""
    for part in D.split_operands(text):
        if re.fullmatch(r"(\{[^}]*\}\s*)+", part):
            pending += part
        else:
            parts.append(part + (" " + pending if pending else ""))
            pending = ""
    return parts


SAME_OPCODE = {}


def same_opcode(isa_row):
    return SAME_OPCODE.get(" ".join(isa_row["opcode"].split()), [])


def sdm_memory_bits(isa_row):
    """표 기호 순서대로 원문 메모리 폭(먼 포인터 m16:N 포함). 암묵 오퍼랜드(<...>)는 뺀다."""
    out = []
    for symbol in isa_row["operands"].split(","):
        symbol = R.clean_symbol(symbol)
        correction = R.DESCRIPTION_CORRECTIONS.get((isa_row["mnemonic"], " ".join(isa_row["opcode"].split()), symbol))
        if correction:                            # 생성기와 같은 Description 보정 폭(VPMOVQD m128 -> m64)
            symbol = correction[0]
        if not symbol or symbol.startswith("<"):
            continue
        bits = None
        for part in symbol.split("/"):
            if part in D.FAR_POINTER_BITS:
                bits = D.FAR_POINTER_BITS[part]
            elif part in R.MEMORY_BITS:
                bits = R.MEMORY_BITS[part][1]
        out.append(bits)
    return out


def drop_implicit(got, wanted, isa_row):
    """역어셈블러가 출력한 SDM 암묵 오퍼랜드를 뺀다.
    - 표에 <XMM0>처럼 적힌 암묵 레지스터
    - 문자열 명령의 누산기(Description: AL/AX/EAX/RAX로 읽고 씀)
    - opcode가 정한 리터럴 1(D0/D1 시프트 행 '..., 1'): 역어셈블러가 생략할 수 있다(wanted 쪽을 뺀다)"""
    implicit = {m.lower() for m in re.findall(r"<([A-Za-z]+\d*)", isa_row["operands"])}
    if re.sub(r"[BWDQ]$", "", base_name(isa_row).upper()) in R.STRING_NAMES or base_name(isa_row).upper() in R.STRING_NAMES:
        implicit |= {"al", "ax", "eax", "rax"}
    wanted_names = {w.get("name") for w in wanted}
    got = [g for g in got if not (g["kind"] == "reg" and g["name"] in implicit and g["name"] not in wanted_names)]
    if len(got) == len(wanted) - 1 and wanted and wanted[-1]["kind"] == "imm" and wanted[-1]["value"] == 1 \
            and re.search(r",\s*1$", isa_row["operands"]):
        wanted = wanted[:-1]
    return got, wanted


def reg_positions(isa_row):
    """표 기호 순서(암묵 오퍼랜드 제외)에서 레지스터 칸이 SYM039 reg인 자리('reg', 'reg/m16' 등)."""
    symbols = [R.clean_symbol(s) for s in isa_row["operands"].split(",")]
    symbols = [s for s in symbols if s and not s.startswith("<")]
    return {index for index, symbol in enumerate(symbols) if "reg" in symbol.split("/")}


def compare_operands(case, decoded_text, folded_imm, reversible, isa_row, reg_width_free=False):
    """오퍼랜드가 같은가. reg_width_free면 SYM039 reg 칸은 범용 레지스터 번호만 본다."""
    wanted = [D.operand(t) for t in source_operands(case)]
    bits = sdm_memory_bits(isa_row)
    if len(bits) == len(wanted):
        for op, sdm in zip(wanted, bits):        # 원문 폭이 있으면 생성 철자(fword 등) 대신 원문 폭과 비교
            if op["kind"] == "mem" and sdm and not op["bcst"]:
                op["bits"] = sdm
    if folded_imm:
        wanted = wanted[:-1]
    got = [D.operand(t) for t in decoded_operands(decoded_text)]
    got, wanted = drop_implicit(got, wanted, isa_row)
    free = reg_positions(isa_row) if reg_width_free and not reversible else set()

    def same(index, a, b):
        return D.same_operand(a, b) or (index in free and D.same_gp_register(a, b))
    orders = [wanted] + ([wanted[::-1]] if reversible else [])
    return any(len(w) == len(got) and all(same(i, a, b) for i, (a, b) in enumerate(zip(w, got))) for w in orders)


def far_pointer(isa_row):
    return any(part.strip() in D.FAR_POINTER_BITS for part in isa_row["operands"].split(","))


def reversible_rows(isa):
    """같은 opcode 칸에 오퍼랜드 순서만 뒤집힌 표 행이 있는 행(XCHG r/m16, r16 과 r16, r/m16): 두 순서 모두 SDM 표기."""
    forms = collections.defaultdict(set)
    for row in isa:
        forms[" ".join(row["opcode"].split())].add(tuple(o.strip() for o in row["operands"].split(",")))
    out = set()
    for index, row in enumerate(isa):
        ops = tuple(o.strip() for o in row["operands"].split(","))
        if len(ops) == 2 and ops[::-1] in forms[" ".join(row["opcode"].split())]:
            out.add(index)
    return out


def judge(name, hex_bytes, case, isa_row, by_opcode, reversible=False):
    out = {"text": "", "verdict": "", "reassembled": ""}
    if name == "objdump":
        decoded = disassemble_objdump(hex_bytes)
        whole = len(decoded) == 1 and decoded[0][1] * 2 == len(hex_bytes) and "(bad)" not in decoded[0][0]
        texts = [t for t, _ in decoded]
    else:
        texts, invalid = disassemble_llvm(hex_bytes)
        whole = len(texts) == 1 and not invalid
    out["text"] = " | ".join(texts)
    fwait = (isa_row["opcode"].startswith("9B ") and len(texts) == 2 and not (name == "llvm" and invalid)
             and split_mnemonic(texts[0])[1] in ("wait", "fwait"))
    if fwait:                                    # FWAIT_PAIR: 9B 행은 FWAIT + FN* 두 명령
        texts = [re.sub(r"\bfn", "f", texts[1], count=1)]
        whole = True
    if not whole:
        out["verdict"] = "디코드 실패"
        return out
    reps, main, rest = split_mnemonic(texts[0])
    names, wanted_reps = expected_names(case, isa_row, by_opcode)
    folded = False
    if main not in names:
        operands = source_operands(case)
        imm = D.number(operands[-1]) if operands else None
        folded = imm is not None and any(D.pseudo_op(n, imm) == main for n in names)
    if not set(wanted_reps) <= set(reps):
        out["verdict"] = "니모닉 다름"
        return out
    if main not in names and not folded:
        out["verdict"] = ("니모닉 다름(도구 관례 철자)" if D.TOOL_SPELLINGS.get(main) in names else "니모닉 다름")
        return out
    if ".Ltarget" in case["source"] or case.get("relative"):   # 검사 CLI: 표 행이 rel 형식
        out["verdict"] = "SDM 일치(분기 대상 미대조)"
        return out
    if not rest.strip() and source_operands(case) and any(
            not r["operands"].strip() and base_name(r) == main for r in same_opcode(isa_row)):
        out["verdict"] = "SDM 일치(같은 opcode 표 행의 표기)"   # XLAT m8 바이트를 XLATB로
        return out
    if not source_operands(case) and rest.strip():
        # 표 행에 오퍼랜드가 없음(OUTSB, MOVSB 등). 역어셈블러가 출력한 암묵 오퍼랜드는 SDM 표에 없어 대조하지 않는다
        out["verdict"] = "SDM 일치(암묵 오퍼랜드 미대조)"
        return out
    if main in D.NEAR_AND_FAR and far_pointer(isa_row) and not re.search(r"\bptr\b", rest, re.I):
        # SDM은 m16:N의 어셈블리 크기 표기(FWORD PTR 등)를 정의하지 않는다(Vol.1·Vol.2 전체 검색, 2026-10-12)
        out["verdict"] = "SDM 일치(먼 포인터 크기 표기 미대조)"
    else:
        if compare_operands(case, rest, folded, reversible, isa_row):
            out["verdict"] = "SDM 일치"
        elif compare_operands(case, rest, folded, reversible, isa_row, reg_width_free=True):
            out["verdict"] = "SDM 일치(reg 칸 레지스터 폭 표기)"   # SYM039: r16, r32, or r64 같은 표기
        else:
            out["verdict"] = "오퍼랜드 다름"
    again = assemble(".intel_syntax noprefix\n" + strip_comment(texts[0]) + "\n", DISASSEMBLERS[name])
    out["reassembled"] = (again["bytes"] if again["bytes"] == hex_bytes else
                          "같은 문법의 다른 인코딩 " + again["bytes"] if again["observation_status"] == "accepted"
                          else "거부")
    return out


def prepare(isa):
    """판정에 쓰는 표: opcode 칸 -> SDM 니모닉, 순서만 뒤집힌 행, 같은 opcode 행(SAME_OPCODE). CLI도 쓴다."""
    if not SAME_OPCODE:
        for row in isa:
            SAME_OPCODE.setdefault(" ".join(row["opcode"].split()), []).append(row)
    return sdm_mnemonics(isa), reversible_rows(isa)


def sdm_bytes(result):
    for tool in ("as", "clang"):
        if result["expected"] == "reach" and result["verdict_" + tool].startswith("SDM 일치") and result["bytes_" + tool]:
            return result["bytes_" + tool], tool
    return "", ""


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--cases", default=os.path.join(ROOT, "out/cases"))
    parser.add_argument("--workers", type=int, default=8)
    args = parser.parse_args()
    results = read_csv(os.path.join(args.cases, "check_results.csv"))
    operands_by_case = {c["case_id"]: c["operands"] for c in read_csv(os.path.join(args.cases, "cases.csv"))}
    isa = read_csv(os.path.join(ROOT, "data/db/isa_db.csv"))
    by_opcode, reversible = prepare(isa)
    targets = []
    for result in results:
        data, origin = sdm_bytes(result)
        if data:
            targets.append((result, data, origin))

    def work(item):
        result, data, origin = item
        row = {"case_id": result["case_id"], "row_id": result["row_id"], "instruction": result["instruction"],
               "opcode": result["opcode"], "source": result["source"], "bytes": data, "bytes_from": origin}
        result = dict(result, operands=operands_by_case.get(result["case_id"], ""))
        for name in DISASSEMBLERS:
            judged = judge(name, data, result, isa[int(result["row_id"])], by_opcode,
                           int(result["row_id"]) in reversible)
            for key in ("verdict", "text", "reassembled"):
                row["%s_%s" % (key, name)] = judged[key]
        return row

    with ThreadPoolExecutor(max_workers=max(1, args.workers)) as pool:
        rows = list(pool.map(work, targets))
    write_csv(os.path.join(args.cases, "disasm_results.csv"), rows)
    summary = {"cases": len(rows), "skipped_not_sdm_match": len(results) - len(rows),
               "verdicts": {name: dict(collections.Counter(r["verdict_" + name] for r in rows)) for name in DISASSEMBLERS}}
    with open(os.path.join(args.cases, "disasm_summary.json"), "w", encoding="utf-8") as handle:
        json.dump(summary, handle, ensure_ascii=False, indent=1)
    print(json.dumps(summary, ensure_ascii=False, indent=1))


if __name__ == "__main__":
    main()

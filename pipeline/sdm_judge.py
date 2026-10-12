"""명령어 한 줄을 파이프라인 3·4단계와 같은 기준으로 판정한다(검사 CLI가 쓴다).

1. 후보 SDM 행: 2단계와 같은 행 정리(m2_generate.load_rows, 행 지정 철자 apply_row_spelling)로
   니모닉(REP 계열 포함)과 오퍼랜드 형태(operand_forms.match_token)가 맞는 표 행을 찾는다.
   - 64비트 모드 Valid인 후보가 있으면 기대 결과 reach, 후보가 모두 무효면 reject, 후보가 없으면 unknown.
2. SDM 대 각 어셈블러(3단계 m3_check와 같은 인코딩 대조 encoding, 보정 파일, 기본 설정에서 끈 기능 note)
3. SDM 대 각 역어셈블러(4단계 m4_disasm.judge): SDM 행과 맞은 바이트(GNU 우선)를 objdump·llvm-mc로 따로 푼다.
도구끼리는 비교하지 않는다(2026-10-11 사용자 결정). 판정은 인코딩 필드 대조이며 실행 의미 검증이 아니다.
"""

import os
import re

from pipeline import case_rules as R
from pipeline import m2_generate as m2
from pipeline import m3_check as m3
from pipeline import m4_disasm as m4
from pipeline.operand_forms import match_token

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
# CLI의 도구 이름 -> 3단계 이름
TOOL_NAMES = {"gnu_as": "as", "clang": "clang"}
ASSEMBLER_OK = ("SDM 일치", "SDM 일치(거부)")
DISASM_OK = ("SDM 일치", "SDM 일치(분기 대상 미대조)", "SDM 일치(암묵 오퍼랜드 미대조)", "SDM 일치(같은 opcode 표 행의 표기)",
             "SDM 일치(reg 칸 레지스터 폭 표기)")
REP_BYTE = {"rep": "f3", "repe": "f3", "repz": "f3", "repne": "f2", "repnz": "f2"}

_CONTEXT = None


def context():
    """한 번만 읽는다: isa 행, 2단계 행 정리, 인코딩 보정, 도달 불가 등록, 4단계 표."""
    global _CONTEXT
    if _CONTEXT is None:
        isa = m3.read_csv(m2.ISA_DB)
        rows = m2.load_rows()
        for row in rows:
            row["fixed_operand"] = m2.apply_row_spelling(row)[0]   # 행 지정 고정 오퍼랜드(먼 CALL/JMP 'fword ptr [rax]')
        by_opcode, reversible = m4.prepare(isa)
        _CONTEXT = {
            "isa": isa, "rows": rows, "by_opcode": by_opcode, "reversible": reversible,
            "overrides": {int(r["row_id"]): r for r in m3.read_csv(m3.OVERRIDES)},
            "unreachable": {int(r["row_id"]): r for r in m3.read_csv(m3.UNREACHABLE)},
        }
    return _CONTEXT


def spellings(row):
    """이 행을 가리키는 (REP 접두어 바이트, 니모닉) 철자들: SDM 철자와 2단계 행 지정 철자."""
    words = row["source_mnemonic"].split()
    rep = REP_BYTE.get(words[0]) if len(words) > 1 else None
    names = {words[-1]}
    if row["asm_mnemonic"]:
        names.add(row["asm_mnemonic"].lower())
    if row["name"] == "MOV" and any(re.fullmatch(r"moffs\d+", R.clean_symbol(s)) for s in row["symbols"]):
        names.add("movabs")
    return rep, names


def explicit_symbols(row):
    """소스에 쓰는 오퍼랜드 기호(암묵 오퍼랜드 <XMM0> 등은 뺀다). 2단계와 같은 Description 보정을 적용한다."""
    out = []
    for symbol in row["symbols"]:
        part = R.clean_symbol(symbol)
        correction = R.DESCRIPTION_CORRECTIONS.get((row["name"], row["opcode"], part))
        if correction:
            symbol = symbol.replace(part, correction[0]) if part in symbol else correction[0]
        if not R.clean_symbol(symbol).startswith("<"):
            out.append(symbol)
    return out


GPR_FAMILIES = ("r8", "r16", "r32", "r64")
OTHER_FAMILIES = {"xmm": "xmm", "ymm": "ymm", "zmm": "zmm", "tmm": "tmm", "bnd": "bnd", "mm": "mm", "k": "k",
                  "ST(i)": "st", "Sreg": "sreg", "CR0–CR7": "cr", "DR0–DR7": "dr"}


def piece_accepts(piece, op):
    """표 기호 조각 하나가 입력 오퍼랜드 종류를 받는가. True / False / None(이 검사기가 모르는 기호)."""
    text = op["text"].lower().split("{")[0].strip()
    if R.is_memory(piece):
        return op["kind"] == "mem"
    family = R.register_family(piece)
    if family in GPR_FAMILIES or piece in ("r", "reg"):
        return op["family"] == "gpr"
    if family:
        return op["family"] == OTHER_FAMILIES[family]
    fixed = R.fixed_register(piece)
    if fixed:
        return text == fixed or (fixed.startswith("st") and text in ("st", "st(0)"))
    if re.fullmatch(r"imm(8|16|32|64)|\d+", piece):
        return op["kind"] == "imm"
    if re.fullmatch(r"rel(8|16|32)", piece):
        return op["kind"] in ("symbol", "imm")
    if re.fullmatch(r"ptr16:(16|32)", piece):
        return op["kind"] == "far_ptr"
    return None


def kind_accepts(symbol, op):
    """기호(합성 'r/m16', 'xmm2/m128/m32bcst' 포함)의 어느 조각이든 입력 종류를 받으면 True."""
    part = R.clean_symbol(symbol)
    pieces = [part] if R.is_memory(part) else part.split("/")
    answers = [piece_accepts(p, op) for p in pieces]
    return True if True in answers else None if None in answers else False


def form(symbols, operands, row=None):
    """'match' / 'partial'(검사기 범위 밖 칸이 있음) / None(형태 다름)."""
    if len(symbols) != len(operands):
        return None
    partial = False
    for symbol, op in zip(symbols, operands):
        accumulator = R.STRING_ACCUMULATOR_BITS.get(R.clean_symbol(symbol))
        if row and row["string_memory_accumulator"] and accumulator and op["kind"] == "mem":
            # 2단계: REP LODS AL/AX/EAX/RAX는 GNU가 받는 메모리 철자(byte·…·qword ptr [rsi])로도 쓴다
            if op["bits"] != accumulator:
                return None
            continue
        decor = [d for d in op["decorations"] if not d.startswith("{1to")]
        if decor and not any(d in ("{k1}", "{k2}") for d in R.decorations(symbol)):
            return None                                   # 표 기호에 마스크가 없는데 입력에 마스크가 있음
        kind = kind_accepts(symbol, op)
        if kind is False:
            return None                                   # 오퍼랜드 종류가 다름(레지스터 계열·메모리·즉시값 …)
        value = match_token(R.clean_symbol(symbol), dict(op, decorations=[]))
        if value is False:
            return None
        partial = partial or kind is None or value is None
    return "partial" if partial else "match"


def candidates(parsed):
    """입력 줄과 니모닉·오퍼랜드 형태가 맞는 표 행. 형태 대조는 operand_forms 범위에서만 확정한다.

    REP 계열: SDM 철자는 'REP MOVS m8, m8'처럼 REP 행이다. 그런 행이 없으면(예: 'rep movsb')
    REP를 따로 붙인 기본 행(MOVSB)을 후보로 보고 rep_separate를 표시한다.
    """
    rep = next((REP_BYTE[p] for p in parsed["prefixes"] if p in REP_BYTE), None)
    result = find_candidates(parsed, rep)
    if rep and not result["rows"]:
        fallback = find_candidates(parsed, None)
        if fallback["rows"]:
            fallback["rep_separate"] = True
            return fallback
    return result


def find_candidates(parsed, rep):
    ctx = context()
    mnemonic = parsed["mnemonic"].lower()
    same_name, found = [], []
    for row in ctx["rows"]:
        row_rep, names = spellings(row)
        if mnemonic not in names or row_rep != rep:
            continue
        same_name.append(row)
        kind = form(explicit_symbols(row), parsed["operands"], row)
        if not kind and row["fixed_operand"]:
            # 2단계가 도구 철자로 고정한 행(먼 CALL/JMP의 'data16·rex64 + fword ptr [rax]'): 접두어와 고정 오퍼랜드가 같으면 후보
            kind = ("match" if (not row["asm_prefix"] or row["asm_prefix"] in parsed["prefixes"])
                    and operands_text(parsed).lower() == row["fixed_operand"] else None)
        if kind:
            isa = row["isa"]
            found.append({"row_id": row["row_id"], "instruction": isa["instruction"], "opcode": isa["opcode"],
                          "mode_support": isa["mode_support"], "cpuid_flag": isa["cpuid_flag"],
                          "source_page": isa["source_page"], "form": kind, "row_status": row["status"]})
    status = ("form_match" if any(c["form"] == "match" for c in found) else "incomplete" if found
              else "no_form_match" if same_name else "mnemonic_not_found")
    return {"status": status, "rows": found, "same_name_rows": [r["row_id"] for r in same_name],
            "meaning_verified": False}


def expected_of(found):
    if any(c["mode_support"] == "Valid" for c in found):
        return "reach"
    return "reject" if found else "unknown"


def operands_text(parsed):
    return ", ".join(op["text"] for op in parsed["operands"])


def matching_rows(observed, row_ids, operands, valid_only=False):
    """바이트가 3단계 인코딩 대조로 맞는 행 번호들과, 대조하지 못한 행이 있었는지."""
    ctx = context()
    matched, unchecked = [], False
    case = {"operands": operands}
    for row_id in row_ids:
        isa_row = ctx["isa"][row_id]
        if valid_only and isa_row["mode_support"] != "Valid":
            continue
        # 사용자 라벨의 분기 거리는 정할 수 없다. 꼬리 폭은 보고 목표 거리(생성기의 .Ltarget 규약)는 보지 않는다.
        checked = dict(m3.check_row(isa_row, case), relative_target_unchecked=True)
        status = m3.encoding(observed["bytes"], checked, observed.get("relocations"), ctx["overrides"].get(row_id))
        if status == "fields_match":
            matched.append(row_id)
        elif status == "not_checked":
            unchecked = True
    return matched, unchecked


def judge_assembler(tool, observed, cand, expected, operands):
    """3단계와 같은 판정 이름. tool: 'gnu_as' / 'clang'."""
    out = {"status": observed["status"], "bytes": observed.get("bytes", ""), "verdict": "", "rows": [], "note": ""}
    diagnostic = " ".join((observed.get("assembly", {}).get("stderr") or "").split())
    if observed["status"] != "accepted":
        if expected == "reject":
            out["verdict"] = "SDM 일치(거부)"
        else:
            unknown = re.search(r"no such instruction|invalid instruction mnemonic", diagnostic)
            out["verdict"] = "모르는 명령" if unknown else "거부"
        for c in cand["rows"]:
            reason = m3.DEFAULT_OFF.get(TOOL_NAMES[tool], {}).get(c["cpuid_flag"].strip())
            if reason and "is not supported on" in diagnostic:
                out["note"] = reason
        return out
    own, unchecked = matching_rows(observed, [c["row_id"] for c in cand["rows"]], operands)
    valid_own = [r for r in own if context()["isa"][r]["mode_support"] == "Valid"]
    others, _ = matching_rows(observed, [r for r in cand["same_name_rows"] if r not in own], operands, valid_only=True)
    if expected == "reach":
        if valid_own:
            out.update(verdict="SDM 일치", rows=valid_own)
        elif others:
            out.update(verdict="다른 행 인코딩", rows=others)
        else:
            out["verdict"] = "인코딩 미대조" if unchecked else "다른 인코딩"
    elif expected == "reject":
        out.update(verdict="다른 행으로 수용" if others else "SDM과 다름(수용)", rows=others)
    else:
        out.update(verdict="형태 후보 밖 행 도달" if others else "후보 행 없음", rows=others)
    for row_id in out["rows"]:
        entry = context()["unreachable"].get(row_id)
        if entry:
            out["note"] = (out["note"] + " | " if out["note"] else "") + "도달 불가 등록: " + entry["reason"][:100]
    return out


def judge_disassemblers(code, parsed, assemblers):
    """SDM 일치 바이트(GNU 우선, 없으면 clang)를 4단계 판정으로 objdump·llvm-mc에 따로 맡긴다."""
    ctx = context()
    source = next((t for t in ("gnu_as", "clang") if assemblers.get(t, {}).get("verdict") == "SDM 일치"), None)
    if source is None:
        return {}
    row_id = assemblers[source]["rows"][0]
    relative = any(re.fullmatch(r"rel(8|16|32)", R.clean_symbol(s)) for s in ctx["rows"][row_id]["symbols"])
    case = {"source": code, "operands": operands_text(parsed), "relative": relative}
    out = {}
    for name in m4.DISASSEMBLERS:
        judged = m4.judge(name, assemblers[source]["bytes"], case, ctx["isa"][row_id], ctx["by_opcode"],
                          row_id in ctx["reversible"])
        out[name] = {"from": source, "row_id": row_id, "verdict": judged["verdict"], "text": judged["text"],
                     "reassembled": judged["reassembled"]}
    return out


def judge(code, parsed, observations):
    """observations: {'gnu_as': assemble 결과, 'clang': assemble 결과}(있는 것만)."""
    cand = candidates(parsed)
    expected = expected_of(cand["rows"])
    operands = operands_text(parsed)
    assemblers = {tool: judge_assembler(tool, obs, cand, expected, operands)
                  for tool, obs in observations.items() if obs}
    disassemblers = judge_disassemblers(code, parsed, assemblers)
    if expected == "unknown":
        summary = "no_sdm_row"
    elif (all(a["verdict"] in ASSEMBLER_OK for a in assemblers.values())
          and all(d["verdict"] in DISASM_OK for d in disassemblers.values())):
        summary = "sdm_match"
    else:
        summary = "sdm_difference"
    return {"candidates": cand, "expected": expected, "assemblers": assemblers,
            "disassemblers": disassemblers, "summary": summary, "meaning_verified": False}


def judge_expected_row(observed, row, operands):
    """--expect-row: 지정한 표 행 하나(isa 행 dict)와 3단계 인코딩 대조."""
    if observed.get("status") != "accepted":
        return "not_applicable"
    row_id = int(row["row_id"]) if str(row.get("row_id", "")).isdigit() else None
    checked = dict(row, operand_types=row.get("operands", ""), operands=operands, relative_target_unchecked=True)
    status = m3.encoding(observed.get("bytes", ""), checked, observed.get("relocations"),
                         context()["overrides"].get(row_id))
    return status if status in ("fields_match", "not_checked") else "different_encoding"

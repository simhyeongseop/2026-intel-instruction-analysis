"""
2단계 tokenizer: isa_db.csv -> tokens.csv

1단계(extractor)가 mnemonic / operands 를 대충 나눠놓은 것을, 오퍼랜드 단위로
정밀하게 쪼개서 한 줄 = 오퍼랜드 하나로 만든다. (조합 생성은 3단계 combiner 몫이라
여기서는 하지 않는다.)

예: isa_db.csv 한 행 mnemonic=ADD, operands="r/m32, r32"
    -> tokens.csv 두 행: (operand_index=0, operand_token="r/m32"), (operand_index=1, operand_token="r32")

원칙(설계 지침 CLAUDE.md 1절):
- 정답은 SDM 표기 그대로. r/m32 의 '/' 는 "레지스터 또는 메모리"라는 뜻이라 자르지 않는다
  (조합 전개는 combiner 가 한다 - 여기서는 원형 보존만).
- 각주 숫자 제거는 이미 1단계(extractor)에서 PDF 문자 단위로 근본적으로 처리했으므로
  여기서는 다시 문자열 화이트리스트로 방어하지 않는다(예전에 그 방식이 새 단어가
  나올 때마다 놓치는 문제를 일으켰다 - m1_extract.py 상단 주석 참고).
"""

import csv
from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from pipeline.input_quality import (apply_known_operand_correction, blocking_issues,
                                    gate_exit_code, validate_operand_list,
                                    validate_operand_token, write_issues)
from pipeline.generation_contract import form_hash

IN_CSV = ROOT / "data/db/isa_db.csv"
OUT_CSV = ROOT / "data/db/tokens.csv"
ISSUES_CSV = ROOT / "data/db/extraction_issues.csv"

OUT_COLUMNS = [
    "row_id", "mnemonic", "operand_index", "operand_count",
    "operand_token", "raw_operand_token", "normalized_operand_token",
    "operand_kind", "implicit_operands", "validation_status", "validation_codes",
    "raw_instruction",
    "op_en", "mode_support", "cpuid_flag", "source_page",
    "opcode", "description", "form_hash",
]

# ---------- REP/REPE/REPNE 처럼 mnemonic 이 "접두사"이고, 진짜 니모닉(MOVS 등)이
# operands 칸 맨 앞에 섞여 들어온 경우를 위한 보정 ----------
# 예: isa_db.csv 상 mnemonic="REP", operands="MOVS m8, m8" (원래 SDM instruction은
# "REP MOVS m8, m8" 인데 1단계가 첫 단어만 mnemonic으로 떼어내며 이렇게 됨).
# 문자열 반복 명령어(STRING instruction) 니모닉은 x86 ISA 상 7개로 고정돼 있어
# PDF 렌더링에 따라 늘어나는 종류가 아니므로, 각주 숫자 화이트리스트와 달리
# 안전하게 하드코딩해도 된다.
REPEAT_PREFIXES = {"REP", "REPE", "REPZ", "REPNE", "REPNZ"}
STRING_INSTR_MNEMONICS = {"INS", "OUTS", "LODS", "MOVS", "CMPS", "SCAS", "STOS"}


def fix_repeat_prefix_mnemonic(mnemonic, operands):
    """REP 계열 mnemonic 뒤에 진짜 니모닉이 operands 맨 앞에 섞여있으면 mnemonic 쪽으로 옮긴다."""
    if mnemonic not in REPEAT_PREFIXES or not operands:
        return mnemonic, operands
    first_segment = operands.split(",", 1)[0]
    words = first_segment.split(None, 1)
    if not words or words[0] not in STRING_INSTR_MNEMONICS:
        return mnemonic, operands
    sub_mnemonic = words[0]
    remainder = words[1].strip() if len(words) > 1 else ""
    rest = operands.split(",", 1)[1] if "," in operands else ""
    new_operands = ", ".join(p for p in (remainder, rest.strip()) if p)
    return f"{mnemonic} {sub_mnemonic}", new_operands


def split_operands(operands):
    """콤마로 오퍼랜드를 분리한다. '/'는 "reg 또는 mem" 표기이므로 자르지 않는다."""
    if not operands or not operands.strip():
        return []
    return [tok.strip() for tok in operands.split(",") if tok.strip()]


# ---------- operand_kind 분류 (참고용 힌트일 뿐, 최종 판단은 combiner 몫) ----------

DECORATION_RE = re.compile(r"\{[^}]*\}")  # {k1}, {z}, {er}, {sae} 등 표기 제거용

IMMEDIATE_RE = re.compile(r"^imm(8|16|32|64)$")
LITERAL_NUM_RE = re.compile(r"^-?\d+$")
RELATIVE_RE = re.compile(r"^rel(8|16|32|64)$")
MOFFS_RE = re.compile(r"^moffs(8|16|32|64)$")
FAR_PTR_RE = re.compile(r"^ptr\d+:\d+$")

REGISTER_ATOM_PATTERNS = [
    re.compile(r"^r(8|16|32|64)[ab]?$"),          # r8, r32, r32a, r64b ...
    re.compile(r"^r$"),                            # r/m8 안의 bare 'r'
    re.compile(r"^(x|y|z)?mm[0-9]*$"),             # mm, mm1, xmm, xmm1, ymm2, zmm3 ...
    re.compile(r"^k[0-9]+$"),                      # k1, k2, k3
    re.compile(r"^bnd[0-9]*$"),                    # bnd, bnd1, bnd2
    re.compile(r"^tmm[0-9]+$"),                    # tmm1, tmm2
    re.compile(r"^ST(\([^)]*\))?$"),               # ST, ST(0), ST(i)
    re.compile(r"^CR\d+([–-]CR\d+)?$"),       # CR8, CR0–CR7
    re.compile(r"^DR\d+([–-]DR\d+)?$"),       # DR0–DR7
]
REGISTER_LITERALS = {
    "Sreg", "reg",
    "AL", "AH", "AX", "EAX", "RAX",
    "CL", "DX",
    "CS", "SS", "DS", "ES", "FS", "GS",
}

MEMORY_ATOM_PATTERNS = [
    re.compile(r"^m\d*(int|fp|bcd|byte|bcst)?$"),  # m, m8, m512, m16int, m32fp, m80bcd, m512byte, m32bcst ...
    re.compile(r"^m\d+/\d+byte$"),                 # m14/28byte, m94/108byte (하나의 메모리 표기, 대안 분리 아님)
    re.compile(r"^vm(32|64)[xyz]$"),               # vm32x, vm64y ... (VSIB 메모리 주소)
    re.compile(r"^m\d+[:&]\d+$"),                  # m16:16, m16&16 등
]
MEMORY_LITERALS = {"mem", "sibmem", "mib"}


def strip_decorations(token):
    """{k1}, {z}, {er}, {sae} 같은 마스크/라운딩 표기를 떼어낸 '순수 오퍼랜드' 문자열."""
    return DECORATION_RE.sub("", token).strip()


def atom_kind(atom):
    """오퍼랜드(혹은 '/'로 나눈 대안 하나)가 무슨 종류인지. 모르면 None."""
    if not atom:
        return None
    if IMMEDIATE_RE.match(atom) or LITERAL_NUM_RE.match(atom):
        return "immediate"
    if RELATIVE_RE.match(atom):
        return "relative"
    if MOFFS_RE.match(atom):
        return "moffs"
    if FAR_PTR_RE.match(atom):
        return "far_ptr"
    if atom in REGISTER_LITERALS or any(p.match(atom) for p in REGISTER_ATOM_PATTERNS):
        return "register"
    if atom in MEMORY_LITERALS or any(p.match(atom) for p in MEMORY_ATOM_PATTERNS):
        return "memory"
    return None


def classify_operand(token):
    """오퍼랜드 토큰 하나의 kind 를 추정한다 (참고용). combiner가 최종 조합 판단을 한다."""
    if "<" in token:
        return "implicit"  # <XMM0> 같은 암묵 오퍼랜드 표기
    clean = strip_decorations(token)
    if not clean:
        return "other"
    kind = atom_kind(clean)
    if kind:
        return kind
    if "/" in clean:
        parts = [p.strip() for p in clean.split("/") if p.strip()]
        part_kinds = [atom_kind(p) for p in parts]
        if parts and all(part_kinds):
            kind_set = set(part_kinds)
            if kind_set == {"register"}:
                return "register"
            if kind_set == {"memory"}:
                return "memory"
            if kind_set <= {"register", "memory"}:
                return "reg_or_mem"
    return "other"


def tokenize_row(row, row_id, token_row_start=0):
    """isa_db.csv 한 행 -> tokens.csv 여러 행(오퍼랜드 없으면 한 행)."""
    mnemonic, raw_operands = fix_repeat_prefix_mnemonic(row["mnemonic"], row["operands"])
    operands, implicit_operands, correction_issues = apply_known_operand_correction(
        mnemonic, row["source_page"], raw_operands, row_id)
    operand_tokens = split_operands(operands)
    raw_operand_tokens = split_operands(raw_operands)
    common = {
        "row_id": row_id,
        "mnemonic": mnemonic,
        "raw_instruction": row["instruction"],
        "op_en": row["op_en"],
        "mode_support": row["mode_support"],
        "cpuid_flag": row["cpuid_flag"],
        "source_page": row["source_page"],
        "opcode": row.get("opcode", ""),
        "description": row.get("description", ""),
        "form_hash": form_hash(row),
    }
    if not operand_tokens:
        checked = validate_operand_token("", row_id, token_row_start)
        return [dict(common, operand_index="", operand_count=0,
                     operand_token="", raw_operand_token="",
                     normalized_operand_token="", operand_kind="none", implicit_operands="",
                     validation_status=checked["validation_status"],
                     validation_codes=checked["validation_codes"])], checked["issues"]
    out = []
    issues = list(correction_issues)
    if not correction_issues:
        issues.extend(validate_operand_list(raw_operands, row_id))
    correction_codes = [item["rule"] for item in correction_issues]
    for idx, token in enumerate(operand_tokens):
        checked = validate_operand_token(token, row_id, token_row_start + idx)
        raw_token = raw_operand_tokens[idx] if idx < len(raw_operand_tokens) else token
        token_correction_codes = correction_codes if raw_token != token else []
        codes = token_correction_codes + [code for code in checked["validation_codes"].split(";") if code]
        status = ("normalized" if token_correction_codes and checked["validation_status"] == "valid"
                  else checked["validation_status"])
        out.append(dict(common, operand_index=idx, operand_count=len(operand_tokens),
                         operand_token=checked["normalized"], raw_operand_token=raw_token,
                         normalized_operand_token=checked["normalized"],
                         operand_kind=classify_operand(checked["normalized"]),
                         implicit_operands=implicit_operands if token_correction_codes else "",
                         validation_status=status,
                         validation_codes=";".join(dict.fromkeys(codes))))
        issues.extend(checked["issues"])
    if any(item["disposition"] == "extraction_suspect" for item in issues):
        for token_row in out:
            codes = [code for code in token_row["validation_codes"].split(";") if code]
            for item in issues:
                if item["rule"] == "missing_operand_delimiter" and item["rule"] not in codes:
                    codes.append(item["rule"])
            if "missing_operand_delimiter" in codes:
                token_row["validation_status"] = "extraction_suspect"
                token_row["validation_codes"] = ";".join(codes)
    return out, issues


def read_isa_db(path):
    with open(path, newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))


def write_tokens(rows, path):
    with open(path, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=OUT_COLUMNS)
        writer.writeheader()
        for row in rows:
            writer.writerow(row)


def main():
    isa_rows = read_isa_db(IN_CSV)
    print(f"입력 행 수: {len(isa_rows)}")
    out_rows = []
    issues = []
    for row_id, row in enumerate(isa_rows):
        token_rows, row_issues = tokenize_row(row, row_id, len(out_rows))
        out_rows.extend(token_rows)
        issues.extend(row_issues)
    write_tokens(out_rows, OUT_CSV)
    write_issues(ISSUES_CSV, issues)
    print(f"출력 행 수(오퍼랜드 단위): {len(out_rows)}")
    print(f"CSV 저장: {OUT_CSV}")
    print(f"입력 품질 기록: {ISSUES_CSV} ({len(issues)}건, 차단 {len(blocking_issues(issues))}건)")
    if blocking_issues(issues):
        print("추출 의심 입력이 있어 다음 단계를 중단합니다.")
    return gate_exit_code(issues)


if __name__ == "__main__":
    raise SystemExit(main())

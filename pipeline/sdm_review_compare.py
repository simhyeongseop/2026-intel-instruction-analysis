"""주 에이전트 독립 판정(main_symbol_spec.csv)과 Sol 원문 추출(sol_partN.csv)을 오퍼랜드 줄 단위로 대조한다.

어느 쪽이 맞는지는 정하지 않는다. 두 기록이 같은지, 다르면 어떤 모양으로 다른지만 분류한다.
- 종류(kind)는 두 쪽 모두 정해진 이름 목록을 쓰므로 그대로 비교한다.
- 폭(data_width)은 Sol 값이 숫자 하나일 때만 자동 비교한다. 서술형 값은 '수동 확인'으로 둔다.
- 레지스터 목록·제약 문장은 자유 서술이라 비교하지 않는다(자료에 그대로 옮긴다).
- Sol part마다 '원문 확정'의 기준이 달랐으므로(2026-10-10 확인) 같은 기계적 기준으로 다시 매긴
  uniform_status를 함께 쓴다. Sol이 붙인 원래 status는 그대로 남긴다.
"""

import csv
import glob
import os
import re

FOOTNOTE = re.compile(r"\^\d+")

# 사람이 확인해야 하는 분류. 이 밖의 분류는 두 기록이 일치하거나 비교 대상이 아니다.
REVIEW_KIND = {"불일치", "main 고정 표기·Sol 종류 있음"}
REVIEW_WIDTH = {"불일치"}
REVIEW_SOL_STATUS = {"원문 충돌", "원문 없음", "추출 불완전"}
LONE_ZMM = re.compile(r"^zmm\d*(\s*\{[^}]*\})*$")
# 표 구문에 글자 그대로 나오는 레지스터 이름: 대문자·숫자만(AL, DX, RAX, XMM0, ST(0)) 또는
# 꺾쇠 안의 암묵 레지스터(<XMM0>, <XMM0-7>, <eax>, <edx>).
# 사용자 결정(4 추가): 표에 글자 그대로 적힌 고정 상수(SAL r/m8, 1의 1)도 같은 기준으로 본다.
FIXED_REGISTER = re.compile(r"^(?:[A-Z][A-Z0-9]{1,3}(?:\(\d\))?|<(?:XMM\d(?:-\d)?|[A-Za-z]{2,3})>|\d+)$")


def read_csv(path):
    with open(path, encoding="utf-8", newline="") as handle:
        return list(csv.DictReader(handle))


def load_sol(review_dir):
    """sol_part1~8.csv를 합친다. 같은 (row_id, operand_index)가 두 번 나오면 오류로 멈춘다."""
    rows = {}
    for path in sorted(glob.glob(os.path.join(review_dir, "sol_part[0-9].csv"))):
        part = os.path.basename(path)[len("sol_"):-len(".csv")]
        for row in read_csv(path):
            key = (int(row["row_id"]), int(row["operand_index"]))
            if key in rows:
                raise ValueError("Sol 줄 중복: %s (%s, %s)" % (key, rows[key]["part"], part))
            row["part"] = part
            rows[key] = row
    return rows


def load_main(path):
    return {(int(r["row_id"]), int(r["operand_index"])): r for r in read_csv(path)}


def plain_symbol(text):
    """각주 표시(^n)와 공백 차이만 없앤다. 다른 차이는 남긴다."""
    return " ".join(FOOTNOTE.sub("", text or "").split())


def compare_symbol(main_symbol, sol_symbol):
    if main_symbol.strip() == sol_symbol.strip():
        return "같음"
    if plain_symbol(main_symbol) == plain_symbol(sol_symbol):
        return "각주·공백만 다름"
    return "다름"


def compare_kind(main, sol):
    """main 상태(defined/no_definition/literal_in_syntax)와 Sol 종류를 함께 본다."""
    sol_kind = sol["kind"].strip()
    if main["status"] == "literal_in_syntax":
        if sol_kind == "literal":
            return "일치"
        return "main 고정 표기·Sol 종류 있음"
    if main["status"] == "no_definition":
        if sol_kind in ("", "원문 없음"):
            return "둘 다 없음"
        return "main 총론 정의 없음·Sol 값 있음"
    if sol_kind in ("", "원문 없음"):
        return "main 값 있음·Sol 원문 없음"
    return "일치" if main["kind"] == sol_kind else "불일치"


def compare_width(main_width, sol_width):
    main_width = main_width.strip()
    sol_width = sol_width.strip()
    if not main_width and not sol_width:
        return "둘 다 빈칸"
    if sol_width.startswith("원문 없음"):
        return "Sol 원문 없음"
    if not re.fullmatch(r"\d+", sol_width):
        return "Sol 서술형(수동 확인)" if sol_width else "Sol 빈칸"
    if not main_width:
        return "main 빈칸·Sol 숫자"
    return "일치" if main_width == sol_width else "불일치"


def is_missing(value):
    """빈칸이거나 '원문 없음'이 들어 있으면 그 칸은 원문으로 채워지지 않은 것으로 본다."""
    return not value.strip() or "원문 없음" in value


def uniform_status(sol):
    """전 part 공통 기준: 종류와 폭 칸이 모두 원문으로 채워져야 원문 확정.

    사용자 결정(2026-10-10):
    - 결정 1: 단독 zmm의 폭은 원문 없음이다(SYM070의 512는 메모리 쪽 폭으로 읽는다).
    - 결정 4: 표에 이름이 그대로 적힌 고정 레지스터(AL, DX, <XMM0> 등)와 고정 상수(1)는 폭 문장 없이 종류만 있으면 확정이다.
    """
    if sol["status"] in ("원문 충돌", "추출 불완전"):
        return sol["status"]
    if is_missing(sol["kind"]):
        return "원문 없음"
    symbol = plain_symbol(sol["table_symbol"])
    if LONE_ZMM.match(symbol):
        return "원문 없음"
    if is_missing(sol["data_width"]) and not FIXED_REGISTER.match(symbol):
        return "원문 없음"
    return "원문 확정"


def compare_line(key, main, sol):
    """한 오퍼랜드 줄의 대조 결과. 한쪽에만 있는 줄도 받는다."""
    out = {
        "row_id": key[0], "operand_index": key[1],
        "part": sol["part"] if sol else "",
        "mnemonic": sol["mnemonic"] if sol else "",
        "main_symbol": main["table_symbol"] if main else "",
        "sol_symbol": sol["table_symbol"] if sol else "",
        "main_status": main["status"] if main else "",
        "main_symbol_id": main["symbol_id"] if main else "",
        "main_kind": main["kind"] if main else "",
        "sol_kind": sol["kind"] if sol else "",
        "main_width": main["data_width"] if main else "",
        "sol_width": sol["data_width"] if sol else "",
        "sol_status": sol["status"] if sol else "",
        "uniform_status": uniform_status(sol) if sol else "",
        "sol_source_level": sol["source_level"] if sol else "",
    }
    if main is None or sol is None:
        side = "Sol에만 있음" if main is None else "main에만 있음"
        out.update(symbol_result=side, kind_result=side, width_result=side, needs_review="예",
                   review_reasons=side)
        return out
    out["symbol_result"] = compare_symbol(main["table_symbol"], sol["table_symbol"])
    out["kind_result"] = compare_kind(main, sol)
    out["width_result"] = compare_width(main["data_width"], sol["data_width"])
    reasons = []
    if out["symbol_result"] == "다름":
        reasons.append("표기 다름")
    if out["kind_result"] in REVIEW_KIND:
        reasons.append("종류 " + out["kind_result"])
    if out["width_result"] in REVIEW_WIDTH:
        reasons.append("폭 불일치")
    if out["uniform_status"] != "원문 확정":
        reasons.append("공통 기준 " + out["uniform_status"])
    out["needs_review"] = "예" if reasons else ""
    out["review_reasons"] = "; ".join(reasons)
    return out


def compare_all(main_rows, sol_rows):
    """operand_index >= 1 줄만 대조한다. 0번 줄(행 전체 조건)은 main에 대응 값이 없다."""
    keys = sorted({k for k in main_rows if k[1] > 0} | {k for k in sol_rows if k[1] > 0})
    return [compare_line(k, main_rows.get(k), sol_rows.get(k)) for k in keys]


def row_level_review(sol_rows):
    """Sol의 0번 줄(행 전체 조건) 중 원문 충돌·없음·불완전인 것."""
    return [r for k, r in sorted(sol_rows.items()) if k[1] == 0 and r["status"] in REVIEW_SOL_STATUS]


# ---------------------------------------------------------------- 행 단위 상태와 생성 케이스 연결

ROW_PRIORITY = ["원문 충돌", "추출 불완전", "원문 없음", "원문 확정"]
STRING_MNEMONICS = {"INS", "LODS", "MOVS", "OUTS", "STOS", "CMPS", "SCAS"}


def row_status(operand_statuses, row_condition_status):
    """isa 행 하나의 상태: 오퍼랜드 줄(공통 기준)과 행 전체 조건(Sol 0번 줄) 중 가장 나쁜 것."""
    statuses = list(operand_statuses)
    if row_condition_status in ("원문 충돌", "추출 불완전"):
        statuses.append(row_condition_status)
    for status in ROW_PRIORITY:
        if status in statuses:
            return status
    return "원문 확정"


def extraction_defects(isa_row):
    """1단계 isa_db 값에서 PDF 원문과 다르다고 확인된 결함 유형을 기계적으로 찾는다.

    op_en 빈칸은 원문 표에 Op/En 열이 없는 x87(F로 시작)·XACQUIRE/XRELEASE는 제외한다.
    """
    defects = []
    mnemonic = isa_row["mnemonic"]
    op_en = isa_row["op_en"].strip()
    if not op_en and not mnemonic.startswith("F") and mnemonic not in ("XACQUIRE", "XRELEASE"):
        defects.append("op_en 빈칸")
    if re.search(r"\s", op_en):
        defects.append("op_en 공백 분리")
    if isa_row["opcode"].strip().endswith("/"):
        defects.append("opcode /r 누락(PDF 원문 오기)")
    operands = isa_row["operands"] or ""
    if operands.split(" ")[0] in STRING_MNEMONICS:
        defects.append("operands에 니모닉")
    if re.search(r"\b(?:r/m|m|r)(?:8|16|32|64)1\b", operands):
        defects.append("operands 각주 숫자")
    return defects

"""1단계 isa_db 추출 결함 행의 보정값을 PDF 쪽 텍스트에서 기계적으로 찾아 근거와 함께 기록한다.

    python3 scripts/build_extraction_corrections.py

대상: sdm_review_compare.extraction_defects가 찾은 행. isa_db는 고치지 않는다.
결과: data/rules/extraction_corrections.csv (row_id, field, isa_value, corrected_value, page, evidence_line, check)
- op_en 빈칸: PDF 표 줄에서 opcode 바로 뒤 칸을 읽고, 같은 쪽~다음 3쪽의 Instruction Operand Encoding 표에
  그 글자로 시작하는 줄이 있는지 확인한다.
- op_en 공백 분리('RV M'): 공백을 없앤 값이 Operand Encoding 표에 있는지 확인한다.
- operands에 니모닉(REP 계열): 표 Instruction 칸 'REP INS m8, DX'를 니모닉 'REP INS'와 오퍼랜드로 나눈다.
- operands 각주 숫자(LAR r64/m161): PDF 줄의 Instruction 칸을 그대로 쓴다.
- opcode /r 누락(VMOVD): PDF 원문 자체가 '6E /'로 인쇄되어 있어(그림 확인) 추출 결함이 아니다. 보정하지 않고
  encoding_check_overrides.csv의 대조용 opcode로만 다룬다.
"""

import csv
import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline import manual_index  # noqa: E402
from pipeline import sdm_review_compare as cmp  # noqa: E402

OUT = "data/rules/extraction_corrections.csv"


def squeeze(text):
    return re.sub(r"\s+", "", text)


def table_line(index, row):
    """isa 행의 opcode로 시작하는 PDF 쪽 줄(공백 무시 비교). 같은 opcode 줄이 여럿이면 Instruction 칸까지 맞는 줄."""
    opcode = squeeze(row["opcode"])
    lines = [l for l in index.page_text(int(row["source_page"])).splitlines() if squeeze(l).startswith(opcode)]
    exact = [l for l in lines if squeeze(row["instruction"]) in squeeze(l)]
    return (exact or lines or [""])[0]


def encoding_letters(index, page):
    """같은 쪽~다음 3쪽에서 'Instruction Operand Encoding' 뒤에 나오는 Op/En 줄의 첫 칸."""
    letters = set()
    for number in range(page, page + 4):
        text = index.page_text(number)
        if "Operand Encoding" not in text:
            continue
        after = text.split("Operand Encoding", 1)[1]
        for line in after.splitlines():
            matched = re.match(r"^([A-Z]{1,4})\s+(?:N/A|Full|Tuple|Scalar|Half|Quarter|Eighth|ModRM|VEX|EVEX|Implicit|"
                               r"Mem|BaseReg|opcode|Fixed|NA|Opcode|imm8|SIB|AL|EAX)", line)
            if matched:
                letters.add(matched.group(1))
    return letters


def main():
    index = manual_index.ManualIndex()
    with open("data/db/isa_db.csv", encoding="utf-8") as handle:
        isa = list(csv.DictReader(handle))
    out = []
    for row_id, row in enumerate(isa):
        for defect in cmp.extraction_defects(row):
            line = table_line(index, row)
            entry = {"row_id": row_id, "mnemonic": row["mnemonic"], "defect": defect, "field": "", "isa_value": "",
                     "corrected_value": "", "page": row["source_page"], "evidence_line": line, "check": ""}
            if defect == "op_en 빈칸":
                tokens = line.split()
                count = len(row["opcode"].split())
                value = tokens[count] if len(tokens) > count else ""
                letters = encoding_letters(index, int(row["source_page"]))
                entry.update(field="op_en", isa_value=row["op_en"], corrected_value=value,
                             check="Operand Encoding 표에 있음" if value in letters else "확인 실패(표 글자 %s)" % sorted(letters))
            elif defect == "op_en 공백 분리":
                value = squeeze(row["op_en"])
                letters = encoding_letters(index, int(row["source_page"]))
                entry.update(field="op_en", isa_value=row["op_en"], corrected_value=value,
                             check="Operand Encoding 표에 있음" if value in letters else "확인 실패(표 글자 %s)" % sorted(letters))
            elif defect == "operands에 니모닉":
                prefix, string_mnemonic, operands = row["instruction"].split(" ", 2)
                found = squeeze(row["instruction"]) in squeeze(line)
                entry.update(field="mnemonic|operands", isa_value="%s|%s" % (row["mnemonic"], row["operands"]),
                             corrected_value="%s %s|%s" % (prefix, string_mnemonic, operands),
                             check="PDF 줄에 Instruction 칸 있음" if found else "확인 실패")
            elif defect == "operands 각주 숫자":
                matched = re.search(re.escape(row["mnemonic"]) + r"\s+(.+?)\s+" + re.escape(row["op_en"]) + r"\s", line)
                value = matched.group(1) if matched else ""
                entry.update(field="operands", isa_value=row["operands"], corrected_value=value,
                             check="PDF 줄에서 읽음" if value else "확인 실패")
            elif defect == "opcode /r 누락(PDF 원문 오기)":
                entry.update(field="opcode", isa_value=row["opcode"], corrected_value="",
                             check="PDF 원문 오기(그림 확인: '6E /'). 보정하지 않음; encoding_check_overrides.csv로 대조")
            out.append(entry)
    with open(OUT, "w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(out[0].keys()))
        writer.writeheader()
        writer.writerows(out)
    from collections import Counter
    print(len(out), Counter((e["defect"], e["check"][:22]) for e in out))
    for e in out:
        if e["check"].startswith("확인 실패"):
            print(e["row_id"], e["mnemonic"], e["corrected_value"], e["check"], "|", e["evidence_line"][:90])


if __name__ == "__main__":
    main()

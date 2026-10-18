"""ISA 행마다 원문 근거를 모은다: 표의 원문 줄, 각주, Op/En 정의 줄, Description.

판단은 하지 않는다. 찾은 방법과 찾지 못한 이유를 상태로 남긴다.
  table_line_status: found / ambiguous(같은 후보 여럿, 순서로 고름) / not_found
  op_en_status:      found / not_found / multiple
"""

import re

from pipeline import manual_lookup


def squash(text):
    return re.sub(r"\s+", " ", text or "").strip()


def section_for_page(index, file_page):
    """그 쪽을 포함하는 명령 절. 여러 개면 첫 번째."""
    for section in index.sections:
        if section["is_instruction_section"] and file_page in section["pages"]:
            return section
    return None


COLUMN_NAMES = ("opcode", "instruction", "op_en", "mode_64", "mode_compat", "cpuid", "description")


def named_cells(cell_record):
    """표 셀 원문(각주 '^n' 보존)을 열 이름으로 묶는다. roles는 1단계 열 분류 결과다."""
    cells = cell_record["marked_cells"]
    roles = cell_record["roles"]
    def cell(index):
        return squash(cells[index]) if index is not None and index < len(cells) and cells[index] else ""
    if roles["merged"]:
        named = {"opcode_instruction": cell(0)}
    else:
        named = {"opcode": cell(0), "instruction": cell(1)}
    named.update({
        "op_en": cell(roles["op_en_idx"]),
        "mode_64": cell(roles["mode_idx"]),
        "mode_compat": cell(roles.get("compat_idx")),
        "cpuid": cell(roles["cpuid_idx"]),
        "description": cell(roles["description_idx"]),
    })
    return named


def footnote_numbers(named):
    """열마다 붙은 각주 번호. {'instruction': ['1'], ...}"""
    found = {}
    for name, text in named.items():
        numbers = re.findall(r"\^(\d+)", text)
        if numbers:
            found[name] = sorted(set(numbers), key=int)
    return found


def notes_by_number(index, section):
    """절의 NOTES: 원문을 번호별로 나눈다. {'1': '...', ...}"""
    pieces = manual_lookup.subsection_text(index, section, "NOTES:")
    lines = [line for _, page_lines in pieces for line in page_lines]
    notes, current = {}, None
    for line in lines[1:]:
        matched = re.match(r"^(\d{1,2})\.\s*(.*)$", line.strip())
        if matched:
            current = matched.group(1)
            notes[current] = matched.group(2)
        elif current and not re.search(r"Vol\. 2[A-D]", line):
            notes[current] += " " + line.strip()
    return notes


def op_en_lines(index, section, op_en):
    """Instruction Operand Encoding 표에서 op_en 글자로 시작하는 줄."""
    pieces = manual_lookup.subsection_text(index, section, "Instruction Operand Encoding")
    hits = []
    for file_page, lines in pieces:
        for line in lines[1:]:
            if op_en and re.match(r"^%s\s" % re.escape(op_en), line.strip()):
                hits.append((file_page, line.strip()))
    return hits


def description_text(index, section):
    pieces = manual_lookup.subsection_text(index, section, "Description")
    return [(file_page, "\n".join(lines[1:])) for file_page, lines in pieces]


def evidence_for_rows(index, rows, cell_records):
    """isa_db 행 목록 -> 근거 기록 목록(같은 순서, row_id = 행 번호).

    cell_records는 scripts/extract_table_footnotes.py가 만든 표 셀 원문(isa_db와 순서·값 일치 검사 완료)이다.
    """
    if len(cell_records) != len(rows):
        raise ValueError("표 셀 원문과 isa_db의 행 수가 다르다")
    records = []
    section_cache = {}
    notes_cache = {}
    for row_id, row in enumerate(rows):
        page = int(row["source_page"])
        if cell_records[row_id]["row_id"] != row_id or int(cell_records[row_id]["source_page"]) != page:
            raise ValueError("행 %d의 표 셀 원문 연결이 어긋났다" % row_id)
        if page not in section_cache:
            section_cache[page] = section_for_page(index, page)
        section = section_cache[page]
        named = named_cells(cell_records[row_id])
        numbers = footnote_numbers(named)
        record = {
            "row_id": row_id,
            "mnemonic": row["mnemonic"],
            "opcode": row["opcode"],
            "instruction": row["instruction"],
            "op_en": row["op_en"],
            "mode_support": row["mode_support"],
            "source_page": page,
            "section_id": section["section_id"] if section else "",
            "section_title": section["title"] if section else "",
            "table_cells": named,
            "footnote_numbers": numbers,
        }
        if section:
            if section["section_id"] not in notes_cache:
                notes_cache[section["section_id"]] = notes_by_number(index, section)
            notes = notes_cache[section["section_id"]]
            wanted = sorted({n for ns in numbers.values() for n in ns}, key=int)
            record["footnotes"] = {n: notes.get(n, "") for n in wanted}
            record["footnotes_missing"] = [n for n in wanted if not notes.get(n)]
            lines = op_en_lines(index, section, row["op_en"])
            record["op_en_lines"] = lines
            record["op_en_status"] = "not_found" if not lines else ("found" if len(lines) == 1 else "multiple")
            record["description"] = description_text(index, section)
        else:
            record.update(footnotes={}, footnotes_missing=[], op_en_lines=[], op_en_status="no_section",
                          description=[])
        records.append(record)
    return records

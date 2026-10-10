"""매뉴얼 조회 CLI — 터미널에서 SDM 원문·규칙·생성 사례를 본다.

    python3 scripts/manual_lookup.py status
    python3 scripts/manual_lookup.py search MOV            # 절 목록 + 본문 일치
    python3 scripts/manual_lookup.py show MOV              # 니모닉이 들어간 절 전부: 쪽, 추출 상태, 소제목, 형식 표 행
    python3 scripts/manual_lookup.py show MOV --part Description   # 소제목 원문만
    python3 scripts/manual_lookup.py show MOV --text       # 절 전체 원문
    python3 scripts/manual_lookup.py page 731              # 파일 쪽 원문
    python3 scripts/manual_lookup.py general [--tables]    # 총론 제목·표 목록
    python3 scripts/manual_lookup.py symbols [r/m8|SYM027] [--full]  # 총론 표기 정의(원문)
    python3 scripts/manual_lookup.py cases MOV [--opcode "88 /r"]  # 생성 사례와 도구별 판정

쪽 번호는 'PDF 파일 쪽 / 인쇄 쪽'을 함께 적는다. 원본 확인은 PDF 뷰어에서 파일 쪽으로 연다.
색인이 없거나 PDF가 바뀌었으면 먼저 `~/pdftools_venv/bin/python scripts/build_manual_index.py`.
"""

import argparse
import os
import sys
import textwrap

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from pipeline import manual_lookup  # noqa: E402

RAW = "[원문]"


def page_label(index, file_page):
    printed = index.pages_by_number[file_page]["printed_page"] if file_page in index.pages_by_number else ""
    return "파일 %d쪽 / 인쇄 %s" % (file_page, printed or "번호 없음")


def need_index(data):
    if data.index is None:
        print("색인을 쓸 수 없다: %s (%s)" % (data.state, data.detail.get("reason", "")))
        print("먼저 실행: ~/pdftools_venv/bin/python scripts/build_manual_index.py")
        return False
    return True


# ------------------------------------------------------------ 명령

def cmd_status(data, args):
    print("색인 상태: %s" % data.state)
    if data.index is None:
        print("이유: %s" % data.detail.get("reason", ""))
        return 1
    m = data.index.manifest
    print("PDF: %s  sha256 %s" % (m["pdf"]["path"], m["pdf"]["sha256"]))
    print("색인 규칙 %s, 생성 %s, %d쪽, 절 %d(명령 절 %d), 꼬리말 없는 쪽 %d"
          % (m["index_revision"], m["built_at"], m["page_count"], m["section_count"],
             m["instruction_section_count"], m["pages_without_footer"]))
    print("총론 표기 정의: %d개 (%s)" % (len(data.symbols()), os.path.relpath(manual_lookup.SYMBOLS_CSV, manual_lookup.ROOT)))
    return 0


def cmd_search(data, args):
    if not need_index(data):
        return 1
    found = data.find_sections(args.query)
    print("명령어 절 %d개" % len(found))
    if not found:
        print("  일치하는 명령어 절이 없다.")
    for kind, s in found:
        mark = "=" if kind == "exact" else "~"
        print("  %s %-8s %s  (%s ~ 파일 %d쪽, %d쪽 분량)"
              % (mark, s["section_id"], s["title"], page_label(data.index, s["first_page"]),
                 s["last_page"], len(s["pages"])))
    hits = data.index.search_text(args.query, limit=args.limit)
    more = " (앞 %d개만)" % args.limit if len(hits) >= args.limit else ""
    print("\n본문 일치 %d개%s" % (len(hits), more))
    if not hits:
        print("  본문에서 찾지 못했다.")
    for h in hits:
        print("  파일 %4d쪽 [%s] %s" % (h["file_page"], (h["section_title"] or "절 없음")[:30], h["line"][:110]))
    return 0


def pick_sections(data, query):
    """절 ID(s0257)나 니모닉. 니모닉은 정확히 일치하는 절 전부를 돌려준다."""
    if query in data.index.sections_by_id:
        return [data.index.sections_by_id[query]]
    return data.index.sections_for_mnemonic(query)


def print_section(data, s, args):
    index = data.index
    print("=" * 100)
    print("%s %s  %s" % (s["section_id"], s["title"], RAW))
    print("권 %s, %s ~ 파일 %d쪽 (%d쪽 분량)"
          % (s["volume"], page_label(index, s["first_page"]), s["last_page"], len(s["pages"])))
    rows = data.isa_rows_for(s)
    notes = data.extraction_notes(s, rows)
    print("\n추출 상태:")
    for note in notes or ["표시할 불완전 지점 없음 (자동 검사 범위 안에서)"]:
        print("  - " + note)
    print("\n소제목:")
    if not s["subsections"]:
        print("  찾은 소제목이 없다")
    for x in s["subsections"]:
        print("  - %-35s 파일 %d쪽" % (x["title"], x["file_page"]))
    print("\n추출된 형식 표 행 (data/db/isa_db.csv, %d개):" % len(rows))
    for r in rows:
        print("  %-22s %-34s %-4s %-8s %s" % (r["opcode"], r["instruction"], r["op_en"],
                                             r["mode_support"], r["description"][:40]))
    if args.part:
        pieces = manual_lookup.subsection_text(index, s, args.part)
        print("\n--- %s %s ---" % (args.part, RAW))
        if not pieces:
            print("이 절에서 '%s' 소제목을 찾지 못했다." % args.part)
        for file_page, lines in pieces:
            print("[%s]" % page_label(index, file_page))
            print("\n".join(lines))
    if args.text:
        for file_page in s["pages"]:
            record = index.pages_by_number[file_page]
            extra = " — 꼬리말 없음, 앞 절에 이어 붙임" if record.get("section_inherited") else ""
            print("\n--- %s%s %s ---" % (page_label(index, file_page), extra, RAW))
            print("\n".join(record["lines"]))


def cmd_show(data, args):
    if not need_index(data):
        return 1
    sections = pick_sections(data, args.query)
    if not sections:
        print("'%s'와 정확히 일치하는 명령어 절이 없다. search로 부분 일치를 찾아본다." % args.query)
        return 1
    if len(sections) > 1:
        print("'%s'가 들어간 절 %d개를 모두 보여준다: %s"
              % (args.query, len(sections), ", ".join(s["title"] for s in sections)))
    for s in sections:
        print_section(data, s, args)
    return 0


def cmd_page(data, args):
    if not need_index(data):
        return 1
    record = data.index.pages_by_number.get(args.number)
    if record is None:
        print("파일 %d쪽은 없다 (1~%d)." % (args.number, len(data.index.pages)))
        return 1
    print("%s  절: %s  %s" % (page_label(data.index, args.number), record.get("section_title") or "없음", RAW))
    if record["flags"]:
        print("추출 표시: %s" % ", ".join(record["flags"]))
    print("-" * 100)
    print("\n".join(record["lines"]))
    return 0


def cmd_general(data, args):
    if not need_index(data):
        return 1
    general = data.index.general
    for h in general["headings"]:
        print("%-10s %-75s 파일 %3d쪽 / %s" % (h["number"], h["title"][:75], h["file_page"], h["printed_page"] or "-"))
    if args.tables:
        print()
        for t in general["tables"]:
            print("%-11s %-75s 파일 %3d쪽" % (t["label"], t["title"][:75], t["file_page"]))
    return 0


def cmd_symbols(data, args):
    """총론 3.1.1.1~3.1.1.5 표기 정의. 원문 그대로이며 해석은 없다."""
    rows = data.symbols()
    if args.symbol:
        wanted = args.symbol.lower()
        rows = [r for r in rows if r["symbol_id"].lower() == wanted
                or wanted in [n.strip().lower() for n in r["symbol"].replace(" or ", ",").split(",")]]
        if not rows:
            print("'%s' 정의가 총론 3.1.1.1~3.1.1.5에 없다." % args.symbol)
            return 1
    print("총론 표기 정의 %d개 %s" % (len(rows), RAW))
    for r in rows:
        print("\n%s  %s  (파일 %s쪽 / 인쇄 %s, %s)" % (r["symbol_id"], r["symbol"], r["file_pages"],
                                                     r["printed_page"] or "-", r["section"]))
        if args.symbol or args.full:
            print(textwrap.fill(r["source_text"], 100, initial_indent="  ", subsequent_indent="  "))
    return 0


def cmd_cases(data, args):
    cases = data.cases_for(args.mnemonic, args.opcode)
    print("생성 사례·판정: %s (저장된 결과, 새 실행이 아니다)" % os.path.relpath(manual_lookup.CASES_SNAPSHOT, manual_lookup.ROOT))
    print("%d개" % len(cases))
    if not cases:
        print("  생성 사례가 없다.")
    for c in cases:
        print("\n  %s  %s | %s" % (c["case_id"], c["opcode"], c["instruction"]))
        print("    소스: %s   SDM 기대: %s" % (c["source"], c["expected"]))
        print("    근거: %s" % c["evidence"])
        check = c["check"]
        if not check:
            print("    판정 없음(python3 pipeline/m3_check.py)")
            continue
        for tool in ("as", "clang"):
            print("    %-5s %s  %s %s" % (tool, check["verdict_" + tool], check["bytes_" + tool] or "-",
                                       check["tested_source_" + tool] if check["tested_source_" + tool] != c["source"] else ""))
    return 0


def main(argv=None):
    parser = argparse.ArgumentParser(description="SDM 매뉴얼 조회 (터미널)")
    sub = parser.add_subparsers(dest="command", required=True)
    sub.add_parser("status")
    p = sub.add_parser("search")
    p.add_argument("query")
    p.add_argument("--limit", type=int, default=30)
    p = sub.add_parser("show")
    p.add_argument("query", help="니모닉 또는 절 ID(s0257)")
    p.add_argument("--part", help="소제목 하나의 원문만 (예: Description, Operation, NOTES:)")
    p.add_argument("--text", action="store_true", help="절 전체 원문")
    p = sub.add_parser("page")
    p.add_argument("number", type=int, help="PDF 파일 쪽 번호")
    p = sub.add_parser("general")
    p.add_argument("--tables", action="store_true")
    p = sub.add_parser("symbols")
    p.add_argument("symbol", nargs="?", help="기호(r/m8) 또는 ID(SYM027)")
    p.add_argument("--full", action="store_true", help="모든 정의의 원문까지")
    p = sub.add_parser("cases")
    p.add_argument("mnemonic")
    p.add_argument("--opcode")
    args = parser.parse_args(argv)

    data = manual_lookup.ManualData()
    handler = {"status": cmd_status, "search": cmd_search, "show": cmd_show, "page": cmd_page,
               "general": cmd_general, "symbols": cmd_symbols, "cases": cmd_cases}[args.command]
    return handler(data, args)


if __name__ == "__main__":
    raise SystemExit(main())

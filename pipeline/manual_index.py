"""매뉴얼 색인 — intel_manual.pdf 원문을 한 번 추출해 조회용으로 저장한다.

이 모듈은 PDF 원문(페이지 텍스트, 절 구분, 페이지 번호)만 다룬다.
규칙 해석이나 명령어 판정은 하지 않는다. 해석은 data/rules/ 와 검토 문서가 맡는다.

페이지 번호는 두 가지를 모두 기록한다.
  - file_page: PDF 파일의 1-based 페이지 번호 (isa_db.csv의 source_page와 같은 기준)
  - printed_page: 페이지 하단에 인쇄된 번호 ("4-28" 등)

PDF가 바뀌면 색인은 무효다. manifest.json에 PDF의 sha256을 적어 두고
index_state()로 확인한다.
"""

import hashlib
import json
import os
import re

PDF_PATH = "intel_manual.pdf"
INDEX_DIR = "out/manual_index"
INDEX_REVISION = "manual-index-v3"

# 명령어 레퍼런스 본문이 시작하는 파일 페이지(1-based). m1_extract.py의 범위와 같은 기준이다.
INSTR_REF_START = 119
INSTR_REF_END = 2393

# 페이지 하단 꼬리말. 홀수/짝수 쪽에서 제목과 번호의 좌우가 바뀐다.
#   "MOV—Move Vol. 2B 4-28"  /  "2-70 Vol. 2A"
FOOTER_TITLE_FIRST = re.compile(
    r"^(?P<title>.*?)\s*Vol\.\s*(?P<volume>2[A-D])\s+(?P<printed>[A-Z0-9]+-\d+)$"
)
FOOTER_PAGE_FIRST = re.compile(
    r"^(?P<printed>[A-Z0-9]+-\d+)\s+Vol\.\s*(?P<volume>2[A-D])\s*(?P<title>.*)$"
)

# 절 제목의 니모닉과 설명을 가르는 줄표. 일반 하이픈은 니모닉 안에도 쓰여서 제외한다.
TITLE_DASH = re.compile(r"\s*[—–]\s*")

# 니모닉으로 볼 수 있는 토큰. CMOVcc, Jcc, SETcc 처럼 소문자 꼬리가 붙는 것도 받는다.
MNEMONIC_TOKEN = re.compile(r"^[A-Z][A-Za-z0-9_]*$")

# 명령어 절 안에서 쓰이는 소제목. 이 목록에 없는 제목은 알 수 없는 소제목으로 표시한다.
SUBSECTION_TITLES = [
    "Instruction Operand Encoding",
    "Description",
    "Operation",
    "Flags Affected",
    "FPU Flags Affected",
    "Intel C/C++ Compiler Intrinsic Equivalent",
    "Intel C/C++ Compiler Intrinsic Equivalents",
    "C/C++ Compiler Intrinsic Equivalent",
    "SIMD Floating-Point Exceptions",
    "Floating-Point Exceptions",
    "Numeric Exceptions",
    "Protected Mode Exceptions",
    "Real-Address Mode Exceptions",
    "Virtual-8086 Mode Exceptions",
    "Compatibility Mode Exceptions",
    "64-Bit Mode Exceptions",
    "Exceptions (All Operating Modes)",
    "Exceptions (All Modes)",
    "Other Exceptions",
    "NOTES:",
    "NOTE:",
]

# 총론(1~3장)에서 뽑는 번호 붙은 제목과 표 제목.
NUMBERED_HEADING = re.compile(r"^(?P<number>\d+(?:\.\d+)+)\s+(?P<title>\S.{1,90})$")
TABLE_CAPTION = re.compile(r"^(?P<label>Table\s+\d+-\d+)\.\s*(?P<title>\S.{1,90})$")
FIGURE_CAPTION = re.compile(r"^(?P<label>Figure\s+\d+-\d+)\.\s*(?P<title>\S.{1,90})$")


# ---------------------------------------------------------------- PDF 지문

def pdf_fingerprint(pdf_path=PDF_PATH):
    """PDF 파일의 해시와 크기를 돌려준다. 색인 무효화 판단에 쓴다."""
    digest = hashlib.sha256()
    with open(pdf_path, "rb") as handle:
        for chunk in iter(lambda: handle.read(1 << 20), b""):
            digest.update(chunk)
    return {
        "path": pdf_path,
        "sha256": digest.hexdigest(),
        "bytes": os.path.getsize(pdf_path),
    }


def index_state(index_dir=INDEX_DIR, pdf_path=PDF_PATH):
    """색인이 현재 PDF와 맞는지 확인한다. 'current' / 'stale' / 'missing' 중 하나."""
    manifest_path = os.path.join(index_dir, "manifest.json")
    if not os.path.exists(manifest_path):
        return "missing", {"reason": "색인이 없다", "index_dir": index_dir}
    manifest = read_json(manifest_path)
    if not os.path.exists(pdf_path):
        return "stale", {"reason": "PDF 파일이 없다", "pdf_path": pdf_path}
    current = pdf_fingerprint(pdf_path)
    if current["sha256"] != manifest.get("pdf", {}).get("sha256"):
        return "stale", {
            "reason": "PDF 해시가 색인과 다르다",
            "index_sha256": manifest.get("pdf", {}).get("sha256"),
            "pdf_sha256": current["sha256"],
        }
    if manifest.get("index_revision") != INDEX_REVISION:
        return "stale", {
            "reason": "색인 생성 규칙 버전이 다르다",
            "index_revision": manifest.get("index_revision"),
            "current_revision": INDEX_REVISION,
        }
    return "current", {"manifest": manifest}


# ---------------------------------------------------------------- 꼬리말/제목 파싱

def parse_footer(line):
    """꼬리말 한 줄에서 절 제목·권·인쇄 페이지를 뽑는다. 아니면 None."""
    text = (line or "").strip()
    if "Vol." not in text:
        return None
    for regex in (FOOTER_TITLE_FIRST, FOOTER_PAGE_FIRST):
        matched = regex.match(text)
        if matched:
            return {
                "footer_title": matched.group("title").strip(),
                "volume": matched.group("volume"),
                "printed_page": matched.group("printed"),
            }
    return None


def find_footer(lines):
    """페이지의 마지막 3줄에서 꼬리말을 찾는다. 찾은 줄 번호도 같이 준다."""
    for offset in range(1, 4):
        if len(lines) < offset:
            break
        parsed = parse_footer(lines[-offset])
        if parsed:
            parsed["footer_line_from_end"] = offset
            return parsed
    return None


def split_section_title(title):
    """'MOV—Move to/from Control Registers' -> (['MOV'], 'Move to/from Control Registers')

    줄표가 없는 제목(장 제목 등)은 니모닉이 없는 것으로 본다.
    """
    text = (title or "").strip()
    if not text:
        return [], ""
    parts = TITLE_DASH.split(text, maxsplit=1)
    if len(parts) != 2:
        return [], text
    left, right = parts[0].strip(), parts[1].strip()
    mnemonics = []
    for token in left.split("/"):
        token = token.strip()
        if token and MNEMONIC_TOKEN.match(token):
            mnemonics.append(token)
    if not mnemonics:
        return [], text
    return mnemonics, right


def printed_chapter(printed_page):
    """'4-28' -> '4', 'INDEX-7' -> 'INDEX'."""
    if not printed_page or "-" not in printed_page:
        return ""
    return printed_page.split("-", 1)[0]


# ---------------------------------------------------------------- 페이지 추출

def page_flags(lines, footer, file_page, table_pages):
    """이 페이지의 추출 상태를 표시한다. 불완전한 곳을 감추지 않는다."""
    flags = []
    if not lines:
        flags.append("no_text")
    if footer is None:
        flags.append("no_footer")
    symbol_only = [line for line in lines if line.strip() and not re.search(r"[0-9A-Za-z]", line)]
    if symbol_only:
        flags.append("symbol_only_lines:%d" % len(symbol_only))
    if file_page in table_pages:
        flags.append("encoding_table_page")
    return flags


def load_table_mnemonics(isa_db_path="data/db/isa_db.csv"):
    """isa_db.csv의 쪽별 니모닉. 제목이 묶음 표기(예: 'VF[,N]MADD[132,213,231]PH')라
    니모닉을 뽑지 못한 절도 그 쪽의 표 행으로 연결한다."""
    import csv

    by_page = {}
    if not os.path.exists(isa_db_path):
        return by_page
    with open(isa_db_path, encoding="utf-8") as handle:
        for row in csv.DictReader(handle):
            try:
                by_page.setdefault(int(row["source_page"]), set()).add(row["mnemonic"].upper())
            except (KeyError, TypeError, ValueError):
                continue
    return by_page


def attach_table_mnemonics(sections, by_page):
    for section in sections:
        names = set()
        for file_page in section["pages"]:
            names |= by_page.get(file_page, set())
        section["table_mnemonics"] = sorted(names)
        if names and section["first_page"] >= INSTR_REF_START and not section["is_instruction_section"]:
            section["is_instruction_section"] = True
            section["title_mnemonics_unparsed"] = True


def load_table_pages(isa_db_path="data/db/isa_db.csv"):
    """isa_db.csv가 인코딩 표를 찾아낸 페이지 집합. 교차 확인용이다."""
    import csv

    pages = set()
    if not os.path.exists(isa_db_path):
        return pages
    with open(isa_db_path, encoding="utf-8") as handle:
        for row in csv.DictReader(handle):
            try:
                pages.add(int(row["source_page"]))
            except (KeyError, TypeError, ValueError):
                continue
    return pages


def extract_pages(pdf_path=PDF_PATH, table_pages=None, progress=None):
    """PDF의 모든 페이지에서 텍스트와 꼬리말을 뽑는다."""
    import pdfplumber

    table_pages = table_pages or set()
    pages = []
    with pdfplumber.open(pdf_path) as pdf:
        for zero_based, page in enumerate(pdf.pages):
            file_page = zero_based + 1
            text = page.extract_text() or ""
            lines = [line.rstrip() for line in text.split("\n")] if text else []
            footer = find_footer(lines)
            record = {
                "file_page": file_page,
                "printed_page": footer["printed_page"] if footer else "",
                "volume": footer["volume"] if footer else "",
                "footer_title": footer["footer_title"] if footer else "",
                "head_line": lines[0].strip() if lines else "",
                "lines": lines,
                "flags": page_flags(lines, footer, file_page, table_pages),
            }
            pages.append(record)
            # 페이지 객체를 닫지 않으면 2,500여 쪽의 레이아웃 캐시가 메모리에 쌓인다.
            page.close()
            if progress and file_page % 100 == 0:
                progress(file_page, len(pdf.pages))
    return pages


def resolve_sections(pages):
    """꼬리말 제목이 같은 연속 페이지를 한 절로 묶는다.

    꼬리말이 없는 페이지는 바로 앞 절에 이어 붙이고 inherited로 표시한다.
    """
    sections = []
    current = None
    for record in pages:
        title = record["footer_title"]
        if not title and record["printed_page"]:
            # 꼬리말은 있는데 제목이 없는 쪽(장 시작, 총론, 부록). 앞 명령어 절에 붙이지 않는다.
            title = "(제목 없는 꼬리말) Vol. %s %s장" % (
                record["volume"], printed_chapter(record["printed_page"]))
        if not title and current is not None:
            record["section_title"] = current["title"]
            record["section_inherited"] = True
            current["pages"].append(record["file_page"])
            current["inherited_pages"].append(record["file_page"])
            continue
        record["section_inherited"] = False
        record["section_title"] = title
        if current is not None and current["title"] == title:
            current["pages"].append(record["file_page"])
            continue
        mnemonics, summary = split_section_title(title)
        current = {
            "section_id": "s%04d" % (len(sections) + 1),
            "title": title,
            "mnemonics": mnemonics,
            "summary": summary,
            "pages": [record["file_page"]],
            "inherited_pages": [],
            "volume": record["volume"],
            "printed_first": record["printed_page"],
        }
        sections.append(current)
    for section in sections:
        section["first_page"] = section["pages"][0]
        section["last_page"] = section["pages"][-1]
        section["printed_chapter"] = printed_chapter(section["printed_first"])
        section["is_instruction_section"] = bool(
            section["mnemonics"] and section["first_page"] >= INSTR_REF_START
        )
    for record in pages:
        record.setdefault("section_title", "")
        record.setdefault("section_inherited", False)
    mark_repeated_titles(sections)
    return sections


def mark_repeated_titles(sections):
    """같은 제목이 떨어진 페이지 묶음에 다시 나오면 표시한다(나뉜 절일 수 있다)."""
    seen = {}
    for section in sections:
        seen.setdefault(section["title"], []).append(section["section_id"])
    for section in sections:
        others = [sid for sid in seen[section["title"]] if sid != section["section_id"]]
        section["same_title_sections"] = others


def find_subsections(pages_by_number, section):
    """명령어 절 안의 소제목 위치를 찾는다. 목록에 없는 제목은 unknown으로 둔다."""
    found = []
    known = {title.lower(): title for title in SUBSECTION_TITLES}
    for file_page in section["pages"]:
        record = pages_by_number.get(file_page)
        if not record:
            continue
        for line_index, line in enumerate(record["lines"]):
            stripped = line.strip()
            if not stripped or len(stripped) > 60:
                continue
            title = known.get(stripped.lower())
            if title:
                found.append(
                    {
                        "title": title,
                        "file_page": file_page,
                        "line_index": line_index,
                        "known": True,
                    }
                )
    return found


def build_general_outline(pages):
    """총론(1~3장)의 번호 붙은 제목과 표·그림 제목을 색인한다."""
    headings, tables, figures = [], [], []
    for record in pages:
        if record["file_page"] >= INSTR_REF_START:
            continue
        chapter = printed_chapter(record["printed_page"])
        for line in record["lines"]:
            stripped = line.strip()
            matched = NUMBERED_HEADING.match(stripped)
            if matched and not stripped.endswith("."):
                headings.append(
                    {
                        "number": matched.group("number"),
                        "title": matched.group("title").strip(),
                        "file_page": record["file_page"],
                        "printed_page": record["printed_page"],
                        "volume": record["volume"],
                        "chapter": chapter,
                    }
                )
                continue
            matched = TABLE_CAPTION.match(stripped)
            if matched:
                tables.append(
                    {
                        "label": matched.group("label"),
                        "title": matched.group("title").strip(),
                        "file_page": record["file_page"],
                        "printed_page": record["printed_page"],
                    }
                )
                continue
            matched = FIGURE_CAPTION.match(stripped)
            if matched:
                figures.append(
                    {
                        "label": matched.group("label"),
                        "title": matched.group("title").strip(),
                        "file_page": record["file_page"],
                        "printed_page": record["printed_page"],
                    }
                )
    return {"headings": headings, "tables": tables, "figures": figures}


# ---------------------------------------------------------------- 색인 쓰기/읽기

def load_saved_pages(index_dir, pdf_path):
    """같은 PDF에서 이미 추출한 페이지 원문을 다시 쓴다. PDF 해시가 다르면 None."""
    manifest_path = os.path.join(index_dir, "manifest.json")
    pages_path = os.path.join(index_dir, "pages.jsonl")
    if not (os.path.exists(manifest_path) and os.path.exists(pages_path)):
        return None
    manifest = read_json(manifest_path)
    if manifest.get("pdf", {}).get("sha256") != pdf_fingerprint(pdf_path)["sha256"]:
        return None
    pages = []
    with open(pages_path, encoding="utf-8") as handle:
        for line in handle:
            record = json.loads(line)
            # 절 구분은 다시 계산한다. 추출 원문과 꼬리말만 남긴다.
            record.pop("section_title", None)
            record.pop("section_inherited", None)
            pages.append(record)
    return pages


def build_index(pdf_path=PDF_PATH, index_dir=INDEX_DIR, progress=None, reuse_pages=False):
    """PDF에서 색인을 만들어 index_dir에 저장한다.

    reuse_pages=True면 같은 해시의 PDF에서 저장해 둔 페이지 원문으로 절만 다시 나눈다.
    """
    import datetime

    os.makedirs(index_dir, exist_ok=True)
    table_pages = load_table_pages()
    pages = load_saved_pages(index_dir, pdf_path) if reuse_pages else None
    reused = pages is not None
    if pages is None:
        pages = extract_pages(pdf_path, table_pages=table_pages, progress=progress)
    sections = resolve_sections(pages)
    attach_table_mnemonics(sections, load_table_mnemonics())
    pages_by_number = {record["file_page"]: record for record in pages}
    for section in sections:
        if section["is_instruction_section"]:
            section["subsections"] = find_subsections(pages_by_number, section)
        else:
            section["subsections"] = []
    general = build_general_outline(pages)

    with open(os.path.join(index_dir, "pages.jsonl"), "w", encoding="utf-8") as handle:
        for record in pages:
            handle.write(json.dumps(record, ensure_ascii=False) + "\n")
    with open(os.path.join(index_dir, "sections.json"), "w", encoding="utf-8") as handle:
        json.dump(sections, handle, ensure_ascii=False, indent=1)
    with open(os.path.join(index_dir, "general.json"), "w", encoding="utf-8") as handle:
        json.dump(general, handle, ensure_ascii=False, indent=1)

    manifest = {
        "index_revision": INDEX_REVISION,
        "built_at": datetime.datetime.now().isoformat(timespec="seconds"),
        "pdf": pdf_fingerprint(pdf_path),
        "page_count": len(pages),
        "section_count": len(sections),
        "instruction_section_count": sum(1 for s in sections if s["is_instruction_section"]),
        "pages_without_footer": sum(1 for p in pages if "no_footer" in p["flags"]),
        "pages_without_text": sum(1 for p in pages if "no_text" in p["flags"]),
        "general_heading_count": len(general["headings"]),
        "pages_reused_from_previous_extraction": reused,
    }
    manifest["pdf"]["page_count"] = len(pages)
    with open(os.path.join(index_dir, "manifest.json"), "w", encoding="utf-8") as handle:
        json.dump(manifest, handle, ensure_ascii=False, indent=1)
    return manifest


def read_json(path):
    with open(path, encoding="utf-8") as handle:
        return json.load(handle)


class ManualIndex:
    """저장된 색인을 메모리에 올려 조회한다."""

    def __init__(self, index_dir=INDEX_DIR):
        self.index_dir = index_dir
        self.manifest = read_json(os.path.join(index_dir, "manifest.json"))
        self.sections = read_json(os.path.join(index_dir, "sections.json"))
        self.general = read_json(os.path.join(index_dir, "general.json"))
        self.pages = []
        with open(os.path.join(index_dir, "pages.jsonl"), encoding="utf-8") as handle:
            for line in handle:
                self.pages.append(json.loads(line))
        self.pages_by_number = {record["file_page"]: record for record in self.pages}
        self.sections_by_id = {section["section_id"]: section for section in self.sections}

    def page_text(self, file_page):
        record = self.pages_by_number.get(file_page)
        return "\n".join(record["lines"]) if record else ""

    def sections_for_mnemonic(self, mnemonic):
        """니모닉이 들어간 모든 명령어 절. 같은 니모닉의 여러 절을 다 돌려준다."""
        wanted = (mnemonic or "").strip().upper()
        hits = []
        for section in self.sections:
            if not section["is_instruction_section"]:
                continue
            names = [name.upper() for name in section["mnemonics"]] + section.get("table_mnemonics", [])
            if wanted in names:
                hits.append(section)
        return hits

    def sections_matching(self, query):
        """니모닉 부분 일치 + 절 제목 부분 일치."""
        needle = (query or "").strip().lower()
        if not needle:
            return []
        hits = []
        for section in self.sections:
            if not section["is_instruction_section"]:
                continue
            names = " ".join(section["mnemonics"]).lower()
            if needle in names or needle in section["title"].lower():
                hits.append(section)
        return hits

    def search_text(self, query, limit=100):
        """페이지 본문 문자열 검색. 대소문자는 무시한다."""
        needle = (query or "").strip().lower()
        if not needle:
            return []
        hits = []
        for record in self.pages:
            for line_index, line in enumerate(record["lines"]):
                if needle in line.lower():
                    hits.append(
                        {
                            "file_page": record["file_page"],
                            "printed_page": record["printed_page"],
                            "section_title": record.get("section_title", ""),
                            "line_index": line_index,
                            "line": line.strip(),
                        }
                    )
                    if len(hits) >= limit:
                        return hits
        return hits

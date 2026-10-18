"""매뉴얼 조회 — 색인·추출 DB·규칙·생성 사례·저장 관측을 묶어 돌려준다.

출력 형식은 scripts/manual_lookup.py(터미널)가 맡는다. 여기서는 값만 만든다.
원문만 다룬다. 총론 표기 정의도 원문 그대로(data/rules/sdm_symbols.csv)이며 해석 열은 없다.
"""

import csv
import os

from pipeline import manual_index

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ISA_DB = os.path.join(ROOT, "data/db/isa_db.csv")
# 총론 표기 정의(원문 그대로). 이전 해석 규칙(common_rules.csv)은 2026-10-09 사용자 결정으로 폐기했다.
SYMBOLS_CSV = os.path.join(ROOT, "data/rules/sdm_symbols.csv")
# 생성 사례(2단계 m2_generate)와 도구별 판정(3단계 m3_check). 저장된 결과이며 조회할 때 새로 실행하지 않는다.
CASES_SNAPSHOT = os.path.join(ROOT, "out/cases")


def read_csv(path):
    if not os.path.exists(path):
        return []
    with open(path, encoding="utf-8", newline="") as handle:
        return list(csv.DictReader(handle))


def subsection_text(index, section, title):
    """명령 절 안에서 소제목 하나의 원문을 잘라 온다. 다음 소제목 직전까지다.

    돌려주는 값: [(file_page, [줄...]), ...]. 소제목이 없으면 빈 목록.
    """
    marks = section.get("subsections", [])
    wanted = title.strip().lower()
    for position, mark in enumerate(marks):
        if mark["title"].lower() != wanted:
            continue
        end = marks[position + 1] if position + 1 < len(marks) else None
        pieces = []
        for file_page in section["pages"]:
            if file_page < mark["file_page"]:
                continue
            if end and file_page > end["file_page"]:
                break
            lines = index.pages_by_number[file_page]["lines"]
            start_line = mark["line_index"] if file_page == mark["file_page"] else 0
            stop_line = end["line_index"] if end and file_page == end["file_page"] else len(lines)
            if stop_line > start_line:
                pieces.append((file_page, lines[start_line:stop_line]))
        return pieces
    return []


class ManualData:
    """색인·추출 DB·규칙·생성 사례·저장 판정을 한 번만 읽어 둔다."""

    def __init__(self, index_dir=None, pdf_path=None):
        self.index_dir = index_dir or os.path.join(ROOT, manual_index.INDEX_DIR)
        self.pdf_path = pdf_path or os.path.join(ROOT, manual_index.PDF_PATH)
        self.state, self.detail = manual_index.index_state(self.index_dir, self.pdf_path)
        self.index = manual_index.ManualIndex(self.index_dir) if self.state == "current" else None
        self._isa_rows = None
        self._cases = None
        self._observations = None

    # 필요할 때만 읽는다. 사례 파일은 수십 MB라 조회마다 읽으면 느리다.
    @property
    def isa_rows(self):
        if self._isa_rows is None:
            self._isa_rows = read_csv(ISA_DB)
        return self._isa_rows

    @property
    def cases(self):
        if self._cases is None:
            self._cases = read_csv(os.path.join(CASES_SNAPSHOT, "cases.csv"))
        return self._cases

    @property
    def observations(self):
        """저장된 도구별 판정. case_id -> 판정 행. 새 실행이 아니다."""
        if self._observations is None:
            self._observations = {row["case_id"]: row for row in read_csv(os.path.join(CASES_SNAPSHOT, "check_results.csv"))}
        return self._observations

    def symbols(self):
        return read_csv(SYMBOLS_CSV)

    def find_sections(self, query):
        """정확한 니모닉 일치를 먼저, 그다음 니모닉/제목 부분 일치. (일치 종류, 절) 목록."""
        exact = self.index.sections_for_mnemonic(query)
        exact_ids = {s["section_id"] for s in exact}
        partial = [s for s in self.index.sections_matching(query) if s["section_id"] not in exact_ids]
        return [("exact", s) for s in exact] + [("partial", s) for s in partial]

    def isa_rows_for(self, section):
        """같은 절(페이지 범위)의 추출 표 행만 돌려준다."""
        # 묶음 제목 절(SETcc, VF[,N]MADD... 등)은 제목에서 니모닉을 못 뽑으므로 그 쪽 표 행의 니모닉도 쓴다.
        names = {name.upper() for name in section["mnemonics"]} | set(section.get("table_mnemonics", []))
        page_set = set(section["pages"])
        hits = []
        for row in self.isa_rows:
            try:
                page = int(row["source_page"])
            except (TypeError, ValueError):
                continue
            if page in page_set and row["mnemonic"].upper() in names:
                hits.append(row)
        return hits

    def extraction_notes(self, section, rows):
        """추출이 불완전할 수 있는 지점. 조용히 넘기지 않는다."""
        notes = []
        if section["inherited_pages"]:
            notes.append("꼬리말이 없어 앞 절에서 이어 붙인 쪽: %s"
                         % ", ".join(str(p) for p in section["inherited_pages"]))
        if section["same_title_sections"]:
            notes.append("같은 제목의 다른 쪽 묶음: %s" % ", ".join(section["same_title_sections"]))
        for file_page in section["pages"]:
            flags = self.index.pages_by_number[file_page]["flags"]
            symbol = [f for f in flags if f.startswith("symbol_only_lines")]
            if symbol:
                notes.append("파일 %d쪽: 기호만 있는 줄이 있다(표·수식 추출 불완전 가능, %s)"
                             % (file_page, symbol[0].split(":")[1] + "줄"))
            if "no_text" in flags:
                notes.append("파일 %d쪽: 텍스트가 추출되지 않았다" % file_page)
        if not rows:
            notes.append("이 절에서 추출된 형식 표 행(isa_db.csv)이 없다")
        return notes

    def cases_for(self, mnemonic, opcode=None):
        """생성된 입력 사례와 저장된 과거 관측. 새 실행이 아니다."""
        wanted = (mnemonic or "").upper()
        hits = []
        for row in self.cases:
            if row["mnemonic"].upper() != wanted:
                continue
            if opcode and row["opcode"] != opcode:
                continue
            hits.append({
                "case_id": row["case_id"], "opcode": row["opcode"], "instruction": row["instruction"],
                "source": row["source"], "expected": row["expected"], "evidence": row["evidence"],
                "check": self.observations.get(row["case_id"]),
            })
        return hits

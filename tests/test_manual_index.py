"""매뉴얼 색인·조회 회귀 검사.

기대값은 색인 코드가 아니라 PDF 원문(파일 731~734쪽 MOV—Move, 총론 2.2.1 등)을 직접 읽고 정했다.
실제 색인(out/manual_index)이 없거나 현재 PDF와 맞지 않으면 그 부분은 건너뛴다.
"""

import csv
import json
import os
import shutil
import sys
import tempfile
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline import manual_index  # noqa: E402

INDEX_DIR = os.path.join(ROOT, manual_index.INDEX_DIR)
PDF = os.path.join(ROOT, manual_index.PDF_PATH)


def page(file_page, lines, title="", printed="", volume="2B"):
    return {"file_page": file_page, "printed_page": printed, "volume": volume,
            "footer_title": title, "head_line": lines[0] if lines else "", "lines": lines, "flags": []}


class FooterAndTitleTest(unittest.TestCase):
    def test_odd_and_even_footer(self):
        self.assertEqual(manual_index.parse_footer("MOV—Move Vol. 2B 4-28"),
                         {"footer_title": "MOV—Move", "volume": "2B", "printed_page": "4-28"})
        self.assertEqual(manual_index.parse_footer("2-70 Vol. 2A")["printed_page"], "2-70")
        self.assertIsNone(manual_index.parse_footer("Move r8 to r/m8."))

    def test_shared_and_plain_titles(self):
        self.assertEqual(manual_index.split_section_title("MOVS/MOVSB/MOVSW/MOVSD/MOVSQ—Move Data")[0],
                         ["MOVS", "MOVSB", "MOVSW", "MOVSD", "MOVSQ"])
        # 일반 하이픈은 제목 구분자가 아니다.
        self.assertEqual(manual_index.split_section_title("INSTRUCTION SET REFERENCE, A-L")[0], [])

    def test_untitled_footer_does_not_join_previous_instruction(self):
        pages = [
            page(700, ["a"], "LZCNT—Count", "3-600", "2A"),
            page(701, ["b"], "", "4-1"),          # 장 시작: 꼬리말은 있고 제목은 없음
            page(702, ["c"], "", ""),             # 꼬리말 자체가 없음 -> 앞 절에 이어 붙임
        ]
        sections = manual_index.resolve_sections(pages)
        self.assertEqual(sections[0]["pages"], [700])
        self.assertEqual(sections[1]["pages"], [701, 702])
        self.assertEqual(sections[1]["inherited_pages"], [702])
        self.assertFalse(sections[1]["is_instruction_section"])


class IndexInvalidationTest(unittest.TestCase):
    def test_changed_pdf_makes_index_stale(self):
        work = tempfile.mkdtemp()
        try:
            pdf = os.path.join(work, "a.pdf")
            with open(pdf, "wb") as handle:
                handle.write(b"%PDF-1.4 first")
            index_dir = os.path.join(work, "index")
            os.makedirs(index_dir)
            self.assertEqual(manual_index.index_state(index_dir, pdf)[0], "missing")
            manifest = {"index_revision": manual_index.INDEX_REVISION,
                        "pdf": manual_index.pdf_fingerprint(pdf)}
            with open(os.path.join(index_dir, "manifest.json"), "w") as handle:
                json.dump(manifest, handle)
            self.assertEqual(manual_index.index_state(index_dir, pdf)[0], "current")
            with open(pdf, "wb") as handle:
                handle.write(b"%PDF-1.4 changed")
            state, detail = manual_index.index_state(index_dir, pdf)
            self.assertEqual(state, "stale")
            self.assertIn("해시", detail["reason"])
            # 해시가 같아도 색인 규칙 버전이 다르면 무효다.
            manifest["pdf"] = manual_index.pdf_fingerprint(pdf)
            manifest["index_revision"] = "old"
            with open(os.path.join(index_dir, "manifest.json"), "w") as handle:
                json.dump(manifest, handle)
            self.assertEqual(manual_index.index_state(index_dir, pdf)[0], "stale")
        finally:
            shutil.rmtree(work)


@unittest.skipUnless(os.path.exists(PDF) and manual_index.index_state(INDEX_DIR, PDF)[0] == "current",
                     "현재 PDF와 맞는 색인이 없다")
class RealIndexTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.index = manual_index.ManualIndex(INDEX_DIR)

    def test_mov_has_three_sections_and_general_mov_spans_pages(self):
        titles = {s["title"]: s for s in self.index.sections_for_mnemonic("MOV")}
        self.assertEqual(set(titles), {"MOV—Move", "MOV—Move to/from Control Registers",
                                       "MOV—Move to/from Debug Registers"})
        move = titles["MOV—Move"]
        self.assertEqual(move["pages"], [731, 732, 733, 734])
        self.assertEqual(move["printed_first"], "4-28")
        found = [(x["title"], x["file_page"]) for x in move["subsections"]]
        self.assertIn(("NOTES:", 731), found)
        self.assertIn(("Description", 732), found)
        self.assertIn(("Operation", 732), found)
        self.assertIn(("64-Bit Mode Exceptions", 734), found)

    def test_mov_footnote_text_is_kept(self):
        text = self.index.page_text(731)
        self.assertIn("With a REX prefix in 64-bit mode, attempts to access AH, BH, CH, or DH", text)
        # 각주 번호가 기호에 붙어 추출된다. 화면은 원문 그대로 보여준다.
        self.assertIn("MOV r/m81, r81", text)

    def test_shared_section_found_by_each_mnemonic(self):
        for name in ("MOVSB", "MOVSQ"):
            hits = self.index.sections_for_mnemonic(name)
            self.assertEqual(len(hits), 1, name)
            self.assertTrue(hits[0]["title"].startswith("MOVS/MOVSB/MOVSW/MOVSD/MOVSQ"))
        # MOVSD는 문자열 명령과 SSE2 명령의 두 절에 모두 나온다.
        self.assertEqual(len(self.index.sections_for_mnemonic("MOVSD")), 2)

    def test_no_result(self):
        self.assertEqual(self.index.sections_for_mnemonic("NOSUCHOP"), [])
        self.assertEqual(self.index.sections_matching("zzqqxx"), [])
        self.assertEqual(self.index.search_text("zzqqxx"), [])

    def test_general_outline_links(self):
        headings = {(h["number"], h["title"]): h for h in self.index.general["headings"]}
        self.assertEqual(headings[("2.2.1", "REX Prefixes")]["file_page"], 37)
        self.assertEqual(headings[("3.1.1.3", "Instruction Column in the Opcode Summary Table")]["file_page"], 105)
        tables = {t["label"]: t for t in self.index.general["tables"]}
        self.assertEqual(tables["Table 2-7"]["file_page"], 42)

    def test_every_symbol_definition_is_verbatim_from_its_pages(self):
        """sdm_symbols.csv는 원문 그대로다: 항목 원문이 인용한 쪽 원문(공백 무시)에 들어 있어야 한다."""
        path = os.path.join(ROOT, "data/rules/sdm_symbols.csv")
        with open(path, encoding="utf-8") as handle:
            symbols = list(csv.DictReader(handle))
        self.assertGreater(len(symbols), 90)
        self.assertNotIn("interpretation", symbols[0])
        for row in symbols:
            pages = [int(p) for p in row["file_pages"].split(";")]
            joined = "".join("".join(self.index.page_text(p).split()) for p in pages).replace("•", "")
            first_words = "".join(row["source_text"].split())[:60].replace("•", "")
            self.assertIn(first_words, joined, row["symbol_id"])
        by_symbol = {r["symbol"]: r for r in symbols}
        self.assertIn("AL, CL, DL, BL, AH, CH, DH, BH, BPL, SPL, DIL, and SIL", by_symbol["r8"]["source_text"])
        self.assertEqual(by_symbol["r8"]["file_pages"], "105")

@unittest.skipUnless(os.path.exists(PDF) and manual_index.index_state(INDEX_DIR, PDF)[0] == "current",
                     "현재 PDF와 맞는 색인이 없다")
class TerminalLookupTest(unittest.TestCase):
    """터미널 조회(scripts/manual_lookup.py). 기대값은 PDF 731~732쪽 원문에서 정했다."""

    def run_cli(self, *argv):
        import contextlib
        import io
        sys.path.insert(0, os.path.join(ROOT, "scripts"))
        import manual_lookup as cli
        out = io.StringIO()
        with contextlib.redirect_stdout(out):
            code = cli.main(list(argv))
        return code, out.getvalue()

    def test_part_cuts_one_subsection(self):
        code, text = self.run_cli("show", "MOV", "--part", "NOTES:")
        self.assertEqual(code, 0)
        notes = text.split("--- NOTES: [원문] ---")[1].split("=" * 100)[0]
        self.assertIn("1. With a REX prefix in 64-bit mode", notes)
        self.assertIn("3. The moffs8, moffs16, moffs32, and moffs64", notes)
        # 다음 소제목(Instruction Operand Encoding, 732쪽)부터는 들어가지 않는다.
        self.assertNotIn("Instruction Operand Encoding", notes)
        self.assertNotIn("파일 732쪽", notes)

    def test_show_lists_every_mov_section(self):
        code, text = self.run_cli("show", "MOV")
        self.assertEqual(code, 0)
        for title in ("MOV—Move  [원문]", "MOV—Move to/from Control Registers", "MOV—Move to/from Debug Registers"):
            self.assertIn(title, text)
        self.assertIn("파일 731쪽 / 인쇄 4-28", text)

    def test_no_result_and_bad_page_return_error(self):
        code, text = self.run_cli("show", "NOSUCHOP")
        self.assertEqual(code, 1)
        self.assertIn("일치하는 명령어 절이 없다", text)
        code, text = self.run_cli("search", "zzqqxx")
        self.assertIn("일치하는 명령어 절이 없다", text)
        self.assertIn("본문에서 찾지 못했다", text)
        code, _ = self.run_cli("page", "99999")
        self.assertEqual(code, 1)

    def test_cases_show_saved_observation_not_new_run(self):
        code, text = self.run_cli("cases", "MOV", "--opcode", "8A /r")
        self.assertIn("새 실행이 아니다", text)
        self.assertIn("5개", text)
        self.assertIn("mov cl, dl", text)
        self.assertIn("88d1", text)   # 저장 관측: 8A 행 사례가 88로 조립됨


if __name__ == "__main__":
    unittest.main()

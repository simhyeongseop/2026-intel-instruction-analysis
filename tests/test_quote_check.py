"""인용 대조 회귀. 기대값은 손으로 만든 문자열에서 정했다."""

import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from pipeline import quote_check as qc  # noqa: E402


class ParseTest(unittest.TestCase):
    def test_page_and_symbol_forms(self):
        text = ('[SYM070] "A ZMM register." | [1121쪽 Description] "first." | '
                '[파일1245 NOTES] "second." | [407 각주 2] "third (x)." (설명)')
        self.assertEqual(qc.parse_quotes(text), [
            ("SYM070", "A ZMM register."), ("1121쪽 Description", "first."),
            ("파일1245 NOTES", "second."), ("407 각주 2", "third (x).")])

    def test_bit_range_inside_quote_is_not_anchor(self):
        text = '[100 Operation] "DEST[3:0] := SRC[7:4]" | [SYM001] "x"'
        self.assertEqual(qc.parse_quotes(text), [("100 Operation", "DEST[3:0] := SRC[7:4]"), ("SYM001", "x")])

    def test_table_cells_after_slash_are_cut(self):
        text = '[1121쪽 표] "VPSADBW xmm1" / Op/En "B" / 64/32 "V/V" | [SYM092] "V — Supported."'
        self.assertEqual(qc.parse_quotes(text)[0], ("1121쪽 표", "VPSADBW xmm1"))

    def test_parse_ref(self):
        self.assertEqual(qc.parse_ref("파일1245 NOTES"), ("page", (1245, 1245), "NOTES"))
        self.assertEqual(qc.parse_ref("281-284 표"), ("page", (281, 284), "표"))
        self.assertEqual(qc.parse_ref("SYM018"), ("sym", "SYM018", ""))


class MatchTest(unittest.TestCase):
    SOURCE = "The source operand is a ZMM\nregister, a 512-bit memory loca-\ntion. floating- point value V/V"

    def test_levels(self):
        self.assertEqual(qc.match_level("source operand is a ZMM register", self.SOURCE), "exact")
        self.assertEqual(qc.match_level("floating-point value", self.SOURCE), "nospace")
        self.assertEqual(qc.match_level("memory location", self.SOURCE), "nohyphen")

    def test_paraphrase_is_not_found(self):
        # 뜻은 같아도 원문 문장이 아니면 찾지 못해야 한다.
        self.assertIsNone(qc.match_level("The source is a ZMM register", self.SOURCE))
        self.assertIsNone(qc.match_level("소스는 ZMM 레지스터", self.SOURCE))

    def test_leading_ellipsis_and_slash_join(self):
        self.assertEqual(qc.match_level("...source operand is a ZMM", self.SOURCE), "exact")
        self.assertEqual(qc.match_level("source operand / floating- point", self.SOURCE), "exact")

    def test_table_ref(self):
        self.assertTrue(qc.is_table_ref("표"))
        self.assertTrue(qc.is_table_ref("표 Description 칸"))
        self.assertTrue(qc.is_table_ref("형식 표 64-bit 열"))
        self.assertFalse(qc.is_table_ref("Description"))

    def test_table_label_form(self):
        cells = "0F C0 /r | XADD r/m8^1, r8^1 | MR | Valid | Valid"
        self.assertEqual(qc.table_label_level("64/32 bit Mode: Valid/Valid", cells), "table_label")
        self.assertIsNone(qc.table_label_level("64/32 bit Mode: Valid/N.E.", cells))
        # 열 이름 꼴이 아니면 이 단계를 쓰지 않는다.
        self.assertIsNone(qc.table_label_level("Valid/Valid", cells))

    def test_fragments_must_all_exist(self):
        self.assertEqual(qc.match_level("source operand ... V/V", self.SOURCE), "exact")
        self.assertIsNone(qc.match_level("source operand ... V/N.E.", self.SOURCE))


if __name__ == "__main__":
    unittest.main()

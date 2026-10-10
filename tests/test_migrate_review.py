"""090 -> 093 이전의 쪽 번호 바꾸기 회귀. 기대값은 손으로 정했다."""

import importlib.util
import os
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SPEC = importlib.util.spec_from_file_location("migrate_review_to_093", os.path.join(ROOT, "scripts", "migrate_review_to_093.py"))
script = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(script)

PAGES = {123: 130, 100: 105, 101: 106, 1304: 1305}


class RemapTest(unittest.TestCase):
    def test_page_forms(self):
        text = ('[123 Description] "a" | [SYM001] "b" | [파일123 NOTES] "c" | [1304쪽 표] "d" | '
                '[100-101 표] "e" | [100 Operation] "DEST[3:0] := SRC[7:4]"')
        self.assertEqual(script.remap_quotes(text, PAGES),
                         '[130 Description] "a" | [SYM001] "b" | [파일130 NOTES] "c" | [1305쪽 표] "d" | '
                         '[105-106 표] "e" | [105 Operation] "DEST[3:0] := SRC[7:4]"')

    def test_unmapped_page_kept(self):
        self.assertEqual(script.remap_quotes('[999 Description] "x"', PAGES), '[999 Description] "x"')

    def test_page_number_fields(self):
        self.assertEqual(script.remap_page_numbers("100-101", PAGES, r"(\d{2,4})"), "105-106")
        self.assertEqual(script.remap_page_numbers("1304", PAGES, r"(\d{2,4})"), "1305")


if __name__ == "__main__":
    unittest.main()

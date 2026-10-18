"""66H 오퍼랜드 크기 접두어 대조 회귀. 기대값은 Vol.1 Table 3-4(83쪽)와 ModRM 손계산으로 정했다."""

import csv
import os
import sys
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline import operand_size_prefix as P  # noqa: E402
from pipeline.encoding_audit import check_encoding  # noqa: E402


class OperandSizePrefixTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        with open(P.ISA_DB, encoding="utf-8", newline="") as handle:
            cls.isa = list(csv.DictReader(handle))

    def match(self, instruction, hex_bytes, description=""):
        row = next(r for r in self.isa if r["instruction"] == instruction and description in r["description"])
        return check_encoding(hex_bytes, dict(row, operand_types=row["operands"]))["status"] == "fields_match"

    def test_rows_split_only_by_operand_size(self):
        self.assertTrue(self.match("ADD r/m16, r16", "6601d1"))
        self.assertFalse(self.match("ADD r/m16, r16", "01d1"))       # 66 없음 = ADD r/m32, r32
        self.assertFalse(self.match("ADD r/m32, r32", "6601d1"))
        self.assertTrue(self.match("PUSH imm16", "66683412"))
        self.assertFalse(self.match("PUSH imm16", "683412"))
        self.assertTrue(self.match("CALL m16:16", "66ff18"))
        self.assertFalse(self.match("CALL m16:16", "ff18"))          # 66 없음 = m16:32
        self.assertTrue(self.match("CRC32 r32, r/m16", "66f20f38f1ca"))

    def test_default_64_bit_rows(self):
        self.assertTrue(self.match("PUSH r64", "51"))
        self.assertFalse(self.match("PUSH r64", "6651"))             # 66 있음 = PUSH r16
        self.assertTrue(self.match("PUSH r16", "6651"))
        self.assertFalse(self.match("LEAVE", "66c9", "Set RSP"))
        self.assertTrue(self.match("LEAVE", "66c9", "Set SP"))

    def test_operandless_rows_use_description(self):
        self.assertTrue(self.match("CBW", "6698"))
        self.assertFalse(self.match("CBW", "98"))                    # 66 없음 = CWDE
        self.assertTrue(self.match("CWDE", "98"))

    def test_fixed_16_bit_rows_have_no_rule(self):
        # 짝 행이 없어 66이 인코딩 요소가 아니다
        self.assertIsNone(P.required_size(next(r for r in self.isa if r["instruction"] == "RET imm16")))
        self.assertTrue(self.match("ENTER imm16, 0", "c8341200"))
        self.assertTrue(self.match("LLDT r/m16", "0f00d1"))


    def test_rex_w_sibling_rows(self):
        # 같은 opcode 칸에 REX.W 행이 따로 있으면 REX.W 없는 행은 REX.W 바이트를 받지 않는다(Vol.1 Table 3-4)
        self.assertTrue(self.match("CALL m16:32", "ff18"))
        self.assertFalse(self.match("CALL m16:32", "48ff18"))        # 48 = REX.W -> CALL m16:64
        self.assertTrue(self.match("CALL m16:64", "48ff18"))
        self.assertFalse(self.match("ADD r/m32, r32", "4801d1"))
        self.assertTrue(self.match("ADD r/m32, r32", "4101d1"))      # REX.B만(r9d)은 REX.W가 아니다
        self.assertTrue(self.match("PUSH r64", "51"))                # REX.W 짝 행이 없는 행은 대상이 아니다
        self.assertFalse(P.forbids_rex_w(next(r for r in self.isa if r["instruction"] == "PUSH r64")))


if __name__ == "__main__":
    unittest.main()

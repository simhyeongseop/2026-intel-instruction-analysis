"""3단계 판정 회귀. 기대값은 SDM 표 행(CALL·BNDCL)과 ModRM 손계산에서 정했다."""

import os
import sys
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline import m3_check as C  # noqa: E402


class ValidRowsReachedTest(unittest.TestCase):
    def setUp(self):
        self.isa = C.read_csv(os.path.join(ROOT, "data/db/isa_db.csv"))

    def reached(self, instruction, hex_bytes):
        row_id = next(i for i, r in enumerate(self.isa) if r["instruction"] == instruction)
        case = {"row_id": str(row_id), "mnemonic": self.isa[row_id]["mnemonic"], "operands": "dword ptr [rax]"}
        observed = {"bytes": hex_bytes, "relocations": None}
        return [self.isa[int(i)]["instruction"] for i in C.valid_rows_reached(observed, case, self.isa, {})]

    def test_dword_call_is_far_call(self):
        # 66 FF 18: ModRM 18 = mod 00, reg 011(/3), rm 000 -> CALL m16:16 (66 = 16비트 오퍼랜드)
        self.assertIn("CALL m16:16", self.reached("CALL r/m32", "66ff18"))
        self.assertNotIn("CALL r/m64", self.reached("CALL r/m32", "66ff18"))

    def test_mpx_memory_size_is_ignored(self):
        # F3 0F 1A 00: 64비트 모드의 BNDCL 메모리 형식은 r/m64 행
        self.assertEqual(self.reached("BNDCL bnd, r/m32", "f30f1a00"), ["BNDCL bnd, r/m64"])

    def test_unrelated_bytes(self):
        self.assertEqual(self.reached("CALL r/m32", "90"), [])


class RegisteredFormTest(unittest.TestCase):
    """data/rules/unreachable_forms.csv: 등록한 형식만 '도달 불가(등록)'로 바꾼다(형식 칸이 메모리인지로 구분)."""

    def setUp(self):
        self.entries = {int(r["row_id"]): r for r in C.read_csv(C.UNREACHABLE)}

    def verdict(self, row_id, source):
        out = {"verdict": "다른 인코딩", "diagnostic": ""}
        return C.registered(out, {"row_id": str(row_id), "source": source}, self.entries)["verdict"]

    def test_push_imm16_and_xbegin_rel16(self):
        self.assertEqual(self.verdict(2314, "data16 push 0x1234"), "도달 불가(등록)")
        self.assertEqual(self.verdict(4118, "data16 xbegin .Ltarget16"), "도달 불가(등록)")

    def test_unregistered_row_kept(self):
        self.assertEqual(self.verdict(2315, "push 0x12345678"), "다른 인코딩")
        self.assertEqual(self.verdict(2314, "push word ptr [rax]"), "다른 인코딩")   # 메모리 형식은 등록 밖


if __name__ == "__main__":
    unittest.main()

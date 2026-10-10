"""판 비교 짝짓기 회귀. 손으로 만든 행으로 기대값을 정했다."""

import importlib.util
import os
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SPEC = importlib.util.spec_from_file_location("compare_isa_editions", os.path.join(ROOT, "scripts", "compare_isa_editions.py"))
script = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(script)


def row(opcode, instruction, op_en="A", page="10"):
    return {"opcode": opcode, "instruction": instruction, "mnemonic": instruction.split()[0],
            "operands": "", "op_en": op_en, "mode_support": "V/V", "cpuid_flag": "", "description": "", "source_page": page}


class PairTest(unittest.TestCase):
    def test_same_changed_added_removed(self):
        old = [row("90", "NOP"), row("0F 05", "SYSCALL"), row("C3", "RET", op_en="ZO")]
        new = [row("90", "NOP", page="11"), row("C3", "RET", op_en="Z0"), row("0F 01 D0", "XGETBV")]
        result = {}
        for o, n in script.pair_rows(old, new):
            status, fields = script.classify(old[o] if o is not None else None, new[n] if n is not None else None)
            result[(o, n)] = (status, fields)
        self.assertEqual(result[(0, 0)], ("same", []))           # 쪽 번호만 다름
        self.assertEqual(result[(2, 1)], ("changed", ["op_en"]))
        self.assertEqual(result[(1, None)][0], "removed")
        self.assertEqual(result[(None, 2)][0], "added")

    def test_duplicate_keys_pair_in_order_and_ignore_spacing(self):
        old = [row("F3 6D", "REP INS m16, DX"), row("F3 6D", "REP INS m32, DX")]
        new = [row("F3  6D", "REP INS m16,DX"), row("F3 6D", "REP INS m32, DX")]
        self.assertEqual(script.pair_rows(old, new), [(0, 0), (1, 1)])


if __name__ == "__main__":
    unittest.main()

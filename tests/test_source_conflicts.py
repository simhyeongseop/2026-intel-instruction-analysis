"""예외 사례 대조 스크립트의 바이트 해석 회귀. 기대값은 인코딩 형식에서 손으로 계산했다."""

import importlib.util
import os
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SPEC = importlib.util.spec_from_file_location("check_source_conflicts", os.path.join(ROOT, "scripts", "check_source_conflicts.py"))
script = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(script)


class ByteTest(unittest.TestCase):
    def test_vex_l(self):
        self.assertEqual(script.vex_l(bytes.fromhex("c4e26d03cb")), 1)   # 6D = 0110 1101, 비트 2 = 1
        self.assertEqual(script.vex_l(bytes.fromhex("c4e37917c800")), 0)  # 79 = 0111 1001, 비트 2 = 0
        self.assertEqual(script.vex_l(bytes.fromhex("c5edfdcb")), 1)      # 2바이트 VEX: ED의 비트 2
        self.assertIsNone(script.vex_l(bytes.fromhex("0f0b")))

    def test_flip_vex_l(self):
        self.assertEqual(script.flip_vex_l(bytes.fromhex("c4e37917c800")).hex(), "c4e37d17c800")
        self.assertEqual(script.flip_vex_l(bytes.fromhex("c5edfdcb")).hex(), "c5e9fdcb")

    def test_evex_ll(self):
        self.assertEqual(script.evex_ll(bytes.fromhex("62f1ff89e6ca")), 0)  # 89 = 1000 1001, 비트 6:5 = 00
        self.assertEqual(script.evex_ll(bytes.fromhex("62f1ffa9e6ca")), 1)  # A9 = 1010 1001 -> 01
        self.assertEqual(script.evex_ll(bytes.fromhex("62f1ffc9e6ca")), 2)  # C9 = 1100 1001 -> 10
        self.assertIsNone(script.evex_ll(bytes.fromhex("c5edfdcb")))

    def test_expected_ll(self):
        self.assertEqual(script.expected_ll("EVEX.128.F2.0F.W1 E6 /r"), 0)
        self.assertEqual(script.expected_ll("EVEX.256.66.0F38.W0 64 /r"), 1)
        self.assertIsNone(script.expected_ll("EVEX.LLIG.F3.MAP5.W0 5D /r"))


if __name__ == "__main__":
    unittest.main()

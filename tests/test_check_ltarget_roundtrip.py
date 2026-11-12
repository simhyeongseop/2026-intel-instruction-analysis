""".Ltarget 라벨 되돌리기 회귀. 기대값은 손으로 계산했다(b0는 시작 0, .Ltarget = 0, .Ltarget16/32 = 4096)."""

import os
import shutil
import sys
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)
sys.path.insert(0, os.path.join(ROOT, "scripts"))

import check_ltarget_roundtrip as L  # noqa: E402
from pipeline import toolchain as T  # noqa: E402


class ToLabelTest(unittest.TestCase):
    def test_objdump_absolute(self):
        # 77 fe: ja, 변위 -2 -> 대상 0. objdump는 절대 주소 0x0을 쓴다
        self.assertEqual(L.to_label("gnu", "ja 0x0", 2), "ja .Ltarget")
        # e8 fb 0f 00 00: 다음 명령 5 + 0xffb = 0x1000
        self.assertEqual(L.to_label("gnu", "call 0x1000", 5), "call .Ltarget+4096")

    def test_llvm_relative(self):
        # llvm-mc는 변위를 쓴다: 77 fe -> 'ja -2', 대상 = 2 + (-2) = 0
        self.assertEqual(L.to_label("llvm", "ja -2", 2), "ja .Ltarget")
        self.assertEqual(L.to_label("llvm", "callq 4091", 5), "callq .Ltarget+4096")
        self.assertEqual(L.to_label("llvm", "jrcxz -3", 3), "jrcxz .Ltarget")   # 67 e3 fd

    def test_not_branch(self):
        self.assertIsNone(L.to_label("gnu", "add eax, 1", 3))
        self.assertIsNone(L.to_label("gnu", "call qword ptr [rax]", 2))


@unittest.skipUnless(shutil.which(T.AS) or os.path.exists(T.AS), "GNU as 없음")
class ToolTest(unittest.TestCase):
    def test_rel8_and_rel32(self):
        self.assertEqual(L.check("gnu", "77fe", "intel")["b0_b1"], "같음")
        self.assertEqual(L.check("gnu", "e8fb0f0000", "att")["b0_b1"], "같음")

    def test_other_target(self):
        # 77 00: 대상 2 -> '.Ltarget+2'로 되돌려야 같다
        out = L.check("gnu", "7700", "intel")
        self.assertEqual(out["as1_label"], "ja .Ltarget+2")
        self.assertEqual(out["b0_b1"], "같음")

    def test_wrong_label_is_caught(self):
        # 반례: 대상을 1 틀리게 되돌리면 변위가 달라져 '다름'이 나와야 한다
        original = L.to_label
        try:
            L.to_label = lambda family, text, length: original(family, text, length) + "+1"
            self.assertEqual(L.check("gnu", "77fe", "intel")["b0_b1"], "다름")
        finally:
            L.to_label = original


if __name__ == "__main__":
    unittest.main()

"""5단계 왕복 대조 회귀. 기대값은 SDM opcode 표(MOV 89/8B)와 도구 출력 형식에서 손으로 정했다."""

import os
import shutil
import sys
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline import m5_roundtrip as M  # noqa: E402
from pipeline import toolchain as T  # noqa: E402


class VerdictTest(unittest.TestCase):
    def test_categories(self):
        self.assertEqual(M.verdict(False, False, False, False), M.REJECTED)
        self.assertEqual(M.verdict(True, True, True, True), M.RELOCATED)
        self.assertEqual(M.verdict(True, False, True, True), M.SAME)
        self.assertEqual(M.verdict(True, False, False, True), M.SAME_INSN)
        self.assertEqual(M.verdict(True, False, False, False), M.DIFFERENT)

    def test_route(self):
        self.assertEqual(M.route((True, "4889c8"), (True, "4889c8")), "두 경로 같음")
        self.assertEqual(M.route((True, "4889c8"), (True, "488bc1")), "두 경로 바이트 다름")
        self.assertEqual(M.route((False, ""), (True, "4889c8")), "AT&T 경로만 거부")
        self.assertEqual(M.route((False, ""), (False, "")), "둘 다 거부")

    def test_clean(self):
        self.assertEqual(M.clean("lea    0x0(%rip),%rax        # 0x7"), "lea 0x0(%rip),%rax")
        self.assertEqual(M.clean("call\t0x5 <foo>"), "call 0x5")

    def test_targets_skip_rejected(self):
        results = [{"status_as": "accepted", "bytes_as": "90", "status_clang": "diagnostic_rejection",
                    "bytes_clang": ""}]
        self.assertEqual([f for f, _ in M.targets(results)], ["gnu"])


@unittest.skipUnless(shutil.which(T.OBJDUMP) and shutil.which(T.LLVM_MC) and shutil.which(T.CLANG),
                     "도구 없음")
class ToolTest(unittest.TestCase):
    def test_same_bytes(self):
        for family in M.FAMILIES:                  # MOV r/m64, r64 (REX.W 89 /r): 어셈블러 기본 선택
            row = M.roundtrip(family, "4889c8")
            self.assertEqual((row["verdict_att"], row["verdict_intel"]), (M.SAME, M.SAME), family)

    def test_direction_bit_lost(self):
        for family in M.FAMILIES:                  # MOV r64, r/m64 (REX.W 8B /r): 텍스트는 89 형식과 같다
            row = M.roundtrip(family, "488bc1")
            self.assertEqual(row["verdict_att"], M.SAME_INSN, family)
            self.assertEqual(row["bytes_att"], "4889c8", family)
            self.assertEqual(row["route"], "두 경로 같음", family)

    def test_movsxd_r16_intel64(self):
        row = M.roundtrip("gnu", "6663ca")         # MOVSXD r16, r/m16 (66 63 /r): Intel64 해석이면 cx, dx
        self.assertEqual((row["verdict_att"], row["verdict_intel"]), (M.SAME, M.SAME))
        self.assertIn("dx", row["intel"])
        self.assertNotIn("edx", row["intel"])

    def test_relative_excluded(self):
        row = M.roundtrip("gnu", "e800000000", relative=True)
        self.assertEqual(row["verdict_att"], M.RELATIVE)
        self.assertEqual(row["bytes_att"], "")

    def test_undecodable(self):
        row = M.roundtrip("gnu", "0f0b0f")         # ud2 + 남은 바이트 하나
        self.assertEqual(row["verdict_att"], M.UNDECODED)


if __name__ == "__main__":
    unittest.main()

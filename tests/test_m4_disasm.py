"""4단계 역어셈블 대조 규칙 회귀. 기대값은 SDM 표와 도구 출력 형식에서 손으로 정했다."""

import os
import re
import sys
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline import disasm_rules as D  # noqa: E402
from pipeline import m4_disasm as M  # noqa: E402


def same(a, b):
    return D.same_operand(D.operand(a), D.operand(b))


class PseudoOpTest(unittest.TestCase):
    def test_values_from_sdm_tables(self):
        self.assertEqual(D.pseudo_op("vcmppd", 0x12), "vcmple_oqpd")    # 289쪽 VCMPLE_OQPD ... 12H
        self.assertEqual(D.pseudo_op("cmpps", 1), "cmpltps")            # Table 3-11
        self.assertIsNone(D.pseudo_op("cmpps", 0x12))                   # 레거시 표는 0~7뿐
        self.assertIsNone(D.pseudo_op("vcmppd", 0x7f))
        self.assertEqual(D.pseudo_op("vpcmpub", 5), "vpcmpnltub")       # Table 5-19(5번 PDF 오기 'VPPCMPNLT*')
        self.assertIsNone(D.pseudo_op("vpcmpb", 3))                     # 표에 없는 값
        self.assertEqual(D.pseudo_op("vpclmulqdq", 0x11), "vpclmulhqhqdq")

    def test_tables_are_in_sdm_text(self):
        from pipeline import manual_index
        try:
            index = manual_index.ManualIndex(os.path.join(ROOT, "out/manual_index"))
        except OSError:
            self.skipTest("매뉴얼 색인 없음")
        text = lambda page: re.sub(r"\s+", " ", index.page_text(page))
        page289 = text(288) + " " + text(289)
        for value, name in enumerate(D.CMP_VEX[1]):
            self.assertIn("VCMP%sPD reg1, reg2, reg3 VCMPPD reg1, reg2, reg3, %02XH" % (name, value)
                          if value > 9 else "VCMP%sPD reg1, reg2, reg3 VCMPPD reg1, reg2, reg3, %d" % (name, value)
                          if value < 8 else "VCMP%sPD" % name, page289)
        self.assertIn("PCLMULHQHQDQ xmm1, xmm2 0001_0001B", text(946))
        self.assertIn("REPNE/REPNZ prefix is encoded using F2H", text(31))
        self.assertIn(D.FWAIT_PAIR[1], text(506))


class OperandTest(unittest.TestCase):
    def test_equivalent_spellings(self):
        self.assertTrue(same("xmmword ptr [rax+rbx*4+0x10]", "XMMWORD PTR [rax + 4*rbx + 16]"))
        self.assertTrue(same("dword ptr [rax]{1to8}", "DWORD BCST [rax]"))          # objdump 브로드캐스트 표기
        self.assertTrue(same("byte ptr [0x123456789abcdef0]", "ds:0x123456789abcdef0"))  # objdump moffs
        self.assertTrue(same("0x12", "18"))
        self.assertTrue(same("st", "st(0)"))

    def test_real_differences(self):
        self.assertFalse(same("cx", "ecx"))
        self.assertFalse(same("qword ptr [rax]", "dword ptr [rax]"))
        self.assertFalse(same("zmm0 {k1}{z}", "zmm0 {k1}"))
        self.assertFalse(same("[rax+rbx*4+0x10]", "[rax+rbx*2+0x10]"))

    def test_llvm_separate_mask(self):
        self.assertEqual(M.decoded_operands("{k1}, ymmword ptr [rax + zmm0]"), ["ymmword ptr [rax + zmm0] {k1}"])


class MnemonicTest(unittest.TestCase):
    def test_split(self):
        self.assertEqual(M.split_mnemonic("rep\t\tinsb\tbyte ptr es:[rdi], dx")[:2], (["f3"], "insb"))
        self.assertEqual(M.split_mnemonic("{evex} vmovq xmm0,QWORD PTR [rip+0x10]        # 0x1a")[1], "vmovq")
        self.assertEqual(M.split_mnemonic("lock")[:2], (["f0"], "f0"))
        self.assertEqual(M.split_mnemonic("repz scas al,BYTE PTR es:[rdi]")[:2], (["f3"], "scas"))

    def test_opcode_key_for_string_synonyms(self):
        self.assertEqual(M.opcode_key("F3 6C"), "6C")
        self.assertEqual(M.opcode_key("F3 REX.W + AD"), "REX.W AD")
        self.assertEqual(M.opcode_key("F3 0F B8 /r"), "F3 0F B8 /r")     # 필수 접두어 F3는 떼지 않음


class FarPointerTest(unittest.TestCase):
    """먼 CALL(FF /3)을 크기 표기 없이 'call [rax]'로 내면 가까운 호출 텍스트다(다시 조립하면 ff10)."""

    def setUp(self):
        import shutil
        from pipeline import toolchain as T
        if not (shutil.which(T.OBJDUMP) and shutil.which(T.LLVM_MC)):
            self.skipTest("역어셈블러 없음")
        self.isa = M.read_csv(os.path.join(ROOT, "data/db/isa_db.csv"))
        self.row = next(r for r in self.isa if r["instruction"] == "CALL m16:32")
        self.case = {"source": "call fword ptr [rax]", "operands": "fword ptr [rax]"}

    def judge(self, name, hex_bytes):
        return M.judge(name, hex_bytes, self.case, self.row, M.sdm_mnemonics(self.isa))["verdict"]

    def test_far_call_needs_a_size_or_far_spelling(self):
        self.assertEqual(self.judge("llvm", "ff18"), "오퍼랜드 다름(먼 포인터 표시 없음)")   # 'call [rax]'
        self.assertEqual(self.judge("objdump", "ff18"), "SDM 일치")                          # 'call FWORD PTR [rax]'


if __name__ == "__main__":
    unittest.main()

"""encoding_audit의 SDM 표기 확장(NP, MAP5/MAP6, NDS, /is4, REX.w) 회귀.

기대 바이트는 인코딩 형식에서 손으로 계산했다(EVEX P0 하위 3비트 = map, P1 하위 2비트 = pp, VEX C4 둘째 바이트 하위 5비트 = map).
"""

import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from pipeline.encoding_audit import check_encoding, normalize_template  # noqa: E402


def status(data, opcode):
    return check_encoding(data, {"row_id": "x", "opcode": opcode, "operands": "", "operand_types": ""})["status"]


class NotationTest(unittest.TestCase):
    def test_map5_f3(self):
        # vaddsh xmm0,xmm0,xmm0: 62 F5(map 101) 7E(W0 vvvv1111 1 pp=10=F3) 08 58 C0
        self.assertEqual(status("62f57e0858c0", "EVEX.LLIG.F3.MAP5.W0 58 /r"), "fields_match")
        self.assertEqual(status("62f17e0858c0", "EVEX.LLIG.F3.MAP5.W0 58 /r"), "different_encoding")  # map 1

    def test_map5_np(self):
        # vaddph xmm0,xmm0,xmm0: P1 7C → pp=00
        self.assertEqual(status("62f57c0858c0", "EVEX.128.NP.MAP5.W0 58 /r"), "fields_match")
        self.assertEqual(status("62f57d0858c0", "EVEX.128.NP.MAP5.W0 58 /r"), "different_encoding")  # pp=66

    def test_map6(self):
        # vcvtph2psx xmm0,xmm0: 62 F6(map 110) 7D(pp=66) 08 13 C0
        self.assertEqual(status("62f67d0813c0", "EVEX.128.66.MAP6.W0 13 /r"), "fields_match")
        self.assertEqual(status("62f57d0813c0", "EVEX.128.66.MAP6.W0 13 /r"), "different_encoding")  # map 5

    def test_nds_is_ignored(self):
        self.assertEqual(status("62f27f0868c8", "EVEX.NDS.128.F2.0F38.W0 68 /r"), "fields_match")

    def test_is4_tail(self):
        # vblendvpd xmm0,xmm0,xmm0,xmm0: C4 E3(map 3) 79(W0 vvvv1111 L0 pp=01) 4B C0 00(is4)
        self.assertEqual(status("c4e3794bc000", "VEX.128.66.0F3A.W0 4B /r /is4"), "fields_match")
        self.assertEqual(status("c4e3794bc0", "VEX.128.66.0F3A.W0 4B /r /is4"), "different_encoding")  # is4 없음

    def test_slash_ib(self):
        self.assertEqual(status("62f37d0857c001", "EVEX.LLIG.66.0F3A.W0 57 /r /ib"), "fields_match")

    def test_lowercase_rex_w(self):
        # adcx rcx,rcx: 66 48 0F 38 F6 C9
        self.assertEqual(status("66480f38f6c9", "66 REX.w 0F 38 F6 /r"), "fields_match")
        self.assertEqual(status("660f38f6c9", "66 REX.w 0F 38 F6 /r"), "different_encoding")  # REX.W 없음


class ModrmNotationTest(unittest.TestCase):
    """SYM087(11:rrr:bbb, !(11), 고정 REG/RM)과 SYM010(+i)."""

    def test_not_11_requires_memory(self):
        op = "VEX.128.66.0F38.W0 E6 !(11):rrr:bbb"
        self.assertEqual(status("67c4e271e608", op), "fields_match")      # ModRM 08: MOD 00
        self.assertEqual(status("c4e271e6c8", op), "different_encoding")  # ModRM C8: MOD 11

    def test_11_requires_register(self):
        op = "F3 0F 38 FA 11:rrr:bbb"
        self.assertEqual(status("f30f38fac9", op), "fields_match")
        self.assertEqual(status("f30f38fa08", op), "different_encoding")

    def test_fixed_reg_and_rm(self):
        self.assertEqual(status("67f30f38d808", "F3 0F 38 D8 !(11):001:bbb"), "fields_match")       # REG 001
        self.assertEqual(status("67f30f38d800", "F3 0F 38 D8 !(11):001:bbb"), "different_encoding")  # REG 000
        self.assertEqual(status("67c4e27b4b0420", "VEX.128.F2.0F38.W0 4B !(11):rrr:100"), "fields_match")  # RM 100
        self.assertEqual(status("67c4e27b4b00", "VEX.128.F2.0F38.W0 4B !(11):rrr:100"), "different_encoding")

    def test_plus_i(self):
        self.assertEqual(status("d8c3", "D8 C0+i"), "fields_match")        # i = 3
        self.assertEqual(status("d8c8", "D8 C0+i"), "different_encoding")  # C8은 C0..C7 밖
        self.assertEqual(status("d9c3", "D8 C0+i"), "different_encoding")

    def test_plus_register(self):
        self.assertEqual(status("6651", "50+rw"), "fields_match")                  # push cx
        self.assertEqual(status("b900000100", "B8+ rd id"), "fields_match")         # mov ecx, imm32
        self.assertEqual(status("48b90000000001000000", "REX.W + B8+ rd io"), "fields_match")
        self.assertEqual(status("4151", "50+rd"), "fields_match")                   # push r9: REX.B + 51
        self.assertEqual(status("b9000001", "B8+ rd id"), "different_encoding")     # id가 3바이트
        self.assertEqual(status("59", "50+rd"), "different_encoding")               # 58..5F는 POP

    def test_nfx_mod11_and_literal_tail(self):
        self.assertEqual(status("480fc7f1", "NFx REX.W + 0F C7 /6"), "fields_match")  # rdrand rcx
        self.assertEqual(status("f30f1ec9", "F3 0F 1E /1 (mod=11)"), "fields_match")
        self.assertEqual(status("67f30f1e08", "F3 0F 1E /1 (mod=11)"), "different_encoding")
        self.assertEqual(status("c8ff7f00", "C8 iw 00"), "fields_match")

    def test_spelling_variants(self):
        self.assertEqual(status("660f3820c0", "66 0f 38 20 /r"), "fields_match")
        self.assertEqual(status("660f3a61c001", "66 0F 3A 61 /r imm8"), "fields_match")
        self.assertEqual(status("660f3acfc001", "66 0F3A CF /r /ib"), "fields_match")
        self.assertEqual(status("660fe0c0", "66 0F E0, /r"), "fields_match")
        self.assertEqual(status("6762f27d09920408", "EVEX.128.66.0F38.W0 92 /vsib"), "fields_match")
        self.assertEqual(status("67f30f0128", "F3 0F 01 /5 (mod!=11, /5, memory only)"), "fields_match")
        self.assertEqual(status("f30f01e8", "F3 0F 01 /5 (mod!=11, /5, memory only)"), "different_encoding")


    def test_map7_notation(self):
        # 'MAP7:W0.F8 11:000:bbb'(사용자 결정 2026-10-10, source_conflict_cases MAP7-*): 맵 7·W0·opcode F8, ModRM 11:000.
        # 표 칸에 imm32 꼬리가 없으므로 꼬리 없는 바이트로 표기 해석만 본다(실제 케이스는 overrides의 byte_pattern).
        self.assertEqual(normalize_template("VEX.128.F2.MAP7:W0.F8 11:000:bbb")[0], "VEX.128.F2.MAP7.W0 F8 /0")
        self.assertEqual(status("c4e77bf8c1", "VEX.128.F2.MAP7:W0.F8 11:000:bbb"), "fields_match")
        self.assertEqual(status("c4e17bf8c1", "VEX.128.F2.MAP7:W0.F8 11:000:bbb"), "different_encoding")  # map 1
        self.assertEqual(status("c4e77af8c1", "VEX.128.F2.MAP7:W0.F8 11:000:bbb"), "different_encoding")  # pp=F3
        self.assertEqual(status("c4e77bf801", "VEX.128.F2.MAP7:W0.F8 11:000:bbb"), "different_encoding")  # mod!=11


class OverridePatternTest(unittest.TestCase):
    """MAP7 행의 손 해석 바이트 패턴은 자기 형식에만 맞아야 한다(GNU 관측 c4 e7 7b f8 c1 imm32 = URDMSR rcx)."""

    def test_map7_patterns_are_exclusive(self):
        import csv
        import re
        root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        with open(os.path.join(root, "data/rules/encoding_check_overrides.csv"), encoding="utf-8") as handle:
            patterns = {r["mnemonic"]: r["byte_pattern"] for r in csv.DictReader(handle) if "MAP7" in r["table_opcode"]}
        forms = {"RDMSR": "c4e77bf6c100000100", "URDMSR": "c4e77bf8c100000100",
                 "UWRMSR": "c4e77af8c100000100", "WRMSRNS": "c4e77af6c100000100"}
        self.assertEqual(set(patterns), set(forms))
        for name, pattern in patterns.items():
            for other, data in forms.items():
                self.assertEqual(bool(re.match(pattern, data)), name == other, (name, other))
            self.assertFalse(re.match(pattern, forms[name][:-2]), name)          # imm32 1바이트 모자람
            self.assertFalse(re.match(pattern, forms[name].replace("c4e7", "c4e1", 1)), name)  # map 1


if __name__ == "__main__":
    unittest.main()

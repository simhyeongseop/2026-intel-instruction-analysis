"""2단계 생성기 회귀. 기대값은 SDM 표기와 선택 규칙에서 손으로 정했다(생성 코드의 표를 읽지 않는다)."""

import os
import sys
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline import m2_generate as G  # noqa: E402


def fake_row(name, opcode="", symbols=(), mode="Valid"):
    return {"row_id": 0, "name": name, "opcode": opcode, "symbols": list(symbols), "widths": {},
            "string_memory_accumulator": False,
            "isa": {"mode_support": mode}}


def choices(symbol, name="ADD", opcode="00 /r", excluded=("rax", "rbx")):
    regs = G.RowRegisters(set(excluded))
    return G.operand_choices(symbol, fake_row(name, opcode, [symbol]), regs)[0]


class RegisterTest(unittest.TestCase):
    def test_sdm_list_order_skips_address_and_fixed_registers(self):
        regs = G.RowRegisters({"rax", "rbx", "cl"})          # 주소 rax·rbx, 같은 표의 고정 CL
        self.assertEqual(regs.take("r32")[0], "edx")         # SYM028 순서 EAX, ECX, EDX: eax·ecx(cl과 같은 물리) 제외
        self.assertEqual(regs.take("r64")[0], "rdi")         # SYM029 순서 RAX, RBX, RCX, RDX, RDI: rdx는 위에서 씀
        self.assertEqual(regs.take("xmm")[0], "xmm0")
        self.assertEqual(regs.take("zmm")[0], "zmm1")        # xmm0과 같은 물리 레지스터는 건너뜀

    def test_st_i_starts_after_top(self):
        self.assertEqual(G.RowRegisters(set()).take("ST(i)")[0], "st(1)")


class OperandTest(unittest.TestCase):
    def test_reg_or_mem(self):
        self.assertEqual([(k, t) for k, t, _ in choices("r/m8")], [("reg", "cl"), ("mem", "byte ptr {addr}")])
        self.assertEqual(choices("r/m16")[1][2], "SYM036")       # 메모리 근거: r/m16 정의(SYM042 m16은 문자열 명령 전용)
        self.assertEqual(choices("m16", "LLDT")[0][2], "SYM042")  # 단독 m16 표기는 그대로
        # reg/m16(VMOVW): 레지스터 칸 근거는 reg 정의(SYM039: r16, r32, or r64)이고 값은 64비트 모드 기본 32
        reg = choices("reg/m16", "VMOVW", "EVEX.128.66.MAP5.WIG 6E /r")[0]
        self.assertEqual(reg[1], "ecx")
        self.assertTrue(reg[2].startswith("SYM039"))

    def test_reg_r64_alternative(self):
        # MOVMSKPD 절 "The upper bits of r32 or r64 are filled with zeros": 대표 r32 다음에 r64
        picks = [(k, t) for k, t, _ in choices("reg", "MOVMSKPD", "66 0F 50 /r")]
        self.assertEqual(picks, [("reg", "ecx"), ("reg", "rdx")])
        # VMOVW·VPBROADCASTB/W: 명령 절에 폭이 없고 XED는 GPR32만 정의 -> r64 대안 없음(2026-10-13)
        kinds = [(k, t) for k, t, _ in choices("reg/m16", "VMOVW", "EVEX.128.66.MAP5.WIG 6E /r")]
        self.assertEqual(kinds, [("reg", "ecx"), ("mem", "word ptr {addr}")])
        picks = [t for _, t, _ in choices("reg", "VPBROADCASTB", "EVEX.128.66.0F38.W0 7A /r")]
        self.assertEqual(picks, ["ecx"])
        # 명령 절이 "r32 or r64"를 적은 reg/m16 행은 r64 대안을 유지(PEXTRW)
        self.assertIn(("reg", "rdx"), [(k, t) for k, t, _ in choices("reg/m16", "PEXTRW", "66 0F 3A 15 /r ib")])
        # SENDUIPI 절 "The operand always has 64 bits": 대표값이 이미 r64면 대안 없음
        row = fake_row("SENDUIPI", "F3 0F C7 /6", ["reg"])
        row["widths"] = {"reg": "64"}
        self.assertEqual([t for _, t, _ in G.operand_choices("reg", row, G.RowRegisters(set()))[0]], ["rax"])

    def test_broadcast_count_from_plain_memory_width(self):
        self.assertEqual(choices("xmm3/m128/m32bcst")[-1][1], "dword ptr {addr}{1to4}")
        self.assertEqual(choices("zmm3/m512/m16bcst {er}")[-1][1], "word ptr {addr}{1to32}")
        self.assertEqual(choices("xmm2/m64/m16bcst")[-1][1], "word ptr {addr}{1to4}")   # 변환 계열: 메모리 폭 기준

    def test_values(self):
        self.assertEqual(choices("imm8")[0][1], "0x12")       # 1이 아니라 시프트 1비트 행(D0/D1)과 겹치지 않음
        self.assertEqual(choices("imm32")[0][1], "0x12345678")  # imm8로 줄어들지 않는 값
        self.assertEqual(choices("<XMM0>"), [])               # 암묵 오퍼랜드는 소스에 없음
        self.assertEqual(choices("m14/28byte", "FNSTENV")[0][1], "{addr}")   # GNU 키워드 없는 폭
        self.assertEqual(choices("m2byte", "FSTCW")[0][1], "word ptr {addr}")
        self.assertEqual(choices("k1+1", "VP2INTERSECTD")[0][1], "k0")       # 짝 레지스터: 짝수 번호
        self.assertEqual(choices("r16/r32/r64", "UMONITOR")[0][1], "rcx")    # 주소 레지스터: 64비트 기본 주소
        self.assertEqual(choices("xmm2/mm128")[1][1], "xmmword ptr {addr}")  # PDF 오기 정리

    def test_unknown_symbol_is_an_error(self):
        with self.assertRaises(ValueError):
            choices("qq9")


class AliasTest(unittest.TestCase):
    def case(self, row_id, source, shape, expected):
        return {"row_id": row_id, "source": source, "shape": shape, "expected": expected, "alias_rows": ""}

    def test_invalid_row_with_same_syntax_as_valid_row(self):
        cases = [self.case(1, "inc cx", "inc r16", "reach"), self.case(2, "inc cx", "inc r16", "reject"),
                 self.case(3, "ja .Ltarget16", "ja .Ltarget16", "reject"),
                 self.case(4, "ja .Ltarget32", "ja .Ltarget32", "reach"),
                 self.case(5, "push ecx", "push r32", "reject")]
        G.mark_aliases(cases)
        self.assertEqual([c["expected"] for c in cases], ["reach", "alias_no_test", "alias_no_test", "reach", "reject"])
        self.assertEqual(cases[0]["alias_rows"], "2")

    def test_far_pointer_memory_alias(self):
        # CALL r/m32(N.E.)의 메모리 형식은 4바이트 먼 포인터 m16:16(유효)과 같은 문법. 레지스터 형식은 그대로 거부 시험
        cases = [dict(self.case(227, "call ecx", "call r32", "reject"), instruction="CALL r/m32", notes=""),
                 dict(self.case(227, "call dword ptr [rax]", "call dword ptr [r]", "reject"),
                      instruction="CALL r/m32", notes=""),
                 dict(self.case(231, "data16 call fword ptr [rax]", "data16 call fword ptr [r]", "reach"),
                      instruction="CALL m16:16", notes="")]
        G.mark_far_pointer_aliases(cases)
        self.assertEqual([c["expected"] for c in cases], ["reject", "alias_no_test", "reach"])
        self.assertEqual(cases[1]["alias_rows"], "231")
        self.assertEqual(cases[0]["alias_rows"], "")

    def test_shape_ignores_register_numbers_not_fixed_names(self):
        self.assertEqual(G.shape_of("reg", "mm1"), G.shape_of("reg", "mm0"))
        self.assertNotEqual(G.shape_of("fixed", "al"), G.shape_of("reg", "cl"))
        self.assertEqual(G.shape_of("reg", "xmm3 {k2}{z}"), "xmm {k}{z}")


class GeneratedOutputTest(unittest.TestCase):
    """전체 생성 결과의 대표 행(생성 파일이 없으면 건너뜀)."""

    def setUp(self):
        path = os.path.join(ROOT, "out/cases/cases.csv")
        if not os.path.exists(path):
            self.skipTest("out/cases 없음")
        self.cases = G.read_csv(path)

    def sources(self, opcode, instruction):
        return [c["source"] for c in self.cases if c["opcode"] == opcode and c["instruction"] == instruction]

    def test_rows_fixed_by_rewrite(self):
        self.assertIn("rcl dl, 0x12", self.sources("C0 /2 ib", "RCL r/m8, imm8"))
        self.assertIn("retf", self.sources("CB", "RET"))
        self.assertIn("data16 push 0x1234", self.sources("68 iw", "PUSH imm16"))
        self.assertEqual(self.sources("9C", "PUSHF"), ["pushfw"])          # 16비트 행: SDM 니모닉은 동의어로 다뤄짐
        self.assertEqual(self.sources("9C", "PUSHFQ"), ["pushfq"])
        leave = {c["instruction"] + c["source"] for c in self.cases if c["opcode"] == "C9"}
        self.assertIn("LEAVEdata16 leave", leave)
        self.assertIn("LEAVEleave", leave)
        self.assertIn("senduipi rcx", self.sources("F3 0F C7 /6", "SENDUIPI reg"))     # 명령 절: 64비트
        self.assertNotIn("bndmk bnd0, qword ptr [rip+0x10]", self.sources("F3 0F 1B /r", "BNDMK bnd, m64"))  # RIP는 #UD
        self.assertIn("tcmmimfp16ps tmm0, tmm1, tmm2", self.sources("VEX.128.66.0F38.W0 6C 11:rrr:bbb",
                                                                       "TCMMIMFP16PS tmm1, tmm2, tmm3"))

    def test_every_row_has_a_case(self):
        self.assertEqual(len({c["row_id"] for c in self.cases}), len(G.read_csv(G.ISA_DB)))


if __name__ == "__main__":
    unittest.main()

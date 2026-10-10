"""main/Sol 대조 분류 회귀. 기대값은 손으로 만든 작은 줄에서 정했다(실제 자료를 읽지 않음)."""

import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from pipeline import sdm_review_compare as cmp  # noqa: E402


def main_line(status="defined", kind="register", width="8", symbol="r8", symbol_id="SYM026"):
    return {"table_symbol": symbol, "status": status, "kind": kind, "data_width": width, "symbol_id": symbol_id}


def sol_line(kind="register", width="8", status="원문 확정", symbol="r8"):
    return {"table_symbol": symbol, "kind": kind, "data_width": width, "status": status,
            "source_level": "총론", "part": "part1", "mnemonic": "X"}


class CompareTest(unittest.TestCase):
    def test_agreement_needs_no_review(self):
        out = cmp.compare_line((1, 1), main_line(), sol_line())
        self.assertEqual((out["kind_result"], out["width_result"], out["needs_review"]), ("일치", "일치", ""))

    def test_kind_and_width_disagreement(self):
        out = cmp.compare_line((1, 1), main_line(kind="memory", width="256"),
                               sol_line(kind="register_or_memory", width="128"))
        self.assertEqual(out["kind_result"], "불일치")
        self.assertEqual(out["width_result"], "불일치")
        self.assertEqual(out["review_reasons"], "종류 불일치; 폭 불일치")

    def test_descriptive_width_is_not_auto_compared(self):
        out = cmp.compare_line((1, 1), main_line(width="32"), sol_line(width="reg 128 / mem 32"))
        self.assertEqual(out["width_result"], "Sol 서술형(수동 확인)")
        self.assertEqual(out["needs_review"], "")

    def test_footnote_only_symbol_difference(self):
        self.assertEqual(cmp.compare_symbol("^1 m2byte", "m2byte"), "각주·공백만 다름")
        self.assertEqual(cmp.compare_symbol("r32 <XMM0-6>", "r32"), "다름")

    def test_main_without_definition(self):
        out = cmp.compare_line((1, 1), main_line(status="no_definition", kind="", width=""),
                               sol_line(kind="register", width="512"))
        self.assertEqual(out["kind_result"], "main 총론 정의 없음·Sol 값 있음")
        self.assertEqual(out["width_result"], "main 빈칸·Sol 숫자")
        both_missing = cmp.compare_line((1, 1), main_line(status="no_definition", kind="", width=""),
                                        sol_line(kind="원문 없음", width="원문 없음", status="원문 없음"))
        self.assertEqual(both_missing["kind_result"], "둘 다 없음")
        self.assertEqual(both_missing["review_reasons"], "공통 기준 원문 없음")

    def test_literal_in_main(self):
        lit = main_line(status="literal_in_syntax", kind="literal", width="", symbol="AL")
        self.assertEqual(cmp.compare_kind(lit, sol_line(kind="literal")), "일치")
        self.assertEqual(cmp.compare_kind(lit, sol_line(kind="register")), "main 고정 표기·Sol 종류 있음")

    def test_one_sided_lines_and_row_zero(self):
        lines = cmp.compare_all({(1, 0): main_line(), (1, 1): main_line()},
                                {(1, 0): sol_line(), (1, 1): sol_line(), (1, 2): sol_line()})
        self.assertEqual([(x["row_id"], x["operand_index"]) for x in lines], [(1, 1), (1, 2)])
        self.assertEqual(lines[1]["kind_result"], "Sol에만 있음")
        self.assertEqual(lines[1]["needs_review"], "예")

    def test_conflict_status_needs_review(self):
        out = cmp.compare_line((1, 1), main_line(), sol_line(status="원문 충돌"))
        self.assertEqual(out["review_reasons"], "공통 기준 원문 충돌")

    def test_uniform_status_requires_kind_and_width(self):
        # Sol이 확정이라 했어도 폭이 비었거나 일부가 원문 없음이면 공통 기준에서는 원문 없음이다.
        self.assertEqual(cmp.uniform_status(sol_line(width="")), "원문 없음")
        self.assertEqual(cmp.uniform_status(sol_line(width="m512: 512 (ZMM 레지스터 폭은 원문 없음)")), "원문 없음")
        self.assertEqual(cmp.uniform_status(sol_line(kind="")), "원문 없음")
        self.assertEqual(cmp.uniform_status(sol_line()), "원문 확정")
        self.assertEqual(cmp.uniform_status(sol_line(status="원문 충돌", width="")), "원문 충돌")

    def test_lone_zmm_width_is_missing_by_decision_1(self):
        self.assertEqual(cmp.uniform_status(sol_line(symbol="zmm1 {k1}{z}", width="512")), "원문 없음")
        self.assertEqual(cmp.uniform_status(sol_line(symbol="zmm2", width="512")), "원문 없음")
        # zmm/m512 복합 표기와 xmm은 이 규칙 대상이 아니다.
        self.assertEqual(cmp.uniform_status(sol_line(symbol="zmm3/m512", width="512")), "원문 확정")
        self.assertEqual(cmp.uniform_status(sol_line(symbol="xmm1", width="128")), "원문 확정")

    def test_fixed_register_needs_no_width_by_decision_4(self):
        for name in ("AL", "DX", "RAX", "<XMM0>", "<XMM0-7>", "<eax>", "<edx>", "ST(0)", "AL^1", "1"):
            self.assertEqual(cmp.uniform_status(sol_line(symbol=name, kind="literal", width="")), "원문 확정", name)
        # 종류가 없으면 고정 레지스터라도 원문 없음, 기호 표기(r8, Sreg, imm8)는 여전히 폭이 필요하다.
        self.assertEqual(cmp.uniform_status(sol_line(symbol="AL", kind="원문 없음", width="")), "원문 없음")
        for name in ("r8", "Sreg", "imm8", "xmm1", "sibmem", "m8"):
            self.assertEqual(cmp.uniform_status(sol_line(symbol=name, width="")), "원문 없음", name)


class RowLevelTest(unittest.TestCase):
    def test_row_status_takes_worst(self):
        self.assertEqual(cmp.row_status(["원문 확정", "원문 확정"], "원문 확정"), "원문 확정")
        self.assertEqual(cmp.row_status(["원문 확정", "원문 없음"], "원문 확정"), "원문 없음")
        self.assertEqual(cmp.row_status(["원문 확정"], "원문 충돌"), "원문 충돌")
        # 오퍼랜드가 없는 행은 행 조건만 본다. 행 조건의 '원문 없음'은 오퍼랜드 판정에 쓰지 않는다.
        self.assertEqual(cmp.row_status([], "원문 확정"), "원문 확정")

    def test_extraction_defects(self):
        base = {"mnemonic": "PMINSD", "op_en": "", "opcode": "66 0F 38 39 /r", "operands": "xmm1, xmm2/m128"}
        self.assertEqual(cmp.extraction_defects(base), ["op_en 빈칸"])
        self.assertEqual(cmp.extraction_defects(dict(base, mnemonic="FADD")), [])
        self.assertEqual(cmp.extraction_defects(dict(base, mnemonic="XACQUIRE")), [])
        self.assertEqual(cmp.extraction_defects(dict(base, op_en="RV M")), ["op_en 공백 분리"])
        self.assertEqual(cmp.extraction_defects(dict(base, op_en="A", opcode="VEX.128.66.0F.W0 6E /")), ["opcode /r 누락(PDF 원문 오기)"])
        self.assertEqual(cmp.extraction_defects(dict(base, op_en="A", operands="INS m8, DX")), ["operands에 니모닉"])
        self.assertEqual(cmp.extraction_defects(dict(base, op_en="A", operands="r32, r64/m161")), ["operands 각주 숫자"])
        self.assertEqual(cmp.extraction_defects(dict(base, op_en="A", operands="EAX, imm32")), [])


if __name__ == "__main__":
    unittest.main()

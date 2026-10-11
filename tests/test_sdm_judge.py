"""검사 CLI의 SDM 판정(pipeline/sdm_judge.py) 회귀.

기대값은 SDM 표 행(행 번호는 data/db/isa_db.csv)과 바이트 손계산으로 정했다.
어셈블러 관측은 가짜 dict로 넣어 도구 없이 판정 규칙만 시험한다.
"""

import os
import sys
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline import sdm_judge as J  # noqa: E402
from pipeline.operand_forms import parse_instruction  # noqa: E402


def accepted(hex_bytes):
    return {"status": "accepted", "bytes": hex_bytes, "relocations": None, "assembly": {"stderr": ""}}


def rejected(message):
    return {"status": "rejected", "bytes": "", "relocations": None, "assembly": {"stderr": message}}


def instruction(row_id):
    return J.context()["isa"][row_id]["instruction"]


class CandidateTest(unittest.TestCase):
    def rows(self, code):
        return [c["row_id"] for c in J.candidates(parse_instruction(code))["rows"]]

    def test_register_and_memory_forms(self):
        self.assertEqual([instruction(r) for r in self.rows("add cx, dx")], ["ADD r/m16, r16", "ADD r16, r/m16"])
        # dword 메모리: r/m32(N.E.)와 m16:16(4바이트 먼 포인터, Vol.2 240쪽) 둘 다 형태가 맞다
        self.assertEqual([instruction(r) for r in self.rows("call dword ptr [rax]")], ["CALL r/m32", "CALL m16:16"])

    def test_kind_mismatch_is_not_a_candidate(self):
        # rbx는 CR0–CR7 칸이 아니다, 메모리는 rel 칸이 아니다
        self.assertEqual(self.rows("mov eax, rbx"), [])
        self.assertNotIn("CALL rel32", [instruction(r) for r in self.rows("call dword ptr [rax]")])

    def test_rep_spellings(self):
        separate = J.candidates(parse_instruction("rep movsb"))
        self.assertTrue(separate.get("rep_separate"))
        self.assertEqual([instruction(c["row_id"]) for c in separate["rows"]], ["MOVSB"])
        table = self.rows("rep movs byte ptr [rdi], byte ptr [rsi]")
        self.assertEqual([instruction(r) for r in table], ["REP MOVS m8, m8"])

    def test_expected_result(self):
        self.assertEqual(J.expected_of(J.candidates(parse_instruction("call word ptr [rax]"))["rows"]), "reject")
        self.assertEqual(J.expected_of(J.candidates(parse_instruction("add cx, dx"))["rows"]), "reach")
        self.assertEqual(J.expected_of([]), "unknown")


class AssemblerVerdictTest(unittest.TestCase):
    def verdict(self, code, observed, tool="gnu_as"):
        parsed = parse_instruction(code)
        cand = J.candidates(parsed)
        return J.judge_assembler(tool, observed, cand, J.expected_of(cand["rows"]), J.operands_text(parsed))

    def test_sdm_row_reached(self):
        out = self.verdict("add cx, dx", accepted("6601d1"))
        self.assertEqual((out["verdict"], [instruction(r) for r in out["rows"]]), ("SDM 일치", ["ADD r/m16, r16"]))

    def test_missing_66_is_another_row(self):
        # 01 d1(66 없음)은 ADD r/m32, r32 — 입력 add cx, dx의 후보가 아니다(66H 대조, Vol.1 Table 3-4)
        out = self.verdict("add cx, dx", accepted("01d1"))
        self.assertEqual((out["verdict"], [instruction(r) for r in out["rows"]]), ("다른 행 인코딩", ["ADD r/m32, r32"]))

    def test_invalid_row_accepted_as_far_call(self):
        out = self.verdict("call word ptr [rax]", accepted("ff18"), "clang")
        self.assertEqual((out["verdict"], [instruction(r) for r in out["rows"]]), ("다른 행으로 수용", ["CALL m16:32"]))
        self.assertEqual(self.verdict("call word ptr [rax]", rejected("Error: operand type mismatch"))["verdict"],
                         "SDM 일치(거부)")

    def test_user_label_branch(self):
        # jne .Lx (자기 자신으로 가는 짧은 분기 75 fe): 꼬리 폭만 보고 목표 거리는 보지 않는다
        out = self.verdict("jne .Lx", accepted("75fe"))
        self.assertEqual((out["verdict"], [instruction(r) for r in out["rows"]]), ("SDM 일치", ["JNE rel8"]))

    def test_default_off_note(self):
        out = self.verdict("bndcl bnd0, rcx", rejected("Error: `bndcl' is not supported on `x86_64'"))
        self.assertEqual(out["verdict"], "거부")
        self.assertIn("-march=generic64+mpx", out["note"])

    def test_expected_row(self):
        row = J.context()["isa"][39]                       # ADD r/m16, r16
        self.assertEqual(J.judge_expected_row(accepted("6601d1"), dict(row, row_id="39"), "cx, dx"), "fields_match")
        self.assertEqual(J.judge_expected_row(accepted("01d1"), dict(row, row_id="39"), "cx, dx"), "different_encoding")


if __name__ == "__main__":
    unittest.main()

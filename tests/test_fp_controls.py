"""SDM ER/SAE 조건, 모드가 바뀐 바이트와 장식 누락 반례."""
import unittest

from pipeline import fp_controls as FP
from pipeline import m2_generate as G
from pipeline import m4_disasm as D
from pipeline import sdm_judge as J
from pipeline.encoding_audit import check_encoding
from pipeline.operand_forms import parse_instruction


class ControlsTest(unittest.TestCase):
    def candidates(self, code):
        return J.candidates(parse_instruction(code))["rows"]

    def test_correct_rows_and_forbidden_forms(self):
        self.assertEqual([r["row_id"] for r in self.candidates(
            "vaddpd zmm0, zmm1, zmm2, {rd-sae}")], [51])
        self.assertEqual([r["row_id"] for r in self.candidates(
            "vcomisd xmm0, xmm1, {sae}")], [424])
        self.assertEqual([r["row_id"] for r in self.candidates(
            "vcmppd k1, zmm0, zmm1, {sae}, 0x12")], [395])
        self.assertEqual([r["row_id"] for r in self.candidates(
            "vcvtsi2sd xmm0, xmm1, {rd-sae}, rcx")], [488])
        for code in (
            "vaddpd ymm0, ymm1, ymm2, {rn-sae}",
            "vaddpd zmm0, zmm1, zmmword ptr [rax], {rn-sae}",
            "vcomisd xmm0, qword ptr [rax], {sae}",
            "vaddpd zmm0, zmm1, zmm2, {sae}",
            "vaddpd zmm0, {rd-sae}, zmm1, zmm2",
            "vaddpd zmm0, zmm1, {rd-sae}, zmm2",
            "vaddpd zmm0, zmm1, zmm2, {rd-sae}, {rn-sae}",
            "vaddpd zmm0, zmm1, zmm2, {bad-sae}",
        ):
            self.assertEqual(self.candidates(code), [], code)

    def row(self, index, operands):
        return dict(J.context()["isa"][index],
                    operand_types=J.context()["isa"][index]["operands"], operands=operands)

    def test_requested_rc_and_sae_bit(self):
        # VADDPD: EVEX P2 b=1, RC=00/01/10/11 (SDM Table 2-38).
        for control, p2 in (("rn", "18"), ("rd", "38"), ("ru", "58"), ("rz", "78")):
            row = self.row(51, f"zmm0, zmm1, zmm2, {{{control}-sae}}")
            checked = check_encoding("62f1f5" + p2 + "58c2", row)
            self.assertEqual(checked["status"], "fields_match")
            self.assertIn("EVEX_rounding_RC", checked["checked_fields"])
            self.assertNotIn("EVEX_rounding_LL", checked["unverified_fields"])
            wrong_p2 = "38" if control == "rn" else "18"
            self.assertEqual(check_encoding("62f1f5" + wrong_p2 + "58c2", row)["status"],
                             "different_encoding")
            self.assertEqual(check_encoding("62f1f54858c2", row)["status"], "different_encoding")
        row = self.row(424, "xmm0, xmm1, {sae}")
        self.assertEqual(check_encoding("62f1fd182fc1", row)["status"], "fields_match")
        self.assertEqual(check_encoding("62f1fd082fc1", row)["status"], "different_encoding")
        # SAE-only LL ignored (Table 2-43 note 2), unlike ER's requested RC.
        self.assertEqual(check_encoding("62f1fd782fc1", row)["status"], "fields_match")
        self.assertEqual(check_encoding("62f1fd182f01", row)["status"], "different_encoding")
        row = self.row(424, "xmm0, qword ptr [rax], {sae}")
        self.assertEqual(check_encoding("62f1fd182fc1", row)["status"], "different_encoding")
        row = self.row(51, "zmm0, zmm1, zmm2")
        self.assertEqual(check_encoding("62f1f51858c2", row)["status"], "different_encoding")
        self.assertEqual(check_encoding("62f1f54858c2", row)["status"], "fields_match")

    def test_expected_row_cannot_ignore_an_unsupported_control(self):
        # --expect-row도 후보 탐색과 별도로 ER/SAE 조건을 확인해야 한다.
        row = self.row(39, "cx, dx, {rn-sae}")
        self.assertEqual(check_encoding("6601d1", row)["status"], "different_encoding")
        row = self.row(50, "ymm0, ymm1, ymm2, {rn-sae}")
        self.assertEqual(check_encoding("62f1f52858c2", row)["status"], "different_encoding")
        row = self.row(488, "xmm0, xmm1, {rd-sae}, rcx")
        self.assertEqual(check_encoding("62f1f7382ac1", row)["status"], "fields_match")
        self.assertEqual(check_encoding("62f1f7182ac1", row)["status"], "different_encoding")

    def test_generated_modes_and_existing_ids(self):
        rows = G.load_rows()
        cases = G.generate([rows[i] for i in (51, 395, 424, 2888)])
        additions = [c for c in cases if c["variant"].startswith(("er:", "sae"))]
        self.assertEqual(len(additions), 13)
        self.assertEqual({c["variant"] for c in additions if c["row_id"] == 51},
                         {"er:" + mode + "-sae" + mask
                          for mode in ("rn", "rd", "ru", "rz") for mask in ("", ":mask")})
        self.assertTrue(all("[" not in c["source"] for c in additions))
        self.assertTrue(all("Vol.2 72" in c["evidence"] for c in additions))
        for case in additions:
            self.assertIn(case["row_id"], [r["row_id"] for r in self.candidates(case["source"])])

    def test_disassembly_checks_control_not_just_registers(self):
        row = J.context()["isa"][51]
        case = {"operands": "zmm0, zmm1, zmm2, {rd-sae}"}
        self.assertTrue(D.compare_operands(case, "zmm0, zmm1, zmm2, {rd-sae}", False, False, row))
        self.assertFalse(D.compare_operands(case, "zmm0, zmm1, zmm2, {rn-sae}", False, False, row))
        self.assertFalse(D.compare_operands(case, "zmm0, zmm1, zmm2", False, False, row))
        row = J.context()["isa"][395]
        case = {"operands": "k0, zmm0, zmm1, {sae}, 0x12"}
        self.assertTrue(D.compare_operands(case, "k0, zmm0, zmm1, {sae}", True, False, row))
        self.assertFalse(D.compare_operands(case, "k0, zmm0, zmm1", True, False, row))


if __name__ == "__main__":
    unittest.main()

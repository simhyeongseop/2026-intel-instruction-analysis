import unittest

from pipeline.input_quality import (blocking_issues, compare_extraction_text, gate_exit_code,
                                    require_validated_tokens, validate_operand_list,
                                    validate_operand_token)
from pipeline import m2_tokenize
from pipeline.m3_combine import assign_stable_combo_ids
from scripts.run_spec_probe import build_delta


class InputQualityTests(unittest.TestCase):
    def test_extraction_width_gate_detects_m161(self):
        result = validate_operand_token("r64/m161", row_id=992, token_row_id=1937)
        self.assertEqual(result["validation_status"], "extraction_suspect")
        self.assertIn("invalid_composite_memory_width", result["validation_codes"])

    def test_extraction_width_gate_allows_special_memory_sizes(self):
        for token in ("m14/28byte", "m94/108byte", "m384"):
            with self.subTest(token=token):
                self.assertEqual(validate_operand_token(token)["validation_status"], "valid")

    def test_character_gate_detects_unicode_and_dot(self):
        dash = validate_operand_token("CR0–CR7", row_id=1118)
        self.assertEqual(dash["normalized"], "CR0-CR7")
        self.assertEqual(dash["validation_status"], "normalized")
        dotted = validate_operand_token("ymm3/.m256", row_id=1582)
        self.assertEqual(dotted["validation_status"], "extraction_suspect")
        self.assertIn("unexpected_dot_before_memory", dotted["validation_codes"])

    def test_delimiter_gate_detects_encodekey_row(self):
        issues = validate_operand_list("r32, r32 <XMM0-6>", row_id=570)
        self.assertEqual([item["rule"] for item in issues], ["missing_operand_delimiter"])
        self.assertEqual(blocking_issues(issues), issues)

    def test_token_validation_status_is_required(self):
        with self.assertRaisesRegex(ValueError, "missing R0 columns"):
            require_validated_tokens([{"operand_token": "r64/m161"}])

    def test_dual_extraction_diff_is_suspect(self):
        issues = compare_extraction_text("xmm3/m128", "xmm3 /m128", row_id=1)
        self.assertEqual(issues[0]["rule"], "dual_extraction_mismatch")
        self.assertEqual(issues[0]["disposition"], "extraction_suspect")

    def test_tokenizer_marks_tokens_and_gate_fails_on_suspect(self):
        row = {"opcode": "0F 02 /r", "instruction": "LAR r32, r64/m161",
               "mnemonic": "LAR", "operands": "r32, r64/m161", "op_en": "RM",
               "mode_support": "Valid", "cpuid_flag": "", "description": "fixture",
               "source_page": "999"}
        token_rows, issues = m2_tokenize.tokenize_row(row, 992)
        self.assertEqual(gate_exit_code(issues), 2)
        self.assertEqual(token_rows[1]["validation_status"], "extraction_suspect")
        self.assertTrue({"raw_operand_token", "normalized_operand_token",
                         "validation_status", "validation_codes"} <= set(token_rows[0]))

    def test_reviewed_corrections_preserve_raw_values(self):
        base = {"opcode": "", "op_en": "", "mode_support": "Valid",
                "cpuid_flag": "", "description": "fixture"}
        lar = dict(base, instruction="LAR r32, r64/m161", mnemonic="LAR",
                   operands="r32, r64/m161", source_page="651")
        rows, issues = m2_tokenize.tokenize_row(lar, 992)
        self.assertEqual(rows[1]["raw_operand_token"], "r64/m161")
        self.assertEqual(rows[1]["normalized_operand_token"], "r64/m16")
        self.assertFalse(blocking_issues(issues))
        self.assertEqual(issues[0]["disposition"], "known_issue")

        encode = dict(base, instruction="ENCODEKEY256 r32, r32 <XMM0-6>",
                      mnemonic="ENCODEKEY256", operands="r32, r32 <XMM0-6>",
                      source_page="403")
        rows, issues = m2_tokenize.tokenize_row(encode, 570)
        self.assertEqual([row["operand_token"] for row in rows], ["r32", "r32"])
        self.assertEqual(rows[1]["raw_operand_token"], "r32 <XMM0-6>")
        self.assertEqual(rows[1]["implicit_operands"], "<XMM0-6>")
        self.assertFalse(blocking_issues(issues))

    def test_probe_delta_preserves_lineage_and_observation_changes(self):
        before = [{"case_id": "combo_1", "status": "accepted", "as_bytes": "90"},
                  {"case_id": "combo_2", "status": "rejected", "as_bytes": ""}]
        after = [{"case_id": "combo_1", "status": "needs_review", "as_bytes": "90"},
                 {"case_id": "combo_3", "status": "accepted", "as_bytes": "90"}]
        delta = build_delta(before, after)
        self.assertEqual([row["case_id"] for row in delta], ["combo_1", "combo_2", "combo_3"])
        self.assertEqual(delta[0]["changes"]["status"], ["accepted", "needs_review"])
        self.assertEqual(delta[1]["lineage_status"], "unmatched")

    def test_new_combo_does_not_renumber_existing_ids(self):
        prior = [{"combo_id": "10", "row_id": "1", "combo_index": "0"},
                 {"combo_id": "11", "row_id": "2", "combo_index": "0"}]
        current = [{"row_id": "1", "combo_index": 0},
                   {"row_id": "1", "combo_index": 1},
                   {"row_id": "2", "combo_index": 0}]
        assigned = assign_stable_combo_ids(current, prior)
        self.assertEqual([row["combo_id"] for row in assigned], [10, 12, 11])


if __name__ == "__main__":
    unittest.main(verbosity=2)

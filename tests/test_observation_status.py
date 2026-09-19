"""5단계가 '진단 거부'와 '도구 사건'을 구분해 기록하는지 확인한다.

예전에는 crashed/timeout 이 모두 error 로 뭉개져서, 도구가 죽은 것과 입력이 틀린 것을
구별할 수 없었다. 그러면 7단계가 도구 사건을 false_alarm 으로 내릴 수 있다.
"""

from pathlib import Path
import shutil
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from pipeline.m5_assemble import assemble_one, judge_mismatch
from pipeline.m7_triage import build_triage_rows

HAVE_AS = shutil.which("as") is not None


def asm_row(**kwargs):
    row = {"combo_id": "99999", "row_id": "0", "combo_index": "0", "mnemonic": "TESTINS",
           "cpuid": "", "note": "", "source_line": "1", "asm_line": "testins ecx",
           "expected_valid": "True", "mode_support": "Valid", "actual_result": "error",
           "mismatch": "False", "error_message": "", "object_file_path": ""}
    row.update(kwargs)
    return row


class AssembleStatus(unittest.TestCase):
    @unittest.skipUnless(HAVE_AS, "as 없음")
    def test_accepted_and_rejected_are_distinguished(self):
        with tempfile.TemporaryDirectory() as tmp:
            self.assertEqual(assemble_one("nop", tmp)[0], "ok")
            status, message, obj = assemble_one("mov eax, rbx", tmp)
        self.assertEqual(status, "error")
        self.assertIn("Error", message)
        self.assertIsNone(obj)

    def test_mismatch_uses_ok_only(self):
        """crashed/timeout 은 성공으로 세지 않는다."""
        self.assertFalse(judge_mismatch("True", "ok"))
        self.assertTrue(judge_mismatch("True", "error"))
        self.assertTrue(judge_mismatch("True", "crashed"))
        self.assertTrue(judge_mismatch("True", "timeout"))


class ProcessFailureTriage(unittest.TestCase):
    def test_crash_is_not_dismissed(self):
        rows = build_triage_rows([asm_row(actual_result="crashed",
                                          error_message="as가 시그널 11로 종료")], [])
        self.assertEqual(len(rows), 1)
        self.assertEqual(rows[0]["category"], "tool_process_failure")
        self.assertEqual(rows[0]["verdict"], "unsure")

    def test_timeout_is_not_dismissed(self):
        rows = build_triage_rows([asm_row(actual_result="timeout")], [])
        self.assertEqual(rows[0]["verdict"], "unsure")

    def test_normal_rows_are_unaffected(self):
        self.assertEqual(build_triage_rows([asm_row(actual_result="ok")], []), [])


if __name__ == "__main__":
    unittest.main(verbosity=2)

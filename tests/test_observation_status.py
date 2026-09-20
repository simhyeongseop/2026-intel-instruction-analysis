"""5단계가 '진단 거부'와 '도구 사건'을 구분해 기록하는지 확인한다.

예전에는 crashed/timeout 이 모두 error 로 뭉개져서, 도구가 죽은 것과 입력이 틀린 것을
구별할 수 없었다. 그러면 7단계가 도구 사건을 false_alarm 으로 내릴 수 있다.
"""

from pathlib import Path
import shutil
import subprocess
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


class ObjdumpBatchRetry(unittest.TestCase):
    """objdump 배치가 일시적으로 느려졌을 때 단계 전체가 죽지 않아야 한다.

    2026-09-20에 8단계가 오브젝트 23,157개를 막 쓴 직후 9단계의 배치 하나가 180초를
    넘겨 단계가 실패했다. 같은 배치를 나중에 재보면 2.8초였다(파일시스템 일시 지연).
    """

    def setUp(self):
        from pipeline import m9_clang_compare
        self.module = m9_clang_compare
        self.real_run = subprocess.run
        self.calls = []

    def tearDown(self):
        subprocess.run = self.real_run

    def fake_run(self, limit):
        def run(args, **kwargs):
            size = len(args) - 1
            self.calls.append(size)
            if size > limit:
                raise subprocess.TimeoutExpired(args, kwargs.get("timeout"))
            return subprocess.CompletedProcess(args, 0, stdout=f"[{size}]", stderr="")
        return run

    def test_slow_batch_is_split_and_merged(self):
        subprocess.run = self.fake_run(limit=2)
        result = self.module.run_objdump_batch(["objdump"], [f"f{i}" for i in range(8)])
        self.assertEqual(self.calls[0], 8)          # 먼저 통째로 시도하고
        self.assertEqual(max(self.calls[1:]), 4)    # 반씩 갈라 다시 시도한다
        self.assertEqual(result.stdout, "[2][2][2][2]")  # 출력은 순서대로 합쳐진다

    def test_single_file_timeout_still_fails(self):
        """반례: 파일 하나가 정말 안 끝나면 조용히 넘어가면 안 된다."""
        subprocess.run = self.fake_run(limit=0)
        with self.assertRaises(subprocess.TimeoutExpired):
            self.module.run_objdump_batch(["objdump"], ["only.o"])

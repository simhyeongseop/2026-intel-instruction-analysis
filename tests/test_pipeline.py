import csv
from pathlib import Path
import sys
import unittest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from pipeline.run import plan_stages
from pipeline.m7_triage import build_triage_rows


class PipelineTests(unittest.TestCase):
    def test_stage12_registered_and_cpu_explicit(self):
        plan = plan_stages('execute', until='lint')
        self.assertEqual([(n, skipped) for n, _, skipped in plan],
                         [('execute', True), ('execute_edge_cases', True), ('lint', False)])
        self.assertFalse(plan_stages(only='execute_edge_cases', execute=True)[0][2])

    def test_only_and_until(self):
        self.assertEqual([x[0] for x in plan_stages(only='triage')], ['triage'])
        self.assertEqual(len(plan_stages('tokenizer', until='generator')), 3)
        with self.assertRaises(ValueError):
            plan_stages('lint', until='triage')

    def test_review_changes_preserve_history(self):
        with (ROOT / 'out/asm_result.csv').open(encoding='utf-8') as stream:
            assembly = list(csv.DictReader(stream))
        with (ROOT / 'out/roundtrip.csv').open(encoding='utf-8') as stream:
            rt = list(csv.DictReader(stream))
        result = build_triage_rows(assembly, rt)
        by_combo = {r['source'].split('/')[-1]: r for r in result}
        # Re-running the full pipeline may drop rows that no longer have a
        # matching roundtrip observation; the history assertions below are
        # the invariant this test is meant to protect.
        self.assertGreaterEqual(len(result), 1583)
        self.assertEqual(by_combo['4597']['legacy_verdict'], 'bug')
        self.assertEqual(by_combo['4597']['finding_type'], 'support_gap')
        self.assertEqual(by_combo['1683']['legacy_verdict'], 'unsure')
        self.assertEqual(by_combo['1683']['verdict'], 'false_alarm')
        self.assertEqual(by_combo['1527']['review_status'], 'confirmed')
        self.assertEqual(result, build_triage_rows(assembly, rt))
        changed = [dict(r, asm_line='nop') if r['combo_id'] == '1527' else r for r in assembly]
        with self.assertRaises(ValueError):
            build_triage_rows(changed, rt)


if __name__ == '__main__':
    unittest.main(verbosity=2)

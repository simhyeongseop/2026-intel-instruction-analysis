from pathlib import Path
import sys
import unittest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from pipeline.run import plan_stages


class PipelineTests(unittest.TestCase):
    def test_current_stages(self):
        self.assertEqual([n for n, _, _ in plan_stages()], ['extractor', 'generator', 'check', 'disasm'])
        self.assertEqual([x[0] for x in plan_stages(only='check')], ['check'])
        self.assertEqual([x[0] for x in plan_stages('generator', until='check')], ['generator', 'check'])
        with self.assertRaises(ValueError):
            plan_stages('check', until='generator')


if __name__ == '__main__':
    unittest.main(verbosity=2)

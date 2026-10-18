"""원문 없음 완화 규칙 회귀. 기대값은 손으로 정했고, 근거 문장은 실제 원문(Vol.1·Vol.2 색인, 총론 기호 CSV)에서 찾는다."""

import csv
import os
import re
import sys
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline import sdm_relaxation as rx  # noqa: E402


def squeeze(text):
    return re.sub(r"\s+", "", text)


class RuleTest(unittest.TestCase):
    def test_vol1_registers(self):
        self.assertEqual(rx.relax("zmm1 {k1}{z}")[:3], (rx.RELAXED_A, "register", "512"))
        self.assertEqual(rx.relax("ST(i)")[:3], (rx.RELAXED_A, "register", "80"))

    def test_combination(self):
        status, kind, width, _ = rx.relax("xmm3/m128/m32bcst")
        self.assertEqual((status, kind, width), (rx.RELAXED_B, "register_or_memory", "xmm 128 / m128 128 / m32bcst 원소 32"))
        self.assertEqual(rx.relax("zmm2/m512")[0], rx.RELAXED_A)       # zmm 부분이 Vol.1 근거
        self.assertEqual(rx.relax("zmm3 /m512")[0], rx.RELAXED_A)      # 슬래시 앞 공백
        self.assertEqual(rx.relax("xmm2/m16")[2], "xmm 128 / m16 16")
        self.assertEqual(rx.relax("r32a")[:3], (rx.RELAXED_B, "register", "32"))
        self.assertEqual(rx.relax("k1+1")[:3], (rx.RELAXED_B, "register", "64"))

    def test_not_relaxed(self):
        for symbol in ("m2byte", "xmm3/m128/m8bcst"):
            self.assertIsNone(rx.relax(symbol), symbol)
        self.assertIsNone(rx.relax("m2byte", "FSTSW"))   # 상태 워드는 이 규칙 대상이 아니다

    def test_other_section(self):
        status, kind, width, evidence = rx.relax("xmm3/m128/m16bcst")
        self.assertEqual((status, kind, width), (rx.RELAXED_D, "register_or_memory", "xmm 128 / m128 128 / m16bcst 원소 16"))
        self.assertIn("1889 VMAXPH", evidence)
        self.assertEqual(rx.relax("zmm3/m512/m16bcst {er}")[0], rx.RELAXED_D)   # zmm(A)보다 D가 우선 표시

    def test_x87_control_word(self):
        self.assertEqual(rx.relax("m2byte", "FNSTCW")[:3], (rx.RELAXED_A, "memory", "16"))

    def test_variable(self):
        self.assertEqual(rx.relax("tmm1")[:3], (rx.VARIABLE_C, "register", "가변"))
        self.assertEqual(rx.relax("vm32y {k1}")[0], rx.VARIABLE_C)
        self.assertEqual(rx.relax("mib")[2], "해당 없음")
        self.assertEqual(rx.relax("mem", "XSAVE")[:3], (rx.VARIABLE_C, "memory", "가변(XSAVE 영역)"))
        self.assertIn("XCR0 | IA32_XSS", rx.relax("mem", "XSAVES64")[3])
        # 반례: XSAVE 계열이 아니면 'mem'은 그대로 원문 없음
        self.assertIsNone(rx.relax("mem", "LDDQU"))
        self.assertIsNone(rx.relax("mem"))


class EvidenceTest(unittest.TestCase):
    """규칙 표의 인용문이 적힌 곳에 실제로 있는지 확인한다(색인이 없으면 건너뜀)."""

    def setUp(self):
        from pipeline import manual_index
        try:
            self.vol1 = manual_index.ManualIndex(os.path.join(ROOT, "out/manual_index_vol1"))
            self.vol2 = manual_index.ManualIndex(os.path.join(ROOT, "out/manual_index"))
        except OSError:
            self.skipTest("매뉴얼 색인 없음")
        with open(os.path.join(ROOT, "data/rules/sdm_symbols.csv"), encoding="utf-8") as handle:
            self.symbols = {r["symbol_id"]: r["source_text"] for r in csv.DictReader(handle)}

    def check(self, where, quote):
        if where.startswith("SYM"):
            self.assertIn(squeeze(quote), squeeze(self.symbols[where]), where)
            return
        volume, page = where.split()[0], int(where.split()[1])
        index = self.vol1 if volume == "Vol.1" else self.vol2
        self.assertIn(squeeze(quote), squeeze(index.page_text(page)), where)

    def test_all_quotes(self):
        entries = list(rx.PARTS.values()) + list(rx.VARIABLE.values()) + list(rx.OTHER_SECTION.values()) + [rx.X87]
        entries += [(None, None) + rx.VOL2_FSTCW, (None, None) + rx.VOL1_CONTROL_WORD]
        entries += [(None, None) + rx.VOL1_XSAVE_SIZE, (None, None) + rx.VOL1_XSAVE_COMPACTED,
                    (None, None) + rx.VOL2_XSAVE_RFBM]
        for _, _, where, quote in entries:
            self.check(where, quote)


if __name__ == "__main__":
    unittest.main()

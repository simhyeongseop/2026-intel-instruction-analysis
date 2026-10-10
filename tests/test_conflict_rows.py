"""남은 충돌 행 대조 스크립트의 판정·하드코딩 회귀. 기대값은 손으로 만든 입력과 인코딩 형식에서 정했다."""

import csv
import importlib.util
import os
import re
import sys
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)
sys.path.insert(0, os.path.join(ROOT, "scripts"))
SPEC = importlib.util.spec_from_file_location("check_conflict_rows", os.path.join(ROOT, "scripts", "check_conflict_rows.py"))
script = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(script)


def tool(status="accepted", data="62f37d0854c001", encoding="fields_match"):
    return {"observation_status": status, "bytes": data, "encoding": encoding}


class VerdictTest(unittest.TestCase):
    combo = {"test_kind": "normal"}

    def test_levels(self):
        self.assertEqual(script.verdict(self.combo, tool(), tool(), False), "통과")
        self.assertEqual(script.verdict(self.combo, tool(), tool(status="diagnostic_rejection", data=""), False),
                         "통과(GNU 단독)")
        self.assertEqual(script.verdict(self.combo, tool(), tool(data="00"), False), "통과(GNU 단독)")
        self.assertEqual(script.verdict(self.combo, tool(encoding="different_encoding"), tool(), False), "불일치")
        self.assertEqual(script.verdict(self.combo, tool(), tool(), True), "불일치")
        self.assertEqual(script.verdict(self.combo, tool(encoding="not_checked"), tool(encoding="not_checked"), False),
                         "조립 일치(인코딩 미대조)")
        self.assertEqual(script.verdict({"test_kind": "negative"}, tool(), tool(), False), "음성 케이스")
        self.assertEqual(script.verdict(self.combo, tool(encoding="different_encoding"), tool(), False, True),
                         "도달 불가(별칭)")
        self.assertEqual(script.verdict(self.combo, tool(status="diagnostic_rejection", data="", encoding="not_checked"),
                                        tool(), False, True), "도달 불가(문법)")
        # 목록에 없으면 GNU 거부는 불일치다.
        self.assertEqual(script.verdict(self.combo, tool(status="diagnostic_rejection", data="", encoding="not_checked"),
                                        tool(), False, False), "불일치")
        # 하드코딩한 별칭 목록에 있어도 표 행에 도달했으면 통과다.
        self.assertEqual(script.verdict(self.combo, tool(), tool(), False, True), "통과")

    def test_classify(self):
        self.assertEqual(script.classify('Operation "Store-Form"는 병합 마스킹만'), "store_zeroing")
        self.assertEqual(script.classify("NOTES 3은 moffs 숫자가 데이터 크기"), "moffs_meaning")
        self.assertEqual(script.classify("아무 관련 없음"), "other")


class OverrideTest(unittest.TestCase):
    def setUp(self):
        with open(os.path.join(ROOT, "data/rules/encoding_check_overrides.csv"), encoding="utf-8") as handle:
            self.rows = {r["row_id"]: r for r in csv.DictReader(handle)}

    def test_map5_patterns(self):
        load, store = self.rows["3426"]["byte_pattern"], self.rows["3427"]["byte_pattern"]
        # 62 F5 7E 08 10 00: P0 F5(map 101), P1 7E(W0, vvvv 1111, pp F3), opcode 10
        self.assertTrue(re.match(load, "62f57e081000"))
        self.assertTrue(re.match(load, "6762f57e891000"))
        self.assertTrue(re.match(store, "62f57e091100"))
        # 반례: map 1(F1), W1(FE), pp 66(7D), 다른 opcode
        for wrong in ("62f17e081000", "62f5fe081000", "62f57d081000", "62f57e081100"):
            self.assertFalse(re.match(load, wrong), wrong)

    def test_check_opcode_rows_match_table(self):
        with open(os.path.join(ROOT, "data/db/isa_db.csv"), encoding="utf-8") as handle:
            isa = list(csv.DictReader(handle))
        for row_id, row in self.rows.items():
            self.assertEqual(isa[int(row_id)]["opcode"], row["table_opcode"], row_id)
            self.assertTrue(row["check_opcode"] or row["byte_pattern"], row_id)

    def test_encoding_status_uses_override(self):
        combo = {"row_id": "3041", "opcode": "EVEX.128.66.0F3A.W0 54 /r", "mnemonic": "VFIXUPIMMPS",
                 "operands": "xmm0, xmm0, xmm0, 1", "operand_types": ""}
        data = "62f37d0854c001"
        self.assertEqual(script.encoding_status(data, combo, False, None), "different_encoding")
        self.assertEqual(script.encoding_status(data, combo, False, self.rows["3041"]), "fields_match")
        # 반례: opcode 바이트가 55면 보정 opcode로도 맞지 않는다.
        self.assertEqual(script.encoding_status("62f37d0855c001", combo, False, self.rows["3041"]), "different_encoding")


if __name__ == "__main__":
    unittest.main()

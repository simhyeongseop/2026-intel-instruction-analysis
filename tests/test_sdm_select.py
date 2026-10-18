"""선택 규칙 회귀. 기대값은 SDM 원문(파일 105~107쪽 목록, 127·132·731쪽 표)을 직접 읽고 정했다."""

import csv
import os
import sys
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline import sdm_select  # noqa: E402


EVIDENCE = os.path.join(ROOT, "out/sdm_evidence_093/rows.jsonl")


def isa_rows_on(*pages):
    """isa_db 행 + Operand Encoding 원문 줄(근거 묶음이 있으면)."""
    import json
    with open(os.path.join(ROOT, "data/db/isa_db.csv"), encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle))
    lines = {}
    if os.path.exists(EVIDENCE):
        with open(EVIDENCE, encoding="utf-8") as handle:
            for line in handle:
                record = json.loads(line)
                lines[record["row_id"]] = record["op_en_lines"][0][1] if record["op_en_lines"] else ""
    wanted = {str(p) for p in pages}
    return [dict(row, row_id=i, op_en_line=lines.get(i, "")) for i, row in enumerate(rows)
            if row["source_page"] in wanted]


class ExpandListTest(unittest.TestCase):
    def test_source_order_and_ranges(self):
        self.assertEqual(sdm_select.expand_register_list("AL, CL, DL, BL, AH, CH, DH, BH, BPL, SPL, DIL, and SIL"),
                         ["AL", "CL", "DL", "BL", "AH", "CH", "DH", "BH", "BPL", "SPL", "DIL", "SIL"])
        r64 = sdm_select.expand_register_list("RAX, RBX, RCX, RDX, RDI, RSI, RBP, RSP, R8–R15")
        self.assertEqual(r64[:4], ["RAX", "RBX", "RCX", "RDX"])   # r64 원문 순서는 r32(EAX, ECX, ...)와 다르다
        self.assertEqual(r64[-1], "R15")
        self.assertEqual(len(r64), 16)
        xmm = sdm_select.expand_register_list("XMM0 through XMM7; XMM8 through XMM15 are available using REX")
        self.assertEqual(xmm, ["XMM%d" % i for i in range(16)])
        self.assertEqual(sdm_select.expand_register_list("k0 through k7")[0], "K0")
        byte_ext = sdm_select.expand_register_list("one of the byte registers (R8B - R15B) available when using REX")
        self.assertEqual(byte_ext[0], "R8B")
        self.assertEqual(byte_ext[-1], "R15B")


class FixedRowExclusionTest(unittest.TestCase):
    def test_add_section_excludes_accumulator(self):
        rows = isa_rows_on(132)            # ADD 표: 'ADD AL, imm8', 'ADD AX, imm16', 'ADD EAX, imm32', 'ADD RAX, imm32'
        fixed = sdm_select.fixed_registers(rows)
        self.assertTrue({"AL", "AX", "EAX", "RAX"} <= fixed)
        self.assertEqual(sdm_select.pick_register("AL, CL, DL, BL, AH, CH, DH, BH, BPL, SPL, DIL, and SIL", fixed)[0], "CL")
        self.assertEqual(sdm_select.pick_register("RAX, RBX, RCX, RDX, RDI, RSI, RBP, RSP, R8–R15", fixed)[0], "RBX")

    def test_without_fixed_rows_first_item_is_kept(self):
        self.assertEqual(sdm_select.pick_register("XMM0 through XMM7", set())[0], "XMM0")
        self.assertEqual(sdm_select.pick_register("XMM0 through XMM7", {"XMM0"})[0], "XMM1")   # <XMM0> 고정 오퍼랜드


@unittest.skipUnless(os.path.exists(EVIDENCE), "근거 묶음이 없다")
class DirectionPairTest(unittest.TestCase):
    def test_modrm_order_from_operand_encoding_text(self):
        self.assertEqual(sdm_select.modrm_order("MR ModRM:r/m (w) ModRM:reg (r) N/A N/A"), ("r/m", "reg"))
        self.assertEqual(sdm_select.modrm_order("A Full Mem ModRM:reg (w) ModRM:r/m (r) N/A N/A"), ("reg", "r/m"))
        self.assertIsNone(sdm_select.modrm_order("OI opcode + rd (w) imm8/16/32/64 N/A N/A"))

    def test_mov_pairs_from_table(self):
        rows = isa_rows_on(731)            # MOV 88/8A, 89/8B(16·32), REX.W 89/8B
        pairs = sdm_select.direction_pairs(rows)
        by_id = {r["row_id"]: r for r in rows}
        self.assertTrue(all(not same for _, _, same in pairs))
        named = sorted((by_id[a]["opcode"], by_id[b]["opcode"], by_id[a]["operands"]) for a, b, _ in pairs)
        self.assertEqual(named, sorted([
            ("88 /r", "8A /r", "r/m8, r8"),
            ("89 /r", "8B /r", "r/m16, r16"),
            ("89 /r", "8B /r", "r/m32, r32"),
            ("REX.W + 89 /r", "REX.W + 8B /r", "r/m64, r64"),
        ]))
        # 반례: 8C(MOV r/m16, Sreg)와 8E(MOV Sreg, r/m16)는 오퍼랜드가 뒤바뀌었지만 레지스터 종류가 달라
        # 'mov ax, ds' / 'mov ds, ax'로 문자열이 갈린다. 방향 쌍이 아니다.
        self.assertFalse([p for p in pairs if "Sreg" in by_id[p[0]]["operands"]])

    def test_xchg_pair_has_same_opcode(self):
        # 쪽 번호는 판마다 달라지므로(090판 2270, 093판 2279) XCHG 표가 있는 쪽을 isa_db에서 찾는다.
        page = next(int(r["source_page"]) for r in isa_rows_on(*range(2200, 2400)) if r["mnemonic"] == "XCHG")
        rows = [r for r in isa_rows_on(page) if r["mnemonic"] == "XCHG"]
        pairs = sdm_select.direction_pairs(rows)
        self.assertTrue(pairs)
        self.assertTrue(all(same for _, _, same in pairs))   # 86 /r, 87 /r: 두 행 opcode가 같다

    def test_vex_and_evex_rows_are_not_paired(self):
        rows = [r for r in isa_rows_on(*range(740, 760)) if r["mnemonic"] == "VMOVAPS"]
        pairs = sdm_select.direction_pairs(rows)
        by_id = {r["row_id"]: r for r in rows}
        self.assertEqual(len(pairs), 5)    # VEX.128, VEX.256, EVEX.128, EVEX.256, EVEX.512 각 1쌍
        for a, b, _ in pairs:
            self.assertEqual(by_id[a]["opcode"].split(".")[0], by_id[b]["opcode"].split(".")[0])

if __name__ == "__main__":
    unittest.main()

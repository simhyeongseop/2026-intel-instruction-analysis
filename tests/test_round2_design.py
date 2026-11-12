"""2026-11-11 설계 변경 회귀(교수님 미팅): 접두어 없는 소스, 경계값·시드 랜덤 변형, 외부 기호 분기의 재배치 대조,
왕복의 분기 대상 바꾸기와 가르기. 기대값은 SDM 기호 정의(SYM026 등), ModRM·재배치 손계산, readelf 출력 형식에서
손으로 정했다."""

import os
import sys
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline import m2_generate as G  # noqa: E402
from pipeline import m3_check as C  # noqa: E402
from pipeline import m5_roundtrip as M  # noqa: E402
from pipeline.encoding_audit import check_encoding  # noqa: E402
from pipeline.instruction_check import relocation_entries, relocation_text  # noqa: E402

EXTRA = {"seed": 7, "random": 2}
ROWS = G.load_rows()
CASES = G.generate(ROWS, EXTRA)
ISA = C.read_csv(os.path.join(ROOT, "data/db/isa_db.csv"))


def sources(instruction, variant=None):
    return [c["source"] for c in CASES if c["instruction"] == instruction
            and (variant is None or c["variant"] == variant)]


def row_of(instruction, opcode):
    return next(i for i, r in enumerate(ISA) if r["instruction"] == instruction and r["opcode"] == opcode)


class GeneratorTest(unittest.TestCase):
    def test_no_prefix_outside_manual_syntax(self):
        # 사용자 결정(2026-11-11): data16, rex64를 소스에 넣지 않는다
        self.assertFalse([c["source"] for c in CASES if c["source"].split()[0] in ("data16", "rex64")])
        self.assertIn("push 0x1234", sources("PUSH imm16"))

    def test_external_branch_target(self):
        self.assertIn("ja ext_target", sources("JA rel32", "base"))
        self.assertIn("ja .Ltarget", sources("JA rel8"))                    # 같은 파일 라벨 변형은 남긴다

    def test_high_registers(self):
        # EVEX: 32개 벡터(Vol.2 66), 쓰기 마스크 k7(SYM071 k1~k7의 끝)
        self.assertIn("vaddps zmm31 {k7}{z}, zmm30, zmm29",
                      sources("VADDPS zmm1 {k1}{z}, zmm2, zmm3/m512/m32bcst {er}", "hi"))
        # SYM026: AH, CH ... (REX 없는 행만). MOV r/m8, r8(88 /r)의 두 자리에 ah, ch
        self.assertEqual(sources("MOV r/m8, r8", "h8"), ["mov ah, ch"])
        self.assertEqual([c for c in CASES if c["variant"] == "h8" and "REX" in c["opcode"]], [])

    def test_boundary_values(self):
        add = sources("ADD r/m32, imm8")
        for text in ("add ecx, -0x80", "add ecx, 0x0", "add dword ptr [rsp], 0x12", "add dword ptr [rbp], 0x12",
                     "add dword ptr [rax+0x80], 0x12", "add dword ptr [r8+r15*4+0x10], 0x12"):
            self.assertIn(text, add)

    def test_random_is_reproducible_and_in_range(self):
        again = G.generate(G.load_rows(), EXTRA)
        self.assertEqual([c["source"] for c in CASES], [c["source"] for c in again])
        other = G.generate(G.load_rows(), {"seed": 8, "random": 2})
        self.assertNotEqual([c["source"] for c in CASES if c["variant"].startswith("rand")],
                            [c["source"] for c in other if c["variant"].startswith("rand")])
        for case in CASES:
            if case["instruction"] == "ADD r/m32, imm32" and case["variant"].startswith("rand"):
                value = int(case["source"].rsplit(",", 1)[1].strip(), 16)
                self.assertFalse(-128 <= value <= 127, case["source"])     # imm8로 줄어드는 값은 뽑지 않음

    def test_alias_key_compares_numbers_by_value(self):
        self.assertEqual(G.alias_key({"shape": "shl r32, 0x1"}), G.alias_key({"shape": "shl r32, 1"}))
        self.assertNotEqual(G.alias_key({"shape": "shl r32, 0x2"}), G.alias_key({"shape": "shl r32, 1"}))

    def test_every_case_has_att_or_reason(self):
        for case in CASES:
            self.assertTrue(case["source_att"] or "AT&T 변환 안 함" in case["notes"], case["source"])


class RelocationTest(unittest.TestCase):
    READELF = ("    Offset             Info             Type               Symbol's Value  Symbol's Name + Addend\n"
               "0000000000000007  000000010000000f R_X86_64_PC8           0000000000000000 ext_target - 1\n"
               "0000000000000002  0000000100000004 R_X86_64_PLT32         0000000000000000 ext_target - 4\n")

    def test_parse_and_text_in_offset_order(self):
        entries = relocation_entries(self.READELF)
        self.assertEqual(entries[0], {"offset": 7, "type": "R_X86_64_PC8", "symbol": "ext_target", "addend": -1})
        self.assertEqual(relocation_text(entries), "2:R_X86_64_PLT32:ext_target:-4; 7:R_X86_64_PC8:ext_target:-1")

    def check(self, instruction, opcode, hex_bytes, relocations):
        row = dict(ISA[row_of(instruction, opcode)])
        row = dict(row, operand_types=row["operands"], operands="ext_target")
        return check_encoding(hex_bytes, row, relocations)["status"]

    def test_external_branch_encoding(self):
        # JA rel32 = 0F 87 cd. 변위 4바이트는 위치 2, RELA addend = -4(명령 끝까지 4바이트)
        good = [{"offset": 2, "type": "R_X86_64_PLT32", "symbol": "ext_target", "addend": -4}]
        self.assertEqual(self.check("JA rel32", "0F 87 cd", "0f8700000000", good), "fields_match")
        self.assertEqual(self.check("JA rel32", "0F 87 cd", "0f8700000000", [dict(good[0], addend=-5)]),
                         "different_encoding")
        self.assertEqual(self.check("JA rel32", "0F 87 cd", "0f8700000000", [dict(good[0], symbol="foo")]),
                         "not_checked")
        # LOOP rel8 = E2 cb: 위치 1, PC8, addend -1
        loop = [{"offset": 1, "type": "R_X86_64_PC8", "symbol": "ext_target", "addend": -1}]
        self.assertEqual(self.check("LOOP rel8", "E2 cb", "e200", loop), "fields_match")
        self.assertEqual(self.check("LOOP rel8", "E2 cb", "e200", [dict(loop[0], type="R_X86_64_PC32")]),
                         "different_encoding")


class RoundtripTest(unittest.TestCase):
    def test_rewrite_target(self):
        self.assertEqual(M.rewrite_target("ja 0x6"), "ja ext_target")          # objdump
        self.assertEqual(M.rewrite_target("callq 0"), "callq ext_target")       # llvm-mc AT&T
        self.assertEqual(M.rewrite_target("jmp *%rax"), "jmp *%rax")
        self.assertEqual(M.rewrite_target("call qword ptr [rax]"), "call qword ptr [rax]")
        self.assertEqual(M.rewrite_target("mov eax, 0x6"), "mov eax, 0x6")

    def test_localize(self):
        self.assertEqual(M.localize(M.SAME, "같은 바이트"), "")
        self.assertEqual(M.localize(M.DIFFERENT, "같은 바이트"), "역어셈블 출력 쪽 의심")
        self.assertEqual(M.localize(M.REJECTED, "AT&T만 거부"), "어셈블러 문법 해석 쪽 의심")
        self.assertEqual(M.localize(M.DIFFERENT, "변환 없음"), "가를 수 없음")


class SyntaxCompareTest(unittest.TestCase):
    class FakeAssembler:
        def __init__(self, table):
            self.table = table

        def run(self, tool, source, syntax="intel"):
            status, data = self.table[(source, syntax)]
            return {"status": status, "bytes": data, "reloc_text": "", "diagnostic": ""}

    def test_categories(self):
        asm = self.FakeAssembler({("push fs", "intel"): ("accepted", "660fa0"), ("push %fs", "att"): ("accepted", "0fa0"),
                                  ("add ecx, edx", "intel"): ("accepted", "01d1"),
                                  ("add %edx, %ecx", "att"): ("accepted", "01d1"),
                                  ("callw *(%rax)", "att"): ("diagnostic_rejection", ""),
                                  ("call word ptr [rax]", "intel"): ("accepted", "ff18")})
        verdict = lambda s, a: C.syntax_compare({"source": s, "source_att": a}, "clang", asm)["syntax"]
        self.assertEqual(verdict("push fs", "push %fs"), "바이트 다름")
        self.assertEqual(verdict("add ecx, edx", "add %edx, %ecx"), "같은 바이트")
        self.assertEqual(verdict("call word ptr [rax]", "callw *(%rax)"), "AT&T만 거부")
        self.assertEqual(verdict("add ecx, edx", ""), "변환 없음")


if __name__ == "__main__":
    unittest.main()

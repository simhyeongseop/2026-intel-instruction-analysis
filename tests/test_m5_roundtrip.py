"""5단계 왕복 대조 회귀. 기대값은 SDM opcode 표(MOV 89/8B)와 도구 출력 형식에서 손으로 정했다."""

import os
import shutil
import sys
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline import m5_roundtrip as M  # noqa: E402
from pipeline import toolchain as T  # noqa: E402


class VerdictTest(unittest.TestCase):
    def test_categories(self):
        self.assertEqual(M.verdict(False, False, False, False), M.REJECTED)
        self.assertEqual(M.verdict(True, True, True, True), M.RELOCATED)
        self.assertEqual(M.verdict(True, False, True, True), M.SAME)
        self.assertEqual(M.verdict(True, False, False, True), M.SAME_INSN)
        self.assertEqual(M.verdict(True, False, False, False), M.DIFFERENT)

    def test_route(self):
        self.assertEqual(M.route((True, "4889c8"), (True, "4889c8")), "두 경로 같음")
        self.assertEqual(M.route((True, "4889c8"), (True, "488bc1")), "두 경로 바이트 다름")
        self.assertEqual(M.route((False, ""), (True, "4889c8")), "AT&T 경로만 거부")
        self.assertEqual(M.route((False, ""), (False, "")), "둘 다 거부")

    def test_clean(self):
        self.assertEqual(M.clean("lea    0x0(%rip),%rax        # 0x7"), "lea 0x0(%rip),%rax")
        self.assertEqual(M.clean("call\t0x5 <foo>"), "call 0x5")

    def test_targets_skip_rejected(self):
        results = [{"status_as": "accepted", "bytes_as": "90", "status_clang": "diagnostic_rejection",
                    "bytes_clang": ""}]
        self.assertEqual([f for f, _ in M.targets(results)], ["gnu"])


@unittest.skipUnless(shutil.which(T.OBJDUMP) and shutil.which(T.LLVM_MC) and shutil.which(T.CLANG),
                     "도구 없음")
class ToolTest(unittest.TestCase):
    def test_same_bytes(self):
        for family in M.FAMILIES:                  # MOV r/m64, r64 (REX.W 89 /r): 어셈블러 기본 선택
            row = M.roundtrip(family, "4889c8")
            self.assertEqual((row["verdict_att"], row["verdict_intel"]), (M.SAME, M.SAME), family)

    def test_direction_bit_lost(self):
        for family in M.FAMILIES:                  # MOV r64, r/m64 (REX.W 8B /r): 텍스트는 89 형식과 같다
            row = M.roundtrip(family, "488bc1")
            self.assertEqual(row["verdict_att"], M.SAME_INSN, family)
            self.assertEqual(row["bytes_att"], "4889c8", family)
            self.assertEqual(row["route"], "두 경로 같음", family)

    def test_movsxd_r16_intel64(self):
        row = M.roundtrip("gnu", "6663ca")         # MOVSXD r16, r/m16 (66 63 /r): Intel64 해석이면 cx, dx
        self.assertEqual((row["verdict_att"], row["verdict_intel"]), (M.SAME, M.SAME))
        self.assertIn("dx", row["intel"])
        self.assertNotIn("edx", row["intel"])

    def test_relative_excluded(self):
        row = M.roundtrip("gnu", "e800000000", relative=True)
        self.assertEqual(row["verdict_att"], M.RELATIVE)
        self.assertEqual(row["bytes_att"], "")

    def test_undecodable(self):
        row = M.roundtrip("gnu", "0f0b0f")         # ud2 + 남은 바이트 하나
        self.assertEqual(row["verdict_att"], M.UNDECODED)


class ChainKeyTest(unittest.TestCase):
    """as0–as2 문자열 키. 기대값은 손으로 정했다."""

    def test_text_key_spacing_case(self):
        self.assertEqual(M.text_key("MOV RAX, QWORD PTR [RBX + 8]"), M.text_key("mov rax,qword ptr [rbx+8]"))
        self.assertNotEqual(M.text_key("adc al, 0x12"), M.text_key("adc al, 18"))
        self.assertEqual(M.text_key("vpmovusdb xmm5 {k3}{z}, xmm15"), M.text_key("vpmovusdb xmm5{k3}{z},xmm15"))
        self.assertEqual(M.text_key("mov eax, dword ptr [rax-0x80]"), M.text_key("mov eax, dword ptr [rax - 0x80]"))
        self.assertNotEqual(M.text_key("cmovng cx, r15w"), M.text_key("cmovle cx,r15w"))   # 별칭은 다름으로 둔다

    def test_rescore(self):
        row = {"cmp_as0_as2_intel": "다름", "note_as0_as2_intel": "", "as0_intel": "adc byte ptr [rax-0x80], dl",
               "as2_intel": "adc byte ptr [rax - 128], dl",
               "cmp_as0_as2_att": "미대조", "note_as0_as2_att": "", "as0_att": "x", "as2_att": ""}
        M.rescore([row])
        self.assertEqual((row["cmp_as0_as2_intel"], row["note_as0_as2_intel"]), ("다름", M.NUMBER_ONLY))
        self.assertEqual(row["cmp_as0_as2_att"], "미대조")

    def test_number_key(self):
        self.assertEqual(M.number_key("adc al, 0x12"), M.number_key("adc al, 18"))
        self.assertEqual(M.number_key("mov eax, dword ptr [rbp-0x8]"), M.number_key("mov eax,dword ptr [rbp-8]"))
        self.assertNotEqual(M.number_key("adc al, 0x12"), M.number_key("adc al, 0x13"))
        self.assertEqual(M.number_key("vaddps zmm31, zmm1, zmm2"), "vaddps zmm31,zmm1,zmm2")   # 레지스터 숫자는 그대로

    def test_rejected_path(self):
        out = M.chain("intel", "mov rax, rcx", (("mov %rcx,%rax",), ("mov rax,rcx",)), {"accepted": False})
        self.assertEqual((out["b1"], out["cmp_b0_b1"], out["cmp_as0_as2"], out["cmp_as1_as2"]),
                         ("거부", M.NOT_COMPARED, M.NOT_COMPARED, M.NOT_COMPARED))


@unittest.skipUnless(shutil.which(T.OBJDUMP) and shutil.which(T.LLVM_MC) and shutil.which(T.CLANG),
                     "도구 없음")
class ChainToolTest(unittest.TestCase):
    """as0 -> b0 -> as1 -> b1 -> as2 세 비교. 기대값: SDM MOV 89/8B, ADC 14 ib, objdump·llvm-mc 출력 형식."""

    SOURCES = {"intel": "mov rax, rcx", "att": "mov %rcx, %rax"}

    def cmp(self, row, syntax):
        return tuple(row["%s_%s" % (k, syntax)] for k in ("cmp_as0_as2", "cmp_b0_b1", "cmp_as1_as2"))

    # AT&T as0 'mov %rcx, %rax': objdump는 'mov %rcx,%rax'(같음), llvm-mc는 크기 글자 'movq'(문자열 다름)
    AS0_ATT = {"gnu": "같음", "llvm": "다름"}

    def test_all_same(self):
        for family in M.FAMILIES:                  # REX.W 89 /r, modrm c8: reg=rcx, rm=rax
            row = M.roundtrip(family, "4889c8", sources=self.SOURCES)
            self.assertEqual(self.cmp(row, "intel"), ("같음", "같음", "같음"), (family, row))
            self.assertEqual(self.cmp(row, "att"), (self.AS0_ATT[family], "같음", "같음"), (family, row))
            for syntax in ("att", "intel"):
                self.assertEqual(row["b1_" + syntax], "4889c8")

    def test_direction_bit(self):
        for family in M.FAMILIES:                  # REX.W 8B /r, modrm c1: 같은 명령, 다시 조립하면 89 형식
            row = M.roundtrip(family, "488bc1", sources=self.SOURCES)
            self.assertEqual(self.cmp(row, "intel"), ("같음", "다름", "같음"), (family, row))
            self.assertEqual(self.cmp(row, "att"), (self.AS0_ATT[family], "다름", "같음"), (family, row))
            for syntax in ("att", "intel"):
                self.assertEqual(row["b1_" + syntax], "4889c8")

    def test_number_only(self):
        row = M.roundtrip("gnu", "1412", sources={"intel": "adc al, 18", "att": "adc $18, %al"})
        self.assertEqual(self.cmp(row, "intel"), ("다름", "같음", "같음"))
        self.assertEqual(row["note_as0_as2_intel"], M.NUMBER_ONLY)
        self.assertEqual(row["as2_intel"], "adc al,0x12")

    def test_relative_not_compared(self):
        row = M.roundtrip("gnu", "e800000000", relative=True, sources={"intel": "call .Ltarget"})
        self.assertEqual(self.cmp(row, "intel"), (M.NOT_COMPARED,) * 3)
        self.assertEqual(row["as0_intel"], "call .Ltarget")


if __name__ == "__main__":
    unittest.main()

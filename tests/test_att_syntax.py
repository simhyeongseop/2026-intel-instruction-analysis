"""Intel -> AT&T 소스 변환 회귀. 기대값은 GNU as 매뉴얼(i386-Variations, i386-Mnemonics, AT&T Syntax bugs)의
규칙에서 손으로 썼다(변환 코드의 표를 읽지 않는다)."""

import os
import sys
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline import att_syntax as A  # noqa: E402


def convert(source, others=()):
    """others: 같은 니모닉의 다른 폭 소스(메모리 폭이 레지스터로 정해지지 않는지 판단할 자료)."""
    return A.convert(source, A.ambiguous_keys([source] + list(others)))


class OrderAndOperandTest(unittest.TestCase):
    def test_reversed_order_registers_immediates_memory(self):
        self.assertEqual(convert("add ecx, edx"), "add %edx, %ecx")
        self.assertEqual(convert("add dword ptr [rax+rbx*4+0x10], 0x12", ["add byte ptr [rax], 0x12"]),
                         "addl $0x12, 0x10(%rax,%rbx,4)")
        self.assertEqual(convert("mov ecx, dword ptr [rip-0x80]"), "mov -0x80(%rip), %ecx")
        self.assertEqual(convert("mov ecx, dword ptr [rbx*4+0x10]"), "mov 0x10(,%rbx,4), %ecx")
        self.assertEqual(convert("mov ecx, dword ptr [0x10]"), "mov 0x10, %ecx")

    def test_two_immediates_not_reversed(self):
        # 매뉴얼: 'instructions with 2 immediate operands, such as the enter instruction, do not have reversed order'
        self.assertEqual(convert("enter 0x1234, 0x12"), "enter $0x1234, $0x12")

    def test_avx512_decorations(self):
        # 매뉴얼 예: 'vaddps {rn-sae}, %zmm4, %zmm5, %zmm6{%k7}' 꼴
        self.assertEqual(convert("vaddps zmm6 {k7}, zmm5, zmm4, {rn-sae}"), "vaddps {rn-sae}, %zmm4, %zmm5, %zmm6{%k7}")
        self.assertEqual(convert("vaddps zmm0 {k1}{z}, zmm1, dword ptr [rax]{1to16}"),
                         "vaddps (%rax){1to16}, %zmm1, %zmm0{%k1}{z}")
        self.assertEqual(convert("vpgatherdd xmm0 {k1}, [r13+xmm1*4-0x80]"), "vpgatherdd -0x80(%r13,%xmm1,4), %xmm0{%k1}")

    def test_rounding_after_gpr_source(self):
        # 2026-11-11 관측: 두 도구의 AT&T는 GPR 소스 변환에서 장식을 GPR 뒤에만 받고, 두 역어셈블러도 이렇게 쓴다
        self.assertEqual(convert("vcvtsi2sd xmm0, xmm1, rcx, {rn-sae}"), "vcvtsi2sd %rcx, {rn-sae}, %xmm1, %xmm0")
        self.assertEqual(convert("vcvtusi2ss xmm0, xmm1, ecx, {rz-sae}"), "vcvtusi2ss %ecx, {rz-sae}, %xmm1, %xmm0")
        # GPR가 목적지인 변환(vcvtsd2si)과 벡터 소스는 기존대로 장식이 맨 앞
        self.assertEqual(convert("vcvtsd2si ecx, xmm0, {rn-sae}"), "vcvtsd2si {rn-sae}, %xmm0, %ecx")
        self.assertEqual(convert("vcvtps2ph ymm0, zmm1, {sae}, 0x12"), "vcvtps2ph $0x12, {sae}, %zmm1, %ymm0")

    def test_branches(self):
        self.assertEqual(convert("jmp rcx"), "jmp *%rcx")
        self.assertEqual(convert("call qword ptr [rax]"), "call *(%rax)")
        self.assertEqual(convert("call fword ptr [rax]"), "lcalll *(%rax)")        # 먼 호출 m16:32
        self.assertEqual(convert("jmp tbyte ptr [rax]"), "ljmpq *(%rax)")          # 먼 점프 m16:64
        self.assertEqual(convert("jmp 0x10:0x1234"), "ljmp $0x10,$0x1234")
        self.assertEqual(convert("retf 0x1234"), "lret $0x1234")
        self.assertEqual(convert("ja ext_target"), "ja ext_target")


class SuffixTest(unittest.TestCase):
    def test_suffix_only_when_memory_width_is_open(self):
        self.assertEqual(convert("clflushopt byte ptr [rax]"), "clflushopt (%rax)")     # 폭이 하나뿐
        self.assertEqual(convert("push qword ptr [rax]", ["push word ptr [rax]"]), "pushq (%rax)")
        self.assertEqual(convert("shl dword ptr [rax], cl", ["shl byte ptr [rax], cl"]), "shll %cl, (%rax)")
        self.assertEqual(convert("add dword ptr [rax], ecx", ["add qword ptr [rax], rcx"]), "add %ecx, (%rax)")

    def test_mnemonic_spellings(self):
        self.assertEqual(convert("movzx ecx, byte ptr [rax]"), "movzbl (%rax), %ecx")
        self.assertEqual(convert("movsx rcx, dx"), "movswq %dx, %rcx")
        self.assertEqual(convert("movsxd rcx, edx"), "movslq %edx, %rcx")
        self.assertEqual(convert("fild qword ptr [rax]", ["fild word ptr [rax]"]), "fildll (%rax)")
        self.assertEqual(convert("fld tbyte ptr [rax]", ["fld dword ptr [rax]"]), "fldt (%rax)")
        self.assertEqual(convert("cvtsi2ss xmm1, qword ptr [rax]", ["cvtsi2ss xmm1, dword ptr [rax]"]),
                         "cvtsi2ssq (%rax), %xmm1")
        self.assertEqual(convert("insd"), "insl")
        self.assertEqual(convert("ins byte ptr [rdi], dx", ["ins word ptr [rdi], dx"]), "insb (%dx), (%rdi)")

    def test_vector_width_letter(self):
        others = ["vcvtpd2ps xmm0, ymmword ptr [rax]"]
        self.assertEqual(convert("vcvtpd2ps xmm0, xmmword ptr [rax]", others), "vcvtpd2psx (%rax), %xmm0")
        self.assertEqual(convert("vcvtpd2ps ymm0, zmmword ptr [rax]", others), "vcvtpd2ps (%rax), %ymm0")
        self.assertEqual(convert("vcvtpd2ps xmm0, qword ptr [rax]{1to2}", others), "vcvtpd2ps (%rax){1to2}, %xmm0")

    def test_x87_reversed_mnemonic(self):
        # 매뉴얼 'AT&T Syntax bugs': 'fsub %st,%st(3)'은 %st(3) = %st - %st(3)
        self.assertEqual(convert("fsub st(3), st"), "fsubr %st, %st(3)")
        self.assertEqual(convert("fsubp"), "fsubrp")
        self.assertEqual(convert("fadd st(1), st(0)"), "fadd %st(0), %st(1)")      # 가환 연산은 그대로

    def test_unknown_form_is_refused(self):
        with self.assertRaises(A.Unsupported):
            A.convert("mov eax, [rax+rbx+rcx]")


if __name__ == "__main__":
    unittest.main()

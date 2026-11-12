"""as0–as2 차이 분류 회귀. 기대값은 실제 출력 예(11월 11일 라운드)를 보고 손으로 정했다."""

import os
import sys
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)
sys.path.insert(0, os.path.join(ROOT, "scripts"))

import classify_roundtrip_diffs as C  # noqa: E402


class ClassifyTextTest(unittest.TestCase):
    def check(self, as0, as2, expected):
        self.assertEqual(C.classify_text(as0, as2), expected, (as0, as2))

    def test_single_rules(self):
        self.check("adc al, 0x12", "adc al, 18", "숫자 진법")
        self.check("vorpd ymm0, ymm1, ymmword ptr [rbp]", "vorpd ymm0,ymm1,YMMWORD PTR [rbp+0x0]", "생략 변위 0")
        self.check("cmp %dl, (%rbp)", "cmp %dl,0x0(%rbp)", "생략 변위 0")
        self.check("adc byte ptr [rax+rbx*8], dl", "adc byte ptr [rax + 8*rbx], dl", "주소 스케일 표기")
        self.check("setb byte ptr [rax+rbx*1]", "setb byte ptr [rax+rbx]", "주소 스케일 표기")
        self.check("movdir64b rcx, [rip+0x10]", "movdir64b rcx, zmmword ptr [rip+0x10]",
                   "메모리 크기·브로드캐스트 표기")
        self.check("vfnmadd231ph zmm0, zmm1, zmm2, {ru-sae}", "vfnmadd231ph zmm0,zmm1,zmm2{ru-sae}",
                   "반올림·SAE 위치")
        self.check("cmovng cx, r15w", "cmovle cx,r15w", "조건 코드 별칭")
        self.check("jnb ext_target", "jae ext_target", "조건 코드 별칭")
        self.check("rep outsb (%rsi), (%dx)", "rep outsb (%rsi),%dx", "AT&T 포트 괄호")

    def test_pair_rules(self):
        self.check("adc al, -0x1", "adc al,0xff", "숫자 진법+숫자 폭 감기(부호·2의 보수)")
        self.check("sub $-1, %ax", "sub $0xffff,%ax", "숫자 진법+숫자 폭 감기(부호·2의 보수)")
        self.check("bt $0x1, %ecx", "btl $1, %ecx", "숫자 진법+AT&T 크기 글자")
        self.check("fmulp", "fmulp st(1), st", "암묵·생략 오퍼랜드")
        self.check("vcmpps $0x12, %xmm13, %xmm14, %xmm15", "vcmple_oqps %xmm13,%xmm14,%xmm15",
                   "숫자 진법+비교 술어 의사 명령")
        self.check("vpcmpb k0, xmm0, xmm1, 0x0", "vpcmpeqb k0,xmm0,xmm1", "숫자 진법+비교 술어 의사 명령")

    def test_more_rules(self):
        self.check("vmaxss xmm0, xmm1, dword ptr [rip-0x80]", "vmaxss xmm0,xmm1,DWORD PTR [rip+0xffffffffffffff80]",
                   "숫자 진법+숫자 폭 감기(부호·2의 보수)")
        self.check("vpshldvq xmm0, xmm1, xmmword ptr [0x10]", "vpshldvq xmm0,xmm1,XMMWORD PTR ds:0x10",
                   "메모리 크기·브로드캐스트 표기")
        self.check("vpsraq (%r13), %zmm1, %zmm0", "vpsraq 0x0(%r13),%zmm1,%zmm0", "생략 변위 0")
        self.check("cmovnz -0x80(%rax), %rcx", "cmovneq -128(%rax), %rcx", "숫자 진법+조건 코드 별칭+AT&T 크기 글자")
        self.check("sal r15w, cl", "shl r15w, cl", "니모닉 별칭(sal·movabs 등)")
        self.check("cmpzxadd dword ptr [rbp], ecx, edx", "cmpexadd dword ptr [rbp], ecx, edx", "조건 코드 별칭")
        self.check("fcmovb st(0), st(1)", "fcmovb st, st(1)", "x87 st(0) 표기")
        self.check("fstsw word ptr [rax+0x7f]", "wait | fnstsw word ptr [rax + 127]",
                   "숫자 진법+FWAIT 분리(fstsw -> wait|fnstsw)")
        self.check("vandps ymm2, ymm4, ymm11", "vandps ymm2, ymm11, ymm4", "소스 두 오퍼랜드 순서 바뀜")
        self.check("vorps %ymm11, %ymm4, %ymm2", "vorps %ymm4, %ymm11, %ymm2", "소스 두 오퍼랜드 순서 바뀜")  # AT&T
        self.check("enter -0x1, 0x0", "enter 0xffff,0x0", "숫자 진법+숫자 폭 감기(부호·2의 보수)")

    def test_third_rules(self):
        self.check("lsl rcx, word ptr [rax]", "lsl ecx,WORD PTR [rax]", "GPR 폭 표기(r64·r32·r16)")
        self.check("mov %es, %r15", "mov %es,%r15d", "GPR 폭 표기(r64·r32·r16)")
        self.check("xchg ecx, dword ptr [r12]", "xchg DWORD PTR [r12],ecx", "XCHG 오퍼랜드 순서")
        self.check("vpermpd ymm0, ymm1, ymmword ptr [rsp]", "{evex} vpermpd ymm0,ymm1,YMMWORD PTR [rsp]",
                   "인코딩 표시({evex}·rex.w)")
        self.check("repne cmps byte ptr [rsi], byte ptr [rdi]", "repnz cmps byte ptr [rsi],byte ptr [rdi]",
                   "니모닉 별칭(sal·movabs 등)")

    def test_not_explained(self):
        self.check("add eax, 1", "sub eax, 1", C.OTHER)          # 니모닉이 다른 명령
        self.check("mov eax, 1", "mov eax, 2", C.OTHER)          # 폭으로 감아도 다른 값
        self.check("jb x", "jae x", C.OTHER)                     # 반대 조건은 별칭이 아니다
        self.check("vsubps ymm2, ymm4, ymm11", "vsubps ymm2, ymm11, ymm4", "소스 두 오퍼랜드 순서 바뀜")  # 규칙은 순서만 본다
        self.check("lsl rcx, word ptr [rax]", "lsl rdx, word ptr [rax]", C.OTHER)   # 다른 번호 레지스터

    def test_condition_alias_keeps_suffix(self):
        self.assertEqual(C.condition_alias("cmovnaw 8(%rax),%cx"), "cmovbew 8(%rax),%cx")
        self.assertEqual(C.condition_alias("jnb x"), "jae x")
        self.assertEqual(C.condition_alias("jmp x"), "jmp x")

    def test_known(self):
        row = {"verdict_intel": "재조립 거부", "instruction": "LSS r64,m16:64", "intel": "lss rcx,FWORD PTR [rax]"}
        self.assertTrue(C.known(row, "intel").startswith("미대조(재조립 거부): GNU objdump가 L*S"))


class MeaningTest(unittest.TestCase):
    """as0–as2 의미 확인. 기대값은 실제 행(LLVM push %fs, CALL r/m16, VPCMPB 술어 0)을 보고 손으로 정했다."""

    def row(self, b0_b1, as1_as2, check):
        return {"cmp_b0_b1_att": b0_b1, "cmp_as1_as2_att": as1_as2, "cmp_b0_b1_intel": b0_b1,
                "cmp_as1_as2_intel": as1_as2, "syntax_check": check}

    def test_same_bytes(self):
        self.assertEqual(C.meaning(self.row("같음", "같음", "같은 바이트"), "att"), C.SAME_BYTES)
        # Intel 경로는 as0가 b0를 만든 소스라 syntax_check와 무관
        self.assertEqual(C.meaning(self.row("같음", "같음", "바이트 다름"), "intel"), C.SAME_BYTES)

    def test_att_source_differs(self):
        # LLVM: Intel 'push fs' -> 66 0f a0, AT&T 'push %fs' -> 0f a0. 왕복은 맞아도 as0(AT&T)는 다른 바이트
        self.assertEqual(C.meaning(self.row("같음", "같음", "바이트 다름"), "att"), C.ATT_OTHER_BYTES)
        # LLVM: 'callw *(%rax)'는 64비트에서 거부(Intel 'call word ptr'은 ff18로 수용)
        self.assertEqual(C.meaning(self.row("같음", "같음", "AT&T만 거부"), "att"), C.ATT_REJECTED)

    def test_round_trip_differs(self):
        # VPCMPB 술어 0: b0 3F /r ib, b1 74 /r
        self.assertEqual(C.meaning(self.row("다름", "같음", "같은 바이트"), "att"), C.ROUND_DIFF)
        self.assertEqual(C.meaning(self.row("미대조", "미대조", "같은 바이트"), "intel"), C.UNKNOWN)
        self.assertEqual(C.meaning(self.row("같음", "다름", "같은 바이트"), "intel"), C.UNKNOWN)


if __name__ == "__main__":
    unittest.main()

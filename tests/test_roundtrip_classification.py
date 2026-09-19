"""7단계가 새 입력 표기를 설명할 수 있는지 확인한다.

2026-09-19 라운드에서 rip 상대·마스크·브로드캐스트 표기를 생성하기 시작했다.
분류기가 이 표기를 모르면 전부 "설명할 수 없는 차이"(unsure)로 쌓인다.
아래 기대값은 실제 objdump 2.42 출력을 그대로 옮긴 것이다.

반례도 함께 둔다: 흡수하면 안 되는 진짜 차이는 여전히 unsure 로 남아야 한다.
"""

from pathlib import Path
import sys
import unittest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from pipeline.m7_triage import ROUNDTRIP_VERDICT, _roundtrip_category


class RoundtripCategories(unittest.TestCase):
    def check(self, source, objdump, expected):
        self.assertEqual(_roundtrip_category(source, objdump), expected,
                         f"{source!r} vs {objdump!r}")

    def test_rip_relative_comment_is_not_a_finding(self):
        # objdump 는 rip 상대 주소에 '# 0x17' 주석을 덧붙인다.
        self.check("adc byte ptr [rip+0x10], 1",
                   "adc    BYTE PTR [rip+0x10],0x1        # 0x17", "numeric_repr")

    def test_mask_decoration_spacing(self):
        self.check("vaddpd xmm0 {k1}{z}, xmm0, xmm0",
                   "vaddpd xmm0{k1}{z},xmm0,xmm0", "numeric_repr")

    def test_broadcast_display(self):
        self.check("vaddpd xmm0, xmm0, qword ptr [eax]{1to2}",
                   "vaddpd xmm0,xmm0,QWORD BCST [eax]", "broadcast_display")

    def test_sib_and_immediate_forms(self):
        self.check("adc byte ptr [rax+rbx*4+0x10], 1",
                   "adc    BYTE PTR [rax+rbx*4+0x10],0x1", "numeric_repr")
        self.check("enter 0x7fff, 0", "enter  0x7fff,0x0", "numeric_repr")

    def test_real_difference_is_still_unexplained(self):
        """반례: 레지스터가 실제로 다른 것은 흡수되면 안 된다."""
        category = _roundtrip_category("adc ecx, 1", "adc    edx,0x1")
        self.assertEqual(ROUNDTRIP_VERDICT[category], "unsure")

    def test_comment_strip_does_not_eat_operands(self):
        """반례: 주석 제거가 오퍼랜드까지 지우면 안 된다."""
        self.check("mov eax, dword ptr [rip+0x10]",
                   "mov    eax,DWORD PTR [rip+0x10]        # 0x2a", "numeric_repr")
        category = _roundtrip_category("mov eax, dword ptr [rip+0x10]",
                                       "mov    ecx,DWORD PTR [rip+0x10]        # 0x2a")
        self.assertEqual(ROUNDTRIP_VERDICT[category], "unsure")


if __name__ == "__main__":
    unittest.main(verbosity=2)

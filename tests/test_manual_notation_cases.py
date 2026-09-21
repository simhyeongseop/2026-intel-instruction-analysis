"""2026-09-21에 확정한 매뉴얼 표기 사례와 도구 관측을 고정한다.

여기 적힌 바이트는 그날 실제로 도구를 돌려 얻은 값이다. 이 테스트가 깨지면 버그가 아니라
**도구 동작이 바뀐 것**이므로, 관측을 다시 기록하고 `docs/MEETING_NOTES/11회_발표자료.md`를 갱신한다.

판정하는 것이 아니라 관측을 고정한다. 바이트가 같다고 실행 의미가 같다는 뜻은 아니다.
"""
import shutil
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TOOLS = sys.platform == 'linux' and all(shutil.which(t) for t in ('as', 'clang', 'objdump'))
HEADER = '.intel_syntax noprefix\n.text\n'


def assemble(code, tool='as'):
    """한 줄을 조립해 (성공여부, 바이트문자열)을 준다. 판정하지 않고 관측만 돌려준다."""
    with tempfile.TemporaryDirectory() as directory:
        source = Path(directory) / 'a.s'
        obj = Path(directory) / 'a.o'
        source.write_text(HEADER + code + '\n', encoding='utf-8')
        command = (['as', '--64', '-mintel64', '-o', str(obj), str(source)] if tool == 'as'
                   else ['clang', '-c', '-x', 'assembler', str(source), '-o', str(obj)])
        if subprocess.run(command, capture_output=True).returncode != 0:
            return False, ''
        return True, text_bytes(obj)


def text_bytes(obj):
    dump = subprocess.run(['objdump', '-d', '-M', 'intel', str(obj)],
                          capture_output=True, text=True).stdout
    out = []
    for line in dump.splitlines():
        parts = line.split('\t')
        if len(parts) >= 2 and parts[0].strip().endswith(':'):
            out.append(parts[1].strip().replace(' ', ''))
    return ''.join(out)


def disassembly(code):
    """조립한 뒤 objdump가 보여주는 명령어 문자열."""
    with tempfile.TemporaryDirectory() as directory:
        source = Path(directory) / 'a.s'
        obj = Path(directory) / 'a.o'
        source.write_text(HEADER + code + '\n', encoding='utf-8')
        if subprocess.run(['as', '--64', '-mintel64', '-o', str(obj), str(source)],
                          capture_output=True).returncode != 0:
            return ''
        dump = subprocess.run(['objdump', '-d', '-M', 'intel', str(obj)],
                              capture_output=True, text=True).stdout
        for line in dump.splitlines():
            parts = line.split('\t')
            if len(parts) >= 3 and parts[0].strip().endswith(':'):
                return ' '.join(parts[2].split())
        return ''


@unittest.skipUnless(TOOLS, 'as/clang/objdump 필요')
class ManualNotationTests(unittest.TestCase):
    """매뉴얼 표기가 어긋난 행을 다른 열·형제 행 근거로 고쳐 쓰면 시험된다."""

    def test_vpmovqd_half_mem_reaches_evex128_row(self):
        # 매뉴얼은 xmm1/m128이라 적었지만 Tuple Type이 Half Mem이라 m64가 맞다.
        self.assertEqual(assemble('vpmovqd xmmword ptr [eax], xmm0'), (False, ''))
        self.assertEqual(assemble('vpmovqd qword ptr [eax], xmm0'), (True, '6762f27e083500'))
        # m128은 ymm 소스와 짝이다(EVEX.256 행).
        self.assertEqual(assemble('vpmovqd xmmword ptr [eax], ymm0'), (True, '6762f27e283500'))

    def test_vpmovqd_siblings_use_reduced_size(self):
        # 형제 행은 모두 줄어든 크기로 적혀 있어 그대로 조립된다. VPMOVQD만 예외였다.
        for code in ('vpmovdb dword ptr [eax], xmm0', 'vpmovqw dword ptr [eax], xmm0',
                     'vpmovqb word ptr [eax], xmm0'):
            with self.subTest(code=code):
                self.assertTrue(assemble(code)[0])

    def test_vscatterdpd_half_index_reaches_evex256_row(self):
        # 매뉴얼은 vm32y라 적었지만 인덱스는 원소 수만큼만 필요해 vm32x가 맞다.
        self.assertEqual(assemble('vscatterdpd [eax + ymm1] {k1}, ymm0'), (False, ''))
        self.assertEqual(assemble('vscatterdpd [eax + xmm1] {k1}, ymm0'), (True, '6762f2fd29a20408'))
        # 쌍둥이 VPSCATTERDQ는 매뉴얼 표기가 올바른 쪽이고 EVEX 바이트가 같다(opcode만 a0/a2).
        self.assertEqual(assemble('vpscatterdq [eax + xmm1] {k1}, ymm0'), (True, '6762f2fd29a00408'))

    def test_sysexit_two_rows_need_size_suffix(self):
        # 니모닉 글자가 같은 두 SDM 행은 크기 접미사로만 구분된다.
        self.assertEqual(assemble('sysexit'), (False, ''))
        self.assertEqual(assemble('sysexitd'), (True, '0f35'))
        self.assertEqual(assemble('sysexitq'), (True, '480f35'))
        self.assertEqual(assemble('sysretd'), (True, '0f07'))
        self.assertEqual(assemble('sysretq'), (True, '480f07'))

    def test_sysexit_non_rexw_row_has_no_portable_text(self):
        # 비REX.W 행을 두 어셈블러가 모두 받는 입력 텍스트가 없다.
        self.assertEqual(assemble('sysexit', 'as')[0], False)
        self.assertEqual(assemble('sysexit', 'clang'), (True, '0f35'))
        self.assertEqual(assemble('sysexitd', 'as'), (True, '0f35'))
        self.assertEqual(assemble('sysexitd', 'clang')[0], False)
        # REX.W 행은 공통 표기가 있다.
        self.assertEqual(assemble('sysexitq', 'as'), (True, '480f35'))
        self.assertEqual(assemble('sysexitq', 'clang'), (True, '480f35'))


@unittest.skipUnless(TOOLS, 'as/clang/objdump 필요')
class LarLslRexWTests(unittest.TestCase):
    """as의 기본 인코딩 선택이 REX.W를 빠뜨려 왕복이 깨지는 관측을 고정한다.

    `rex64` 의사 프리픽스로는 REX.W 형식을 만들 수 있으므로 ISA 표현력의 한계가 아니다.
    이미 보고된 결함이다 - binutils bug gas/32813 "Missing REX prefix for LSL".
    """

    def test_as_drops_rex_w_silently(self):
        # rcx로 썼는데 32비트 인코딩이 나온다. 오류도 경고도 없다.
        self.assertEqual(assemble('lar rcx, rcx'), (True, '0f02c9'))
        self.assertEqual(assemble('lsl rcx, rcx'), (True, '0f03c9'))
        # 그 바이트를 다시 읽으면 ecx다 — 입력에 쓴 레지스터가 사라진다.
        self.assertEqual(disassembly('lar rcx, rcx'), 'lar ecx,ecx')

    def test_clang_emits_rex_w_for_same_text(self):
        # 같은 입력에서 clang은 REX.W 형식을 만든다. 문법적으로 불가능한 것이 아니다.
        self.assertEqual(assemble('lar rcx, rcx', 'clang'), (True, '480f02c9'))
        self.assertEqual(assemble('lsl rcx, rcx', 'clang'), (True, '480f03c9'))

    def test_rex64_prefix_does_produce_rex_w(self):
        """`rex64` 의사 프리픽스를 쓰면 as도 REX.W 형식을 만든다.

        2026-09-21 최초 기록에서 "as는 어떤 문법으로도 REX.W LAR/LSL을 만들 수 없다"고 적었으나
        틀렸다. Intel 문법 기본 렌더링·AT&T·크기 접미사에서만 REX.W가 빠지고, `rex64`로는 나온다.
        따라서 이것은 ISA 표현력의 한계가 아니라 **기본 인코딩 선택의 문제**다.
        """
        self.assertEqual(assemble('rex64 lar rcx, rcx'), (True, '480f02c9'))
        self.assertEqual(assemble('rex64 lsl rcx, rcx'), (True, '480f03c9'))

    def test_att_syntax_and_suffix_also_drop_rex_w(self):
        # 의사 프리픽스 없이는 AT&T로도, 크기 접미사를 붙여도 REX.W가 나오지 않는다.
        for code in ('lar %rcx, %rcx', 'larq %rcx, %rcx'):
            with tempfile.TemporaryDirectory() as directory:
                source = Path(directory) / 'a.s'
                obj = Path(directory) / 'a.o'
                source.write_text('.text\n' + code + '\n', encoding='utf-8')
                run = subprocess.run(['as', '--64', '-o', str(obj), str(source)], capture_output=True)
                with self.subTest(code=code):
                    self.assertEqual(run.returncode, 0)
                    self.assertEqual(text_bytes(obj), '0f02c9')

    def test_rex_w_bytes_do_not_round_trip_through_as(self):
        """48 0f 02 c9 → objdump → as 를 거치면 바이트가 달라진다.

        objdump 표시(`lar rcx,rcx`)는 올바르다. 그 문자열을 as가 받아들이면서 REX.W 없는
        다른 인코딩을 내보내므로 왕복이 깨진다. 오류도 경고도 나오지 않는다.
        """
        for original, shown, narrowed in (('480f02c9', 'lar rcx,rcx', '0f02c9'),
                                          ('480f03c9', 'lsl rcx,rcx', '0f03c9')):
            with self.subTest(original=original):
                with tempfile.TemporaryDirectory() as directory:
                    source = Path(directory) / 'b.s'
                    obj = Path(directory) / 'b.o'
                    literal = ','.join('0x' + original[i:i+2] for i in range(0, len(original), 2))
                    source.write_text('.text\n.byte ' + literal + '\n', encoding='utf-8')
                    subprocess.run(['as', '--64', '-o', str(obj), str(source)], check=True,
                                   capture_output=True)
                    dump = subprocess.run(['objdump', '-d', '-M', 'intel', str(obj)],
                                          capture_output=True, text=True).stdout
                    printed = ''
                    for line in dump.splitlines():
                        parts = line.split('\t')
                        if len(parts) >= 3 and parts[0].strip().endswith(':'):
                            printed = ' '.join(parts[2].split())
                            break
                # objdump 표시는 올바르다.
                self.assertEqual(printed, shown)
                # 그 표시를 그대로 다시 조립하면 수용되지만 바이트가 다르다.
                accepted, again = assemble(printed)
                self.assertTrue(accepted)
                self.assertEqual(again, narrowed)
                self.assertNotEqual(again, original)


@unittest.skipUnless(TOOLS, 'as/clang/objdump 필요')
class FarPointerRoundTripTests(unittest.TestCase):
    """예외 ⑥과의 대비: 이쪽 왕복 실패는 거부로 드러난다(시끄러운 실패)."""

    def test_lss_display_is_rejected_on_reassembly(self):
        self.assertEqual(assemble('lss rcx, tbyte ptr [rax]'), (True, '480fb208'))
        self.assertEqual(disassembly('lss rcx, tbyte ptr [rax]'), 'lss rcx,FWORD PTR [rax]')
        # objdump 출력을 as에 다시 넣으면 거부된다. clang은 받아준다.
        self.assertEqual(assemble('lss rcx,FWORD PTR [rax]', 'as'), (False, ''))
        self.assertEqual(assemble('lss rcx,FWORD PTR [rax]', 'clang'), (True, '480fb208'))



@unittest.skipUnless(TOOLS, 'as/clang/objdump 필요')
class EncodingControlPrefixTests(unittest.TestCase):
    """GAS 의사 프리픽스로 특정 SDM 행을 강제할 수 있다는 것을 고정한다.

    2026-09-21 최초 기록은 "같은 문법을 공유하는 두 행은 원리상 구분할 수 없다"고 적었으나
    틀렸다. `{load}`/`{store}`/`{disp32}`/`rex64`로 강제할 수 있다.
    """

    def test_load_store_prefix_selects_direction(self):
        # 기본 렌더링은 10 /r(store 방향)을 고른다.
        self.assertEqual(assemble('adc cl, dl'), (True, '10d1'))
        # 의사 프리픽스로 두 행을 각각 지정할 수 있다.
        self.assertEqual(assemble('{load} adc cl, dl'), (True, '12ca'))
        self.assertEqual(assemble('{store} adc cl, dl'), (True, '10d1'))

    def test_disp32_prefix_forces_near_branch(self):
        with tempfile.TemporaryDirectory() as directory:
            source = Path(directory) / 'a.s'
            obj = Path(directory) / 'a.o'
            source.write_text(HEADER + '.Ltarget:\n{disp32} ja .Ltarget\n', encoding='utf-8')
            subprocess.run(['as', '--64', '-mintel64', '-o', str(obj), str(source)],
                           check=True, capture_output=True)
            # 기본은 77 fe(rel8)지만 {disp32}는 0f 87 + rel32를 낸다.
            self.assertTrue(text_bytes(obj).startswith('0f87'))


if __name__ == '__main__':
    unittest.main()

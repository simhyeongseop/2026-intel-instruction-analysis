"""SDM Description repairs: fixed examples, untouched neighbours, and width counterexamples.

Byte expectations were observed with GNU 2.42/Clang 18.1.3. SDM memory/offset/index
widths are independent assertions; assembler acceptance alone is not a pass.
"""
import json
import shutil
import unittest

from pipeline import m2_tokenize, m3_combine, m4_generate
from pipeline.generation_contract import reviewed_generation_form, validate_generated
from pipeline.instruction_check import assemble
from pipeline.m5_assemble import ASM_HEADER
from pipeline.operand_forms import legacy_fields


FORMS = [
    ('VPMOVQD', ['xmm1/m128 {k1}{z}', 'xmm2'], 'EVEX.128.F3.0F38.W0 35 /r'),
    ('VSCATTERDPD', ['vm32y {k1}', 'ymm1'], 'EVEX.256.66.0F38.W1 A2 /vsib'),
    ('VSCATTERDPD', ['vm32z {k1}', 'zmm1'], 'EVEX.512.66.0F38.W1 A2 /vsib'),
    ('CALL', ['m16:16'], 'FF /3'), ('CALL', ['m16:64'], 'REX.W FF /3'),
    ('JMP', ['m16:16'], 'FF /5'), ('JMP', ['m16:64'], 'REX.W FF /5'),
    ('SYSEXIT', [], 'REX.W + 0F 35'), ('SYSRET', [], 'REX.W + 0F 07'),
]

# All 5 memory variations + 2 index variations + 4 far targets + 2 returns.
EXPECTED_BYTES = {
    'vpmovqd qword ptr [eax], xmm0': ('6762f27e083500',) * 2,
    'vpmovqd qword ptr [rax+rbx*4+0x10], xmm0': ('62f27e0835449802',) * 2,
    'vpmovqd qword ptr [rip+0x10], xmm0': ('62f27e08350510000000',) * 2,
    'vpmovqd qword ptr [eax] {k1}, xmm0': ('6762f27e093500',) * 2,
    'vpmovqd qword ptr [eax], xmm1': ('6762f27e083508',) * 2,
    'vscatterdpd [eax + xmm1] {k1}, ymm0': ('6762f2fd29a20408',) * 2,
    'vscatterdpd [eax + ymm1] {k1}, zmm0': ('6762f2fd49a20408',) * 2,
    'data16 call fword ptr [eax]': ('6766ff18', '6667ff18'),
    'rex64 call fword ptr [rax]': ('48ff18',) * 2,
    'data16 jmp fword ptr [eax]': ('6766ff28', '6667ff28'),
    'rex64 jmp fword ptr [rax]': ('48ff28',) * 2,
    'sysexitq': ('480f35',) * 2,
    'sysretq': ('480f07',) * 2,
}


def generated(name, types, opcode, row_id=123456):
    raw = dict(mnemonic=name, operands=', '.join(types), opcode=opcode,
               instruction=name + (' ' + ', '.join(types) if types else ''),
               op_en='', mode_support='Valid', source_page='999',
               description='raw SDM fixture must survive', cpuid_flag='')
    tokens = m2_tokenize.tokenize_row(raw, row_id)[0]
    before = json.dumps(tokens, sort_keys=True)
    rows = m3_combine.generate_combo_rows(tokens)
    assert json.dumps(tokens, sort_keys=True) == before
    return rows


def source(row):
    return m4_generate.build_line(row).partition('  # ')[0]


class DescriptionRepairTests(unittest.TestCase):
    def test_all_13_sources_and_raw_metadata(self):
        seen = set()
        for name, types, opcode in FORMS:
            for row in generated(name, types, opcode):
                text = source(row)
                if name != 'VPMOVQD' or '[' in text:
                    seen.add(text)
                self.assertEqual(row['operand_types'], ', '.join(types))
                self.assertEqual(row['description'], 'raw SDM fixture must survive')
                self.assertEqual(row['opcode'], opcode)
                self.assertTrue(json.loads(row['generation_corrections'])['reason'])
                self.assertNotEqual(row['input_status'], 'invalid', text)
        self.assertEqual(seen, set(EXPECTED_BYTES))

    def test_effective_types_and_pointer_width_metadata(self):
        pmov = generated(*FORMS[0])
        self.assertTrue(all('xmm1/m64' in r['effective_operand_types'] for r in pmov))
        for i, index in ((1, 'vm32x'), (2, 'vm32y')):
            self.assertTrue(generated(*FORMS[i])[0]['effective_operand_types'].startswith(index))
        for i, bits, address in ((3, 32, 32), (4, 80, 64), (5, 32, 32), (6, 80, 64)):
            memory = json.loads(generated(*FORMS[i])[0]['structured_operands'])[0]
            self.assertEqual((memory['data_bits'], memory['address_bits']), (bits, address))
            self.assertEqual(memory['assembly_size_bits'], 48)

    def test_exact_form_gates_leave_neighbours_unchanged(self):
        neighbours = [
            ('VPMOVQD', ['xmm1/m128 {k1}{z}', 'ymm2'], 'EVEX.256.F3.0F38.W0 35 /r'),
            ('VPMOVSQD', ['xmm1/m64 {k1}{z}', 'xmm2'], 'EVEX.128.F3.0F38.W0 25 /r'),
            ('VSCATTERDPD', ['vm32x {k1}', 'xmm1'], 'EVEX.128.66.0F38.W1 A2 /vsib'),
            ('VSCATTERDPS', ['vm32y {k1}', 'ymm1'], 'EVEX.256.66.0F38.W0 A2 /vsib'),
            ('VSCATTERDPD', ['vm32y {k1}', 'ymm1'], 'EVEX.256.66.0F38.W0 A2 /vsib'),
            ('CALL', ['m16:32'], 'FF /3'), ('JMP', ['m16:32'], 'FF /5'),
            ('SYSEXIT', [], '0F 35'), ('SYSRET', [], '0F 07'),
            ('MOV', ['Sreg', 'r/m64'], 'REX.W + 8E /r'),
            ('BOUND', ['r16', 'm16&16'], '62 /r'),
        ]
        for name, types, opcode in neighbours:
            with self.subTest(name=name, opcode=opcode):
                self.assertIsNone(reviewed_generation_form(name, opcode, types))
                self.assertTrue(all(not r['generation_corrections'] for r in generated(name, types, opcode)))
        self.assertEqual(source(generated('CALL', ['m16:32'], 'FF /3')[0]), 'call far ptr [eax]')
        self.assertEqual(source(generated('JMP', ['m16:32'], 'FF /5')[0]), 'jmp far ptr [eax]')

    def test_old_widths_missing_controls_and_rex_before_addr32_are_counterexamples(self):
        bad_values = [(['xmmword ptr [eax]', 'xmm0'], {}),
                      (['[eax + ymm1] {k1}', 'ymm0'], {}),
                      (['[eax + zmm1] {k1}', 'zmm0'], {}),
                      (['far ptr [eax]'], {}), (['fword ptr [eax]'], {'asm_prefix': 'rex64'}),
                      (['far ptr [eax]'], {}), (['fword ptr [eax]'], {'asm_prefix': 'rex64'}),
                      ([], {}), ([], {})]
        for (name, types, opcode), (values, rendering) in zip(FORMS, bad_values):
            with self.subTest(name=name, opcode=opcode):
                result = validate_generated(name, types, values, opcode=opcode, **rendering)
                self.assertEqual(result['status'], 'invalid')
        result = validate_generated('CALL', ['m16:64'], ['fword ptr [eax]'],
                                    opcode='REX.W FF /3', asm_prefix='rex64')
        self.assertIn('far_branch64_shared_spelling_requires_addr64', result['violations'])


@unittest.skipUnless(all(shutil.which(t) for t in ('as', 'clang', 'objcopy', 'objdump', 'readelf')),
                     'assembler inspection tools required')
class DescriptionRepairAssemblyTests(unittest.TestCase):
    def test_all_13_variants_actual_bytes_and_prefix_semantics(self):
        for text, expected in EXPECTED_BYTES.items():
            for tool, data in zip(('as', 'clang'), expected):
                with self.subTest(source=text, tool=tool):
                    observed = assemble(ASM_HEADER + text + '\n', tool)
                    self.assertEqual(observed['observation_status'], 'accepted')
                    self.assertEqual(observed['assembly']['stderr'], '')
                    self.assertEqual(observed['bytes'], data)
                    if text.startswith(('data16 ', 'rex64 ')):
                        raw, pos, rex, prefixes = legacy_fields(observed['bytes'])
                        if text.startswith('data16 '):
                            self.assertIn(0x66, prefixes)
                            self.assertIsNone(rex)
                        else:
                            self.assertEqual(rex, 0x48)
                            self.assertEqual(raw[pos - 1], 0x48)  # no legacy prefix after REX.W
                        self.assertEqual(raw[pos], 0xff)
                        self.assertEqual((raw[pos + 1] >> 3) & 7, 3 if 'call' in text else 5)


if __name__ == '__main__':
    unittest.main()

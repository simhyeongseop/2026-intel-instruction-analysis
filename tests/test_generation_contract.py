"""Independent counterexamples and fixed byte expectations for generator revision 2."""
import shutil
import tempfile
import unittest

from pipeline import m2_tokenize, m3_combine, m4_generate, m5_assemble, m8_clang_assemble
from pipeline.encoding_audit import check_encoding
from pipeline.generation_contract import validate_generated
from pipeline.instruction_check import assemble
from pipeline.operand_forms import match_token, operand


def tokens(mnemonic, types, opcode='', mode='Valid'):
    row = dict(mnemonic=mnemonic, operands=', '.join(types), opcode=opcode,
               instruction=mnemonic + ' ' + ', '.join(types), op_en='',
               mode_support=mode, source_page='999', description='fixture', cpuid_flag='')
    return m2_tokenize.tokenize_row(row, 0)[0]


class GenerationContractTests(unittest.TestCase):
    def test_unavailable_long_mode_row_cannot_use_64bit_memory_address(self):
        for mode in ('Invalid', 'N.E.', 'N.S.'):
            for address in ('[rax]', '[rax+rbx*4+0x10]', '[rip+0x10]'):
                result = validate_generated('ARPL', ['r/m16', 'r16'],
                                            ['word ptr ' + address, 'cx'], mode)
                self.assertIn('op0_address_unavailable_in_supported_mode', result['violations'])
            supported_address = validate_generated('ARPL', ['r/m16', 'r16'],
                                                  ['word ptr [eax]', 'cx'], mode)
            self.assertEqual(supported_address['status'], 'checked')
            self.assertFalse(supported_address['mode_valid'])
        valid = validate_generated('MOV', ['r64', 'r/m64'], ['rcx', 'qword ptr [rip+0x10]'])
        self.assertEqual(valid['status'], 'checked')

    def test_fixed_control_register_and_range_are_distinct(self):
        self.assertEqual(m3_combine.register_candidate('CR8'), 'cr8')
        self.assertEqual(m3_combine.register_candidate('CR0-CR7'), 'cr0')
        self.assertEqual(validate_generated('MOV', ['r64', 'CR8'], ['rcx', 'cr0'])['status'], 'invalid')

    def test_sdm_r8_is_not_literal_r8(self):
        self.assertTrue(match_token('r8', operand('cl')))
        self.assertFalse(match_token('r8', operand('r8')))
        self.assertEqual(validate_generated('ADC', ['r/m8', 'r8'], ['cl', 'cl'])['status'], 'checked')

    def test_unknown_and_decoration_never_mean_checked(self):
        self.assertEqual(validate_generated('X', ['mystery'], ['foo'])['status'], 'unverified')
        result = validate_generated('VADDPS', ['zmm1{k1}{z}'], ['zmm0{k1}{z}'])
        self.assertEqual(result['status'], 'unverified')
        self.assertIn('op0_unmodelled_decoration', result['unverified'])
        self.assertFalse(result['meaning_verified'])

    def test_relative_mode_and_distance_intent_are_separate(self):
        small = m3_combine.expand_token('rel8', 'relative')[0][0]
        large = m3_combine.expand_token('rel32', 'relative')[0][0]
        self.assertEqual((small, large), ('.Ltarget', '.Ltarget32'))
        self.assertEqual(validate_generated('JMP', ['rel16'], ['.Ltarget16'])['status'], 'invalid')
        self.assertEqual(validate_generated('XBEGIN', ['rel16'], ['.Ltarget16'])['status'], 'checked')
        self.assertIn('relative_target_policy', validate_generated('JMP', ['rel32'], [large])['checked_constraints'])

    def test_moffs_data_width_address_width_and_canonicality(self):
        result = validate_generated('MOV', ['AL', 'moffs8'], ['al', 'byte ptr [0x100000000]'])
        self.assertEqual(result['status'], 'checked')
        memory = result['operands'][1]
        self.assertEqual((memory['data_bits'], memory['address_bits']), (8, 64))
        self.assertTrue(memory['canonical_address_48'])
        self.assertFalse(result['execution_ready'])
        for bad in ('qword ptr [0x100000000]', 'byte ptr [rax+0x100000000]'):
            self.assertEqual(validate_generated('MOV', ['AL', 'moffs8'], ['al', bad])['status'], 'invalid')
        edge = validate_generated('MOV', ['AL', 'moffs8'], ['al', 'ds:0x123456789abcdef0'])
        self.assertFalse(edge['operands'][1]['canonical_address_48'])

    def test_implicit_string_addresses_do_not_accept_sib_or_displacement(self):
        for mnemonic, expected in [('CMPS', ['byte ptr [rsi]', 'byte ptr [rdi]']),
                                   ('REP MOVS', ['byte ptr [rdi]', 'byte ptr [rsi]'])]:
            combos = m3_combine.build_combos_for_row(tokens(mnemonic, ['m8', 'm8']))
            self.assertEqual([r['operands'] for r in combos], [expected])
        for source in ('byte ptr [rax+rbx*4]', 'byte ptr [rsi+16]', 'byte ptr [rip+16]'):
            self.assertEqual(validate_generated('CMPS', ['m8', 'm8'], [source, 'byte ptr [rdi]'])['status'], 'invalid')
        self.assertFalse(m3_combine.can_vary_memory(['byte ptr [eax]'], 'REP MOVS'))
        self.assertTrue(m3_combine.can_vary_memory(['byte ptr [eax]']))

    def test_vsib_destination_index_mask_physical_numbers(self):
        rows = tokens('VGATHERDPS', ['xmm1', 'vm32x', 'xmm2'], 'VEX.128.66.0F38.W0 92 /r')
        combos = m3_combine.build_combos_for_row(rows)
        self.assertEqual(combos[0]['operands'], ['xmm0', '[eax + xmm1]', 'xmm2'])
        for combo in combos:
            checked = validate_generated('VGATHERDPS', combo['operand_types'], combo['operands'])
            self.assertNotIn('vsib_vector_register_overlap', checked['violations'])
        conflict = validate_generated('VGATHERDPS', ['ymm1', 'vm32x', 'ymm2'], ['ymm0', '[eax+xmm1]', 'ymm1'])
        self.assertIn('vsib_vector_register_overlap', conflict['violations'])
        scatter = validate_generated('VSCATTERDPS', ['vm32x', 'xmm1'], ['[eax+xmm1]', 'xmm1'])
        self.assertNotIn('vsib_vector_register_overlap', scatter['violations'])

    def test_token_metadata_and_old_schema_gate(self):
        rows = tokens('MOV', ['r64', 'CR8'], 'REX.R + 0F 20 /r')
        self.assertTrue({'opcode', 'description', 'form_hash'} <= rows[0].keys())
        old = [{k: v for k, v in row.items() if k != 'opcode'} for row in rows]
        with self.assertRaisesRegex(ValueError, 'regenerate'):
            m3_combine.generate_combo_rows(old)

    def test_prefetchit_and_xlat_implicit_addresses(self):
        for mnemonic, source in [('PREFETCHIT0', 'byte ptr [rip+0x10]'),
                                 ('PREFETCHIT1', 'byte ptr [rip+0x10]'), ('XLAT', 'byte ptr [rbx]')]:
            combos = m3_combine.build_combos_for_row(tokens(mnemonic, ['m8']))
            self.assertEqual([c['operands'] for c in combos], [[source]])
        self.assertEqual(validate_generated('PREFETCHIT0', ['m8'], ['byte ptr [rax]'])['status'], 'invalid')
        self.assertEqual(validate_generated('XLAT', ['m8'], ['byte ptr [rbx+16]'])['status'], 'invalid')

    def test_changed_source_or_form_never_inherits_old_id(self):
        old = [dict(combo_id='9', row_id='0', combo_index=0, mnemonic='MOV', operands='rcx, cr0', form_hash='one', constraint_hash='A'),
               dict(combo_id='50', row_id='0', combo_index=1, mnemonic='MOV', operands='rcx, cr0', form_hash='one', constraint_hash='A')]
        new = [dict(old[0], operands='rcx, cr8')]
        self.assertEqual(m3_combine.assign_stable_combo_ids(new, old)[0]['combo_id'], 51)
        self.assertEqual(m3_combine.assign_stable_combo_ids([dict(old[0], form_hash='two')], old)[0]['combo_id'], 51)
        self.assertEqual(m3_combine.assign_stable_combo_ids([dict(old[0], constraint_hash='B')], old)[0]['combo_id'], 51)

    def test_regeneration_ids_are_idempotent(self):
        rows = tokens('MOV', ['AL', 'moffs8'], 'REX.W + A0')
        first = m3_combine.generate_combo_rows(rows)
        again = m3_combine.generate_combo_rows(rows, first)
        self.assertEqual(first, again)
        self.assertEqual(m4_generate.build_line(first[1]).partition('  # ')[0], 'rex64 movabs al, byte ptr [0x100000000]')


class EncodingAuditTests(unittest.TestCase):
    def check(self, data, opcode, types='', status='checked', values=''):
        return check_encoding(data, dict(row_id='x', opcode=opcode, operand_types=types, input_status=status, operands=values))

    def test_branch_width_and_actual_target(self):
        self.assertEqual(self.check('77fe', '0F 87 cd', 'rel32')['row_reach'], 'different')
        self.assertEqual(self.check('0f87fa0f0000', '0F 87 cd', 'rel32')['row_reach'], 'matched')
        self.assertEqual(self.check('0f87fa000000', '0F 87 cd', 'rel32')['row_reach'], 'different')
        self.assertEqual(self.check('77fe', '77 cb', 'rel8')['row_reach'], 'matched')
        row = dict(opcode='E3 cb', operand_types='rel8', input_status='checked', mode_support='N.E.')
        result = check_encoding('e3fe', row)
        self.assertEqual(result['row_reach'], 'matched')
        self.assertFalse(result['coverage_eligible'])

    def test_moffs_and_rex_w_rows(self):
        self.assertEqual(self.check('a00000000001000000', 'A0', 'AL, moffs8', values='al, byte ptr [0x100000000]')['row_reach'], 'matched')
        self.assertEqual(self.check('a00000000001000000', 'REX.W + A0', 'AL, moffs8')['row_reach'], 'different')
        self.assertEqual(self.check('48a00000000001000000', 'REX.W + A0', 'AL, moffs8', values='al, byte ptr [0x100000000]')['row_reach'], 'matched')
        self.assertEqual(self.check('a10000000001000000', 'A1', 'AX, moffs16')['row_reach'], 'different')
        self.assertEqual(self.check('6648a10000000001000000', 'A1', 'AX, moffs16', values='ax, word ptr [0x100000000]')['row_reach'], 'different')
        self.assertEqual(self.check('a00000000000000000', 'A0', 'AL, moffs8', values='al, byte ptr [0x100000000]')['row_reach'], 'different')
        edge = dict(opcode='A0', operand_types='AL, moffs8', operands='al, ds:0x123456789abcdef0', input_status='checked', mode_support='Valid', test_kind='edge')
        self.assertFalse(check_encoding('a0f0debc9a78563412', edge)['coverage_eligible'])

    def test_vector_family_length_width_and_prefix_counterexamples(self):
        row = 'EVEX.128.66.0F.W1 58 /r'
        self.assertEqual(self.check('62f1fd0858c1', row)['status'], 'fields_match')
        for bad in ('62f1fd2858c1', '62f17d0858c1', '62f1fc0858c1', 'c5f958c1'):
            self.assertEqual(self.check(bad, row)['status'], 'different_encoding')
        self.assertEqual(self.check('c5f858c1', 'VEX.128.0F.WIG 58 /r')['row_reach'], 'partial')
        self.assertFalse(self.check('c5f858c1', 'VEX.128.0F.WIG 58 /r')['coverage_eligible'])

    def test_immediate_tail_and_fixed_cr8(self):
        self.assertEqual(self.check('81c101000000', '81 /0 id')['status'], 'fields_match')
        self.assertEqual(self.check('81c101', '81 /0 id')['status'], 'different_encoding')
        self.assertEqual(self.check('440f20c1', 'REX.R + 0F 20 /0', 'r64, CR8', values='rcx, cr8')['row_reach'], 'matched')
        self.assertEqual(self.check('0f20c1', '0F 20 /r', 'r64, CR8')['row_reach'], 'different')
        self.assertEqual(self.check('440f20c0', 'REX.R + 0F 20 /0', 'r64, CR8', values='rcx, cr8')['row_reach'], 'different')
        self.assertEqual(check_encoding('e900000000', {'opcode': 'E9 cd'}, True)['row_reach'], 'unverified')
        self.assertEqual(self.check('01', '01 /r')['row_reach'], 'different')


class WholeRegenerationTests(unittest.TestCase):
    def test_all_rows_regenerate_with_safe_identity_and_known_input_violations(self):
        isa = m2_tokenize.read_isa_db(m2_tokenize.IN_CSV)
        token_rows = []
        for index, row in enumerate(isa):
            token_rows.extend(m2_tokenize.tokenize_row(row, index, len(token_rows))[0])
        prior = m3_combine.read_tokens(m3_combine.OUT_CSV)
        current = m3_combine.generate_combo_rows(token_rows, prior)
        again = m3_combine.generate_combo_rows(token_rows, current)
        self.assertEqual(current, again)
        self.assertEqual(len(current), len({r['combo_id'] for r in current}))
        negative = [r for r in current if r['input_status'] == 'invalid']
        self.assertEqual(len(negative), 72)
        self.assertEqual(sum(r['input_violations'] == 'rel16_unavailable_in_64bit_mode' for r in negative), 33)
        self.assertEqual(sum('address_unavailable_in_supported_mode' in r['input_violations'] for r in negative), 39)
        self.assertTrue(all(r['mode_support'] != 'Valid' for r in negative))
        old_by_id = {str(r['combo_id']): r for r in prior}
        for row in current:
            if str(row['combo_id']) in old_by_id:
                before = m4_generate.build_line(old_by_id[str(row['combo_id'])]).partition('  # ')[0]
                after = m4_generate.build_line(row).partition('  # ')[0]
                self.assertEqual(before, after)


@unittest.skipUnless(all(shutil.which(t) for t in ('as', 'clang', 'objdump', 'objcopy', 'readelf')), 'assembler inspection tools required')
class AssemblyIntegrationTests(unittest.TestCase):
    def test_all_moffs_widths_and_directions(self):
        for accumulator, width, prefix in [('AL', 8, ''), ('AX', 16, '66'),
                                            ('EAX', 32, ''), ('RAX', 64, '48')]:
            for store in (False, True):
                opcode = ('A2' if width == 8 else 'A3') if store else ('A0' if width == 8 else 'A1')
                template = ('REX.W + ' if width == 64 else '') + opcode
                types = [f'moffs{width}', accumulator] if store else [accumulator, f'moffs{width}']
                generated = m3_combine.generate_combo_rows(tokens('MOV', types, template))
                row = next(r for r in generated if r['asm_mnemonic'] == 'movabs')
                code = m4_generate.build_line(row).partition('  # ')[0]
                for tool in ('as', 'clang'):
                    with self.subTest(code=code, tool=tool):
                        result = assemble(m5_assemble.ASM_HEADER + code + '\n', tool)
                        self.assertEqual(result['bytes'], prefix + opcode.lower() + '0000000001000000')

    def test_xbegin_rel16_is_valid_but_tool_acceptance_is_not_width_verification(self):
        rows = m3_combine.generate_combo_rows(tokens('XBEGIN', ['rel16'], 'C7 F8'))
        row = rows[0]
        self.assertEqual(row['input_status'], 'checked')
        self.assertEqual(row['test_kind'], 'encoding_directed')
        code = m4_generate.build_line(row).partition('  # ')[0]
        self.assertEqual(code, 'data16 xbegin .Ltarget16')
        self.assertEqual(check_encoding('66c7f8fb0f', row)['row_reach'], 'matched')
        # A 32-bit tail after 66 is not the intended 16-bit instruction.
        self.assertEqual(check_encoding('66c7f8f90f0000', row)['row_reach'], 'different')
        gnu = assemble(m5_assemble.ASM_HEADER + code + '\n', 'as')
        self.assertEqual(gnu['bytes'], '66c7f8fb0f')

    def test_independent_encoding_constants_on_both_tools(self):
        expected = [('mov rcx, cr8', '440f20c1'), ('mov cr8, rcx', '440f22c1'),
                    ('ja .Ltarget32', '0f87fa0f0000'), ('ja .Ltarget', '77fe'),
                    ('movabs al, byte ptr [0x100000000]', 'a00000000001000000'),
                    ('rex64 movabs al, byte ptr [0x100000000]', '48a00000000001000000'),
                    ('rep movs byte ptr [rdi], byte ptr [rsi]', 'f3a4')]
        for tool in ('as', 'clang'):
            for code, data in expected:
                with self.subTest(tool=tool, code=code):
                    result = assemble(m5_assemble.ASM_HEADER + code + '\n', tool)
                    self.assertEqual(result['bytes'], data)
                    self.assertFalse(result['relocations'])

    def test_success_warnings_are_retained_and_clean_gather_has_none(self):
        for module in (m5_assemble, m8_clang_assemble):
            with tempfile.TemporaryDirectory() as tmp:
                status, diagnostics, _ = module.assemble_one('vgatherdps xmm0, [eax+xmm1], xmm1', tmp)
                self.assertTrue(status == 'ok' or status is True)
                self.assertIn('distinct', diagnostics)
                _, clean, _ = module.assemble_one('vgatherdps xmm0, [eax+xmm1], xmm2', tmp)
                self.assertEqual(clean, '')


if __name__ == '__main__':
    unittest.main()

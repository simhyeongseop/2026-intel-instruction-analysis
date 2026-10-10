"""도구 계약과 독립적인 바이트 기대값을 검증한다. unittest만 필요."""
import csv
import json
from pathlib import Path
import shutil
import subprocess
import sys
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from pipeline.instruction_check import (HEADER, assemble, check_instruction, command,
                                        decode_lines, evaluate_expected)
from pipeline.operand_forms import check_opcode_template, load_db, match_token, operand, parse_instruction
from scripts.asm_linter import exit_code, source_records

LINUX_TOOLS = sys.platform == 'linux' and all(shutil.which(t) for t in ('as', 'clang', 'objdump', 'objcopy', 'readelf'))


class InputTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.db = load_db()

    def test_semicolon_is_separator(self):
        records = list(source_records('.intel_syntax noprefix; mov eax, ebx # comment\nlabel: add eax, 1'))
        self.assertEqual([(r[1], r[2]) for r in records], [('.intel_syntax noprefix', 'skipped'),
                          ('mov eax, ebx', 'instruction'), ('add eax, 1', 'instruction')])

    def test_mode_and_macro_never_silently_ignored(self):
        for directive in ('.code32', '.att_syntax', '.macro foo', '.data'):
            self.assertTrue(all(x[2] == 'unsupported' for x in source_records(directive + '\nmov eax, ebx')))

    def test_unknown_never_means_valid(self):
        result = check_instruction('madeup eax, ebx', self.db, static_only=True)
        self.assertEqual(result['status'], 'incomplete')
        self.assertEqual(result['sdm']['status'], 'mnemonic_not_found')
        self.assertFalse(result['sdm']['meaning_verified'])

    def test_multi_statement_rejected_at_api_boundary(self):
        for code in ('mov eax, ebx; nop', 'nop\n.include "private"', '.byte 0x90'):
            self.assertEqual(check_instruction(code, self.db)['status'], 'incomplete')

    def test_operand_families_and_immediate_boundaries(self):
        for form, text, expected in [('r/m32', 'eax', True), ('r/m32', 'mm0', False),
                                     ('xmm1/m64', 'qword ptr [rax]', True), ('xmm1/m64', 'ymm0', False),
                                     ('imm8', '256', False), ('imm8', '-128', True),
                                     ('m16:64', 'tbyte ptr [rax]', True), ('m32', '[rax]', None)]:
            with self.subTest(form=form, text=text):
                self.assertIs(match_token(form, operand(text)), expected)

    def test_masks_prefixes_not_overclaimed(self):
        parsed = parse_instruction('lock add dword ptr [rax], 1')
        self.assertEqual(parsed['prefixes'], ['lock'])
        self.assertIsNone(match_token('zmm1', operand('zmm0{k1}{z}')))
        self.assertEqual(operand('bnd4')['kind'], 'unknown')

    def test_opcode_comparison_is_partial(self):
        row = {'row_id': 'case', 'opcode': 'REX.W + 0F B2 /r'}
        self.assertEqual(check_opcode_template('67480fb208', row)['status'], 'fields_match')
        self.assertEqual(check_opcode_template('670fb208', row)['status'], 'different_encoding')
        self.assertFalse(check_opcode_template('67480fb208', row)['meaning_verified'])
        row['opcode'] = 'VEX.128.66.0F.WIG 58 /r'
        self.assertEqual(check_opcode_template('c5f858c1', row)['status'], 'not_checked')

    def test_exit_codes(self):
        self.assertEqual(exit_code([{'status': 'accepted'}]), 0)
        self.assertEqual(exit_code([{'status': 'needs_review'}]), 1)
        self.assertEqual(exit_code([{'status': 'skipped'}]), 2)
        self.assertEqual(exit_code([{'status': 'rejected'}, {'status': 'incomplete'}]), 2)

    def test_missing_tool_and_timeout(self):
        self.assertEqual(command(['this-tool-does-not-exist'])['failure'], 'unavailable')
        with patch('pipeline.instruction_check.subprocess.run', side_effect=subprocess.TimeoutExpired('as', 1)):
            self.assertEqual(command(['as'])['failure'], 'timeout')

    def test_signal_exit_is_not_diagnostic_rejection(self):
        with patch('pipeline.instruction_check.subprocess.run',
                   return_value=subprocess.CompletedProcess(['as'], -11, '', 'SIGSEGV')):
            observed = command(['as'])
        self.assertEqual(observed['status'], 'process_crash')
        self.assertEqual(observed['returncode'], -11)

    def test_timeout_preserves_partial_output(self):
        error = subprocess.TimeoutExpired(['as'], 1, output=b'partial out', stderr=b'partial err')
        with patch('pipeline.instruction_check.subprocess.run', side_effect=error):
            observed = command(['as'])
        self.assertEqual(observed['status'], 'timeout')
        self.assertEqual(observed['stdout_partial'], 'partial out')
        self.assertEqual(observed['stderr'], 'partial err')

    def test_expected_row_evaluation_does_not_mutate_observation(self):
        result = {'source': 'mov eax, ebx', 'status': 'accepted', 'findings': [],
                  'semantic_status': 'not_verified',
                  'gnu_as': {'status': 'accepted', 'bytes': '89d8'}}
        row = {'row_id': 'case', 'opcode': '03 /r'}
        evaluated = evaluate_expected(result, row)
        self.assertEqual(result['status'], 'accepted')
        self.assertEqual(evaluated['status'], 'needs_review')
        self.assertEqual(evaluated['encoding_target_match'], 'different_encoding')
        self.assertEqual(evaluated['encoding_policy'], 'allow_equivalent')

    def test_syntax_axis_rejects_unimplemented_input_without_reusing_intel(self):
        result = check_instruction('mov eax, ebx', self.db, syntax='att')
        self.assertEqual(result['status'], 'incomplete')
        self.assertEqual(result['validation_status'], 'unsupported')
        self.assertEqual(result['syntax'], 'att')

    def test_json_cli_other_working_directory(self):
        process = subprocess.run([sys.executable, str(ROOT / 'scripts/asm_linter.py'), '--static-only',
                                  '--format', 'json', 'mov eax, ebx'], cwd=ROOT.parent, capture_output=True)
        self.assertEqual(process.returncode, 2)
        report = json.loads(process.stdout)
        self.assertEqual(report['schema_version'], 1)
        self.assertEqual(report['counts'], {'incomplete': 1})


@unittest.skipUnless(LINUX_TOOLS, 'WSL/Linux의 GNU/Clang 도구 필요')
class LiveToolTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.db = load_db()

    def test_independent_bytes(self):
        # Intel opcode/ModRM에서 손으로 결정할 수 있는 값. 도구가 만든 정답 재사용 아님.
        for source, expected in [('mov eax, ebx', '89d8'), ('add al, 0x12', '0412'),
                                 ('push rcx', '51'), ('push cx', '6651'), ('ud2', '0f0b')]:
            with self.subTest(source=source):
                result = assemble(HEADER + source + '\n')
                self.assertEqual(result['bytes'], expected)
                self.assertTrue(result['inspection_complete'])
                self.assertFalse(result['relocations'])

    def test_all_long_instruction_bytes_are_preserved(self):
        result = assemble(HEADER + 'mov rax, 0x123456789abcdef0\n')
        self.assertEqual(result['bytes'], '48b8f0debc9a78563412')
        self.assertEqual(result['instructions'][0]['bytes'], result['bytes'])

    def test_existing_answer_keys_acceptance(self):
        count = 0
        for path in sorted((ROOT / 'tests/answer_keys').glob('*.csv')):
            with path.open(encoding='utf-8') as stream:
                for row in csv.DictReader(stream):
                    with self.subTest(case=row['id']):
                        result = assemble(HEADER + row['intel_asm'] + '\n')
                        self.assertEqual(result['status'], 'accepted' if row['expect_assemble'] == 'ok' else 'rejected')
                        count += 1
        self.assertEqual(count, 23)

    def test_symbol_and_branch_need_context(self):
        symbol = check_instruction('mov eax, dword ptr [external_symbol]', self.db)
        self.assertTrue(symbol['gnu_as']['relocations'])
        self.assertEqual(symbol['roundtrip']['status'], 'context_required')
        branch = check_instruction('jmp .Ltarget', self.db)
        self.assertEqual(branch['roundtrip']['status'], 'context_required')

    def test_acceptance_is_not_validity(self):
        self.assertEqual(check_instruction('mov eax, rbx', self.db)['status'], 'rejected')
        self.assertEqual(check_instruction('mov eax, ebx', self.db)['status'], 'accepted')
        self.assertEqual(check_instruction('mov eax, ebx', self.db)['semantic_status'], 'not_verified')

    def test_warnings_not_lost(self):
        row = check_instruction('mov al, 0x100', self.db)
        self.assertTrue(row['gnu_as']['assembly']['stderr'])
        self.assertNotEqual(row['status'], 'accepted')

    def test_far_pointer_display_observation_is_conditional(self):
        row = check_instruction('lss rcx, tbyte ptr [eax]', self.db)
        display = row['gnu_as']['instructions'][0]['text']
        codes = [f['code'] for f in row['findings']]
        self.assertEqual('far_pointer_display' in codes, 'FWORD PTR' in display)


if __name__ == '__main__':
    unittest.main(verbosity=2)

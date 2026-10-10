"""Small, partial checks of generated inputs; assembly acceptance is a separate fact.

`checked` means the listed input checks passed, never full ISA/CPU validity.
Unmodelled notation stays `unverified`. Opcode bytes are checked elsewhere.
"""
import hashlib
import json
import re

from pipeline.operand_forms import GPR, PTR_BITS, match_token, operand

REVISION = 'sdm-input-v4-mode-address-check'
STRING_NAMES = {'CMPS', 'MOVS', 'STOS', 'SCAS', 'LODS', 'INS', 'OUTS'}


def reviewed_generation_form(mnemonic, opcode, types):
    """Narrow SDM Description corrections; raw DB/form tokens stay unchanged.

    Keys include the mnemonic, complete opcode, and complete operand form. These
    rules do not depend on row IDs and do not repair neighbouring instructions.
    Evidence: docs/REJECTED_INPUT_REVIEW_2026-09-28.md and its saved SDM pages.
    """
    opcode = re.sub(r'REX\.W\s*\+\s*', 'REX.W ', opcode.upper())
    key = (mnemonic.upper(), ' '.join(opcode.split()),
           tuple(re.sub(r'\s+', '', token) for token in types))
    rules = {
        ('VPMOVQD', 'EVEX.128.F3.0F38.W0 35 /r'.upper(), ('xmm1/m128{k1}{z}', 'xmm2')):
            ('vpmovqd128_half_memory', 'SDM PDF 2054-2055: Half Mem and 2 dwords require m64, not table m128.'),
        ('VSCATTERDPD', 'EVEX.256.66.0F38.W1 A2 /vsib'.upper(), ('vm32y{k1}', 'ymm1')):
            ('vscatterdpd256_half_index', 'SDM PDF 2202-2204: 4 dword indices require vm32x/XMM for YMM data.'),
        ('VSCATTERDPD', 'EVEX.512.66.0F38.W1 A2 /vsib'.upper(), ('vm32z{k1}', 'zmm1')):
            ('vscatterdpd512_half_index', 'SDM PDF 2202-2204: 8 dword indices require vm32y/YMM for ZMM data.'),
        ('CALL', 'FF /3', ('m16:16',)):
            ('far_branch16_size', 'SDM PDF 239-242: explicit data16 selects the 16-bit offset; fword is the shared far-memory spelling.'),
        ('JMP', 'FF /5', ('m16:16',)):
            ('far_branch16_size', 'SDM PDF 622-624: explicit data16 selects the 16-bit offset; fword is the shared far-memory spelling.'),
        ('CALL', 'REX.W FF /3', ('m16:64',)):
            ('far_branch64_size', 'SDM PDF 239-242: explicit rex64 selects the 64-bit offset. Use [rax] so Clang does not put addr32 after REX.W.'),
        ('JMP', 'REX.W FF /5', ('m16:64',)):
            ('far_branch64_size', 'SDM PDF 622-624: explicit rex64 selects the 64-bit offset. Use [rax] so Clang does not put addr32 after REX.W.'),
        ('SYSEXIT', 'REX.W 0F 35', ()):
            ('system_return64_size', 'SDM PDF 1408: sysexitq explicitly selects return to 64-bit user code.'),
        ('SYSRET', 'REX.W 0F 07', ()):
            ('system_return64_size', 'SDM PDF 1411: sysretq explicitly selects return to 64-bit user code.'),
    }
    rule = rules.get(key)
    if rule is None:
        return None
    identifier, reason = rule
    effective = list(types)
    if identifier == 'vpmovqd128_half_memory':
        effective[0] = effective[0].replace('/m128', '/m64')
    elif identifier == 'vscatterdpd256_half_index':
        effective[0] = effective[0].replace('vm32y', 'vm32x')
    elif identifier == 'vscatterdpd512_half_index':
        effective[0] = effective[0].replace('vm32z', 'vm32y')
    return {'id': identifier, 'reason': reason, 'effective_types': effective,
            'asm_prefix': 'data16' if identifier == 'far_branch16_size' else
                          'rex64' if identifier == 'far_branch64_size' else '',
            'asm_mnemonic': mnemonic.lower() + 'q' if identifier == 'system_return64_size' else ''}


def digest(value):
    return hashlib.sha256(json.dumps(value, sort_keys=True, ensure_ascii=False,
                                     separators=(',', ':')).encode()).hexdigest()


def form_hash(row):
    return digest({k: row.get(k, '') for k in
                   ('opcode', 'instruction', 'operands', 'op_en', 'mode_support',
                    'description', 'cpuid_flag', 'source_page')})


def source_hash(mnemonic, operands, prefix=''):
    return digest([prefix, mnemonic.lower(), operands])


def structured_operand(token, text):
    """Keep data width and address width separate, including fixed registers/VSIB."""
    result = operand(text)
    result['sdm_token'] = token
    result['data_bits'] = result.pop('bits')
    result['address_bits'] = None
    regs = result.get('address_registers', [])
    scalar = [r for r in regs if r in GPR]
    if scalar:
        result['address_bits'] = GPR[scalar[0]]
        result['base'] = scalar[0]
    vector = [r for r in regs if re.fullmatch(r'[xyz]mm\d+', r)]
    result['index'] = vector[0] if vector else scalar[1] if len(scalar) > 1 else None
    scale = re.search(r'\*\s*([1248])\b', text)
    result['scale'] = int(scale.group(1)) if scale else 1 if result['index'] else None
    result['displacement'] = None
    offset = re.search(r'([+-])\s*(0x[0-9a-f]+|\d+)\s*\]', text.lower())
    if offset:
        result['displacement'] = int(offset.group(2), 0) * (-1 if offset.group(1) == '-' else 1)
    if 'rip' in text:
        result.update(address_bits=64, base='rip')
    clean = re.sub(r'\{[^}]*\}', '', token).strip()
    if re.fullmatch(r'(?:[A-Z]{2,3}|[CD]R\d+)', clean):
        result['fixed_register'] = clean.lower()
    moffs = re.fullmatch(r'moffs(8|16|32|64)', clean)
    if moffs:
        address = re.search(r'0x[0-9a-f]+', text.lower())
        result.update(kind='moffs', intended_data_bits=int(moffs.group(1)), address_bits=64)
        # ds:offset carries no data-size spelling; that width comes from the accumulator.
        result['data_bits'] = result['data_bits'] or int(moffs.group(1))
        result['address'] = int(address.group(), 16) if address else None
        value = result['address']
        result['canonical_address_48'] = (value is not None and
            (value < 1 << 47 or (0xffff800000000000 <= value < 1 << 64)))
    relative = re.fullmatch(r'rel(8|16|32|64)', clean)
    if relative:
        result.update(kind='relative', displacement_bits=int(relative.group(1)))
    return result


def validate_generated(mnemonic, types, values, mode_support='Valid', *, opcode='',
                       asm_prefix='', asm_mnemonic=''):
    """Check selected constraints independently of candidate selection tables."""
    violations, unknown, checks = [], [], []
    correction = reviewed_generation_form(mnemonic, opcode, types)
    effective = correction['effective_types'] if correction else types
    structured = [structured_operand(t, v) for t, v in zip(types, values)]
    # A row unavailable in long mode cannot use a 64-bit base or RIP-relative
    # addressing in its supported modes. Keep the source as a negative test.
    # This does not infer a supported mode from assembler acceptance.
    if mode_support in ('Invalid', 'N.E.', 'N.S.'):
        for i, op in enumerate(structured):
            if op['kind'] == 'mem' and op['address_bits'] == 64:
                violations.append('op%d_address_unavailable_in_supported_mode' % i)
    if len(types) != len(values):
        violations.append('operand_count')
    name = mnemonic.split()[-1].upper()
    if correction and correction['id'].startswith('far_branch'):
        if asm_prefix != correction['asm_prefix']:
            violations.append('far_branch_size_prefix')
        checks.append('far_branch_size_prefix')
    if correction and correction['id'] == 'system_return64_size':
        if asm_mnemonic != correction['asm_mnemonic'] or asm_prefix:
            violations.append('system_return64_size_spelling')
        checks.append('system_return64_size_spelling')
    for i, (token, value, op) in enumerate(zip(effective, values, structured)):
        clean = re.sub(r'\{[^}]*\}', '', token).strip()
        # Reuse the public *partial* form checker, not the generator's mapping tables.
        plain = operand(re.sub(r'\{[^}]*\}', '', value).strip())
        if correction and correction['id'].startswith('far_branch'):
            # In this shared Intel spelling fword denotes the far form, while
            # data16/REX.W selects the actual offset width. A literal fword=48
            # check alone would contradict the generated encoding.
            if asm_prefix == correction['asm_prefix'] and value.startswith('fword ptr ['):
                bits = 32 if correction['id'] == 'far_branch16_size' else 80
                op.update(assembly_size_bits=op['data_bits'], data_bits=bits,
                          data_width_source='far_branch_operand_size_prefix')
                plain['bits'] = bits
            else:
                violations.append('far_branch_size_spelling')
            if correction['id'] == 'far_branch64_size' and op['address_bits'] != 64:
                # Source [eax] makes Clang emit addr32 after explicit REX.W,
                # cancelling W. This is a shared-rendering policy check, not
                # a claim that the ISA forbids addr32 far branches.
                violations.append('far_branch64_shared_spelling_requires_addr64')
        if correction and types[i] != token and op['kind'] == 'mem':
            op['effective_sdm_token'] = token
        match = match_token(clean, plain)
        if correction and correction['id'].startswith('vscatterdpd') and i == 0:
            family = 'xmm' if correction['id'] == 'vscatterdpd256_half_index' else 'ymm'
            match = op['kind'] == 'mem' and bool(re.fullmatch(family + r'\d+', op.get('index') or ''))
            checks.append('vscatterdpd_index_width')
        fixed = re.fullmatch(r'(?:CR|DR)(\d+)', clean)
        control_range = re.fullmatch(r'(CR|DR)(\d+)-(?:CR|DR)(\d+)', clean)
        if fixed:
            match = value.lower() == clean.lower()
        elif control_range:
            actual = re.fullmatch(control_range.group(1).lower() + r'(\d+)', value)
            match = bool(actual) and int(control_range.group(2)) <= int(actual.group(1)) <= int(control_range.group(3))
        if name == 'LODS' and clean in ('AL', 'AX', 'EAX', 'RAX') and op['kind'] == 'mem':
            match = op['data_bits'] == GPR[clean.lower()]
        if op['kind'] == 'moffs':
            match = (op['address'] is not None and 0 <= op['address'] < 1 << op['address_bits']
                     and op['data_bits'] == op['intended_data_bits'] and
                     bool(re.fullmatch(r'(?:ds:0x[0-9a-f]+|(?:byte|word|dword|qword) ptr \[0x[0-9a-f]+\])', value.lower())))
            checks.append('moffs_data_and_address_width_separate')
        elif op['kind'] == 'relative':
            match = value == ('.Ltarget' if op['displacement_bits'] == 8 else
                               '.Ltarget' + str(op['displacement_bits']))
            checks.append('relative_target_policy')
            if op['displacement_bits'] == 64 or (op['displacement_bits'] == 16 and name != 'XBEGIN'):
                violations.append('rel%d_unavailable_in_64bit_mode' % op['displacement_bits'])
        if match is False:
            violations.append('op%d_form' % i)
        elif match is None:
            unknown.append('op%d_unmodelled_form' % i)
        else:
            checks.append('op%d_form' % i)
        if '{' in token or '{' in value:
            unknown.append('op%d_unmodelled_decoration' % i)
    if name in STRING_NAMES:
        memory = [o for o in structured if o['kind'] == 'mem']
        expected = (['rdi', 'rsi'] if name == 'MOVS' else ['rsi', 'rdi'] if name == 'CMPS'
                    else ['rsi'] if name in ('LODS', 'OUTS') else ['rdi'])
        actual = [{'esi': 'rsi', 'edi': 'rdi'}.get(o.get('base'), o.get('base')) for o in memory]
        if actual != expected:
            violations.append('implicit_string_addresses')
        if any(o.get('index') for o in memory):
            violations.append('implicit_string_has_index')
        if any(not re.fullmatch(r'(?:byte|word|dword|qword) ptr \[(?:rsi|rdi|esi|edi)\]', o['text']) for o in memory):
            violations.append('implicit_string_address_spelling')
        checks.append('implicit_string_addresses')
    if name in ('PREFETCHIT0', 'PREFETCHIT1'):
        if any(o.get('base') != 'rip' or o.get('index') for o in structured if o['kind'] == 'mem'):
            violations.append('instruction_prefetch_requires_rip')
        checks.append('instruction_prefetch_requires_rip')
    if name == 'XLAT':
        memory = [o for o in structured if o['kind'] == 'mem']
        if any(not re.fullmatch(r'byte ptr \[(?:rbx|ebx)\]', o['text']) for o in memory):
            violations.append('xlat_implicit_base')
        checks.append('xlat_implicit_base')
    if 'GATHER' in name and any(o.get('index') and re.fullmatch(r'[xyz]mm\d+', o['index']) for o in structured):
        numbers = []
        for op in structured:
            text = op.get('index') or op['text'].split()[0]
            reg = re.fullmatch(r'[xyz]mm(\d+)', text)
            if reg:
                numbers.append(int(reg.group(1)))
        if len(numbers) != len(set(numbers)):
            violations.append('vsib_vector_register_overlap')
        checks.append('vsib_physical_register_numbers')
    return {'status': 'invalid' if violations else 'unverified' if unknown else 'checked',
            'violations': violations, 'unverified': unknown, 'checked_constraints': checks,
            'operands': structured, 'mode_valid': mode_support == 'Valid',
            'meaning_verified': False, 'execution_ready': False}


def require_generation_metadata(rows):
    required = {'opcode', 'description', 'form_hash'}
    if any(not required <= row.keys() for row in rows):
        raise ValueError('Old tokens schema: regenerate with python3 pipeline/m2_tokenize.py (opcode/description/form_hash required)')

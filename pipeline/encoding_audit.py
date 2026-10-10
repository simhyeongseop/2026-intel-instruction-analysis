"""Decode a bounded set of SDM encoding fields, independently of source generation.

Matches are field matches. Only the explicitly listed narrow forms get row_reach
`matched`; no result claims complete ISA or execution validity.
"""
import re

from pipeline.operand_forms import check_opcode_template, legacy_fields


def gpr_number(text):
    names = ('rax eax ax al', 'rcx ecx cx cl', 'rdx edx dx dl', 'rbx ebx bx bl',
             'rsp esp sp spl', 'rbp ebp bp bpl', 'rsi esi si sil', 'rdi edi di dil')
    for index, aliases in enumerate(names):
        if text in aliases.split():
            return index
    match = re.fullmatch(r'r(\d+)(?:[bwd])?', text)
    return int(match.group(1)) if match else None


def modrm_end(data, pos, address32=False):
    """Offset just after ModRM/SIB/displacement (64/32-bit addressing only)."""
    if pos >= len(data):
        return None
    mod, rm = data[pos] >> 6, data[pos] & 7
    pos += 1
    if mod == 3:
        return pos
    base = rm
    if rm == 4:
        if pos >= len(data):
            return None
        base = data[pos] & 7
        pos += 1
    pos += 4 if mod == 2 or (mod == 0 and base == 5) else 1 if mod == 1 else 0
    return pos if pos <= len(data) else None


NOTATION_CODES = {'ib', 'iw', 'id', 'io', 'cb', 'cw', 'cd', 'cp'}


def normalize_template(template):
    """SDM 표기를 대조 가능한 형태로 바꾸고 ModRM 조건을 따로 돌려준다.

    - SYM087: '11:rrr:bbb'(MOD=11), '!(11):rrr:bbb'(MOD!=11), 'mm:101:bbb'·'!(11):001:bbb'(REG 고정),
      '!(11):rrr:100'(RM 고정) -> '/r' 또는 '/n' + 조건
    - 소문자 hex 바이트('0f'), 'imm8'(= ib), '/ib', '/vsib'(ModRM+SIB), ', /r', 붙은 '0F38'/'0F3A'(legacy)
    - SYM003 'NFx'(F2/F3 금지)는 NP와 같이 접두어 표기로만 남긴다(대조하지 않음), '(mod=11)'은 MOD=11 조건
    - 'C8 iw 00'처럼 즉시값 뒤에 붙은 고정 바이트는 ib 길이로만 센다(값은 대조하지 않음)
    """
    conditions = {}
    text = re.sub(r'REX\.w\b', 'REX.W', template.strip())

    def modrm(match):
        mod, reg, rm = match.group(1), match.group(2), match.group(3)
        if mod == '11':
            conditions['mod'] = 'register'
        elif mod == '!(11)':
            conditions['mod'] = 'memory'
        if re.fullmatch(r'[01]{3}', rm):
            conditions['rm'] = int(rm, 2)
        return ' /%d' % int(reg, 2) if re.fullmatch(r'[01]{3}', reg) else ' /r'
    text = re.sub(r'\s*(11|!\(11\)|mm):(rrr|[01]{3}):(bbb|[01]{3})', modrm, text)
    text = re.sub(r'\s*\((?:mod!=11|mod\s*!=\s*11)[^)]*\)', lambda m: conditions.update(mod='memory') or '', text)
    text = re.sub(r'\s*\(mod\s*=\s*11\)', lambda m: conditions.update(mod='register') or '', text)
    # 'MAP7:W0.F6'(RDMSR·URDMSR·UWRMSR·WRMSRNS 표 칸): 맵·W 뒤에 opcode가 점으로 붙은 표기
    text = re.sub(r'\.(MAP\d):(W[01])\.([0-9A-F]{2})\b', r'.\1.\2 \3', text)
    text = re.sub(r'\bNFx\b', 'NP', text)
    text = re.sub(r'\b(ib|iw|id)\s+[0-9A-F]{2}\b', r'\1 ib', text)
    text = re.sub(r',\s*/r', ' /r', text)
    text = re.sub(r'\bimm8\b', 'ib', text)
    text = re.sub(r'(?<=\s)/ib\b', 'ib', text) if not text.startswith(('VEX', 'EVEX')) else text
    if '/vsib' in text:
        text = text.replace(' /vsib', '' if re.search(r'/[0-7]\b', text) else ' /r')
    if not text.startswith(('VEX', 'EVEX')):
        text = re.sub(r'\b0F(38|3A)\b', r'0F \1', text)
    text = ' '.join(t.upper() if re.fullmatch(r'[0-9a-f]{2}', t) and t not in NOTATION_CODES else t
                    for t in text.split())
    return text, conditions


def check_encoding(hex_bytes, row, relocations=False):
    """표 opcode 칸 대조. '+i'(SYM010), '+rb/+rw/+rd/+ro'(SYM009)는 하위 3비트 0..7 중 하나라도 맞으면 그 결과를 쓴다.

    +r 표기에서 r8~r15는 REX.B가 4번째 비트를 맡으므로 opcode 하위 3비트는 같은 0..7 범위다.
    """
    template = row.get('opcode', '')
    plus = re.search(r'([0-9A-Fa-f]{2})\s*\+\s*(?:i|r[bwdo])\b', template)
    if not plus:
        return _check_encoding(hex_bytes, row, relocations)
    base = int(plus.group(1), 16)
    results = [_check_encoding(hex_bytes, dict(row, opcode=template.replace(plus.group(0), '%02X' % (base + i))),
                               relocations) for i in range(8)]
    matched = [r for r in results if r['status'] == 'fields_match']
    return matched[0] if matched else results[0]


def _check_encoding(hex_bytes, row, relocations=False):
    result = {'status': 'not_checked', 'row_reach': 'unverified', 'checked_fields': [],
              'unverified_fields': ['operand_semantics', 'CPUID', 'execution'],
              'meaning_verified': False, 'coverage_eligible': False}
    if not hex_bytes:
        result['reason'] = 'no_bytes'
        return result
    if relocations:
        result['reason'] = 'unresolved_relocation'
        return result
    data, pos, rex, prefixes = legacy_fields(hex_bytes)
    # SDM notations (REX.w, 11:rrr:bbb, !(11), imm8, /vsib ...) -> comparable template + ModRM conditions.
    template, modrm_conditions = normalize_template(row.get('opcode', ''))
    tokens = re.sub(r'(?<=[0-9A-F])/', ' /', re.sub(r'(REX\.[WR])\s*\+\s*', r'\1 ', template)).split()
    vector = template.startswith(('VEX.', 'EVEX.'))
    opcode_pos, good = pos, True
    if vector:
        # Whitespace sometimes occurs inside the SDM prefix notation.
        # Tail per SDM 3.1.1.2: [/r] [/ib,/is4]; /is4 is an imm8 carrying a register (SYM017).
        match = re.fullmatch(r'((?:VEX|EVEX)\.[A-Za-z0-9.]+)\s+([0-9A-F]{2})\s*(/r|/[0-7])?(?:\s*/?(ib|is4))?',
                             re.sub(r'\.\s+', '.', re.sub(r'(?<=[0-9A-F])/', ' /', template)))
        if not match:
            result['reason'] = 'unsupported_vector_template'
            return result
        fields = match.group(1).split('.')
        family, pp, map_id, width, length = fields[0], 0, 1, None, None
        for field in fields[1:]:
            if field in ('66', 'F3', 'F2'):
                pp = {'66': 1, 'F3': 2, 'F2': 3}[field]
            elif field in ('0F', '0F38', '0F3A', 'MAP5', 'MAP6', 'MAP7'):
                # EVEX.mmm maps 1, 2, 3, 5, 6 (SDM 2.7, file page 68).
                # VEX MAP7: 093판 총론에는 정의가 없고(48쪽 Table 2-10은 00111B Reserved) 명령 표 칸에만 있다.
                # 사용자 결정(2026-10-10): 표 표기를 따르고 map 필드 값 7로 대조한다(source_conflict_cases MAP7-*).
                map_id = {'0F': 1, '0F38': 2, '0F3A': 3, 'MAP5': 5, 'MAP6': 6, 'MAP7': 7}[field]
            elif field == 'NP':
                pp = 0  # SYM002: no 66/F2/F3 beyond the opcode
            elif field in ('NDS', 'NDD', 'DDS'):
                pass  # SYM021: former vvvv-usage notation, not an encoding field
            elif field in ('W0', 'W1'):
                width = int(field[-1])
            elif field in ('128', '256', '512', 'LZ', 'L0', 'L1'):
                length = {'128': 0, '256': 1, '512': 2, 'LZ': 0, 'L0': 0, 'L1': 1}[field]
            elif field not in ('WIG', 'LIG', 'LLIG'):
                result['reason'] = 'unsupported_vector_prefix_field:' + field
                return result
        if pos < len(data) and data[pos] == 0xc5 and len(data) >= pos + 3:
            actual_family, actual_map, actual_pp = 'VEX', 1, data[pos+1] & 3
            actual_w, actual_l, opcode_pos = 0, (data[pos+1] >> 2) & 1, pos + 2
        elif pos < len(data) and data[pos] == 0xc4 and len(data) >= pos + 4:
            actual_family, actual_map, actual_pp = 'VEX', data[pos+1] & 31, data[pos+2] & 3
            actual_w, actual_l, opcode_pos = data[pos+2] >> 7, (data[pos+2] >> 2) & 1, pos + 3
        elif pos < len(data) and data[pos] == 0x62 and len(data) >= pos + 5:
            actual_family, actual_map, actual_pp = 'EVEX', data[pos+1] & 7, data[pos+2] & 3
            actual_w, actual_l, opcode_pos = data[pos+2] >> 7, (data[pos+3] >> 5) & 3, pos + 4
            # EVEX.b on a register operand reuses LL for rounding control.
            if data[pos+3] & 0x10 and len(data) > opcode_pos + 1 and data[opcode_pos+1] >> 6 == 3:
                length = None
                result['unverified_fields'].append('EVEX_rounding_LL')
        else:
            result.update(status='different_encoding', row_reach='different', reason='encoding_family')
            return result
        good = (family, map_id, pp) == (actual_family, actual_map, actual_pp)
        result['checked_fields'].extend(['encoding_family', 'opcode_map', 'mandatory_prefix'])
        if width is not None:
            good = good and width == actual_w
            result['checked_fields'].append('W')
        if length is not None:
            good = good and length == actual_l
            result['checked_fields'].append('vector_length')
        good = good and data[opcode_pos] == int(match.group(2), 16)
        result['checked_fields'].append('opcode_bytes')
        tokens = [match.group(2), match.group(3) or '', 'ib' if match.group(4) else '']
        end = opcode_pos + 1
        result['unverified_fields'].extend(['vector_register_fields', 'mask', 'broadcast'])
    else:
        legacy = check_opcode_template(hex_bytes, {'row_id': row.get('row_id', ''), 'opcode': template})
        if legacy['status'] == 'not_checked':
            result['reason'] = legacy.get('reason', '')
            return result
        good = legacy['status'] == 'fields_match'
        result['checked_fields'] = legacy['checked_fields']
        opcodes = [int(t, 16) for t in tokens if re.fullmatch(r'[0-9A-F]{2}', t)]
        while opcodes and opcodes[0] in (0x66, 0xf2, 0xf3):
            opcodes.pop(0)
        end = pos + len(opcodes)
    if '/r' in tokens or any(re.fullmatch(r'/[0-7]', t) for t in tokens):
        extension = next((t for t in tokens if re.fullmatch(r'/[0-7]', t)), None)
        if extension:
            good = good and end < len(data) and (data[end] >> 3) & 7 == int(extension[1])
            result['checked_fields'].append('ModRM.reg_extension')
        if 'mod' in modrm_conditions and end is not None and end < len(data):
            good = good and ((data[end] >> 6) == 3) == (modrm_conditions['mod'] == 'register')
            result['checked_fields'].append('ModRM.mod_' + modrm_conditions['mod'])
        if 'rm' in modrm_conditions and end is not None and end < len(data):
            good = good and (data[end] & 7) == modrm_conditions['rm']
            result['checked_fields'].append('ModRM.rm_fixed')
        result['unverified_fields'].append('ModRM_register_operands')
        end = modrm_end(data, end, 0x67 in prefixes)
        result['checked_fields'].append('ModRM_SIB_displacement_layout')
    tail_width = {'ib': 1, 'iw': 2, 'id': 4, 'io': 8, 'cb': 1, 'cw': 2, 'cd': 4}
    tail = sum(tail_width[t] for t in tokens if t in tail_width)
    relative = re.search(r'\brel(8|16|32)\b', row.get('operand_types', row.get('operands', '')))
    is_xbegin = row.get('mnemonic', '').upper() == 'XBEGIN'
    if is_xbegin and relative:
        # The SDM table says C7 F8 without cw/cd; the operand and 66 prefix
        # distinguish the two valid XBEGIN forms in long mode.
        bits = int(relative.group(1))
        tail = bits // 8
        good = good and ((0x66 in prefixes) == (bits == 16))
        result['checked_fields'].append('xbegin_operand_size')
    moffs = re.search(r'\bmoffs(8|16|32|64)\b', row.get('operand_types', row.get('operands', '')))
    if end is None:
        good = False
    else:
        # moffs templates have no explicit offset-width suffix.
        if moffs:
            tail += 4 if 0x67 in prefixes else 8
            result['checked_fields'].append('moffs_address_width')
            bits = int(moffs.group(1))
            good = good and (bits == 8 or (bits == 16 and 0x66 in prefixes and not (rex and rex & 8))
                            or (bits == 32 and 0x66 not in prefixes and not (rex and rex & 8))
                            or (bits == 64 and rex is not None and bool(rex & 8)))
            result['checked_fields'].append('moffs_data_width')
            offset = re.search(r'0x[0-9a-f]+', row.get('operands', '').lower())
            if offset:
                good = good and int.from_bytes(data[end:], 'little') == int(offset.group(), 16)
                result['checked_fields'].append('moffs_offset_value')
            else:
                result['unverified_fields'].append('moffs_offset_value')
        good = good and len(data) == end + tail
        result['checked_fields'].append('immediate_relative_tail_width' if tail else 'instruction_length')
    narrow = bool(relative or (not vector and moffs and 'moffs_offset_value' in result['checked_fields']))
    if not vector and 'CR8' in row.get('operand_types', row.get('operands', '')):
        mod = data[pos+2] if len(data) > pos+2 else 0
        control = ((mod >> 3) & 7) + (8 if rex and rex & 4 else 0)
        good = good and control == 8 and mod >> 6 == 3
        result['checked_fields'].append('fixed_CR8')
        registers = [gpr_number(op.strip()) for op in row.get('operands', '').split(',')]
        expected_reg = next((n for n in registers if n is not None), None)
        if expected_reg is not None:
            actual_reg = (mod & 7) + (8 if rex and rex & 1 else 0)
            good = good and expected_reg == actual_reg
            result['checked_fields'].append('control_move_GPR')
            narrow = True
    if relative and end is not None and tail:
        bits = int(relative.group(1))
        good = good and tail == bits // 8 and (bits != 16 or is_xbegin)
        displacement = int.from_bytes(data[end:], 'little', signed=True)
        good = good and (displacement + len(data) == (0 if bits == 8 else 4096))
        result['checked_fields'].append('relative_displacement_target')
    name = row.get('mnemonic', '').split()[-1].upper() if row.get('mnemonic') else ''
    if not vector and name in ('MOVS', 'CMPS', 'LODS', 'STOS', 'SCAS', 'INS', 'OUTS'):
        widths = re.findall(r'\bm(8|16|32|64)\b', row.get('operand_types', ''))
        if not widths:
            accumulator = next((x.strip() for x in row.get('operand_types', '').split(',') if x.strip() in ('AL', 'AX', 'EAX', 'RAX')), None)
            widths = [str({'AL': 8, 'AX': 16, 'EAX': 32, 'RAX': 64}[accumulator])] if accumulator else []
        if widths:
            bits = int(widths[0])
            good = good and all(int(x) == bits for x in widths)
            good = good and (bits == 8 or (bits == 16 and 0x66 in prefixes and not (rex and rex & 8))
                or (bits == 32 and 0x66 not in prefixes and not (rex and rex & 8))
                or (bits == 64 and rex is not None and bool(rex & 8)))
            result['checked_fields'].append('implicit_string_data_width')
            narrow = True
    result['status'] = 'fields_match' if good else 'different_encoding'
    result['row_reach'] = 'matched' if good and narrow else 'partial' if good else 'different'
    result['coverage_eligible'] = (good and narrow and row.get('input_status') == 'checked'
                                   and row.get('mode_support') == 'Valid'
                                   and row.get('test_kind') not in ('edge', 'negative')
                                   and 'edge:' not in row.get('note', ''))
    return result

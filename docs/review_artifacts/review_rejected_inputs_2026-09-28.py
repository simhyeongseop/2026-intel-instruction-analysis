"""Frozen-input SDM review. This does not alter the instruction generator or run instructions.

Run with pypdf available (the review installed it under /tmp/rejected_review_pdfdeps):
  PYTHONPATH=/tmp/rejected_review_pdfdeps python3 docs/review_artifacts/review_rejected_inputs_2026-09-28.py evidence
  python3 docs/review_artifacts/review_rejected_inputs_2026-09-28.py review

The explicit row rules below are review decisions, not a general ISA validator.
"""
import collections
import csv
import hashlib
import json
import re
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SNAPSHOT = ROOT / 'out/generator_audit_2026-09-28'
OUT = ROOT / 'out/rejected_input_review_2026-09-28'


def read_csv(path):
    with path.open(newline='', encoding='utf-8') as stream:
        return list(csv.DictReader(stream))


def inputs():
    observations = read_csv(SNAPSHOT / 'encoding_audit.csv')
    rejected = {r['combo_id'] for r in observations if r['observation_status'] == 'diagnostic_rejection'}
    by_id = collections.defaultdict(dict)
    for row in observations:
        if row['combo_id'] in rejected:
            by_id[row['combo_id']][row['tool']] = row
    assert len(by_id) == 178
    assert all(set(o) == {'as', 'clang'} for o in by_id.values())
    return by_id, read_csv(ROOT / 'data/db/isa_db.csv')


def hash_file(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def assemble(source, mode, tool):
    """Assembler syntax probe only. No linking or CPU execution."""
    with tempfile.TemporaryDirectory(prefix='rejected-review-') as directory:
        assembly = Path(directory) / 'input.s'
        obj = Path(directory) / 'input.o'
        assembly.write_text('.intel_syntax noprefix\n.text\n.Ltarget:\n' + source + '\n', encoding='utf-8')
        if tool == 'as':
            command = ['as', '--' + str(mode), '-mintel64', '-o', str(obj), str(assembly)]
        else:
            command = ['clang', '-m' + str(mode), '-c', '-x', 'assembler', str(assembly), '-o', str(obj)]
        process = subprocess.run(command, capture_output=True, text=True)
        dump = ''
        if process.returncode == 0:
            dump = subprocess.run(['objdump', '-d', '-M', 'intel', str(obj)], capture_output=True, text=True).stdout
        return {'source': source, 'mode': mode, 'tool': tool, 'command': command,
                'returncode': process.returncode, 'stderr': process.stderr, 'disassembly': dump}


def evidence():
    from pypdf import PdfReader
    observations, db = inputs()
    OUT.mkdir(parents=True, exist_ok=True)
    pages = {int(db[int(o['as']['row_id'])]['source_page']) for o in observations.values()}
    # Continuations containing operation, memory-width, or exception details.
    pages.update({37, 38, 39, 40, 41, 42, 209, 211, 213, 214, 216, 218, 219, 221, 222, 224,
                  240, 241, 242, 269, 270, 623, 624, 652, 692,
                  732, 733, 734, 825, 1302, 1409, 1410, 1412, 1437,
                  2055, 2056, 2203, 2204, 2205, 2367, 2369, 2391, 2393})
    reader = PdfReader(ROOT / 'intel_manual.pdf')
    extracted = {str(p): reader.pages[p - 1].extract_text() for p in sorted(pages)}
    (OUT / 'sdm_pages.json').write_text(json.dumps(extracted, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    probes = []
    # Compare pointer directives in a mode where BOUND is defined.
    for source in ('bound cx, word ptr [eax]', 'bound cx, dword ptr [eax]',
                   'bound ecx, dword ptr [eax]', 'bound ecx, qword ptr [eax]'):
        for tool in ('as', 'clang'):
            probes.append(assemble(source, 32, tool))
    # These probes explain textual width selection. Their acceptance is NOT SDM evidence.
    for source in ('call far ptr [eax]', 'call dword ptr [eax]', 'call fword ptr [eax]',
                   'call tbyte ptr [eax]', 'jmp far ptr [eax]', 'jmp dword ptr [eax]',
                   'jmp fword ptr [eax]', 'jmp tbyte ptr [eax]',
                   'clrssbsy qword ptr [eax]', 'clrssbsy [eax]',
                   'rstorssp qword ptr [eax]', 'rstorssp [eax]',
                   'bndldx bnd0, [rax]', 'bndstx [rax], bnd0'):
        for tool in ('as', 'clang'):
            probes.append(assemble(source, 64, tool))
    (OUT / 'syntax_probes.json').write_text(json.dumps(probes, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    manifest = {'review_date': '2026-09-28', 'completed_local_date': '2026-09-29',
                'scope': '178 unique combos with diagnostic_rejection in either saved assembler observation',
                'cpu_execution': False, 'pdf_pages': sorted(pages),
                'sha256': {str(p.relative_to(ROOT)): hash_file(p) for p in
                           (SNAPSHOT / 'encoding_audit.csv', SNAPSHOT / 'combos.csv', ROOT / 'data/db/isa_db.csv', ROOT / 'intel_manual.pdf')},
                'versions': {t: subprocess.run([t, '--version'], capture_output=True, text=True).stdout.splitlines()[0]
                             for t in ('as', 'clang', 'objdump')},
                'syntax_docs': ['https://sourceware.org/binutils/docs/as/i386_002dVariations.html']}
    (OUT / 'manifest.json').write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print('extracted', len(pages), 'SDM pages; saved', len(probes), 'syntax probes')
    for p in probes[:8]:
        print(p['tool'], p['source'], p['returncode'], p['stderr'].strip(), p['disassembly'].splitlines()[-1:] if p['disassembly'] else '')


def split_operands(source):
    return [s.strip() for s in source.partition(' ')[2].split(',')] if ' ' in source else []


def address_review(source, mode):
    addresses = re.findall(r'\[([^]]+)\]', source)
    if not addresses:
        return 'not_applicable', '명시 메모리 주소 없음.'
    address = addresses[0]
    if mode != 'Valid' and re.search(r'\b(?:rax|rbx|rip)\b', address):
        return 'incompatible_with_supported_mode', f'[{address}]는 64비트 주소형이다. 대상 행은 64비트 모드에서 {mode}이므로 이 주소를 그대로 쓰는 지원 모드가 없다.'
    if mode != 'Valid' and address == 'rax':
        return 'incompatible_with_supported_mode', 'RAX 기반 주소는 64비트 전용이며 이 행의 지원 모드와 양립하지 않는다.'
    if re.search(r'\b(?:xmm|ymm|zmm)\d+\b', address):
        return 'valid_32bit_vsib_address', f'[{address}]는 EAX 기반 32비트 주소, 벡터 인덱스, scale=1, disp=0이다. 16비트 주소형이 아니며 별도 index 폭 판정을 따른다.'
    if address == 'eax':
        return 'valid_address_shape', 'EAX 기반 32비트 주소형. 64비트 실행 문맥에서는 address-size override로 표현하며 데이터 폭과 주소 폭은 별개다.'
    if address in ('rax', 'rax+rbx*4+0x10', 'rip+0x10'):
        return 'valid_address_shape', f'[{address}]는 64비트 base/SIB 또는 RIP-relative 주소형이다; scale=4와 disp=0x10은 허용 범위다.'
    raise AssertionError(('unreviewed address', source))


def decision(row, source, dbrow):
    """Return literal table verdict, description verdict, family, and evidence-based reason."""
    operands = split_operands(source)
    no_operand = {0, 1, 3, 5, 533, 534, 578, 579, 811, 812, 1992, 1993,
                  1998, 2322, 2323, 2325, 2737}
    if row in no_operand:
        assert not operands
        return 'conforms', 'conforms', 'zero_operand', '명시 오퍼랜드 0개가 SDM ZO/Z0 행과 일치한다. AL/AX, 스택, MSR 등 Description의 상태는 암시적이며 추가 source operand를 요구하지 않는다.'
    if row in (2, 4):
        assert operands[0] in ('1', '0x7f')
        return 'conforms', 'conforms', 'aad_aam_imm8', f'{operands[0]}은 imm8 범위의 양수 base이다. Description의 number base 입력에 맞고 0이 아니다.'
    if row == 153:
        assert operands[1] in ('cx', 'dx') and (operands[0] == 'cx' or operands[0].startswith('word ptr ['))
        return 'conforms', 'conforms', 'arpl', f'목적지 {operands[0]}는 r/m16, 소스 {operands[1]}는 r16이다. 두 selector의 RPL을 비교하는 형태에 맞는다.'
    if row in range(174, 180):
        width = 32 if row % 2 == 0 else 64
        assert operands[0] == 'bnd0' and (operands[1] == ('ecx' if width == 32 else 'rcx') or operands[1].startswith(('dword' if width == 32 else 'qword') + ' ptr ['))
        return 'conforms', 'conforms', 'mpx_check', f'bnd0은 BND0–3 범위이고 {operands[1]}는 r/m{width} 표기와 맞는다. 메모리형은 LEA 주소를 비교하며 메모리 데이터 읽기 폭을 뜻하지 않는다.'
    if row in (180, 187):
        assert source in ('bndldx bnd0, [rax]', 'bndstx [rax], bnd0')
        return 'conforms', 'conforms', 'mpx_mib', 'bnd0과 base=RAX,index 생략,disp=0인 mib이다. SDM Description은 base 또는 index를 생략한 인코딩에서 해당 값을 zero 상수로 처리한다고 명시한다. index가 없는 [rax]를 자동 오류로 판정하지 않는다.'
    if row in (181, 182):
        assert operands == ['bnd0', ('dword' if row == 181 else 'qword') + ' ptr [rax]']
        return 'conforms', 'conforms', 'mpx_make', 'bnd0과 memory-only m32/m64 형태가 일치한다. base=RAX, disp=0, index 없음이며 RIP-relative 금지 조건에 해당하지 않는다. 이 명령의 m32/m64도 메모리를 읽지 않고 LEA처럼 주소를 계산한다.'
    if row in range(183, 187):
        width = 64 if row in (183, 185) else 128
        assert all(re.fullmatch(r'bnd[01]', o) or o == ('qword' if width == 64 else 'xmmword') + ' ptr [rax]' for o in operands)
        return 'conforms', 'conforms', 'mpx_move', f'두 bound register는 BND0/BND1이고 memory 대안은 m{width}이다. SDM Figure 3-5는 32비트 모드의 경계값 pair를 8바이트,64비트 모드를16바이트로 구분한다. register-register는 두 경계값을 옮기는 허용 형태이며 같은 register 사용 금지 조건이 없다.'
    if row in (188, 189):
        assert operands[0] == ('cx' if row == 188 else 'ecx') and operands[1].startswith(('word' if row == 188 else 'dword') + ' ptr [')
        return 'tool_syntax_dependent', 'tool_syntax_dependent', 'bound_pair_width', f'SDM bounds operand는 두 개의 {"word" if row == 188 else "doubleword"} 경계값, 총 {32 if row == 188 else 64}비트이다. GNU는 전체 pair 폭인 {"dword" if row == 188 else "qword"} ptr를 요구하므로 이 입력의 {operands[1].split(" ptr")[0]} ptr는 GNU 문법에서 부적합하다. Clang은 각 경계값 폭을 directive에 쓰므로 원본 표기가 이 지원 모드에서는 올바른 pair 의미를 나타낸다. 32비트 syntax probe에서 양쪽 관례를 분리했다. 어셈블러 공통 입력으로는 부적합하지만 ISA 의미의 총폭 부족을 양 도구에 공통으로 확정하지 않는다.'
    if row in (226, 227, 918, 919):
        width = 16 if row in (226, 918) else 32
        assert operands[0] == ('cx' if width == 16 else 'ecx') or operands[0].startswith('word ptr [')
        return 'conforms', 'conforms', 'near_indirect_branch', f'{operands[0]}는 r/m{width} target이다. 해당 near branch 행의 offset 폭과 일치한다. 64비트 near branch가 64비트로 강제되는 모드 제약은 별도 판정이다.'
    if row in (229, 230, 921, 922):
        width = 16 if row in (229, 921) else 32
        assert operands == [('0x10:0x1234' if width == 16 else '0x10:0x12345678')]
        return 'conforms', 'conforms', 'far_immediate_branch', f'명시 selector=0x10은16비트, offset은 {width}비트 범위이고 ptr16:{width} far target 구조와 일치한다. 값이 descriptor를 실제 가리키는지는 런타임 조건이다.'
    if row in (231, 232, 233, 923, 924, 925):
        width = {231: 16, 232: 32, 233: 64, 923: 16, 924: 32, 925: 64}[row]
        assert operands == ['far ptr [eax]']
        if width == 32:
            return 'underspecified', 'conforms_with_default_size', 'far_memory_branch', 'far ptr [eax]는 selector+offset을 담은 memory far target의 구조에는 맞지만 offset 폭을 쓰지 않았다. 현재64비트 GNU Intel 문맥의 기본32비트 offset 선택은 이 m16:32 Description과 맞는다. 이 판정은 implicit default에 의존하며 독립적인16/32/64 행 선택을 보장하지 않는다.'
        return 'underspecified', 'nonconforming_target_size', 'far_memory_branch', f'far ptr [eax]는 offset 폭을 생략해 m16:{width}를 지정하지 않는다. 현재 64비트 GNU 문맥의 기본 32비트 offset은 이 행의 {width}비트 offset 요구와 다르다. GNU에서는 {"dword ptr 또는 명시 16비트 operand-size" if width == 16 else "tbyte ptr와 REX.W"} 같은 size 선택이 필요하다. probe에서 Clang은 dword/tbyte directive에도 기본 32비트 offset을 선택하므로 양 도구 공통 대체 입력으로 확정하지 않았다. 저장된 바이트는 source 해석의 보조 관측이며 ISA 기준은 SDM이다.'
    if row in (244, 2466):
        assert operands[0].startswith('qword ptr [')
        return 'conforms', 'conforms', 'cet_shadow_stack_memory', 'qword ptr는 m64 memory-only token에 맞고 register 대안은 사용하지 않았다. SDM Operation은8바이트 정렬과8바이트 token 접근을 요구한다. 주소값/권한/CR4.CET/token 내용은 런타임 전제이며 source만으로 충족 여부를 판정하지 않는다. Clang의 typed-memory 거부는 이 m64 규정 위반 증거가 아니다.'
    if row == 815:
        assert operands[0] == 'ecx' and operands[1].startswith('xmmword ptr [')
        return 'conforms', 'conforms', 'invpcid', 'ECX=r32, xmmword ptr=m128 descriptor로 type register+descriptor 구조와 일치한다. 실제 ECX 값은 INVPCID type0–3이어야 하지만 입력 문자열은 register 값을 정하지 않는다.'
    if row == 825:
        assert operands == ['.Ltarget']
        return 'conforms', 'conforms', 'jcxz', '.Ltarget는 rel8 branch target을 나타내는 symbol이며 저장된 테스트에서 명령 바로 앞의 label이므로 displacement 범위 안이다. JCXZ는 CX를 암시적으로 검사하며 명시 CX operand가 필요하지 않다. 16비트 address-size가64비트 모드에서 불가능한 점은 모드 제약이다.'
    if row in (992, 1041):
        assert source == ('lar ecx, rcx' if row == 992 else 'lsl rcx, ecx')
        return 'conforms', 'conforms', 'lar_lsl_asymmetric_registers', 'SDM 표의 비대칭 r32/r64 register pair와 literal 일치한다. Description/각주가 source 하위16비트만 selector로 사용하고32/64비트 destination 결과 동작이 동일하다고 명시한다. 독립적인 두 폭을 바꾸는 일반 MOV와 같은 규칙으로 거부 판정하지 않는다. REX.W 행 선택은 별도 문제다.'
    if row in (998, 999, 1003, 1004):
        width = 16 if row in (998, 1003) else 32
        assert operands[0] == ('cx' if width == 16 else 'ecx') and operands[1].startswith(('dword' if width == 16 else 'fword') + ' ptr [')
        return 'conforms', 'conforms', 'lds_les_far_pointer', f'destination은 r{width}, memory는16비트 selector+{width}비트 offset, 총{width + 16}비트이다. {"dword" if width == 16 else "fword"} ptr가 전체 pointer 폭을 올바르게 지정한다.'
    if row == 1023:
        assert operands[0] == 'cx' or operands[0].startswith('word ptr [')
        return 'conforms', 'conforms', 'lkgs', 'CX 또는 word ptr memory는 r/m16 selector이고 LKGS의 단일 explicit operand 형태에 맞는다. GS load의 권한과 descriptor 유효성은 런타임 조건이다.'
    if row == 1099:
        assert operands[0] == 'ds' and operands[1].startswith('qword ptr [')
        return 'conforms', 'unresolved_memory_width_notation', 'mov_segment_memory', '표/행 Description은 Sreg,r/m64의 하위 16비트를 DS로 옮긴다고 써 qword ptr 대안과 literal 일치한다. 본문은 valid 16비트 selector를 요구하나 memory fetch 폭을 명확히 분리하지 않는다. 이 source가 8바이트 접근을 뜻해야 하는지, 하위 16비트 selector container 표기인지 원문만으로 결정하지 못했다. 과거 CPU의 2바이트 접근 관측으로 SDM 명세 쟁점을 확정하지 않는다.'
    if row in (1118, 1121, 1124, 1126):
        special = 'cr0' if row in (1118, 1121) else 'dr0'
        assert set(operands) == {'ecx', special}
        return 'conforms', 'conforms', 'control_debug_register_move', f'ECX=r32와 {special.upper()}는 해당 CR0–7/DR0–7 범위 내 register이다. operand 순서가 읽기/쓰기 행과 맞고 CR1/DR4 같은 예약 register를 쓰지 않는다. privilege조건은 런타임 전제다.'
    if row in (1351, 1352):
        width = 16 if row == 1351 else 32
        assert operands[0] == ('cx' if width == 16 else 'ecx')
        assert operands[1] in (('cx', 'dx') if width == 16 else ('ecx', 'edx')) or operands[1].startswith(('word' if width == 16 else 'dword') + ' ptr [')
        return 'conforms', 'conforms', 'movsxd_same_width', f'r{width},r/m{width}의 같은 폭 복사는 SDM에 명시된 유효 행이다. REX.W 없는 MOVSXD는 discouraged라는 각주이며 금지 규정은 아니다. {operands[0]}/{operands[1]}는 요구된 type과 폭에 일치한다.'
    if row in (1978, 1981, 2308, 2311):
        assert operands[0] == 'ecx' or operands[0].startswith('dword ptr [')
        return 'conforms', 'conforms', 'stack_r32', 'ECX 또는 dword ptr memory는32비트 stack operand 형태에 일치한다. PUSH/POP의32비트 operand가64비트 mode에서N.E.라는 제약은 별도 열에 기록한다.'
    segment_rows = {1983: 'ds', 1984: 'es', 1985: 'ss', 2316: 'cs', 2317: 'ss', 2318: 'ds', 2319: 'es'}
    if row in segment_rows:
        assert operands == [segment_rows[row]]
        return 'conforms', 'conforms', 'stack_segment', f'explicit {operands[0].upper()} segment register는 SDM 행과 일치한다. FS/GS 또는 다른 segment register로 바뀐 입력이 아니다.'
    if row == 2396:
        assert operands == ['ecx']
        return 'conforms', 'conforms', 'rdpid_r32', 'ECX는r32 destination에 일치한다. IA32_TSC_AUX를 읽는 대상이며 r64 행이 아니다.'
    if row in (2696, 2697, 2698, 2699):
        assert not operands
        if row in (2697, 2699):
            return 'conforms', 'nonconforming_target_size', 'system_return_size', '명시 operand0개는표와 일치하나 bare mnemonic에64비트 operand-size/REX.W 선택이 없다. Description의64비트 user-mode return을 선택하지 못한다. 두 SDM행을 구분하려면 sysexitq/sysretq 같은64비트 size 선택이 필요하다; 저장된 Clang 관측도 bare형을non-REX.W로 해석했다.'
        return 'conforms', 'conforms_with_default_size', 'system_return_size', '명시 operand0개가표와 일치한다. 현재Clang bare mnemonic의기본non-REX.W형은 compatibility/32비트 return인 Description과 맞는다. GNU의 ambiguous size 거부는explicit operand 누락이 아니며, tool별 textual size 선택 규칙의 차이다.'
    if row == 2734:
        assert operands[0] == 'ecx' and (operands[1] in ('ecx', 'edx') or operands[1].startswith('dword ptr ['))
        return 'conforms', 'conforms', 'ud0', 'ECX=r32와r/m32 소스가표와 맞고 same/different register 모두 허용한다. Operation이#UD인 의도적인 exception instruction이라 성공적인 실행을 적합성조건으로 두지 않는다.'
    if row == 3789:
        assert operands[0].startswith('xmmword ptr [') and operands[1] in ('xmm0', 'xmm1')
        assert '{z}' not in source
        return 'conforms', 'nonconforming', 'vpmovqd_half_memory', 'literal m128 표에는 맞지만 Description의2개quadword→2개doubleword 결과는64비트이다. Operand Encoding Half Mem과본문의256/128/64-bit memory, memory Operation(KL=2)이모두m64를지지한다. m128 directive는EVEX.128+xmm source 행의memory destination 폭에맞지않는다. source XMM0/1은허용하고mask없음또는K1 merge만사용하므로mask는원인이아니다.'
    if row in (4045, 4046):
        index, source_reg, needed = ('ymm1', 'ymm0', 'xmm1') if row == 4045 else ('zmm1', 'zmm0', 'ymm1')
        assert operands == [f'[eax + {index}] {{k1}}', source_reg]
        return 'conforms', 'nonconforming', 'vscatterdpd_index_width', f'literal vm32y/vm32z표에는맞지만Operation의VL={256 if row == 4045 else 512},KL={4 if row == 4045 else 8}는32비트index를{4 if row == 4045 else 8}개사용한다. 필요한index vector폭은{128 if row == 4045 else 256}비트({needed})인데{index}를썼다. EAX 주소와scale1,K1(비K0),source {source_reg} 자체는적합하다. 표/본문의폭모순을확인했으나공식정오표까지입증한것은아니다.'
    if row in set(range(4184, 4192)) | set(range(4202, 4210)):
        m = re.fullmatch(r'\[eax \+ (ymm1|zmm1)\] \{k1\}', operands[0])
        assert m
        suffix = dbrow['mnemonic'][-3:]
        expected_index = 'ymm1' if suffix == 'DPD' else 'zmm1'
        assert m[1] == expected_index
        indices = 16 if suffix == 'DPS' else 8
        index_bits = 32 if suffix in ('DPS', 'DPD') else 64
        return 'conforms', 'conforms', 'avx512_sparse_prefetch', f'{suffix}는signed{index_bits}비트index {indices}개를사용하므로{expected_index}가맞다. EAX 32비트VSIB base,scale1,disp0,K1이vm형과operation에맞고16비트주소형/일반SIB가아니다. T0/T1및read/write hint는mnemonic에들어있으며추가data register는요구하지않는다. 이ISA근거는Clang거부와독립적이다.'
    raise AssertionError(('missing explicit row rule', row, source))


def review():
    observations, db = inputs()
    extracted = json.loads((OUT / 'sdm_pages.json').read_text(encoding='utf-8'))
    rows = []
    for combo_id, pair in sorted(observations.items(), key=lambda item: int(item[0])):
        observation = pair['as']
        row = int(observation['row_id'])
        d = db[row]
        source = observation['source']
        assert pair['clang']['source'] == source
        assert str(d['source_page']) in extracted
        literal, verdict, family, reason = decision(row, source, d)
        addr_status, addr_reason = address_review(source, d['mode_support'])
        refs = f'intel_manual.pdf PDF p.{d["source_page"]};sdm_pages.json key={d["source_page"]}'
        continuations = {'mpx_mib': [212, 220], 'mpx_move': [217, 218], 'far_memory_branch': [239, 240, 242, 622, 623, 624],
                         'bound_pair_width': [223], 'mov_segment_memory': [731, 732, 733, 734],
                         'vpmovqd_half_memory': [2054, 2055], 'vscatterdpd_index_width': [2202, 2203, 2204],
                         'avx512_sparse_prefetch': [int(d['source_page']) + 1]}
        if family in continuations:
            refs += ';' + ','.join('SDM PDF p.' + str(p) for p in continuations[family])
        if family in ('bound_pair_width', 'far_memory_branch', 'cet_shadow_stack_memory', 'mpx_mib'):
            refs += ';syntax_probes.json (syntax only)'
        if family in ('bound_pair_width', 'far_memory_branch'):
            refs += ';https://sourceware.org/binutils/docs/as/i386_002dVariations.html'
        if addr_status != 'not_applicable':
            refs += ';SDM PDF p.37-42 (addressing/REX/RIP-relative)'
        input_problem = verdict.startswith('nonconforming') or addr_status == 'incompatible_with_supported_mode'
        if input_problem:
            overall = 'input_issue_description_or_address'
        elif verdict.startswith('unresolved'):
            overall = 'unresolved_description'
        elif verdict == 'tool_syntax_dependent':
            overall = 'tool_syntax_dependent'
        else:
            overall = 'conforms_static_operands'
        rows.append({'combo_id': combo_id, 'row_id': row, 'source': source,
                     'sdm_instruction': d['instruction'], 'sdm_operands': d['operands'], 'opcode': d['opcode'],
                     'description': d['description'], 'source_page': d['source_page'],
                     'mode_support': d['mode_support'],
                     'mode_validity_64bit': 'supported' if d['mode_support'] == 'Valid' else 'unsupported_' + d['mode_support'],
                     'as_status': pair['as']['observation_status'], 'clang_status': pair['clang']['observation_status'],
                     'as_diagnostics': pair['as']['diagnostics'], 'clang_diagnostics': pair['clang']['diagnostics'],
                     'literal_table_operand_verdict': literal, 'description_operand_verdict': verdict,
                     'overall_operand_verdict': overall,
                     'as_operand_interpretation': 'nonconforming_pair_size_directive' if family == 'bound_pair_width' else verdict,
                     'clang_operand_interpretation': 'conforms_pair_element_size_directive' if family == 'bound_pair_width' else verdict,
                     'review_family': family, 'reason': reason,
                     'address_verdict': addr_status, 'address_reason': addr_reason,
                     'evidence_refs': refs,
                     'runtime_conditions': 'not_evaluated: register/memory values, alignment, CPUID, CPL, CR/MSR state, descriptor/token validity; no CPU execution'})
    with (OUT / 'cases.csv').open('w', newline='', encoding='utf-8') as stream:
        writer = csv.DictWriter(stream, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)
    summary = {'unique_combos': len(rows), 'unique_isa_rows': len({r['row_id'] for r in rows}),
               'literal_table_operand_verdict': dict(collections.Counter(r['literal_table_operand_verdict'] for r in rows)),
               'description_operand_verdict': dict(collections.Counter(r['description_operand_verdict'] for r in rows)),
               'overall_operand_verdict': dict(collections.Counter(r['overall_operand_verdict'] for r in rows)),
               'input_issue_union_combo_ids': [r['combo_id'] for r in rows if r['overall_operand_verdict'] == 'input_issue_description_or_address'],
               'mode_by_overall_verdict': dict(collections.Counter(r['mode_validity_64bit'] + '/' + r['overall_operand_verdict'] for r in rows)),
               'address_verdict': dict(collections.Counter(r['address_verdict'] for r in rows)),
               'mode_support': dict(collections.Counter(r['mode_support'] for r in rows)),
               'families': dict(collections.Counter(r['review_family'] for r in rows)),
               'unresolved_combo_ids': [r['combo_id'] for r in rows if r['description_operand_verdict'].startswith('unresolved')],
               'notes': ['Mode, operand-data shape, target-size selection, and address/support-mode compatibility are independent columns.',
                         'conforms means static operand shape/description only; runtime preconditions are not verified.']}
    (OUT / 'summary.json').write_text(json.dumps(summary, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(json.dumps(summary, ensure_ascii=False, indent=2))


def validate():
    """Check artifact completeness and provenance, independently of decision()."""
    observations, db = inputs()
    rows = read_csv(OUT / 'cases.csv')
    summary = json.loads((OUT / 'summary.json').read_text(encoding='utf-8'))
    pages = json.loads((OUT / 'sdm_pages.json').read_text(encoding='utf-8'))
    manifest = json.loads((OUT / 'manifest.json').read_text(encoding='utf-8'))
    assert len(rows) == len({r['combo_id'] for r in rows}) == 178
    assert {r['combo_id'] for r in rows} == set(observations)
    for r in rows:
        pair = observations[r['combo_id']]
        d = db[int(r['row_id'])]
        assert r['source'] == pair['as']['source'] == pair['clang']['source']
        for tool in ('as', 'clang'):
            assert r[tool + '_status'] == pair[tool]['observation_status']
            assert r[tool + '_diagnostics'] == pair[tool]['diagnostics']
        for field in ('description', 'opcode', 'source_page', 'mode_support'):
            assert r[field] == d[field]
        assert r['sdm_operands'] == d['operands'] and r['sdm_instruction'] == d['instruction']
        assert r['reason'] and r['address_reason'] and r['evidence_refs']
        for first, last in re.findall(r'PDF p\.(\d+)(?:-(\d+))?', r['evidence_refs']):
            for page in range(int(first), int(last or first) + 1):
                assert str(page) in pages
    for path, expected in manifest['sha256'].items():
        assert hash_file(ROOT / path) == expected
    assert summary['overall_operand_verdict'] == dict(collections.Counter(r['overall_operand_verdict'] for r in rows))
    assert sum(summary['overall_operand_verdict'].values()) == 178
    # Fixed expectation from manual review, not derived from the decision dispatch.
    actual_description_issues = {r['combo_id'] for r in rows if r['description_operand_verdict'].startswith('nonconforming')}
    assert actual_description_issues == {'424', '426', '1441', '1443', '4538', '4540',
                                         '6540', '18282', '18283', '18284', '24567', '7035', '7036'}
    assert set(summary['unresolved_combo_ids']) == {'1683', '9292', '9293'}
    result = {'status': 'PASS', 'cases': 178, 'isa_rows': 104,
              'checks': ['exact_target_set_no_duplicates', 'original_source_metadata_observations_match',
                         'all_pdf_evidence_refs_exist', 'original_input_hashes_unchanged',
                         'mutually_exclusive_totals', 'explicit_13_description_issues', 'explicit_3_unresolved'],
              'pdf_pages_saved': len(pages), 'cpu_execution': False}
    (OUT / 'validation.json').write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(json.dumps(result, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    {'evidence': evidence, 'review': review, 'validate': validate}[sys.argv[1]]()

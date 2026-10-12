"""생성기 규칙: SDM 표기 -> 대표값. 값마다 근거(원문 위치) 또는 규칙 이름을 붙인다.

근거 종류
- SDM: 총론 기호 정의(SYM 번호, data/rules/sdm_symbols.csv), Vol.1·Vol.2 쪽(sdm_relaxation 인용 포함)
- 선택 규칙: 원문이 값을 정하지 않는 곳(목록 중 어느 레지스터인지)에만 쓰는 기계적 규칙
- 도구 문법: GNU as/clang Intel 문법 철자(크기 키워드 등). ISA 의미가 아니라 입력 철자다

여기 있는 표만 고치면 생성 값이 바뀐다. 표 밖에서 값을 짐작하지 않는다.
"""

import re

# ---------- 원문 근거 ----------
VOL1_DEFAULTS = ('Vol.1 66', 'In 64-bit mode, the default address size is 64 bits and its default operand size is 32 bits.')
VOL2_PREFETCHI = ('Vol.2 1118', 'PREFETCHIT0/1 can be used in 64-bit mode with RIP-relative addressing')
VOL2_MASK_GATHER = ('SYM072', '{k1} — Without {z}: a mask register used as instruction writemask for instructions that '
                    'do not allow zeroing-masking but support merge-masking. This corresponds to instructions that '
                    'require the value of the aaa field to be different than 0 (e.g., gather)')
VOL2_MEMORY_NO_ZEROING = ('Vol.2 70 2.7.4', 'Instructions which allow merging-masking but do not allow zeroing-masking. '
                          '— Require EVEX.z to be set to 0. — This group is mostly composed of instructions that write to memory.')
VOL2_BCST = ('Vol.2 72 2.7.7', 'embedded broadcast')
GNU_SIZE_KEYWORDS = ('GNU as 2.42 i386 Intel syntax', 'byte/word/dword/fword/qword/tbyte/xmmword/ymmword/zmmword ptr')

# ---------- 레지스터 목록 (SDM 원문 순서) ----------
# 범용 레지스터는 물리 번호를 같이 적는다(al/ax/eax/rax = 0). 같은 행에서 같은 물리 레지스터를 두 번 쓰지 않는다.
REGISTER_LISTS = {
    'r8': ('SYM026', ['al', 'cl', 'dl', 'bl', 'ah', 'ch', 'dh', 'bh', 'bpl', 'spl', 'dil', 'sil']),
    'r16': ('SYM027', ['ax', 'cx', 'dx', 'bx', 'sp', 'bp', 'si', 'di']),
    'r32': ('SYM028', ['eax', 'ecx', 'edx', 'ebx', 'esp', 'ebp', 'esi', 'edi']),
    'r64': ('SYM029', ['rax', 'rbx', 'rcx', 'rdx', 'rdi', 'rsi', 'rbp', 'rsp'] + ['r%d' % n for n in range(8, 16)]),
    'xmm': ('SYM058', ['xmm%d' % n for n in range(16)]),
    'ymm': ('SYM063', ['ymm%d' % n for n in range(16)]),
    'zmm': ('Vol.1 332', ['zmm%d' % n for n in range(32)]),
    'mm': ('SYM055', ['mm%d' % n for n in range(8)]),
    'k': ('SYM073', ['k%d' % n for n in range(8)]),
    'bnd': ('SYM067', ['bnd%d' % n for n in range(4)]),
    'tmm': ('Vol.1 425', ['tmm%d' % n for n in range(8)]),
    # SYM054 ST(i)는 i := 0..7이지만 ST(0)은 따로 SYM053 표기다. 선택 규칙: 구분되게 st(1)부터 쓴다.
    'ST(i)': ('SYM054', ['st(%d)' % n for n in range(1, 8)]),
    'Sreg': ('SYM050', ['es', 'cs', 'ss', 'ds', 'fs', 'gs']),
    'CR0–CR7': ('표 Instruction 칸', ['cr%d' % n for n in range(8)]),
    'DR0–DR7': ('표 Instruction 칸', ['dr%d' % n for n in range(8)]),
}
WRITEMASKS = ('SYM071', ['k%d' % n for n in range(1, 8)])  # {k1}{z}: k1 through k7

GPR_NUMBER = {}
for _names in (['al', 'cl', 'dl', 'bl'], ['ax', 'cx', 'dx', 'bx', 'sp', 'bp', 'si', 'di'],
               ['eax', 'ecx', 'edx', 'ebx', 'esp', 'ebp', 'esi', 'edi'],
               ['rax', 'rcx', 'rdx', 'rbx', 'rsp', 'rbp', 'rsi', 'rdi']):
    for _number, _name in enumerate(_names):
        GPR_NUMBER[_name] = _number
GPR_NUMBER.update({'spl': 4, 'bpl': 5, 'sil': 6, 'dil': 7, 'ah': 'ah', 'ch': 'ch', 'dh': 'dh', 'bh': 'bh'})
for _n in range(8, 16):
    for _suffix in ('', 'd', 'w', 'b'):
        GPR_NUMBER['r%d%s' % (_n, _suffix)] = _n

# 선택 규칙: 메모리 주소에 쓰는 레지스터(기본 rax, 색인 rbx)는 값 오퍼랜드에서 뺀다(주소와 값을 구분할 수 있게).
ADDRESS_BASE, ADDRESS_INDEX = 'rax', 'rbx'
ADDRESS_FORMS = {  # 선택 규칙: 총론 2.2.1.4·Vol.1 66쪽의 64비트 기본 주소 크기로 base / SIB / RIP 세 형태
    'base': '[rax]', 'sib': '[rax+rbx*4+0x10]', 'rip': '[rip+0x10]',
}

# ---------- 메모리 폭 (SDM) ----------
MEMORY_BITS = {
    'm8': ('SYM041', 8), 'm16': ('SYM042', 16), 'm32': ('SYM043', 32), 'm64': ('SYM044', 64),
    'm128': ('SYM045', 128), 'm256': ('SYM064', 256), 'm512': ('SYM069', 512),
    'm32fp': ('SYM051', 32), 'm64fp': ('SYM051', 64), 'm80fp': ('SYM051', 80),
    'm16int': ('SYM052', 16), 'm32int': ('SYM052', 32), 'm64int': ('SYM052', 64), 'm80bcd': ('SYM048', 80),
    'm2byte': ('Vol.2 506 + Vol.1 213 / Vol.2 510 (완화 A)', 16),
}
# r/m8~r/m64는 총론이 레지스터·메모리 겸용 기호로 따로 정의한다(SYM035~038). 메모리 쪽 근거는 이 번호로 적는다.
# (SYM042 m16은 "used only with the string instructions"라서 r/m16의 메모리 근거로 맞지 않는다)
RM_SYMBOLS = {'r/m8': 'SYM035', 'r/m16': 'SYM036', 'r/m32': 'SYM037', 'r/m64': 'SYM038'}
# 크기 키워드 없이 쓰는 메모리 표기(원문 폭이 키워드와 맞지 않거나 원문이 폭을 하나로 정하지 않음)
MEMORY_NO_KEYWORD = {
    'm': 'SYM040 (16, 32 또는 64)', 'mem': '명령 절 폭: LDDQU 16바이트, XSAVE·XRSTOR 계열 완화 C 가변', 'mib': 'SYM068', 'sibmem': 'Vol.2 51 2.4',
    'm384': 'GNU 키워드 없음', 'm512byte': 'GNU 키워드 없음', 'm14/28byte': 'GNU 키워드 없음',
    'm94/108byte': 'GNU 키워드 없음', 'm16&32': 'SYM047', 'm16&16': 'SYM047', 'm32&32': 'SYM047', 'm16&64': 'SYM047',
}
SIZE_KEYWORD = {8: 'byte', 16: 'word', 32: 'dword', 48: 'fword', 64: 'qword', 80: 'tbyte',
                128: 'xmmword', 256: 'ymmword', 512: 'zmmword'}

# 도구 문법: 원문 폭과 같은 키워드를 붙이면 GNU as가 거부하는 명령(기존 생성기에서 관측해 옮김)
# (as 관측: "fxsave zmmword ptr [eax]" 거부, "aesdec128kl xmm0, xmmword ptr [eax]" 거부, "ldtilecfg zmmword ptr" 거부)
TOOL_NO_SIZE_KEYWORD = {
    'AESDEC128KL', 'AESDEC256KL', 'AESDECWIDE128KL', 'AESDECWIDE256KL', 'AESENC128KL', 'AESENC256KL',
    'AESENCWIDE128KL', 'AESENCWIDE256KL', 'ENQCMD', 'ENQCMDS', 'FXRSTOR', 'FXRSTOR64', 'FXSAVE', 'FXSAVE64',
    'LDTILECFG', 'STTILECFG', 'MOVDIR64B',
}

# ---------- 즉시값 (선택 규칙) ----------
# 기본값: 그 폭에만 들어가는 값(작은 폭 형식이나 1비트 시프트 행으로 바뀌지 않게). 변형: 부호 있는 최대값.
# SYM030~033: imm8 -128..127, imm16/imm32/imm64는 그 폭의 값
IMMEDIATES = {
    'imm8': ('SYM030', '0x12', '0x7f'), 'imm16': ('SYM031', '0x1234', '0x7fff'),
    'imm32': ('SYM032', '0x12345678', '0x7fffffff'), 'imm64': ('SYM033', '0x123456789abcdef0', '0x7fffffffffffffff'),
}

# ---------- 표기 정리 (원문 오기·추출 잡음) ----------
SYMBOL_FIXES = {
    'xmm2/mm128': ('xmm2/m128', 'PDF 표 오기(Sol 1220: 설명 칸은 xmm2/m128)'),
    'ymm3/.m256': ('ymm3/m256', 'PDF 표 오기(Sol 1582: 마침표 섞임)'),
    'r64/m161': ('r64/m16', '추출 잡음: 각주 1이 붙음(Sol 992)'),
    'imm8/r': ('imm8', 'PDF 표기(Sol 4010). 구문의 imm8로 읽는다'),
}

# 주소 크기를 따르는 레지스터(Description: 레지스터가 주소를 담음). 64비트 기본 주소 크기(VOL1_DEFAULTS)의 r64를 쓴다.
ADDRESS_REGISTER_MNEMONICS = {'UMONITOR', 'MOVDIR64B', 'ENQCMD', 'ENQCMDS'}

# reg 칸(SYM039 "can be r16, r32, or r64")의 r64 대안과 근거. 대표값 r32(Vol.1 66 기본 크기) 다음에 만든다.
# 명령 절이 r32·r64를 적은 행은 그 쪽, 명령 절이 폭을 적지 않은 행은 SYM039만 근거로 적는다.
# r16은 만들지 않는다(2026-10-12 사용자 결정): 어느 명령 절에도 없고, 16비트 크기를 나타낼 인코딩이 없다.
_SECTION_R32_R64 = {
    'EXTRACTPS': 'Vol.2 423 "default operand size of 64 bits"', 'VEXTRACTPS': 'Vol.2 423 "default operand size of 64 bits"',
    'MOVMSKPD': 'Vol.2 787 "r32 or r64"', 'VMOVMSKPD': 'Vol.2 787 "r32 or r64"',
    'MOVMSKPS': 'Vol.2 789 "r32 or r64"', 'VMOVMSKPS': 'Vol.2 789 "r32 or r64"',
    'PEXTRB': 'Vol.2 989 "r32 or r64"', 'VPEXTRB': 'Vol.2 989 "r64/r32"',
    'PEXTRW': 'Vol.2 992 "r32 or r64"', 'VPEXTRW': 'Vol.2 992 "r64/r32"',
    'PMOVMSKB': 'Vol.2 1053 "r32 or r64"', 'VPMOVMSKB': 'Vol.2 1053 "r32 or r64"',
}
REG_R64 = dict(_SECTION_R32_R64, **{name: 'SYM039 (명령 절 폭 없음)' for name in ('VMOVW', 'VPBROADCASTB', 'VPBROADCASTW')})

# 명령 절이 RIP 상대 주소를 #UD로 정한 메모리 오퍼랜드: RIP 형태를 만들지 않는다
RIP_UNDEFINED = {
    'BNDMK': 'BNDMK 절: "#UD if executed in 64-bit mode with RIP-relative addressing"',
    'BNDLDX': 'BNDLDX 절 64-Bit Mode Exceptions: "#UD If ModRM is RIP relative."',
    'BNDSTX': 'BNDSTX 절 64-Bit Mode Exceptions: "#UD If ModRM is RIP relative."',
}

STRING_NAMES = {'CMPS', 'MOVS', 'STOS', 'SCAS', 'LODS', 'INS', 'OUTS'}
# SYM041/042: "pointed to by the DS:(E)SI or ES:(E)DI registers". 64비트 기본 주소 크기로 rsi/rdi.
STRING_ADDRESSES = {'MOVS': ['[rdi]', '[rsi]'], 'CMPS': ['[rsi]', '[rdi]'], 'LODS': ['[rsi]'], 'OUTS': ['[rsi]'],
                    'STOS': ['[rdi]'], 'SCAS': ['[rdi]'], 'INS': ['[rdi]']}
STRING_ACCUMULATOR_BITS = {'AL': 8, 'AX': 16, 'EAX': 32, 'RAX': 64}

# SDM Description 보정(2026-09-28 거부 입력 재검토에서 옮김, 문서는 git 기록 b24bb9c 이전): (니모닉, opcode, 표기) -> 생성 표기
DESCRIPTION_CORRECTIONS = {
    ('VPMOVQD', 'EVEX.128.F3.0F38.W0 35 /r', 'xmm1/m128'):
        ('xmm1/m64', 'SDM PDF 2054-2055: Half Mem, 2 dwords -> m64'),
    ('VSCATTERDPD', 'EVEX.256.66.0F38.W1 A2 /vsib', 'vm32y'):
        ('vm32x', 'SDM PDF 2202-2204: 4 dword indices -> XMM index'),
    ('VSCATTERDPD', 'EVEX.512.66.0F38.W1 A2 /vsib', 'vm32z'):
        ('vm32y', 'SDM PDF 2202-2204: 8 dword indices -> YMM index'),
}

# 도구 문법으로 그 표 행을 지정하는 철자(기존 생성기에서 옮김; 근거는 각 항목)
ROW_SPELLINGS = {
    ('CALL', 'FF /3', 'm16:16'): ('data16', '', 'fword ptr [rax]', 'SDM 239-242: data16이 16비트 오프셋을 고름'),
    ('JMP', 'FF /5', 'm16:16'): ('data16', '', 'fword ptr [rax]', 'SDM 622-624: data16이 16비트 오프셋을 고름'),
    ('CALL', 'REX.W FF /3', 'm16:64'): ('rex64', '', 'fword ptr [rax]', 'SDM 239-242: rex64가 64비트 오프셋을 고름'),
    ('JMP', 'REX.W FF /5', 'm16:64'): ('rex64', '', 'fword ptr [rax]', 'SDM 622-624: rex64가 64비트 오프셋을 고름'),
    ('SYSEXIT', 'REX.W 0F 35', ''): ('', 'sysexitq', '', 'SDM 1408: 64비트 사용자 코드로 복귀'),
    ('SYSRET', 'REX.W 0F 07', ''): ('', 'sysretq', '', 'SDM 1411: 64비트 사용자 코드로 복귀'),
    # 표 Description "Far return". 표 Instruction 칸은 near와 같은 'RET'이므로 GNU/clang의 far 철자 retf를 쓴다
    ('RET', 'CB', ''): ('', 'retf', '', '표 Description "Far return to calling procedure."'),
    ('RET', 'CA iw', 'imm16'): ('', 'retf', '', '표 Description "Far return ... pop imm16 bytes"'),
    # 64비트 모드 'push imm'은 68 id가 된다. 16비트 피연산자(66)는 GNU 문서의 data16 접두어로 지정
    # (2026-10-11 관측: GNU 'data16 push' -> 66 68 iw. clang의 data16은 0x66 한 바이트라 66 68 id가 된다.
    #  clang Intel 문법에는 PUSH imm16 철자가 없다. REPORT '버그 후보 원문 재점검')
    ('PUSH', '68 iw', 'imm16'): ('data16', '', '', '표 "PUSH imm16"(66 접두어로 16비트 피연산자)'),
}
# 오퍼랜드 없는 16비트 행(operand_size_prefix가 16으로 정한 행): SDM 니모닉만으로는 도구가 16비트를 고르지 않는다.
# 원문: PUSHF·POPF "Others may treat these mnemonics as synonyms"(Vol.2 PUSHF·POPF Description),
#       LEAVE는 16·32·64비트 행의 문법이 모두 'LEAVE'다.
# 두 도구가 받는 철자를 쓴다(2026-10-11 관측: pushfw 669c, popfw 669d, data16 leave 66c9).
# IRET(16비트)은 SDM 니모닉 'iret'을 그대로 둔다. clang은 66 cf, GNU는 cf(SDM: "most assemblers use the IRET
# mnemonic interchangeably")이며, GNU의 iretw는 clang이 모른다.
OPERANDLESS_16BIT_SPELLINGS = {
    'PUSHF': ('', 'pushfw', 'Vol.2 PUSHF: 니모닉을 동의어로 다루는 어셈블러가 있음'),
    'POPF': ('', 'popfw', 'Vol.2 POPF: 니모닉을 동의어로 다루는 어셈블러가 있음'),
    'LEAVE': ('data16', '', 'Vol.2 LEAVE: 16·32·64비트 행 문법이 같음, 66H로 16비트'),
}
FAR_POINTER_MEMORY = {'16': 'dword', '32': 'fword', '64': 'tbyte'}  # LSS/LFS/LGS: m16:16/32/64의 전체 크기
FAR_POINTER_IMMEDIATE = {'ptr16:16': '0x10:0x1234', 'ptr16:32': '0x10:0x12345678'}  # SYM025


def clean_symbol(symbol):
    """표 기호에서 각주(^1)와 장식({k1}{z}, {er}, {sae})을 떼고 '/' 주변 공백을 없앤다."""
    text = re.sub(r'\^\d+', '', symbol or '')
    text = re.sub(r'\s*\{[^}]*\}', '', text).strip()
    text = re.sub(r'\s*/\s*', '/', text)
    return SYMBOL_FIXES.get(text, (text, ''))[0]


def decorations(symbol):
    """표 기호의 장식 목록: ['{k1}', '{z}', '{er}', '{sae}'] 중 있는 것."""
    return re.findall(r'\{[^}]*\}', symbol or '')


def register_family(part):
    """'xmm1' -> 'xmm', 'r32a' -> 'r32', 'k1+1' -> 'k', 'zmm2+3' -> 'zmm', 'bnd1' -> 'bnd'. 레지스터가 아니면 None."""
    part = re.sub(r'\+\d+$', '', part)
    for family in ('xmm', 'ymm', 'zmm', 'tmm', 'bnd', 'mm', 'k'):
        if re.fullmatch(family + r'\d*', part):
            return family
    if re.fullmatch(r'r(8|16|32|64)[ab]?', part):
        return re.sub(r'[ab]$', '', part)
    if part in ('ST(i)', 'Sreg', 'CR0–CR7', 'DR0–DR7'):
        return part
    return None


def is_memory(part):
    return (part in MEMORY_BITS or part in MEMORY_NO_KEYWORD or bool(re.fullmatch(r'm(16|32|64)bcst', part))
            or bool(re.fullmatch(r'vm(32|64)[xyz]', part)) or bool(re.fullmatch(r'm16:(16|32|64)', part))
            or bool(re.fullmatch(r'moffs(8|16|32|64)', part)))


def fixed_register(part):
    """표에 이름 그대로 적힌 고정 레지스터(AL, DX, ST(0), CR8, FS ...)면 소문자 이름, 아니면 None."""
    if part in ('ST', 'ST(0)'):
        return 'st(0)' if part == 'ST(0)' else 'st'
    if re.fullmatch(r'(?:[A-Z]{2,3}|CR8)', part) and part not in ('ST',):
        return part.lower()
    return None


def memory_text(part, address, mnemonic):
    """메모리 표기 하나 -> 소스 철자. 크기 키워드는 원문 폭(MEMORY_BITS)과 같은 GNU 키워드만 쓴다."""
    if mnemonic in TOOL_NO_SIZE_KEYWORD or part in MEMORY_NO_KEYWORD:
        return address
    if part in MEMORY_BITS:
        keyword = SIZE_KEYWORD.get(MEMORY_BITS[part][1])
        return '%s ptr %s' % (keyword, address) if keyword else address
    far = re.fullmatch(r'm16:(16|32|64)', part)
    if far:
        return '%s ptr %s' % (FAR_POINTER_MEMORY[far.group(1)], address)
    return address


def evidence_of(part):
    """대표값 근거 표시(원문 위치 또는 규칙 이름)."""
    family = register_family(part)
    if family:
        return REGISTER_LISTS[family][0]
    if part in MEMORY_BITS:
        return MEMORY_BITS[part][0]
    if part in MEMORY_NO_KEYWORD:
        return MEMORY_NO_KEYWORD[part]
    if part in IMMEDIATES:
        return IMMEDIATES[part][0]
    if re.fullmatch(r'm(16|32|64)bcst', part):
        return VOL2_BCST[0] if part != 'm16bcst' else 'Vol.2 1889 VMAXPH (완화 D)'
    if re.fullmatch(r'vm(32|64)[xyz]', part):
        return 'SYM075/076'
    if re.fullmatch(r'm16:(16|32|64)', part):
        return 'SYM046'
    if re.fullmatch(r'moffs(8|16|32|64)', part):
        return 'SYM049'
    if re.fullmatch(r'rel(8|16|32)', part):
        return 'SYM023/024'
    return '표에 적힌 값'

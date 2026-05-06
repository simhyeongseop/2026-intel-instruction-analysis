import pdfplumber
import pandas as pd
import re


def clean_instruction_text(text: str) -> str:
    """PDF 파싱 시 각주(superscript) 번호가 오퍼랜드 타입 또는 니모닉에 오염된 것을 수정.

    처리 케이스:
      r/m81, r/m82  → r/m8   (r/m8 뒤 각주 숫자, 공백 포함 케이스도 처리)
      r81, r82      → r8     (r8 뒤 각주 숫자)
      r8,1          → r8,    (쉼표와 각주가 붙은 케이스)
      imm81         → imm8
      moffs83 etc.  → moffs8/16/32/64
      Sreg2         → Sreg
      FNSAVE1 ...   → FNSAVE ...  (FN* 니모닉 각주 정규화)
    """
    # r/m 뒤 각주 숫자 제거 — 공백 포함 케이스도 처리 (r/m8 1, r/m82, r/m162 등)
    text = re.sub(r'r/m(8|16|32|64)\s*\d+', r'r/m\1', text)
    # r/m8,2 형태 — 쉼표 뒤에 각주가 붙은 케이스 (ROL r/m8,2 1 → ROL r/m8, 1)
    text = re.sub(r'r/m8,\d+', 'r/m8,', text)
    # r8/r16/r32/r64 뒤 각주 숫자 제거 (r81→r8, r162→r16, r642→r64 등)
    text = re.sub(r'\br(8|16|32|64)\d+\b', r'r\1', text)
    # r8,1 형태 (쉼표와 각주가 붙은 케이스)
    text = re.sub(r'\b(r8),\d+', r'\1,', text)
    # m8/m16/m32/m64 뒤 각주 숫자 제거 (m162→m16, m642→m64 등)
    # m80bcd, m80fp 는 \b 덕분에 보호됨
    text = re.sub(r'\bm(8|16|32|64)\d+\b', r'm\1', text)
    # imm8 뒤 각주 숫자 제거
    text = re.sub(r'imm8\d+', 'imm8', text)
    # moffs 각주 제거 (moffs83→moffs8, moffs163→moffs16 등)
    text = re.sub(r'moffs(8|16|32|64)\d+', r'moffs\1', text)
    # Sreg 각주 제거
    text = re.sub(r'Sreg\d+', 'Sreg', text)
    # FN* 니모닉 끝의 각주 1 제거 (FNSAVE1→FNSAVE, FNSTCW1→FNSTCW 등)
    text = re.sub(r'^(FN[A-Z]+)1\b', r'\1', text)
    return text.strip()

# 테이블 헤더 행 제외용 키워드
HEADER_KEYWORDS = {
    'Opcode', 'Instruction', 'Op/En', '64-Bit', 'Compat', 'Description',
    'Mode', 'Leg Mode', '64/32', 'CPUID', 'Encoding',
}

# 실제 명령어가 아닌 노이즈 니모닉
NOISE_MNEMONICS = {
    # 프리픽스 바이트
    'REXPrefix', 'F3', 'F2', 'F0', 'F1', 'REX',
    'VEX', 'EVEX', 'XOP', 'MVEX',
    # 세그먼트 프리픽스 (단독 명령어 아님)
    'SS', 'CS', 'DS', 'ES', 'FS', 'GS',
    # 기술 명칭
    'AVX', 'AVX2', 'XMM', 'YMM', 'ZMM', 'F16C', 'CMPCCXADD', 'AMX',
    'VVVV', 'FP', 'Type',
    # Op/En 인코딩 표기 (RM, MR, RMI 등 오퍼랜드 인코딩 코드)
    'RM', 'MR', 'RMI', 'RVM', 'MVR', 'RVMI', 'RVMR', 'VMI', 'VM',
    'ZO', 'OI', 'RR', 'RRI', 'MF', 'RM0', 'RMV', 'RVR', 'RMOV',
    'SPE', 'PRIV', 'OPA', 'IOPL', 'QNAN', 'FCS', 'FALSE', 'X1', 'X2',
    # 레지스터 이름이 단독으로 잡힌 경우
    'RAX', 'RBX', 'RCX', 'RDX', 'RSI', 'RDI', 'RSP', 'RBP',
    'EAX', 'EBX', 'ECX', 'EDX', 'ESI', 'EDI', 'ESP', 'EBP',
    'BH', 'AH', 'CH', 'DH',
    # 기타 노이즈
    'UD01', 'UDB', 'AXCXDXBXSPBPSIDI',
    # FPU 노이즈 (명령어+오퍼랜드타입 합쳐진 것)
    # FNSTSW1/FNINIT1/FNCLEX1 은 clean_instruction_text()로 정규화하므로 제거
    'FISTTPINTEGER64', 'FISTTPinteger64',
    'FIMULWORDI', 'FIMULDWORDI',
    # 추가 Op/En 코드 변형
    'RVMI', 'RVM', 'MVR',
}

# 64비트 모드에서 Invalid인 명령어 하드코딩 백업 목록
# (PDF에서 컬럼 값이 다양하게 표기되어 필터가 안 잡히는 경우 대비)
INVALID_64BIT_INSTRS = {
    'ARPL', 'LDS', 'LES', 'BOUND', 'PUSHA', 'PUSHAD', 'POPA', 'POPAD',
    'AAA', 'AAD', 'AAM', 'AAS', 'DAA', 'DAS', 'INTO', 'JCXZ', 'JECXZ',
}

# col[0] opcode가 이 단어로 시작하면 노이즈 (Type 1, Type E2 등)
NOISE_OPCODE_PREFIXES = ('Type ', 'EVEX.vvvv', 'EVEX.aaa')

# 유효한 instruction form 패턴: 대문자 2글자 이상으로 시작
INSTR_PATTERN = re.compile(r'^[A-Z][A-Z0-9]{1,15}(\s|$)')

# 64비트 모드 col[3] 값 중 필터링할 것
MODE_64BIT_INVALID = {'Invalid', 'I', 'N.E.', 'N.S.'}

# 실제 opcode는 16진수 바이트, /r, VEX/EVEX/REX 접두어 중 하나를 포함
# "Type 1", "EVEX.vvvv" 같은 노이즈 제외용
OPCODE_VALID = re.compile(
    r'([0-9A-F]{2}|/[r01234567]|VEX\.|EVEX\.|REX\.?W?|'
    r'\bib\b|\biw\b|\bid\b|\bio\b)',
    re.IGNORECASE
)


class IntelInstructionExtractor:
    def __init__(self, pdf_path):
        self.pdf_path = pdf_path
        self.seen = set()
        self.instruction_data = []

    def preprocess_text(self, text):
        if not text:
            return ""
        text = re.sub(r'([a-zA-Z0-9])[\n\r]+([a-zA-Z0-9])', r'\1\2', text)
        text = re.sub(r'[\n\r]+', ' ', text)
        text = re.sub(r'\s+', ' ', text)
        return text.strip()

    def is_valid_instruction_row(self, row):
        """
        유효한 instruction encoding 테이블 행인지 확인.
        - col[1]: 완전한 instruction form (ADC AL, imm8 등)
        - col[3]: 64-bit Mode 컬럼 → Invalid/N.E. 이면 제외
        """
        # 최소 4개 컬럼 필요 (Opcode, Instruction, Op/En, 64-Bit Mode)
        if len(row) < 4 or not row[1]:
            return False

        cell = str(row[1]).strip()

        # 헤더 행 제외
        if any(kw in cell for kw in HEADER_KEYWORDS):
            return False

        # 대문자 니모닉 패턴 확인
        if not INSTR_PATTERN.match(cell):
            return False

        # 노이즈 니모닉 제외 (쉼표·점·숫자 trailing 제거 후 비교)
        mnemonic = cell.split()[0].rstrip(',.') if cell.split() else ''
        if mnemonic in NOISE_MNEMONICS:
            return False

        # 64-bit Mode 컬럼(col[3]) 확인: Invalid/N.E. 제외
        mode_64 = str(row[3]).strip() if row[3] else ''
        if mode_64 in MODE_64BIT_INVALID:
            return False

        # 하드코딩 64비트 Invalid 명령어 제외 (컬럼 값이 다양하게 표기된 경우 대비)
        if mnemonic in INVALID_64BIT_INSTRS:
            return False

        # col[0] opcode 유효성 확인 ("Type 1", "EVEX.vvvv" 같은 노이즈 제외)
        opcode_raw = str(row[0]).strip() if row[0] else ''
        if opcode_raw:
            if opcode_raw.startswith(NOISE_OPCODE_PREFIXES):
                return False
            if not OPCODE_VALID.search(opcode_raw):
                return False

        # 하이픈 포함 instruction form 제외 (fmulsingle-real 등 오퍼랜드 타입이 붙은 노이즈)
        if '-' in cell:
            return False

        return True

    def extract_from_pdf(self):
        """
        col[0] = Opcode, col[1] = Instruction form, col[3] = 64-bit Mode
        64비트에서 유효한 명령어만 추출한다.
        """
        with pdfplumber.open(self.pdf_path) as pdf:
            for page in pdf.pages:
                tables = page.extract_tables()
                if not tables:
                    continue

                for table in tables:
                    for row in table:
                        if not row:
                            continue

                        # col[1] 에 cleaning 적용 후 validity 검사
                        if len(row) >= 2 and row[1]:
                            row = list(row)
                            row[1] = clean_instruction_text(
                                self.preprocess_text(str(row[1]))
                            )

                        if not self.is_valid_instruction_row(row):
                            continue

                        opcode      = self.preprocess_text(str(row[0]) if row[0] else '')
                        instruction = str(row[1])  # 이미 preprocess + clean 완료
                        mode_64     = self.preprocess_text(str(row[3]) if row[3] else '')

                        if not instruction:
                            continue

                        key = (opcode, instruction)
                        if key in self.seen:
                            continue
                        self.seen.add(key)

                        self.instruction_data.append({
                            'original':    instruction,
                            'opcode':      opcode,
                            'instruction': instruction,
                            'mode_64':     mode_64,
                        })

    def save_to_csv(self, output_path):
        df = pd.DataFrame(self.instruction_data)
        df.to_csv(output_path, index=False, encoding='utf-8-sig')

        total = len(df)
        print(f"총 추출된 명령어 form: {total}")
        print(f"저장: {output_path}")

        print("\n=== 샘플 (앞 10개) ===")
        for _, r in df.head(10).iterrows():
            print(f"  [{r['opcode'][:20]:20s}] {r['instruction']}")

        # 제외된 케이스 통계
        print(f"\n[필터 적용] 64-bit Invalid 및 노이즈 제외 후 {total}개 추출")


def main():
    pdf_path = "325383-090-sdm-vol-2abcd.pdf"
    output_path = "data/stage1_extracted/instruction_list_original.csv"

    extractor = IntelInstructionExtractor(pdf_path)

    print("PDF에서 명령어 추출 중 (64-bit Invalid 제외)...")
    extractor.extract_from_pdf()

    print("결과 저장 중...")
    extractor.save_to_csv(output_path)

    print("완료!")


if __name__ == "__main__":
    main()

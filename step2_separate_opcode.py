import pandas as pd
import re
from collections import namedtuple

class IntelOpcodeProcessor:
    """
    Intel x86/x64 어셈블리 명령어를 Opcode와 Instruction으로 분리하는 클래스
    """
    
    def __init__(self, csv_path='instruction_list.csv'):
        self.df = pd.read_csv(csv_path)
        self.instructions = self.df['Instruction Syntax'].tolist()
        self.opcodes = []
        self.separated_instructions = []
        self.operands = set()
        
    def separate_opcode_instruction(self, text):
        """
        텍스트에서 Opcode와 Instruction을 분리
        
        형식:
        - EVEX.128.0F.W0 10 /rVMOVUPS xmm1 {k1}{z}
          → Opcode: EVEX.128.0F.W0 10 /r, Instruction: VMOVUPS xmm1 {k1}{z}
        - ADD r/m16
          → Opcode: (없음), Instruction: ADD r/m16
        """
        
        # 패턴 1: EVEX/VEX/REX 접두사 + 16진수/숫자 + /r 패턴
        # EVEX.128.0F.W0 10 /rVMOVUPS ... → Opcode + Instruction 분리
        evex_pattern = r'^((?:EVEX|VEX|REX)[^V]*?/[rR])([A-Z].*?)(?:\s|$)'
        match = re.match(evex_pattern, text)
        
        if match:
            opcode = match.group(1).strip()
            instruction = match.group(2).strip() + ' ' + text[match.end():].strip()
            return opcode, instruction.strip()
        
        # 패턴 2: 일반 니모닉 + 오퍼랜드
        # ADD, SUB, ANDN 등 기존 테이블에서 나올 수 있는 형식
        mnemonic_pattern = r'^([A-Z][A-Z0-9]*(?:\s+[^A-Z].*)?)'
        match = re.match(mnemonic_pattern, text)
        
        if match:
            instruction = match.group(1).strip()
            return None, instruction
        
        # 분리 불가능한 경우
        return None, text
    
    def split_combined_operands(self, instruction_text):
        """
        r/m16 같은 combined operand를 r16, m16으로 분리
        m16&16 같은 경우도 처리
        """
        # r/m 패턴 분리
        instruction_text = re.sub(r'\br/m(\d+)\b', r'r\1, m\1', instruction_text)
        
        # m&숫자 패턴 (m16&16 → m16)
        instruction_text = re.sub(r'\bm(\d+)&\d+\b', r'm\1', instruction_text)
        
        # ptr16:숫자 패턴 (ptr16:32 → ptr16:32 유지)
        # 이것은 주소 지정이므로 그대로 유지
        
        return instruction_text
    
    def extract_operands(self, text):
        """
        텍스트에서 모든 오퍼랜드 추출
        """
        operands = set()
        
        # 레지스터 오퍼랜드
        register_patterns = [
            r'\b(r\d+)\b',  # r8, r16, r32, r64, r81 등
            r'\b([a-z]{2,3}(?:h|l)?)\b',  # al, ah, ax, eax, rax 등
            r'\b([xy]mm\d+)\b',  # xmm0-xmm31, ymm0-ymm31
            r'\b([zy]mm\d+)\b',  # zmm0-zmm31
            r'\b(rip)\b',  # RIP-relative addressing
        ]
        
        # 메모리 오퍼랜드
        memory_patterns = [
            r'\b(m\d+)\b',  # m8, m16, m32, m64, m128, m256, m512
        ]
        
        # 즉시값 오퍼랜드
        imm_patterns = [
            r'\b(imm\d+)\b',  # imm8, imm16, imm32
        ]
        
        # 기타 오퍼랜드
        other_patterns = [
            r'\b(ptr\d+:\d+)\b',  # ptr16:32, ptr16:16 등
            r'\b(rel\d+)\b',  # rel8, rel16, rel32
            r'\b(vm\d+[a-z])\b',  # vm32x, vm64x 등
            r'\b(k[0-9])\b',  # 마스킹 레지스터 k0-k7
        ]
        
        for pattern in register_patterns + memory_patterns + imm_patterns + other_patterns:
            matches = re.findall(pattern, text, re.IGNORECASE)
            operands.update([m.lower() for m in matches])
        
        return operands
    
    def process_all(self):
        """
        모든 명령어를 처리
        """
        print("\n" + "=" * 80)
        print("단계 2: Opcode와 Instruction 분리")
        print("=" * 80)
        
        opcode_found = 0
        
        for inst in self.instructions:
            opcode, instruction = self.separate_opcode_instruction(inst)
            
            if opcode:
                opcode_found += 1
            
            # combined operand 분리
            instruction = self.split_combined_operands(instruction)
            
            # 오퍼랜드 추출
            operands = self.extract_operands(instruction)
            self.operands.update(operands)
            
            self.opcodes.append(opcode)
            self.separated_instructions.append(instruction)
        
        print(f"\n[분리 결과]")
        print(f"  - Opcode 발견됨: {opcode_found}개")
        print(f"  - Opcode 없음: {len(self.instructions) - opcode_found}개")
        print(f"  - 발견된 총 오퍼랜드 타입: {len(self.operands)}개")
        
        # 샘플 표시
        print("\n[분리된 명령어 샘플 (Opcode 있는 경우)]")
        for i, (orig, opc, inst) in enumerate(zip(self.instructions, self.opcodes, self.separated_instructions)):
            if opc:
                print(f"  원본: {orig}")
                print(f"  Opcode: {opc}")
                print(f"  Instruction: {inst}")
                if i > 2:
                    break
                print()
    
    def save_results(self):
        """
        분리된 결과를 CSV 파일로 저장
        """
        result_df = pd.DataFrame({
            'Original': self.instructions,
            'Opcode': self.opcodes,
            'Instruction': self.separated_instructions
        })
        
        result_df.to_csv('opcode_instruction_separated.csv', index=False, encoding='utf-8')
        print(f"\n✓ 분리 결과 저장: opcode_instruction_separated.csv")
        
        # 오퍼랜드만 저장
        operands_df = pd.DataFrame({
            'Operand': sorted(self.operands)
        })
        
        operands_df.to_csv('extracted_operands.csv', index=False, encoding='utf-8')
        print(f"✓ 추출된 오퍼랜드 저장: extracted_operands.csv ({len(self.operands)}개)")


if __name__ == "__main__":
    processor = IntelOpcodeProcessor()
    processor.process_all()
    processor.save_results()

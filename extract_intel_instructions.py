import pdfplumber
import pandas as pd
import re
import os

class IntelInstructionExtractor:
    def __init__(self, pdf_path):
        """
        초기화 메서드
        :param pdf_path: 분석할 인텔 매뉴얼 Volume 2 PDF 파일 경로
        """
        self.pdf_path = pdf_path
        # 명령어의 중복을 방지하기 위해 Set 자료구조 사용
        self.instructions = set()
        # Opcode와 Instruction이 분리된 데이터를 저장할 리스트
        # 각 요소: {original: 원본, opcode: 분리된opcode, instruction: 분리된명령어}
        self.instruction_data = []
        
    def preprocess_text(self, text):
        """
        텍스트 정제 및 병합 (노이즈 및 줄바꿈 복구 로직)
        :param text: 테이블 셀에서 추출된 원본 문자열
        :return: 정제된 명령어 신텍스 문자열
        """
        if not text:
            return ""
            
        # 1. 단어 중간에서 줄바꿈이 일어난 경우 이어붙이기 (예: 'VFMAD\nD132PD' -> 'VFMADD132PD')
        # 영문자나 숫자로 끝나는 라인이 영문자나 숫자로 시작하는 라인과 줄바꿈으로 나뉜 경우 삭제
        text = re.sub(r'([a-zA-Z0-9])[\n\r]+([a-zA-Z0-9])', r'\1\2', text)
        
        # 2. 그 외의 줄바꿈(쉼표 다음이나 공백 다음 줄바꿈 발생)은 단일 띄어쓰기로 치환
        text = re.sub(r'[\n\r]+', ' ', text)
        
        # 3. 매뉴얼 특유의 각주 기호(*1, *2 등) 및 노이즈 기호 제거
        text = re.sub(r'\*[A-Za-z0-9]*', '', text)
        
        # 4. 연속된 다중 공백을 하나의 공백으로 압축하고 양끝 여백 제거
        text = re.sub(r'\s+', ' ', text).strip()
        
        return text

    def separate_opcode_from_instruction(self, text):
        """
        Opcode와 Instruction을 분리합니다.
        EVEX/VEX/REX 접두사를 가진 경우 분리, 아니면 None을 반환합니다.
        
        예시:
          EVEX.128.0F.W0 10 /rVMOVUPS xmm1 {k1}{z}
          → opcode: EVEX.128.0F.W0 10 /r
          → instruction: VMOVUPS xmm1 {k1}{z}
        
        :param text: 정제된 명령어 텍스트
        :return: (opcode, instruction) 튜플. Opcode가 없으면 (None, text) 반환
        """
        # 패턴 1: EVEX/VEX/REX 접두사가 있는 경우
        # EVEX.128.0F.W0 10 /r 형태의 Opcode 뒤에 명령어가 붙어있는 패턴
        match = re.match(r'^((?:EVEX|VEX|REX)[^V]*?/[rR])([A-Z].*?)(?:\s|$)', text)
        
        if match:
            opcode = match.group(1).strip()
            instruction_part = match.group(2).strip()
            # instruction 이후의 오퍼랜드와 모질들도 포함
            rest_idx = match.end(1)
            instruction = text[rest_idx:].strip()
            return opcode, instruction
        
        # Opcode 분리 불가능한 경우 (일반 명령어)
        return None, text

    def is_valid_instruction(self, text):
        """
        문자열이 유효한 어셈블리 명령어 신텍스(Syntax)인지 판별
        :param text: 정제된 텍스트
        :return: (유효 여부, 앞부분 니모닉(Mnemonic) 추출값)
        """
        # 앞글자가 대문자 알파벳으로 시작해야 함 (명령어 니모닉의 기본 룰)
        if not text or not text[0].isalpha() or not text[0].isupper():
            return False
            
        # 명령어 신텍스는 보통 길이가 지나치게 길지 않음 (100자 이상은 설명문일 확률이 높음)
        if len(text) > 100:
            return False
            
        # 첫 단어(니모닉)가 순수 영대문자/숫자의 조합인지 정규식으로 확인 (예: 'ADD', 'VFMADD132PD')
        mnemonic_match = re.match(r'^([A-Z][A-Z0-9]+)', text)
        if not mnemonic_match:
            return False
            
        # 소문자 단독으로 시작되는 경우 필터링 방어
        return True

    def parse(self):
        """
        PDF를 순회하며 테이블을 파싱하여 어셈블리 명령어를 추출
        """
        if not os.path.exists(self.pdf_path):
            print(f"[Error] PDF 파일을 찾을 수 없습니다: {self.pdf_path}")
            return

        print(f"[*] '{self.pdf_path}' 파일 분석을 시작합니다. (페이지 수가 많아 시간이 약간 소요됩니다)")
        
        with pdfplumber.open(self.pdf_path) as pdf:
            total_pages = len(pdf.pages)
            
            for page_num, page in enumerate(pdf.pages):
                tables = page.extract_tables()
                
                for table in tables:
                    if not table or not table[0]:
                        continue
                        
                    # 테이블의 첫 행(헤더) 가져오기, None 값은 빈 문자열로 처리
                    headers = [str(cell).strip().lower() for cell in table[0] if cell]
                    
                    # 'instruction' 컬럼이 존재하는 테이블인지 식별
                    # 인텔 매뉴얼의 Opcode 테이블 구조 상 'instruction' 열에 명령어 신텍스가 존재
                    inst_col_idx = -1
                    for idx, header in enumerate(headers):
                        if 'instruction' in header:
                            inst_col_idx = idx
                            break
                    
                    if inst_col_idx == -1:
                        continue  # 원하는 테이블이 아님
                        
                    # 헤더를 제외한 실제 데이터 행 순회
                    for row in table[1:]:
                        # 리스트 인덱스 Out of Range 방어
                        if len(row) <= inst_col_idx:
                            continue
                            
                        raw_inst = row[inst_col_idx]
                        if not raw_inst:
                            continue
                            
                        # 문자열 전처리 및 복구
                        cleaned_inst = self.preprocess_text(raw_inst)
                        
                        # 어셈블리 명령어 검증 후 Set에 추가 (자동 중복 제거)
                        if self.is_valid_instruction(cleaned_inst):
                            # 1. '-' 설명이 포함된 경우 제외
                            if '–' in cleaned_inst or ' - ' in cleaned_inst or '—' in cleaned_inst:
                                continue
                                
                            # 2. 콤마로 구분된 오퍼랜드 분리
                            if ',' in cleaned_inst:
                                parts = cleaned_inst.split(',')
                                first_part = parts[0].strip()
                                self.instructions.add(first_part)
                                
                                # Opcode 분리 및 저장
                                opcode, instruction = self.separate_opcode_from_instruction(first_part)
                                self.instruction_data.append({
                                    'original': first_part,
                                    'opcode': opcode,
                                    'instruction': instruction
                                })
                                
                                # Mnemonic 추출 (첫 번째 단어)
                                mnemonic = first_part.split(' ')[0]
                                
                                for p in parts[1:]:
                                    p = p.strip()
                                    if p:
                                        variant = f"{mnemonic} {p}"
                                        self.instructions.add(variant)
                                        
                                        # 각 variant에 대해서도 Opcode 분리
                                        opcode, instruction = self.separate_opcode_from_instruction(variant)
                                        self.instruction_data.append({
                                            'original': variant,
                                            'opcode': opcode,
                                            'instruction': instruction
                                        })
                            else:
                                self.instructions.add(cleaned_inst)
                                
                                # Opcode 분리 및 저장
                                opcode, instruction = self.separate_opcode_from_instruction(cleaned_inst)
                                self.instruction_data.append({
                                    'original': cleaned_inst,
                                    'opcode': opcode,
                                    'instruction': instruction
                                })
                            
                # 진행 상황 로깅 (매 100 페이지마다 출력)
                if (page_num + 1) % 100 == 0 or (page_num + 1) == total_pages:
                    print(f"[*] 진행 상황: {page_num + 1} / {total_pages} 페이지 파싱 완료...")

    def save_to_csv(self, output_file='instruction_list.csv'):
        """
        추출된 명령어를 알파벳 순(A-Z)으로 정렬하여 CSV 포맷으로 저장
        원본, Opcode, Instruction을 분리하여 저장합니다.
        
        :param output_file: 저장할 CSV 파일명
        """
        if not self.instruction_data:
            print("[Warning] 추출된 명령어가 없습니다.")
            return
        
        # instruction_data를 DataFrame으로 변환
        df = pd.DataFrame(self.instruction_data)
        
        # 원본 기준으로 정렬
        df = df.sort_values('original').reset_index(drop=True)
        
        # Opcode 분리 통계
        has_opcode = df['opcode'].notna().sum()
        no_opcode = df['opcode'].isna().sum()
        
        # CSV 저장 (utf-8, 인덱스 없음)
        df.to_csv(output_file, index=False, encoding='utf-8')
        
        print(f"\n[Success] 대상 분석 완료!")
        print(f"━" * 80)
        print(f"📊 추출 통계:")
        print(f"  • 총 명령어 수: {len(df)}")
        print(f"  • Opcode 포함 (EVEX/VEX/REX): {has_opcode}개")
        print(f"  • Opcode 없음 (일반 명령어): {no_opcode}개")
        print(f"\n💾 저장 정보:")
        print(f"  • 파일명: {output_file}")
        print(f"  • 파일 위치: {os.path.abspath(output_file)}")
        print(f"  • 포함 컬럼: original, opcode, instruction")
        print(f"━" * 80)
        
        # 샘플 출력 (Opcode가 있는 명령어 상위 5개)
        opcode_df = df[df['opcode'].notna()].head(5)
        if not opcode_df.empty:
            print(f"\n📌 Opcode 분리 샘플 (상위 5개):")
            for idx, row in opcode_df.iterrows():
                print(f"\n  [{idx+1}] 원본:")
                print(f"      {row['original']}")
                print(f"      Opcode: {row['opcode']}")
                print(f"      Instruction: {row['instruction']}")
        
        # 옵션: 원본 형식도 저장 (호환성 유지)
        original_only_df = pd.DataFrame(sorted(list(self.instructions)), columns=['Instruction Syntax'])
        original_output = output_file.replace('.csv', '_original.csv')
        original_only_df.to_csv(original_output, index=False, encoding='utf-8')
        print(f"\n💾 추가 저장:")
        print(f"  • {original_output} (기존 형식과 호환)")

if __name__ == "__main__":
    # 분석하려는 인텔 매뉴얼 Volume 2. PDF 파일명
    PDF_FILE_PATH = "325383-090-sdm-vol-2abcd.pdf"  
    
    # 클래스 모듈 인스턴스화
    extractor = IntelInstructionExtractor(PDF_FILE_PATH)
    
    # 분석 실행
    extractor.parse()
    
    # 결과 CSV 출력
    extractor.save_to_csv("instruction_list.csv")

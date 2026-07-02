"""
Stage 1 커버리지 검증 도구.

목차 니모닉 목록(toc_instruction_list.csv)을 ground truth로,
description 표 추출 결과(instruction_forms.csv)가 얼마나 커버하는지 대조한다.
누락 항목을 4분류한다:
  - 예상된 제외 : 64비트 invalid / cc placeholder / 그룹대표명 / 목차 압축표기
  - 대소문자차이 : 사실상 존재 (SDM이 X/x 혼용, 예 VEXTRACTF32X8)
  - 그룹명-구체형 존재 : VPSHLD → VPSHLDW/D/Q
  - 진짜 누락 : 위 어디에도 해당 안 됨
"""
import csv
import re
from pathlib import Path

BASE = Path(__file__).parent.parent.parent
FORMS = BASE / "data/stage1_extracted/instruction_forms.csv"
TOC = BASE / "data/stage1_extracted/toc_instruction_list.csv"

INVALID64 = {"AAA", "AAD", "AAM", "AAS", "BOUND", "DAA", "DAS", "INTO", "LDS", "LES",
             "POPA", "POPAD", "PUSHA", "PUSHAD", "POPFD", "PUSHFD", "ARPL"}
CC = {"CMOVcc", "Jcc", "SETcc", "FCMOVcc", "LOOPcc", "CMPccXADD"}
GENERIC = {"VBROADCAST", "VPBROADCAST", "VMASKMOV", "VPMASKMOV", "PMOVSX", "PMOVZX",
           "UD", "PREFETCHh", "REPNZ", "REPZ"}
TOC_NOISE = {"16", "32", "64", "n", "W", "D", "Q", "PS", "PD", "B"}


def main():
    forms_mn, texts = set(), []
    with FORMS.open(encoding="utf-8-sig") as f:
        for r in csv.DictReader(f):
            forms_mn.add(r["mnemonic"].strip())
            texts.append(r["instruction"] + " || " + r["source_cell"])
    blob = "\n".join(texts)
    blob_lower = blob.lower()

    toc = set()
    with TOC.open(encoding="utf-8-sig") as f:
        for r in csv.DictReader(f):
            for m in r["mnemonics_expanded"].split():
                toc.add(m.strip())
    toc_clean = {m for m in toc if m not in TOC_NOISE}
    only_toc = sorted(toc_clean - forms_mn)

    expected, case_variant, group_name, v_prefixed, real_missing = [], [], [], [], []
    for m in only_toc:
        if m in INVALID64 or m in CC or m in GENERIC or "[" in m or "," in m:
            expected.append(m)
            continue
        ml = re.escape(m.lower())
        if re.search(r"(?<![a-z0-9])" + ml + r"(?![a-z0-9])", blob_lower):
            case_variant.append(m)
        elif re.search(r"(?<![a-z0-9])" + ml + r"[a-z0-9]", blob_lower):
            group_name.append(m)
        elif re.search(r"(?<![a-z0-9])v" + ml + r"(?![a-z0-9])", blob_lower):
            v_prefixed.append(m)     # AVX-512 전용: 실제 니모닉은 V접두형 (PABSQ→VPABSQ)
        else:
            real_missing.append(m)

    print(f"forms 고유 니모닉: {len(forms_mn)}")
    print(f"TOC 니모닉(노이즈 제거): {len(toc_clean)}, forms 미포함: {len(only_toc)}")
    print(f"  [예상된 제외]         : {len(expected)}")
    print(f"  [대소문자만 다름]     : {len(case_variant)}  {case_variant}")
    print(f"  [그룹명-구체형 존재]  : {len(group_name)}  {group_name}")
    print(f"  [AVX-512 V접두형 존재]: {len(v_prefixed)}  {v_prefixed}")
    print(f"  [진짜 누락]           : {len(real_missing)}")
    for m in real_missing:
        print("     X", m)


if __name__ == "__main__":
    main()

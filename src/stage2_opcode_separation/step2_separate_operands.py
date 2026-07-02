"""
Stage 2 (재작성): instruction form → 오퍼랜드 분리 + r/m 확장

입력: data/stage1_extracted/instruction_forms.csv   (재작성된 Stage 1 출력)
      columns: page, layout, mnemonic, instruction, opcode, mode_support, source_cell

처리:
  1. instruction에서 니모닉을 떼어 operands 문자열을 얻는다.
       "ADC AL, imm8"  → mnemonic=ADC, operands="AL, imm8"
       "VZEROALL"      → operands=""
  2. GP 레지스터/메모리 겸용 표기 r/m<size> 를 r 버전과 m 버전으로 확장한다.
       "ADC r/m16, r16" → "ADC r16, r16" / "ADC m16, r16"
     (벡터의 xmm2/m128 같은 표기는 Stage 3 operand 후보 처리에서 다룬다.)

출력: data/stage2_opcode_split/step2_instruction_forms_split.csv
      columns: Page, Layout, Opcode, Mnemonic, Operands, Instruction, ModeSupport
"""

import csv
import re
from pathlib import Path

BASE = Path(__file__).parent.parent.parent
IN_CSV = BASE / "data" / "stage1_extracted" / "instruction_forms.csv"
OUT_CSV = BASE / "data" / "stage2_opcode_split" / "step2_instruction_forms_split.csv"

# GP r/m 표기만 확장한다 (r/m8, r/m16, r/m32, r/m64). 벡터 xmm/m128 은 제외.
RM_PATTERN = re.compile(r"\br/m(8|16|32|64)\b")


def split_mnemonic_operands(instruction: str) -> tuple[str, str]:
    parts = instruction.strip().split(None, 1)
    mnemonic = parts[0] if parts else ""
    operands = parts[1].strip() if len(parts) > 1 else ""
    return mnemonic, operands


def expand_rm(instruction: str) -> list[str]:
    """
    instruction form의 첫 r/m<size> 를 r 버전 / m 버전으로 확장.
    r/m 이 없으면 원본 그대로 반환.
    """
    if not RM_PATTERN.search(instruction):
        return [instruction]
    r_version = RM_PATTERN.sub(lambda m: "r" + m.group(1), instruction, count=1)
    m_version = RM_PATTERN.sub(lambda m: "m" + m.group(1), instruction, count=1)
    if r_version == m_version:
        return [r_version]
    return [r_version, m_version]


def main():
    OUT_CSV.parent.mkdir(parents=True, exist_ok=True)

    rows_out = []
    with IN_CSV.open(encoding="utf-8-sig") as f:
        for row in csv.DictReader(f):
            instruction = row["instruction"].strip()
            opcode = row["opcode"].strip()
            page = row["page"]
            layout = row["layout"]
            mode = row.get("mode_support", "")

            for expanded in expand_rm(instruction):
                mnemonic, operands = split_mnemonic_operands(expanded)
                rows_out.append({
                    "Page": page,
                    "Layout": layout,
                    "Opcode": opcode,
                    "Mnemonic": mnemonic,
                    "Operands": operands,
                    "Instruction": expanded,
                    "ModeSupport": mode,
                })

    with OUT_CSV.open("w", newline="", encoding="utf-8-sig") as f:
        w = csv.DictWriter(f, fieldnames=[
            "Page", "Layout", "Opcode", "Mnemonic", "Operands", "Instruction", "ModeSupport"
        ])
        w.writeheader()
        w.writerows(rows_out)

    n_in = sum(1 for _ in IN_CSV.open(encoding="utf-8-sig")) - 1
    print(f"[저장] {OUT_CSV}")
    print(f"  입력 form: {n_in} → 출력 행: {len(rows_out)} (r/m 확장 +{len(rows_out) - n_in})")
    uniq_mn = sorted({r["Mnemonic"] for r in rows_out})
    print(f"  고유 니모닉: {len(uniq_mn)}")
    # 샘플
    print("\n=== ADC 확장 샘플 ===")
    for r in rows_out:
        if r["Mnemonic"] == "ADC":
            print(f"  {r['Instruction']:28s} | ops={r['Operands']}")


if __name__ == "__main__":
    main()

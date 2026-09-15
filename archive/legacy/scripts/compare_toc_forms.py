"""Compare Mnemonic set in Stage 2 forms against the TOC instruction list.

Goal: identify mnemonics that appear in forms but are NOT in the SDM TOC,
which would indicate parsing artifacts (page headers / prose mis-extracted).
"""
import csv
import os

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TOC = os.path.join(BASE, "data", "stage1_extracted", "toc_instruction_list.csv")
FORMS = os.path.join(BASE, "data", "stage2_opcode_split", "step2_instruction_forms_split.csv")


def load_toc_mnemonics():
    toc = set()
    with open(TOC, encoding="utf-8") as f:
        r = csv.DictReader(f)
        for row in r:
            # mnemonics_expanded may contain multiple mnemonics
            for col in ("mnemonics_expanded", "mnemonic_group"):
                v = (row.get(col) or "").strip()
                if v:
                    for m in v.replace(";", ",").split(","):
                        m = m.strip().upper()
                        if m:
                            toc.add(m)
    return toc


def load_forms_mnemonics():
    counts = {}
    with open(FORMS, encoding="utf-8") as f:
        r = csv.DictReader(f)
        for row in r:
            m = (row.get("Mnemonic") or "").strip().upper()
            counts[m] = counts.get(m, 0) + 1
    return counts


def main():
    toc = load_toc_mnemonics()
    forms = load_forms_mnemonics()
    print(f"TOC mnemonics: {len(toc)}")
    print(f"Forms distinct mnemonics: {len(forms)}")

    # check the specific ones user flagged
    for probe in ("VADDPD", "AESENCWIDE256KL", "AESENC256KL"):
        print(f"  probe {probe}: in TOC={probe in toc}, forms count={forms.get(probe, 0)}")

    missing = sorted(m for m in forms if m not in toc)
    print(f"\nMnemonics in FORMS but NOT in TOC: {len(missing)}")
    total_rows = sum(forms[m] for m in missing)
    print(f"Total form rows affected: {total_rows}")
    for m in missing:
        print(f"  {m!r}  (x{forms[m]})")


if __name__ == "__main__":
    main()

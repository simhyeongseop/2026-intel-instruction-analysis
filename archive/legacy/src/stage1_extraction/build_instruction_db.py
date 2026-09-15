"""
명령어 테이블 DB + 인덱스 구축 (Q5 / STAGE3 지침 선결 조건)

목적:
  Stage 3가 "애매하면 instruction table 로 돌아가 description 을 확인"할 수 있도록,
  각 명령어의 (a) 위치 인덱스, (b) SDM Description 섹션 텍스트를 조회 가능한 DB로 만든다.

입력:
  data/stage1_extracted/instruction_forms.csv   (page 컬럼 보유 → 니모닉↔페이지)
  325383-090-sdm-vol-2abcd.pdf                   (Description 텍스트 원본)

출력:
  data/instruction_db/instruction_index.csv      (mnemonic, page, layout, n_forms)
  data/instruction_db/instruction_descriptions.csv (page, heading, description)

방식:
  - forms 에서 니모닉↔페이지 인덱스를 만든다(전수 스캔 불필요).
  - forms 에 등장하는 고유 페이지들만 PDF에서 텍스트를 떠서, 각 페이지(및 연속 1~2p)의
    "Description" 섹션(헤더 'Description' ~ 다음 섹션 'Operation'/'Flags Affected'/...)을 추출.
"""

import csv
import re
from collections import defaultdict
from pathlib import Path
import pdfplumber

BASE = Path(__file__).parent.parent.parent
FORMS = BASE / "data" / "stage1_extracted" / "instruction_forms.csv"
PDF = BASE / "325383-090-sdm-vol-2abcd.pdf"
OUT_DIR = BASE / "data" / "instruction_db"

# Description 섹션의 끝을 알리는 다음 섹션 헤더들
STOP_HEADERS = re.compile(
    r"^(Operation|Flags Affected|Intel C/C\+\+|SIMD Floating-Point Exceptions|"
    r"Exceptions|Protected Mode Exceptions|Compatibility Mode Exceptions|"
    r"64-Bit Mode Exceptions|Real-Address Mode Exceptions|Virtual-8086|"
    r"Other Exceptions|Description of|Affected Flags)",
    re.IGNORECASE,
)


def extract_description(page_texts: list[str]) -> str:
    """연속 페이지 텍스트 목록에서 첫 'Description' 섹션을 추출."""
    joined = "\n".join(page_texts)
    lines = joined.splitlines()
    out, capturing = [], False
    for ln in lines:
        s = ln.strip()
        if not capturing:
            if s == "Description" or s.lower() == "description":
                capturing = True
            continue
        if STOP_HEADERS.match(s):
            break
        out.append(s)
    text = " ".join(x for x in out if x)
    text = re.sub(r"\s+", " ", text).strip()
    return text[:2000]


def main():
    OUT_DIR.mkdir(parents=True, exist_ok=True)

    # 1) 인덱스 (forms 활용)
    mnem_pages = defaultdict(lambda: defaultdict(int))   # mnemonic -> page -> count
    page_layout = {}
    with FORMS.open(encoding="utf-8-sig") as f:
        for r in csv.DictReader(f):
            p = int(r["page"])
            mnem_pages[r["mnemonic"]][p] += 1
            page_layout[p] = r["layout"]

    index_rows = []
    for mnem in sorted(mnem_pages):
        for p in sorted(mnem_pages[mnem]):
            index_rows.append({"mnemonic": mnem, "page": p,
                               "layout": page_layout.get(p, ""),
                               "n_forms": mnem_pages[mnem][p]})
    with (OUT_DIR / "instruction_index.csv").open("w", newline="", encoding="utf-8-sig") as f:
        w = csv.DictWriter(f, fieldnames=["mnemonic", "page", "layout", "n_forms"])
        w.writeheader(); w.writerows(index_rows)

    # 2) Description (고유 페이지만)
    pages = sorted({p for m in mnem_pages.values() for p in m})
    print(f"[인덱스] 니모닉 {len(mnem_pages)}개, 고유 페이지 {len(pages)}개")

    desc_rows = []
    with pdfplumber.open(str(PDF)) as pdf:
        n = len(pdf.pages)
        cache = {}
        def ptext(i):
            if i not in cache:
                cache[i] = (pdf.pages[i].extract_text() or "") if 0 <= i < n else ""
            return cache[i]
        for k, p in enumerate(pages):
            heading = (ptext(p).splitlines() or [""])[0].strip()
            desc = extract_description([ptext(p), ptext(p + 1), ptext(p + 2)])
            desc_rows.append({"page": p, "heading": heading[:120], "description": desc})
            if k % 200 == 0:
                print(f"  ...desc {k}/{len(pages)}")

    with (OUT_DIR / "instruction_descriptions.csv").open("w", newline="", encoding="utf-8-sig") as f:
        w = csv.DictWriter(f, fieldnames=["page", "heading", "description"])
        w.writeheader(); w.writerows(desc_rows)

    got = sum(1 for r in desc_rows if r["description"])
    print(f"[저장] {OUT_DIR}")
    print(f"  instruction_index.csv: {len(index_rows)}행")
    print(f"  instruction_descriptions.csv: {len(desc_rows)}페이지 (description 확보 {got})")
    # 샘플
    for r in desc_rows[:3]:
        print(f"\n  p{r['page']} {r['heading'][:50]}\n    {r['description'][:160]}")


if __name__ == "__main__":
    main()

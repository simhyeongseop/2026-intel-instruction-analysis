"""
Stage 1 (사전 단계): Intel SDM Vol.2 목차(Table of Contents)에서
instruction 참조 항목 전체 목록을 추출한다.

목적
----
기존 Stage 1(`extract_intel_instructions.py`)은 명령어 인코딩 표를 직접
파싱하는데, 벡터(VEX/EVEX) 명령어 표는 레이아웃이 달라 통째로 누락됐다.
그 검증(ground truth)을 위해, 목차에 나열된 "우리가 뽑아야 할 명령어 전체
목록"을 먼저 확보한다.

목차 항목 형식
--------------
    MNEMONIC—Full Description . . . . . . . . 3-31

- em-dash(— U+2014, 드물게 – U+2013)가 니모닉과 설명을 구분한다.
- 여러 니모닉이 한 항목에 묶이기도 한다: "SAL/SAR/SHL/SHR—Shift"
- 압축 표기도 있다: "VF[,N]MADD[132,213,231]PH—..."
- 설명이 다음 줄로 넘어가는 경우가 있으나, 우리는 em-dash 앞부분(니모닉)만
  사용하므로 줄바꿈 영향이 없다.

출력
----
    data/stage1_extracted/toc_instruction_list.csv
      columns: chapter, mnemonic_group, description, mnemonics_expanded
"""

import re
import csv
from pathlib import Path
import pdfplumber

BASE = Path(__file__).parent.parent.parent
PDF = BASE / "325383-090-sdm-vol-2abcd.pdf"
OUT_CSV = BASE / "data" / "stage1_extracted" / "toc_instruction_list.csv"

# 목차에서 instruction 참조가 나오는 페이지 범위(0-indexed).
# AAA/AAD가 page 3에 있으므로 3부터 시작한다.
# 이후 FIGURES/TABLES/APPENDIX 목차는 제외한다.
TOC_PAGE_START = 3
TOC_PAGE_END = 20  # inclusive, FIGURES 목차(21)는 제외

# em-dash 계열 구분자 (하이픈 '-'은 니모닉/설명에 쓰이므로 제외)
DASH = "\u2014\u2013"  # — –

# 니모닉 그룹으로 인정할 좌측 문자열 패턴.
# 대문자로 시작, 대문자/소문자/숫자/'/'/대괄호/쉼표/공백/'-'만 허용.
# 소문자는 Jcc/CMOVcc/SETcc/LOOPcc, PREFETCHh 같은 placeholder 때문에 허용하되,
# 아래 looks_like_mnemonic_group()에서 '소문자 3연속(=영어 단어)'을 배제한다.
MNEMONIC_GROUP_RE = re.compile(r"^[A-Z][A-Za-z0-9/\[\],.\- ]*$")

# 설명 연속 줄(영어 단어)을 걸러내기 위한 패턴: 소문자 3자 이상 연속
ENGLISH_WORD_RE = re.compile(r"[a-z]{3,}")

# 명백히 instruction이 아닌 목차 라인(섹션/그림/표/챕터 등) 접두어
SKIP_PREFIXES = (
    "FIGURE", "TABLE", "CHAPTER", "APPENDIX", "CONTENTS", "PAGE",
    "SECTION", "EXAMPLE",
)

# 챕터 → 알파벳 구간 라벨
CHAPTER_LABEL = {
    3: "A-L", 4: "M-U", 5: "V (AVX/AVX-512)",
    6: "W-Z", 7: "Safer Mode (GETSEC)", 8: "Xeon Phi",
}


def detect_chapter(text: str, current: int) -> int:
    """페이지 텍스트에서 'CHAPTER n' 마커를 보고 현재 챕터를 갱신."""
    m = re.search(r"CHAPTER\s+(\d+)", text)
    if m:
        return int(m.group(1))
    return current


def clean_mnemonic_group(left: str) -> str:
    """좌측(니모닉) 문자열 정리: 앞뒤 공백/잔여 점 제거."""
    left = left.strip()
    left = re.sub(r"\s{2,}", " ", left)
    return left.strip(" .")


def looks_like_mnemonic_group(left: str) -> bool:
    """좌측 문자열이 니모닉 그룹인지 판정."""
    if not left or len(left) > 90:
        return False
    if left.upper().startswith(SKIP_PREFIXES):
        return False
    # 소문자로 시작하는 설명 연속 줄 등은 제외 (MNEMONIC_GROUP_RE가 걸러줌)
    if not MNEMONIC_GROUP_RE.match(left):
        return False
    # 영어 단어(소문자 3연속)가 있으면 설명 연속 줄로 간주하고 제외.
    # 단, Jcc/CMOVcc/SETcc/LOOPcc('cc'), PREFETCHh('h')처럼 짧은 소문자
    # placeholder는 통과한다.
    if ENGLISH_WORD_RE.search(left):
        return False
    # 최소 하나의 알파벳 대문자 포함
    return bool(re.search(r"[A-Z]", left))


def expand_group(group: str) -> list[str]:
    """
    'SAL/SAR/SHL/SHR' → ['SAL','SAR','SHL','SHR']
    '/'로만 분리한다. 대괄호 압축 표기(VF[,N]MADD[...])는 그대로 1개로 둔다.
    """
    if "[" in group or "]" in group:
        return [group]
    parts = [p.strip() for p in group.split("/") if p.strip()]
    return parts or [group]


def extract_toc() -> list[dict]:
    rows: list[dict] = []
    seen_groups: set[str] = set()
    current_chapter = 3

    with pdfplumber.open(str(PDF)) as pdf:
        for pno in range(TOC_PAGE_START, TOC_PAGE_END + 1):
            text = pdf.pages[pno].extract_text() or ""
            if "FIGURES" in text[:300] or "TABLES" in text[:300]:
                break
            current_chapter = detect_chapter(text, current_chapter)

            for raw in text.splitlines():
                line = raw.strip()
                if not line:
                    continue
                # em-dash 구분자가 있어야 instruction 항목
                m = re.search(f"[{DASH}]", line)
                if not m:
                    continue

                left = line[: m.start()]
                right = line[m.end():]

                group = clean_mnemonic_group(left)
                if not looks_like_mnemonic_group(group):
                    continue

                if group in seen_groups:
                    continue
                seen_groups.add(group)

                # 설명에서 점선(dot leader)과 뒤따르는 페이지 번호를 제거한다.
                # 예: "Cache Line Write Back . . . . 3-154" → "Cache Line Write Back"
                description = re.split(r"\s*(?:\.\s*){2,}", right)[0].strip()
                expanded = expand_group(group)

                rows.append({
                    "chapter": f"{current_chapter} ({CHAPTER_LABEL.get(current_chapter, '?')})",
                    "mnemonic_group": group,
                    "description": description,
                    "mnemonics_expanded": " ".join(expanded),
                })

    return rows


def main():
    OUT_CSV.parent.mkdir(parents=True, exist_ok=True)
    rows = extract_toc()

    with OUT_CSV.open("w", newline="", encoding="utf-8-sig") as f:
        writer = csv.DictWriter(
            f, fieldnames=["chapter", "mnemonic_group", "description", "mnemonics_expanded"]
        )
        writer.writeheader()
        writer.writerows(rows)

    # 개별 니모닉 총합
    all_mnemonics: set[str] = set()
    for r in rows:
        for mn in r["mnemonics_expanded"].split():
            all_mnemonics.add(mn)

    print(f"[저장] {OUT_CSV}")
    print(f"  목차 항목(그룹) 수: {len(rows)}")
    print(f"  개별 니모닉 수(‘/’ 확장, 대괄호 표기는 1개 취급): {len(all_mnemonics)}")

    # 챕터별 분포
    from collections import Counter
    chap = Counter(r["chapter"] for r in rows)
    print("\n=== 챕터별 항목 수 ===")
    for k in sorted(chap):
        print(f"  {k:24s}: {chap[k]}")

    # V로 시작하는 벡터 명령어 개수(누락 검증 핵심)
    v_groups = [r["mnemonic_group"] for r in rows if r["mnemonic_group"].startswith("V")]
    print(f"\n  V로 시작하는 그룹 수: {len(v_groups)} (예: {v_groups[:3]})")

    print("\n=== 앞 10개 ===")
    for r in rows[:10]:
        print(f"  [{r['chapter']:8s}] {r['mnemonic_group']}")
    print("=== 뒤 10개 ===")
    for r in rows[-10:]:
        print(f"  [{r['chapter']:8s}] {r['mnemonic_group']}")


if __name__ == "__main__":
    main()

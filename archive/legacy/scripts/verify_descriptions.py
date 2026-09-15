"""
Stage 3 검증 — SDM description(DB) 대조.

목적
----
1. 설명문에서 아키텍처 제약(#UD 조건, 레지스터 distinctness, opmask/broadcast 제약)을
   체계적으로 추출 → 음성셋(N1/N2)의 근거를 DB로 재확인하고 확장 후보(N3–N8) 목록화.
2. 양성 base 생성물(step3_coverage.csv, variant_axis=base)이 문서화된 #UD/distinctness
   제약을 위반하지 않는지 대조.

입력
----
  data/instruction_db/instruction_index.csv        (mnemonic → page)
  data/instruction_db/instruction_descriptions.csv (page → heading, description)
  data/stage3_operands/step3_coverage.csv          (생성물)

출력
----
  data/stage3_operands/step3_constraint_inventory.csv   (제약 인벤토리)
  콘솔: 양성 세트 대조 요약
"""
import csv
import re
from pathlib import Path

BASE = Path(__file__).parent.parent
DB = BASE / "data" / "instruction_db"
COV = BASE / "data" / "stage3_operands" / "step3_coverage.csv"
OUT = BASE / "data" / "stage3_operands" / "step3_constraint_inventory.csv"

# 제약 유형 → 근거 문장을 찾는 정규식 (SDM 설명문 관용 표현)
# 주의: DB의 description은 '도입부 문단'만 담고 Operation/Exceptions 섹션은 미포함(Stage 1
# 추출 한계). 따라서 gather류 "#UD if any pair ... same"은 DB에 없다 → reg_distinct는
# UD 신호와 'same'이 한 문장에 동시 출현할 때만 인정(서술적 'same as' 오탐 배제).
CONSTRAINT_PATTERNS = {
    "reg_distinct": re.compile(
        r"(?=.*\bsame\b)(?=.*(?:#ud|ud fault|invalid[- ]opcode)).*", re.I),
    "mask_k0": re.compile(r"(k0[^.]*(?:can(?:not)?|must|not)[^.]*|aaa[^.]*000[^.]*)", re.I),
    "mask_lowbit": re.compile(r"(low bit[^.]*mask[^.]*|masked off[^.]*)", re.I),
    "evex_b": re.compile(r"(evex\.b must be 0[^.]*|embedded (?:rounding|broadcast)[^.]*)", re.I),
    "ud_generic": re.compile(r"(#ud|ud fault|invalid[- ]opcode)", re.I),
}


def split_sentences(text):
    return re.split(r"(?<=[.)])\s+", text)


def load_mnem_pages():
    m2p = {}
    with (DB / "instruction_index.csv").open(encoding="utf-8-sig") as f:
        for r in csv.DictReader(f):
            m2p.setdefault(r["mnemonic"].strip().upper(), r["page"].strip())
    return m2p


def load_descriptions():
    p2d = {}
    with (DB / "instruction_descriptions.csv").open(encoding="utf-8-sig") as f:
        for r in csv.DictReader(f):
            p2d[r["page"].strip()] = (r["heading"], r["description"])
    return p2d


def main():
    m2p = load_mnem_pages()
    p2d = load_descriptions()

    # 1) 제약 인벤토리 추출
    inventory = []           # (mnemonic, page, heading, ctype, evidence)
    per_mnem_types = {}      # mnemonic -> set(ctype)
    for mnem, page in m2p.items():
        desc = p2d.get(page)
        if not desc:
            continue
        heading, text = desc
        for sent in split_sentences(text):
            for ctype, pat in CONSTRAINT_PATTERNS.items():
                if pat.search(sent):
                    ev = re.sub(r"\s+", " ", sent).strip()[:300]
                    inventory.append((mnem, page, heading, ctype, ev))
                    per_mnem_types.setdefault(mnem, set()).add(ctype)

    with OUT.open("w", newline="", encoding="utf-8-sig") as f:
        w = csv.writer(f)
        w.writerow(["mnemonic", "page", "heading", "constraint_type", "evidence"])
        w.writerows(sorted(inventory))

    # 유형별 명령 수 집계
    from collections import Counter
    ctype_mnems = Counter()
    for types in per_mnem_types.values():
        for t in types:
            ctype_mnems[t] += 1
    print(f"[제약 인벤토리] {OUT}")
    print(f"  근거 문장 {len(inventory)}건, 제약 보유 명령 {len(per_mnem_types)}개")
    for t, n in ctype_mnems.most_common():
        print(f"    {t:14} : {n:3d} 명령")

    # 2) 양성 base 세트 대조 — distinctness 제약 명령이 base에서 어떻게 생성됐는지
    base_rows = []
    with COV.open(encoding="utf-8-sig") as f:
        for r in csv.DictReader(f):
            if r.get("variant_axis") == "base" and r["Mappable"] == "True":
                base_rows.append(r)

    distinct_mnems = {m for m, ts in per_mnem_types.items() if "reg_distinct" in ts}
    print(f"\n[양성 세트 대조] reg_distinct 제약 명령 {len(distinct_mnems)}개 중 base 생성물 점검")
    flagged = []
    for r in base_rows:
        mnem = r["Mnemonic"].strip().upper()
        if mnem not in distinct_mnems:
            continue
        gen = r["Generated"]
        # 생성물에서 벡터/인덱스 레지스터 추출 후 중복(aliasing) 여부 검사
        regs = re.findall(r"\b([xyz]mm\d+)\b", gen)
        idx = re.findall(r"\[[^\]]*?([xyz]mm\d+)[^\]]*?\]", gen)  # VSIB index
        allregs = regs
        dup = len(allregs) != len(set(allregs))
        if dup:
            flagged.append((mnem, gen))
    if flagged:
        print(f"  ⚠ aliasing 의심 base 생성물 {len(flagged)}건 (문서화된 distinctness 위반 가능):")
        for m, g in flagged[:20]:
            print(f"    {m:14} {g}")
    else:
        print("  ✓ distinctness 제약 명령의 base 생성물에서 벡터 레지스터 aliasing 미검출")

    # 3) gather(VSIB) distinctness 전용 검사 — N1의 근거는 SDM PDF(Operation/Exceptions)라
    #    DB 도입부엔 없지만, 양성 base가 dest≠index≠mask 를 지키는지는 독립 검증한다.
    vsib_re = re.compile(r"\[[^\]]*?([xyz]mm\d+)[^\]]*?\]")
    reg_re = re.compile(r"\b([xyz]mm\d+)\b")
    gather_checked = gather_alias = 0
    for r in base_rows:
        gen = r["Generated"]
        idx = vsib_re.findall(gen)
        if not idx:                         # VSIB(gather/scatter)만
            continue
        gather_checked += 1
        allregs = reg_re.findall(gen)       # dest, index, (mask) 전부
        if len(allregs) != len(set(allregs)):
            gather_alias += 1
    print(f"\n[gather VSIB distinctness] base 중 VSIB form {gather_checked}건 점검 → "
          f"aliasing {gather_alias}건")
    if gather_alias == 0:
        print("  ✓ 모든 gather 양성 생성물이 dest≠index≠mask 유지 (N1으로 정상 분리됨)")


if __name__ == "__main__":
    main()

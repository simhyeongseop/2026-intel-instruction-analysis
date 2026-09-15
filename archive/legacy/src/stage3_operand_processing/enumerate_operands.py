"""
Stage 3 준비: Stage 2 결과에서 등장하는 모든 오퍼랜드 토큰을 전수 집계한다.
(어떤 오퍼랜드 타입을 매핑해야 하는지 데이터로 파악 — 추측 배제)
"""
import csv
import re
from collections import Counter
from pathlib import Path

BASE = Path(__file__).parent.parent.parent
IN_CSV = BASE / "data" / "stage2_opcode_split" / "step2_instruction_forms_split.csv"


def tokenize_operands(operands: str) -> list[str]:
    """콤마로 분리. 각 오퍼랜드의 마스크/브로드캐스트 표기는 유지한 채 반환."""
    if not operands:
        return []
    return [t.strip() for t in operands.split(",") if t.strip()]


def main():
    counter = Counter()
    with IN_CSV.open(encoding="utf-8-sig") as f:
        for row in csv.DictReader(f):
            for tok in tokenize_operands(row["Operands"]):
                counter[tok] += 1

    print(f"고유 오퍼랜드 토큰 수: {len(counter)}")
    print(f"총 오퍼랜드 등장 수: {sum(counter.values())}")
    print("\n=== 빈도순 전체 목록 ===")
    for tok, cnt in counter.most_common():
        print(f"  {cnt:5d}  {tok}")


if __name__ == "__main__":
    main()

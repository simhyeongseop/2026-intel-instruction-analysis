"""저장된 5단계 관측에 원본 Intel 소스와 마지막 Intel 출력 비교를 덧붙인다.

문자열 비교만 수행한다. 명령 동등성은 5단계 insn_match 판정을 사용한다.
"""

import argparse
import collections
import csv
import hashlib
import json
import re
from pathlib import Path


DEFAULT_INPUT = Path("out/roundtrip_20261103_intel64/roundtrip_results.csv")
DEFAULT_OUTPUT = Path("out/roundtrip_source_compare_20261105")


def text_key(value):
    """대소문자와 구두점 주변 공백만 흡수하고 오퍼랜드·접두어는 보존한다."""
    value = re.sub(r"\s*([,\[\]+*])\s*", r"\1", value.casefold())
    return " ".join(value.split())


def compare(row, syntax):
    verdict = row["verdict_" + syntax]
    if verdict in ("분기 대상 미대조", "역어셈블 실패", "재배치 생김", "재조립 거부"):
        return "미대조", ""
    if row["byte_match_" + syntax] == "예":
        final_intel = row["intel"]
    else:
        final_intel = row["again_intel_" + syntax]
    if not final_intel:
        return "미대조", ""
    return ("문자열 같음" if text_key(row["source"]) == text_key(final_intel)
            else "문자열 다름"), final_intel


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--input", type=Path, default=DEFAULT_INPUT)
    parser.add_argument("--out", type=Path, default=DEFAULT_OUTPUT)
    args = parser.parse_args()
    with args.input.open(encoding="utf-8-sig", newline="") as handle:
        rows = list(csv.DictReader(handle))
    output = []
    summary = {}
    for row in rows:
        enriched = dict(row)
        for syntax in ("att", "intel"):
            status, final_intel = compare(row, syntax)
            enriched["source_match_" + syntax] = status
            enriched["final_intel_" + syntax] = final_intel
        output.append(enriched)
    for family in ("gnu", "llvm"):
        mine = [r for r in output if r["family"] == family]
        summary[family] = {
            syntax: dict(collections.Counter(r["source_match_" + syntax] for r in mine))
            for syntax in ("att", "intel")
        }
    args.out.mkdir(parents=True, exist_ok=True)
    with (args.out / "source_compare.csv").open("w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(output[0]))
        writer.writeheader()
        writer.writerows(output)
    manifest = {
        "source_snapshot": str(args.input),
        "source_sha256": hashlib.sha256(args.input.read_bytes()).hexdigest(),
        "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "scope": "저장된 5단계 결과의 수용 케이스; 도구 재실행 없음",
        "comparison": "원본 Intel 소스와 최종 Intel 역어셈블 문자열; 대소문자·구두점 주변 공백만 무시",
        "limitations": [
            "문자열 다름은 명령 또는 CPU 의미가 다름을 뜻하지 않음",
            "바이트 같음이면 최초 Intel 출력이 마지막 Intel 출력과 같다고 추론",
            "분기 대상·재배치·역어셈블 실패·재조립 거부는 미대조",
        ],
        "summary": summary,
    }
    (args.out / "manifest.json").write_text(json.dumps(manifest, ensure_ascii=False, indent=2), encoding="utf-8")
    print(json.dumps(summary, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()

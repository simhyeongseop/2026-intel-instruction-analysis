"""
9단계 clang_compare: out/asm_result.csv(as) vs out/clang_result.csv(clang) 비교.

8회 미팅 후속 과제 1번(Clang 확장 비교)의 두 번째 절반. combo_id 기준으로 두
어셈블러의 성공/실패를 맞대보고, 둘 다 성공한 경우엔 objdump 역어셈블 텍스트로
바이트 인코딩까지 비교한다.

카테고리 5가지:
  both_reject          - as/clang 둘 다 거부
  as_only              - as만 성공, clang은 거부
  clang_only           - clang만 성공, as는 거부
  both_ok_same_bytes   - 둘 다 성공, 인코딩(objdump 역어셈블 텍스트)도 같음
  both_ok_diff_bytes   - 둘 다 성공, 그런데 인코딩이 다름 (진짜 흥미로운 대상)

CLAUDE.md 1절/6절 원칙: "차이 ≠ 버그". as/clang이 다르게 처리한다고 바로
버그라고 쓰지 않는다. 여기서는 분류·근거 수집까지만 하고, "이게 SDM 위반
후보인지"는 사람(triage 대화)이나 이후 라운드에서 SDM 원문 대조로 판단한다.

주의(codex 검증 1차에서 지적받아 수정): 처음 버전은 objdump 역어셈블 "텍스트"만
비교해서 same/diff를 판정했다. 텍스트가 같아도 바이트가 다를 수 있고(예: 같은
니모닉인데 prefix만 다른 경우), objdump 파싱이 양쪽 다 실패하면 빈 문자열끼리
"같음"으로 오판정될 위험도 있었다. 지금은 각 파일당 정확히 명령어 1개만 들어있는
구조(generator가 combo 1개 = 파일 1개로 생성)를 이용해, 그 파일의 모든 hex byte
컬럼(줄바꿈된 continuation 줄 포함)을 통째로 이어붙여 "바이트 문자열"로 비교한다.
파싱 결과가 비어 있으면(objdump가 그 파일을 못 읽었거나 출력이 없으면) 명시적으로
parse_error 취급하고 "같음"으로 넘어가지 않는다.
"""

import argparse
import csv
import os
import re
import subprocess

AS_CSV = "out/asm_result.csv"
CLANG_CSV = "out/clang_result.csv"
OUT_CSV = "out/clang_compare.csv"
OUT_REPORT = "out/clang_compare_report.md"

FILE_HEADER_RE = re.compile(r"^(.+):\s+file format")
BATCH_SIZE = 500
# objdump -d 한 줄: "   0:\t67 66 ff 18 \tcall   DWORD PTR [eax]" (mnemonic 없는
# continuation 줄은 세 번째 탭 필드가 없다 — 그래도 바이트는 이어붙여야 한다).
OFFSET_LINE_RE = re.compile(r"^\s*[0-9a-f]+:\t")


def read_csv_by_combo_id(path):
    rows_by_id = {}
    with open(path, encoding="utf-8") as f:
        for row in csv.DictReader(f):
            rows_by_id[row["combo_id"]] = row
    return rows_by_id


def parse_objdump_output(text):
    """파일별로 (마지막 mnemonic 텍스트, 이어붙인 hex byte 문자열)을 반환한다.

    각 대상 .o 파일에는 명령어가 정확히 1개뿐이므로(m4/m8이 combo 1개당 파일 1개로
    생성), 그 파일 블록 안의 모든 hex byte 컬럼을 순서대로 이어붙이면 그 한 명령어의
    전체 바이트가 된다 — 여러 명령어가 섞일 위험이 없다.
    """
    disasm_by_path = {}
    bytes_by_path = {}
    current_path = None
    for line in text.splitlines():
        header = FILE_HEADER_RE.match(line)
        if header:
            current_path = header.group(1)
            continue
        if current_path is None:
            continue
        if not OFFSET_LINE_RE.match(line):
            continue
        parts = line.split("\t")
        if len(parts) >= 2:
            hex_chunk = parts[1].strip()
            if hex_chunk:
                bytes_by_path[current_path] = bytes_by_path.get(current_path, "") + hex_chunk.replace(" ", "")
        if len(parts) >= 3 and parts[2].strip():
            disasm_by_path[current_path] = parts[2].strip()
    return disasm_by_path, bytes_by_path


def run_objdump(object_paths, display_syntax='intel'):
    if not object_paths:
        return {}, {}
    disasm_by_path, bytes_by_path = {}, {}
    for start in range(0, len(object_paths), BATCH_SIZE):
        batch = object_paths[start:start + BATCH_SIZE]
        result = subprocess.run(
            ["objdump", "-d", "-M", display_syntax] + batch,
            capture_output=True, text=True, timeout=180,
        )
        disasm, raw_bytes = parse_objdump_output(result.stdout)
        disasm_by_path.update(disasm)
        bytes_by_path.update(raw_bytes)
    return disasm_by_path, bytes_by_path


def normalize(text):
    """m6_roundtrip.py의 normalize()와 동일 (공백/대소문자만 흡수)."""
    text = text.lower().strip()
    text = re.sub(r"\s*,\s*", ",", text)
    text = re.sub(r"\s+", " ", text)
    return text


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--display-syntax', choices=('intel', 'att'), default='intel')
    parser.add_argument('--output', type=str)
    parser.add_argument('--report', type=str)
    args = parser.parse_args()
    as_rows = read_csv_by_combo_id(AS_CSV)
    clang_rows = read_csv_by_combo_id(CLANG_CSV)

    combo_ids = sorted(set(as_rows) | set(clang_rows), key=lambda x: int(x))

    # 둘 다 성공한 것만 objdump 대상으로 모아서 한 번에 배치 실행 (m6 방식, 속도).
    both_ok_ids = []
    for combo_id in combo_ids:
        as_row = as_rows.get(combo_id)
        clang_row = clang_rows.get(combo_id)
        if as_row and clang_row and as_row["actual_result"] == "ok" and clang_row["actual_result"] == "ok":
            both_ok_ids.append(combo_id)

    as_paths = [as_rows[cid]["object_file_path"] for cid in both_ok_ids]
    clang_paths = [clang_rows[cid]["object_file_path"] for cid in both_ok_ids]
    as_disasm, as_bytes = run_objdump(as_paths, args.display_syntax)
    clang_disasm, clang_bytes = run_objdump(clang_paths, args.display_syntax)

    counts = {
        "both_reject": 0, "as_only": 0, "clang_only": 0,
        "both_ok_same_bytes": 0, "both_ok_diff_bytes": 0, "parse_error": 0,
    }
    out_rows = []
    diff_examples = []

    for combo_id in combo_ids:
        as_row = as_rows.get(combo_id)
        clang_row = clang_rows.get(combo_id)
        # 두 산출물의 소스가 같은 out/tests.s라 combo_id 집합은 항상 일치해야 하지만,
        # 만약 한쪽에만 있으면(재실행 시점 불일치 등) 그 자체를 알 수 있게 남겨둔다.
        as_ok = bool(as_row) and as_row["actual_result"] == "ok"
        clang_ok = bool(clang_row) and clang_row["actual_result"] == "ok"

        as_objdump_line = as_disasm.get(as_row["object_file_path"], "") if as_ok else ""
        clang_objdump_line = clang_disasm.get(clang_row["object_file_path"], "") if clang_ok else ""
        as_byte_str = as_bytes.get(as_row["object_file_path"], "") if as_ok else ""
        clang_byte_str = clang_bytes.get(clang_row["object_file_path"], "") if clang_ok else ""

        if as_ok and clang_ok:
            if not as_byte_str or not clang_byte_str:
                # objdump가 이 파일 블록에서 바이트를 하나도 못 뽑았으면 "같다"고
                # 조용히 넘기지 않고 별도 카테고리로 남긴다 (codex 검증 1차 지적사항).
                category = "parse_error"
            else:
                category = "both_ok_same_bytes" if as_byte_str == clang_byte_str else "both_ok_diff_bytes"
        elif as_ok and not clang_ok:
            category = "as_only"
        elif clang_ok and not as_ok:
            category = "clang_only"
        else:
            category = "both_reject"
        counts[category] += 1

        ref_row = as_row or clang_row
        out_row = {
            "combo_id": combo_id,
            "row_id": ref_row["row_id"],
            "mnemonic": ref_row["mnemonic"],
            "expected_valid": ref_row["expected_valid"],
            "mode_support": ref_row["mode_support"],
            "asm_line": ref_row["asm_line"],
            "as_result": as_row["actual_result"] if as_row else "missing",
            "clang_result": clang_row["actual_result"] if clang_row else "missing",
            "category": category,
            "as_bytes": as_byte_str,
            "clang_bytes": clang_byte_str,
            "as_objdump": as_objdump_line,
            "clang_objdump": clang_objdump_line,
            "as_error": as_row["error_message"] if as_row and not as_ok else "",
            "clang_error": clang_row["error_message"] if clang_row and not clang_ok else "",
            "display_syntax": args.display_syntax,
        }
        out_rows.append(out_row)
        if category == "both_ok_diff_bytes" and len(diff_examples) < 30:
            diff_examples.append(out_row)

    fieldnames = [
        "combo_id", "row_id", "mnemonic", "expected_valid", "mode_support",
        "asm_line", "as_result", "clang_result", "category",
        "as_bytes", "clang_bytes", "as_objdump", "clang_objdump", "as_error", "clang_error", "display_syntax",
    ]
    output = args.output or (OUT_CSV if args.display_syntax == 'intel' else
                             OUT_CSV.replace('.csv', '_%s.csv' % args.display_syntax))
    os.makedirs(os.path.dirname(output) or '.', exist_ok=True)
    with open(output, "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(out_rows)

    output_report = args.report or (OUT_REPORT if args.display_syntax == 'intel' else OUT_REPORT.replace('.md', '_%s.md' % args.display_syntax))
    os.makedirs(os.path.dirname(output_report) or '.', exist_ok=True)
    write_report(counts, out_rows, diff_examples, output_report)

    print(f"대상 combo_id 수: {len(combo_ids)}")
    for key, value in counts.items():
        print(f"  {key}: {value}")
    print(f"출력: {output}, {output_report}")


def write_report(counts, out_rows, diff_examples, output_report=OUT_REPORT):
    lines = []
    lines.append("# Clang vs GNU as 비교 (9단계 clang_compare)\n")
    lines.append("as = GNU as (기존 5단계 assembler), clang = clang 통합 어셈블러(8단계).")
    lines.append("둘 다 같은 out/tests.s를 한 줄씩 개별 어셈블한 결과를 combo_id로 맞댄 것이다.\n")
    lines.append("**원칙(CLAUDE.md 6절): 차이 ≠ 버그.** 아래 분류는 사실 확인까지만이고,")
    lines.append("SDM 위반 여부 판단은 별도로 원문 대조가 필요하다.\n")

    lines.append("## 카테고리별 건수\n")
    lines.append("| 카테고리 | 건수 | 의미 |")
    lines.append("|---|---|---|")
    meaning = {
        "both_reject": "as/clang 둘 다 거부",
        "as_only": "as만 성공, clang은 거부",
        "clang_only": "clang만 성공, as는 거부",
        "both_ok_same_bytes": "둘 다 성공, 바이트(hex) 인코딩이 완전히 같음",
        "both_ok_diff_bytes": "둘 다 성공, 바이트 인코딩이 다름",
        "parse_error": "둘 다 성공했다고 나왔는데 objdump가 바이트를 못 뽑음 (조사 필요)",
    }
    for key in ["both_ok_same_bytes", "both_ok_diff_bytes", "as_only", "clang_only", "both_reject", "parse_error"]:
        lines.append(f"| {key} | {counts[key]} | {meaning[key]} |")
    lines.append("")

    def category_rows(category, limit):
        return [r for r in out_rows if r["category"] == category][:limit]

    lines.append("## both_ok_diff_bytes 사례 (최대 30건)\n")
    lines.append("as와 clang이 둘 다 받아줬는데 실제 바이트(hex)가 다름 — 이 카테고리가")
    lines.append("가장 흥미로운 대상이다. `note`는 이 라운드에서 직접 objdump/코드로 확인한 것만 채움.\n")
    lines.append("| combo_id | mnemonic | asm_line | as_bytes | clang_bytes | as_objdump | clang_objdump |")
    lines.append("|---|---|---|---|---|---|---|")
    for row in diff_examples:
        lines.append(f"| {row['combo_id']} | {row['mnemonic']} | `{row['asm_line']}` | `{row['as_bytes']}` | `{row['clang_bytes']}` | `{row['as_objdump']}` | `{row['clang_objdump']}` |")
    lines.append("")

    lines.append("## as_only 사례 (최대 15건)\n")
    lines.append("| combo_id | mnemonic | asm_line | expected_valid | clang_error |")
    lines.append("|---|---|---|---|---|")
    for row in category_rows("as_only", 15):
        lines.append(f"| {row['combo_id']} | {row['mnemonic']} | `{row['asm_line']}` | {row['expected_valid']} | {row['clang_error'][:120]} |")
    lines.append("")

    lines.append("## clang_only 사례 (최대 15건)\n")
    lines.append("| combo_id | mnemonic | asm_line | expected_valid | as_error |")
    lines.append("|---|---|---|---|---|")
    for row in category_rows("clang_only", 15):
        lines.append(f"| {row['combo_id']} | {row['mnemonic']} | `{row['asm_line']}` | {row['expected_valid']} | {row['as_error'][:120]} |")
    lines.append("")

    with open(output_report, "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + "\n")


if __name__ == "__main__":
    main()

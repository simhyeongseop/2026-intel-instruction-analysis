"""
10단계 reassemble_check: roundtrip(6단계)에서 "different"로 나온 줄들에 대해,
objdump가 보여준 역어셈블 텍스트를 "다시 어셈블"해서 원본과 바이트가 실제로
같은지 확인한다.

8회 미팅 후속 과제 2번(objdump 검증 심화)의 구현. 교수님 피드백 요지: "컴파일
성공 여부만 보지 말고, 실제 바이너리가 의도한 그대로 변환됐는지 검증하라."
roundtrip(6단계)은 텍스트 비교(공백/대소문자만 흡수)로 same/different만 갈랐고,
triage(7단계)는 그 different를 패턴 매칭 + 사람이 SDM/도구로 확인해 false_alarm/
bug/unsure로 분류했다. 이 단계는 그 분류를 텍스트 패턴이 아니라 "실제로 다시
어셈블해서 바이트가 같은가"라는 도구 기반 잣대로 한 번 더, 독립적으로 검증한다.

원리: objdump 역어셈블 텍스트가 원본과 문자열은 다르더라도(예: alias, 진법 표기,
크기 지시자 생략) "같은 명령어를 가리키는 다른 표현"이라면, 그 텍스트를 다시
어셈블했을 때 원본과 동일한 바이트가 나와야 한다. 바이트까지 다르면 triage의
false_alarm 판정이 틀렸을 가능성이 있는 **우선 재검토 대상**이라는 뜻이다 -
다만 바이트 차이의 원인이 항상 "진짜로 다른 명령어"인 것은 아니고, relocation
처리(상대분기 라벨->절대주소)나 비최소 인코딩 선택처럼 의미상 무해한 경우도
있으므로 매번 개별적으로 원인을 확인해야 한다(아래 relative_target_reassembly_
artifact 카테고리가 그 예). Stage 8/9(clang 비교)에서 CALL/JMP 오판정을 잡아낸
것과 같은 "도구로 재확인한다"는 원리를 roundtrip 전체 1,456건에 자동으로
적용하는 것.

한계(알고 시작할 것): objdump 텍스트에는 `{evex}` 태그, `bnd` 접두어, 세그먼트
접두어(`ds:`) 등 GNU as Intel-syntax 입력으로 그대로 재사용하기 애매한 표기가
섞여 있을 수 있다. 이런 건 "reassemble_failed"로 따로 모아서 이 단계의 한계로
문서화하지, 억지로 텍스트를 고쳐서 통과시키지 않는다(정답을 만들어내면 검증
의미가 없어짐).
"""

import argparse
import csv
import os
import re
import subprocess
import tempfile

ROUNDTRIP_CSV = "out/roundtrip.csv"
OUT_CSV = "out/reassemble_check.csv"
OUT_REPORT = "out/reassemble_check_report.md"
BATCH_SIZE = 500
OBJDUMP_TIMEOUT = 600  # 초. 배치가 넘기면 반으로 갈라 재시도한다

ASM_HEADER = ".intel_syntax noprefix\n.Ltarget:\n"
AS_CMD = ["as", "--64", "-mintel64"]

FILE_HEADER_RE = re.compile(r"^(.+):\s+file format")
OFFSET_LINE_RE = re.compile(r"^\s*[0-9a-f]+:\t")

# 상대분기(.Ltarget) 명령어는 objdump가 라벨을 절대주소(예: "0x0")로 보여준다.
# 그 절대주소 상수를 다시 어셈블하면 as가 위치독립적으로 확정 못 해 재배치
# (relocation)를 생성하면서 원본과 다른 바이트를 써넣는다(codex 검증에서
# "short/near 인코딩 선택 차이"가 아니라 relocation 문제라고 정정받음). 원본은
# 섹션 내부 상대 라벨, 재어셈블은 절대주소라 이 바이트 차이만으로는 디스어셈블러
# 버그 여부를 판정할 수 없다(검증 방법의 한계) - "의미 차이가 없다"고 단정하지
# 않는다.
RELATIVE_TARGET_RE = re.compile(r"^0x[0-9a-f]+$")


def read_different_rows(path):
    rows = []
    with open(path, encoding="utf-8") as f:
        for row in csv.DictReader(f):
            if row["result"] == "different":
                rows.append(row)
    return rows


def reassemble_one(objdump_line, tmp_dir):
    """objdump가 보여준 텍스트 한 줄을 다시 어셈블한다.

    반환: (ok, error_message, object_path_or_None)
    """
    tmp_s = os.path.join(tmp_dir, "line.s")
    tmp_o = os.path.join(tmp_dir, "line.o")
    with open(tmp_s, "w", encoding="utf-8", newline="\n") as f:
        f.write(ASM_HEADER + objdump_line + "\n")

    if os.path.exists(tmp_o):
        os.remove(tmp_o)

    result = subprocess.run(
        AS_CMD + ["-o", tmp_o, tmp_s],
        capture_output=True, text=True, timeout=10,
    )

    if result.returncode == 0 and os.path.exists(tmp_o):
        return True, "", tmp_o

    error_message = (result.stderr or result.stdout or "").strip()
    error_message = " | ".join(line.strip() for line in error_message.splitlines() if line.strip())
    return False, error_message, None


def parse_objdump_bytes(text):
    """m9_clang_compare.py와 동일한 방식: 파일당 명령어 1개 전제로 hex byte를 이어붙인다."""
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
    return bytes_by_path


def run_objdump_batch(args, batch, timeout=OBJDUMP_TIMEOUT):
    """objdump 한 배치를 실행한다. 일시적으로 느려지면 배치를 반으로 갈라 다시 시도한다.

    오브젝트 수만 개를 막 만든 직후에는 파일시스템이 느려져 배치 하나가 제한 시간을
    넘길 수 있다(2026-09-20 관측: 같은 배치가 평소 3초, 그때는 180초 초과).
    단계 전체를 죽이는 대신 잘라서 다시 시도하고, 그래도 안 되면 그때 실패시킨다.
    """
    try:
        return subprocess.run(args + batch, capture_output=True, text=True, timeout=timeout)
    except subprocess.TimeoutExpired:
        if len(batch) == 1:
            raise
        half = len(batch) // 2
        first = run_objdump_batch(args, batch[:half], timeout)
        second = run_objdump_batch(args, batch[half:], timeout)
        first.stdout += second.stdout
        return first


def run_objdump(object_paths):
    if not object_paths:
        return {}
    bytes_by_path = {}
    for start in range(0, len(object_paths), BATCH_SIZE):
        batch = object_paths[start:start + BATCH_SIZE]
        result = run_objdump_batch(["objdump", "-d", "-M", "intel"], batch)
        bytes_by_path.update(parse_objdump_bytes(result.stdout))
    return bytes_by_path


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--display-syntax', choices=('intel', 'att'), default='intel')
    parser.add_argument('--output', type=str)
    parser.add_argument('--report', type=str)
    args = parser.parse_args()
    rows = read_different_rows(ROUNDTRIP_CSV)

    if args.display_syntax == 'att':
        out_rows = [{**row, 'category': 'display_not_checked', 'orig_bytes': '',
                     'reassembled_bytes': '',
                     'note': 'AT&T 표시 왕복은 현재 구현 범위 밖; 입력 Intel 관측과 raw bytes만 보존.',
                     'display_syntax': 'att'} for row in rows]
        output = args.output or OUT_CSV.replace('.csv', '_att.csv')
        os.makedirs(os.path.dirname(output) or '.', exist_ok=True)
        with open(output, 'w', encoding='utf-8', newline='') as stream:
            fieldnames = list(out_rows[0]) if out_rows else ['display_syntax']
            writer = csv.DictWriter(stream, fieldnames=fieldnames)
            writer.writeheader()
            writer.writerows(out_rows)
        report_output = args.report or OUT_REPORT.replace('.md', '_att.md')
        os.makedirs(os.path.dirname(report_output) or '.', exist_ok=True)
        with open(report_output, 'w', encoding='utf-8') as stream:
            stream.write(
                '# Reassemble display-syntax probe\n\n'
                'display_syntax=att is recorded as display_not_checked. '
                'AT&T input rendering is outside the current implementation scope; '
                'this probe does not reassemble AT&T text.\n\n'
                f'- input different rows: {len(rows)}\n'
                '- category: display_not_checked\n'
            )
        print(f"AT&T 표시 왕복 미구현을 명시적으로 기록: {len(rows)}건")
        print(f"출력: {output}, {report_output}")
        return

    reassembled_paths = {}  # combo_id -> path
    reassemble_error = {}   # combo_id -> error message
    out_rows_partial = []

    with tempfile.TemporaryDirectory(prefix="m10_reasm_") as tmp_dir:
        for row in rows:
            combo_id = row["combo_id"]
            ok, err, tmp_o = reassemble_one(row["objdump_line"], tmp_dir)
            if ok:
                keep_path = os.path.join(tmp_dir, f"kept_{combo_id}.o")
                os.replace(tmp_o, keep_path)
                reassembled_paths[combo_id] = keep_path
            else:
                reassemble_error[combo_id] = err

        # 원본 바이트: out/objects/combo_<id>.o (assembler 5단계 산출물, 이미 존재).
        original_paths = [row["object_file_path"] for row in rows]
        original_bytes = run_objdump(original_paths)

        # 재어셈블 성공분만 배치로 다시 objdump.
        reasm_ids = list(reassembled_paths.keys())
        reasm_paths = [reassembled_paths[cid] for cid in reasm_ids]
        reasm_bytes = run_objdump(reasm_paths)

        counts = {
            "byte_roundtrip_same": 0, "byte_roundtrip_diff": 0,
            "reassemble_failed": 0, "relative_target_reassembly_artifact": 0,
        }
        out_rows = []
        diff_examples = []

        for row in rows:
            combo_id = row["combo_id"]
            orig_b = original_bytes.get(row["object_file_path"], "")
            is_relative_target = (
                ".Ltarget" in row["asm_line"]
                and bool(RELATIVE_TARGET_RE.match(row["objdump_line"].split()[-1]))
            )
            if combo_id in reassemble_error:
                category = "reassemble_failed"
                reasm_b = ""
                note = reassemble_error[combo_id]
            else:
                reasm_b = reasm_bytes.get(reassembled_paths[combo_id], "")
                if not orig_b or not reasm_b:
                    category = "reassemble_failed"
                    note = "objdump가 원본 또는 재어셈블 결과에서 바이트를 못 뽑음"
                elif orig_b == reasm_b:
                    category = "byte_roundtrip_same"
                    note = ""
                elif is_relative_target:
                    category = "relative_target_reassembly_artifact"
                    note = ("상대분기 라벨(.Ltarget)이 objdump에는 절대주소로 표시됨 - 그 절대주소 "
                            "상수를 다시 어셈블하면 as가 위치독립적으로 확정 못 해 재배치(relocation)를 "
                            "생성하면서 바이트가 달라짐. 원본은 섹션 내부 상대 라벨, 재어셈블은 절대주소라 "
                            "이 바이트 차이만으로는 디스어셈블러 버그 여부를 판정할 수 없음(검증 방법의 한계).")
                else:
                    category = "byte_roundtrip_diff"
                    note = ""
            counts[category] += 1

            out_row = {
                "combo_id": combo_id,
                "row_id": row["row_id"],
                "mnemonic": row["mnemonic"],
                "asm_line": row["asm_line"],
                "objdump_line": row["objdump_line"],
                "category": category,
                "orig_bytes": orig_b,
                "reassembled_bytes": reasm_b,
                "note": note,
                "display_syntax": args.display_syntax,
            }
            out_rows.append(out_row)
            if category == "byte_roundtrip_diff" and len(diff_examples) < 50:
                diff_examples.append(out_row)

    fieldnames = ["combo_id", "row_id", "mnemonic", "asm_line", "objdump_line",
                  "category", "orig_bytes", "reassembled_bytes", "note", "display_syntax"]
    output = args.output or OUT_CSV
    os.makedirs(os.path.dirname(output) or '.', exist_ok=True)
    with open(output, "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(out_rows)

    report_output = args.report or OUT_REPORT
    os.makedirs(os.path.dirname(report_output) or '.', exist_ok=True)
    write_report(counts, diff_examples, len(rows), report_output)

    print(f"roundtrip 'different' 대상: {len(rows)}건")
    for key, value in counts.items():
        print(f"  {key}: {value}")
    print(f"출력: {output}, {report_output}")


def write_report(counts, diff_examples, total, output_report=OUT_REPORT):
    lines = []
    lines.append("# 바이트 라운드트립 검증 (10단계 reassemble_check)\n")
    lines.append("roundtrip(6단계)에서 'different'로 나온 각 줄에 대해, objdump가 보여준")
    lines.append("역어셈블 텍스트를 다시 GNU as로 어셈블해서 원본과 바이트가 같은지 확인했다.\n")
    lines.append(f"대상: {total}건\n")
    lines.append("| 카테고리 | 건수 | 의미 |")
    lines.append("|---|---|---|")
    meaning = {
        "byte_roundtrip_same": "재어셈블 바이트가 원본과 동일 - 바이트 보존 관측. 원본 의미/false_alarm 확정과는 구분",
        "byte_roundtrip_diff": "재어셈블 바이트가 원본과 다름 - 진짜 의미 차이일 가능성, 개별 확인 필요",
        "relative_target_reassembly_artifact": "상대분기 라벨->절대주소 표시를 재어셈블하면 relocation이 생겨 바이트가 달라짐 - 이 방법으로는 디스어셈블러 버그 여부 판정 불가",
        "reassemble_failed": "objdump 텍스트를 그대로 다시 어셈블 못 함(예: {evex} 태그, 세그먼트 접두어 등)",
    }
    for key in ["byte_roundtrip_same", "byte_roundtrip_diff", "relative_target_reassembly_artifact", "reassemble_failed"]:
        lines.append(f"| {key} | {counts[key]} | {meaning[key]} |")
    lines.append("")

    lines.append("## byte_roundtrip_diff 사례 (최대 50건)\n")
    lines.append("| combo_id | mnemonic | asm_line | objdump_line | orig_bytes | reassembled_bytes |")
    lines.append("|---|---|---|---|---|---|")
    for row in diff_examples:
        lines.append(f"| {row['combo_id']} | {row['mnemonic']} | `{row['asm_line']}` | "
                      f"`{row['objdump_line']}` | `{row['orig_bytes']}` | `{row['reassembled_bytes']}` |")
    lines.append("")

    with open(output_report, "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + "\n")


if __name__ == "__main__":
    main()

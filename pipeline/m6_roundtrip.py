"""
6단계 roundtrip: 어셈블 성공한 명령어를 objdump로 역어셈블해서 원본 asm_line과
같은지/다른지만 비교한다.

입력은 out/asm_result.csv (5단계 assembler 결과) 이다. asm_result.csv는
actual_result가 "ok"인 행에만 object_file_path(예: out/objects/combo_6.o)가
채워져 있다 (에러난 줄은 기계어가 없어 역어셈블 대상이 아님). 5단계는 명령어를
한 줄씩 개별 .o로 어셈블했으므로, 여기서도 파일 하나 = 명령어 하나다.
(.claude/agents/roundtrip.md 는 "out/tests.o 단일 파일"이라고 적혀 있지만
실제 assembler(m5)는 이렇게 만들지 않으므로, 실제 산출물 기준으로 맞춘다.)

주의 (CLAUDE.md 1절, 교수님 피드백):
objdump는 원본 어셈블리 텍스트를 복원하는 도구가 아니다. 기계어를 다시
어셈블리로 "표시"할 뿐이다. 그래서 원본 asm_line과 objdump 결과가 텍스트로
다르더라도 곧바로 오류가 아니다 (예: alias, 크기 지시자 생략/추론, 레이블
대신 절대주소 표시 등). 여기서는 "같다(same)/다르다(different)"만 정확히
가려낸다. 왜 다른지 원인 분석과 오탐(false alarm) 판단은 7단계 triage가 한다.
"""

import argparse
import csv
import os
import re
import subprocess

IN_CSV = "out/asm_result.csv"
OUT_CSV = "out/roundtrip.csv"

# objdump가 여러 파일을 한 번에 받으면 파일마다 이 줄로 구분해서 출력한다.
# 예: "out/objects/combo_42.o:     file format elf64-x86-64"
FILE_HEADER_RE = re.compile(r"^(.+):\s+file format")
BATCH_SIZE = 500


def read_ok_rows(path):
    """asm_result.csv에서 actual_result == ok 인 행만 읽는다."""
    rows = []
    with open(path, encoding="utf-8") as f:
        for row in csv.DictReader(f):
            if row["actual_result"] == "ok":
                rows.append(row)
    return rows


def parse_objdump_output(text):
    """objdump 출력 전체를 "파일 경로 -> 역어셈블 명령어 문자열" dict로 나눈다.

    각 파일은 명령어가 딱 한 줄(단일 인스트럭션)이므로, 파일 블록 안에서
    실제 니모닉이 적힌 줄 하나만 골라낸다. 인코딩이 길면(EVEX+immediate 등)
    objdump가 헥스 바이트 덤프를 다음 줄로 줄바꿈하는데, 그 이어지는 줄은
    "주소:\t헥스바이트"까지만 있고 세 번째(탭 구분) 칸에 니모닉이 없으므로
    명령어 줄로 취급하지 않고 건너뛴다.
    """
    disasm_by_path = {}
    current_path = None
    for line in text.splitlines():
        header = FILE_HEADER_RE.match(line)
        if header:
            current_path = header.group(1)
            continue
        if current_path is None:
            continue
        parts = line.split("\t")
        if len(parts) >= 3 and parts[2].strip():
            disasm_by_path[current_path] = parts[2].strip()
    return disasm_by_path


def run_objdump(object_paths, display_syntax='intel'):
    """objdump -d -M intel 을 한 번에 실행한다.

    파일 하나씩 7천 번 따로 실행하는 것보다, 경로를 한꺼번에 넘기고 출력을
    나눠 읽는 쪽이 훨씬 빠르다 (objdump는 여러 파일을 인자로 받을 수 있음).
    """
    disasm_by_path = {}
    for start in range(0, len(object_paths), BATCH_SIZE):
        batch = object_paths[start:start + BATCH_SIZE]
        result = subprocess.run(
            ["objdump", "-d", "-M", display_syntax] + batch,
            capture_output=True, text=True, timeout=180,
        )
        disasm_by_path.update(parse_objdump_output(result.stdout))
    return disasm_by_path


def normalize(text):
    """비교 전에 사소한 표기 차이(공백, 대소문자)를 흡수한다.

    숫자 표기(십진 1 vs 16진 0x1)나 레이블 vs 절대주소(.Ltarget vs 0x0) 같은
    차이는 여기서 흡수하지 않는다 -> 그런 건 "different"로 남기고 triage가
    alias/false alarm 여부를 판단한다.
    """
    text = text.lower().strip()
    text = re.sub(r"\s*,\s*", ",", text)  # 콤마 앞뒤 공백 통일 ("al, 1" vs "al,0x1")
    text = re.sub(r"\s+", " ", text)      # 연속 공백을 하나로
    return text


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--display-syntax', choices=('intel', 'att'), default='intel')
    parser.add_argument('--output', type=str)
    args = parser.parse_args()
    rows = read_ok_rows(IN_CSV)
    object_paths = [row["object_file_path"] for row in rows]
    disasm_by_path = run_objdump(object_paths, args.display_syntax)

    out_rows = []
    same_count = 0
    diff_count = 0
    missing_count = 0

    for row in rows:
        path = row["object_file_path"]
        objdump_line = disasm_by_path.get(path, "")
        if not objdump_line:
            missing_count += 1

        same = normalize(row["asm_line"]) == normalize(objdump_line)
        result = "same" if same else "different"
        if same:
            same_count += 1
        else:
            diff_count += 1

        out_rows.append({
            "combo_id": row["combo_id"],
            "row_id": row["row_id"],
            "mnemonic": row["mnemonic"],
            "source_line": row["source_line"],
            "asm_line": row["asm_line"],
            "objdump_line": objdump_line,
            "result": result,
            "mismatch": row["mismatch"],
            "object_file_path": path,
            "display_syntax": args.display_syntax,
        })

    fieldnames = [
        "combo_id", "row_id", "mnemonic", "source_line", "asm_line",
        "objdump_line", "result", "mismatch", "object_file_path", "display_syntax",
    ]
    output = args.output or (OUT_CSV if args.display_syntax == 'intel' else
                             OUT_CSV.replace('.csv', '_%s.csv' % args.display_syntax))
    os.makedirs(os.path.dirname(output) or '.', exist_ok=True)
    with open(output, "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(out_rows)

    print(f"대상 명령어 수(ok): {len(rows)}")
    print(f"same: {same_count}  different: {diff_count}")
    if missing_count:
        print(f"경고: objdump 출력에서 역어셈블 줄을 못 찾은 파일 {missing_count}개")
    print(f"출력: {output}")


if __name__ == "__main__":
    main()

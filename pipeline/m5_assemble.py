"""
5단계 assembler: out/tests.s -> out/asm_result.csv (+ out/objects/*.o)

기본 어셈블러는 GNU as (Intel syntax, --64 -mintel64).
clang/llvm-mc는 나중에 --assembler=clang 같은 옵션으로만 열어둘 예정 (지금은 안 씀).

핵심 방식: out/tests.s를 통째로 어셈블하면 한 줄만 에러여도 전체가 실패로 뜬다.
그래서 명령어를 "한 줄씩" 잘라 각각 별도의 임시 .s 파일로 만들어 개별 어셈블한다.
그래야 어떤 줄이 되고 안 되는지 정확히 알 수 있다.

주의: 여기서는 "됐다/안 됐다 + 에러 메시지"만 기록한다. 원인 판단(버그인지 아닌지)은
7단계 triage가 한다 (CLAUDE.md 1절, 6절).
"""

import csv
import os
import re
import shutil
import subprocess
import tempfile

IN_ASM = "out/tests.s"
OUT_CSV = "out/asm_result.csv"
OUT_OBJ_DIR = "out/objects"

# out/tests.s 각 줄 끝 주석의 키들 (m4_generate.py build_line()이 이 순서로 붙였다).
# cpuid 값에는 공백이 들어갈 수 있어서("AVX512DQ OR AVX10.1") 단순 split(" ")으로는
# 못 자르고, "키=" 앞에서만 끊어야 한다 -> lookahead 정규식으로 분리.
TAG_KEYS = ["combo_id", "row_id", "combo_index", "mnemonic",
            "expected_valid", "mode_support", "cpuid", "note"]
TAG_SPLIT_RE = re.compile(r"(?=(?:%s)=)" % "|".join(TAG_KEYS))

ASM_HEADER = ".intel_syntax noprefix\n.Ltarget:\n"


def parse_tag(tag_text):
    """줄 끝 주석(# combo_id=... row_id=... ...)을 dict로 분해한다."""
    fields = {key: "" for key in TAG_KEYS}
    for chunk in TAG_SPLIT_RE.split(tag_text):
        chunk = chunk.strip()
        if not chunk or "=" not in chunk:
            continue
        key, _, value = chunk.partition("=")
        if key in fields:
            fields[key] = value.strip()
    return fields


def read_instruction_lines(path):
    """out/tests.s에서 실제 명령어 줄만 골라낸다 (헤더/라벨/빈 줄 제외)."""
    items = []
    with open(path, encoding="utf-8") as f:
        for line_no, raw_line in enumerate(f, start=1):
            line = raw_line.rstrip("\n")
            if "  # combo_id=" not in line:
                continue  # 헤더, .intel_syntax, .Ltarget 라벨, 빈 줄 등은 건너뜀
            code, _, tag_text = line.partition("  # ")
            tag = parse_tag(tag_text)
            items.append({"line_no": line_no, "code": code, "tag": tag})
    return items


def assemble_one(code, tmp_dir):
    """명령어 한 줄을 임시 .s 파일로 만들어 GNU as로 어셈블한다.

    반환: (ok, error_message, object_bytes_path_or_None)
    """
    tmp_s = os.path.join(tmp_dir, "line.s")
    tmp_o = os.path.join(tmp_dir, "line.o")
    with open(tmp_s, "w", encoding="utf-8", newline="\n") as f:
        f.write(ASM_HEADER + code + "\n")

    if os.path.exists(tmp_o):
        os.remove(tmp_o)

    result = subprocess.run(
        ["as", "--64", "-mintel64", "-o", tmp_o, tmp_s],
        capture_output=True, text=True, timeout=10,
    )

    if result.returncode == 0 and os.path.exists(tmp_o):
        return True, "", tmp_o

    error_message = (result.stderr or result.stdout or "").strip()
    error_message = " | ".join(line.strip() for line in error_message.splitlines() if line.strip())
    # tmp_dir는 실행할 때마다 랜덤하게 바뀌므로, 재현 가능한 CSV를 위해
    # 절대경로를 지우고 파일명(line.s)만 남긴다 (CLAUDE.md "재현 가능" 원칙).
    error_message = error_message.replace(tmp_s, "line.s")
    return False, error_message, None


def judge_mismatch(expected_valid, actual_result):
    """매뉴얼 기대(expected_valid)와 실제 as 결과(actual_result)가 다른지 표시.

    True면 흥미로운 케이스: "매뉴얼상 유효한데 as가 거부" 또는 "매뉴얼상 무효인데 as가 받음".
    triage가 여기서부터 원인을 파고든다.
    """
    expects_ok = expected_valid.strip().lower() == "true"
    got_ok = actual_result == "ok"
    return expects_ok != got_ok


def main():
    items = read_instruction_lines(IN_ASM)
    os.makedirs(OUT_OBJ_DIR, exist_ok=True)

    rows = []
    ok_count = 0
    error_count = 0
    mismatch_count = 0

    with tempfile.TemporaryDirectory(prefix="m5_asm_") as tmp_dir:
        for item in items:
            tag = item["tag"]
            code = item["code"]
            combo_id = tag["combo_id"]

            ok, error_message, tmp_o = assemble_one(code, tmp_dir)
            actual_result = "ok" if ok else "error"

            object_path = ""
            if ok:
                object_path = os.path.join(OUT_OBJ_DIR, f"combo_{combo_id}.o")
                shutil.copyfile(tmp_o, object_path)
                ok_count += 1
            else:
                error_count += 1

            mismatch = judge_mismatch(tag["expected_valid"], actual_result)
            if mismatch:
                mismatch_count += 1

            rows.append({
                "combo_id": combo_id,
                "row_id": tag["row_id"],
                "combo_index": tag["combo_index"],
                "mnemonic": tag["mnemonic"],
                "cpuid": tag["cpuid"],
                "note": tag["note"],
                "source_line": item["line_no"],
                "asm_line": code,
                "expected_valid": tag["expected_valid"],
                "mode_support": tag["mode_support"],
                "actual_result": actual_result,
                "mismatch": mismatch,
                "error_message": error_message,
                "object_file_path": object_path,
            })

    fieldnames = [
        "combo_id", "row_id", "combo_index", "mnemonic", "cpuid", "note",
        "source_line", "asm_line", "expected_valid", "mode_support",
        "actual_result", "mismatch", "error_message", "object_file_path",
    ]
    with open(OUT_CSV, "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)

    print(f"입력 명령어 줄 수: {len(items)}")
    print(f"성공(ok): {ok_count}  실패(error): {error_count}")
    print(f"mismatch(기대와 다름): {mismatch_count}")
    print(f"출력: {OUT_CSV}, 오브젝트 디렉터리: {OUT_OBJ_DIR}")


if __name__ == "__main__":
    main()

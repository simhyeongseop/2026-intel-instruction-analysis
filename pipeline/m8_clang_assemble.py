"""
8단계 clang_assemble: out/tests.s -> out/clang_result.csv (+ out/clang_objects/*.o)

8회 미팅 후속 과제 1번(Clang 확장 비교)의 첫 절반. m5_assemble.py와 완전히 같은
방식(한 줄씩 개별 임시 .s로 잘라 개별 어셈블)으로 같은 out/tests.s를 **clang**의
통합 어셈블러(integrated assembler)에 통과시킨다. as와 나란히 비교하기 위해
asm_result.csv와 최대한 같은 컬럼 구조로 만든다 (m9_clang_compare.py가 join).

주의(실험으로 확인한 사실, m5와 다른 점):
- clang -c는 문법 오류가 있어도 셸에서 여러 커맨드를 ";"로 이어붙여 실행하면
  종료코드가 뒤섞여 보일 때가 있었다(버퍼링 문제). 하지만 python subprocess로
  단독 실행하면 정상적으로 returncode=1을 준다(직접 확인). as와 동일하게
  returncode==0 and 오브젝트 파일 존재 여부로 성공을 판단한다.
- clang 기본 타겟이 이 WSL 환경에선 x86_64-pc-linux-gnu(64비트)이지만, as처럼
  명시적으로 고정하기 위해 --target=x86_64-pc-linux-gnu를 붙인다.
"""

import csv
import os
import re
import shutil
import subprocess
import tempfile

IN_ASM = "out/tests.s"
OUT_CSV = "out/clang_result.csv"
OUT_OBJ_DIR = "out/clang_objects"

# m5_assemble.py와 동일 (out/tests.s 태그 포맷 재사용).
TAG_KEYS = ["combo_id", "row_id", "combo_index", "mnemonic",
            "expected_valid", "mode_support", "cpuid", "note"]
TAG_SPLIT_RE = re.compile(r"(?=(?:%s)=)" % "|".join(TAG_KEYS))

ASM_HEADER = ".intel_syntax noprefix\n.Ltarget:\n"

CLANG_CMD = ["clang", "--target=x86_64-pc-linux-gnu", "-c"]


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
    """out/tests.s에서 실제 명령어 줄만 골라낸다 (m5_assemble.py와 동일)."""
    items = []
    with open(path, encoding="utf-8") as f:
        for line_no, raw_line in enumerate(f, start=1):
            line = raw_line.rstrip("\n")
            if "  # combo_id=" not in line:
                continue
            code, _, tag_text = line.partition("  # ")
            tag = parse_tag(tag_text)
            items.append({"line_no": line_no, "code": code, "tag": tag})
    return items


def assemble_one(code, tmp_dir):
    """명령어 한 줄을 임시 .s 파일로 만들어 clang으로 어셈블한다.

    반환: (ok, error_message, object_bytes_path_or_None)
    """
    tmp_s = os.path.join(tmp_dir, "line.s")
    tmp_o = os.path.join(tmp_dir, "line.o")
    with open(tmp_s, "w", encoding="utf-8", newline="\n") as f:
        f.write(ASM_HEADER + code + "\n")

    if os.path.exists(tmp_o):
        os.remove(tmp_o)

    result = subprocess.run(
        CLANG_CMD + ["-o", tmp_o, tmp_s],
        capture_output=True, text=True, timeout=10,
    )

    if result.returncode == 0 and os.path.exists(tmp_o):
        return True, "", tmp_o

    error_message = (result.stderr or result.stdout or "").strip()
    error_message = " | ".join(line.strip() for line in error_message.splitlines() if line.strip())
    error_message = error_message.replace(tmp_s, "line.s")
    return False, error_message, None


def judge_mismatch(expected_valid, actual_result):
    """m5_assemble.py와 동일: 매뉴얼 기대와 실제 결과가 다르면 True."""
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

    with tempfile.TemporaryDirectory(prefix="m8_clang_") as tmp_dir:
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
    print(f"clang 성공(ok): {ok_count}  실패(error): {error_count}")
    print(f"mismatch(기대와 다름): {mismatch_count}")
    print(f"출력: {OUT_CSV}, 오브젝트 디렉터리: {OUT_OBJ_DIR}")


if __name__ == "__main__":
    main()

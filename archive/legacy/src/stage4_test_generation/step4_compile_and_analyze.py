"""
Step 4: 컴파일 및 에러 수집

Stage 3이 생성한 어셈블리 파일을 GNU as / llvm-mc (clang) 에 넣어
발생하는 에러를 수집한다.

한글 경로 문제 회피를 위해 stdin 파이프로 소스를 전달한다.

출력:
  - step4_as_errors.txt    : GNU as 에러 원문
  - step4_clang_errors.txt : Clang(llvm-mc) 에러 원문
  - step4_error_lines.csv  : 에러 파싱 결과 (라인별)
  - test_all_annotated.s   : GNU as 에러 위치 주석 달린 소스
"""

import subprocess
import re
import csv
import platform
from pathlib import Path

BASE = Path(__file__).parent.parent.parent
SRC_ASM = BASE / "data" / "stage3_operands" / "step3_generated.s"
OUT_DIR = BASE / "data" / "stage4_tests"

IS_WINDOWS = platform.system() == "Windows"


def _run_stdin(cmd: list[str], src_text: str) -> tuple[str, int]:
    """stdin으로 소스를 파이프하여 실행. (stdout+stderr, returncode) 반환."""
    if IS_WINDOWS:
        wsl_cmd = " ".join(cmd)
        proc = subprocess.run(
            ["wsl", "bash", "-c", wsl_cmd],
            input=src_text, capture_output=True, text=True,
            encoding="utf-8", errors="replace",
        )
    else:
        proc = subprocess.run(
            cmd, input=src_text, capture_output=True, text=True,
            encoding="utf-8", errors="replace",
        )
    output = (proc.stderr or "") + (proc.stdout or "")
    return output, proc.returncode


def parse_errors(raw: str, compiler: str) -> list[dict]:
    """에러 메시지를 라인 단위로 파싱."""
    results = []
    # GNU as: {stdin}:123: Error: ...
    # clang:  <stdin>:123:45: error: ...
    pat = re.compile(r"(?:\{stdin\}|<stdin>|[^:]+):(\d+):(?:\d+:)?\s*(Error|Warning|error|warning):\s*(.+)", re.I)
    for line in raw.splitlines():
        m = pat.search(line)
        if m:
            results.append({
                "compiler": compiler,
                "line_num": int(m.group(1)),
                "error_type": m.group(2).lower(),
                "message": m.group(3).strip(),
                "raw": line.strip(),
            })
    return results


def annotate_source(src_lines: list[str], errors: list[dict]) -> str:
    """에러가 발생한 줄에 주석을 추가."""
    err_map: dict[int, list[str]] = {}
    for e in errors:
        ln = e["line_num"]
        err_map.setdefault(ln, []).append(f"// ← [{e['compiler']}] {e['message']}")
    out = []
    for i, line in enumerate(src_lines, 1):
        out.append(line)
        if i in err_map:
            for ann in err_map[i]:
                out.append(ann)
    return "\n".join(out)


def main():
    OUT_DIR.mkdir(parents=True, exist_ok=True)

    print("=" * 60)
    print("Step 4: 컴파일 및 에러 수집 (stdin 파이프 방식)")
    print("=" * 60)

    if not SRC_ASM.exists():
        print(f"[오류] 소스 없음: {SRC_ASM}")
        print("       Stage 3를 먼저 실행하세요.")
        return

    src_text = SRC_ASM.read_text(encoding="utf-8")
    src_lines = src_text.splitlines()
    print(f"[대상] {SRC_ASM.name} ({len(src_lines)} lines)")
    print(f"[환경] {'Windows (WSL 경유)' if IS_WINDOWS else 'Linux/macOS'}\n")

    all_errors: list[dict] = []

    # ── 1. GNU as ────────────────────────────────────────────
    print("─" * 40)
    print("[1] GNU as (binutils) — stdin 파이프")
    as_cmd = ["as", "--64", "-mintel64", "-o", "/dev/null"]
    raw_as, rc_as = _run_stdin(as_cmd, src_text)
    (OUT_DIR / "step4_as_errors.txt").write_text(raw_as, encoding="utf-8")
    errors_as = parse_errors(raw_as, "as")
    all_errors.extend(errors_as)
    print(f"  returncode: {rc_as}, 에러 행: {len(errors_as)}")

    # ── 2. Clang (llvm-mc) ───────────────────────────────────
    print("\n" + "─" * 40)
    print("[2] Clang (integrated assembler) — stdin 파이프")
    clang_cmd = ["clang", "-c", "-x", "assembler", "-o", "/dev/null", "-"]
    raw_clang, rc_clang = _run_stdin(clang_cmd, src_text)
    (OUT_DIR / "step4_clang_errors.txt").write_text(raw_clang, encoding="utf-8")
    errors_clang = parse_errors(raw_clang, "clang")
    all_errors.extend(errors_clang)
    print(f"  returncode: {rc_clang}, 에러 행: {len(errors_clang)}")

    # ── 3. 에러 CSV 저장 ─────────────────────────────────────
    print("\n" + "─" * 40)
    print("[3] 에러 파싱 결과 저장")
    if all_errors:
        # source line 병합
        for e in all_errors:
            idx = e["line_num"] - 1
            e["source_line"] = src_lines[idx].strip() if 0 <= idx < len(src_lines) else ""

        error_csv = OUT_DIR / "step4_error_lines.csv"
        with error_csv.open("w", newline="", encoding="utf-8-sig") as f:
            w = csv.DictWriter(f, fieldnames=["compiler", "line_num", "error_type",
                                              "message", "source_line", "raw"])
            w.writeheader()
            w.writerows(all_errors)
        print(f"  저장: {error_csv} ({len(all_errors)}행)")

        # 주석 달린 소스
        annotated = annotate_source(src_lines, all_errors)
        (OUT_DIR / "test_all_annotated.s").write_text(annotated, encoding="utf-8")
        print(f"  주석 소스: test_all_annotated.s")

        # 간단 통계
        from collections import Counter
        by_compiler = Counter(e["compiler"] for e in all_errors)
        print(f"\n  에러 요약: {dict(by_compiler)}")
        # 에러 메시지 상위 10
        msg_counter = Counter(e["message"].split("'")[0].strip() for e in all_errors)
        print("  에러 유형 상위:")
        for msg, cnt in msg_counter.most_common(10):
            print(f"    {cnt:4d}  {msg[:60]}")
    else:
        print("  에러 없음 — 모든 명령어 수용됨.")

    print(f"\n[완료] Stage 4 에러 수집 완료 → {OUT_DIR}")


if __name__ == "__main__":
    main()

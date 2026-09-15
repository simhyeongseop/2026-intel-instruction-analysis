"""
Stage 3 검증: 생성된 Intel-syntax 어셈블리를 GNU as로 실제 어셈블하여
매핑이 '유효한 어셈블리'를 만들어냈는지 확인한다. (교수님 철학: 실제 어셈블러로 검증)

- step3_generated.s 를 as --64 -mintel64 로 어셈블
- 에러 라인을 파싱해 성공/실패 통계 + 에러 메시지 클러스터 출력
"""
import re
import subprocess
import platform
from collections import Counter
from pathlib import Path

BASE = Path(__file__).parent.parent.parent
SRC = BASE / "data" / "stage3_operands" / "step3_generated.s"
IS_WIN = platform.system() == "Windows"


def wslpath(p: Path) -> str:
    r = subprocess.run(["wsl", "wslpath", "-a", str(p.resolve())],
                       capture_output=True, text=True, encoding="utf-8", errors="replace")
    return r.stdout.strip()


def main():
    lines = SRC.read_text(encoding="utf-8").splitlines()
    content = "\n".join(lines) + "\n"
    # 경로(한글/OneDrive) 문제 회피: stdin 으로 파이프. as 는 인자 없으면 stdin 을 읽는다.
    cmd = ["wsl", "as", "--64", "-mintel64", "-o", "/dev/null"] if IS_WIN \
          else ["as", "--64", "-mintel64", "-o", "/dev/null"]
    r = subprocess.run(cmd, input=content, capture_output=True, text=True,
                       encoding="utf-8", errors="replace", timeout=180)
    err_text = r.stderr + r.stdout

    err_pat = re.compile(r":(\d+):\s*(Error|Warning):\s*(.+)", re.IGNORECASE)
    err_lines: dict[int, str] = {}
    for ln in err_text.splitlines():
        m = err_pat.search(ln)
        if m and m.group(2).lower() == "error":
            err_lines[int(m.group(1))] = m.group(3).strip()

    # 명령어 라인만 카운트 (들여쓰기된 라인)
    instr_line_nums = [i + 1 for i, l in enumerate(lines) if l.startswith("    ")]
    total = len(instr_line_nums)
    n_err = sum(1 for ln in err_lines if 1 <= ln <= len(lines) and lines[ln - 1].startswith("    "))
    ok = total - n_err

    print(f"어셈블 대상 명령어: {total}")
    print(f"  성공: {ok} ({ok/total*100:.2f}%)")
    print(f"  실패: {n_err} ({n_err/total*100:.2f}%)")

    # 에러 메시지 클러스터
    def norm_msg(msg: str) -> str:
        msg = re.sub(r"`[^']*'", "`X'", msg)
        msg = re.sub(r"\d+", "N", msg)
        return msg[:70]

    clusters = Counter(norm_msg(m) for m in err_lines.values())
    print(f"\n=== 에러 클러스터 (상위 15) ===")
    for msg, cnt in clusters.most_common(15):
        print(f"  {cnt:4d}  {msg}")
        for ln, mm in err_lines.items():
            if norm_msg(mm) == msg and 1 <= ln <= len(lines):
                print(f"         예: {lines[ln-1].strip()[:60]}  | {mm[:50]}")
                break

    # 전체 실패 라인 CSV 저장 (분석용)
    import csv as _csv
    out = SRC.parent / "step3_asm_errors.csv"
    with out.open("w", newline="", encoding="utf-8-sig") as f:
        w = _csv.writer(f)
        w.writerow(["line", "instruction", "error"])
        for ln in sorted(err_lines):
            if 1 <= ln <= len(lines):
                w.writerow([ln, lines[ln-1].strip(), err_lines[ln]])
    print(f"\n[저장] {out}")


if __name__ == "__main__":
    main()

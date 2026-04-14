"""
Step 4-3: 컴파일 및 에러 수집 (4회 미팅 액션 아이템)

생성된 어셈블리 테스트 파일을 GCC / Clang / GNU as 로 컴파일하고
발생하는 에러를 수집하여 분석합니다.

컴파일 명령어 (미팅 참고):
  gcc  -c <src> -o <output>
  clang -c <src> -o <output>
  as       <src> -o <output>   (GNU assembler 단독 사용 시)

출력:
  - step4_gcc_errors.txt    : GCC 에러 원문
  - step4_clang_errors.txt  : Clang 에러 원문
  - step4_as_errors.txt     : GNU as 에러 원문
  - step4_error_lines.csv   : 에러 파싱 결과 (라인별)
"""

import subprocess
import re
import csv
import platform
from pathlib import Path


# ============================================================
# 환경 설정
# ============================================================

BASE = Path(__file__).parent.parent.parent
SRC_ASM = BASE / "data" / "stage4_tests" / "test_all_instructions.s"
OUT_DIR = BASE / "data" / "stage4_tests"

IS_WINDOWS = platform.system() == "Windows"


def run_assembler(compiler_cmd: list[str], src: Path, out: Path) -> tuple[str, str, int]:
    """
    어셈블러/컴파일러를 실행하고 (stdout, stderr, returncode) 반환.
    Windows에서는 WSL을 통해 실행.
    """
    if IS_WINDOWS:
        # WSL 경로 변환: C:\... → /mnt/host/c/...
        def to_wsl(p: Path) -> str:
            s = str(p).replace("\\", "/")
            # C:/Users/... → /mnt/host/c/Users/...
            if len(s) >= 2 and s[1] == ":":
                drive = s[0].lower()
                rest = s[2:]
                return f"/mnt/host/{drive}{rest}"
            return s

        wsl_src = to_wsl(src)
        wsl_out = to_wsl(out)
        cmd = ["powershell", "-Command",
               f"wsl {' '.join(compiler_cmd)} '{wsl_src}' -o '{wsl_out}' 2>&1"]
    else:
        cmd = compiler_cmd + [str(src), "-o", str(out)]

    result = subprocess.run(
        cmd,
        capture_output=True,
        text=True,
        encoding="utf-8",
        errors="replace",
    )
    # PowerShell 경유 시 stdout에 stderr도 포함됨
    stderr = result.stderr or result.stdout
    return result.stdout, stderr, result.returncode


def run_via_wsl(wsl_cmd: str) -> tuple[str, int]:
    """WSL 명령 직접 실행 (PowerShell 경유)"""
    result = subprocess.run(
        ["powershell", "-Command", f"wsl {wsl_cmd} 2>&1"],
        capture_output=True,
        text=True,
        encoding="utf-8",
        errors="replace",
    )
    output = result.stdout + result.stderr
    return output, result.returncode


# ============================================================
# 에러 파싱
# ============================================================

ERROR_PATTERN = re.compile(
    r"(?P<file>[^:]+):(?P<line>\d+):\s*(?P<type>Error|Warning|error|warning):\s*(?P<msg>.+)"
)

def parse_errors(raw_output: str, compiler: str) -> list[dict]:
    """
    컴파일러 에러 출력을 파싱하여 구조화된 리스트 반환.
    각 항목: {compiler, line_num, error_type, message}
    """
    rows = []
    for line in raw_output.splitlines():
        m = ERROR_PATTERN.search(line)
        if m:
            rows.append({
                "compiler": compiler,
                "line_num": int(m.group("line")),
                "error_type": m.group("type").lower(),
                "message": m.group("msg").strip(),
                "raw": line.strip(),
            })
    return rows


def annotate_source_with_errors(src_path: Path, errors: list[dict], compiler: str) -> str:
    """
    소스 파일 각 라인에 에러 주석을 달아서 반환.
    미팅 규칙: 에러 라인 번호 + 에러 내용을 주석으로 남김.
    """
    lines = src_path.read_text(encoding="utf-8").splitlines()
    error_map = {}
    for e in errors:
        ln = e["line_num"] - 1  # 0-indexed
        if ln not in error_map:
            error_map[ln] = []
        error_map[ln].append(e["message"])

    result = []
    for i, line in enumerate(lines):
        result.append(line)
        if i in error_map:
            for msg in error_map[i]:
                result.append(f"    # [{compiler} ERROR] {msg}")
    return "\n".join(result)


# ============================================================
# 메인
# ============================================================

def main():
    OUT_DIR.mkdir(parents=True, exist_ok=True)

    print("=" * 60)
    print("Step 4-3: 컴파일 및 에러 수집")
    print("=" * 60)

    if not SRC_ASM.exists():
        print(f"[오류] 테스트 파일 없음: {SRC_ASM}")
        print("       step4_test_generator.py 먼저 실행하세요.")
        return

    print(f"[대상] {SRC_ASM}")
    print(f"[환경] {'Windows (WSL 경유)' if IS_WINDOWS else 'Linux/macOS'}\n")

    all_errors: list[dict] = []

    # ── GNU as (GNU Binutils Assembler) ──────────────────────
    print("─" * 40)
    print("[1] GNU as (binutils assembler) 실행")
    as_out_path = OUT_DIR / "test_all_as.o"

    if IS_WINDOWS:
        src_wsl = str(SRC_ASM).replace("\\", "/")
        if len(src_wsl) >= 2 and src_wsl[1] == ":":
            drive = src_wsl[0].lower()
            src_wsl = f"/mnt/host/{drive}{src_wsl[2:]}"
        out_wsl = str(as_out_path).replace("\\", "/")
        if len(out_wsl) >= 2 and out_wsl[1] == ":":
            drive = out_wsl[0].lower()
            out_wsl = f"/mnt/host/{drive}{out_wsl[2:]}"

        raw_output, rc = run_via_wsl(f"as '{src_wsl}' -o '{out_wsl}'")
    else:
        result = subprocess.run(
            ["as", str(SRC_ASM), "-o", str(as_out_path)],
            capture_output=True, text=True
        )
        raw_output = result.stderr
        rc = result.returncode

    as_errors_path = OUT_DIR / "step4_as_errors.txt"
    as_errors_path.write_text(raw_output, encoding="utf-8")
    errors_as = parse_errors(raw_output, "as")
    all_errors.extend(errors_as)

    print(f"  returncode: {rc}")
    print(f"  에러 수: {len(errors_as)}")
    print(f"  원문 저장: {as_errors_path}")

    # ── GCC ─────────────────────────────────────────────────
    print("\n─" * 40)
    print("[2] GCC 실행 (gcc -c)")
    gcc_out_path = OUT_DIR / "test_all_gcc.o"

    if IS_WINDOWS:
        wsl_gcc_check, _ = run_via_wsl("which gcc")
        gcc_available = "gcc" in wsl_gcc_check
    else:
        gcc_available = subprocess.run(["which", "gcc"], capture_output=True).returncode == 0

    if gcc_available:
        _, raw_gcc, rc_gcc = run_assembler(["gcc", "-c"], SRC_ASM, gcc_out_path)
        gcc_errors_path = OUT_DIR / "step4_gcc_errors.txt"
        gcc_errors_path.write_text(raw_gcc, encoding="utf-8")
        errors_gcc = parse_errors(raw_gcc, "gcc")
        all_errors.extend(errors_gcc)
        print(f"  returncode: {rc_gcc}")
        print(f"  에러 수: {len(errors_gcc)}")
        print(f"  원문 저장: {gcc_errors_path}")
    else:
        print("  [스킵] gcc 미설치. 'sudo apt install gcc' 또는 WSL에 설치 필요.")

    # ── Clang ────────────────────────────────────────────────
    print("\n─" * 40)
    print("[3] Clang 실행 (clang -c)")
    clang_out_path = OUT_DIR / "test_all_clang.o"

    if IS_WINDOWS:
        wsl_clang_check, _ = run_via_wsl("which clang")
        clang_available = "clang" in wsl_clang_check
    else:
        clang_available = subprocess.run(["which", "clang"], capture_output=True).returncode == 0

    if clang_available:
        _, raw_clang, rc_clang = run_assembler(["clang", "-c"], SRC_ASM, clang_out_path)
        clang_errors_path = OUT_DIR / "step4_clang_errors.txt"
        clang_errors_path.write_text(raw_clang, encoding="utf-8")
        errors_clang = parse_errors(raw_clang, "clang")
        all_errors.extend(errors_clang)
        print(f"  returncode: {rc_clang}")
        print(f"  에러 수: {len(errors_clang)}")
        print(f"  원문 저장: {clang_errors_path}")
    else:
        print("  [스킵] clang 미설치. 'sudo apt install clang' 또는 WSL에 설치 필요.")

    # ── 에러 파싱 결과 CSV 저장 ─────────────────────────────
    print("\n─" * 40)
    print("[4] 에러 파싱 결과 저장")
    if all_errors:
        error_csv = OUT_DIR / "step4_error_lines.csv"
        import pandas as pd
        df_err = pd.DataFrame(all_errors)

        # 소스 라인 텍스트 병합
        src_lines = SRC_ASM.read_text(encoding="utf-8").splitlines()
        def get_src_line(ln):
            idx = ln - 1
            if 0 <= idx < len(src_lines):
                return src_lines[idx].strip()
            return ""
        df_err["source_line"] = df_err["line_num"].apply(get_src_line)

        df_err.to_csv(error_csv, index=False, encoding="utf-8")
        print(f"  저장: {error_csv}")
        print(f"  총 에러 행: {len(df_err)}")

        # 주석 달린 소스 파일 저장 (GNU as 기준)
        if errors_as:
            annotated = annotate_source_with_errors(SRC_ASM, errors_as, "as")
            annotated_path = OUT_DIR / "test_all_annotated.s"
            annotated_path.write_text(annotated, encoding="utf-8")
            print(f"  주석 달린 소스: {annotated_path}")
    else:
        print("  에러 없음 (모두 성공) 또는 컴파일러 미설치.")

    print(f"\n[완료] Step 4-3 컴파일 및 에러 수집 완료")
    print(f"       → {OUT_DIR}")


if __name__ == "__main__":
    main()

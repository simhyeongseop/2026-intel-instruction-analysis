"""
12단계 execute_edge_cases: 8회 후속 과제 4번("N.E./이상 케이스가 실제 CPU에서 어떻게
동작하는지 확인")을 위한 자동 실행 도구.

11단계(execute)가 손으로 만든 6개 시나리오를 돌린 것과 달리, 이 단계는 파이프라인이
이미 찾아낸 데이터(out/asm_result.csv)에서 대상을 **자동으로 골라** 실제로 실행한다:
SDM이 mode_support를 Invalid/N.E./N.S.로 명시했는데(expected_valid=False) `as`가 실제로
받아준(actual_result=="ok") 케이스들. "매뉴얼상 인코딩되면 안 되는데 어셈블러가 만들어낸
기계어를 실제 CPU에 넣으면 무슨 일이 벌어지는가"를 직접 관찰하는 것이 목적.

11단계와 같은 안전 원칙을 그대로 쓴다: 격리된 자식 프로세스 + 타임아웃, POSIX
returncode 부호로 정상종료/시그널 구분.

제외 대상: asm_line에 ".Ltarget"이 들어간 상대분기(Jcc/CALL/JMP rel) 계열은 뺀다.
이유: 이런 건 "인코딩이 안 되는 근접분기"가 아니라 컴파일 시점의 변위 크기 선택
문제(N.S. rel16 등)라서, 실행해봐야 그냥 근처로 점프하고 계속 진행할 뿐 CPU 동작에
대해 새로 알 수 있는 게 거의 없다(10단계에서 이미 이 패턴을 "검증 방법의 한계"로
문서화함). 이 필터는 ".Ltarget"이 있는 줄만 뺄 뿐이다 - 남는 대상 중엔 lahf/leave/sahf처럼
오퍼랜드가 아예 없는 명령어도 있다(codex 지적으로 "레지스터/메모리 오퍼랜드가 있는 케이스만
남는다"는 과장된 표현을 정정함). 그래도 상대분기 계열보다는 훨씬 다양한 실행 결과를 볼 수
있는 대상이 된다.

주의: 각 명령어를 실행할 때 레지스터(rax, eax 등)는 커널이 새 프로세스에 준 초기값
그대로다(값을 따로 설정하지 않음) - 정확한 값을 레지스터 덤프로 확인하지는 않았지만,
System V ABI상 유효한 데이터가 들어있다고 보장되지 않는 값이라 메모리 오퍼랜드
참조는 대체로 실패(주로 SIGSEGV)할 가능성이 높다. 이건 의도적이다: "정답이 뭔지 미리 알고 설계한" 테스트가 아니라
"매뉴얼에 없는 조합을 그냥 실행하면 무슨 일이 벌어지는지" 관찰하는 게 목적이므로,
관찰된 결과(SIGILL/SIGSEGV/exit0/...)를 그대로 기록하고 해석은 사람+codex가 한다.
"""

import csv
import os
import subprocess
import tempfile

from m11_execute import ASM_HEADER, EXIT_CLEAN, LD_CMD, LOAD_ADDR, AS_CMD, describe_returncode

IN_CSV = "out/asm_result.csv"
OUT_CSV = "out/edge_case_execution.csv"
OUT_REPORT = "out/edge_case_execution_report.md"

RUN_TIMEOUT = 3


def read_target_rows(path):
    rows = []
    with open(path, encoding="utf-8") as f:
        for row in csv.DictReader(f):
            if row["actual_result"] != "ok":
                continue
            if row["expected_valid"].strip().lower() != "false":
                continue
            if ".Ltarget" in row["asm_line"]:
                continue
            rows.append(row)
    return rows


def build_and_run_one(asm_line, name, tmp_dir):
    tmp_s = os.path.join(tmp_dir, f"{name}.s")
    tmp_o = os.path.join(tmp_dir, f"{name}.o")
    tmp_bin = os.path.join(tmp_dir, f"{name}.bin")

    with open(tmp_s, "w", encoding="utf-8", newline="\n") as f:
        f.write(ASM_HEADER + "    " + asm_line + EXIT_CLEAN)

    # as/ld 자체가 멈추는 경우도 있을 수 있어(예: 잘못된 입력으로 무한루프) 이 두 단계도
    # 타임아웃 예외를 개별적으로 잡는다 - 안 잡으면 이 한 건 때문에 전체 배치가 중단된다
    # (codex 지적 반영).
    try:
        asm_result = subprocess.run(AS_CMD + ["-o", tmp_o, tmp_s], capture_output=True, text=True, timeout=10)
    except subprocess.TimeoutExpired:
        return "assemble_timeout", ""
    if asm_result.returncode != 0:
        return "assemble_error", asm_result.stderr.strip()

    try:
        ld_result = subprocess.run(
            LD_CMD + ["-o", tmp_bin, tmp_o, f"-Ttext={LOAD_ADDR}", "-e", "_start"],
            capture_output=True, text=True, timeout=10,
        )
    except subprocess.TimeoutExpired:
        return "link_timeout", ""
    if ld_result.returncode != 0:
        return "link_error", ld_result.stderr.strip()

    try:
        run_result = subprocess.run([tmp_bin], timeout=RUN_TIMEOUT)
        return describe_returncode(run_result.returncode), ""
    except subprocess.TimeoutExpired:
        return "timeout_hang", ""


def main():
    rows = read_target_rows(IN_CSV)
    out_rows = []
    outcome_counts = {}

    with tempfile.TemporaryDirectory(prefix="m12_edge_") as tmp_dir:
        for row in rows:
            combo_id = row["combo_id"]
            outcome, error = build_and_run_one(row["asm_line"], f"combo_{combo_id}", tmp_dir)
            outcome_counts[outcome] = outcome_counts.get(outcome, 0) + 1
            out_rows.append({
                "combo_id": combo_id,
                "mnemonic": row["mnemonic"],
                "asm_line": row["asm_line"],
                "mode_support": row["mode_support"],
                "outcome": outcome,
                "error": error,
            })
            print(f"{combo_id} {row['mnemonic']:12s} {row['asm_line']:35s} -> {outcome}")

    fieldnames = ["combo_id", "mnemonic", "asm_line", "mode_support", "outcome", "error"]
    with open(OUT_CSV, "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(out_rows)

    write_report(out_rows, outcome_counts)

    print(f"\n대상: {len(rows)}건")
    for key, value in sorted(outcome_counts.items(), key=lambda kv: -kv[1]):
        print(f"  {key}: {value}")
    print(f"출력: {OUT_CSV}, {OUT_REPORT}")


def write_report(out_rows, outcome_counts):
    lines = []
    lines.append("# N.E./N.S./Invalid 케이스 실제 CPU 실행 결과 (12단계)\n")
    lines.append("SDM이 mode_support=Invalid/N.E./N.S.로 명시했는데 `as`가 실제로 어셈블에 "
                  "성공한 케이스들을 실제로 실행해봤다. 레지스터는 커널이 준 초기값 그대로")
    lines.append("(레지스터 덤프로 확인하진 않았으나 유효하다고 보장되지 않는 값)이고 "
                  "따로 설정하지 않았다 - '무슨 일이 일어나는지 관찰'이 목적이지")
    lines.append("'특정 결과를 재현'하려는 게 아니다.\n")

    lines.append("## 결과 분포\n")
    lines.append("| outcome | 건수 |")
    lines.append("|---|---|")
    for key, value in sorted(outcome_counts.items(), key=lambda kv: -kv[1]):
        lines.append(f"| {key} | {value} |")
    lines.append("")

    lines.append("## 전체 케이스\n")
    lines.append("| combo_id | mnemonic | asm_line | mode_support | outcome |")
    lines.append("|---|---|---|---|---|")
    for row in out_rows:
        lines.append(f"| {row['combo_id']} | {row['mnemonic']} | `{row['asm_line']}` | "
                      f"{row['mode_support']} | **{row['outcome']}** |")
    lines.append("")

    with open(OUT_REPORT, "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + "\n")


if __name__ == "__main__":
    main()

"""CPU 실행 관측: 소스 한 줄을 GNU as/ld로 고정 주소 실행파일로 만들어 격리된 자식 프로세스로 실행한다.

예전 11단계(m11_execute)에서 3단계 --execute와 충돌 확인 스크립트가 쓰던 부분만 옮겼다.
POSIX에서 returncode가 음수면 그 절댓값이 프로세스를 죽인 시그널 번호다(-11=SIGSEGV, -4=SIGILL).
타임아웃은 행(hang)으로 기록한다. 관측 결과는 ISA 의미 확정이 아니다.
"""

import os
import signal
import subprocess

from pipeline import toolchain as T

AS_CMD = [T.AS, "--64", "-mintel64"]
LD_CMD = [T.LD]
LOAD_ADDR = "0x400000"  # -fno-pie 스타일 고정 주소

ASM_HEADER = ".intel_syntax noprefix\n.global _start\n.text\n_start:\n"
# 정상 종료: exit(0) 시스템 호출
EXIT_CLEAN = "\n    mov eax, 60\n    xor edi, edi\n    syscall\n"


def describe_returncode(rc):
    if rc == 0:
        return "exit0"
    if rc > 0:
        return f"exit{rc}"
    try:
        return signal.Signals(-rc).name
    except ValueError:
        return f"signal{-rc}"


def build_and_run(case, tmp_dir):
    """case = {"name", "body"}. 어셈블 -> 고정주소 링크 -> 타임아웃 실행. (상태, 오류, 소스 경로)"""
    tmp_s = os.path.join(tmp_dir, f"{case['name']}.s")
    tmp_o = os.path.join(tmp_dir, f"{case['name']}.o")
    tmp_bin = os.path.join(tmp_dir, f"{case['name']}.bin")

    with open(tmp_s, "w", encoding="utf-8", newline="\n") as f:
        f.write(ASM_HEADER + "    " + case["body"])

    asm_result = subprocess.run(AS_CMD + ["-o", tmp_o, tmp_s], capture_output=True, text=True, timeout=10)
    if asm_result.returncode != 0:
        return "assemble_error", asm_result.stderr.strip(), tmp_s

    ld_result = subprocess.run(
        LD_CMD + ["-o", tmp_bin, tmp_o, f"-Ttext={LOAD_ADDR}", "-e", "_start"],
        capture_output=True, text=True, timeout=10,
    )
    if ld_result.returncode != 0:
        return "link_error", ld_result.stderr.strip(), tmp_s

    try:
        run_result = subprocess.run([tmp_bin], timeout=3)
        return describe_returncode(run_result.returncode), "", tmp_s
    except subprocess.TimeoutExpired:
        return "timeout_hang", "", tmp_s

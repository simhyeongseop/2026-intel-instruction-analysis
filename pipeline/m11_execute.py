"""
11단계 execute: 8회 미팅 후속 과제 3번(절대주소/주소체계 테스트)의 구현.

지금까지(1~10단계)는 "어셈블/역어셈블이 되는가"만 봤다. 이 단계는 실제로
바이너리를 만들어서 **실행**하고, 그 결과(정상 종료/시그널)를 관찰한다.

교수님 요청 요지:
- -fno-pie 등으로 고정 주소를 쓰는 환경 구성
- 64비트 주소체계에서 32비트 vs 64비트 레지스터/메모리 표현이 스펙대로 동작하는지 확인
- 레지스터에 실제 함수 주소를 넣고 호출 + 주소 일부에 쓰레기 값을 넣어 동작 변화 확인

방법: GNU as/ld로 실제 ELF 실행파일을 고정 주소(-Ttext)에 만들어서, **격리된 자식
프로세스**(subprocess.run)로 **타임아웃**을 걸고 실행한다. POSIX에서 subprocess의
returncode가 음수면 그 절댓값이 프로세스를 죽인 시그널 번호다(예: -11=SIGSEGV,
-4=SIGILL) - ptrace 등 복잡한 장치 없이 이 성질만으로 정상종료/크래시를 구분할 수
있다. 타임아웃에 걸리면 무한루프/행(hang)으로 간주한다.

이 단계는 CLAUDE.md의 "소규모 정답지" 정신을 따른다 - combos.csv에서 자동 생성하는
대신, 형섭이 이해할 수 있는 손으로 만든 시나리오 몇 개를 아래 TEST_CASES에 직접
적는다. 각 케이스는 왜 그 결과가 나와야 하는지 주석으로 설명한다.
"""

import csv
import os
import signal
import subprocess
import tempfile

OUT_CSV = "out/address_test_result.csv"

AS_CMD = ["as", "--64", "-mintel64"]
LD_CMD = ["ld"]
LOAD_ADDR = "0x400000"  # -fno-pie 스타일 고정 주소 (기본 no-pie 로드 주소와 동일 대역)

ASM_HEADER = ".intel_syntax noprefix\n.global _start\n.text\n_start:\n"
# 모든 케이스는 살아남으면 sys_exit(0)으로 깔끔히 끝난다 - 그래야 "정상 종료"와
# "크래시"를 exit code만으로 확실히 구분할 수 있다.
EXIT_CLEAN = "\n    mov eax, 60\n    xor edi, edi\n    syscall\n"

TEST_CASES = [
    {
        "name": "call_valid_function_ptr_64bit",
        "expect": "exit0",
        "note": "정상 케이스(대조군): RIP-relative로 구한 진짜 함수 주소를 64비트 "
                "레지스터(rax)에 넣고 call. SDM대로 정상 실행되어야 한다.",
        "body": "lea rax, [rip+target_func]\n    call rax" + EXIT_CLEAN + "target_func:\n    ret\n",
    },
    {
        "name": "call_garbage_upper32_64bit",
        "expect": "sigsegv",
        "note": "진짜 함수 주소의 상위 32비트를 쓰레기 값(0xDEADBEEF)으로 덮어써서 "
                "call. 정확한 메커니즘(codex 검증 2라운드 반영): x86-64는 가상주소가 "
                "'canonical'해야 한다는 규칙이 있다(4-level paging에선 47비트, "
                "5-level paging에선 56비트를 넘는 상위 비트가 그 최상위 비트의 부호 "
                "확장이어야 함 - 상위 32비트를 0xDEADBEEF로 덮어쓴 이 결과 주소는 "
                "어느 기준으로도 그 부호 확장 규칙을 어겨 non-canonical이 된다). "
                "이 규칙을 어기면 페이지테이블을 조회하기도 전에 CPU가 즉시 "
                "#GP(General Protection fault)를 낸다(단순히 '매핑 안 된 주소라서 "
                "페이지폴트'와는 다른 메커니즘). 리눅스는 #GP든 페이지 부재로 인한 "
                "#PF든 둘 다 SIGSEGV로 유저 프로세스에 전달하므로 관측되는 시그널은 "
                "같다. '주소 상위 절반은 무시해도 된다'는 32비트식 가정이 64비트 "
                "환경에서는 틀렸음을 보여주는 케이스.",
        "body": ("lea rax, [rip+target_func]\n"
                 "    mov r10, 0xDEADBEEF00000000\n"
                 "    or rax, r10\n"
                 "    call rax" + EXIT_CLEAN + "target_func:\n    ret\n"),
    },
    {
        "name": "call_via_32bit_register_truncated",
        "expect": "exit0",
        "note": "함수 주소를 32비트 레지스터(eax)에만 넣고 64비트 컨텍스트에서 그걸로 "
                "call하면, eax->rax로 갈 때 상위 32비트가 자동 zero-extension된다. "
                "이 스크립트의 고정 로드 주소(0x400000)는 32비트 안에 확실히 들어가는 "
                "값이므로, 이 결과는 우연이 아니라 **이 주소 배치에서는 결정적으로 "
                "exit0**이다(codex 검증에서 '우연히'라는 표현이 부정확하다고 지적받아 "
                "정정 - zero-extension으로 상위 32비트가 0이 되고, 원래 주소도 상위가 "
                "0이었으니 값 자체가 안 바뀐다). 이것만으로는 truncation의 위험을 "
                "증명하지 못한다 - 실제 위험은 아래 "
                "`truncate_high_stack_address_to_32bit` 케이스에서 4GiB를 넘는 진짜 "
                "고주소(스택)로 대조한다.",
        "body": "lea rax, [rip+target_func]\n    mov eax, eax\n    call rax" + EXIT_CLEAN + "target_func:\n    ret\n",
    },
    {
        "name": "truncate_high_stack_address_to_32bit",
        "expect": "sigsegv",
        "run_wrapper": ["setarch", "x86_64", "-R"],
        "note": "리눅스 x86-64에서 스택 주소는 항상 4GiB(32비트 범위)를 훨씬 넘는 "
                "높은 주소(보통 0x7fxxxxxxxxxx대)에 있다. rsp(스택 포인터, 확실히 "
                "고주소)를 32비트 레지스터 연산으로 '32비트로 자르면' 원래 스택과 "
                "전혀 다른 낮은 주소가 되고, 그 주소를 읽으면 SIGSEGV가 나야 한다 - "
                "교수님이 요청한 '32비트 vs 64비트 표현' 실제 위험 시연이다.\n"
                "정정(codex 지적, 2차/3차 - 추측이 아니라 실측으로 확인함): 이 "
                "실행파일과 별도 테스트 바이너리에 `/proc/self/maps`를 직접 읽어 "
                "표준출력으로 찍어보게 해서 실제 매핑을 확인했다(`setarch x86_64 -R` "
                "적용 상태). 결과: 낮은 주소 쪽엔 `0x3ff000-0x400000`(ELF 헤더, "
                "r--p), `0x400000-0x401000`(.text, r-xp), `0x401000-0x402000`(.bss, "
                "rw-p)만 있고, 그 다음 매핑은 곧바로 `0x7ffff7ff7000`대(vvar/vdso)와 "
                "`0x7ffffffde000-0x7ffffffff000`(스택)로 건너뛴다 - 즉 "
                "`0x402000`부터 `0x7ffff7ff6fff`까지는 실측으로 확인된 **거대한 "
                "미매핑 공백**이다. rsp를 32비트로 자른 값 - 스택 범위 "
                "`0x7ffffffde000~0x7ffffffff000`의 하위 32비트, 즉 마지막 8자리인 "
                "`0xfffde000~0xfffff000`(codex 지적으로 자릿수 계산 오류 정정: "
                "이전엔 `0xffffde00~0xffffff00`로 잘못 적었다) - 은 이 공백 안에 "
                "확실히 들어간다.\n"
                "이 실측(readelf/proc-maps)은 **`setarch x86_64 -R`로 ASLR을 끈 "
                "조건**에서 한 번 확인한 것이다 - ASLR을 켠 채 여러 번 실행해도 "
                "매번 이 공백 안에 남는다는 것까지 일반적으로 증명한 건 아니므로, "
                "이 SIGSEGV 근거는 'setarch로 고정한 이 조건에서'로 범위를 "
                "한정한다(codex 지적 반영 - 과잉 일반화하지 않음).",
        "body": ("mov rax, rsp\n"
                 "    mov eax, eax\n"
                 "    mov rbx, [rax]" + EXIT_CLEAN),
    },
    {
        "name": "jmp_null_address",
        "expect": "sigsegv",
        "note": "주소 레지스터를 아예 0(널)으로 만들고 jmp. 매핑 안 된 0페이지라 "
                "SIGSEGV가 나야 한다 - 가장 기본적인 대조군.",
        "body": "xor rax, rax\n    jmp rax" + EXIT_CLEAN,
    },
    {
        "name": "call_misaligned_valid_range_address",
        "expect": "sigsegv",
        "note": "유효한 함수 주소에서 1바이트 어긋난 위치로 call. 실제 원인 추적:\n"
                "  1) objdump -d로 확인 - target_func(0xC3, ret)는 .text의 마지막 "
                "바이트이고, target_func+1은 파일에 있는 바이트가 아니다.\n"
                "  2) 그 주소의 실제 런타임 바이트 값을 추측하지 않고 직접 읽어서 "
                "확인했다: `movzx edi, byte ptr [target_func+1]; mov eax,60; syscall`로 "
                "그 바이트 값을 그대로 exit code로 만들어보니 실제로 0(exit code 0)이 "
                "나왔다 - '커널이 어차피 0으로 채웠을 것'이라는 추측이 아니라 실측값이다 "
                "(codex가 objdump -s만으로는 이걸 증명 못 한다고 지적해서 별도로 읽기 "
                "테스트를 만들어 확인함, 코드에는 안 남기고 이 note에만 기록).\n"
                "  3) 0x00 0x00을 명령으로 해석하면 'add byte ptr [rax], al'이 되고, "
                "이때 rax는 실행 중인 자기 주소(target_func+1)를 가리킨다 - readelf -l로 "
                "확인한 대로 이 주소가 속한 PT_LOAD 세그먼트가 'R E'(쓰기 불가)라서, "
                "그 주소에 쓰기를 시도하면 SIGSEGV가 난다.\n"
                "'W^X 보호'라는 표현은 부정확 - 이건 별도의 보안 기능이 아니라 그냥 "
                "이 PT_LOAD 세그먼트에 W 플래그가 없는 것뿐이다(codex 지적 반영).",
        "body": "lea rax, [rip+target_func]\n    inc rax\n    call rax" + EXIT_CLEAN + "target_func:\n    ret\n",
    },
]

EXPECT_SETS = {
    "exit0": {"exit0"},
    "sigsegv": {"SIGSEGV"},
}


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
    """어셈블 -> 고정주소 링크 -> 격리된 자식 프로세스로 타임아웃 실행."""
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

    run_cmd = case.get("run_wrapper", []) + [tmp_bin]
    try:
        run_result = subprocess.run(run_cmd, timeout=3)
        return describe_returncode(run_result.returncode), "", tmp_s
    except subprocess.TimeoutExpired:
        return "timeout_hang", "", tmp_s


def main():
    out_rows = []
    with tempfile.TemporaryDirectory(prefix="m11_exec_") as tmp_dir:
        for case in TEST_CASES:
            actual, error, src_path = build_and_run(case, tmp_dir)
            match = actual in EXPECT_SETS[case["expect"]]
            out_rows.append({
                "name": case["name"],
                "expect": case["expect"],
                "actual": actual,
                "match": match,
                "note": case["note"],
                "error": error,
            })
            print(f"{case['name']}: expect={case['expect']} actual={actual} "
                  f"{'OK' if match else '!! 불일치'}")

    fieldnames = ["name", "expect", "actual", "match", "note", "error"]
    with open(OUT_CSV, "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(out_rows)

    mismatches = [r for r in out_rows if not r["match"]]
    print(f"\n총 {len(out_rows)}건, 불일치 {len(mismatches)}건")
    print(f"출력: {OUT_CSV}")


if __name__ == "__main__":
    main()

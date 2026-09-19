"""생성기 수정 라운드의 회귀 기대값 표를 만든다.

목적: `m3_combine.py`/`m4_generate.py`를 고치기 **전에** "무엇을 어떤 값으로 바꿀
것인지"를 고정하고, 그 기대값이 실제 도구에서 어떻게 처리되는지를 사람 손이 아니라
도구 실행 결과로 기록한다.

- before: 수정 전 스냅샷(`tests/baseline/combos_2026-09-15.csv`)의 줄.
  현재 `out/tests.s`에서 읽으면 수정 후에는 before == after 가 되어 대조가 사라진다.
- after: 이번 라운드에서 생성기가 만들어야 하는 줄 (사람이 SDM을 보고 정한 목표)
- as_*/clang_*: 두 줄을 각각 as/clang에 넣어 그 자리에서 관측한 결과

여기서 as가 수용했다는 사실은 "그 줄이 SDM 의미대로 동작한다"는 뜻이 아니다.
수용 여부와 바이트만 기록한다(CLAUDE.md 작업 기준).

실행: python3 scripts/build_fix_expectations.py
"""

import csv
import os
from pathlib import Path
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]
BASELINE = ROOT / "tests/baseline/combos_2026-09-15.csv"
OUT_CSV = ROOT / "tests/expectations/generator_fix_expectations.csv"

ASM_HEADER = ".intel_syntax noprefix\n.Ltarget:\n"

OUT_COLUMNS = [
    "family", "kind", "base_combo_id", "mnemonic", "mode_support",
    "before", "as_before", "after", "as_after", "bytes_after", "clang_after",
    "근거",
]

# kind:
#   fix     - mode_support=Valid 인데 우리 생성 값이 틀렸다. after 로 바꾼다.
#   keep    - 매뉴얼이 Invalid/N.E./N.S. 로 규정한 행. 거부가 정상이므로 그대로 둔다.
#   variant - 기존 값은 combo_index 0 에 두고, after 를 새 combo_index 로 덧붙인다.
TARGETS = [
    # ---- fix: m512 등 고정 크기 블록에 zmmword ptr 를 붙인 것 ----
    ("m512_size_prefix", "fix", "143", "aesdec256kl xmm0, [eax]",
     "SDM의 m512는 512바이트 블록이고 zmm 레지스터 크기 지시자가 아니다."),
    ("m512_size_prefix", "fix", "1031", "enqcmd ecx, [eax]",
     "ENQCMD 목적지는 64바이트 큐 항목. 크기 지시자를 쓰지 않는다."),
    ("m512_size_prefix", "fix", "1193", "fxsave [eax]",
     "m512byte(512바이트 저장 영역)에는 대응하는 Intel 크기 키워드가 없다."),
    ("m512_size_prefix", "fix", "1536", "ldtilecfg [eax]",
     "AMX 타일 설정 영역 64바이트. 크기 지시자를 쓰지 않는다."),
    # ---- fix: 모드/폭 제약을 반영하지 못한 레지스터 선택 ----
    ("mode_register_width", "fix", "1782", "movdir64b ecx, [eax]",
     "64비트 모드에서 16비트 주소 레지스터는 쓸 수 없다. 주소 폭과 레지스터 폭을 맞춘다."),
    ("mode_register_width", "fix", "4599", "umonitor ecx",
     "r16/r32/r64 중 64비트 모드에서 유효한 폭을 고른다(16비트 주소 불가)."),
    ("mode_register_width", "fix", "4274", "senduipi rcx",
     "SENDUIPI reg 는 64비트 모드에서 r64."),
    # ---- fix: 암묵 오퍼랜드를 명시 오퍼랜드로 적은 것 ----
    ("implicit_operand", "fix", "156", "aesdecwide128kl [eax]",
     "<XMM0-7>은 암묵 오퍼랜드 표기이므로 소스에 적지 않는다."),
    ("implicit_operand", "fix", "157", "aesdecwide256kl [eax]",
     "<XMM0-7> 제거 + m512 크기 지시자 제거."),
    ("implicit_operand", "fix", "1247", "hreset 1",
     "<EAX>는 암묵 오퍼랜드."),
    ("implicit_operand", "fix", "1027", "encodekey128 ecx, ecx",
     "<XMM0-2>, <XMM4-6>은 암묵 오퍼랜드."),
    ("implicit_operand", "fix", "1554", "loadiwkey xmm0, xmm0",
     "<EAX>, <XMM0>은 암묵 오퍼랜드."),
    ("implicit_operand", "fix", "4573", "tpause ecx",
     "<edx>, <eax>는 암묵 오퍼랜드. 현재 줄은 as가 받아주지만 Clang은 거부한다."),
    # ---- fix: 매뉴얼 표기를 그대로 옮긴 것 ----
    ("raw_notation", "fix", "5934", "vp2intersectd k1, xmm0, xmm0",
     "k1+1은 마스크 쌍 표기이지 덧셈식이 아니다. 쌍의 첫 레지스터를 적는다."),
    ("raw_notation", "fix", "7235", "v4fmaddps zmm0, zmm2, xmmword ptr [eax]",
     "zmm2+3은 연속 레지스터 블록 표기. 블록의 첫 레지스터를 적는다."),
    ("raw_notation", "fix", "6953", "vreducesd xmm0, xmm0, xmm0, 1",
     "imm8/r 은 추출 단계에서 남은 표기. 즉시값으로 취급한다."),
    # ---- fix: moffs 를 일반 메모리 오퍼랜드로 만든 것 ----
    ("moffs_encoding", "fix", "1684", "mov al, ds:0x123456789abcdef0",
     "moffs 행(A0)은 64비트 절대 주소를 요구한다. [0x1000]은 ModRM 인코딩(8A)으로 간다."),
    ("moffs_encoding", "fix", "1686", "mov ax, ds:0x123456789abcdef0",
     "moffs16 행(66 A1) 타격. 현재 값은 ModRM 인코딩으로 간다."),
    # ---- fix: 문자열 명령어의 누산기 표기 ----
    ("string_accumulator", "fix", "4051", "rep lods byte ptr [rsi]",
     "SDM은 'REP LODS AL'로 적지만 as는 읽어올 메모리 오퍼랜드를 요구한다. 같은 인코딩(AC)의 다른 표기."),
    # ---- variant: 주소 폭과 레지스터 폭을 함께 바꾼 메모리 변형 ----
    ("variant_memory_paired", "variant", "1031", "enqcmd rcx, [rax+rbx*4+0x10]",
     "ENQCMD는 레지스터 폭과 주소 폭이 같아야 한다. 주소만 64비트로 바꾸면 as가 거부한다."),
    # ---- keep: 매뉴얼이 64비트 모드에서 무효로 규정한 행 ----
    ("expected_rejection", "keep", "322", "bndcl bnd0, ecx",
     "BNDCL bnd, r/m32 은 64비트 모드 N.E. as의 거부가 매뉴얼 기대와 일치한다."),
    ("expected_rejection", "keep", "1330", "invpcid ecx, xmmword ptr [eax]",
     "INVPCID r32, m128 은 64비트 모드 N.E."),
    ("expected_rejection", "keep", "4034", "rdpid ecx",
     "RDPID r32 는 64비트 모드 N.E."),
    # ---- keep/조사: rel16 행은 64비트 모드에서 입력으로 표현할 수 없다 ----
    ("rel16_not_targetable", "keep", "414", "call .Ltarget",
     "CALL rel16 은 N.S. 현재 입력은 rel32로 어셈블되므로 그 행을 시험한 것이 아니다."),
    ("rel16_not_targetable", "variant", "414", "data16 call .Ltarget",
     "data16 접두어로 rel16 을 시도한 관측용 변형. 결과 바이트를 기록만 한다."),
    # ---- variant: 메모리 형태 다양화 (교수님 4·5회 요청) ----
    ("variant_memory_sib", "variant", "75", "add ecx, dword ptr [rax+rbx*4+0x10]",
     "base+index*scale+disp 형태. 현재는 [eax] 한 종류뿐이다."),
    ("variant_memory_rip", "variant", "75", "add ecx, dword ptr [rip+0x10]",
     "rip 상대 주소. 현재 생성 입력에 0건이다."),
    # ---- variant: 즉시값 ----
    ("variant_imm_max", "variant", "8", "adc eax, 0x7fffffff",
     "해당 폭의 최대 양수. 0xffffffff 는 as가 부호확장 imm8(83 /2)로 줄이므로 쓰지 않는다. "
     "0x7fffffff 는 축약되지 않아 의도한 imm32 인코딩 행을 그대로 때린다."),
    # ---- variant: AVX-512 장식 ----
    ("variant_avx512_mask", "variant", "88", "vaddpd zmm0 {k1}{z}, zmm0, zmm0",
     "{k1}{z} 표기. 현재는 장식을 지워서 마스크 있는 행을 시험하지 못한다."),
    ("variant_avx512_bcst", "variant", "89", "vaddpd zmm0, zmm0, qword ptr [eax]{1to8}",
     "m64bcst 브로드캐스트 표기."),
]


def read_baseline_lines(path):
    """수정 전 스냅샷에서 combo_id -> 그때의 명령어 줄을 읽는다."""
    lines = {}
    with open(path, newline="", encoding="utf-8") as f:
        for row in csv.DictReader(f):
            lines[row["combo_id"]] = f"{row['mnemonic'].lower()} {row['operands']}".strip()
    return lines


def read_combo_meta(path):
    """combos.csv 에서 combo_id -> (mnemonic, mode_support) 를 읽는다."""
    meta = {}
    with open(path, newline="", encoding="utf-8") as f:
        for row in csv.DictReader(f):
            meta[row["combo_id"]] = (row["mnemonic"], row["mode_support"])
    return meta


def assemble(tool, code, tmp_dir):
    """한 줄을 as 또는 clang 에 넣고 (상태, 상세) 를 돌려준다.

    상태는 accepted/rejected. 상세는 수용이면 .text 바이트, 거부면 에러 한 줄.
    """
    src = os.path.join(tmp_dir, "line.s")
    obj = os.path.join(tmp_dir, "line.o")
    with open(src, "w", encoding="utf-8", newline="\n") as f:
        f.write(ASM_HEADER + code + "\n")

    if tool == "as":
        cmd = ["as", "--64", "-mintel64", "-o", obj, src]
    else:
        cmd = ["clang", "-c", "-x", "assembler", "-o", obj, src]
    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.returncode != 0:
        return "rejected", first_error(result.stderr)
    return "accepted", text_bytes(obj)


def first_error(stderr):
    """어셈블러 stderr 에서 에러 한 줄만 뽑는다."""
    for line in (stderr or "").splitlines():
        if "Error" in line or "error" in line:
            return line.split(":", 3)[-1].strip()
    return "unknown error"


def text_bytes(obj_path):
    """objdump 로 .text 바이트를 뽑아 공백으로 이어 붙인다."""
    dump = subprocess.run(["objdump", "-d", "-M", "intel", obj_path],
                          capture_output=True, text=True)
    out = []
    for line in dump.stdout.splitlines():
        parts = line.split("\t")
        if len(parts) >= 2 and parts[0].strip().endswith(":"):
            out.append(parts[1].strip())
    return " ".join(out)


def build_rows(generated, meta, tmp_dir):
    """TARGETS 한 줄씩 실제 도구에 넣어 기대값 표의 행을 만든다."""
    rows = []
    for family, kind, combo_id, after, evidence in TARGETS:
        before = generated.get(combo_id, "")
        mnemonic, mode_support = meta.get(combo_id, ("", ""))
        as_before = assemble("as", before, tmp_dir)[0] if before else ""
        as_after, detail_after = assemble("as", after, tmp_dir)
        clang_after = assemble("clang", after, tmp_dir)[0]
        rows.append({
            "family": family,
            "kind": kind,
            "base_combo_id": combo_id,
            "mnemonic": mnemonic,
            "mode_support": mode_support,
            "before": before,
            "as_before": as_before,
            "after": after,
            "as_after": as_after,
            "bytes_after": detail_after,
            "clang_after": clang_after,
            "근거": evidence,
        })
    return rows


def main():
    generated = read_baseline_lines(BASELINE)
    meta = read_combo_meta(ROOT / "data/db/combos.csv")
    with tempfile.TemporaryDirectory(prefix="fix_expect_") as tmp_dir:
        rows = build_rows(generated, meta, tmp_dir)

    OUT_CSV.parent.mkdir(parents=True, exist_ok=True)
    with open(OUT_CSV, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=OUT_COLUMNS)
        writer.writeheader()
        for row in rows:
            writer.writerow(row)

    fixes = sum(1 for r in rows if r["kind"] == "fix")
    keeps = sum(1 for r in rows if r["kind"] == "keep")
    variants = sum(1 for r in rows if r["kind"] == "variant")
    print(f"기대값 행 수: {len(rows)} (fix={fixes}, keep={keeps}, variant={variants})")
    print(f"CSV 저장: {OUT_CSV}")


if __name__ == "__main__":
    main()

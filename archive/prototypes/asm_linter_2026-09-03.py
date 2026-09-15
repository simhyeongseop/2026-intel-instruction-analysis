#!/usr/bin/env python3
"""
역사적 프로토타입 (2026-09-03). 현재 도구는 scripts/asm_linter.py를 사용한다.

목적 (CLAUDE.md 0절): "매뉴얼대로 작성했는데 어셈블러가 제대로 처리하지 못하는 경우"를
사용자가 어셈블리 한 줄을 쓰는 시점에 바로 알려준다.

동작 방식 (형섭이 정한 설계 3가지):
  1) 동적-정적 혼합: 정적 규칙으로 먼저 검사하고, 실제 as/clang을 조용히 돌려
     "진짜 에러 메시지"를 가져와 우리 해설을 덧붙인다.
  2) 사전 정적 분석 기반: 정적 규칙이 먼저 플래그를 세우고, 어셈블러가 실패하면
     그 플래그의 해설을 에러 밑에 붙인다. (어셈블러 에러 문구가 버전마다 바뀌어도 안 깨짐)
  3) 실용주의: 어셈블러가 통과시켰어도 매뉴얼 기준과 다르면 강한 경고 대신
     "[참고]" 수준의 정보성 메시지만 띄운다.

주의: as/clang/objdump는 WSL(Ubuntu)에만 있다. Windows에서 돌리면 정적 검사만 된다
      (자동으로 정적 전용 모드로 내려간다).

사용법:
  python3 scripts/asm_linter.py "lss rcx, fword ptr [eax]"
  python3 scripts/asm_linter.py -f out/tests.s
  python3 scripts/asm_linter.py --demo
  python3 scripts/asm_linter.py --static-only "mov ds, qword ptr [eax]"
"""

import argparse
import csv
import os
import re
import subprocess
import sys
import tempfile

# 이 스크립트는 한국어를 출력한다. Windows 콘솔(cp949)에서 죽지 않게 UTF-8로 고정한다.
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ISA_DB = "data/db/isa_db.csv"

# as에 넘기는 옵션. 파이프라인 5단계(m5_assemble.py)와 똑같이 맞춰야 결과가 일치한다.
AS_OPTS = ["--64", "-mintel64"]
AS_OPTS_PLAIN = ["--64"]        # -mintel64 없이도 되는지 비교용
ASM_HEADER = ".intel_syntax noprefix\n.Ltarget:\n"


# ---------------------------------------------------------------- 오퍼랜드 파서

# Intel 크기 지시자 -> 비트수
PTR_SIZES = {
    "byte": 8, "word": 16, "dword": 32, "fword": 48,
    "qword": 64, "tbyte": 80, "xmmword": 128, "ymmword": 256, "zmmword": 512,
}

SREGS = ("cs", "ds", "es", "fs", "gs", "ss")


def build_reg_table():
    """레지스터 이름 -> 비트수 표를 만든다."""
    regs = {}
    for name in ("al", "bl", "cl", "dl", "ah", "bh", "ch", "dh",
                 "spl", "bpl", "sil", "dil"):
        regs[name] = 8
    for name in ("ax", "bx", "cx", "dx", "si", "di", "bp", "sp"):
        regs[name] = 16
    for name in ("eax", "ebx", "ecx", "edx", "esi", "edi", "ebp", "esp"):
        regs[name] = 32
    for name in ("rax", "rbx", "rcx", "rdx", "rsi", "rdi", "rbp", "rsp"):
        regs[name] = 64
    for i in range(8, 16):
        regs["r%db" % i] = 8
        regs["r%dw" % i] = 16
        regs["r%dd" % i] = 32
        regs["r%d" % i] = 64
    for i in range(32):
        regs["xmm%d" % i] = 128
        regs["ymm%d" % i] = 256
        regs["zmm%d" % i] = 512
    for i in range(8):
        regs["mm%d" % i] = 64
        regs["st%d" % i] = 80
    for i in range(8):
        regs["k%d" % i] = 64
        regs["bnd%d" % i] = 128
    return regs


REGS = build_reg_table()

PTR_RE = re.compile(r"^(byte|word|dword|fword|qword|tbyte|xmmword|ymmword|zmmword)\s+ptr\b")
IMM_RE = re.compile(r"^(0x[0-9a-f]+|-?\d+)$")


def parse_operand(text):
    """오퍼랜드 문자열 하나를 {kind, bits, raw}로 분해한다.

    kind: reg / sreg / mem / imm / label / unknown
    bits: 아는 경우만 숫자, 모르면 None (예: 크기 지시자 없는 [eax])
    """
    raw = text.strip()
    low = raw.lower()

    # 1) 크기 지시자가 붙은 메모리: "fword ptr [eax]"
    match = PTR_RE.match(low)
    if match:
        return {"kind": "mem", "bits": PTR_SIZES[match.group(1)],
                "ptr_name": match.group(1), "raw": raw}

    # 2) 크기 지시자 없는 메모리: "[eax]", "es:[eax]"
    if "[" in low:
        return {"kind": "mem", "bits": None, "ptr_name": None, "raw": raw}

    # 3) 세그먼트 레지스터 (항상 16비트 셀렉터)
    if low in SREGS:
        return {"kind": "sreg", "bits": 16, "ptr_name": None, "raw": raw}

    # 4) 일반 레지스터
    if low in REGS:
        return {"kind": "reg", "bits": REGS[low], "ptr_name": None, "raw": raw}

    # 5) 즉시값
    if IMM_RE.match(low):
        return {"kind": "imm", "bits": None, "ptr_name": None, "raw": raw}

    # 6) 라벨(.Ltarget 등)
    if low.startswith(".") or low.isidentifier():
        return {"kind": "label", "bits": None, "ptr_name": None, "raw": raw}

    return {"kind": "unknown", "bits": None, "ptr_name": None, "raw": raw}


def parse_line(line):
    """어셈블리 한 줄을 (mnemonic, [operand, ...])로 분해한다.

    명령어가 아닌 줄(빈 줄, 주석, .directive, 라벨)이면 (None, None)을 준다.
    """
    code = line
    for marker in ("  # ", "\t#", " //"):
        if marker in code:
            code = code.split(marker)[0]
    code = code.strip()
    if code.startswith("#") or code.startswith("//"):
        return None, None
    if not code or code.startswith(".") or code.endswith(":"):
        return None, None

    parts = code.split(None, 1)
    mnemonic = parts[0].lower()
    if len(parts) == 1:
        return mnemonic, []
    operands = [parse_operand(x) for x in parts[1].split(",")]
    return mnemonic, operands


def bits_to_ptr(bits):
    """비트수 -> Intel 크기 지시자 이름 (모르면 'N비트' 문자열)."""
    for name, value in PTR_SIZES.items():
        if value == bits:
            return name + " ptr"
    return "%d비트" % bits


# ---------------------------------------------------------------- ISA DB 조회

def load_isa_db(path):
    """isa_db.csv를 mnemonic -> [행, ...] 형태로 읽는다. 없으면 빈 dict."""
    table = {}
    if not os.path.exists(path):
        return table
    with open(path, encoding="utf-8") as f:
        for row in csv.DictReader(f):
            key = (row.get("mnemonic") or "").strip().upper()
            if key:
                table.setdefault(key, []).append(row)
    return table


def sdm_forms(db, mnemonic):
    """해당 니모닉의 SDM 폼들을 'LSS r64,m16:64 (REX.W + 0F B2 /r, Valid, p.658)' 형태로."""
    lines = []
    for row in db.get(mnemonic.upper(), []):
        lines.append("%s  (%s, %s, p.%s)" % (
            row.get("instruction", ""), row.get("opcode", ""),
            row.get("mode_support", ""), row.get("source_page", "")))
    return lines


# ---------------------------------------------------------------- 정적 규칙

# 규칙마다 아래 dict를 만들어 돌려준다.
#   rule_id  : 규칙 이름 (동적 결과와 매칭하는 키)
#   level    : "error"(어셈블러가 거부할 것으로 예상) / "warn" / "info"
#   summary  : 한 줄 요약
#   sdm      : 인텔 매뉴얼 근거 (폼 + 페이지)
#   cause    : 왜 이런 일이 생기는지 (as/clang 실측으로 알아낸 원인)
#   fix      : 권장 수정 (없으면 "")
#   cross    : 어셈블러 간 차이 등 참고 사항 (없으면 "")

FARPTR = ("lss", "lfs", "lgs", "les", "lds")


def rule_farptr_size(mnemonic, ops, db):
    """LSS/LFS/LGS 등 far pointer 로드: 메모리 크기 = 목적지 폭 + 세그먼트 16비트."""
    if mnemonic not in FARPTR or len(ops) != 2:
        return []
    dest, src = ops[0], ops[1]
    if dest["kind"] != "reg" or src["kind"] != "mem" or src["bits"] is None:
        return []

    need = dest["bits"] + 16          # m16:16=32, m16:32=48, m16:64=80
    if src["bits"] == need:
        return []

    return [{
        "rule_id": "farptr_size_mismatch",
        "level": "error",
        "summary": "%s의 메모리 크기가 목적지 폭과 안 맞습니다. 목적지 '%s'(%d비트)면 "
                   "메모리는 '%s'(%d비트)여야 하는데 '%s'(%d비트)로 적혀 있습니다."
                   % (mnemonic.upper(), dest["raw"], dest["bits"],
                      bits_to_ptr(need), need, src["raw"], src["bits"]),
        "sdm": "far pointer는 [세그먼트 셀렉터 16비트 + 오프셋 %d비트] = %d비트다. "
               "SDM 폼: %s" % (dest["bits"], need,
                               " / ".join(sdm_forms(db, mnemonic)) or "(DB 없음)"),
        "cause": "as는 Intel 크기 지시자를 내부적으로 AT&T 접미사로 바꿔 오퍼랜드 폭을 정한다"
                 "(실측: dword ptr->'w', fword ptr->'l', tbyte ptr->'q'). 그래서 크기 지시자와 "
                 "목적지 레지스터 폭이 어긋나면 \"incorrect register ... used with 'X' suffix\" 또는 "
                 "\"operand size mismatch\"가 난다.",
        "fix": "%s %s, %s %s" % (mnemonic, dest["raw"], bits_to_ptr(need),
                                 re.sub(r"^.*?(\[)", r"\1", src["raw"])),
        "cross": "clang은 크기 지시자를 사실상 무시하고 목적지 레지스터 이름만 보고 인코딩한다"
                 "(실측: fword/tbyte/생략 전부 같은 바이트). clang이 통과시켜도 매뉴얼에 맞는 건 아니다.",
    }]


def rule_farptr_r64(mnemonic, ops, db):
    """LSS/LFS/LGS의 r64(REX.W) 폼 — 이 프로젝트가 확정한 objdump 표시 결함."""
    if mnemonic not in ("lss", "lfs", "lgs") or len(ops) != 2:
        return []
    if ops[0]["kind"] != "reg" or ops[0]["bits"] != 64:
        return []

    return [{
        "rule_id": "farptr_r64_objdump_display",
        "level": "info",
        "summary": "%s의 64비트(REX.W) 폼입니다. as는 매뉴얼대로 인코딩하지만 "
                   "objdump가 역어셈블 결과를 틀리게 표시합니다." % mnemonic.upper(),
        "sdm": "SDM p.658 Description은 이 폼이 80비트 포인터를 읽는다고 숫자로 명시한다 "
               "-> 표시는 TBYTE PTR이어야 한다.",
        "cause": "GNU objdump는 REX.W로 승격된 r64 폼의 메모리 크기를 m16:32용인 'FWORD PTR'로 "
                 "표시한다. 그 텍스트를 그대로 as에 되먹이면 as가 거부한다 "
                 "(as 자신은 rcx엔 TBYTE가 맞다고 알고 있다는 방증). r16/r32 폼은 정상 표시된다.",
        "fix": "",
        "cross": "llvm-objdump는 같은 바이트에 이 오표기를 하지 않는다 -> GNU objdump만의 결함. "
                 "또한 이 폼은 as에 '-mintel64' 옵션이 있어야 어셈블된다(아래 실측 참고).",
    }]


def rule_mov_sreg(mnemonic, ops, db):
    """MOV Sreg, ... — 세그먼트 레지스터는 항상 16비트 셀렉터만 로드한다."""
    if mnemonic != "mov" or len(ops) != 2:
        return []
    dest, src = ops[0], ops[1]
    if dest["kind"] != "sreg":
        return []

    forms = " / ".join(f for f in sdm_forms(db, "MOV") if "Sreg" in f) or "(DB 없음)"

    # (1) 메모리 폼인데 크기 지시자가 word가 아닌 경우
    if src["kind"] == "mem" and src["bits"] is not None and src["bits"] != 16:
        return [{
            "rule_id": "mov_sreg_mem_size",
            "level": "error",
            "summary": "'%s'는 16비트 세그먼트 레지스터라 메모리에서 16비트 셀렉터만 읽습니다. "
                       "'%s'가 아니라 'word ptr'여야 합니다." % (dest["raw"], src["raw"]),
            "sdm": "SDM 표에는 'REX.W + 8E /r  MOV Sreg, r/m64'가 64비트 모드 Valid로 실려 있으나, "
                   "같은 행 Description이 \"Move lower 16 bits of r/m64 to segment register\"라고 "
                   "적어 실제 전송 폭은 16비트임을 밝힌다. 폼: %s" % forms,
            "cause": "as는 'operand type mismatch for `mov`'로 거부하고 word ptr만 받는다. "
                     "clang 18/19/20도 똑같이 'invalid operand for instruction'으로 거부한다 "
                     "(어셈블러 4종 일치). 즉 SDM 표의 r/m64는 레지스터 폼을 가리키는 표기이고, "
                     "메모리 폼으로 64비트를 읽는 인코딩은 실제로 존재하지 않는다.",
            "fix": "mov %s, word ptr %s" % (dest["raw"],
                                            re.sub(r"^.*?(\[)", r"\1", src["raw"])),
            "cross": "이 프로젝트의 현재 판정은 'unsure'다(combo 1683) — 어셈블러 4종이 일치하므로 "
                     "\"as만 매뉴얼보다 엄격하다\"고 보기 어렵지만, SDM 내부 모순의 결정적 증거는 아직 없다.",
        }]

    # (2) 레지스터 폼인데 32비트가 아닌 경우 -> as와 clang의 인코딩이 갈린다
    if src["kind"] == "reg" and src["bits"] != 32:
        return [{
            "rule_id": "mov_sreg_reg_width",
            "level": "info",
            "summary": "'mov %s, %s'(%d비트 소스)는 as와 clang이 서로 다른 바이트로 인코딩합니다."
                       % (dest["raw"], src["raw"], src["bits"]),
            "sdm": "세그먼트 레지스터 로드는 폭에 관계없이 하위 16비트 셀렉터만 쓴다. 폼: %s" % forms,
            "cause": "as는 오퍼랜드 크기 접두어와 REX.W를 버리고 항상 '8E D8'로 인코딩한다"
                     "(실측: mov ds,ax / mov ds,eax / mov ds,rax 모두 8e d8). "
                     "objdump는 이걸 전부 'mov ds,eax'로 되돌린다.",
            "fix": "",
            "cross": "clang은 폭을 유지한다(실측: mov ds,ax -> 66 8e d8, mov ds,rax -> 48 8e d8). "
                     "실행 의미는 셋 다 같지만(하위 16비트 로드) 바이트가 달라 round-trip이 안 맞는다.",
        }]

    return []


def rule_asymmetric_width(mnemonic, ops, db):
    """LAR/LSL — SDM 표기가 비대칭(r32, r64/m16)이라 어셈블러마다 해석이 갈린다."""
    if mnemonic not in ("lar", "lsl") or len(ops) != 2:
        return []
    dest, src = ops[0], ops[1]
    if dest["kind"] != "reg":
        return []
    if dest["bits"] != 64 and not (src["kind"] == "reg" and src["bits"] != dest["bits"]):
        return []

    return [{
        "rule_id": "ambiguous_asymmetric_width",
        "level": "warn",
        "summary": "%s는 SDM 표기 자체가 두 오퍼랜드 폭을 다르게 적어(비대칭) 어셈블러마다 "
                   "해석이 갈립니다." % mnemonic.upper(),
        "sdm": "폼: %s — REX.W 비트 하나로 두 GPR 오퍼랜드의 폭을 독립 지정할 수 없으므로, "
               "이 비대칭 표기는 어떤 어셈블러로도 그대로 인코딩할 수 없다."
               % (" / ".join(sdm_forms(db, mnemonic)) or "(DB 없음)"),
        "cause": "as(2.42/2.47 모두)는 어떤 레지스터 조합으로도 'REX.W + 0F 02/03' 바이트를 만들지 "
                 "못한다 — 대칭 폼(lar rcx,rcx)조차 REX 없는 '0f 02 c9'로 조용히 32비트로 축소한다.",
        "fix": "",
        "cross": "clang은 목적지 레지스터 이름만 보고 REX.W를 정한다(lar ecx,rcx -> REX 없음, "
                 "lar rcx,ecx -> 48 0f 02 c9). 이 프로젝트는 SDM 표 오탈자로 보고 'false_alarm'으로 "
                 "판정했다(combo 1516/1571).",
    }]


def rule_sdm_operand_count(mnemonic, ops, db):
    """SDM DB에 같은 오퍼랜드 개수의 폼이 있는지 본다 (isa_db.csv 기반 일반 규칙)."""
    rows = db.get(mnemonic.upper())
    if not rows:
        if db:      # DB는 읽혔는데 니모닉이 없다
            return [{
                "rule_id": "mnemonic_not_in_sdm",
                "level": "warn",
                "summary": "'%s'는 SDM 인코딩 표(isa_db.csv)에 없는 니모닉입니다." % mnemonic,
                "sdm": "(해당 행 없음)",
                "cause": "매뉴얼에 없는 니모닉이거나, alias·의사명령어(pseudo-op)이거나, "
                         "extractor가 아직 못 뽑은 표일 수 있다.",
                "fix": "",
                "cross": "",
            }]
        return []

    counts = set()
    for row in rows:
        operands = (row.get("operands") or "").strip()
        counts.add(len([x for x in operands.split(",") if x.strip()]))
    if len(ops) in counts:
        return []

    return [{
        "rule_id": "sdm_operand_count_mismatch",
        "level": "error",
        "summary": "%s에 오퍼랜드 %d개를 줬는데, SDM에는 %s개 폼만 있습니다."
                   % (mnemonic.upper(), len(ops),
                      "/".join(str(c) for c in sorted(counts))),
        "sdm": "폼: %s" % (" / ".join(sdm_forms(db, mnemonic)) or "(DB 없음)"),
        "cause": "매뉴얼 표의 오퍼랜드 개수와 다르게 쓰면 as는 "
                 "\"number of operands mismatch\"로 거부한다.",
        "fix": "",
        "cross": "",
    }]


def rule_udb(mnemonic, ops, db):
    """UDB — SDM 표엔 있는데 as/clang 둘 다 니모닉을 모른다."""
    if mnemonic != "udb":
        return []
    return [{
        "rule_id": "sdm_mnemonic_unknown_to_assembler",
        "level": "warn",
        "summary": "'udb'는 SDM 표(D6 UDB, p.1436)에 64비트 모드 Valid로 실려 있지만 "
                   "as도 clang도 이 니모닉을 모릅니다.",
        "sdm": "폼: %s" % (" / ".join(sdm_forms(db, "UDB")) or "(DB 없음)"),
        "cause": "as는 \"no such instruction: `udb'\", clang은 "
                 "\"invalid instruction mnemonic 'udb'\"로 거부한다(실측, 어셈블러 2종 일치).",
        "fix": "",
        "cross": "판정 보류 중이다. UDB가 UD0/UD1/UD2처럼 어셈블해 쓰라고 만든 구체 명령어인지, "
                 "\"이 오피코드 자리는 영구히 정의되지 않음\"을 뜻하는 문서상 라벨인지가 갈림길이다"
                 "(docs/HANDOFF.md 3절 과제 C). 라벨이라면 어셈블러가 몰라도 정상이다.",
    }]


RULES = [
    rule_farptr_size,
    rule_farptr_r64,
    rule_mov_sreg,
    rule_asymmetric_width,
    rule_udb,
    rule_sdm_operand_count,
]


def run_static(mnemonic, ops, db):
    """정적 규칙을 전부 돌려 플래그 목록을 모은다 (설계 2: 어셈블러보다 먼저)."""
    flags = []
    for rule in RULES:
        flags.extend(rule(mnemonic, ops, db))
    return flags


# ---------------------------------------------------------------- 어셈블러 실측

def have(tool):
    """해당 도구가 PATH에 있는지."""
    try:
        subprocess.run([tool, "--version"], capture_output=True, timeout=10)
        return True
    except (OSError, subprocess.SubprocessError):
        return False


def first_error(text):
    """as/clang stderr에서 첫 에러 문구만 뽑는다."""
    for line in (text or "").splitlines():
        match = re.search(r"(?:Error|error):\s*(.*)", line)
        if match:
            return match.group(1).strip()
    return (text or "").strip().splitlines()[0] if (text or "").strip() else "(메시지 없음)"


def objdump_first(obj_path):
    """objdump -d -M intel 결과에서 첫 명령어의 (바이트, 역어셈블 텍스트)."""
    result = subprocess.run(["objdump", "-d", "-M", "intel", obj_path],
                            capture_output=True, text=True, timeout=15)
    for line in result.stdout.splitlines():
        match = re.match(r"\s+0:\s+([0-9a-f ]+?)\t(.*)", line)
        if match:
            byte_text = match.group(1).replace(" ", "")
            disasm = re.sub(r"\s+", " ", match.group(2).strip())
            return byte_text, disasm
    return "", ""


def assemble(code, tool, opts, work_dir):
    """어셈블리 한 줄을 조용히 어셈블한다. 반환 dict(ok, error, bytes, disasm)."""
    src = os.path.join(work_dir, "lint_%s.s" % tool)
    obj = os.path.join(work_dir, "lint_%s.o" % tool)
    with open(src, "w", encoding="utf-8", newline="\n") as f:
        f.write(ASM_HEADER + code + "\n")
    if os.path.exists(obj):
        os.remove(obj)

    if tool == "as":
        cmd = ["as"] + opts + ["-o", obj, src]
    else:
        cmd = ["clang", "-c", "-x", "assembler", "-o", obj, src]

    try:
        result = subprocess.run(cmd, capture_output=True, text=True, timeout=20)
    except subprocess.SubprocessError as exc:
        return {"ok": False, "error": "실행 실패: %s" % exc, "bytes": "", "disasm": ""}

    if result.returncode != 0 or not os.path.exists(obj):
        return {"ok": False,
                "error": first_error(result.stderr or result.stdout),
                "bytes": "", "disasm": ""}

    byte_text, disasm = objdump_first(obj)
    return {"ok": True, "error": "", "bytes": byte_text, "disasm": disasm}


def roundtrip(disasm, work_dir):
    """objdump가 뱉은 텍스트를 다시 as에 넣어본다 (디스어셈블러 자체 결함 탐지).

    반환: (성공여부, 메시지). 원본과 바이트가 같은지까지 본다.
    """
    if not disasm:
        return None, ""
    back = assemble(disasm, "as", AS_OPTS, work_dir)
    if not back["ok"]:
        return False, back["error"]
    return True, back["bytes"]


# ---------------------------------------------------------------- 리포트 출력

def wrap(text, indent):
    """긴 한국어 문장을 적당히 줄바꿈한다 (터미널에서 읽기 좋게)."""
    width = 96 - len(indent)
    out = []
    line = ""
    for word in text.split(" "):
        if line and len(line) + 1 + len(word) > width:
            out.append(line)
            line = word
        else:
            line = (line + " " + word) if line else word
    if line:
        out.append(line)
    return ("\n" + indent).join(out)


def print_flags(flags):
    """정적 분석 결과를 찍는다."""
    tag = {"error": "[에러 예상]", "warn": "[경고]", "info": "[참고]"}
    print("  정적 분석: %d건" % len(flags))
    for flag in flags:
        print("    %s (%s)" % (tag.get(flag["level"], "[?]"), flag["rule_id"]))
        print("      %s" % wrap(flag["summary"], " " * 6))
        print("      SDM 근거 : %s" % wrap(flag["sdm"], " " * 17))
        if flag["fix"]:
            print("      권장 수정 : %s" % flag["fix"])


def check_one(code, db, work_dir, use_as, use_clang):
    """어셈블리 한 줄을 검사하고 리포트를 출력한다."""
    mnemonic, ops = parse_line(code)
    print("=" * 96)
    print("입력: %s" % code)
    if mnemonic is None:
        print("  (명령어 줄이 아니라 건너뜁니다)")
        return

    # --- 설계 2: 정적 분석을 먼저 돌려 플래그를 세운다
    flags = run_static(mnemonic, ops, db)
    if flags:
        print_flags(flags)
    else:
        print("  정적 분석: 매뉴얼 기준 이상 없음")

    if not use_as and not use_clang:
        return

    # --- 설계 1: 실제 어셈블러를 조용히 돌려 진짜 에러 메시지를 가져온다
    print("  어셈블러 실측:")
    as_result = None
    if use_as:
        as_result = assemble(code, "as", AS_OPTS, work_dir)
        label = "as (%s)" % " ".join(AS_OPTS)
        if as_result["ok"]:
            print("    %-22s : ok    %-14s -> %s"
                  % (label, as_result["bytes"], as_result["disasm"]))
        else:
            print("    %-22s : ERROR %s" % (label, as_result["error"]))

    clang_result = None
    if use_clang:
        clang_result = assemble(code, "clang", [], work_dir)
        if clang_result["ok"]:
            print("    %-22s : ok    %s" % ("clang", clang_result["bytes"]))
        else:
            print("    %-22s : ERROR %s" % ("clang", clang_result["error"]))

    if as_result is None:
        return

    # -mintel64 없이도 되는지 확인 (이 옵션이 있어야만 되는 폼이 실제로 있다)
    if as_result["ok"]:
        plain = assemble(code, "as", AS_OPTS_PLAIN, work_dir)
        if not plain["ok"]:
            print("    %-22s : ERROR %s" % ("as (-mintel64 없이)", plain["error"]))
            print("      -> 이 폼은 as에 '-mintel64' 옵션이 있어야 어셈블됩니다. 옵션이 없으면 "
                  "매뉴얼대로 써도 거부됩니다.")

    # --- 설계 3(실용주의) + 설계 2(플래그 해설 붙이기)
    print("  판정:")
    error_flags = [f for f in flags if f["level"] in ("error", "warn")]

    if not as_result["ok"]:
        if error_flags:
            print("    정적 분석이 예측한 대로 as가 거부했습니다. 원인 해설:")
            for flag in error_flags:
                print("      - (%s) %s" % (flag["rule_id"], wrap(flag["cause"], " " * 8)))
                if flag["cross"]:
                    print("        참고: %s" % wrap(flag["cross"], " " * 14))
        else:
            print("    as가 거부했지만 대응하는 정적 규칙이 없습니다 -> 규칙 추가 후보입니다.")
            print("    (에러 문구: %s)" % as_result["error"])
        return

    # 어셈블은 성공. 실용주의: 강한 경고 대신 정보성 메시지만.
    if flags:
        print("    어셈블 성공. 다만 매뉴얼 기준과 다음 차이가 있으니 유의하세요:")
        for flag in flags:
            print("      - (%s) %s" % (flag["rule_id"], wrap(flag["cause"], " " * 8)))
            if flag["cross"]:
                print("        참고: %s" % wrap(flag["cross"], " " * 14))
    else:
        print("    어셈블 성공 + 매뉴얼 기준 이상 없음.")

    # 디스어셈블 결과를 되먹여 round-trip 확인
    ok_back, info = roundtrip(as_result["disasm"], work_dir)
    if ok_back is False:
        print("    round-trip 실패: objdump가 찍은 '%s'를 다시 as에 넣으면 거부됩니다 "
              "-> 디스어셈블러 표시가 틀렸다는 신호입니다." % as_result["disasm"])
        print("      (as 에러: %s)" % info)
    elif ok_back and info and info != as_result["bytes"]:
        print("    round-trip 바이트 불일치: 원본 %s vs 재어셈블 %s" % (as_result["bytes"], info))

    if clang_result and clang_result["ok"] and clang_result["bytes"] != as_result["bytes"]:
        print("    as와 clang의 인코딩이 다릅니다: as=%s / clang=%s"
              % (as_result["bytes"], clang_result["bytes"]))


# ---------------------------------------------------------------- 진입점

DEMO = [
    "lss rcx, fword ptr [eax]",     # 크기 불일치 -> as 거부
    "lss rcx, tbyte ptr [eax]",     # 매뉴얼대로 -> as 성공, objdump 오표시
    "lss ecx, fword ptr [eax]",     # 정상
    "mov ds, qword ptr [eax]",      # SDM엔 r/m64인데 as/clang 둘 다 거부
    "mov ds, word ptr [eax]",       # 정상
    "mov ds, rax",                  # as는 REX.W 버림, clang은 유지
    "lar ecx, rcx",                 # SDM 비대칭 표기
    "udb",                          # SDM엔 있는데 어셈블러가 모름
    "ud0",                          # SDM은 2오퍼랜드 폼
]


def main():
    parser = argparse.ArgumentParser(
        description="인텔 매뉴얼(SDM) 기준 어셈블리 검사 + 어셈블러 실측 해설")
    parser.add_argument("code", nargs="*", help="검사할 어셈블리 (따옴표로 묶어서)")
    parser.add_argument("-f", "--file", help="검사할 .s 파일")
    parser.add_argument("--demo", action="store_true", help="대표 케이스 시범 실행")
    parser.add_argument("--static-only", action="store_true",
                        help="어셈블러를 돌리지 않고 정적 검사만")
    parser.add_argument("--no-clang", action="store_true", help="clang 비교 생략")
    parser.add_argument("--limit", type=int, default=0, help="파일 검사 시 최대 줄 수")
    parser.add_argument("--db", default=ISA_DB, help="isa_db.csv 경로")
    args = parser.parse_args()

    db = load_isa_db(args.db)
    if not db:
        print("[알림] %s를 못 읽어 SDM 대조 없이 진행합니다." % args.db)

    use_as = use_clang = False
    if not args.static_only:
        use_as = have("as")
        use_clang = (not args.no_clang) and have("clang")
        if not use_as:
            print("[알림] as를 찾을 수 없어 정적 검사만 합니다. "
                  "as/objdump/clang은 WSL(Ubuntu)에 있습니다 -> "
                  "wsl -d Ubuntu -- bash -lc 'python3 scripts/asm_linter.py ...'")

    if args.demo:
        codes = DEMO
    elif args.file:
        with open(args.file, encoding="utf-8") as f:
            codes = [line.rstrip("\n") for line in f]
        codes = [c for c in codes if parse_line(c)[0] is not None]
        if args.limit:
            codes = codes[:args.limit]
    elif args.code:
        codes = [" ".join(args.code)]
    else:
        parser.error("검사할 어셈블리를 주거나 -f/--demo를 쓰세요.")

    work_dir = tempfile.mkdtemp(prefix="asm_linter_")
    try:
        for code in codes:
            check_one(code, db, work_dir, use_as, use_clang)
        print("=" * 96)
        print("총 %d줄 검사 완료." % len(codes))
    finally:
        for name in os.listdir(work_dir):
            os.remove(os.path.join(work_dir, name))
        os.rmdir(work_dir)


if __name__ == "__main__":
    main()

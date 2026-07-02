"""
Stage 5 (재작성): 역어셈블 비교 (roundtrip)

흐름:
  step3_generated.s
    → (어셈블 실패 라인 제외한) 깨끗한 소스
    → as --64 -mintel64 -o /tmp/step5.o   (WSL)
    → objdump -d -M intel                 (WSL)
    → 원본 명령어 vs 역어셈블 결과를 정규화 후 1:1 비교/분류

분류:
  exact_match            정규화 후 완전 일치
  alias                  니모닉 별칭(sal=shl, retq=ret 등) 후 동일
  operand_repr_changed   피연산자 표기만 다름(숫자/PTR 크기 등)
  mnemonic_changed       니모닉 자체가 다름 (검토 대상)
  relative_target        rel 분기의 '.' → 절대주소 (구조적)
  review                 그 외 (검토 대상)

출력:
  data/stage5_disassembly/step5_roundtrip_compare.csv
  data/stage5_disassembly/step5_roundtrip_report.md
"""

import re
import subprocess
import platform
from collections import Counter
from pathlib import Path

BASE = Path(__file__).parent.parent.parent
SRC = BASE / "data" / "stage3_operands" / "step3_generated.s"
OUT_DIR = BASE / "data" / "stage5_disassembly"
IS_WIN = platform.system() == "Windows"


def wsl_run(args: list[str], stdin: str | None = None) -> subprocess.CompletedProcess:
    cmd = (["wsl"] + args) if IS_WIN else args
    return subprocess.run(cmd, input=stdin, capture_output=True, text=True,
                          encoding="utf-8", errors="replace", timeout=240)


HEADER = ".intel_syntax noprefix"


# ── 1. 소스 로드 + 어셈블 실패 라인 제외 ───────────────────────────────
def load_and_clean() -> list[str]:
    lines = SRC.read_text(encoding="utf-8").splitlines()
    instrs = [l.strip() for l in lines if l.startswith("    ")]
    # HEADER 가 1번 라인, 명령어 i(1-based)는 파일 라인 i+1 에 온다.
    src_text = HEADER + "\n" + "\n".join(instrs) + "\n"

    r = wsl_run(["as", "--64", "-mintel64", "-o", "/dev/null"], stdin=src_text)
    bad = set()
    for ln in (r.stderr + r.stdout).splitlines():
        m = re.search(r":(\d+):\s*Error", ln)
        if m:
            bad.add(int(m.group(1)) - 1)     # 파일라인 → 명령어 인덱스(1-based)
    clean = [instr for idx, instr in enumerate(instrs, 1) if idx not in bad]
    print(f"  소스 명령어 {len(instrs)}개 중 어셈블 실패 {len(bad)}개 제외 → {len(clean)}개")
    return clean


# ── 2. 어셈블 → objdump ───────────────────────────────────────────────
def assemble_and_objdump(clean: list[str]) -> str:
    src_text = HEADER + "\n" + "\n".join(clean) + "\n"
    r1 = wsl_run(["as", "--64", "-mintel64", "-o", "/tmp/step5.o"], stdin=src_text)
    if r1.returncode != 0:
        raise RuntimeError("clean 소스 어셈블 실패:\n" + (r1.stderr or r1.stdout)[:500])
    r2 = wsl_run(["objdump", "-d", "-M", "intel", "/tmp/step5.o"])
    if r2.returncode != 0:
        raise RuntimeError("objdump 실패:\n" + (r2.stderr or r2.stdout)[:500])
    return r2.stdout


def parse_objdump(text: str) -> list[str]:
    """objdump 출력에서 명령어 텍스트만 순서대로 추출."""
    out = []
    for raw in text.splitlines():
        # 형식:  "  12:  48 01 c0    add    rax,rax"
        m = re.match(r"^\s*[0-9a-f]+:\s+(?:[0-9a-f]{2} )+\s*(\S.*)$", raw)
        if not m:
            continue
        txt = m.group(1).strip()
        if re.fullmatch(r"(?:[0-9a-f]{2}\s*)+", txt):   # opcode 바이트 연속줄
            continue
        out.append(re.sub(r"\s+", " ", txt))
    return out


# ── 3. 정규화 + 별칭 ──────────────────────────────────────────────────
ALIAS = {
    "retq": "ret", "movabs": "mov", "sal": "shl", "xlatb": "xlat",
    "cmovz": "cmove", "cmovnz": "cmovne", "setz": "sete", "setnz": "setne",
    "jz": "je", "jnz": "jne", "jnae": "jb", "jc": "jb", "jnb": "jae", "jnc": "jae",
    "jna": "jbe", "jnbe": "ja", "jpe": "jp", "jpo": "jnp", "jnge": "jl",
    "jnl": "jge", "jng": "jle", "jnle": "jg",
    "repz": "repe", "repnz": "repne",
    "pushfq": "pushf", "popfq": "popf", "cltq": "cdqe", "cqto": "cqo",
    "cwtl": "cwde", "cltd": "cdq",
    # 문자열 명령 크기 접미어 → 베이스 (movsd 는 SSE와 혼동되므로 제외)
    "cmpsb": "cmps", "cmpsw": "cmps", "cmpsq": "cmps",
    "scasb": "scas", "scasw": "scas", "scasd": "scas", "scasq": "scas",
    "stosb": "stos", "stosw": "stos", "stosd": "stos", "stosq": "stos",
    "lodsb": "lods", "lodsw": "lods", "lodsd": "lods", "lodsq": "lods",
    "movsb": "movs", "movsw": "movs", "movsq": "movs", "cmpsd": "cmps",
    "insb": "ins", "insw": "ins", "insd": "ins",
    "outsb": "outs", "outsw": "outs", "outsd": "outs",
    "iretd": "iret", "iretq": "iret",
    "movsd": "movs",
}
STRING_MN = {"cmps", "scas", "stos", "lods", "movs", "ins", "outs"}


def normalize(text: str) -> str:
    s = text.lower().strip()
    s = re.sub(r"#.*$", "", s)                    # objdump 주석 제거
    s = re.sub(r"<[^>]*>", "", s)                 # <symbol> 제거
    s = re.sub(r"^\s*rex(\.\w+)?\s+", "", s)       # objdump 의 'rex.W ' 프리픽스 표시 제거
    s = re.sub(r"\b(byte|word|dword|qword|tbyte|fword|oword|xmmword|ymmword|zmmword)\s+ptr\b", "", s)  # PTR 크기 표기(비의미적) 제거
    s = re.sub(r"\bptr\b", "", s)
    s = re.sub(r"\b(cs|ds|es|fs|gs|ss):", "", s)  # 세그먼트 프리픽스 표기
    s = re.sub(r"0x0+([0-9a-f])", r"0x\1", s)     # 선행 0 제거
    s = re.sub(r"\[(0x[0-9a-f]+|\d+)\]", r"\1", s)  # moffs: [0x1000] ↔ 0x1000
    s = re.sub(r"\+riz\*?1?", "", s)              # objdump 의 riz(무인덱스) 표기 제거
    s = s.replace("st(0)", "st")                  # x87: st(0) == st
    s = re.sub(r"[ \t]+", " ", s).strip()
    # 니모닉과 피연산자 분리 (첫 공백 보존). 피연산자 내부 공백/기호주변은 정규화.
    mn, _, ops = s.partition(" ")
    ops = re.sub(r"\s*,\s*", ",", ops)
    ops = re.sub(r"\s+", "", ops)                 # 피연산자 내부 잔여 공백 제거
    return f"{mn} {ops}".strip()


# 조건코드 동의어 정규화 (cmovc=cmovb, setna=setbe, jnae=jb ...)
_CC = {
    "c": "b", "nae": "b", "nb": "ae", "nc": "ae", "na": "be", "nbe": "a",
    "nge": "l", "nl": "ge", "ng": "le", "nle": "g", "pe": "p", "po": "np",
    "z": "e", "nz": "ne",
}


def canon_mnemonic(m: str) -> str:
    for pref in ("cmov", "set"):
        if m.startswith(pref) and m[len(pref):] in _CC:
            return pref + _CC[m[len(pref):]]
    if m.startswith("j") and m not in {"jmp", "jecxz", "jrcxz", "jcxz"} and m[1:] in _CC:
        return "j" + _CC[m[1:]]
    return ALIAS.get(m, m)


def split_mn(text: str) -> tuple[str, str]:
    # 프리픽스(rep/lock 등) 처리: 첫 토큰이 프리픽스면 붙여서 둘째를 니모닉으로
    parts = text.split(" ", 1)
    return parts[0], (parts[1] if len(parts) > 1 else "")


def _base_pseudo(m: str) -> str:
    """의사명령 정규화: vcmpltpd→vcmppd, vpclmulhqlqdq→vpclmulqdq."""
    mm = re.fullmatch(r"(v?cmp)[a-z_0-9]*(pd|ps|sd|ss|ph|sh)", m)
    if mm:
        return mm.group(1) + mm.group(2)
    mm = re.fullmatch(r"(v?pclmul)[a-z]*(qdq)", m)
    if mm:
        return mm.group(1) + mm.group(2)
    return m


PREFIXES = {"rep", "repe", "repz", "repne", "repnz", "lock"}


# GP 레지스터를 폭 무관 기호로 접기 (ax/eax/rax → @a) — 레지스터 폭 표시차 탐지용
_REGFOLD = {}
for _b in ["a", "b", "c", "d"]:
    for _r in [f"{_b}l", f"{_b}x", f"e{_b}x", f"r{_b}x"]:
        _REGFOLD[_r] = f"@{_b}"
for _b in ["si", "di", "sp", "bp"]:
    for _r in [_b, f"e{_b}", f"r{_b}", f"{_b}l"]:
        _REGFOLD[_r] = f"@{_b}"


def _regfold(op: str) -> str:
    return re.sub(r"\b[a-z]{2,4}\b", lambda m: _REGFOLD.get(m.group(0), m.group(0)), op)


def _split_prefix(text: str):
    parts = text.strip().split(None, 1)
    if parts and parts[0].lower() in PREFIXES and len(parts) > 1:
        return parts[0].lower(), parts[1]
    return None, text


def classify(src: str, dis: str) -> str:
    # 프리픽스(rep/repe/lock 등)를 raw 단계에서 떼고 내부 명령어끼리 비교
    sp, sr = _split_prefix(src)
    dp, dr = _split_prefix(dis)
    if sp and dp and canon_mnemonic(sp) == canon_mnemonic(dp):
        return classify(sr, dr)

    ns, nd = normalize(src), normalize(dis)
    if ns == nd:
        return "exact_match"
    sm, so = split_mn(ns)
    dm, do = split_mn(nd)

    # 프리픽스(rep/repe/repne/lock) + 문자열 op: objdump 표준형/repz별칭 → 정상
    if sm in PREFIXES and dm in PREFIXES and canon_mnemonic(sm) == canon_mnemonic(dm):
        is_ = re.match(r"[a-z]+", so)
        id_ = re.match(r"[a-z]+", do)
        if is_ and id_ and canon_mnemonic(is_.group(0)) == canon_mnemonic(id_.group(0)) \
           and canon_mnemonic(is_.group(0)) in STRING_MN:
            return "string_alias"

    # 의사명령: cmppd+imm → cmpltpd, pclmulqdq+imm → pclmulhqlqdq 등 (semantic 동일)
    if _base_pseudo(sm) == _base_pseudo(dm) and (_base_pseudo(sm) != sm or _base_pseudo(dm) != dm):
        return "pseudo_op"

    cm_s, cm_d = canon_mnemonic(sm), canon_mnemonic(dm)
    if cm_s == cm_d:
        # 문자열 명령: 암묵 rsi/rdi 표준형 등 표기차는 정상
        if cm_s in STRING_MN:
            return "string_alias"
        if so == do:
            return "alias"                     # 니모닉 별칭/조건코드 동의어
        sp = [x for x in so.split(",") if x]
        dp = [x for x in do.split(",") if x]
        # 암묵 오퍼랜드: objdump가 XMM0 등 암묵 피연산자를 명시
        if len(dp) > len(sp) and dp[:len(sp)] == sp \
           and all(re.fullmatch(r"[a-z0-9()]+", x) for x in dp[len(sp):]):
            return "implicit_operand"
        # 숫자/표기만 다름
        if re.sub(r"0x[0-9a-f]+|\b\d+\b", "#", so) == re.sub(r"0x[0-9a-f]+|\b\d+\b", "#", do):
            return "operand_repr_changed"
        # 레지스터 폭 표시차 (예: lldt ax ↔ lldt eax) — 검토 대상으로 분리
        if _regfold(so) == _regfold(do):
            return "register_width_changed"
        # rel 분기: 소스 '.' → objdump 절대주소
        if so in (".", "") and re.fullmatch(r"0x[0-9a-f]+|[0-9a-f]+", do):
            return "relative_target"
        return "operand_changed"
    return "mnemonic_changed"


BENIGN = {"exact_match", "alias", "operand_repr_changed", "relative_target",
          "implicit_operand", "string_alias", "pseudo_op"}


def align_key(text: str) -> str:
    """정렬용 키: 별칭 정규화한 니모닉 + 숫자를 #로 치환한 피연산자 형태."""
    mn, op = split_mn(normalize(text))
    op = re.sub(r"0x[0-9a-f]+|\b\d+\b", "#", op)
    return f"{canon_mnemonic(mn)} {op}".strip()


def main():
    import csv
    import difflib
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    print("[Stage 5] roundtrip 시작")
    clean = load_and_clean()
    objdump_text = assemble_and_objdump(clean)
    (OUT_DIR / "step5_objdump.txt").write_text(objdump_text, encoding="utf-8")
    disasm = parse_objdump(objdump_text)
    print(f"  소스 {len(clean)} vs objdump {len(disasm)}")

    # difflib 로 두 스트림 정렬 (삽입/삭제로 어긋남 보정)
    s_keys = [align_key(s) for s in clean]
    d_keys = [align_key(d) for d in disasm]
    matcher = difflib.SequenceMatcher(None, s_keys, d_keys, autojunk=False)

    rows = []
    cats = Counter()

    def add(src, dis):
        if src is None:
            cat = "extra_disasm"
        elif dis is None:
            cat = "missing_disasm"
        else:
            cat = classify(src, dis)
        cats[cat] += 1
        rows.append({"index": len(rows) + 1, "category": cat,
                     "source": src or "", "disasm": dis or ""})

    for tag, i1, i2, j1, j2 in matcher.get_opcodes():
        if tag == "equal":
            for k in range(i2 - i1):
                add(clean[i1 + k], disasm[j1 + k])
        elif tag == "replace":
            for k in range(max(i2 - i1, j2 - j1)):
                s = clean[i1 + k] if i1 + k < i2 else None
                d = disasm[j1 + k] if j1 + k < j2 else None
                add(s, d)
        elif tag == "delete":
            for k in range(i1, i2):
                add(clean[k], None)
        elif tag == "insert":
            for k in range(j1, j2):
                add(None, disasm[k])

    n = len(rows)
    with (OUT_DIR / "step5_roundtrip_compare.csv").open("w", newline="", encoding="utf-8-sig") as f:
        w = csv.DictWriter(f, fieldnames=["index", "category", "source", "disasm"])
        w.writeheader()
        w.writerows(rows)

    benign = sum(v for k, v in cats.items() if k in BENIGN)
    report = [
        "# Stage 5 Roundtrip 비교 리포트", "",
        f"- 비교 행: {n}",
        f"- 정상(일치/별칭/표기차/상대주소): {benign} ({benign/n*100:.2f}%)",
        f"- 검토 대상: {n - benign}", "",
        "## 카테고리별 분포", "", "| 카테고리 | 건수 |", "|---|---:|",
    ]
    for k, v in cats.most_common():
        report.append(f"| {k} | {v} |")
    report += ["", "## 검토 대상 샘플 (최대 25)", ""]
    shown = 0
    for r in rows:
        if r["category"] not in BENIGN:
            report.append(f"- `{r['source']}`  →  `{r['disasm']}`  ({r['category']})")
            shown += 1
            if shown >= 25:
                break
    (OUT_DIR / "step5_roundtrip_report.md").write_text("\n".join(report) + "\n", encoding="utf-8")

    print(f"\n=== 카테고리 ===")
    for k, v in cats.most_common():
        print(f"  {v:5d}  {k}")
    print(f"\n[저장] {OUT_DIR}/step5_roundtrip_compare.csv, step5_roundtrip_report.md")


if __name__ == "__main__":
    main()

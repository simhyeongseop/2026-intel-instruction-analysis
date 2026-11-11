"""5단계 Intel·AT&T 왕복 대조: 어셈블러가 만든 바이트를 역어셈블 -> 다시 조립 -> 다시 역어셈블해 처음과 비교한다.

    python3 pipeline/m5_roundtrip.py [--cases out/cases] [--out out/roundtrip_20261103] [--workers 8] [--limit N]

2026-11-03 연구실 미팅(화이트보드) 흐름. 계열마다(같은 계열 도구끼리만, 2026-10-11 결정 유지):
    Intel 소스 --어셈블러--> B0 --역어셈블 AT&T--> A0 --다시 조립(AT&T)--> Ba --역어셈블--> A1, I1
                               --역어셈블 Intel--> I0 --다시 조립(Intel)--> Bi --역어셈블--> A2, I2
- gnu : B0 = 3단계 GNU as 바이트, objdump로 풀고 GNU as로 다시 조립.
        objdump도 as(-mintel64)와 같은 Intel64 해석(-M intel64)으로 푼다(기본값 AMD64면 MOVSXD r16이 r/m32로 나옴)
- llvm: B0 = 3단계 clang 바이트, llvm-mc --disassemble로 풀고 clang으로 다시 조립
대상: 그 어셈블러가 받아들인 케이스 전부(3단계 SDM 불일치 포함, 판정은 sdm_verdict 열에 남김).
한 바이트열에서 여러 명령이 나와도(FWAIT 짝 등) 출력 전체를 그대로 다시 조립한다.

판정(verdict_att: AT&T 경로, verdict_intel: Intel 경로. 같은 규칙):
- 바이트 같음: 다시 조립한 바이트 == B0
- 바이트 다름·명령 같음: 바이트는 다르지만 다시 푼 AT&T·Intel 명령이 처음 명령과 같다
  (텍스트에 방향 비트·{evex} 같은 인코딩 선택이 남지 않으므로 정상일 수 있다. 버그로 단정하지 않는다)
- 바이트 다름·명령 다름: 다시 푼 명령까지 바뀌었다(우선 검토)
- 재조립 거부: 도구가 자기 출력을 다시 받지 않는다(검토)
제외(비교 불가): 분기 대상 미대조(같은 파일 라벨 .Ltarget 형식, 출력이 절대 주소), 재배치 생김, 역어셈블 실패

외부 기호 분기(2026-11-11 교수님 미팅): 소스의 분기 대상이 정의하지 않은 외부 기호(ext_target)면 B0의 변위는 0이고
재배치가 남는다. 역어셈블 출력의 분기 대상 숫자(objdump 'ja 0x6', llvm-mc 'ja 0')를 그 기호로 바꿔(target_rewrite)
다시 조립하고, 바이트와 재배치(위치·종류·기호·addend)를 함께 비교한다.

가르기(localize_att, localize_intel; 2026-11-11 교수님 미팅): 3단계가 원본 Intel 소스를 AT&T로 직접 바꿔 같은
어셈블러로 조립한 결과(syntax_<도구>)를 쓴다. 경로가 B0로 돌아오지 않을 때
- 역어셈블 출력 쪽 의심: 원본 Intel·AT&T 소스는 같은 바이트(B0)인데, 역어셈블러가 낸 그 문법 텍스트만 다른 결과
- 어셈블러 문법 해석 쪽 의심: 원본 Intel·AT&T 소스부터 바이트가 다르거나 한쪽만 거부
- 가를 수 없음: AT&T 변환 없음 등
어느 쪽도 버그 확정이 아니다(텍스트가 매뉴얼상 그 바이트를 뜻하는지는 따로 본다).
byte_match·insn_match 열은 예/아니오로 따로 남긴다. route: 두 경로(Ba, Bi)의 바이트가 같은가.
이 단계는 도구 자기 일관성 관측이다. SDM 적합성은 3·4단계가 본다.
"""

import argparse
import collections
import csv
import json
import os
import re
import subprocess
import sys
import tempfile
from concurrent.futures import ThreadPoolExecutor
from datetime import datetime, timezone

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from pipeline import toolchain as T  # noqa: E402
from pipeline.instruction_check import assemble, environment, relocation_text, sha256  # noqa: E402
from pipeline.m4_disasm import join_prefix_lines, read_csv, write_csv  # noqa: E402

FAMILIES = {"gnu": "as", "llvm": "clang"}      # 계열 -> 어셈블러(3단계 열 이름과 다시 조립에 같이 씀)
SYNTAX_HEADER = {"intel": ".intel_syntax noprefix\n", "att": ".att_syntax prefix\n"}
SAME = "바이트 같음"
SAME_INSN = "바이트 다름·명령 같음"
DIFFERENT = "바이트 다름·명령 다름"
REJECTED = "재조립 거부"
RELATIVE = "분기 대상 미대조"
RELOCATED = "재배치 생김"
UNDECODED = "역어셈블 실패"


# ---------- 역어셈블 ----------

def objdump_text(hex_bytes, syntax):
    """GNU objdump로 바이트를 푼다. (명령 텍스트 목록, 바이트를 남김없이 풀었는가)."""
    with tempfile.TemporaryDirectory(prefix="m5_") as folder:
        path = os.path.join(folder, "b.bin")
        with open(path, "wb") as handle:
            handle.write(bytes.fromhex(hex_bytes))
        run = subprocess.run([T.OBJDUMP, "-D", "-w", "-b", "binary", "-m", "i386:x86-64", "-M", syntax + ",intel64",
                              "--insn-width=16", path], capture_output=True, text=True, timeout=20)
    texts, used = [], 0
    for line in run.stdout.splitlines():
        match = re.match(r"^\s*[0-9a-f]+:\t((?:[0-9a-f]{2} )+)\s*\t?(.*)$", line)
        if match:
            texts.append(match.group(2).strip())
            used += len(match.group(1).split())
    # 풀지 못한 바이트는 '(bad)' 또는 '.byte 0xf'로 나온다. '.byte'는 다시 조립하면 같은 바이트가 되므로 실패로 본다
    whole = bool(texts) and used * 2 == len(hex_bytes) and not any(
        "(bad)" in t or t.startswith(".byte") for t in texts)
    return texts, whole


def llvm_text(hex_bytes, syntax):
    """llvm-mc로 바이트를 푼다. --output-asm-variant: 0 = AT&T, 1 = Intel."""
    data = " ".join("0x" + hex_bytes[i:i + 2] for i in range(0, len(hex_bytes), 2))
    variant = "1" if syntax == "intel" else "0"
    run = subprocess.run([T.LLVM_MC, "--disassemble", "-triple=x86_64-unknown-linux-gnu",
                          "--output-asm-variant=" + variant], input=data, capture_output=True, text=True, timeout=20)
    lines = [l.strip() for l in run.stdout.splitlines() if l.strip() and not l.strip().startswith(".")]
    invalid = "invalid instruction encoding" in run.stderr or "potentially undefined" in run.stderr
    return join_prefix_lines(lines), bool(lines) and not invalid


def disassemble(family, hex_bytes, syntax):
    return (objdump_text if family == "gnu" else llvm_text)(hex_bytes, syntax)


def clean(text):
    """비교·다시 조립용 텍스트: 주석('# 0x...'), 기호(<...>) 제거, 공백 하나로."""
    text = re.sub(r"<[^>]*>", "", text)
    text = re.sub(r"\s*(#|//).*$", "", text)
    return " ".join(text.split())


def both_texts(family, hex_bytes, external=False):
    """(AT&T 명령 튜플, Intel 명령 튜플, 둘 다 남김없이 풀었는가). external이면 분기 대상을 외부 기호로 바꾼다."""
    att, att_whole = disassemble(family, hex_bytes, "att")
    intel, intel_whole = disassemble(family, hex_bytes, "intel")
    fix = rewrite_target if external else (lambda t: t)
    return (tuple(fix(clean(t)) for t in att), tuple(fix(clean(t)) for t in intel), att_whole and intel_whole)


EXTERNAL_TARGET = "ext_target"
BRANCH = re.compile(r"^(?:[a-z0-9.]+\s+)*?(j[a-z]+|call[qlw]?|loop[a-z]*|xbegin[a-z]*)\s+(-?(?:0x)?[0-9a-f]+)$")


def rewrite_target(text):
    """'ja 0x6' / 'ja 0' -> 'ja ext_target'. 간접 분기('*', 메모리)와 숫자 아닌 대상은 그대로."""
    match = BRANCH.match(text)
    if not match or "*" in text or "[" in text or "(" in text:
        return text
    return text[:match.start(2)] + EXTERNAL_TARGET


def reassemble(family, texts, syntax):
    """역어셈블 텍스트를 같은 계열 어셈블러로 다시 조립한다. (받았는가, 바이트, 재배치 한 줄)."""
    source = SYNTAX_HEADER[syntax] + "".join(t + "\n" for t in texts)
    result = assemble(source, FAMILIES[family], display_syntax=syntax)
    return result["observation_status"] == "accepted", result["bytes"], relocation_text(result["relocation_list"])


# ---------- 판정 ----------

def verdict(accepted, relocated, byte_match, insn_match):
    """한 경로의 판정. 인자는 다시 조립 결과와 두 비교의 참/거짓."""
    if not accepted:
        return REJECTED
    if relocated:
        return RELOCATED
    if byte_match:
        return SAME
    return SAME_INSN if insn_match else DIFFERENT


def route(att, intel):
    """두 경로(AT&T, Intel) 다시 조립 결과가 같은가. att·intel: (받았는가, 바이트)."""
    if not att[0] and not intel[0]:
        return "둘 다 거부"
    if not att[0]:
        return "AT&T 경로만 거부"
    if not intel[0]:
        return "Intel 경로만 거부"
    return "두 경로 같음" if att[1] == intel[1] else "두 경로 바이트 다름"


def yes_no(value):
    return "예" if value else "아니오"


def one_path(family, syntax, b0, first, reloc0="", external=False):
    """한 경로(syntax로 풀어 다시 조립)를 돌린다. first: 처음 (AT&T, Intel) 명령 튜플.
    external: 외부 기호 분기. 다시 조립한 재배치(reloc)가 B0의 재배치(reloc0)와 같아야 바이트 같음."""
    texts = first[0] if syntax == "att" else first[1]
    accepted, again, reloc = reassemble(family, texts, syntax)
    out = {"bytes": again if accepted else "거부", "reloc": reloc, "again_att": "", "again_intel": "",
           "byte_match": "", "insn_match": "", "verdict": "", "accepted": accepted, "raw": (again, reloc)}
    if not accepted:
        out["verdict"] = REJECTED
        return out
    relocated = bool(reloc) and not external
    byte_match = again == b0 and reloc == reloc0
    second = first
    if not byte_match:
        att2, intel2, whole = both_texts(family, again, external)
        out["again_att"], out["again_intel"] = " | ".join(att2), " | ".join(intel2)
        second = (att2, intel2) if whole else None
    insn_match = second == first
    out.update(byte_match=yes_no(byte_match), insn_match=yes_no(insn_match),
               verdict=verdict(accepted, relocated, byte_match, insn_match))
    return out


PATH_KEYS = ("bytes", "reloc", "again_att", "again_intel", "byte_match", "insn_match", "verdict")


def roundtrip(family, b0, relative=False, reloc0="", external=False):
    """한 계열의 왕복 관측(두 경로). 결과 열 사전을 돌려준다.
    relative: 같은 파일 라벨 분기(비교 불가). external: 외부 기호 분기(대상 숫자를 기호로 바꿔 비교)."""
    att, intel, whole = both_texts(family, b0, external)
    row = {"att": " | ".join(att), "intel": " | ".join(intel), "route": "",
           "target_rewrite": "예" if external else ""}
    for syntax in ("att", "intel"):
        for key in PATH_KEYS:
            row["%s_%s" % (key, syntax)] = ""
    if not whole or relative:
        row["verdict_att"] = row["verdict_intel"] = UNDECODED if not whole else RELATIVE
        return row
    paths = {}
    for syntax in ("att", "intel"):
        paths[syntax] = one_path(family, syntax, b0, (att, intel), reloc0, external)
        for key in PATH_KEYS:
            row["%s_%s" % (key, syntax)] = paths[syntax][key]
    row["route"] = route((paths["att"]["accepted"], paths["att"]["raw"]),
                         (paths["intel"]["accepted"], paths["intel"]["raw"]))
    return row


def localize(verdict, syntax_check):
    """경로가 B0로 돌아오지 않을 때 어느 쪽을 의심할지. syntax_check: 3단계 syntax_<도구>."""
    if verdict in ("", SAME, RELATIVE, UNDECODED):
        return ""
    if syntax_check == "같은 바이트":
        return "역어셈블 출력 쪽 의심"
    if syntax_check in ("바이트 다름", "AT&T만 거부", "Intel만 거부"):
        return "어셈블러 문법 해석 쪽 의심"
    return "가를 수 없음"


def targets(results):
    """(계열, 3단계 결과 행) 목록: 그 계열 어셈블러가 받아 바이트가 있는 케이스."""
    out = []
    for family, tool in FAMILIES.items():
        for result in results:
            if result["status_" + tool] == "accepted" and result["bytes_" + tool]:
                out.append((family, result))
    return out


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--cases", default=os.path.join(ROOT, "out/cases"))
    parser.add_argument("--out", default=os.path.join(ROOT, "out/roundtrip_20261103"))
    parser.add_argument("--workers", type=int, default=8)
    parser.add_argument("--limit", type=int, default=0, help="계열마다 앞에서 N개만(시험용)")
    args = parser.parse_args()
    started = datetime.now(timezone.utc).isoformat()
    source = os.path.join(args.cases, "check_results.csv")
    results = read_csv(source)
    if args.limit:
        results = results[:args.limit]
    work_list = targets(results)

    def work(item):
        family, result = item
        tool = FAMILIES[family]
        row = {"case_id": result["case_id"], "row_id": result["row_id"], "instruction": result["instruction"],
               "opcode": result["opcode"], "source": result["source"], "family": family,
               "sdm_verdict": result["verdict_" + tool], "b0": result["bytes_" + tool],
               "reloc0": result.get("reloc_" + tool, ""), "syntax_check": result.get("syntax_" + tool, "")}
        row.update(roundtrip(family, row["b0"], ".Ltarget" in result["source"], row["reloc0"],
                             EXTERNAL_TARGET in result["source"]))
        for syntax in ("att", "intel"):
            row["localize_" + syntax] = localize(row["verdict_" + syntax], row["syntax_check"])
        return row

    with ThreadPoolExecutor(max_workers=max(1, args.workers)) as pool:
        rows = list(pool.map(work, work_list))
    os.makedirs(args.out, exist_ok=True)
    write_csv(os.path.join(args.out, "roundtrip_results.csv"), rows)
    summary = {"cases": dict(collections.Counter(r["family"] for r in rows)), "verdicts": {}, "routes": {},
               "localize": {}}
    for family in FAMILIES:
        mine = [r for r in rows if r["family"] == family]
        summary["verdicts"][family] = {s: dict(collections.Counter(r["verdict_" + s] for r in mine))
                                       for s in ("att", "intel")}
        summary["routes"][family] = dict(collections.Counter(r["route"] for r in mine if r["route"]))
        summary["localize"][family] = {s: dict(collections.Counter(r["localize_" + s] for r in mine
                                                                   if r["localize_" + s])) for s in ("att", "intel")}
    with open(os.path.join(args.out, "roundtrip_summary.json"), "w", encoding="utf-8") as handle:
        json.dump(summary, handle, ensure_ascii=False, indent=1)
    manifest = {"started_utc": started, "finished_utc": datetime.now(timezone.utc).isoformat(),
                "command": sys.argv, "limit": args.limit, "input": {source: sha256(source)},
                "code": {p: sha256(os.path.join(ROOT, p)) for p in
                         ("pipeline/m5_roundtrip.py", "pipeline/m4_disasm.py", "pipeline/instruction_check.py")},
                "environment": environment(), "summary": summary}
    with open(os.path.join(args.out, "manifest.json"), "w", encoding="utf-8") as handle:
        json.dump(manifest, handle, ensure_ascii=False, indent=1)
    print(json.dumps(summary, ensure_ascii=False, indent=1))


if __name__ == "__main__":
    main()

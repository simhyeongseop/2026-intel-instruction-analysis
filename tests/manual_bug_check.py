"""
triage(7단계)가 찾아낸 발견 13건을 형섭이 직접 눈으로 확인하기 위한 테스트 스크립트.

이 파일은 파이프라인의 일부가 아니다 (pipeline/ 밑에 안 두는 이유).
CLAUDE.md 1절 "판정은 도구(as/objdump)가 한다" 원칙대로, 여기 적힌 asm 한 줄 한 줄을
실제로 GNU `as --64 -mintel64`에 넣어서 그 자리에서 성공/실패를 확인한다.
LLM이 "이게 버그다"라고 주장하는 게 아니라, 실행 결과를 그대로 보여주는 것뿐이다.

사용법:
    python3 tests/manual_bug_check.py            # 13건 전체
    python3 tests/manual_bug_check.py call_jmp_ne_case  # id로 하나만

두 그룹으로 나뉜다:
  [B] 진짜 버그 후보 (7건) — SDM과 GNU as가 실제로 다르게 동작하는 것.
      이건 "고치는" 대상이 아니라 이 프로젝트가 찾으려는 결과물 그 자체.
  [A] 우리 파이프라인(combiner) 코드의 한계 (6건) — combiner가 대표값을 잘못 골라서
      정상적으로 되는 명령어를 실패로 잘못 만든 것. broken(combiner 실제 출력)과
      control(SDM대로 썼으면 나왔어야 할 형태)을 나란히 비교해서 보여준다.

각 케이스의 근거(combo_id, 원본 asm_line, 에러 메시지)는 out/asm_result.csv /
out/triage.csv 에서 그대로 가져온 것이다 — 이 스크립트에 적힌 것과 그 CSV들을
대조해보면 같은 값이 나온다.
"""

import subprocess
import sys
import tempfile
import os

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

AS_CMD = ["as", "--64", "-mintel64"]

CASES = [
    # ------------------------------------------------------------------
    # [B] 진짜 버그 후보 7건 — SDM 기준과 GNU as 실제 동작이 다른 케이스.
    # ------------------------------------------------------------------
    {
        "id": "call_rm32_ne",
        "group": "B",
        "combo_id": 419,
        "claim": "SDM: 64비트 모드에서 CALL r/m32(FF /2)는 N.E.(인코딩 불가). "
                 "as: addr32(0x67)+opsize(0x66) 프리픽스를 붙여 조용히 인코딩해버림.",
        "broken_line": "call dword ptr [eax]",
        "broken_sdm_expect": "error",   # SDM대로면 거부돼야 함
        "control_line": None,
        "control_note": None,
    },
    {
        "id": "jmp_rm32_ne",
        "group": "B",
        "combo_id": 1436,
        "claim": "SDM: 64비트 모드에서 JMP r/m32(FF /4)는 N.S./N.E.(인코딩 불가). "
                 "as: CALL과 동일하게 addr32+opsize 프리픽스로 조용히 인코딩.",
        "broken_line": "jmp dword ptr [eax]",
        "broken_sdm_expect": "error",
        "control_line": None,
        "control_note": None,
    },
    {
        "id": "lar_r64_source",
        "group": "B",
        "combo_id": 1516,
        "claim": "SDM p.651 'LAR r32, r64/m16'가 r64 소스를 명시적으로 허용 "
                 "(주석1: 오퍼랜드 크기와 무관하게 소스 레지스터 하위 16비트만 사용). "
                 "as: r64는 거부하고 r16만 받음.",
        "broken_line": "lar ecx, rcx",
        "broken_sdm_expect": "ok",   # SDM대로면 성공해야 함
        "control_line": "lar ecx, cx",
        "control_note": "as가 실제로 받아주는 형태(r16) — SDM이 명시한 r64와는 다름",
    },
    {
        "id": "lsl_r32_source",
        "group": "B",
        "combo_id": 1571,
        "claim": "SDM p.691 'LSL r64, r32/m16'가 r32 소스를 명시적으로 허용. "
                 "as: r32는 거부하고 r16만 받음.",
        "broken_line": "lsl rcx, ecx",
        "broken_sdm_expect": "ok",
        "control_line": "lsl rcx, cx",
        "control_note": "as가 실제로 받아주는 형태(r16) — SDM이 명시한 r32와는 다름",
    },
    {
        "id": "mov_sreg_rm64",
        "group": "B",
        "combo_id": 1683,
        "claim": "isa_db.csv: 'REX.W + 8E /r MOV Sreg, r/m64'가 Valid로 명시. "
                 "as: r/m64 메모리 폼을 거부하고(operand type mismatch) r/m16만 받음.",
        "broken_line": "mov ds, qword ptr [eax]",
        "broken_sdm_expect": "ok",
        "control_line": "mov ds, word ptr [eax]",
        "control_note": "as가 실제로 받아주는 형태(m16) — SDM이 명시한 r/m64 인코딩 경로가 as에 없음",
    },
    {
        "id": "udb_mnemonic",
        "group": "B",
        "combo_id": 4597,
        "claim": "SDM p.1436: 'D6 UDB' 오피코드가 64비트 모드 Valid (UD0/UD1/UD2와 같은 계열). "
                 "as: 'udb'라는 니모닉 자체를 모름.",
        "broken_line": "udb",
        "broken_sdm_expect": "ok",
        "control_line": "ud2",
        "control_note": "같은 계열(UD0/UD1/UD2) 중 as가 아는 것 — udb만 니모닉이 없음",
    },
    {
        "id": "vpmovqd_memsize",
        "group": "B",
        "combo_id": 6540,
        "claim": "SDM p.2054: VPMOVQD(EVEX.128 truncate) 대상 메모리를 'xmm1/m128'로 명시. "
                 "as: xmmword ptr(m128)는 거부하고 qword ptr(m64)만 받음.",
        "broken_line": "vpmovqd xmmword ptr [eax], xmm0",
        "broken_sdm_expect": "ok",
        "control_line": "vpmovqd qword ptr [eax], xmm0",
        "control_note": "as가 실제로 받아주는 크기(m64) — SDM 표기(m128)와 다름",
    },
    # ------------------------------------------------------------------
    # [A] 우리 combiner(pipeline/m3_combine.py) 코드의 한계 6건.
    # broken_line = combiner가 실제로 만들어낸 조합 (out/asm_result.csv 그대로).
    # control_line = SDM 뜻대로 사람이 직접 쓰면 정상적으로 되는 형태.
    # ------------------------------------------------------------------
    {
        "id": "combiner_farptr_collapse",
        "group": "A",
        "combo_id": 424,
        "claim": "combiner의 MEM_SIZE_RE 정규식(m3_combine.py)이 'm16:16'의 콜론 뒤를 "
                 "무시하고 앞부분 'm16'만 매치해서, far-ptr 메모리 오퍼랜드를 그냥 'word ptr'로 "
                 "잘못 축소해버림 (CALL m16:16/m16:32 6건 전부 영향).",
        "broken_line": "call word ptr [eax]",
        "broken_sdm_expect": "ok",  # combiner가 안 망가뜨렸으면 성공했어야 함
        "control_line": "call far [eax]",
        "control_note": "combiner가 far-ptr을 제대로 다뤘으면 나왔어야 할 형태(far 지시어) — 정상 어셈블됨",
    },
    {
        "id": "combiner_moffs_brackets",
        "group": "A",
        "combo_id": 1689,
        "claim": "combiner의 expand_token(moffs 분기, m3_combine.py 169행)이 괄호 없이 "
                 "'0x1000'을 그대로 반환해서, as가 메모리 오퍼랜드가 아니라 즉시값 mov로 "
                 "오인함 (MOV moffs류 5건 전부 영향).",
        "broken_line": "mov 0x1000, al",
        "broken_sdm_expect": "ok",
        "control_line": "mov [0x1000], al",
        "control_note": "combiner가 괄호를 붙였으면 나왔어야 할 형태 — 정상 어셈블됨",
    },
    {
        "id": "combiner_register_reuse",
        "group": "A",
        "combo_id": 4541,
        "claim": "combiner의 register_candidate(m3_combine.py 92행)가 타입 하나당 대표 "
                 "레지스터 하나만 고정 반환(tmm -> 항상 tmm0)해서, 오퍼랜드 슬롯이 여러 개면 "
                 "전부 같은 레지스터가 들어감 (register_reuse 38건 전부 영향).",
        "broken_line": "tdpbf16ps tmm0, tmm0, tmm0",
        "broken_sdm_expect": "ok",
        "control_line": "tdpbf16ps tmm0, tmm1, tmm2",
        "control_note": "combiner가 슬롯마다 다른 레지스터를 골랐으면 나왔어야 할 형태 — 정상 어셈블됨",
    },
    {
        "id": "combiner_vsib_missing_index",
        "group": "A",
        "combo_id": 5798,
        "claim": "combiner의 memory_candidate가 대표 메모리 주소를 항상 '[eax]' 고정으로 "
                 "반환해서, VSIB(gather/scatter)가 요구하는 인덱스 레지스터(xmm/ymm)가 "
                 "아예 없음 (16건 전부 영향).",
        "broken_line": "vgatherdpd xmm0, [eax], xmm0",
        "broken_sdm_expect": "ok",
        "control_line": "vgatherdpd xmm0, [eax + xmm1], xmm0",
        "control_note": "combiner가 VSIB 인덱스 레지스터를 넣었으면 나왔어야 할 형태 — 정상 어셈블됨",
    },
    {
        "id": "combiner_mpx_addr32_missing",
        "group": "A",
        "combo_id": 323,
        "claim": "combiner가 대표 주소 '[eax]'(32비트 addr32)를 그대로 쓰는데, MPX 명령어는 "
                 "64비트 모드에서 32비트 주소 자체를 거부함 (12건 전부 영향).",
        "broken_line": "bndcl bnd0, dword ptr [eax]",
        "broken_sdm_expect": "ok",
        "control_line": "bndcl bnd0, [rax]",
        "control_note": "combiner가 64비트 주소 레지스터(rax)를 썼으면 나왔어야 할 형태 — 정상 어셈블됨",
    },
    {
        "id": "combiner_avx512_default_mask",
        "group": "A",
        "combo_id": 5802,
        "claim": "combiner의 strip_decorations(m3_combine.py 87행)가 SDM의 '{k1}' 마스크 "
                 "표기를 무조건 지워버려서, 마스크가 필수인 AVX512 gather/scatter가 "
                 "기본 마스크(k0) 상태로 생성됨 — k0는 허용 안 됨 (64건 전부 영향).",
        "broken_line": "vgatherdps xmm0, [eax]",
        "broken_sdm_expect": "ok",
        "control_line": "vgatherdps xmm0 {k1}, [eax + xmm1]",
        "control_note": "combiner가 {k1} 마스크와 VSIB 인덱스를 둘 다 살렸으면 나왔어야 할 형태 — 정상 어셈블됨",
    },
]


def assemble(line):
    """asm 한 줄을 실제로 as에 넣어서 (성공여부, 에러메시지) 반환."""
    with tempfile.TemporaryDirectory() as d:
        src = os.path.join(d, "line.s")
        obj = os.path.join(d, "line.o")
        with open(src, "w", encoding="utf-8") as f:
            f.write(".intel_syntax noprefix\n")
            f.write(line + "\n")
        result = subprocess.run(
            AS_CMD + ["-o", obj, src],
            capture_output=True, text=True,
        )
        ok = result.returncode == 0
        err = result.stderr.strip().replace("\n", " | ")
        return ok, err


def run_case(case):
    print(f"\n{'='*70}")
    print(f"[{case['group']}] {case['id']}  (combo_id={case['combo_id']})")
    print(f"근거: {case['claim']}")

    ok, err = assemble(case["broken_line"])
    actual = "ok" if ok else "error"
    print(f"  실행: {case['broken_line']!r}")
    print(f"  as 결과: {actual}" + (f"  ({err})" if err else ""))

    expect = case["broken_sdm_expect"]
    if actual == expect:
        print(f"  -> SDM 기대({expect})와 일치. 재현 실패(더 이상 버그 아닐 수 있음) — 형섭 확인 필요.")
    else:
        print(f"  -> SDM 기대({expect})와 다름. 보고된 그대로 재현됨.")

    if case["control_line"]:
        cok, cerr = assemble(case["control_line"])
        cactual = "ok" if cok else "error"
        print(f"  대조군: {case['control_line']!r}")
        print(f"  as 결과: {cactual}" + (f"  ({cerr})" if cerr else ""))
        print(f"  대조군 의미: {case['control_note']}")

    return actual != expect  # True면 "보고된 대로 재현됨"


def show_code_evidence():
    """asm 재현과 별개로, combiner 코드 자체가 실제로 이렇게 동작한다는 걸 직접 보여준다."""
    from pipeline.m3_combine import MEM_SIZE_RE, expand_token

    print(f"\n{'='*70}")
    print("코드 레벨 증거 (pipeline/m3_combine.py 를 직접 import 해서 실행)")

    m = MEM_SIZE_RE.match("m16:16")
    print(f"  MEM_SIZE_RE.match('m16:16') -> {m.group() if m else None!r}")
    print("  (far-ptr 타입 'm16:16'인데 콜론 뒤를 무시하고 'm16'만 매치 — combiner_farptr_collapse 원인)")

    result, note = expand_token("moffs8", "moffs")
    print(f"  expand_token('moffs8', 'moffs') -> {result!r}")
    print("  (괄호 없는 '0x1000' 그대로 반환 — combiner_moffs_brackets 원인)")


def main():
    only_id = sys.argv[1] if len(sys.argv) > 1 else None
    cases = [c for c in CASES if only_id is None or c["id"] == only_id]
    if not cases:
        print(f"알 수 없는 id: {only_id}")
        print("사용 가능한 id: " + ", ".join(c["id"] for c in CASES))
        sys.exit(1)

    if only_id is None:
        show_code_evidence()

    reproduced = []
    for case in cases:
        matched = run_case(case)
        reproduced.append((case["id"], matched))

    print(f"\n{'='*70}")
    print("요약")
    for cid, matched in reproduced:
        mark = "재현됨" if matched else "재현 안 됨(확인 필요)"
        print(f"  {cid}: {mark}")
    n_ok = sum(1 for _, m in reproduced if m)
    print(f"\n{n_ok}/{len(reproduced)}건 보고된 그대로 재현.")


if __name__ == "__main__":
    main()

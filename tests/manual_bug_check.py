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
      이건 "고치는" 대상이 아니라 이 프로젝트가 찾으려는 결과물 그 자체. 아직 안 고쳤고,
      broken_line/control_line으로 지금도 재현된다.
  [A] 우리 파이프라인(combiner) 코드의 한계 (6건) — combiner가 대표값을 잘못 골라서
      정상적으로 되는 명령어를 실패로 잘못 만들었던 것. **2026-07-24에 pipeline/m3_combine.py를
      고쳐서 전부 해결됨.** broken_line(수정 전 실제로 나왔던 값, 역사적 기록)과
      fixed_line(수정 후 combos.csv에서 실제로 나오는 값)을 같이 어셈블해서
      "그때는 실패 -> 지금은 성공"을 직접 비교해서 보여준다.

각 케이스의 근거(combo_id, 원본 asm_line, 에러 메시지)는 out/asm_result.csv /
out/triage.csv 에서 그대로 가져온 것이다 — 이 스크립트에 적힌 것과 그 CSV들을
대조해보면 같은 값이 나온다. [A] 그룹의 fixed_line은 data/db/combos.csv에서
combo_id로 다시 조회해도 같은 값이 나온다.
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
    # [A] 우리 combiner(pipeline/m3_combine.py) 코드의 한계 6건 — 2026-07-24 수정 완료.
    # broken_line = 수정 전 combiner가 실제로 만들어냈던 조합 (역사적 기록용, 지금은 안 나옴).
    # fixed_line = 수정 후 combiner가 실제로 만들어내는 조합 (data/db/combos.csv에서 그대로 가져옴).
    # 둘 다 실행해서 "그때는 실패 -> 지금은 성공"을 직접 비교해서 보여준다.
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
        "fixed_line": "call far ptr [eax]",
        "fixed_note": "수정 후 combiner가 실제로 만들어내는 값(combo_id 424) — far-ptr 전용 "
                      "FAR_PTR_ATOM_RE 추가로 해결. 정상 어셈블됨.",
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
        "fixed_line": "mov [0x1000], al",
        "fixed_note": "수정 후 combiner가 실제로 만들어내는 값(combo_id 1689) — 괄호를 붙이도록 "
                      "고쳐서 해결. 정상 어셈블됨.",
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
        "fixed_line": "tdpbf16ps tmm0, tmm1, tmm2",
        "fixed_note": "수정 후 combiner가 실제로 만들어내는 값(combo_id 4541) — 슬롯마다 순번을 "
                      "매기는 register_candidate(atom, occurrence)로 해결. 정상 어셈블됨.",
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
        "fixed_line": "vgatherdpd xmm0, [eax + xmm1], xmm0",
        "fixed_note": "수정 후 combiner가 실제로 만들어내는 값(combo_id 5798) — VSIB_ATOM_RE로 "
                      "인덱스 레지스터를 붙이도록 해결. 정상 어셈블됨. (단, VSCATTERDPD ymm/zmm "
                      "2건은 SDM 원문 자체의 비대칭 표기 때문에 여전히 실패 — combiner 버그 아님, "
                      "triage에 unsure로 별도 분류됨)",
    },
    {
        "id": "combiner_mpx_addr32_missing",
        "group": "A",
        "combo_id": 323,
        "claim": "combiner가 대표 주소 '[eax]'(32비트 addr32)를 그대로 쓰는데, MPX 명령어는 "
                 "64비트 모드에서 32비트 주소 자체를 거부함 (12건 전부 영향).",
        "broken_line": "bndcl bnd0, dword ptr [eax]",
        "broken_sdm_expect": "ok",
        "fixed_line": "bndcl bnd0, dword ptr [rax]",
        "fixed_note": "수정 후 combiner가 실제로 만들어내는 값(combo_id 323) — MPX_MNEMONICS일 때 "
                      "64비트 주소(rax)를 쓰도록 해결. 정상 어셈블됨.",
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
        "fixed_line": "vgatherdps xmm0 {k1}, [eax + xmm1]",
        "fixed_note": "수정 후 combiner가 실제로 만들어내는 값(combo_id 5802) — {k1} 마스크를 "
                      "살리도록 해결(VSIB 인덱스도 같이 반영됨). 정상 어셈블됨.",
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

    if case.get("control_line"):
        cok, cerr = assemble(case["control_line"])
        cactual = "ok" if cok else "error"
        print(f"  대조군: {case['control_line']!r}")
        print(f"  as 결과: {cactual}" + (f"  ({cerr})" if cerr else ""))
        print(f"  대조군 의미: {case['control_note']}")

    fixed_ok = None
    if case.get("fixed_line"):
        fok, ferr = assemble(case["fixed_line"])
        fixed_ok = fok
        factual = "ok" if fok else "error"
        print(f"  수정 후(현재 combiner 출력): {case['fixed_line']!r}")
        print(f"  as 결과: {factual}" + (f"  ({ferr})" if ferr else ""))
        print(f"  {case['fixed_note']}")
        if factual != "ok":
            print("  경고: 수정 후에도 여전히 실패함 — 형섭 확인 필요.")

    return actual != expect, fixed_ok  # (broken_line이 보고된 대로 재현됐는지, fixed_line이 성공했는지)


def show_code_evidence():
    """asm 재현과 별개로, combiner 코드 자체가 실제로 이렇게 동작하는지 직접 보여준다.
    2026-07-24 combiner 수정 이후: MEM_SIZE_RE 자체는 그대로지만(여전히 'm16'만 매치),
    far-ptr 타입은 FAR_PTR_ATOM_RE 가 먼저 가로채도록 고쳐서 우회한다. moffs는 이제 괄호를 씌운다."""
    from pipeline.m3_combine import MEM_SIZE_RE, FAR_PTR_ATOM_RE, expand_token

    print(f"\n{'='*70}")
    print("코드 레벨 증거 (pipeline/m3_combine.py 를 직접 import 해서 실행)")

    m = MEM_SIZE_RE.match("m16:16")
    print(f"  MEM_SIZE_RE.match('m16:16') -> {m.group() if m else None!r}  (정규식 자체는 여전히 이렇게 매치함)")
    fm = FAR_PTR_ATOM_RE.match("m16:16")
    print(f"  FAR_PTR_ATOM_RE.match('m16:16') -> {'매치됨' if fm else None!r}  (수정 후: 이 정규식이 먼저 가로채서 MEM_SIZE_RE까지 안 감)")

    result, note = expand_token("moffs8", "moffs")
    print(f"  expand_token('moffs8', 'moffs') -> {result!r}  (수정 후: 괄호가 붙어서 나옴)")


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
        matched, fixed_ok = run_case(case)
        reproduced.append((case["id"], case["group"], matched, fixed_ok))

    print(f"\n{'='*70}")
    print("요약")
    for cid, group, matched, fixed_ok in reproduced:
        if fixed_ok is None:
            mark = "재현됨(아직 진짜 버그로 남아있음)" if matched else "재현 안 됨(확인 필요)"
        else:
            mark = "수정 확인됨(fixed_line 성공)" if fixed_ok else "여전히 실패(확인 필요)"
        print(f"  [{group}] {cid}: {mark}")

    n_bug_ok = sum(1 for _, g, m, f in reproduced if g == "B" and m)
    n_bug_total = sum(1 for _, g, _, _ in reproduced if g == "B")
    n_fix_ok = sum(1 for _, g, _, f in reproduced if g == "A" and f)
    n_fix_total = sum(1 for _, g, _, f in reproduced if g == "A")
    if n_bug_total:
        print(f"\n[B] 진짜 버그 후보: {n_bug_ok}/{n_bug_total}건 여전히 재현됨.")
    if n_fix_total:
        print(f"[A] combiner 수정: {n_fix_ok}/{n_fix_total}건 정상 어셈블 확인.")


if __name__ == "__main__":
    main()

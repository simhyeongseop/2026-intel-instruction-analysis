"""
triage(7단계) + clang 비교(8~9단계) + 재어셈블 검증(10단계)이 찾아낸 "진짜 버그 8건"을
누구나 직접 눈으로 재현할 수 있게 만든 PoC(Proof of Concept) 스크립트.

이 파일은 파이프라인의 일부가 아니다 (pipeline/ 밑에 안 두는 이유).
CLAUDE.md 1절 "판정은 도구(as/objdump)가 한다" 원칙대로, 여기 적힌 asm 한 줄 한 줄을
실제로 GNU `as --64 -mintel64`/`objdump -d -M intel`에 넣어서 그 자리에서 결과를 보여준다.
LLM이 "이게 버그다"라고 주장하는 게 아니라, 실행 결과를 그대로 보여주는 것뿐이다.

실행 환경: WSL(Ubuntu) 등 Linux, GNU binutils(`as`/`objdump`) 필요. Windows에는 없음.

사용법:
    python3 tests/manual_bug_check.py              # 전체(8건 진짜 버그 + 6건 combiner 이력)
    python3 tests/manual_bug_check.py lar_r64_source   # id로 하나만

세 그룹으로 나뉜다:
  [B] GNU as 버그 5건 — SDM이 허용하는 문법을 as가 거부(파서/인코딩 문제).
      LAR/LSL/MOV Sreg/UDB/VPMOVQD. as 자체는 아직 안 고쳤고 지금도 재현된다.
  [C] objdump 버그 3건 — as는 SDM대로 정확히 인코딩하는데, objdump가 그 결과를
      잘못된 메모리 크기로 잘못 표시한다(LSS/LFS/LGS). "원본 어셈블 -> objdump로
      역어셈블 -> 그 텍스트를 다시 어셈블"까지 3단계로 보여준다 - 마지막 단계에서 as는
      원본과 objdump 텍스트를 각각 일관되게 처리할 뿐이며, "원래 성공했던 명령을
      objdump 텍스트로는 재현 못 한다"는 사실 자체가 objdump 표시가 틀렸다는 간접
      증거다.
  [A] 우리 파이프라인(combiner) 코드의 한계 6건 — 2026-07-24에 이미 고침(역사적 기록,
      "그때는 실패 -> 지금은 성공"을 비교해서 보여줌). CLAUDE.md 7절 "차이 ≠ 버그" 원칙의
      실제 사례.

2026-08-25 정정 이력: 원래 [B]에 CALL r/m32(N.E.)/JMP r/m32(N.S. — CALL과 표기가 다름,
isa_db.csv 확인) 2건이 더 있었으나, Clang 비교
(8~9단계) 중 ModRM 바이트를 직접 디코딩해보니 as가 실제로 만든 건 SDM이 금지한 근접
호출이 아니라 SDM이 허용하는 원거리(far) 호출이었음을 확인해 false_alarm으로 철회했다
(`docs/DEVLOG.md` 2026-08-25 항목, `out/clang_compare_evidence_raw.md` 참고). 대신 이
라운드에서 새로 확인한 LSS/LFS/LGS(objdump 버그) 3건이 [C]로 추가됐다.

각 케이스의 근거(combo_id, 원본 asm_line, 에러 메시지)는 out/asm_result.csv /
out/triage.csv / out/clang_compare.csv / out/reassemble_check.csv 에서 그대로
가져온 것이다.
"""

import subprocess
import sys
import tempfile
import os
import re

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

AS_CMD = ["as", "--64", "-mintel64"]
OBJDUMP_CMD = ["objdump", "-d", "-M", "intel"]

CASES = [
    # ------------------------------------------------------------------
    # [B] GNU as 버그 5건 — SDM이 허용하는 문법을 as가 거부.
    # ------------------------------------------------------------------
    {
        "id": "lar_r64_source",
        "group": "B",
        "combo_id": 1516,
        "claim": "SDM p.651 'LAR r32, r64/m16'가 r64 소스를 명시적으로 허용 "
                 "(주석1: 오퍼랜드 크기와 무관하게 소스 레지스터 하위 16비트만 사용). "
                 "as: r64는 거부하고 r16만 받음. clang은 받아줌(독립 어셈블러로 교차 확인, "
                 "8~9단계).",
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
                 "as: r32는 거부하고 r16만 받음. clang은 받아줌(교차 확인).",
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
                 "as: r/m64 메모리 폼을 거부하고(operand type mismatch) r/m16만 받음. "
                 "clang도 이 메모리 폼은 거부함(both_reject) — 메모리 형태 자체는 "
                 "교차 확인 안 됨, as 단독 관찰로 유지.",
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
]

OBJDUMP_CASES = [
    # ------------------------------------------------------------------
    # [C] objdump 버그 3건 — as의 인코딩은 SDM과 정확히 일치하지만, objdump가
    # 결과를 잘못된 메모리 크기로 표시한다(REX.W 유무를 반영 못 함).
    # 10단계(reassemble_check) + codex 교차검증으로 2026-08-25 확정.
    # ------------------------------------------------------------------
    {
        "id": "lss_farptr_size",
        "combo_id": 1527,
        "claim": "SDM p.658: 'REX.W + 0F B2 /r LSS r64, m16:64' Valid. m16:64는 "
                 "2+8=10바이트라 관례상 TBYTE PTR로 표시돼야 함. as는 REX.W를 정확히 "
                 "붙여 인코딩하지만, objdump는 REX.W 유무와 무관하게 항상 FWORD PTR "
                 "(6바이트, m16:32용 표기)로 보여준다.",
        "source_line": "lss rcx, tbyte ptr [eax]",
        "wrong_size_word": "fword",
        "right_size_word": "tbyte",
    },
    {
        "id": "lfs_farptr_size",
        "combo_id": 1532,
        "claim": "LSS와 동일 패턴, REX.W + 0F B4 /r LFS r64, m16:64.",
        "source_line": "lfs rcx, tbyte ptr [eax]",
        "wrong_size_word": "fword",
        "right_size_word": "tbyte",
    },
    {
        "id": "lgs_farptr_size",
        "combo_id": 1535,
        "claim": "LSS와 동일 패턴, REX.W + 0F B5 /r LGS r64, m16:64.",
        "source_line": "lgs rcx, tbyte ptr [eax]",
        "wrong_size_word": "fword",
        "right_size_word": "tbyte",
    },
]

RETRACTED_CASES = [
    # 2026-08-25 철회됨 — 재현 안 함, 기록용으로만 남김. 아래 run_retracted_note() 참고.
    {"id": "call_rm32_ne (철회됨)", "combo_id": 419, "mnemonic": "CALL"},
    {"id": "jmp_rm32_ne (철회됨)", "combo_id": 1436, "mnemonic": "JMP"},
]

# ------------------------------------------------------------------
# [A] 우리 combiner(pipeline/m3_combine.py) 코드의 한계 6건 — 2026-07-24 수정 완료.
# broken_line = 수정 전 combiner가 실제로 만들어냈던 조합 (역사적 기록용, 지금은 안 나옴).
# fixed_line = 수정 후 combiner가 실제로 만들어내는 조합 (data/db/combos.csv에서 그대로 가져옴).
# ------------------------------------------------------------------
COMBINER_CASES = [
    {
        "id": "combiner_farptr_collapse",
        "group": "A",
        "combo_id": 424,
        "claim": "combiner의 MEM_SIZE_RE 정규식(m3_combine.py)이 'm16:16'의 콜론 뒤를 "
                 "무시하고 앞부분 'm16'만 매치해서, far-ptr 메모리 오퍼랜드를 그냥 'word ptr'로 "
                 "잘못 축소해버림 (CALL m16:16/m16:32 6건 전부 영향).",
        "broken_line": "call word ptr [eax]",
        "broken_sdm_expect": "ok",
        "fixed_note": "data/db/combos.csv에서 combo_id 424를 지금 다시 조회한 값 — far-ptr 전용 "
                      "FAR_PTR_ATOM_RE 추가로 해결됐는지 매번 실측으로 확인한다.",
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
        "fixed_note": "data/db/combos.csv에서 combo_id 1689를 지금 다시 조회한 값 — 괄호를 붙이도록 "
                      "고쳐서 해결됐는지 매번 실측으로 확인한다.",
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
        "fixed_note": "data/db/combos.csv에서 combo_id 4541을 지금 다시 조회한 값 — 슬롯마다 순번을 "
                      "매기는 register_candidate(atom, occurrence)로 해결됐는지 매번 실측으로 확인한다.",
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
        "fixed_note": "data/db/combos.csv에서 combo_id 5798을 지금 다시 조회한 값 — VSIB_ATOM_RE로 "
                      "인덱스 레지스터를 붙이도록 해결됐는지 매번 실측으로 확인한다. (단, "
                      "VSCATTERDPD ymm/zmm 2건은 SDM 원문 자체의 비대칭 표기 때문에 여전히 실패 — "
                      "combiner 버그 아님, triage에 unsure로 별도 분류됨)",
    },
    {
        "id": "combiner_mpx_addr32_missing",
        "group": "A",
        "combo_id": 323,
        "claim": "combiner가 대표 주소 '[eax]'(32비트 addr32)를 그대로 쓰는데, MPX 명령어는 "
                 "64비트 모드에서 32비트 주소 자체를 거부함 (12건 전부 영향).",
        "broken_line": "bndcl bnd0, dword ptr [eax]",
        "broken_sdm_expect": "ok",
        "fixed_note": "data/db/combos.csv에서 combo_id 323을 지금 다시 조회한 값 — MPX_MNEMONICS일 때 "
                      "64비트 주소(rax)를 쓰도록 해결됐는지 매번 실측으로 확인한다.",
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
        "fixed_note": "data/db/combos.csv에서 combo_id 5802를 지금 다시 조회한 값 — {k1} 마스크를 "
                      "살리도록 해결됐는지(VSIB 인덱스 포함) 매번 실측으로 확인한다.",
    },
]


_TMP_DIRS = []  # 프로그램 종료 시 한꺼번에 지우려고 생성한 임시 디렉터리를 전부 기억해둔다.


def assemble(line):
    """asm 한 줄을 실제로 as에 넣어서 (성공여부, 에러메시지, 오브젝트경로) 반환.
    오브젝트 파일은 임시 디렉터리에 만들어서(같은 프로세스 안에서 objdump로 이어 쓸 수
    있게) 남겨두고, main()이 끝날 때 cleanup_tmp_dirs()로 한꺼번에 지운다."""
    d = tempfile.mkdtemp()
    _TMP_DIRS.append(d)
    src = os.path.join(d, "line.s")
    obj = os.path.join(d, "line.o")
    with open(src, "w", encoding="utf-8") as f:
        f.write(".intel_syntax noprefix\n")
        f.write(line + "\n")
    result = subprocess.run(AS_CMD + ["-o", obj, src], capture_output=True, text=True)
    ok = result.returncode == 0
    err = result.stderr.strip().replace("\n", " | ")
    return ok, err, (obj if ok else None)


def cleanup_tmp_dirs():
    import shutil
    for d in _TMP_DIRS:
        shutil.rmtree(d, ignore_errors=True)
    _TMP_DIRS.clear()


def bytes_of(obj_path):
    """objdump -d로 오브젝트 파일 하나의 hex 바이트를 이어붙여서 반환한다 (증거용)."""
    result = subprocess.run(OBJDUMP_CMD + [obj_path], capture_output=True, text=True)
    hex_bytes = ""
    for line in result.stdout.splitlines():
        m = re.match(r"^\s*[0-9a-f]+:\t([0-9a-f ]+)\t", line)
        if m:
            hex_bytes += m.group(1).replace(" ", "")
    return hex_bytes


def load_combo_operands(combo_id):
    """data/db/combos.csv에서 combo_id로 실제 현재 mnemonic/operands를 조회한다.
    [A] 그룹 fixed_line을 하드코딩 문자열이 아니라 파이프라인이 '지금' 실제로 만들어내는
    값으로 검증하기 위함 (codex 지적: 하드코딩 문자열은 combiner가 바뀌면 조용히 stale해짐)."""
    combos_path = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                                "data", "db", "combos.csv")
    with open(combos_path, encoding="utf-8") as f:
        for row in __import__("csv").DictReader(f):
            if row["combo_id"] == str(combo_id):
                return f"{row['mnemonic'].lower()} {row['operands']}"
    return None


def disassemble(obj_path):
    """objdump로 오브젝트 파일 하나를 역어셈블해서 마지막 명령어 텍스트를 반환."""
    result = subprocess.run(OBJDUMP_CMD + [obj_path], capture_output=True, text=True)
    line_text = None
    for line in result.stdout.splitlines():
        parts = line.split("\t")
        if len(parts) >= 3 and parts[2].strip():
            line_text = parts[2].strip()
    return line_text


def run_case(case):
    print(f"\n{'='*70}")
    print(f"[{case['group']}] {case['id']}  (combo_id={case['combo_id']})")
    print(f"근거: {case['claim']}")

    ok, err, _ = assemble(case["broken_line"])
    actual = "ok" if ok else "error"
    print(f"  실행: {case['broken_line']!r}")
    print(f"  as 결과: {actual}" + (f"  ({err})" if err else ""))

    expect = case["broken_sdm_expect"]
    if actual == expect:
        print(f"  -> SDM 기대({expect})와 일치. 재현 실패(더 이상 버그 아닐 수 있음) — 형섭 확인 필요.")
    else:
        print(f"  -> SDM 기대({expect})와 다름. 보고된 그대로 재현됨.")

    if case.get("control_line"):
        cok, cerr, _ = assemble(case["control_line"])
        cactual = "ok" if cok else "error"
        print(f"  대조군: {case['control_line']!r}")
        print(f"  as 결과: {cactual}" + (f"  ({cerr})" if cerr else ""))
        print(f"  대조군 의미: {case['control_note']}")

    fixed_ok = None
    if case.get("fixed_note"):
        fixed_line = load_combo_operands(case["combo_id"])
        if fixed_line is None:
            print(f"  경고: data/db/combos.csv에서 combo_id={case['combo_id']}를 못 찾음 — 형섭 확인 필요.")
        else:
            fok, ferr, _ = assemble(fixed_line)
            fixed_ok = fok
            factual = "ok" if fok else "error"
            print(f"  수정 후(combos.csv에서 방금 실시간 조회): {fixed_line!r}")
            print(f"  as 결과: {factual}" + (f"  ({ferr})" if ferr else ""))
            print(f"  {case['fixed_note']}")
            if factual != "ok":
                print("  경고: 수정 후에도 여전히 실패함 — 형섭 확인 필요.")

    return actual != expect, fixed_ok


def run_objdump_case(case):
    """[C] objdump 버그: 원본 어셈블 -> objdump 역어셈블 -> 그 텍스트 재어셈블, 3단계로 보여준다."""
    print(f"\n{'='*70}")
    print(f"[C] {case['id']}  (combo_id={case['combo_id']})")
    print(f"근거: {case['claim']}")

    ok, err, obj_path = assemble(case["source_line"])
    print(f"  1) 원본 어셈블: {case['source_line']!r}")
    print(f"     as 결과: {'ok' if ok else 'error'}" + (f"  ({err})" if err else ""))
    if not ok:
        print("  경고: 원본 어셈블부터 실패함 — 재현 안 됨, 형섭 확인 필요.")
        return False
    hex_bytes = bytes_of(obj_path)
    print(f"     실제 인코딩 바이트: {hex_bytes!r} (REX.W가 정확히 붙었는지 직접 눈으로 "
          "확인 가능 — REX.W 바이트는 0x48을 포함하는 접두어)")

    disasm_text = disassemble(obj_path)
    print(f"  2) objdump 역어셈블 결과: {disasm_text!r}")
    has_wrong = bool(disasm_text and re.search(rf"\b{case['wrong_size_word']}\b", disasm_text, re.IGNORECASE))
    has_right = bool(disasm_text and re.search(rf"\b{case['right_size_word']}\b", disasm_text, re.IGNORECASE))
    if has_wrong:
        print(f"     -> objdump가 '{case['wrong_size_word']} ptr'로 표시함(SDM 기준 정답은 "
              f"'{case['right_size_word']} ptr' {10 if case['right_size_word']=='tbyte' else '?'}바이트). "
              "표시 결함 재현됨.")
    elif has_right:
        print(f"     -> objdump가 '{case['right_size_word']} ptr'로 정확히 표시함. "
              "재현 안 됨(objdump 버전이 수정됐을 수 있음) — 형섭 확인 필요.")
    else:
        print("     -> 예상한 크기 단어를 못 찾음 — 형섭 확인 필요.")

    reasm_ok, reasm_err, _ = assemble(disasm_text) if disasm_text else (False, "역어셈블 텍스트 없음", None)
    print(f"  3) objdump 텍스트를 그대로 재어셈블: {disasm_text!r}")
    print(f"     as 결과: {'ok' if reasm_ok else 'error'}" + (f"  ({reasm_err})" if reasm_err else ""))
    if not reasm_ok:
        print("     -> as는 원본(rcx+tbyte)과 objdump 텍스트(rcx+fword)를 각각 일관되게 "
              "처리한 것뿐이지만, 원래 성공했던 명령을 objdump가 보여준 텍스트로는 재현 못 "
              "한다는 사실 자체가 objdump의 크기 표시가 틀렸다는 간접 증거다. 보고된 그대로 재현됨.")
    else:
        print("     -> 재어셈블도 성공함 — 재현 안 됨, 형섭 확인 필요.")

    return has_wrong and not reasm_ok


def show_retracted_note():
    print(f"\n{'='*70}")
    print("철회된 항목 (재현 대상 아님, 기록용)")
    for item in RETRACTED_CASES:
        print(f"  - {item['id']}  (combo_id={item['combo_id']}, {item['mnemonic']})")
    print("  2026-08-25: Clang 비교(8~9단계) 중 ModRM 바이트를 직접 디코딩해보니, as가 만든 "
          "건 SDM이 금지한 근접(near) 호출이 아니라 SDM이 허용하는 원거리(far) 호출이었음을 "
          "확인해 false_alarm으로 철회함. 상세: docs/DEVLOG.md, out/clang_compare_evidence_raw.md")


def show_code_evidence():
    """asm 재현과 별개로, combiner 코드 자체가 실제로 이렇게 동작하는지 직접 보여준다."""
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

    b_cases = [c for c in CASES if only_id is None or c["id"] == only_id]
    c_cases = [c for c in OBJDUMP_CASES if only_id is None or c["id"] == only_id]
    a_cases = [c for c in COMBINER_CASES if only_id is None or c["id"] == only_id]

    if only_id and not (b_cases or c_cases or a_cases):
        all_ids = [c["id"] for c in CASES + OBJDUMP_CASES + COMBINER_CASES]
        print(f"알 수 없는 id: {only_id}")
        print("사용 가능한 id: " + ", ".join(all_ids))
        sys.exit(1)

    if only_id is None:
        show_retracted_note()
        show_code_evidence()

    reproduced = []
    for case in b_cases:
        matched, fixed_ok = run_case(case)
        reproduced.append((case["id"], "B", matched, fixed_ok))
    for case in c_cases:
        matched = run_objdump_case(case)
        reproduced.append((case["id"], "C", matched, None))
    for case in a_cases:
        matched, fixed_ok = run_case(case)
        reproduced.append((case["id"], "A", matched, fixed_ok))

    print(f"\n{'='*70}")
    print("요약")
    for cid, group, matched, fixed_ok in reproduced:
        if group == "A":
            mark = "수정 확인됨(fixed_line 성공)" if fixed_ok else "여전히 실패(확인 필요)"
        else:
            mark = "재현됨(진짜 버그로 남아있음)" if matched else "재현 안 됨(확인 필요)"
        print(f"  [{group}] {cid}: {mark}")

    n_bug_ok = sum(1 for _, g, m, f in reproduced if g in ("B", "C") and m)
    n_bug_total = sum(1 for _, g, _, _ in reproduced if g in ("B", "C"))
    n_fix_ok = sum(1 for _, g, _, f in reproduced if g == "A" and f)
    n_fix_total = sum(1 for _, g, _, f in reproduced if g == "A")
    if n_bug_total:
        print(f"\n[B+C] 진짜 버그: {n_bug_ok}/{n_bug_total}건 재현됨.")
    if n_fix_total:
        print(f"[A] combiner 수정: {n_fix_ok}/{n_fix_total}건 정상 어셈블 확인.")

    cleanup_tmp_dirs()


if __name__ == "__main__":
    main()

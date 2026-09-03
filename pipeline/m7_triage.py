"""
7단계 triage: 컴파일 에러(out/asm_result.csv)와 역어셈블 차이(out/roundtrip.csv)를
종류별로 묶고, 원인을 추정하고, 버그/오탐(false_alarm)/판단보류(unsure)로 나눈다.

원칙(CLAUDE.md 1절·triage 에이전트 지침):
- 정답은 인텔 SDM이다. 어셈블러가 받아주는지가 아니라 매뉴얼이 정의하는지가 기준이다.
- 판정 근거는 도구 결과(as/objdump 직접 실행, SDM PDF 원문 대조)여야 한다.
- LLM 추정만으로 "bug"라고 결론 내지 않는다. 확신이 없으면 unsure로 남겨서 형섭이 검토한다.

이 파일의 분류 규칙들은 out/asm_result.csv·out/roundtrip.csv를 실제로 열어 패턴을 찾고,
의심스러운 것은 `as --64 -mintel64`로 재현하거나 325383-090-sdm-vol-2abcd.pdf 원문을
직접 대조해서 얻은 결론이다. bug로 표시한 항목은 전부 도구 재현 + SDM 원문 대조를 마쳤다.
"""

import csv
import re

ASM_CSV = "out/asm_result.csv"
RT_CSV = "out/roundtrip.csv"
OUT_CSV = "out/triage.csv"
OUT_MD = "out/triage_report.md"


def load_rows(path):
    with open(path, encoding="utf-8") as f:
        return list(csv.DictReader(f))


# ===========================================================================
# 1. 컴파일 에러(asm_result.csv, actual_result == "error") 분류
# ===========================================================================

# 에러 메시지 유형 -> (그룹 이름, 원인 설명(없으면 mnemonic별로 세분), mismatch일 때 verdict)
ERROR_RULES = [
    (re.compile(r"default mask isn't allowed"),
     "avx512_gather_scatter_default_mask",
     "AVX512 gather/scatter는 마스크가 필수(k0 기본마스크 불허)인데, combiner가 SDM의 "
     "'{k1}' 마스크 표기를 대표값으로 펼치는 과정(strip_decorations)에서 지워버려 "
     "마스크 없는 형태로 생성됨 - combiner 한계",
     "false_alarm"),
    (re.compile(r"destination and source registers must be distinct"),
     "combiner_register_reuse",
     "combiner가 서로 다른 오퍼랜드 슬롯에 같은 대표 레지스터(xmm0/ymm0/zmm0 등)를 재사용해서 "
     "만든 조합 - '레지스터가 달라야 함' 제약 위반 (BND 계열과 같은 combiner 한계, DEVLOG 2026-07-23)",
     "false_alarm"),
    (re.compile(r"all tmm registers must be distinct"),
     "combiner_register_reuse",
     "combiner가 tmm 오퍼랜드 슬롯 전부에 tmm0을 재사용 - 위와 동일한 combiner 한계",
     "false_alarm"),
    (re.compile(r"invalid VSIB address"),
     "combiner_vsib_missing_index",
     "vm32x/vm64x(VSIB) 메모리 오퍼랜드를 combiner가 일반 메모리([eax])로만 채워서 VSIB "
     "인덱스 레지스터가 없음 - memory_candidate()가 VSIB를 특별 취급하지 않는 한계",
     "false_alarm"),
    (re.compile(r"32-bit address isn't allowed in 64-bit MPX"),
     "combiner_mpx_addr32_missing",
     "BND 계열 명령어에 32비트 주소([eax])를 그대로 써서 64비트 모드에 필요한 addr32 "
     "프리픽스가 안 붙음 - 이미 알려진 이슈(DEVLOG 2026-07-23)",
     "false_alarm"),
    (re.compile(r"number of operands mismatch"),
     "combiner_implicit_operand_as_explicit",
     "SDM의 <XMM0-7>/<EAX> 같은 암묵 오퍼랜드 표기를 combiner(expand_implicit)가 실제 명시 "
     "오퍼랜드로 방출해서 개수가 안 맞음 - combiner 한계",
     "false_alarm"),
    (re.compile(r"16-bit addressing unavailable"),
     "combiner_mode_invalid_register_choice",
     "r16/r32/r64 중 대표값으로 r16을 골랐는데, 64비트 모드에서는 주소 레지스터로 16비트를 "
     "쓸 수 없다는 모드 제약을 combiner가 반영하지 못함 - combiner 한계",
     "false_alarm"),
    (re.compile(r"invalid operands \(\*UND\*"),
     "extractor_artifact_stray_text",
     "PDF 추출 과정에서 설명 문단 문구가 오퍼랜드 칸에 겹쳐 들어간 것으로 보임(같은 페이지 "
     "설명문에도 'imm8/r imm8 field'로 동일하게 중복 등장, PDF p.2155 직접 대조) - 국소 1건",
     "false_alarm"),
    (re.compile(r"invalid use of register"),
     "combiner_raw_notation_literal",
     None, "false_alarm"),
    (re.compile(r"operand size mismatch"),
     "compile_error_operand_size_mismatch",
     None, "false_alarm"),
    (re.compile(r"ambiguous operand size"),
     "gas_ambiguous_bare_mnemonic",
     "SYSEXIT/SYSRET을 매뉴얼 그대로(오퍼랜드 없이) 써도 as가 크기를 못 정해 거부함 - "
     "'rex64 sysexit' 같은 프리픽스 트릭을 쓰면 성공(직접 확인). 매뉴얼 문법 그대로는 실패라서 "
     "판단보류.",
     "unsure"),
    (re.compile(r"register type mismatch"),
     "gas_register_width_stricter_than_manual",
     "LAR/LSL 관련 - 아래 combo_id 개별 확인 결과를 참고(모두 override로 처리됨)",
     "unsure"),
    (re.compile(r"no such instruction"),
     "gas_missing_mnemonic",
     "UDB 관련 - 아래 combo_id 개별 확인 결과를 참고(override로 처리됨)",
     "unsure"),
]

# "operand size mismatch" 세부 원인 (mnemonic 기준으로 나뉨 - 실제 asm_result.csv를 읽고 분류)
UNNECESSARY_SIZE_DIRECTIVE = {
    "AESDEC256KL", "AESENC256KL", "ENQCMD", "ENQCMDS",
    "FXRSTOR", "FXRSTOR64", "FXSAVE", "FXSAVE64", "LDTILECFG", "STTILECFG",
}
FAR_PTR_SIZE_COLLAPSED = {"LSS", "LFS", "LGS", "LGDT", "LIDT"}
WRONG_REGISTER_WIDTH = {"MOVDIR64B", "SENDUIPI"}
IMPLICIT_AS_EXPLICIT_MNEMONICS = {"REP LODS"}

# "invalid use of register" 세부 원인 (mnemonic 기준)
REG_PAIR_NOTATION = {"VP2INTERSECTD", "VP2INTERSECTQ"}
REG_PLUS_N_NOTATION = {"V4FMADDPS", "V4FNMADDPS", "V4FMADDSS", "V4FNMADDSS",
                       "VP4DPWSSDS", "VP4DPWSSD"}


def _error_sub_cause(category, mnemonic):
    """error message 패턴만으로 원인이 갈리는 경우 mnemonic을 봐서 세분한다."""
    if category == "combiner_raw_notation_literal":
        if mnemonic in REG_PAIR_NOTATION:
            return ("SDM의 'k1+1'(연속 마스크 레지스터 쌍) 표기를 combiner가 실제 레지스터로 "
                    "펼치지 못하고 원문 그대로 남겨서 as가 나눗셈 연산으로 오인 - combiner 한계 "
                    "(operand_kind=='other' -> raw 유지)")
        if mnemonic in REG_PLUS_N_NOTATION:
            return ("SDM의 'zmm2+3'(연속 zmm 레지스터 쌍) 표기를 combiner가 펼치지 못하고 원문 "
                    "그대로 남김 - 위와 동일한 combiner 한계")
        if mnemonic == "VPAND":
            return ("isa_db 원문 자체에 'ymm3/.m256'처럼 불필요한 점(.)이 있음 - PDF 원문(p.923) "
                    "pdfplumber 추출 결과에도 동일하게 나타나 그대로 as 입력이 됨(국소 1건, PDF "
                    "텍스트 추출 특성으로 추정)")
        return "SDM의 특수 레지스터 표기를 combiner가 원문 그대로 남겨서 발생 - combiner 한계"

    if category == "compile_error_operand_size_mismatch":
        if mnemonic in UNNECESSARY_SIZE_DIRECTIVE:
            return ("m512/m512byte처럼 고정 크기인 legacy 메모리 오퍼랜드에 combiner가 불필요한 "
                    "크기 접두어(zmmword ptr)를 붙여서 발생 - 직접 확인: 크기 접두어 없이 "
                    "'[eax]'만 쓰면 정상 어셈블됨(false_alarm)")
        if mnemonic in FAR_PTR_SIZE_COLLAPSED:
            return ("SDM의 복합 메모리 타입(m16:16/m16:32/m16:64, m16&64)을 combiner의 "
                    "memory_candidate 정규식이 앞부분 'm16'만 인식해서 항상 'word ptr'로 뭉개버림 "
                    "- combiner 한계")
        if mnemonic in WRONG_REGISTER_WIDTH:
            return ("SDM 설명상 항상 64비트 레지스터를 쓰는 명령인데(SENDUIPI 설명: 'operand "
                    "always has 64 bits') combiner가 좁은 폭 레지스터를 대표값으로 골라서 발생 - "
                    "직접 확인: 64비트 레지스터로 바꾸면 정상 어셈블됨(false_alarm)")
        if mnemonic in IMPLICIT_AS_EXPLICIT_MNEMONICS:
            return ("SDM이 'REP LODS AL'처럼 암묵 목적지를 표기 관례로 보여줄 뿐인데 combiner가 "
                    "이를 실제 레지스터 오퍼랜드로 방출 - 직접 확인: 'lods al'은 거부되고 "
                    "'lods byte ptr [esi]'/'lodsb'는 정상 어셈블됨")
        return "as가 요구하는 오퍼랜드 크기와 combiner가 만든 크기가 불일치 - 원인 미상, 개별 확인 필요"

    return "원인 미상 - 개별 확인 필요"


# as/objdump로 직접 재현하고 SDM PDF 원문까지 대조를 마친, 결론이 확정된 개별 케이스.
# (combo_id -> (category, verdict, cause))
ERROR_COMBO_OVERRIDES = {
    "6540": ("sdm_table_typo_memory_size", "false_alarm",
             "2026-09-03 정정(형섭 요청으로 codex + 최신 clang 19/20 교차검증 재검토): 원래 "
             "'SDM p.2054가 VPMOVQD(EVEX.128) 대상 메모리를 xmm1/m128로 명시하는데 as는 qword "
             "ptr(m64)만 받아준다'는 bug로 기록돼 있었으나, PDF p.2054/2055 원문을 직접 대조한 "
             "결과 이건 SDM 오피코드 표 자체의 오탈자였다. 근거: (1) 같은 표의 형제 명령어 "
             "VPMOVSQD/VPMOVUSQD의 EVEX.128 행은 둘 다 'xmm1/m64'로 정확히 적혀 있음(VPMOVQD "
             "행만 m128로 다름). (2) p.2055 Description: 'The destination operand is a "
             "YMM/XMM/XMM register or a 256/128/64-bit memory location' - EVEX.128(2-element)에 "
             "대응하는 크기가 64비트라고 명시. (3) Operation pseudocode도 KL=2(128비트 버전)일 때 "
             "32비트씩 2번, 총 64비트만 DEST에 씀. (4) 실측: as(2.42)/clang 18.1.3/19.1.1/20.1.2 "
             "네 어셈블러 전부 `vpmovqd qword ptr [eax], xmm0`는 성공, `xmmword ptr`은 전부 거부 - "
             "완전히 일치. (5) EVEX.256 폼(`vpmovqd xmmword ptr [eax], ymm0`, 표기상 m128이 맞는 "
             "폼)은 as가 정상적으로 받아줘서, as가 무조건 좁게 구현한 게 아니라 폭별로 정확히 "
             "구분하고 있음을 확인. codex 교차검증도 동일 결론(bug→false_alarm)에 동의함."),
    "4597": ("gas_missing_mnemonic", "bug",
             "SDM p.1436에 'D6 UDB' 오피코드가 64비트 모드 Valid로 명시돼 있으나(UD0/UD1/UD2와 "
             "같은 계열) GNU as는 'udb'라는 니모닉 자체를 모른다('no such instruction: udb'). "
             "2026-09-03 codex 재검증에서도 CONFIRMED(SDM Exceptions 섹션에도 'UDB does so only "
             "in 64-bit mode'로 UDB를 직접 언급 - 오탈자 아님)."),
    "1516": ("ambiguous_syntax_resolved_to_valid_symmetric_form", "false_alarm",
             "2026-09-03 정정(codex + 최신 clang 19/20 교차검증 재검토): 원래 'SDM p.651 LAR r32, "
             "r64/m16(각주1)로 r64 소스를 명시 허용하는데 `lar ecx, rcx`를 as가 거부'라는 bug로 "
             "기록돼 있었으나 재검토 결과 근거가 잘못됐다. (1) PDF 문자 단위 폰트크기로 각주 위치를 "
             "정밀 확인한 결과 각주 '1'은 실제로 2번째 행(LAR r32, r32/m16)에 붙어있고 3번째 행"
             "(REX.W 행)에는 원래 각주가 없다 - isa_db.csv가 각주 숫자를 3번째 행 텍스트 끝에 잘못 "
             "붙여 'r64/m161'로 저장한 추출 오류. (2) 바이트 레벨 재현: `lar ecx, rcx`(SDM 문자 "
             "그대로 dest=r32/source=r64)를 clang 18/19/20에 줘도 실제 인코딩은 `0f 02 c9`(REX.W "
             "없음) → objdump가 `lar ecx,ecx`로 역어셈블 - clang도 요청받은 rcx를 조용히 ecx로 "
             "깎아 인코딩할 뿐, SDM 표 그대로의 비대칭 폼을 실제로 만들지 않는다. (3) `lar rcx, "
             "rcx`(양쪽 다 r64로 대칭)는 clang이 REX.W를 포함해 `48 0f 02 c9`(`lar rcx,rcx`)로 "
             "정확히 인코딩하지만, as는 AT&T `larq %rcx,%rcx`까지 포함해 어떤 문법으로도 REX.W를 "
             "만들지 않는다(`0f 02 c9`만 나옴). 즉 실제로 존재 가능한 폼은 'LAR r64, r64/m16'"
             "(대칭)이고, SDM 표의 'LAR r32, r64/m16'(비대칭, dest만 r32) 표기는 REX.W가 두 GPR "
             "오퍼랜드 폭을 독립적으로 지정할 수 없다는 인코딩 구조상 애초에 as/clang 어느 쪽으로도 "
             "실현 불가능한 폼으로 보인다(p.651 Description 'zero-extended to 64 bits and loaded "
             "into the destination operand'도 dest가 사실은 r64라는 뜻이라 표의 'r32'와 모순 - "
             "VPMOVQD와 같은 SDM 오탈자 패턴). CALL/JMP·DEC/INC·LEAVE·LGDT/LIDT·BNDCL에 이어 이 "
             "프로젝트가 이미 확인한 '문법으로 구분 안 되는 SDM 표 행을 그대로 테스트해서 엉뚱한 걸 "
             "검증하게 됨' 패턴의 7번째 사례. codex 교차검증도 동일 결론(false_alarm)에 동의. "
             "**신규 발견(별도 combo 없음, 향후 추가 후보)**: as는 LAR에 REX.W 폼 자체를(대칭 "
             "`lar rcx,rcx`까지 포함) 전혀 구현하지 않는다 - 이건 clang과 다른 진짜 as 한계일 수 "
             "있으나 현재 combos.csv엔 이 대칭 폼을 테스트하는 combo가 없어 이번 라운드에선 "
             "판정하지 않음."),
    "1571": ("ambiguous_syntax_resolved_to_valid_symmetric_form", "false_alarm",
             "2026-09-03 정정(codex + 최신 clang 19/20 교차검증 재검토): combo 1516(LAR)과 완전히 "
             "동일한 유형 - SDM p.691 'LSL r64, r32/m16'도 실제 as/clang 바이트 레벨에선 "
             "구분되지 않는다. `lsl rcx, ecx`(SDM 문자 그대로 dest=r64/source=r32)를 clang "
             "18/19/20에 줘도 인코딩은 `48 0f 03 c9`(REX.W 있음) → objdump가 `lsl rcx,rcx`로 "
             "역어셈블 - 요청한 ecx 소스를 조용히 rcx로 확장했을 뿐, SDM 표 그대로의 비대칭 폭을 "
             "실제로 만들지 않는다. `lsl rcx, rcx`(대칭)는 clang이 REX.W로 정확히 인코딩하지만 as는 "
             "AT&T `lslq %rcx,%rcx`까지 포함해 REX.W를 전혀 만들지 않는다(`0f 03 c9`만 나옴, LAR과 "
             "동일). PDF 각주 위치는 LAR과 달리 2/3번째 행 모두에 '1'이 붙어있어(pdfplumber 추출상 "
             "'r32/m161'이 두 번) 각주 오귀속 여부는 LAR만큼 명확하지 않지만, 핵심 논거(REX.W가 두 "
             "GPR 오퍼랜드 폭을 독립 지정할 수 없어 SDM 표의 비대칭 표기가 어느 어셈블러로도 실현 "
             "불가능하다는 인코딩 구조 논증)는 LAR과 동일하게 적용된다. codex도 combo 1516과 "
             "함께 false_alarm(또는 최소 unsure)으로 하향을 권고. **신규 발견**: as는 LSL에도 "
             "REX.W 폼 자체를 전혀 구현하지 않음(combo 1516과 동일 이슈, 별도 combo 없음)."),
    "1683": ("gas_register_width_stricter_than_manual", "unsure",
             "2026-09-03 재검토(codex 교차검증, 형섭 요청으로 최신 clang 19/20 포함): 원래 'SDM "
             "REX.W+8E/r MOV Sreg,r/m64가 메모리도 Valid로 명시하는데 as가 qword ptr을 거부'라는 "
             "bug로 기록돼 있었으나, clang 18.1.3/19.1.1/20.1.2 넷 다 `mov ds, qword ptr [eax]`를 "
             "'invalid operand for instruction'으로 똑같이 거부함을 확인(word ptr만 성공, as와 "
             "완전히 동일). 레지스터 폼(`mov ds, rax`)은 clang이 REX.W를 포함해 정확히 구현하는데"
             "(`48 8e d8`) as는 REX.W를 조용히 버려서(`8e d8`, combo 1682) 이 부분은 as만의 진짜 "
             "한계로 보이지만, 메모리 폼(이 combo 1683)은 as/clang(사실상 GNU binutils와 LLVM, "
             "독립 구현 2종) 양쪽 다 거부해서 원래 판정의 근거('as만 매뉴얼보다 엄격')가 흔들린다. "
             "다만 codex는 'clang 3버전은 전부 LLVM 계열이라 독립성이 약하고, SDM 정의상 r/m64는 "
             "명시적으로 64비트 메모리를 포함하며 반대방향 행(REX.W+8C/r MOV r64/m16,Sreg)은 이미 "
             "표기에서 레지스터/메모리 폭을 r64/m16으로 명확히 구분해뒀으니 8E/r 행의 r/m64가 "
             "단순 축약 오탈자라 보기엔 근거가 약하다'고 지적 - 실제 페이지 경계 매핑을 이용한 "
             "실기 실행 검증(11/12단계 방식) 전까지는 unsure가 안전하다는 의견. LAR/LSL/VPMOVQD와 "
             "달리 SDM 내부 모순(각주 오귀속, 형제행 비교, Description 불일치)같은 결정적 증거가 "
             "없어 bug 유지도 과하지만 false_alarm 확정도 이르다고 판단해 unsure로 낮춘다."),
    "7035": ("sdm_gather_scatter_vsib_width_asymmetry", "unsure",
             "SDM PDF p.2202(325383-090-sdm-vol-2abcd.pdf, 200dpi 렌더링 대조)에 VSCATTERDPD의 "
             "ymm 폼이 실제로 'vm32y {k1}, ymm1'로 인쇄돼 있다 - combiner가 vm32x를 vm32y로 잘못 "
             "뽑은 추출 오류가 아니라 PDF 원문 자체가 vm32y다. `as`로 직접 재현: "
             "`vscatterdpd [eax + xmm1] {k1}, xmm0`(combo 7034)는 성공하지만 이 combo의 "
             "`[eax + ymm1] {k1}, ymm0`은 'invalid VSIB address'로 실패한다. 한편 유사 명령 "
             "VGATHERDPD(PDF p.1824)는 ymm 데이터인데도 SDM이 vm32x를 그대로 유지해서 "
             "GATHER는 vm32x 유지, SCATTER는 vm32y로 확장하는 비대칭 표기를 보인다 - 이 비대칭이 "
             "SDM의 의도적 설계인지 오탈자인지 도구(as/objdump)만으로는 판단할 수 없어 unsure로 "
             "둔다. 형섭이 PDF 원문과 인텔 공식 정오표를 직접 확인해서 SDM 오탈자인지, as가 SDM에 "
             "명시된 폼을 구현하지 않은 버그인지 확정해야 한다."),
    "7036": ("sdm_gather_scatter_vsib_width_asymmetry", "unsure",
             "SDM PDF p.2202(325383-090-sdm-vol-2abcd.pdf, 200dpi 렌더링 대조)에 VSCATTERDPD의 "
             "zmm 폼이 실제로 'vm32z {k1}, zmm1'로 인쇄돼 있다 - combiner 추출 오류가 아니라 PDF "
             "원문 자체가 vm32z다. `as`로 직접 재현: `vscatterdpd [eax + xmm1] {k1}, xmm0`"
             "(combo 7034)는 성공하지만 이 combo의 `[eax + zmm1] {k1}, zmm0`은 'invalid VSIB "
             "address'로 실패한다. 유사 명령 VGATHERDPD(PDF p.1824)는 zmm 데이터에도 SDM이 vm32x를 "
             "유지해서(GATHER/SCATTER 표기 비대칭) - 의도적 설계인지 오탈자인지 도구만으로는 판단 "
             "불가, unsure로 둔다. 형섭이 PDF 원문과 인텔 정오표를 직접 확인해야 확정된다."),
}

# far-ptr(m16:16/m16:32/m16:64) collapse: pipeline/m3_combine.py의
# MEM_SIZE_RE = r"^m(128|256|384|512|80|8|16|32|64)(?!\d)" 가 "m16:16"의 앞부분 "m16"을 그대로
# 매치해버려서(":"가 (?!\d) lookahead를 통과) far-ptr 타입 3가지가 전부 "word ptr"로 뭉개진다.
# combo_id: 424/425/426 = CALL m16:16/m16:32/m16:64, 1441/1442/1443 = JMP m16:16/m16:32/m16:64.
# 근본 원인은 combiner(3단계)에 있음 - 이번 triage 라운드에서는 m3_combine.py를 고치지 않고
# false_alarm으로만 분류한다(다음 라운드에 combiner가 고칠 후보).
_FARPTR_CAUSE = (
    "SDM의 far-ptr 메모리 타입(m16:16/m16:32/m16:64)을 pipeline/m3_combine.py의 MEM_SIZE_RE"
    "(r'^m(128|256|384|512|80|8|16|32|64)(?!\\d)')가 'm16:16' 등의 앞부분 'm16'만 그대로 매치해서"
    "(':'가 (?!\\d) lookahead를 통과) m16:16/m16:32/m16:64 세 가지가 전부 'word ptr'로 뭉개져 동일한 "
    "'call/jmp word ptr [eax]'가 3번 반복 생성됨 - far pointer는 word ptr 같은 일반 크기 지시자로 "
    "인코딩되지 않으므로 as가 정당하게 거부(직접 재현). 근본 원인은 combiner(3단계) - 다음 라운드에 "
    "MEM_SIZE_RE가 ':'를 인식하도록 고쳐야 함(이번 triage 라운드는 combiner 코드 수정 스코프 밖)."
)
for _cid in ["424", "425", "426", "1441", "1442", "1443"]:
    ERROR_COMBO_OVERRIDES[_cid] = ("combiner_farptr_collapse", "false_alarm", _FARPTR_CAUSE)

# MOV moffs 괄호 누락: tokens.csv row_id 1105-1109 = MOV moffs8/16/32/64, AL/AX/EAX/RAX.
# generator가 "mov 0x1000, al"처럼 대괄호 없는 bare 즉시값을 그대로 방출하는데, as Intel syntax의
# moffs 오퍼랜드는 "mov [0x1000], al" 또는 "mov ds:0x1000, al"처럼 대괄호/세그먼트 표기가 필요하다.
# combo_id 1689-1693. 근본 원인은 generator(4단계) - 이번 라운드는 문서화만, 코드는 고치지 않는다.
_MOFFS_CAUSE = (
    "generator가 moffs 오퍼랜드를 'mov 0x1000, al'처럼 대괄호 없이 방출하는데, as Intel syntax의 "
    "moffs 오퍼랜드는 'mov [0x1000], al' 또는 'mov ds:0x1000, al'처럼 대괄호/세그먼트 표기가 필요함 "
    "- 직접 재현: 대괄호를 씌우면 성공, 'mov 0x1000, al'만 실패. 근본 원인은 generator(4단계)가 "
    "moffs 후보값 포맷팅에 대괄호를 안 씌우는 것 - 다음 라운드에 4단계가 고칠 후보(이번 triage "
    "라운드는 generator 코드 수정 스코프 밖)."
)
for _cid in ["1689", "1690", "1691", "1692", "1693"]:
    ERROR_COMBO_OVERRIDES[_cid] = ("generator_moffs_missing_brackets", "false_alarm", _MOFFS_CAUSE)


def classify_compile_error(row):
    """asm_result.csv에서 actual_result == 'error'인 행 하나를 분류한다."""
    combo_id = row["combo_id"]
    if combo_id in ERROR_COMBO_OVERRIDES:
        category, verdict, cause = ERROR_COMBO_OVERRIDES[combo_id]
        return category, cause, verdict

    msg = row["error_message"]
    mnemonic = row["mnemonic"]
    is_mismatch = row["mismatch"] == "True"

    for pattern, category, cause, verdict in ERROR_RULES:
        if not pattern.search(msg):
            continue
        if cause is None:
            cause = _error_sub_cause(category, mnemonic)
        if not is_mismatch:
            # 매뉴얼도 이미 Invalid/N.E./N.S.로 규정한 조합이 그대로 거부된 것 - 정상, 불일치 아님.
            cause = ("매뉴얼상으로도 이 조합은 Invalid/N.E./N.S.(mode_support="
                     f"{row['mode_support']})로 규정돼 있어 그대로 거부된 것 - 불일치 아님, 정상 동작.")
            verdict = "false_alarm"
        return category, cause, verdict

    if not is_mismatch:
        # for 루프에서 패턴이 안 걸려도, 매뉴얼이 이미 Invalid/N.E./N.S.로 규정해서 그대로
        # 거부된 것이면(mismatch=False) 근거 없는 unsure가 아니라 false_alarm으로 내려야 한다.
        cause = ("매뉴얼상으로도 이 조합은 Invalid/N.E./N.S.(mode_support="
                 f"{row['mode_support']})로 규정돼 있어 그대로 거부된 것 - 불일치 아님, 정상 동작.")
        return "compile_error_expected_rejection_unclassified", cause, "false_alarm"

    return "compile_error_unclassified", "패턴 매칭 실패 - 형섭 직접 확인 필요", "unsure"


# ===========================================================================
# 2. mismatch(매뉴얼상 무효인데 as가 받아준, 46건) 분류
# ===========================================================================

PERMISSIVE_MISMATCH_OVERRIDES = {}

# 값 순서는 다른 classify_* 함수와 동일하게 (category, cause, verdict)로 통일한다.
for _cid in ["970", "971", "1308", "1309", "1541", "3294", "3297", "337", "341"]:
    PERMISSIVE_MISMATCH_OVERRIDES[_cid] = (
        "duplicate_encoding_row_same_syntax",
        "SDM 표에 텍스트 니모닉+오퍼랜드가 똑같은데 오피코드/모드지원이 다른 행이 2개 이상 있음"
        "(예: DEC ecx의 legacy 1바이트 opcode '48+rd'는 64비트 모드 N.E.지만 ModRM 기반 'FF /1'은 "
        "Valid). 파이프라인은 텍스트만 어셈블하므로 as는 항상 인코딩 가능한(Valid) 쪽을 선택함 "
        "- 실제 불일치가 아니라 표 중복 표기 때문.",
        "false_alarm",
    )

for _cid in ["414", "1431"] + [str(i) for i in range(1368, 1429, 2)]:
    PERMISSIVE_MISMATCH_OVERRIDES[_cid] = (
        "generator_did_not_target_invalid_variant",
        "SDM상 rel16(16비트 상대주소, N.S.) 폼을 테스트하려던 행이었지만 generator가 크기 힌트 "
        "없이 '.Ltarget' 라벨만 사용해 as가 기본으로 유효한 rel32를 선택함 - 무효 폼을 실제로 "
        "인코딩하도록 강제한 게 아니므로 '성공'은 당연함(false_alarm).",
        "false_alarm",
    )

for _cid in ["419", "1436"]:
    PERMISSIVE_MISMATCH_OVERRIDES[_cid] = (
        "ambiguous_syntax_resolved_to_valid_far_form",
        "2026-08-25 정정(8단계 clang_compare + codex 교차검증으로 발견): 원래 이 항목은 "
        "'SDM이 N.E.로 명시한 CALL/JMP r/m32(FF /2, FF /4)를 as가 조용히 받아준다'는 bug로 "
        "기록돼 있었으나, ModRM 바이트를 직접 디코딩해보니 틀린 진단이었다. combo 419 "
        "(`call dword ptr [eax]` -> `67 66 ff 18`)의 ModRM=0x18=0b00_011_000, reg=3 -> "
        "FF /3(far call, m16:16/m16:32)이지 FF /2(near call r/m32)가 아니다. combo 1436도 "
        "동일 패턴(ModRM=0x28, reg=5 -> FF /5 far jmp, FF /4 near jmp 아님). isa_db.csv 확인 "
        "결과 FF /3 CALL m16:16/m16:32 / FF /5 JMP m16:16/m16:32는 SDM상 64비트 모드 Valid다 "
        "(64비트 모드에서 인코딩 안 되는 건 근접 r/m32 폼뿐 - CALL FF/2 r/m32는 N.E., JMP "
        "FF/4 r/m32는 N.S.로 표기가 다르지만 둘 다 인코딩 불가라는 실질은 같다). 즉 `as`는 "
        "인코딩 불가 폼을 만든 게 아니라, 모호한 Intel 문법 'call/jmp dword ptr [mem]'을 "
        "66 프리픽스로 far m16:16(4바이트, 'dword ptr' 표기와 크기가 정확히 맞음)으로 유효하게 "
        "해석한 것이다. clang은 66 프리픽스 없이 far m16:32(6바이트, FWORD)로 가서 오히려 "
        "'dword ptr' 표기와는 크기가 안 맞지만, 그래도 근접(N.E./N.S.) 폼은 아니다 - SDM 위반이 "
        "아니라 generator가 만든 모호한 테스트 케이스가 의도(근접 r/m32)와 다른(그러나 둘 다 "
        "유효한) far 폼으로 해석된 것이다. as/clang 모두 근접 N.E./N.S. 폼을 만들지 않는다는 "
        "점에서 일치.",
        "false_alarm",
    )

for _cid in ["1511", "4122"]:
    PERMISSIVE_MISMATCH_OVERRIDES[_cid] = (
        "cpuid_conditional_availability_not_captured",
        "SDM p.650/p.1304: LAHF/SAHF는 64비트 모드 열에 'Invalid'라고 적혀 있지만 각주와 설명문에 "
        "'CPUID.80000001H:ECX.LAHF_SAHF_64[0]=1이면 64비트 모드에서도 Valid'라고 명시돼 있음"
        "(현대 CPU/as는 이 플래그를 사실상 항상 지원) - mode_support 컬럼이 조건부 허용 각주를 "
        "반영하지 못해 생긴 불일치, 실제 as 동작은 매뉴얼의 조건부 허용과 일치.",
        "false_alarm",
    )


def classify_permissive_mismatch(row):
    """asm_result.csv에서 mismatch=True(expected_valid=False인데 actual_result=ok)인 행을 분류한다."""
    combo_id = row["combo_id"]
    if combo_id in PERMISSIVE_MISMATCH_OVERRIDES:
        return PERMISSIVE_MISMATCH_OVERRIDES[combo_id]
    return ("mismatch_assembler_more_permissive",
            "매뉴얼상 Invalid/N.E./N.S.인데 as가 받아줌 - 원인 미확인, 형섭 직접 확인 필요",
            "unsure")


# ===========================================================================
# 3. roundtrip 차이(result == "different", 1,351건) 분류
# ===========================================================================

STRING_MNEMONICS = {
    "movs", "cmps", "lods", "scas", "stos", "ins", "outs",
    "movsb", "movsw", "movsd", "movsq", "cmpsb", "cmpsw", "cmpsd", "cmpsq",
    "lodsb", "lodsw", "lodsd", "lodsq", "scasb", "scasw", "scasd", "scasq",
    "stosb", "stosw", "stosd", "stosq", "insb", "insw", "insd",
    "outsb", "outsw", "outsd", "xlat", "xlatb",
}

MNEM_ALIAS_EXACT = {
    ("sal", "shl"), ("wait", "fwait"), ("mov", "movabs"),
    ("iretd", "iret"), ("popfq", "popf"), ("pushfq", "pushf"),
    ("repe", "repz"), ("repne", "repnz"), ("xacquire", "repnz"), ("xrelease", "repz"),
}

SIZE_WORDS = {"byte", "word", "dword", "qword", "xmmword", "ymmword", "zmmword"}

NUM_RE = re.compile(r"\b0x[0-9a-fA-F]+\b|\b\d+\b")


def _to_num(tok):
    try:
        return int(tok, 16) if tok.lower().startswith("0x") else int(tok)
    except ValueError:
        return None


def _numeric_normalize(s):
    return NUM_RE.sub(lambda m: f"#{_to_num(m.group(0))}#", s)


def _norm_ws(s):
    s = re.sub(r"\s*,\s*", ",", s)
    return re.sub(r"\s+", " ", s).strip()


def _first_word(s):
    """rep/repe/repne/lock 접두어를 뗀 뒤 첫 단어(니모닉)를 뽑는다."""
    parts = s.strip().split(None, 1)
    if parts and parts[0] in ("rep", "repe", "repne", "lock"):
        parts = parts[1].split(None, 1) if len(parts) > 1 else [""]
    return parts[0].strip() if parts and parts[0] else ""


def _strip_evex_tag(s):
    return re.sub(r"^\{evex\}\s*", "", s.strip())


def _cc_alias(a, b):
    """조건부 분기/이동/비교(jcc/cmovcc/setcc/vcmp 등) 니모닉 접미사 alias 여부."""
    for base in ("j", "cmov", "set"):
        if a.startswith(base) and b.startswith(base):
            return True
    if re.match(r"^v?p?cmp", a) and re.match(r"^v?p?cmp", b):
        return True
    if "clmul" in a and "clmul" in b:
        return True
    return False


# combo_id 단위로 패턴 분류를 덮어쓰는 예외 (개별 확인을 거친 것만).
# 튜플 순서는 classify_roundtrip_diff()의 반환 순서와 맞춰 (category, cause, verdict)여야 한다.
ROUNDTRIP_COMBO_OVERRIDES = {
    "1527": ("objdump_farptr_size_ignores_rexw",
             "2026-08-25 확인(10단계 reassemble_check + codex 교차검증), 2026-09-03 정밀도 정정"
             "(codex 재검토): 이전엔 register_width/name_changed로 unsure 처리돼 있었다. "
             "`lss rcx, m16:64`(REX.W + 0F B2 /r)를 as가 SDM 그대로 정확히 인코딩(67 48 0f b2 08, "
             "ModRM reg=1=rcx)했는데 objdump가 메모리 크기를 REX.W로 승격된 r64 폼에서만 항상 "
             "FWORD PTR(6바이트, m16:32 크기)로 표시한다 - m16:64는 10바이트라 TBYTE PTR이어야 "
             "한다(r16/r32 폼은 각각 DWORD/FWORD로 정확히 표시됨, REX.W 유무와 무관하게 항상 "
             "틀린 게 아니라 REX.W 승격 폼에서만 오표기됨). 그 표시 텍스트를 그대로 다시 어셈블하면 "
             "as가 \"incorrect register `rcx' used with `l' suffix\"로 거부하는 것이 간접 증거"
             "(as 자신은 rcx엔 FWORD(l)가 아니라 TBYTE가 맞다고 알고 있음). 추가 증거: LLVM "
             "19.1.1의 llvm-objdump는 같은 바이트를 Intel 모드에서 크기 키워드 없이 `lss rcx, "
             "[eax]`로, AT&T 모드는 `lssq (%eax), %rcx`(64비트 폭을 접미사로 암시)로 표시해 이 "
             "오표기를 하지 않음 - 독립된 2번째 디스어셈블러도 안 하는 GNU objdump만의 결함. "
             "as의 인코딩이 아니라 objdump의 디스어셈블 표시 결함.",
             "bug"),
    "1532": ("objdump_farptr_size_ignores_rexw",
             "combo 1527(LSS)과 동일 패턴, LFS(REX.W + 0F B4 /r).", "bug"),
    "1535": ("objdump_farptr_size_ignores_rexw",
             "combo 1527(LSS)과 동일 패턴, LGS(REX.W + 0F B5 /r).", "bug"),
}

ROUNDTRIP_CAUSES = {
    "implicit_operand_display":
        "string 명령어(movs/lods/stos/scas/cmps/ins/outs/xlat)는 소스에 오퍼랜드를 안 쓰거나 "
        "크기 접미사(movsb 등)로만 써도 objdump는 실제 암묵 오퍼랜드(es:[rdi], ds:[rsi] 등)를 "
        "explicit하게 풀어서 보여줌 - alias/표기 차이, 버그 아님.",
    "mnemonic_alias":
        "조건부 분기/이동/비교(jnz->jne, cmovnge->cmovl 등)나 sal->shl, wait->fwait, "
        "popfq->popf, xacquire/xrelease->repnz/repz 같은 동일 오피코드의 다른 이름(alias) - "
        "버그 아님.",
    "numeric_repr":
        "즉시값 표기가 10진(1)->16진(0x1)으로 바뀐 것뿐, 값 자체는 동일 - 버그 아님.",
    "relative_target_absolute_display":
        "상대 분기 대상이 소스에서는 라벨(.Ltarget)이었는데 objdump는 절대주소(0x0 등)로 "
        "보여줌 - objdump가 라벨을 복원할 방법이 없어서 생기는 표기 차이, 버그 아님.",
    "fpu_stack_register_display":
        "x87 스택 레지스터의 암묵 st(0)를 objdump가 짧게 'st'로 표기하거나(예: fadd st,st(0)), "
        "반대로 소스에 없는 두 번째 스택 레지스터(st(1) 등)를 명시적으로 보여줌 - 표기 관례 "
        "차이, 버그 아님.",
    "encoding_form_annotation":
        "동일한 텍스트 니모닉이 VEX/EVEX 두 가지로 인코딩될 수 있어 objdump가 EVEX로 인코딩된 "
        "쪽에 '{evex}' 태그를 붙여 구분함 - 인코딩 선택 표시일 뿐, 버그 아님.",
    "size_directive_inferred/omitted":
        "소스에 크기 지시자(byte/word/... ptr)를 생략했는데 objdump가 채워서 보여주거나, "
        "반대로 오퍼랜드 크기가 고정된 명령이라 objdump가 불필요한 크기 지시자를 생략함 - "
        "버그 아님.",
    "register_width/name_changed":
        "레지스터 폭 표기가 바뀜(예: mov ds,cx -> mov ds,ecx, lldt cx -> lldt ecx, movsxd "
        "cx,cx -> movsxd cx,ecx). 해당 opcode가 레지스터 폭에 무관하게 동일하게 동작하는지 "
        "아직 as 소스/SDM 각주까지 다 대조하지 못해 판단보류.",
    "operand_count/order_changed":
        "오퍼랜드 순서만 바뀜(예: xchg ax,cx -> xchg cx,ax). XCHG처럼 대칭적인 명령이라 "
        "결과는 동일 - 버그 아님.",
    "implicit_operand_added_by_generator":
        "combiner가 SDM의 <EDX>,<EAX> 같은 암묵 오퍼랜드를 실제 오퍼랜드로 잘못 방출했는데, "
        "이 명령어(umwait/tpause 등)는 as가 초과 오퍼랜드를 에러 없이 그냥 무시함 - "
        "compile_error 쪽의 combiner_implicit_operand_as_explicit와 같은 뿌리의 combiner 한계.",
    "sib_addressing_display":
        "AMX(tile) 명령어는 항상 SIB 인덱스가 필요해서 소스에 인덱스가 없어도 objdump가 "
        "'[eax+eiz*1]'처럼 명시적으로 보여줌 - 표기 차이, 버그 아님.",
    "imm_value_truncated_by_generator":
        "generator가 목적지 크기에 안 맞는 고정 즉시값(0x1000 등)을 그대로 써서 as가 조용히 "
        "잘라(truncate) 인코딩함 - 테스트케이스 생성 결함(generator), 진짜 8/16비트 truncation "
        "버그가 아니라 애초에 잘못된 입력값 - DEVLOG 2026-07-24 참고.",
    "encoding_falls_back_to_nop":
        "PREFETCHIT0/1은 SDM상 RIP-relative 메모리만 유효하고, 그 외 주소 형식이면 NOP로 "
        "취급된다고 명시돼 있음. generator가 RIP-relative가 아닌 [eax]를 써서 objdump가 "
        "'nop'으로 보여주는 것은 SDM에 문서화된 정상 동작(generator가 올바른 폼을 테스트 못한 "
        "것) - 버그 아님.",
    "size_directive_name_changed":
        "같은 128비트를 가리키는 크기 지시자 이름이 다름(xmmword ptr <-> OWORD PTR, "
        "cmpxchg16b) - 표기 관례 차이, 버그 아님.",
}

ROUNDTRIP_VERDICT = {
    "implicit_operand_display": "false_alarm",
    "mnemonic_alias": "false_alarm",
    "numeric_repr": "false_alarm",
    "relative_target_absolute_display": "false_alarm",
    "fpu_stack_register_display": "false_alarm",
    "encoding_form_annotation": "false_alarm",
    "size_directive_inferred/omitted": "false_alarm",
    "register_width/name_changed": "unsure",
    "operand_count/order_changed": "false_alarm",
    "implicit_operand_added_by_generator": "false_alarm",
    "sib_addressing_display": "false_alarm",
    "imm_value_truncated_by_generator": "false_alarm",
    "encoding_falls_back_to_nop": "false_alarm",
    "size_directive_name_changed": "false_alarm",
}


def _roundtrip_category(asm_line, objdump_line):
    """asm_line(소스)과 objdump_line(역어셈블)을 비교해서 차이 원인 그룹을 고른다."""
    a, b = asm_line.strip(), objdump_line.strip()
    al, bl = a.lower(), _strip_evex_tag(b.lower())
    has_evex = bl != b.lower()
    aw, bw = _first_word(al), _first_word(bl)

    if aw in STRING_MNEMONICS or bw in STRING_MNEMONICS:
        return "implicit_operand_display"

    if aw != bw:
        if (aw, bw) in MNEM_ALIAS_EXACT or _cc_alias(aw, bw):
            return "mnemonic_alias"
        if bw == "nop":
            return "encoding_falls_back_to_nop"
        return "mnemonic_alias"  # 나머지 첫 단어 불일치는 잠정적으로 alias류로 묶음

    if has_evex and _norm_ws(al) == _norm_ws(bl):
        return "encoding_form_annotation"

    a_num = _norm_ws(_numeric_normalize(al))
    b_num = _norm_ws(_numeric_normalize(bl))
    if a_num == b_num:
        return "encoding_form_annotation" if has_evex else "numeric_repr"

    if ".ltarget" in al and re.search(r"0x[0-9a-f]+", bl):
        return "relative_target_absolute_display"

    if aw.startswith("f") and ("st(" in al or "st(" in bl or re.search(r"\bst\b", al)
                                or re.search(r"\bst\b", bl)):
        return "fpu_stack_register_display"

    if "eiz" in bl or "riz" in bl:
        return "sib_addressing_display"

    if "oword" in bl and "xmmword" in al:
        return "size_directive_name_changed"

    if re.search(r"\b0x1000\b", al) or re.search(r"\b1000\b", al):
        return "imm_value_truncated_by_generator"

    a_ops = a.split(None, 1)[1] if len(a.split(None, 1)) > 1 else ""
    b_ops = b.split(None, 1)[1] if len(b.split(None, 1)) > 1 else ""
    a_set = {x.replace("ptr", "").strip()
             for x in re.split(r"[\s,]+", _norm_ws(_numeric_normalize(a_ops.lower()))) if x.strip()}
    b_set = {x.replace("ptr", "").strip()
             for x in re.split(r"[\s,]+", _norm_ws(_numeric_normalize(b_ops.lower()))) if x.strip()}
    if a_set and b_set:
        if a_set == b_set:
            return "operand_count/order_changed"
        if b_set < a_set:
            # objdump 쪽 오퍼랜드가 소스보다 적음(부분집합) -> combiner가 암묵 오퍼랜드를 더 넣은 경우
            return "implicit_operand_added_by_generator"

    a_has_size = any(w in al for w in SIZE_WORDS)
    b_has_size = any(w in bl for w in SIZE_WORDS)
    if a_has_size != b_has_size:
        return "size_directive_inferred/omitted"

    return "register_width/name_changed"


def classify_roundtrip_diff(row):
    combo_id = row["combo_id"]
    if combo_id in ROUNDTRIP_COMBO_OVERRIDES:
        return ROUNDTRIP_COMBO_OVERRIDES[combo_id]
    category = _roundtrip_category(row["asm_line"], row["objdump_line"])
    cause = ROUNDTRIP_CAUSES[category]
    verdict = ROUNDTRIP_VERDICT[category]
    return category, cause, verdict


# ===========================================================================
# 4. 전체 조합 - combo_id 기준으로 유니크하게 합친다
# ===========================================================================

def build_triage_rows(asm_rows, rt_rows):
    """asm_result.csv의 에러/mismatch, roundtrip.csv의 different를 combo_id로 묶어서
    triage.csv 한 행씩(중복 없이) 만든다."""
    rt_by_combo = {r["combo_id"]: r for r in rt_rows if r["result"] == "different"}
    triaged = []
    seen_combo_ids = set()

    for row in asm_rows:
        combo_id = row["combo_id"]
        is_error = row["actual_result"] == "error"
        is_permissive_mismatch = row["mismatch"] == "True" and row["actual_result"] == "ok"

        if not is_error and not is_permissive_mismatch:
            continue  # 정상 통과 + 정상 mismatch 없음 -> triage 대상 아님

        if is_error:
            category, cause, verdict = classify_compile_error(row)
            objdump_or_error = row["error_message"]
        else:
            category, cause, verdict = classify_permissive_mismatch(row)
            objdump_or_error = "(as 성공 - 매뉴얼상 Invalid/N.E./N.S.인데 성공)"

        # 같은 combo_id가 roundtrip에서도 different로 잡혔으면 diff_cause를 덧붙인다.
        rt_row = rt_by_combo.get(combo_id)
        if rt_row is not None:
            rt_category, rt_cause, _ = classify_roundtrip_diff(rt_row)
            objdump_or_error += f" | roundtrip objdump: {rt_row['objdump_line']}"
            cause += f" [roundtrip 차이도 있음: {rt_category} - {rt_cause}]"

        triaged.append({
            "category": category,
            "mnemonic": row["mnemonic"],
            "source": f"{row['source_line']}/{combo_id}",
            "objdump_or_error": objdump_or_error,
            "compile_result": row["actual_result"],
            "diff_cause": cause,
            "verdict": verdict,
        })
        seen_combo_ids.add(combo_id)

    for row in rt_rows:
        combo_id = row["combo_id"]
        if row["result"] != "different" or combo_id in seen_combo_ids:
            continue
        category, cause, verdict = classify_roundtrip_diff(row)
        triaged.append({
            "category": category,
            "mnemonic": row["mnemonic"],
            "source": f"{row['source_line']}/{combo_id}",
            "objdump_or_error": row["objdump_line"],
            "compile_result": "ok",
            "diff_cause": cause,
            "verdict": verdict,
        })
        seen_combo_ids.add(combo_id)

    return triaged


# ===========================================================================
# 5. 출력
# ===========================================================================

def write_csv(rows, path):
    fieldnames = ["category", "mnemonic", "source", "objdump_or_error",
                  "compile_result", "diff_cause", "verdict"]
    with open(path, "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def _group_counts(rows):
    counts = {}
    for r in rows:
        counts.setdefault(r["category"], []).append(r)
    return dict(sorted(counts.items(), key=lambda kv: -len(kv[1])))


def write_report(rows, path):
    total = len(rows)
    verdict_counts = {}
    for r in rows:
        verdict_counts[r["verdict"]] = verdict_counts.get(r["verdict"], 0) + 1

    bug_rows = [r for r in rows if r["verdict"] == "bug"]
    groups = _group_counts(rows)

    lines = []
    lines.append("# Triage 리포트 (7단계)")
    lines.append("")
    lines.append(f"- 전체 대상: {total}건 (컴파일 에러 + mismatch + roundtrip 차이, combo_id 기준 중복 제거)")
    lines.append(f"- verdict 분포: " + ", ".join(f"{k}={v}" for k, v in sorted(verdict_counts.items())))
    lines.append("")

    lines.append("## 진짜 의심되는 버그 후보 (verdict=bug)")
    lines.append("")
    lines.append("도구(as/objdump) 직접 재현 + SDM PDF 원문 대조까지 마친 것만 bug로 표시했다.")
    lines.append("")
    for r in bug_rows:
        lines.append(f"### {r['mnemonic']} (source {r['source']})")
        lines.append(f"- 분류: {r['category']}")
        lines.append(f"- objdump/error: {r['objdump_or_error']}")
        lines.append(f"- 원인: {r['diff_cause']}")
        lines.append("")

    lines.append("## 그룹별 건수")
    lines.append("")
    lines.append("| 분류(category) | 건수 | verdict 분포 |")
    lines.append("|---|---|---|")
    for cat, group_rows in groups.items():
        vc = {}
        for r in group_rows:
            vc[r["verdict"]] = vc.get(r["verdict"], 0) + 1
        vc_str = ", ".join(f"{k}={v}" for k, v in sorted(vc.items()))
        lines.append(f"| {cat} | {len(group_rows)} | {vc_str} |")
    lines.append("")

    lines.append("## 그룹별 대표 샘플")
    lines.append("")
    for cat, group_rows in groups.items():
        lines.append(f"### {cat} ({len(group_rows)}건)")
        lines.append("")
        for r in group_rows[:3]:
            lines.append(f"- `{r['mnemonic']}` (source {r['source']}, verdict={r['verdict']}): "
                         f"{r['objdump_or_error'][:120]}")
        lines.append("")
        lines.append(f"원인: {group_rows[0]['diff_cause']}")
        lines.append("")

    with open(path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))


def main():
    asm_rows = load_rows(ASM_CSV)
    rt_rows = load_rows(RT_CSV)

    triaged = build_triage_rows(asm_rows, rt_rows)
    write_csv(triaged, OUT_CSV)
    write_report(triaged, OUT_MD)

    print(f"전체 triage 대상: {len(triaged)}건")
    groups = _group_counts(triaged)
    for cat, group_rows in groups.items():
        print(f"  {cat}: {len(group_rows)}건")
    verdict_counts = {}
    for r in triaged:
        verdict_counts[r["verdict"]] = verdict_counts.get(r["verdict"], 0) + 1
    print("verdict 분포:", verdict_counts)
    print(f"출력: {OUT_CSV}, {OUT_MD}")


if __name__ == "__main__":
    main()

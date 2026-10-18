"""SDM 093판 ER/SAE의 입력 형태와 EVEX 필드. 실행 의미 검사가 아니다.

Vol.2 PDF 72: §§2.7.8–9, register-to-register, scalar/512-bit.
PDF 73 Table 2-38: ER RC=00/01/10/11. PDF 75 Table 2-43 note 2:
SAE-only의 L'L은 ignored. PDF 108: {er}/{sae} 표 기호 정의.
"""
import re

from pipeline.disasm_rules import split_operands
from pipeline.operand_forms import operand

ROUNDING = {"{rn-sae}": 0, "{rd-sae}": 1, "{ru-sae}": 2, "{rz-sae}": 3}
CONTROLS = tuple(ROUNDING) + ("{sae}",)
PATTERN = re.compile(r"\{(?:r[nudz]-sae|sae)\}", re.I)
EVIDENCE = "Vol.2 72 §§2.7.8–9; 73 Table 2-38; 75 Table 2-43; 108 ER/SAE"


def separate(text):
    """일반 오퍼랜드와 ER/SAE를 나누고 위치·중복을 보존한다. 모르는 장식은 지우지 않는다."""
    operands, controls, positions = [], [], []
    for part in split_operands(text):
        found = PATTERN.findall(part)
        bare = PATTERN.sub("", part).strip()
        if bare:
            operands.append(bare)
        controls.extend(token.lower() for token in found)
        positions.extend([len(operands) - 1] * len(found))
    return operands, controls, positions


def form_error(opcode, symbols, text):
    """표 행에 대해 요청한 장식의 조건 위반 이유. 빈 문자열이면 이 부분 조건 통과."""
    operands, controls, positions = separate(text)
    if not controls:
        return ""
    if len(controls) != 1:
        return "ER/SAE 장식 중복"
    control = controls[0]
    marker = "{er}" if control in ROUNDING else "{sae}"
    indices = [i for i, symbol in enumerate(symbols) if marker in symbol.lower()]
    if len(indices) != 1:
        return "이 표 행은 요청한 ER/SAE를 지원하지 않음"
    if len(operands) != len(symbols):
        return "피연산자 수가 표와 다름"
    index = indices[0]
    # LLVM Intel의 정수→실수 변환 출력은 RC를 GPR 소스 앞에 둔다.
    # 실제 수용 관측은 out/er_sae_support_20261013/layout_observations.json.
    before_gpr = (control in ROUNDING and operand(operands[index])["family"] == "gpr"
                  and positions == [index - 1])
    if positions != indices and not before_gpr:
        return "ER/SAE 장식 위치가 표의 피연산자와 다름"
    if any("[" in op or re.search(r"\b(?:ptr|bcst)\b", op, re.I) for op in operands):
        return "ER/SAE는 register-to-register 형식에만 적용"
    if not re.match(r"EVEX\.(?:512|LLIG)\.", opcode):
        return "현재 SDM ER/SAE 대상은 EVEX scalar/512-bit 행"
    return ""


def symbols_of(row):
    text = row.get("operand_types", row.get("operands", ""))
    return [p for p in split_operands(text) if not p.strip().startswith("<")]


def encoding_fields(row, data, prefix_pos, opcode_pos):
    """요청 장식과 EVEX.b/RC/ModRM.mod 대조. None은 이 검사의 범위 밖."""
    text = row.get("operands", "")
    _, controls, _ = separate(text)
    if not controls:
        # 장식 없는 레지스터 입력을 ER/SAE 바이트로 바꾸어도 일치로 세지 않는다.
        symbols = symbols_of(row)
        capable = any("{er}" in symbol or "{sae}" in symbol for symbol in symbols)
        if (capable and data[prefix_pos] == 0x62 and len(data) > opcode_pos + 1
                and data[opcode_pos + 1] >> 6 == 3):
            return not bool(data[prefix_pos + 3] & 0x10)
        return None
    if form_error(row.get("opcode", ""), symbols_of(row), text):
        return False
    if len(data) <= opcode_pos + 1 or data[prefix_pos] != 0x62:
        return False
    if not data[prefix_pos + 3] & 0x10 or data[opcode_pos + 1] >> 6 != 3:
        return False
    control = controls[0]
    # SAE-only: L'L ignored, not a requested rounding mode (Table 2-43 note 2).
    return control == "{sae}" or (data[prefix_pos + 3] >> 5) & 3 == ROUNDING[control]

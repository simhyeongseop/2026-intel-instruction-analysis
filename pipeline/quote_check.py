"""Sol 추출의 source_quotes 인용문이 실제 원문에 있는지 기계적으로 확인한다.

인용 형식: `[쪽 소제목] "문장"`(쪽은 `123`, `123쪽`, `파일123`, `123-124` 모두 받음), `[SYM018] "문장"`.
일치 판정은 단계별로 기록한다. 느슨한 단계에서만 맞은 인용은 그 사실이 보이게 남긴다.
- exact: 공백·따옴표 모양만 정규화하고 그대로 들어 있음
- nospace: 공백을 모두 지우면 들어 있음(표 칸 줄바꿈, 'floating- point' 분철)
- nohyphen: 하이픈까지 지우면 들어 있음('corre- sponding')
- table_label: 표 인용에서 Sol이 붙인 '열 이름: 값' 꼴의 열 이름을 떼고, 'Valid/Valid'처럼 합친 값을
  칸별로 나누면 들어 있음(표 인용에만 적용)
표 인용처럼 '...', ' | ', ' / '로 칸·생략을 나눈 인용은 조각마다 확인하고 가장 느슨한 단계를 결과로 쓴다.
표 인용(소제목이 '표'로 시작하거나 '표'를 포함)은 쪽 텍스트가 열을 섞어 싣기 때문에, 그 쪽들의 표 셀 원문
(table_cells.jsonl, 각주 ^n 표기 포함)도 함께 대조 대상으로 쓴다.
"""

import re

ANCHOR = re.compile(r'\[(?P<ref>[^\]\[]{1,120})\]\s*"')
# 인용 끝: 닫는 따옴표 뒤에 다음 인용(| [), 문자열 끝, 괄호 설명, 다음 표 칸(/ 이름 "값")이 온다.
CLOSE = re.compile(r'"(?=\s*(?:\|\s*\[|$|\(|;|/\s*[^"|]{1,40}"))')
PAGE_REF = re.compile(r"^(?:파일\s*)?(\d+)(?:쪽)?(?:\s*[-–~]\s*(?:파일\s*)?(\d+)(?:쪽)?)?(?:\s+(.*))?$")
SYM_REF = re.compile(r"^SYM\d{3}$")
FRAGMENT_SPLIT = re.compile(r"\s*\.\.\.\s*|…|\s+\|\s+|\s+/\s+")
LEVELS = ["exact", "nospace", "nohyphen"]  # table_label은 표 인용에만 따로 쓴다
QUOTE_CHARS = str.maketrans({"’": "'", "‘": "'", "“": '"', "”": '"', "­": ""})


def parse_quotes(text):
    """(ref, quote) 목록과 해석하지 못한 앵커 수. ref가 쪽·SYM 형식이 아니면 인용으로 보지 않는다."""
    found = []
    position = 0
    while True:
        anchor = ANCHOR.search(text, position)
        if not anchor:
            break
        close = CLOSE.search(text, anchor.end())
        if not close:
            break
        ref = anchor.group("ref").strip()
        if SYM_REF.match(ref) or PAGE_REF.match(ref):
            found.append((ref, text[anchor.end():close.start()]))
            position = close.end()
        else:
            position = anchor.end()
    return found


def parse_ref(ref):
    """('sym', 'SYM018', '') 또는 ('page', (첫 쪽, 끝 쪽), 소제목)."""
    if SYM_REF.match(ref):
        return "sym", ref, ""
    matched = PAGE_REF.match(ref)
    first = int(matched.group(1))
    last = int(matched.group(2)) if matched.group(2) else first
    return "page", (first, last), (matched.group(3) or "").strip()


def normalize(text, level):
    text = text.translate(QUOTE_CHARS)
    if level == "exact":
        return " ".join(text.split())
    text = re.sub(r"\s+", "", text)
    if level == "nohyphen":
        text = text.replace("-", "")
    return text


def match_level(quote, source):
    """quote가 source에 들어 있는 가장 엄격한 단계. 없으면 None. 조각 인용은 모든 조각이 있어야 한다."""
    fragments = [f for f in FRAGMENT_SPLIT.split(quote.strip()) if len(f.strip()) >= 2] or [quote]
    worst = 0
    for fragment in fragments:
        for rank, level in enumerate(LEVELS):
            if normalize(fragment, level) in normalize(source, level):
                worst = max(worst, rank)
                break
        else:
            return None
    return LEVELS[worst]


TABLE_LABEL = re.compile(r"^[^:]{1,40}:\s*")


def table_label_level(quote, source):
    """'64/32 bit Mode: Valid/N.E.; Op/En: MR' 꼴. 열 이름을 떼고 값의 조각이 모두 원문 셀에 있으면 'table_label'."""
    values = [TABLE_LABEL.sub("", part) for part in re.split(r"\s*;\s*", quote) if part.strip()]
    if not values or not any(TABLE_LABEL.match(part) for part in re.split(r"\s*;\s*", quote)):
        return None
    pieces = [piece for value in values for piece in re.split(r"(?<=\w|\.)/(?=\w)", value)]
    return "table_label" if all(match_level(piece, source) for piece in pieces) else None


def is_table_ref(subsection):
    return subsection.startswith("표") or "표" in subsection.split()[:2] or "형식 표" in subsection

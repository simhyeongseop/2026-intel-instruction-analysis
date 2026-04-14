"""
Step 4-4: 에러 Triage (4회 미팅 액션 아이템)

수집된 컴파일러 에러를 그룹화하고 분석합니다.
다음 미팅 준비물: 자주 발생하는 에러의 대표 예제 2~3개 (주석 포함)

출력:
  - step4_error_triage.csv       : 카테고리별 에러 집계
  - step4_error_report.md        : 다음 미팅 보고서 (대표 예제 포함)
"""

import pandas as pd
import re
from pathlib import Path
from collections import defaultdict


BASE = Path(__file__).parent.parent.parent
OUT_DIR = BASE / "data" / "stage4_tests"
ERROR_CSV = OUT_DIR / "step4_error_lines.csv"
ASM_FILE = OUT_DIR / "test_all_instructions.s"


# ============================================================
# 1. 에러 카테고리 분류 (Triage)
# ============================================================

TRIAGE_RULES = [
    # (패턴, 카테고리명, 설명)
    (r"number of operands mismatch",        "operand_count_mismatch",       "오퍼랜드 개수 불일치"),
    (r"unsupported instruction",            "unsupported_instruction",      "지원되지 않는 명령어"),
    (r"(unknown instruction|no such instruction)", "unknown_instruction",   "알 수 없는 명령어"),
    (r"invalid combination of opcode and operand", "invalid_opcode_operand","오퍼랜드-오퍼레이션 조합 오류"),
    (r"operand size mismatch",              "operand_size_mismatch",        "오퍼랜드 크기 불일치"),
    (r"operand type mismatch",              "operand_type_mismatch",        "오퍼랜드 타입 불일치"),
    (r"(immediate|imm).*(too large|out of range|overflow)",
                                            "immediate_out_of_range",       "즉시값 범위 초과"),
    (r"not supported in 64-bit mode",       "not_supported_64bit",          "64비트 모드 미지원"),
    (r"not allowed with",                   "not_allowed",                  "허용되지 않는 조합"),
    (r"conflicting operand size",           "conflicting_size",             "오퍼랜드 크기 충돌"),
    (r"(bad|invalid) (register|reg)",       "bad_register",                 "잘못된 레지스터"),
    (r"(junk|garbage).*(after|in)",         "junk_suffix",                  "명령어 뒤 불필요한 문자"),
    (r"suffix",                             "suffix_error",                 "접미어 오류"),
    (r"reloc",                              "relocation_error",             "재배치 오류"),
    (r"expecting",                          "syntax_expecting",             "구문 오류 (기대값 불일치)"),
    (r"too many",                           "too_many",                     "요소 개수 초과"),
    (r"missing",                            "missing_element",              "필수 요소 누락"),
    (r"not valid",                          "not_valid_here",               "해당 위치에서 유효하지 않음"),
]


def classify_error(message: str) -> tuple[str, str]:
    """에러 메시지를 카테고리로 분류. (category_key, description) 반환"""
    msg_lower = message.lower()
    for pattern, key, desc in TRIAGE_RULES:
        if re.search(pattern, msg_lower):
            return key, desc
    return "other", "기타 에러"


def extract_mnemonic_from_error(message: str) -> str:
    """에러 메시지에서 명령어 니모닉 추출 (backtick 안쪽)"""
    m = re.search(r"`([a-z0-9]+)'", message.lower())
    return m.group(1) if m else ""


# ============================================================
# 2. 소스 라인에서 해당 블록의 원본 Instruction 추출
# ============================================================

def build_line_to_instr_map(asm_path: Path) -> dict[int, str]:
    """각 소스 라인 번호 → 해당 명령어 블록 헤더 (# === ... ===) 매핑"""
    lines = asm_path.read_text(encoding="utf-8").splitlines()
    mapping = {}
    current_header = "(unknown)"
    for i, line in enumerate(lines, 1):
        stripped = line.strip()
        if stripped.startswith("# ===") and stripped.endswith("==="):
            current_header = stripped[5:-3].strip()
        mapping[i] = current_header
    return mapping


# ============================================================
# 3. 보고서 생성
# ============================================================

def build_report(df: pd.DataFrame, line_map: dict[int, str]) -> str:
    """다음 미팅용 에러 분석 보고서 (Markdown)"""

    # 소스 라인 텍스트 다시 로드
    src_lines = ASM_FILE.read_text(encoding="utf-8").splitlines()
    def get_line(n):
        idx = n - 1
        return src_lines[idx].strip() if 0 <= idx < len(src_lines) else ""

    lines_md = []
    lines_md.append("# Step 4 에러 Triage 보고서")
    lines_md.append("")
    lines_md.append(f"**대상 파일**: `test_all_instructions.s`  ")
    lines_md.append(f"**총 에러 수**: {len(df)}개  ")
    lines_md.append(f"**컴파일러**: GNU as (binutils)")
    lines_md.append("")
    lines_md.append("---")
    lines_md.append("")

    # 카테고리별 요약 표
    lines_md.append("## 1. 에러 카테고리별 분포")
    lines_md.append("")
    lines_md.append("| 카테고리 | 설명 | 건수 | 비율 |")
    lines_md.append("|----------|------|-----:|-----:|")
    cat_counts = df.groupby(["category", "category_desc"]).size().reset_index(name="count")
    cat_counts = cat_counts.sort_values("count", ascending=False)
    total = len(df)
    for _, r in cat_counts.iterrows():
        pct = r["count"] / total * 100
        lines_md.append(f"| `{r['category']}` | {r['category_desc']} | {r['count']} | {pct:.1f}% |")
    lines_md.append("")

    lines_md.append("---")
    lines_md.append("")
    lines_md.append("## 2. 카테고리별 대표 예제 (다음 미팅 준비물)")
    lines_md.append("")

    for _, cat_row in cat_counts.iterrows():
        cat = cat_row["category"]
        desc = cat_row["category_desc"]
        count = cat_row["count"]

        lines_md.append(f"### 2.{list(cat_counts['category']).index(cat)+1} `{cat}` — {desc} ({count}건)")
        lines_md.append("")

        subset = df[df["category"] == cat].head(3)
        for i, (_, err_row) in enumerate(subset.iterrows(), 1):
            instr_block = line_map.get(err_row["line_num"], "(unknown)")
            asm_line = get_line(err_row["line_num"])
            lines_md.append(f"**예제 {i}**: `{instr_block}` 블록")
            lines_md.append(f"```asm")
            lines_md.append(f"{asm_line}  # [ERROR] {err_row['message']}")
            lines_md.append(f"```")
            lines_md.append("")

        lines_md.append("")

    lines_md.append("---")
    lines_md.append("")
    lines_md.append("## 3. 주요 니모닉별 에러 발생 빈도 (TOP 20)")
    lines_md.append("")
    df["mnemonic"] = df["message"].apply(extract_mnemonic_from_error)
    mnemonic_counts = df[df["mnemonic"] != ""].groupby("mnemonic").size().nlargest(20)
    lines_md.append("| 니모닉 | 에러 수 |")
    lines_md.append("|--------|--------:|")
    for mnemonic, cnt in mnemonic_counts.items():
        lines_md.append(f"| `{mnemonic}` | {cnt} |")
    lines_md.append("")

    lines_md.append("---")
    lines_md.append("")
    lines_md.append("## 4. 64비트 모드 미지원 명령어 목록")
    lines_md.append("")
    not64 = df[df["category"] == "not_supported_64bit"]["message"].unique()
    for msg in not64:
        m = re.search(r"`([^']+)'", msg)
        if m:
            lines_md.append(f"- `{m.group(1)}`")
    lines_md.append("")

    lines_md.append("---")
    lines_md.append("")
    lines_md.append("## 5. GCC vs Clang 비교")
    lines_md.append("")
    if "compiler" in df.columns:
        comp_table = df.groupby(["compiler", "category"]).size().unstack(fill_value=0)
        lines_md.append("```")
        lines_md.append(comp_table.to_string())
        lines_md.append("```")
    else:
        lines_md.append("_(컴파일러 정보 없음 — GCC/Clang 모두 설치 후 재실행 필요)_")
    lines_md.append("")

    return "\n".join(lines_md)


# ============================================================
# 4. 메인
# ============================================================

def main():
    OUT_DIR.mkdir(parents=True, exist_ok=True)

    print("=" * 60)
    print("Step 4-4: 에러 Triage 분석")
    print("=" * 60)

    if not ERROR_CSV.exists():
        print(f"[오류] {ERROR_CSV} 없음. step4_compile_and_analyze.py 먼저 실행하세요.")
        return

    df = pd.read_csv(ERROR_CSV)
    print(f"[로드] 총 에러: {len(df)}개")

    # 분류
    df[["category", "category_desc"]] = df["message"].apply(
        lambda m: pd.Series(classify_error(m))
    )

    # Triage CSV 저장
    triage_csv = OUT_DIR / "step4_error_triage.csv"
    df.to_csv(triage_csv, index=False, encoding="utf-8")
    print(f"[저장] Triage 결과: {triage_csv}")

    # 카테고리 요약 출력
    print("\n=== 에러 카테고리 분포 ===")
    summary = df.groupby(["category", "category_desc"]).size().reset_index(name="count")
    summary = summary.sort_values("count", ascending=False)
    for _, r in summary.iterrows():
        bar = "#" * min(int(r["count"] / len(df) * 50), 50)
        print(f"  {r['category']:35s} {r['count']:5d}건  {bar}")

    # 보고서 생성
    print("\n[보고서 생성 중...]")
    if ASM_FILE.exists():
        line_map = build_line_to_instr_map(ASM_FILE)
        report_md = build_report(df, line_map)
        report_path = OUT_DIR / "step4_error_report.md"
        report_path.write_text(report_md, encoding="utf-8")
        print(f"[저장] 미팅 보고서: {report_path}")
    else:
        print(f"[경고] {ASM_FILE} 없음. 보고서에 소스 라인 포함 불가.")

    # 다음 미팅 요약 출력
    print("\n" + "=" * 60)
    print("다음 미팅 준비: 카테고리별 대표 예제")
    print("=" * 60)

    top_cats = summary.head(4)
    for _, r in top_cats.iterrows():
        cat = r["category"]
        examples = df[df["category"] == cat].head(2)
        print(f"\n[{cat}] ({r['count']}건)")
        for _, e in examples.iterrows():
            src_lines = ASM_FILE.read_text(encoding="utf-8").splitlines() if ASM_FILE.exists() else []
            idx = e["line_num"] - 1
            asm = src_lines[idx].strip() if 0 <= idx < len(src_lines) else ""
            print(f"  코드: {asm}")
            print(f"  에러: {e['message']}")

    print(f"\n[완료] Step 4-4 에러 Triage 완료")
    print(f"       → {OUT_DIR}")


if __name__ == "__main__":
    main()

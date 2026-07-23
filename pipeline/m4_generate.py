"""
4단계 generator: combos.csv -> out/tests.s

3단계(combiner)가 이미 각 조합의 오퍼랜드를 "구체적인 값"으로 완성해뒀다
(예: operands 컬럼에 "dword ptr [eax], ecx" 처럼 그대로 어셈블리 줄에 붙일 수 있는 문자열이 들어있음).
그래서 4단계가 새로 할 일은 "타입 -> 값" 치환이 아니라:

  1. selector: combos.csv에서 어떤 조합을 어셈블리 줄로 만들지 고른다.
     v1은 "순차(sequential)" — combos.csv에 있는 조합을 위에서부터 순서대로 전부 고른다.
     (한 row_id 안에 combo_index 가 여러 개 있어도 다 만든다 = "많이/다양하게 커버" 원칙,
      CLAUDE.md 6절 "expected_valid=False도 버리지 않는다"와 같은 취지)
  2. generator: 고른 조합 한 줄을 "mnemonic operands" 형태의 실제 어셈블리 텍스트로 만들고,
     원본 combos.csv 행을 역추적할 수 있는 주석을 붙인다.

원칙(CLAUDE.md, 작업 지시):
- 정답 기준은 인텔 매뉴얼. combos.csv operands 값을 손대지 않고 그대로 쓴다
  (여기서 "받아줄지 추측해서" 값을 바꾸지 않는다 — 그 판정은 5단계 assembler/6단계 roundtrip이 한다).
- row_id 570 (ENCODEKEY256)은 알려진 tokenizer 버그(콤마 누락)로 combos.csv 값이 SDM과
  다르다(틀린 조합) -> 스킵하고 out/generator_skipped.csv 에 이유를 남긴다.
- expected_valid=False(Invalid/N.E./N.S.) 조합도 그대로 생성한다. 다만 주석에
  expected_valid=False 라고 표시해서 나중 단계가 "이건 에러가 정상"이라고 구분할 수 있게 한다.
"""

import csv

IN_CSV = "data/db/combos.csv"
OUT_ASM = "out/tests.s"
OUT_SKIPPED = "out/generator_skipped.csv"

# 알려진 이슈: row_id 570 (ENCODEKEY256)은 tokenizer 단계 콤마 누락으로
# combos.csv 값(ecx, xmm0)이 SDM 기준 틀린 조합이다 -> 스킵.
SKIP_ROW_IDS = {
    "570": "ENCODEKEY256: tokenizer 콤마 누락으로 combos.csv operands(ecx, xmm0)가 SDM 기준 오조합 (이전 verifier 피드백)",
}

# CALL/Jcc/LOOP/XBEGIN 등 rel8/rel16/rel32 오퍼랜드는 combiner가 ".Ltarget" 이라는
# 더미 라벨 텍스트를 넣어뒀다. GNU as가 이 줄을 파싱하려면 그 라벨이 파일 어딘가에
# 정의돼 있어야 하므로, 모든 명령어보다 앞에 라벨 하나를 선언해둔다.
JUMP_TARGET_LABEL = ".Ltarget"


def read_combos(path):
    """combos.csv 를 읽어 딕셔너리 리스트로 반환한다."""
    with open(path, encoding="utf-8", newline="") as f:
        reader = csv.DictReader(f)
        return list(reader)


def build_line(row):
    """combos.csv 한 행 -> 어셈블리 한 줄 + 역추적용 주석."""
    mnemonic = row["mnemonic"].lower()
    operands = row["operands"]

    if operands:
        code = f"{mnemonic} {operands}"
    else:
        code = mnemonic  # 오퍼랜드 없는 명령어 (예: aaa, cpuid)

    tag = (
        f"combo_id={row['combo_id']} row_id={row['row_id']} "
        f"combo_index={row['combo_index']} mnemonic={row['mnemonic']} "
        f"expected_valid={row['expected_valid']} mode_support={row['mode_support']}"
    )
    if row["cpuid_flag"]:
        tag += f" cpuid={row['cpuid_flag']}"
    if row["note"]:
        tag += f" note={row['note']}"

    return f"{code}  # {tag}"


def write_asm(rows, skipped, out_path):
    """어셈블리 줄 리스트를 out/tests.s 로 쓴다."""
    lines = []
    lines.append("# out/tests.s - Stage 4 generator 산출물 (자동 생성 파일, 직접 수정 금지)")
    lines.append("# 생성: pipeline/m4_generate.py  (입력: data/db/combos.csv)")
    lines.append("# 각 줄 끝 주석으로 combos.csv 원본 행(combo_id/row_id)을 역추적할 수 있다.")
    for row_id, reason in SKIP_ROW_IDS.items():
        lines.append(f"# 스킵: row_id={row_id} - {reason}")
    lines.append(".intel_syntax noprefix")
    lines.append("")
    lines.append(f"{JUMP_TARGET_LABEL}:  # rel8/rel16/rel32 오퍼랜드(CALL/Jcc/LOOP/XBEGIN 등)가 참조하는 더미 라벨")
    lines.append("")

    for row in rows:
        lines.append(build_line(row))

    with open(out_path, "w", encoding="utf-8", newline="\n") as f:
        f.write("\n".join(lines) + "\n")


def write_skip_log(skipped_rows, out_path):
    """스킵한 combos.csv 행을 이유와 함께 별도 CSV로 남긴다."""
    with open(out_path, "w", encoding="utf-8", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(["combo_id", "row_id", "mnemonic", "operands", "reason"])
        for row, reason in skipped_rows:
            writer.writerow([row["combo_id"], row["row_id"], row["mnemonic"], row["operands"], reason])


def main():
    all_rows = read_combos(IN_CSV)

    kept_rows = []
    skipped_rows = []
    for row in all_rows:
        if row["row_id"] in SKIP_ROW_IDS:
            skipped_rows.append((row, SKIP_ROW_IDS[row["row_id"]]))
            continue
        kept_rows.append(row)

    write_asm(kept_rows, skipped_rows, OUT_ASM)
    write_skip_log(skipped_rows, OUT_SKIPPED)

    print(f"입력 combos.csv 행 수: {len(all_rows)}")
    print(f"생성한 어셈블리 줄 수: {len(kept_rows)}")
    print(f"스킵한 행 수: {len(skipped_rows)}")
    print(f"출력: {OUT_ASM}, {OUT_SKIPPED}")


if __name__ == "__main__":
    main()

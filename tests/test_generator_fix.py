"""생성기 수정 라운드(2026-09-19)의 회귀 검증.

이 파일은 코드를 고치기 **전에** 먼저 넣는다. 역할은 두 가지다.

1. 불변조건: 수정 뒤에도 절대 깨지면 안 되는 것들을 지금 고정한다.
   - combo_id <-> (row_id, combo_index) 대응 유지
   - 재심 판정(`pipeline/review_verdicts.py`)이 고정한 소스 문자열 유지
   - combo_index 0 의 값이 바뀐다면 "이번 라운드에서 의도한 변경 유형"이어야 한다
2. 기대값: `tests/expectations/generator_fix_expectations.csv` 의 before/after 가
   실제 as 에서 기록된 대로 동작하는지 그 자리에서 다시 확인한다.

기대값 표 자체는 `scripts/build_fix_expectations.py` 가 도구 실행 결과로 만든다.
as 가 없는 환경(Windows)에서는 도구를 쓰는 테스트만 건너뛴다.
"""

import csv
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from pipeline.review_verdicts import REVIEW

BASELINE = ROOT / "tests/baseline/combos_2026-09-15.csv"
EXPECTATIONS = ROOT / "tests/expectations/generator_fix_expectations.csv"
COMBOS = ROOT / "data/db/combos.csv"
LEGACY_COMBOS = ROOT / 'out/generator_audit_2026-09-28/legacy_combos.csv'


def historical_combos():
    """The 2026-09-19 policy belongs to its frozen source revision, not new IDs."""
    rows = read_csv(COMBOS)
    if rows and rows[0].get('generator_revision'):
        if not LEGACY_COMBOS.exists():
            raise AssertionError('Historical snapshot missing: run scripts/audit_generator.py before replacing the default combos')
        return read_csv(LEGACY_COMBOS)
    return rows

ASM_HEADER = ".intel_syntax noprefix\n.Ltarget:\n"

# m3/m4 수정이 반영되면 True 로 바꾼다. 그 전까지 "수정 후 기대값" 검사는 건너뛴다.
FIX_LANDED = True

HAVE_AS = shutil.which("as") is not None


def read_csv(path):
    with open(path, newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))


def assemble(code):
    """한 줄을 as 에 넣고 accepted/rejected 를 돌려준다."""
    with tempfile.TemporaryDirectory(prefix="fixtest_") as tmp:
        src = Path(tmp) / "line.s"
        obj = Path(tmp) / "line.o"
        src.write_text(ASM_HEADER + code + "\n", encoding="utf-8", newline="\n")
        done = subprocess.run(["as", "--64", "-mintel64", "-o", str(obj), str(src)],
                              capture_output=True, text=True)
    return "accepted" if done.returncode == 0 else "rejected"


def operand_list(text):
    """오퍼랜드 문자열을 쉼표 단위 리스트로 나눈다."""
    return [part.strip() for part in text.split(",") if part.strip()]


# 이번 라운드에서 의도한 교정 다섯 가지. 각각 "before 를 after 쪽으로 한 걸음 옮기는" 함수다.
# 한 combo 가 두 가지 교정을 동시에 겪는 경우가 있어서(예: MOVDIR64B 는 폭 교정 + 크기 지시자
# 제거), 하나씩 보지 않고 조합으로 도달 가능한지를 본다.
WIDEN = {"cx": "ecx", "ecx": "rcx", "cl": "ecx", "ax": "eax", "eax": "rax"}


def _drop_size_prefix(text):
    """고정 크기 블록에 잘못 붙은 크기 지시자 제거."""
    return [text.replace(f"{kw} ", "") for kw in ("zmmword ptr", "xmmword ptr")
            if f"{kw} " in text]


def _drop_operand(text):
    """암묵 오퍼랜드 제거(뒤에서부터 한 자리씩)."""
    ops = operand_list(text)
    return [", ".join(ops[:-1])] if len(ops) > 1 else []


def _widen_register(text):
    """레지스터 폭 교정 (cx -> ecx -> rcx)."""
    out = []
    ops = operand_list(text)
    for i, op in enumerate(ops):
        if op in WIDEN:
            out.append(", ".join(ops[:i] + [WIDEN[op]] + ops[i + 1:]))
    return out


def _fix_raw_notation(text):
    """매뉴얼 표기 정리 (k1+1 -> k1 등)."""
    out = []
    for raw, fixed in (("k1+1", "k1"), ("zmm2+3", "zmm2"), ("xmm2+3", "xmm2"), ("imm8/r", "1")):
        if raw in text:
            out.append(text.replace(raw, fixed))
    return out


def _fix_moffs(text):
    """moffs 를 절대 주소 형태로 교정."""
    return [re.sub(r"\[0x1000\]", "ds:0x123456789abcdef0", text)] if "[0x1000]" in text else []


ACCUMULATOR_MEM = {"al": "byte ptr [rsi]", "ax": "word ptr [rsi]",
                   "eax": "dword ptr [rsi]", "rax": "qword ptr [rsi]"}


def _string_accumulator(text):
    """SDM 의 누산기 표기(REP LODS AL)를 as 가 요구하는 메모리 표기로."""
    ops = operand_list(text)
    if len(ops) == 1 and ops[0] in ACCUMULATOR_MEM:
        return [ACCUMULATOR_MEM[ops[0]]]
    return []


TRANSFORMS = [_drop_size_prefix, _drop_operand, _widen_register, _fix_raw_notation,
              _fix_moffs, _string_accumulator]


def is_expected_change(before, after, depth=3):
    """before 에서 의도한 교정만 적용해 after 에 도달할 수 있으면 True.

    도달하지 못하는 변경은 이번 라운드에서 의도하지 않은 것이므로 테스트가 실패한다.
    """
    seen = {before}
    frontier = [before]
    for _ in range(depth):
        nxt = []
        for text in frontier:
            for transform in TRANSFORMS:
                for candidate in transform(text):
                    if candidate == after:
                        return True
                    if candidate not in seen:
                        seen.add(candidate)
                        nxt.append(candidate)
        frontier = nxt
    return False


class ComboIdStability(unittest.TestCase):
    """기존 판정·체크리스트가 combo_id 로 과거 결과를 참조하므로 ID 대응을 고정한다."""

    def setUp(self):
        self.baseline = read_csv(BASELINE)
        self.current = historical_combos()

    def test_baseline_ids_are_unique(self):
        keys = [(r["row_id"], r["combo_index"]) for r in self.baseline]
        self.assertEqual(len(keys), len(set(keys)))
        ids = [r["combo_id"] for r in self.baseline]
        self.assertEqual(len(ids), len(set(ids)))
        self.assertEqual(len(self.baseline), 7278)

    def test_existing_combo_ids_keep_their_slot(self):
        current = {(r["row_id"], r["combo_index"]): r["combo_id"] for r in self.current}
        moved = [(k, v, current.get(k)) for k, v in
                 ((( r["row_id"], r["combo_index"]), r["combo_id"]) for r in self.baseline)
                 if current.get(k) != v]
        self.assertEqual(moved, [], f"combo_id 대응이 바뀐 슬롯 {len(moved)}개: {moved[:5]}")

    def test_no_baseline_combo_disappears(self):
        current_ids = {r["combo_id"] for r in self.current}
        missing = sorted({r["combo_id"] for r in self.baseline} - current_ids, key=int)
        self.assertEqual(missing, [], f"사라진 combo_id {len(missing)}개: {missing[:10]}")

    def test_changed_lines_are_intended_kinds(self):
        """index 0 의 값이 바뀌었다면 이번 라운드에서 의도한 변경 유형이어야 한다."""
        current = {(r["row_id"], r["combo_index"]): r["operands"] for r in self.current}
        unexpected = []
        for row in self.baseline:
            key = (row["row_id"], row["combo_index"])
            after = current.get(key)
            if after is None or after == row["operands"]:
                continue
            if not is_expected_change(row["operands"], after):
                unexpected.append((row["combo_id"], row["operands"], after))
        self.assertEqual(unexpected, [],
                         f"의도하지 않은 변경 {len(unexpected)}건: {unexpected[:5]}")


class ReviewPinnedSources(unittest.TestCase):
    """재심 판정은 combo_id 와 소스 문자열을 함께 고정한다.

    이 문자열이 바뀌면 `build_triage_rows()` 가 ValueError 로 파이프라인을 멈춘다
    (pipeline/review_verdicts.py). 그래서 수정 대상에서 반드시 제외해야 한다.
    """

    def test_pinned_combo_sources_unchanged(self):
        current = {r["combo_id"]: f"{r['mnemonic'].lower()} {r['operands']}".strip()
                   for r in read_csv(COMBOS)}
        for combo_id, case in REVIEW.items():
            expected_source = case[0]
            self.assertEqual(current.get(combo_id, "").replace(" ", ""),
                             expected_source.replace(" ", ""),
                             f"재심 고정 사례 combo {combo_id} 의 소스가 바뀌었다")


class ExpectationTable(unittest.TestCase):
    """기대값 표의 before/after 가 지금 도구에서도 기록대로인지 다시 확인한다."""

    def setUp(self):
        self.rows = read_csv(EXPECTATIONS)

    def test_table_shape(self):
        self.assertTrue(self.rows)
        kinds = {r["kind"] for r in self.rows}
        self.assertLessEqual(kinds, {"fix", "keep", "variant"})
        for row in self.rows:
            self.assertTrue(row["근거"], f"{row['base_combo_id']} 에 근거가 없다")
            if row["kind"] == "fix":
                self.assertNotEqual(row["before"], row["after"])

    def test_fix_targets_are_manual_valid_rows(self):
        """고치기로 한 행은 매뉴얼이 64비트 Valid 로 규정한 행이어야 한다.

        Invalid/N.E./N.S. 행에서 as 가 거부하는 것은 기대와 일치하는 결과이므로
        생성 값을 바꿔서 '통과'시키면 안 된다.
        """
        for row in self.rows:
            if row["kind"] == "fix":
                self.assertEqual(row["mode_support"], "Valid", row["base_combo_id"])
            if row["kind"] == "keep":
                self.assertIn(row["mode_support"], {"Invalid", "N.E.", "N.S."},
                              row["base_combo_id"])

    @unittest.skipUnless(HAVE_AS, "as 없음 (Windows)")
    def test_recorded_results_still_reproduce(self):
        for row in self.rows:
            if row["before"] and row["as_before"]:
                self.assertEqual(assemble(row["before"]), row["as_before"],
                                 f"before 재현 실패: {row['before']}")
            self.assertEqual(assemble(row["after"]), row["as_after"],
                             f"after 재현 실패: {row['after']}")

    @unittest.skipUnless(HAVE_AS, "as 없음 (Windows)")
    def test_keep_rows_are_rejected_as_manual_expects(self):
        """keep 행은 매뉴얼이 무효로 본 행이므로 거부가 유지돼야 한다.

        예외: rel16 행은 입력으로 표현할 수 없어 as 가 다른 인코딩으로 수용한다.
        이 사실 자체를 기대값으로 고정해 둔다.
        """
        for row in self.rows:
            if row["kind"] != "keep":
                continue
            result = assemble(row["after"])
            if row["family"] == "rel16_not_targetable":
                self.assertEqual(result, "accepted")
            else:
                self.assertEqual(result, "rejected", row["after"])


@unittest.skipUnless(FIX_LANDED, "m3/m4 수정 전 - 수정 후 기대값 검사는 건너뜀")
class CombinerProducesExpected(unittest.TestCase):
    """수정이 반영되면, 생성기가 기대값 표의 after 를 실제로 만들어야 한다."""

    def test_fix_rows_match_after(self):
        current = {r["combo_id"]: r for r in historical_combos()}
        for row in read_csv(EXPECTATIONS):
            if row["kind"] != "fix":
                continue
            combo = current[row["base_combo_id"]]
            produced = f"{combo['mnemonic'].lower()} {combo['operands']}".strip()
            self.assertEqual(produced, row["after"], row["base_combo_id"])

    def test_variant_rows_exist_somewhere(self):
        produced = {f"{r['mnemonic'].lower()} {r['operands']}".strip()
                    for r in historical_combos()}
        for row in read_csv(EXPECTATIONS):
            if row["kind"] == "variant" and row["family"].startswith("variant_"):
                self.assertIn(row["after"], produced, row["family"])


if __name__ == "__main__":
    unittest.main(verbosity=2)

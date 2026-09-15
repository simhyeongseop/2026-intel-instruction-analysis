#!/usr/bin/env bash
# Ubuntu/Linux 검증용 단일 실행기.
set -uo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
PYTHON_BIN="${PYTHON:-python3}"
STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
RUN_DIR="$ROOT/out/ubuntu-tests/$STAMP"
mkdir -p "$RUN_DIR"
cd "$ROOT"

run_unit=1
run_review=1
run_execute=1
run_lint=1
run_cli=1

usage() {
    cat <<'EOF'
Usage: bash scripts/run_ubuntu_tests.sh [options]

Runs the remaining Linux checks against the current saved pipeline data:
  - Python regression tests (including live GNU as/Clang tests)
  - asm_linter CLI smoke test
  - fixed review cases and CPU boundary experiment
  - pipeline stages 11-12 with --execute
  - pipeline stage 13 full lint (7,283 cases)

Options:
  --skip-review    Do not run scripts/review_cases.py
  --skip-execute   Do not run pipeline stages 11-12
  --skip-lint      Do not run the full stage 13 lint
  --skip-cli       Do not run the CLI smoke test
  --skip-unit      Do not run unittest
  -h, --help       Show this help

Each step keeps its log under out/ubuntu-tests/<UTC timestamp>/.
Exit status is 0 only when every selected step and artifact check succeeds.
EOF
}

while (($#)); do
    case "$1" in
        --skip-review)  run_review=0 ;;
        --skip-execute) run_execute=0 ;;
        --skip-lint)    run_lint=0 ;;
        --skip-cli)     run_cli=0 ;;
        --skip-unit)    run_unit=0 ;;
        -h|--help)      usage; exit 0 ;;
        *) echo "Unknown option: $1" >&2; usage >&2; exit 2 ;;
    esac
    shift
done

failures=0
step_names=()
step_codes=()
last_rc=0

run_step() {
    local name="$1"
    shift
    local log="$RUN_DIR/$name.log"
    step_names+=("$name")
    echo
    echo "=== $name ==="
    echo "command: $*"
    # 진행률을 화면에 즉시 보여주면서 같은 내용을 단계별 로그에도 보존한다.
    # pipefail을 켜 두었으므로 PIPESTATUS[0]이 실제 명령의 종료 코드다.
    "$@" 2>&1 | tee "$log"
    last_rc=${PIPESTATUS[0]}
    step_codes+=("$last_rc")
    if [[ $last_rc -eq 0 ]]; then
        echo "[$name] PASS"
    else
        echo "[$name] FAIL (exit $last_rc)"
        failures=$((failures + 1))
    fi
}

check_artifact() {
    local name="$1"
    shift
    run_step "$name" "$@"
}

echo "Intel Instruction Analysis - Ubuntu test run"
echo "root: $ROOT"
echo "run:  $RUN_DIR"
echo "python: $PYTHON_BIN"

missing=0
for tool in "$PYTHON_BIN" as objdump objcopy readelf clang ld; do
    if command -v "$tool" >/dev/null 2>&1; then
        printf 'found %-8s %s\n' "$tool" "$(command -v "$tool")"
    else
        echo "missing required tool: $tool" >&2
        missing=1
    fi
done
if [[ $missing -ne 0 ]]; then
    echo "Install the missing Ubuntu packages (typically binutils, clang, and python3) and rerun." >&2
    exit 2
fi

if ! "$PYTHON_BIN" - <<'PY'
import sys
raise SystemExit(0 if sys.version_info >= (3, 10) else 1)
PY
then
    echo "Python 3.10 or newer is required." >&2
    exit 2
fi

required_files=(
    intel_manual.pdf
    data/db/isa_db.csv
    data/db/tokens.csv
    data/db/combos.csv
    data/cases.csv
    out/asm_result.csv
    out/roundtrip.csv
)
for path in "${required_files[@]}"; do
    if [[ ! -f "$ROOT/$path" ]]; then
        echo "missing required project file: $path" >&2
        missing=1
    fi
done
if [[ $missing -ne 0 ]]; then
    echo "The current saved pipeline data is incomplete; rerun the earlier stages first." >&2
    exit 2
fi

if [[ $run_unit -eq 1 ]]; then
    run_step unit_tests "$PYTHON_BIN" -m unittest discover -s tests -p 'test_*.py' -v
fi

if [[ $run_cli -eq 1 ]]; then
    run_step cli_smoke "$PYTHON_BIN" scripts/asm_linter.py --format json \
        --output "$RUN_DIR/cli_smoke.json" 'mov eax, ebx'
    if [[ $last_rc -eq 0 ]]; then
        check_artifact cli_output_check "$PYTHON_BIN" - "$RUN_DIR/cli_smoke.json" <<'PY'
import csv
import json
import sys
with open(sys.argv[1], encoding='utf-8') as stream:
    report = json.load(stream)
if report.get('counts') != {'accepted': 1} or report.get('exit_code') != 0:
    raise SystemExit('unexpected CLI smoke result: %r' % report)
PY
    fi
fi

if [[ $run_review -eq 1 ]]; then
    run_step review_cases "$PYTHON_BIN" scripts/review_cases.py
fi

if [[ $run_execute -eq 1 ]]; then
    run_step execute_cpu "$PYTHON_BIN" pipeline/run.py execute --until execute_edge_cases --execute
    if [[ $last_rc -eq 0 ]]; then
        check_artifact execute_outputs_check "$PYTHON_BIN" - \
            "$ROOT/out/address_test_result.csv" "$ROOT/out/edge_case_execution.csv" <<'PY'
import csv
import sys
address, edge = sys.argv[1:]
with open(address, encoding='utf-8') as stream:
    rows = list(csv.DictReader(stream))
if not rows or any(row.get('match', '').strip().lower() != 'true' for row in rows):
    raise SystemExit('stage 11 has no rows or contains an expectation mismatch')
with open(edge, encoding='utf-8') as stream:
    edge_rows = list(csv.DictReader(stream))
if not edge_rows:
    raise SystemExit('stage 12 produced no edge-case rows')
for row in edge_rows:
    outcome = row.get('outcome', '')
    if outcome.endswith('_error') or outcome.endswith('_timeout') or outcome == 'timeout_hang':
        raise SystemExit('stage 12 tool failure: %r' % row)
print('stage 11 rows:', len(rows), 'stage 12 rows:', len(edge_rows))
PY
    fi
fi

if [[ $run_lint -eq 1 ]]; then
    # run.py는 하위 단계 출력을 모아 실행이 끝난 뒤 출력한다. 진행률을 보장하기 위해
    # 이 배치 스크립트에서는 13단계 모듈을 직접 호출한다(결과 manifest는 동일하게 생성됨).
    run_step lint "$PYTHON_BIN" pipeline/m13_lint.py
    if [[ $last_rc -eq 0 ]]; then
        check_artifact lint_manifest_check "$PYTHON_BIN" - "$ROOT/out/lint/manifest.json" <<'PY'
import csv
import json
import sys
with open(sys.argv[1], encoding='utf-8') as stream:
    manifest = json.load(stream)
if manifest.get('truncated') or manifest.get('tool_error'):
    raise SystemExit('lint manifest is truncated or has a tool error')
with open('out/asm_result.csv', encoding='utf-8') as stream:
    expected_generated = sum(1 for _ in csv.DictReader(stream))
with open('data/cases.csv', encoding='utf-8') as stream:
    expected_supplemental = sum(1 for _ in csv.DictReader(stream))
if (manifest.get('generated_cases') != expected_generated or
        manifest.get('supplemental_cases') != expected_supplemental):
    raise SystemExit('unexpected lint case counts: %r' % manifest)
counts = manifest.get('status_counts', {})
allowed = {'accepted', 'needs_review', 'rejected', 'incomplete', 'process_crash',
           'timeout', 'unavailable', 'resource_failure', 'tool_failed'}
if set(counts) - allowed or sum(counts.values()) != expected_generated + expected_supplemental:
    raise SystemExit('unexpected lint status counts: %r' % counts)
print('lint manifest verified:', counts)
PY
    fi
fi

summary="$RUN_DIR/summary.txt"
{
    echo "Intel Instruction Analysis Ubuntu test summary"
    echo "created_utc=$STAMP"
    echo "root=$ROOT"
    echo "run_dir=$RUN_DIR"
    echo "failures=$failures"
    for i in "${!step_names[@]}"; do
        echo "${step_names[$i]}=${step_codes[$i]}"
    done
} >"$summary"

echo
cat "$summary"
if [[ $failures -eq 0 ]]; then
    echo "ALL SELECTED TESTS PASSED"
    exit 0
fi
echo "TESTS FAILED: $failures step(s)" >&2
exit 1

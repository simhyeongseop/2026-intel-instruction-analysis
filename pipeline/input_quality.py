"""Stage 1/2 extraction quality checks.

The extractor output is evidence.  Normalization therefore never replaces the
raw value in the audit fields, and suspicious rows remain visible instead of
being guessed into a valid instruction form.
"""

from __future__ import annotations

import csv
import re
from pathlib import Path


ISSUE_COLUMNS = [
    "row_id", "token_row_id", "rule", "raw_value", "normalized_value",
    "reason", "disposition",
]

TOKEN_REQUIRED_COLUMNS = {
    "raw_operand_token", "normalized_operand_token", "validation_status",
    "validation_codes",
}

VALID_MEMORY_WIDTHS = {8, 16, 32, 64, 80, 128, 256, 512}
UNICODE_DASHES = {"\u2013": "-", "\u2014": "-", "\u2212": "-"}
COMPOSITE_MEMORY_WIDTH_RE = re.compile(r"(?<=/)m(\d+)(?![/\d])", re.IGNORECASE)
DOT_BEFORE_MEMORY_RE = re.compile(r"/\s*\.\s*m(?=\d)", re.IGNORECASE)
MISSING_IMPLICIT_DELIMITER_RE = re.compile(r"^(.*?)\s+(<[^>]+>)$")

# These are narrow corrections for already reviewed extraction artifacts.  The
# raw spelling remains in tokens.csv and extraction_issues.csv.  New spellings
# never inherit these exceptions merely because they look similar.
KNOWN_OPERAND_CORRECTIONS = {
    ("LAR", "651", "r32, r64/m161"): ("r32, r64/m16", "", "known_footnote_digit"),
    ("VPAND", "923", "ymm1, ymm2, ymm3/.m256"): (
        "ymm1, ymm2, ymm3/m256", "", "known_dot_before_memory"),
    ("ENCODEKEY256", "403", "r32, r32 <XMM0-6>"): (
        "r32, r32", "<XMM0-6>", "known_implicit_annotation"),
}


def normalize_operand_text(value: str) -> str:
    """Apply syntax-preserving textual normalization."""
    normalized = value or ""
    for old, new in UNICODE_DASHES.items():
        normalized = normalized.replace(old, new)
    normalized = re.sub(r"\s+", " ", normalized).strip()
    normalized = re.sub(r"\s*,\s*", ", ", normalized)
    normalized = re.sub(r"\s*/\s*", "/", normalized)
    return normalized


def issue(row_id, token_row_id, rule, raw, normalized, reason,
          disposition="extraction_suspect"):
    return {
        "row_id": str(row_id),
        "token_row_id": str(token_row_id),
        "rule": rule,
        "raw_value": raw,
        "normalized_value": normalized,
        "reason": reason,
        "disposition": disposition,
    }


def validate_operand_token(raw_value: str, row_id="", token_row_id=""):
    """Return normalized text, validation status/codes, and issue records."""
    normalized = normalize_operand_text(raw_value)
    issues = []
    if any(mark in (raw_value or "") for mark in UNICODE_DASHES):
        issues.append(issue(
            row_id, token_row_id, "unicode_dash_normalized", raw_value, normalized,
            "Unicode dash was normalized to the ASCII spelling used by the parser.",
            disposition="normalized",
        ))
    if DOT_BEFORE_MEMORY_RE.search(normalized):
        issues.append(issue(
            row_id, token_row_id, "unexpected_dot_before_memory", raw_value,
            DOT_BEFORE_MEMORY_RE.sub("/m", normalized),
            "A dot between '/' and a memory operand is not an SDM operand separator.",
        ))
    for match in COMPOSITE_MEMORY_WIDTH_RE.finditer(normalized):
        width = int(match.group(1))
        if width not in VALID_MEMORY_WIDTHS:
            issues.append(issue(
                row_id, token_row_id, "invalid_composite_memory_width", raw_value,
                normalized,
                f"Composite memory width m{width} is outside the supported SDM widths.",
            ))

    blocking = [item for item in issues if item["disposition"] == "extraction_suspect"]
    if blocking:
        status = "extraction_suspect"
    elif issues:
        status = "normalized"
    else:
        status = "valid"
    return {
        "raw": raw_value,
        "normalized": normalized,
        "validation_status": status,
        "validation_codes": ";".join(item["rule"] for item in issues),
        "issues": issues,
    }


def validate_operand_list(raw_operands: str, row_id=""):
    """Detect a likely missing comma before an angle-bracket implicit operand."""
    issues = []
    for part in (raw_operands or "").split(","):
        candidate = part.strip()
        match = MISSING_IMPLICIT_DELIMITER_RE.match(candidate)
        if match and match.group(1).strip() and not match.group(1).strip().startswith(("REP ", "REPE ", "REPNE ")):
            issues.append(issue(
                row_id, "", "missing_operand_delimiter", candidate, candidate,
                "A normal operand and an angle-bracket implicit operand share one comma field.",
            ))
    return issues


def apply_known_operand_correction(mnemonic: str, source_page, raw_operands: str, row_id=""):
    key = (mnemonic, str(source_page), raw_operands)
    correction = KNOWN_OPERAND_CORRECTIONS.get(key)
    if not correction:
        return raw_operands, "", []
    normalized, implicit, rule = correction
    return normalized, implicit, [issue(
        row_id, "", rule, raw_operands, normalized,
        "Evidence-backed correction for a previously reviewed extraction artifact.",
        disposition="known_issue",
    )]


def compare_extraction_text(table_text: str, character_text: str, row_id=""):
    """Preserve disagreement between table-mode and character-mode extraction."""
    left = normalize_operand_text(table_text)
    right = normalize_operand_text(character_text)
    if table_text == character_text:
        return []
    return [issue(
        row_id, "", "dual_extraction_mismatch", table_text, left,
        f"Character-mode extraction differs: {character_text!r}; normalized={right!r}",
    )]


def write_issues(path, issues):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=ISSUE_COLUMNS)
        writer.writeheader()
        writer.writerows(issues)


def blocking_issues(issues):
    return [item for item in issues if item.get("disposition") == "extraction_suspect"]


def gate_exit_code(issues):
    return 2 if blocking_issues(issues) else 0


def require_validated_tokens(rows):
    """Reject stale tokens.csv files that predate the R0 contract."""
    if not rows:
        raise ValueError("tokens.csv is empty")
    missing = TOKEN_REQUIRED_COLUMNS - set(rows[0])
    if missing:
        raise ValueError("tokens.csv is missing R0 columns: " + ", ".join(sorted(missing)))
    suspect = [row for row in rows if row.get("validation_status") == "extraction_suspect"]
    if suspect:
        raise ValueError(f"tokens.csv contains {len(suspect)} extraction_suspect rows")

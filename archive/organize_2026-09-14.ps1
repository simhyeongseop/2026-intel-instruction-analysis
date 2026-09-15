# 현재 코드에서 참조하지 않는 구 파이프라인을 원래 상대 구조대로 보관한다.
# 파일의 원래 위치와 SHA-256을 이동 전후에 기록/검사한다. 재실행 시 이미 옮긴 항목은 건너뛴다.
$ErrorActionPreference = 'Stop'
$projectRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$prefix = $projectRoot.TrimEnd('\') + '\'
$targets = @(
    'src', 'experiments', 'data/instruction_db', 'data/stage1_extracted',
    'data/stage2_opcode_split', 'data/stage3_operands', 'data/stage4_tests',
    'data/stage5_disassembly', 'data/stage6_differential',
    'scripts/analyze_axisA.py', 'scripts/analyze_patterns.py', 'scripts/compare_toc_forms.py',
    'scripts/generate_instruction_features.py', 'scripts/run_stage4_mapping_pass.sh',
    'scripts/step1_analyze.py', 'scripts/verify_descriptions.py', 'scripts/verify_results.py',
    'docs/DB_COVERAGE_DIAGNOSIS_2026-07-01.md', 'docs/INTERIM_REPORT_2026-05-29.md',
    'docs/INTERIM_REPORT_STAGE4_MAPPING_AND_EQUIVALENCE_2026-05-29.md',
    'docs/PIPELINE_REBUILD_SUMMARY.md', 'docs/RESEARCH_OVERVIEW.md',
    'docs/STAGE3_DESIGN_GUIDELINES.md', 'docs/STAGE4_ERROR_REPORT.md',
    'docs/STAGE6_DIFFERENTIAL_FINDINGS.md', 'docs/STAGE6_ROOTCAUSE.md',
    'docs/stage5_disassembly_validation.md', 'docs/stage5_equivalence_classification_rules.md',
    'docs/stage5_roundtrip_report.md'
)
$moves = @()
foreach ($relative in $targets) {
    $source = [IO.Path]::GetFullPath((Join-Path $projectRoot $relative))
    $destination = [IO.Path]::GetFullPath((Join-Path $projectRoot ('archive/legacy/' + $relative)))
    if (-not $source.StartsWith($prefix, [StringComparison]::OrdinalIgnoreCase) -or
        -not $destination.StartsWith($prefix, [StringComparison]::OrdinalIgnoreCase)) { throw 'Workspace boundary violation' }
    if (-not (Test-Path -LiteralPath $source)) { continue }
    if (Test-Path -LiteralPath $destination) { throw "Destination already exists: $destination" }
    $moves += [pscustomobject]@{Source=$source; Destination=$destination}
}
$records = @()
foreach ($move in $moves) {
    $item = Get-Item -LiteralPath $move.Source
    $files = if ($item.PSIsContainer) { @(Get-ChildItem -LiteralPath $move.Source -File -Recurse -Force) } else { @($item) }
    foreach ($file in $files) {
        $rel = $file.FullName.Substring($prefix.Length).Replace('\','/')
        $records += [pscustomobject]@{Original=$rel; Archived=('archive/legacy/' + $rel); SHA256=(Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash}
    }
}
foreach ($move in $moves) {
    $parent = Split-Path -Parent $move.Destination
    if (-not (Test-Path -LiteralPath $parent)) { New-Item -ItemType Directory -Path $parent | Out-Null }
    Move-Item -LiteralPath $move.Source -Destination $move.Destination
}
foreach ($record in $records) {
    $hash = (Get-FileHash -LiteralPath (Join-Path $projectRoot $record.Archived) -Algorithm SHA256).Hash
    if ($hash -ne $record.SHA256) { throw "Hash mismatch: $($record.Archived)" }
}
if ($records.Count) {
    $records | Export-Csv -LiteralPath (Join-Path $projectRoot 'archive/MOVED_FILES.csv') -Encoding UTF8 -NoTypeInformation
}
Write-Output "Archived $($records.Count) files; all hashes verified."

# Validates every FormuLang conformance test file against tests/schema.json.
# Also checks that every case identifier is unique.
# Usage: pwsh tests/validate.ps1
# Requires PowerShell 7.2+ (Test-Json -SchemaFile).

$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
$schema = Join-Path $root 'schema.json'
$failed = 0
$ids = @{}

$files = Get-ChildItem -Path $root -Recurse -Filter '*.json' | Where-Object { $_.FullName -ne $schema }

foreach ($file in $files) {
    $relative = [IO.Path]::GetRelativePath($root, $file.FullName)
    $json = Get-Content -Path $file.FullName -Raw -Encoding utf8

    $valid = $false
    try {
        $valid = Test-Json -Json $json -SchemaFile $schema -ErrorAction Stop
    } catch {
        Write-Host "FAIL  $relative" -ForegroundColor Red
        Write-Host "      $($_.Exception.Message)"
        $failed++
        continue
    }

    if (-not $valid) {
        Write-Host "FAIL  $relative" -ForegroundColor Red
        $failed++
        continue
    }

    $cases = ($json | ConvertFrom-Json).cases
    foreach ($case in $cases) {
        if ($ids.ContainsKey($case.id)) {
            Write-Host "FAIL  $relative - duplicate id $($case.id) (also in $($ids[$case.id]))" -ForegroundColor Red
            $failed++
        } else {
            $ids[$case.id] = $relative
        }
    }

    Write-Host "ok    $relative ($($cases.Count) cases)"
}

Write-Host ''
Write-Host "$($files.Count) files, $($ids.Count) cases, $failed problems"
if ($failed -gt 0) { exit 1 }

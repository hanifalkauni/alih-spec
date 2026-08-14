# AlihSpec Framework Integrity Validator — Windows PowerShell
# Memvalidasi kelengkapan spesifikasi, tugas, dan link internal
#
# Usage:
#   .\scripts\sdd-validate.ps1

Write-Host ""
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "   AlihSpec - Framework Integrity Validation" -ForegroundColor Cyan
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host ""

$errors = 0
$warnings = 0

# 1. Check Core Files
Write-Host "1. Checking Core Files..." -ForegroundColor Yellow
$coreFiles = @(
    "README.md",
    "AGENTS.md",
    ".sdd\config.yaml",
    ".sdd\mapping\patterns.md",
    "context\AGENTS.md",
    "context\conventions.md",
    "context\glossary.md",
    "context\tech-stack.md",
    "context\RULES.md",
    "context\qa-checklist.md",
    "specs\overview.md",
    "specs\architecture.md",
    "specs\data-models\schema.md",
    "specs\api-contracts\openapi.yaml",
    "tasks\_index.md"
)

foreach ($file in $coreFiles) {
    if (Test-Path $file) {
        Write-Host "  [OK] $file" -ForegroundColor Green
    } else {
        Write-Host "  [MISSING] $file" -ForegroundColor Red
        $errors++
    }
}

# 2. Check Broken Markdown Links
Write-Host ""
Write-Host "2. Scanning for Broken Links across all *.md files..." -ForegroundColor Yellow
$mdFiles = Get-ChildItem -Recurse -Filter *.md | Where-Object { $_.FullName -notmatch '\\(scratch|output|source)\\' }

$brokenCount = 0
foreach ($f in $mdFiles) {
    $content = Get-Content $f.FullName -Raw -Encoding utf8
    $pattern = '\[([^\]]+)\]\(([^)]+)\)'
    [regex]::Matches($content, $pattern) | ForEach-Object {
        $link = $_.Groups[2].Value
        if ($link.StartsWith('http') -or $link.StartsWith('#') -or $link.StartsWith('mailto') -or $link.StartsWith('file:')) {
            return
        }
        $cleanLink = ($link -split '#')[0]
        if ([string]::IsNullOrWhiteSpace($cleanLink)) { return }
        $resolved = Join-Path (Split-Path $f.FullName) $cleanLink
        if (-not (Test-Path $resolved)) {
            $fPath = $f.FullName
            Write-Host "  [BROKEN LINK] In $fPath : $link" -ForegroundColor Red
            $brokenCount++
            $errors++
        }
    }
}

if ($brokenCount -eq 0) {
    Write-Host "  [OK] All markdown links are valid! (0 broken links)" -ForegroundColor Green
}

# 3. Check Spec to Task Coverage
Write-Host ""
Write-Host "3. Checking Spec-to-Task Coverage..." -ForegroundColor Yellow
$specs = Get-ChildItem -Path "specs\modules" -Filter *.md | Where-Object { $_.Name -ne "_template.md" }
$taskIndexContent = Get-Content "tasks\_index.md" -Raw -Encoding utf8

foreach ($s in $specs) {
    $moduleName = $s.BaseName
    $sName = $s.Name
    if ($taskIndexContent -match $moduleName) {
        Write-Host "  [OK] Spec $sName has matching task entry in tasks/_index.md" -ForegroundColor Green
    } else {
        Write-Host "  [WARNING] Spec $sName might not have a task in tasks/_index.md" -ForegroundColor Yellow
        $warnings++
    }
}

# Summary
Write-Host ""
Write-Host "===================================================" -ForegroundColor Cyan
if ($errors -eq 0 -and $warnings -eq 0) {
    Write-Host "   RESULT: Framework 100% VALID AND HEALTHY! (0 errors, 0 warnings)" -ForegroundColor Green
} elseif ($errors -eq 0) {
    Write-Host "   RESULT: VALID with warnings." -ForegroundColor Yellow
} else {
    Write-Host "   RESULT: FAILED with errors." -ForegroundColor Red
}
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host ""

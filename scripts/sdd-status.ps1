# AlihSpec Status Script — Windows PowerShell
# Menampilkan dashboard progress konversi secara instan
#
# Usage:
#   .\scripts\sdd-status.ps1

$indexPath = "tasks\_index.md"
if (-not (Test-Path $indexPath)) {
    Write-Host "File $indexPath tidak ditemukan. Pastikan berada di root direktori project." -ForegroundColor Red
    exit 1
}

$lines = Get-Content $indexPath -Encoding utf8

$doneCount = 0
$inProgressCount = 0
$notStartedCount = 0
$blockedCount = 0

$tasks = @()
$currentPhase = "General"

foreach ($line in $lines) {
    if ($line -match '^##\s+Phase\s+(.+)$') {
        $currentPhase = $matches[1]
    }
    if ($line -match '^\s*-\s*\[(.)\]\s+\[([^\]]+)\]\(([^)]+)\)\s*(?:[-—])?\s*(.*)$') {
        $status = $matches[1]
        $fileName = $matches[2]
        $fileLink = $matches[3]
        $taskDesc = ($matches[4] -replace '^[\s\-—–]+', '').Trim()

        $statusText = "Not Started"
        if ($status -eq "x") {
            $statusText = "Done"
            $doneCount++
        } elseif ($status -eq "/") {
            $statusText = "In Progress"
            $inProgressCount++
        } elseif ($status -eq "!") {
            $statusText = "Blocked"
            $blockedCount++
        } else {
            $notStartedCount++
        }

        $tasks += [PSCustomObject]@{
            Phase = $currentPhase
            Status = $statusText
            StatusCode = $status
            File = $fileName
            Description = $taskDesc
        }
    }
}

$totalTasks = $tasks.Count
$percent = 0
if ($totalTasks -gt 0) {
    $percent = [math]::Round(($doneCount / $totalTasks) * 100, 1)
}

$barWidth = 25
$filledWidth = 0
if ($totalTasks -gt 0) {
    $filledWidth = [math]::Round(($doneCount / $totalTasks) * $barWidth)
}
$emptyWidth = $barWidth - $filledWidth
if ($emptyWidth -lt 0) { $emptyWidth = 0 }
$progressBar = ("=" * $filledWidth) + ("-" * $emptyWidth)

Write-Host ""
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "   AlihSpec - Conversion Progress Dashboard" -ForegroundColor Cyan
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host ""
$pctTotal = "$percent" + "%"
Write-Host "  Progress : [$progressBar] $pctTotal" -ForegroundColor Green
Write-Host "  Total    : $totalTasks tasks" -ForegroundColor White
Write-Host "  Done     : $doneCount" -ForegroundColor Green
Write-Host "  In Prog  : $inProgressCount" -ForegroundColor Yellow
Write-Host "  Pending  : $notStartedCount" -ForegroundColor Gray
if ($blockedCount -gt 0) {
    Write-Host "  Blocked  : $blockedCount" -ForegroundColor Red
}
Write-Host ""

Write-Host "Phase Breakdown:" -ForegroundColor Cyan
$grouped = $tasks | Group-Object Phase
foreach ($g in $grouped) {
    $pDone = ($g.Group | Where-Object { $_.StatusCode -eq "x" }).Count
    $pTotal = $g.Group.Count
    $pPercent = 0
    if ($pTotal -gt 0) { $pPercent = [math]::Round(($pDone / $pTotal) * 100) }
    $pName = $g.Name
    $pctItem = "$pPercent" + "%"
    Write-Host "  - $pName : $pDone/$pTotal ($pctItem)" -ForegroundColor White
}

Write-Host ""

$nextTask = $tasks | Where-Object { $_.StatusCode -eq "/" } | Select-Object -First 1
if (-not $nextTask) {
    $nextTask = $tasks | Where-Object { $_.StatusCode -eq " " } | Select-Object -First 1
}

if ($nextTask) {
    $nextFile = $nextTask.File
    $nextDesc = $nextTask.Description
    Write-Host "Next Recommended Task:" -ForegroundColor Yellow
    Write-Host "  [$nextFile] - $nextDesc" -ForegroundColor White
} elseif ($totalTasks -gt 0 -and $doneCount -eq $totalTasks) {
    Write-Host "ALL TASKS COMPLETED! Proceed to QA checklist." -ForegroundColor Green
}
Write-Host ""

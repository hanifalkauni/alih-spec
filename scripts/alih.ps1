# ⚡ AlihSpec CLI Runner — Windows PowerShell
#
# Usage:
#   .\scripts\alih.ps1 init
#   .\scripts\alih.ps1 status
#   .\scripts\alih.ps1 validate
#   .\scripts\alih.ps1 help

param (
    [Parameter(Position=0)]
    [string]$Command = "help",
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$RemainingArgs
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

switch ($Command.ToLower()) {
    "init" {
        & "$scriptDir\sdd-init.ps1" @RemainingArgs
    }
    "status" {
        & "$scriptDir\sdd-status.ps1" @RemainingArgs
    }
    "validate" {
        & "$scriptDir\sdd-validate.ps1" @RemainingArgs
    }
    Default {
        Write-Host ""
        Write-Host "===================================================" -ForegroundColor Cyan
        Write-Host "   AlihSpec CLI (alih) - Spec-Driven Conversion" -ForegroundColor Cyan
        Write-Host "===================================================" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Usage: .\scripts\alih.ps1 [command]" -ForegroundColor White
        Write-Host ""
        Write-Host "Available Commands:" -ForegroundColor Yellow
        Write-Host "  init      Inisialisasi proyek baru dan pasang preset" -ForegroundColor White
        Write-Host "  status    Tampilkan dashboard progres konversi secara live" -ForegroundColor White
        Write-Host "  validate  Uji integritas framework, broken link, dan coverage task" -ForegroundColor White
        Write-Host "  help      Tampilkan panduan ini" -ForegroundColor White
        Write-Host ""
        Write-Host "Contoh:" -ForegroundColor Gray
        Write-Host "  .\scripts\alih.ps1 status" -ForegroundColor Gray
        Write-Host ""
    }
}

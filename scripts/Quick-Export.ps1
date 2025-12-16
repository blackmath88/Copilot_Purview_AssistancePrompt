<#
.SYNOPSIS
    Quick export of essential Purview configuration (Labels + DLP only)
.DESCRIPTION
    Simplified version for quick testing or minimal exports.
    Exports only Sensitivity Labels and DLP Policies.
.EXAMPLE
    .\Quick-Export.ps1
.NOTES
    Author: Miro Steibruchmätteli
    Repository: https://github.com/blackmath88/Copilot_Purview_AssistancePrompt
    Version: 1.0
#>

Write-Host "🚀 Quick Export - Starting..." -ForegroundColor Cyan

# Connect if needed
try {
    $null = Get-Label -ErrorAction Stop | Select-Object -First 1
    Write-Host "✅ Connected" -ForegroundColor Green
} catch {
    Write-Host "⚠️  Connecting..." -ForegroundColor Yellow
    Connect-IPPSSession
}

# Quick Export
$export = @{
    ExportDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Labels = Get-Label | Select-Object Name, DisplayName, Priority
    DlpPolicies = Get-DlpCompliancePolicy | Select-Object Name, Mode, Enabled
}

# Save
$filename = "Quick_Export_$(Get-Date -Format 'yyyyMMdd_HHmmss').json"
$filepath = Join-Path $env:USERPROFILE\Desktop $filename
$export | ConvertTo-Json | Out-File $filepath -Encoding UTF8

Write-Host "✅ Exported to: $filepath" -ForegroundColor Green
explorer $env:USERPROFILE\Desktop

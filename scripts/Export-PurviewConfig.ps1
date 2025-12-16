<#
.SYNOPSIS
    Exports Microsoft Purview configuration for AI-assisted analysis
.DESCRIPTION
    Exports Sensitivity Labels, DLP Policies, Retention Policies and more from 
    Microsoft Purview / Security & Compliance Center for AI-assisted analysis.
    Designed for SC-401 training participants and IT professionals.
.PARAMETER Detailed
    Include additional data like Sensitive Info Types and Insider Risk Policies
.PARAMETER OutputPath
    Custom output path. Default: Desktop
.EXAMPLE
    .\Export-PurviewConfig.ps1
.EXAMPLE
    .\Export-PurviewConfig.ps1 -Detailed -OutputPath "C:\Exports"
.NOTES
    Author: Miro Steibruchmätteli
    Repository: https://github.com/blackmath88/Copilot_Purview_AssistancePrompt
    Version: 1.0
#>

[CmdletBinding()]
param(
    [switch]$Detailed,
    [string]$OutputPath = "$env:USERPROFILE\Desktop"
)

# Banner
Write-Host ""
Write-Host "╔════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  Purview Configuration Analyzer v1.0      ║" -ForegroundColor Cyan
Write-Host "║  Export Script for AI Analysis            ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Check if module is installed
Write-Host "🔍 Checking prerequisites..." -ForegroundColor Yellow
if (-not (Get-Module -ListAvailable -Name ExchangeOnlineManagement)) {
    Write-Host "❌ ExchangeOnlineManagement module not found!" -ForegroundColor Red
    Write-Host "📥 Installing module... (this may take a few minutes)" -ForegroundColor Yellow
    try {
        Install-Module -Name ExchangeOnlineManagement -Force -AllowClobber -ErrorAction Stop
        Write-Host "✅ Module installed successfully" -ForegroundColor Green
    } catch {
        Write-Host "❌ Installation failed: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "⚠️  Please run PowerShell as Administrator and try again" -ForegroundColor Yellow
        exit 1
    }
} else {
    Write-Host "✅ ExchangeOnlineManagement module found" -ForegroundColor Green
}

# Import module
Write-Host "📦 Importing module..." -NoNewline
Import-Module ExchangeOnlineManagement -ErrorAction SilentlyContinue
Write-Host " ✅" -ForegroundColor Green

# Check if connected
Write-Host ""
Write-Host "🔐 Checking connection to Security & Compliance Center..." -ForegroundColor Yellow
$connected = $false
try {
    $null = Get-Label -ErrorAction Stop | Select-Object -First 1
    $connected = $true
    Write-Host "✅ Already connected!" -ForegroundColor Green
} catch {
    Write-Host "⚠️  Not connected. Initiating connection..." -ForegroundColor Yellow
    try {
        Connect-IPPSSession -ErrorAction Stop
        $connected = $true
        Write-Host "✅ Connected successfully!" -ForegroundColor Green
    } catch {
        Write-Host "❌ Connection failed: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host ""
        Write-Host "💡 Troubleshooting tips:" -ForegroundColor Yellow
        Write-Host "   • Check your credentials" -ForegroundColor White
        Write-Host "   • Verify you have Compliance Admin or Security Admin role" -ForegroundColor White
        Write-Host "   • Try: Connect-IPPSSession -UserPrincipalName your-email@domain.com" -ForegroundColor White
        exit 1
    }
}

if (-not $connected) {
    Write-Host "❌ Unable to establish connection. Exiting." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "📊 Starting export process..." -ForegroundColor Cyan
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host ""

# Initialize report
$report = [ordered]@{
    ExportMetadata = @{
        Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        ExportedBy = $env:USERNAME
        Environment = "Microsoft Purview"
        ScriptVersion = "1.0"
        DetailedExport = $Detailed.IsPresent
        Repository = "https://github.com/blackmath88/Copilot_Purview_AssistancePrompt"
    }
}

# Export Sensitivity Labels
Write-Host "📋 Exporting Sensitivity Labels..." -NoNewline
try {
    $labels = Get-Label -ErrorAction Stop
    $report.SensitivityLabels = $labels | 
        Select-Object Name, DisplayName, Priority, Tooltip, Disabled, ParentId, EncryptionEnabled, ContentType
    Write-Host " ✅ ($($report.SensitivityLabels.Count) labels)" -ForegroundColor Green
} catch {
    Write-Host " ⚠️  Warning: $($_.Exception.Message)" -ForegroundColor Yellow
    $report.SensitivityLabels = @{Error = $_.Exception.Message}
}

# Export DLP Policies
Write-Host "🛡️  Exporting DLP Policies..." -NoNewline
try {
    $dlpPolicies = Get-DlpCompliancePolicy -ErrorAction Stop
    $report.DlpPolicies = $dlpPolicies | 
        Select-Object Name, Mode, Enabled, ExchangeLocation, SharePointLocation, TeamsLocation, OneDriveLocation, EndpointDlpLocation
    Write-Host " ✅ ($($report.DlpPolicies.Count) policies)" -ForegroundColor Green
} catch {
    Write-Host " ⚠️  Warning: $($_.Exception.Message)" -ForegroundColor Yellow
    $report.DlpPolicies = @{Error = $_.Exception.Message}
}

# Export DLP Rules
Write-Host "📜 Exporting DLP Rules..." -NoNewline
try {
    $dlpRules = Get-DlpComplianceRule -ErrorAction Stop
    $report.DlpRules = $dlpRules | 
        Select-Object Name, Policy, Priority, Disabled, BlockAccess, NotifyUser, GenerateIncidentReport
    Write-Host " ✅ ($($report.DlpRules.Count) rules)" -ForegroundColor Green
} catch {
    Write-Host " ⚠️  Warning: $($_.Exception.Message)" -ForegroundColor Yellow
    $report.DlpRules = @{Error = $_.Exception.Message}
}

# Export Retention Policies
Write-Host "⏱️  Exporting Retention Policies..." -NoNewline
try {
    $retentionPolicies = Get-RetentionCompliancePolicy -ErrorAction Stop
    $report.RetentionPolicies = $retentionPolicies | 
        Select-Object Name, Enabled, ExchangeLocation, SharePointLocation, ModernGroupLocation, OneDriveLocation
    Write-Host " ✅ ($($report.RetentionPolicies.Count) policies)" -ForegroundColor Green
} catch {
    Write-Host " ⚠️  Warning: $($_.Exception.Message)" -ForegroundColor Yellow
    $report.RetentionPolicies = @{Error = $_.Exception.Message}
}

# Detailed Export (optional)
if ($Detailed) {
    Write-Host ""
    Write-Host "🔬 Detailed Export Mode - Additional Data:" -ForegroundColor Cyan
    
    # Sensitive Info Types
    Write-Host "   → Sensitive Info Types..." -NoNewline
    try {
        $sensitiveTypes = Get-DlpSensitiveInformationType -ErrorAction Stop
        $report.SensitiveInfoTypes = $sensitiveTypes | 
            Where-Object {$_.Publisher -eq "Microsoft Corporation"} |
            Select-Object Name, Publisher, Description -First 50  # Limit to prevent huge exports
        Write-Host " ✅ ($($report.SensitiveInfoTypes.Count) types)" -ForegroundColor Green
    } catch {
        Write-Host " ⚠️  Warning" -ForegroundColor Yellow
        $report.SensitiveInfoTypes = @{Error = $_.Exception.Message}
    }
    
    # Insider Risk Policies (if available)
    Write-Host "   → Insider Risk Policies..." -NoNewline
    try {
        $insiderRisk = Get-InsiderRiskPolicy -ErrorAction Stop
        $report.InsiderRiskPolicies = $insiderRisk | Select-Object Name, Enabled
        Write-Host " ✅ ($($report.InsiderRiskPolicies.Count) policies)" -ForegroundColor Green
    } catch {
        Write-Host " ⚠️  Not available" -ForegroundColor Yellow
        $report.InsiderRiskPolicies = @{Note = "Feature not available or insufficient permissions"}
    }
}

# Statistics
Write-Host ""
Write-Host "📊 Calculating statistics..." -NoNewline
$report.Statistics = @{
    TotalLabels = if ($report.SensitivityLabels -is [Array]) { $report.SensitivityLabels.Count } else { 0 }
    TotalDlpPolicies = if ($report.DlpPolicies -is [Array]) { $report.DlpPolicies.Count } else { 0 }
    TotalDlpRules = if ($report.DlpRules -is [Array]) { $report.DlpRules.Count } else { 0 }
    TotalRetentionPolicies = if ($report.RetentionPolicies -is [Array]) { $report.RetentionPolicies.Count } else { 0 }
    EnabledDlpPolicies = if ($report.DlpPolicies -is [Array]) { ($report.DlpPolicies | Where-Object {$_.Enabled -eq $true}).Count } else { 0 }
}
Write-Host " ✅" -ForegroundColor Green

# Save to file
Write-Host ""
Write-Host "💾 Saving export..." -NoNewline
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$filename = "Purview_Export_$timestamp.json"
$filepath = Join-Path $OutputPath $filename

try {
    $report | ConvertTo-Json -Depth 6 | Out-File -FilePath $filepath -Encoding UTF8 -ErrorAction Stop
    Write-Host " ✅" -ForegroundColor Green
} catch {
    Write-Host " ❌" -ForegroundColor Red
    Write-Host "Error saving file: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Success Banner
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host ""
Write-Host "╔════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║  ✅ EXPORT COMPLETED SUCCESSFULLY!         ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""

# Export Summary
Write-Host "📁 Export Details:" -ForegroundColor Cyan
Write-Host "   File: $filename" -ForegroundColor White
Write-Host "   Location: $filepath" -ForegroundColor White
Write-Host "   Size: $([math]::Round((Get-Item $filepath).Length / 1KB, 2)) KB" -ForegroundColor White
Write-Host ""

Write-Host "📊 Configuration Summary:" -ForegroundColor Cyan
Write-Host "   • Sensitivity Labels: $($report.Statistics.TotalLabels)" -ForegroundColor White
Write-Host "   • DLP Policies: $($report.Statistics.TotalDlpPolicies) ($($report.Statistics.EnabledDlpPolicies) enabled)" -ForegroundColor White
Write-Host "   • DLP Rules: $($report.Statistics.TotalDlpRules)" -ForegroundColor White
Write-Host "   • Retention Policies: $($report.Statistics.TotalRetentionPolicies)" -ForegroundColor White
Write-Host ""

Write-Host "🔍 Next Steps:" -ForegroundColor Yellow
Write-Host "   1. Upload this JSON to Claude.ai, ChatGPT, or Copilot" -ForegroundColor White
Write-Host "   2. Use prompts/ANALYZER_PROMPT.md for analysis" -ForegroundColor White
Write-Host "   3. Receive your Swiss FADP-optimized recommendations" -ForegroundColor White
Write-Host ""
Write-Host "📚 Documentation: https://github.com/blackmath88/Copilot_Purview_AssistancePrompt" -ForegroundColor Cyan
Write-Host ""

# Offer to open file location
$openFolder = Read-Host "📂 Open file location? (Y/N)"
if ($openFolder -eq 'Y' -or $openFolder -eq 'y') {
    explorer $OutputPath
}

Write-Host ""
Write-Host "✨ Thank you for using Purview Configuration Analyzer!" -ForegroundColor Cyan
Write-Host ""

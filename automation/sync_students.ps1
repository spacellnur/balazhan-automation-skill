<#
.SYNOPSIS
    Balazhan Student Automation Sync Tool
.DESCRIPTION
    Automates the entry of student social passports and curator observation cards on balazhan.nedb.kz.
.EXAMPLE
    .\sync_students.ps1 -JsonPath "..\students.json" -MaxAge 18 -StartNum 1
#>

param(
    [string]$JsonPath = "..\students.json",
    [int]$MaxAge = 18,
    [int]$StartNum = 1,
    [int]$EndNum = 999,
    [ValidateSet("SocialPassport", "ObservationCard", "FullPipeline")]
    [string]$Action = "SocialPassport"
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$resolvedJsonPath = Join-Path $scriptDir $JsonPath
if (-not (Test-Path $resolvedJsonPath)) {
    $resolvedJsonPath = $JsonPath
}

if (-not (Test-Path $resolvedJsonPath)) {
    Write-Error "JSON data file not found: $JsonPath"
    exit 1
}

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "     BALAZHAN AUTOMATION SYNC TOOL (Windows UIA)          " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "Target JSON: $resolvedJsonPath" -ForegroundColor Yellow
Write-Host "Max Age Filter: Under $MaxAge years old" -ForegroundColor Yellow
Write-Host "Student Index Range: $StartNum to $EndNum" -ForegroundColor Yellow
Write-Host "Execution Action: $Action" -ForegroundColor Yellow
Write-Host "==========================================================" -ForegroundColor Cyan

# Load Assemblies
Add-Type -AssemblyName UIAutomationClient
Add-Type -AssemblyName UIAutomationTypes
Add-Type -AssemblyName System.Web.Extensions

# Compile Engine
$engineSource = Get-Content (Join-Path $scriptDir "BalazhanEngine.cs") -Raw -Encoding UTF8
Add-Type -TypeDefinition $engineSource -ReferencedAssemblies UIAutomationClient, UIAutomationTypes, System.Web.Extensions

if ($Action -eq "SocialPassport") {
    Write-Host "`nStarting Social Passport batch processing..." -ForegroundColor Green
    [BalazhanAutomation.BalazhanEngine]::SyncSocialPassports($resolvedJsonPath, $MaxAge, $StartNum, $EndNum)
}
elseif ($Action -eq "ObservationCard") {
    Write-Host "`nSaving Curator Observation Card on active student..." -ForegroundColor Green
    $res = [BalazhanAutomation.BalazhanEngine]::SaveCurrentCuratorObservationCard()
    Write-Host $res -ForegroundColor Green
}
elseif ($Action -eq "FullPipeline") {
    Write-Host "`nRunning Full Pipeline (Social Passports + Cards)..." -ForegroundColor Green
    [BalazhanAutomation.BalazhanEngine]::SyncSocialPassports($resolvedJsonPath, $MaxAge, $StartNum, $EndNum)
}

Write-Host "`nOperation completed!" -ForegroundColor Cyan

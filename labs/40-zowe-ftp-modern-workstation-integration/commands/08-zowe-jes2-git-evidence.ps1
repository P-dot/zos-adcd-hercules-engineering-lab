# Lab 40 Part 2 - Zowe -> JES2 -> Git evidence workflow
# Captures sanitized operational evidence locally.
# This script does NOT commit or push anything.

$ErrorActionPreference = "Stop"

$Repo = "C:\Carrera_Ciberseguridad\06_Portfolio_GitHub\zos-adcd-hercules-engineering-lab"
$Lab  = Join-Path $Repo "labs\40-zowe-ftp-modern-workstation-integration"
$Evidence = Join-Path $Lab "evidence\text"
$Output = Join-Path $Evidence "jes2-controlled-submit.txt"

New-Item -ItemType Directory -Force $Evidence | Out-Null

Write-Host "===== LAB 40 PART 2 ====="
Write-Host "Controlled Zowe -> JES2 evidence capture"
Write-Host ""

$Result = & zowe.cmd zos-ftp submit data-set "IBMUSER.JCL.LAB(IBMJ01)" `
    --zftp-profile zftp `
    --wait-for-output `
    --response-format-json

if ($LASTEXITCODE -ne 0) {
    throw "Zowe/JES2 submission failed. Evidence file was not published."
}

$Json = $Result | ConvertFrom-Json

$Summary = @"
LAB 40 PART 2 - CONTROLLED JES2 VALIDATION
==========================================

Source:
IBMUSER.JCL.LAB(IBMJ01)

Transport:
Zowe CLI -> z/OS FTP -> JES2

Job name:
$($Json.data.jobName)

Job ID:
$($Json.data.jobId)

Status:
$($Json.data.status)

Return code:
$($Json.data.retcode)

Validation:
Controlled JCL submitted from the modern VS Code/Zowe workstation.
JES2 processed the workload and returned the recorded completion status.

Security:
Credentials are not recorded in this evidence file.
Network addresses are intentionally omitted.

Git policy:
Evidence is captured locally only.
Commit and push require manual review.
"@

$Summary | Set-Content $Output -Encoding UTF8

Write-Host ""
Write-Host "===== CAPTURED EVIDENCE ====="
Get-Content $Output

Write-Host ""
Write-Host "===== GIT STATUS ====="
git -C $Repo status --short

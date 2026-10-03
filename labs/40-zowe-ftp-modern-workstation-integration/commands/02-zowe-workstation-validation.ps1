# Lab 40 - workstation validation and Zowe FTP workflow

Write-Host "===== ZOWE CLI ====="
Get-Command zowe -ErrorAction SilentlyContinue | Format-List Name,Source,Version

Write-Host "`n===== NODE ====="
node --version

Write-Host "`n===== ZOWE EXTENSIONS ====="
code --list-extensions --show-versions | Select-String -Pattern "zowe"

Write-Host "`n===== CLI PLUGINS ====="
zowe.cmd plugins list

# Install once if absent:
# zowe.cmd plugins install @zowe/zos-ftp-for-zowe-cli@zowe-v3-lts

Write-Host "`n===== READ SEQUENTIAL DATA SET ====="
zowe.cmd zos-ftp view data-set "IBMUSER.BATCH.INPUT"

Write-Host "`n===== LIST USER DATA SETS ====="
zowe.cmd zos-ftp list data-set "IBMUSER.*"

Write-Host "`n===== LIST REXX PDS MEMBERS ====="
zowe.cmd zos-ftp list data-set-members "IBMUSER.REXX.EXEC"

Write-Host "`n===== VIEW REXX MEMBER ====="
zowe.cmd zos-ftp view data-set "IBMUSER.REXX.EXEC(ARITH04)"

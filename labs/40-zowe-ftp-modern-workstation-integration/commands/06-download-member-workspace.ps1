$Workspace = "$HOME\zos-workspace\rexx"
New-Item -ItemType Directory -Force $Workspace | Out-Null
Set-Location $Workspace

zowe.cmd zos-ftp download data-set "IBMUSER.REXX.EXEC(ARITH04)" --file "ARITH04.rexx"
code.cmd $Workspace

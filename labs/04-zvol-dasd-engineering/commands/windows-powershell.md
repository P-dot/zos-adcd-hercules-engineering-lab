# Windows PowerShell - ZVOL recreation

```powershell
$stamp = Get-Date -Format "yyyyMMdd_HHmmss"
$backup = "F:\ZOS111\BACKUP_ZVOL_$stamp"
New-Item -ItemType Directory -Path $backup

Copy-Item "F:\ZOS111\ZVOL00.CCKD","F:\ZOS111\ZVOL01.CCKD" $backup -ErrorAction SilentlyContinue
Copy-Item "F:\ZOS111\SHADOW\ZVOL00_*","F:\ZOS111\SHADOW\ZVOL01_*" $backup -ErrorAction SilentlyContinue

Move-Item "F:\ZOS111\ZVOL00.CCKD" "F:\ZOS111\ZVOL00.CCKD.BAD_$stamp" -ErrorAction SilentlyContinue
Move-Item "F:\ZOS111\ZVOL01.CCKD" "F:\ZOS111\ZVOL01.CCKD.BAD_$stamp" -ErrorAction SilentlyContinue
Move-Item "F:\ZOS111\SHADOW\ZVOL00_*" $backup -ErrorAction SilentlyContinue
Move-Item "F:\ZOS111\SHADOW\ZVOL01_*" $backup -ErrorAction SilentlyContinue

& "F:\ZOS111\HERCULES\dasdinit.exe" -z -a "F:\ZOS111\ZVOL00.CCKD" 3390-3 ZVOL00
& "F:\ZOS111\HERCULES\dasdinit.exe" -z -a "F:\ZOS111\ZVOL01.CCKD" 3390-3 ZVOL01
```

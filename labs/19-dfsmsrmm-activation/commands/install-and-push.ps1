$Repo = "C:\Carrera_Ciberseguridad\06_Portfolio_GitHub\zos-adcd-hercules-engineering-lab"
$Zip  = "$env:USERPROFILE\Downloads\lab-19-dfsmsrmm-activation.zip"
$Tmp  = "$env:TEMP\lab-19-dfsmsrmm-activation"

Remove-Item $Tmp -Recurse -Force -ErrorAction SilentlyContinue
Expand-Archive -Path $Zip -DestinationPath $Tmp -Force

Copy-Item `
  "$Tmp\19-dfsmsrmm-activation" `
  "$Repo\labs\19-dfsmsrmm-activation" `
  -Recurse -Force

Set-Location $Repo

git status
git add "labs/19-dfsmsrmm-activation"
git status

git commit -m "Add Lab 19 DFSMSrmm activation and runtime validation"
git push origin main

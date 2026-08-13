# Git Bash Upload Commands

Repository and target lab folder:

```bash
REPO="/c/Carrera_Ciberseguridad/06_Portfolio_GitHub/zos-adcd-hercules-engineering-lab"
REMOTE="https://github.com/P-dot/zos-adcd-hercules-engineering-lab.git"
LAB="labs/21-enterprise-system-layout-change-control-baseline"
```

Run from Git Bash after downloading `lab21-enterprise-system-layout-change-control-baseline.zip` to Downloads:

```bash
set -e

REPO="/c/Carrera_Ciberseguridad/06_Portfolio_GitHub/zos-adcd-hercules-engineering-lab"
REMOTE="https://github.com/P-dot/zos-adcd-hercules-engineering-lab.git"
LAB="labs/21-enterprise-system-layout-change-control-baseline"
TMP="$HOME/Downloads/lab21-enterprise-system-layout-change-control-baseline-unzip"

cd "$REPO"

git branch -M main
git remote remove origin 2>/dev/null || true
git remote add origin "$REMOTE"
git pull --rebase origin main

rm -rf "$LAB"
rm -rf "$TMP"
mkdir -p "$LAB"

powershell.exe -NoProfile -Command 'Expand-Archive -LiteralPath "$env:USERPROFILE\Downloads\lab21-enterprise-system-layout-change-control-baseline.zip" -DestinationPath "$env:USERPROFILE\Downloads\lab21-enterprise-system-layout-change-control-baseline-unzip" -Force'

if [ -d "$TMP/lab21-enterprise-system-layout-change-control-baseline" ]; then
  cp -R "$TMP/lab21-enterprise-system-layout-change-control-baseline"/. "$LAB"/
else
  cp -R "$TMP"/. "$LAB"/
fi

echo "=== LAB CONTENT ==="
find "$LAB" -maxdepth 2 -type f | sort

echo "=== GIT STATUS ==="
git status --short

git add "$LAB"
git commit -m "Add lab 21 enterprise system layout baseline"
git push --set-upstream origin main
```

Validation after push:

```bash
git log --oneline -1
git status
git remote -v
```

Expected GitHub path:

```text
P-dot/zos-adcd-hercules-engineering-lab/labs/21-enterprise-system-layout-change-control-baseline
```

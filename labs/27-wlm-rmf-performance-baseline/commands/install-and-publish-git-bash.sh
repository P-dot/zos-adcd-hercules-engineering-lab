#!/usr/bin/env bash
set -euo pipefail

REPO="/c/Carrera_Ciberseguridad/06_Portfolio_GitHub/zos-adcd-hercules-engineering-lab"
ZIP="$HOME/Downloads/lab-27-wlm-rmf-performance-baseline.zip"
TMP="$HOME/Downloads/lab-27-wlm-rmf-performance-baseline-tmp"
LAB="27-wlm-rmf-performance-baseline"

cd "$REPO"
rm -rf "$TMP"
mkdir -p "$TMP"
unzip -o "$ZIP" -d "$TMP"

rm -rf "labs/$LAB"
cp -r "$TMP/$LAB" "labs/$LAB"
rm -rf "$TMP"

echo "===== LAB INSTALLED ====="
find "labs/$LAB" -type f | sort

echo
echo "===== GIT STATUS BEFORE COMMIT ====="
git status --short

git add "labs/$LAB"

git commit -m "Add Lab 27 WLM and RMF performance baseline"
git push origin main

echo
echo "===== FINAL STATUS ====="
git status --short
git log -2 --oneline
git ls-remote origin refs/heads/main

# GitHub upload commands

Coloca este lab dentro del repo principal:

```bash
cd /c/Carrera_Ciberseguridad/06_Portfolio_GitHub/zos-adcd-hercules-engineering-lab
mkdir -p labs
unzip -o ~/Downloads/lab09-adrdssu-backup-hercules-virtual-tape.zip -d labs
find labs/09-adrdssu-backup-hercules-virtual-tape -maxdepth 4 -type f
```

Subida:

```bash
cd /c/Carrera_Ciberseguridad/06_Portfolio_GitHub/zos-adcd-hercules-engineering-lab
git status
git add labs/09-adrdssu-backup-hercules-virtual-tape
git status
git commit -m "Add LAB09 ADRDSSU backup to Hercules virtual tape"
git push -u origin main
```

Antes de publicar, revisar visualmente capturas con rutas locales de Windows si se desea sanitizar para portfolio público.

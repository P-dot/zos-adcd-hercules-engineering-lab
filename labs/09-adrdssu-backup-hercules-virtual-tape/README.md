# Lab 09 - ADRDSSU Backup to Hercules Virtual Tape

## Objetivo

Documentar un backup completo de un volumen de laboratorio z/OS usando `ADRDSSU` y una cinta virtual Hercules en formato HET.

Este lab no toca volúmenes críticos del sistema. El origen del backup es el volumen sandbox `ZVOL00`; la salida es una cinta virtual `BK0001.het` montada manualmente en una unidad 3490 emulada por Hercules.

## Entorno

- Plataforma: z/OS ADCD 1.11 sobre Hercules en Windows
- Volumen origen: `ZVOL00`
- Unidad de cinta usada por z/OS: `0581`
- Formato de cinta Hercules: `HET`
- Utilidad z/OS: `ADRDSSU` / DFSMSdss
- Resultado final: `ADR013I TASK COMPLETED WITH RETURN CODE 0000`

## Evidencia principal

Las capturas están en:

```text
evidence/screenshots/
```

Manifest:

| Imagen | Evidencia |
|---|---|
| `01_tape_units_0580_0581_online_not_ready.png` | z/OS ve unidades 3490 `0580` y `0581` online/not ready |
| `02_zvol00_zvol01_online_baseline.png` | `ZVOL00` y `ZVOL01` online como volúmenes 3390 de laboratorio |
| `03_windows_hetinit_bk0001_created.png` | creación de `BK0001.het` con `hetinit` en Windows |
| `04_tape_units_0580_0581_confirmed.png` | segunda verificación de unidades de cinta |
| `05_zvol00_zvol01_confirmed.png` | segunda verificación de ZVOL00/ZVOL01 |
| `06_initial_adrdssu_jcl_with_tape_labels.png` | JCL inicial con parámetros de cinta explícitos |
| `07_adrdssu_started_mount_request_and_scan.png` | job arrancado, `IEF233A` y scan inicial de ADRDSSU |
| `08_jesmsglg_mount_request_ief233a_0581.png` | petición de montaje `IEF233A M 0581` |
| `09_hercules_devinit_0581_bk0001_rewind_ready_unload.png` | montaje de la cinta con `devinit` en Hercules |
| `10_sdsf_st_job_dmpzv00_execution.png` | job `DMPZV00` en ejecución en SDSF ST |
| `11_adrdssu_initial_syprint_scan.png` | `SYSPRINT` inicial de ADRDSSU |
| `12_hercules_devinit_0581_repeated_mount_success.png` | evidencia adicional de montaje/unload en Hercules |
| `13_adrdssu_syprint_return_code_0000.png` | backup completado con return code `0000` |
| `14_windows_bk0001_het_size_after_backup.png` | `BK0001.het` creció tras el backup |

## Resultado

El backup se completó correctamente:

```text
ADR013I TASK COMPLETED WITH RETURN CODE 0000
ADR012I DFSMSDSS PROCESSING COMPLETE
```

## Valor técnico

Este lab demuestra:

- inventario de unidades de cinta 3490 emuladas;
- creación de cinta virtual HET en Windows;
- ejecución de `ADRDSSU DUMP FULL`;
- montaje manual de cinta en Hercules con `devinit`;
- seguimiento de job en SDSF;
- validación del resultado con `SYSPRINT` y tamaño de la cinta.

## Seguridad operacional

No se realizó restore en este lab. El restore debe hacerse en una fase separada, usando un volumen destino distinto del origen y nunca sobre `SBRES1`, `SBSYS1` ni volúmenes críticos del sistema.

# Safety and Rollback Notes

## Reglas aplicadas

- No se hizo backup de `SBRES1`, `SBSYS1` ni de volúmenes críticos.
- No se hizo restore.
- No se modificaron volúmenes de sistema.
- El origen fue `ZVOL00`, volumen sandbox de laboratorio.
- La salida fue una cinta virtual HET en Windows.

## Restore pendiente

El restore debe hacerse en otro lab y con estas reglas:

- origen: `BK0001.het` / dataset `DMP.ZVOL00A`;
- destino: `ZVOL01` o volumen sandbox nuevo;
- nunca restaurar sobre `ZVOL00` si fue el origen;
- nunca restaurar sobre `SBRES1`, `SBSYS1`, `SYS1.*` o `ADCD.Z111S.*`.

## Riesgo principal

`ADRDSSU RESTORE` puede sobrescribir estructuras completas de volumen. Por eso el restore requiere validación previa del volumen destino, estado online/offline, VTOC y confirmaciones ICKDSF/ADRDSSU.

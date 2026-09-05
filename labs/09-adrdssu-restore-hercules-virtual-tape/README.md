# Lab 09 — Parte 2: restauración de volumen con ADRDSSU

## Objetivo

Restaurar el dump completo de `ZVOL00` desde la cinta Hercules `BK0001` sobre el volumen de laboratorio `ZVOL01` (dispositivo `0A9C`). `ZVOL00`, `SBSYS1`, `SBRES1`, `SYS1.*` y `ADCD.Z111S.*` quedan fuera del alcance.

## Flujo ejecutado

1. El job `RSTZV01` quedó detenido por `EDG4012D` porque DFSMSrmm no estaba activo.
2. Se inició `DFRMM` con `S DFRMM`.
3. Se montó `BK0001.het` en la unidad `0581`.
4. El mensaje `ADR369D` solicitó autorizar escritura de VTOCIX en `ZVOL01`.
5. Se respondió `R 04,U`.
6. `BUILDIX` convirtió la VTOC a `IXFORMAT`.
7. La restauración terminó con `MAXCC=0`.

## Evidencia técnica

```text
EDG0105I DFSMSrmm SUBSYSTEM INITIALIZATION COMPLETE
IEC0604I VTOC CONVERT ROUTINE ENTERED ON 0A9C,ZVOL01
ICK513I 0A9C BUILDIX PROCESSING COMPLETED: VTOC IS NOW IN IXFORMAT
IEF404I RSTZV01 - ENDED
$HASP165 RSTZV01 ENDED AT N1 MAXCC=0
```

## Resultado

La restauración de volumen completo se completó correctamente en `ZVOL01`, con reconstrucción de VTOCIX y sin tocar el volumen origen `ZVOL00`.

## Incidencia y resolución

Responder `CONTINUE` al `EDG4012D` no saltó DFSMSrmm: la cinta fue rechazada mientras el subsistema estaba detenido. Tras iniciar `DFRMM`, el montaje y el procesamiento fueron aceptados.

## Evidencias

Las capturas se encuentran en `evidence/`. La última captura recoge la finalización del job y el `MAXCC=0`.

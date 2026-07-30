# LAB 12 - JES2 JQEs and JNUMWARN Mitigation

## Objetivo

Diagnosticar y documentar el aviso JES2:

```text
$HASP050 JES2 RESOURCE SHORTAGE OF JQES - 80/81% UTILIZATION REACHED
```

El objetivo no era ampliar SPOOL ni modificar `JOBNUM`, sino diferenciar entre:

- espacio físico de SPOOL;
- utilización de JQEs / Job Queue Elements;
- mensajes históricos retenidos en consola.

## Contexto

Este lab nace después del cierre operativo de HZSPROC / Health Checker. Durante el apagado y reinicio del entorno apareció `$HASP050`, pero la evidencia de SPOOL mostró que el volumen adicional `SBSYS9` estaba activo y con uso bajo.

Por tanto, el problema no era falta de SPOOL físico, sino utilización de JQEs por encima del umbral de aviso configurado en JES2.

## Evidencia principal

- `$HASP050` aparece con utilización de JQEs al 80/81%.
- `D A,L` confirma subsistemas principales activos.
- `$D JOBDEF` muestra parámetros JES2 relacionados con jobs.
- `$D SPOOL` muestra `SBSYS1` y `SBSYS9` activos.
- `$D JOBQ` muestra salidas de started tasks en `AWAITING HARDCOPY`.
- `$T JOBDEF,JNUMWARN=90` se aplica correctamente.
- `$D JOBDEF` posterior muestra `JNUMWARN=90`.

## Conclusión técnica

```text
SPOOL físico: OK
SBSYS1: ACTIVE, ~60%
SBSYS9: ACTIVE, ~1%
JQES: aviso por umbral de utilización
JNUMWARN: ajustado de 80 a 90
JOBNUM: no modificado
JES2PARM: no modificado
PURGE masivo: no ejecutado
```

El aviso `$HASP050` retenido en `D R,L` conserva una hora anterior al ajuste y se clasifica como mensaje histórico/no bloqueante.

## Decisión de remediación

Se aplicó una mitigación mínima:

```text
$T JOBDEF,JNUMWARN=90
```

No se modificó `JOBNUM` porque eso pertenece a una corrección estructural JES2 de mayor impacto.

## Riesgo residual

Queda pendiente revisar en un lab separado:

- mantenimiento de salidas JES2 retenidas;
- política de retención de output/hardcopy;
- posible ajuste estructural de `JOBNUM` si el entorno lo requiere;
- persistencia en JES2PARM si se decide conservar `JNUMWARN=90` tras IPL.

## Fuera de alcance

No pertenece a este lab:

- HZSPROC / Health Checker;
- RACF / OPERCMDS;
- ampliación de SPOOL;
- modificación de `JOBNUM`;
- limpieza de LOGREC.

## Siguiente lab sugerido

El siguiente hallazgo operativo visible es:

```text
IFB081I LOGREC DATA SET IS FULL
```

Por tanto, el siguiente lab recomendado es:

```text
LAB 13 - LOGREC full cleanup
```

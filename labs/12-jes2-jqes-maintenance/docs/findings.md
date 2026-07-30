# Findings - LAB 12 JES2 JQEs

## Hallazgo 1 - `$HASP050` por JQEs

El sistema informa:

```text
$HASP050 JES2 RESOURCE SHORTAGE OF JQES - 80/81% UTILIZATION REACHED
```

Interpretación: el umbral de utilización de JQEs estaba alcanzado. No es equivalente a SPOOL lleno.

## Hallazgo 2 - SPOOL físico disponible

`$D SPOOL` muestra que los volúmenes de SPOOL están activos:

```text
SBSYS1 ACTIVE ~60%
SBSYS9 ACTIVE ~1%
```

Interpretación: el SPOOL físico no es el cuello de botella inmediato.

## Hallazgo 3 - JOBQ con started tasks en hardcopy

`$D JOBQ` muestra entradas asociadas a STCs normales del sistema en `AWAITING HARDCOPY`.

Interpretación: no se ejecuta purge masivo porque aparecen tareas legítimas del sistema, no basura claramente identificada.

## Remediación aplicada

```text
$T JOBDEF,JNUMWARN=90
```

Mitigación: elevar el umbral de aviso para evitar ruido al 80% y dejar margen operativo.

## Riesgo residual

Esta mitigación no aumenta la capacidad real de JQEs. Si el entorno vuelve a crecer o el aviso aparece de nuevo al 90%, habrá que estudiar:

```text
JOBNUM
retención de output
política de hardcopy
limpieza selectiva de colas
persistencia en JES2PARM
```

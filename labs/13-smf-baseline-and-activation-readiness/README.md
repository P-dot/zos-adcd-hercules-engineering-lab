# LAB 13 - SMF Baseline and Activation Readiness

## Objetivo

Verificar el estado real de SMF en z/OS ADCD 1.11 sobre Hercules, confirmar la configuración `SMFPRM00`, validar los datasets `SYS1.MAN1/2/3` y activar SMF de forma controlada sin redefinir datasets ni modificar la política de registros.

## Resultado

SMF estaba instalado y configurado con `SMF=00`, pero `SMFPRM00` contenía `NOACTIVE`, por lo que `D SMF` indicaba que `SYS1.MAN` recording no estaba siendo usado.

Se realizó backup del miembro `SMFPRM00`, se cambió únicamente `NOACTIVE` por `ACTIVE`, y se aplicó dinámicamente con:

```text
SET SMF=00
```

La verificación final mostró SMF grabando en `SYS1.MAN1` con `SYS1.MAN2` y `SYS1.MAN3` como alternativos.

## Evidencia principal

- `D SMF` inicial: `SMF SYS1.MAN RECORDING NOT BEING USED`.
- `IEASYSDB`: parámetro `SMF=00`.
- `SMFPRM00`: estado inicial `NOACTIVE`.
- `SYS1.MAN1`, `SYS1.MAN2`, `SYS1.MAN3` existentes.
- Backup de `SMFPRM00` con `IEBCOPY`, CC 0000.
- `SMFPRM00` modificado a `ACTIVE`.
- `SET SMF=00` aplicado.
- `D SMF` final: `SYS1.MAN1` activo y `SYS1.MAN2/3` alternativos.

## Cambios realizados

```text
ADCD.Z111S.PARMLIB(SMFPRM00)
NOACTIVE -> ACTIVE
```

No se modificaron:

```text
SYS(TYPE(...))
SUBSYS(...)
EXITS(...)
DSNAME(SYS1.MAN1/2/3)
JES2PARM
RACF
```

## Valor profesional

Este lab documenta una activación controlada de logging SMF, requisito base para auditoría, trazabilidad, análisis de jobs, rendimiento y seguridad en z/OS.

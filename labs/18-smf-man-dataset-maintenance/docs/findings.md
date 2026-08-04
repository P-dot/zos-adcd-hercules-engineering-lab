# Findings — LAB 18

## Hallazgo 1 — SMF MAN datasets al 100%

`D SMF` mostró que los tres datasets MAN estaban al 100% con estado `DUMP REQUIRED`:

```text
SYS1.MAN1  100  DUMP REQUIRED
SYS1.MAN2  100  DUMP REQUIRED
SYS1.MAN3  100  DUMP REQUIRED
```

## Hallazgo 2 — El primer SMFDMP falló por nombre duplicado

El fallo inicial no fue causado por IFASMFDP ni por SMF. El problema fue que el dataset de salida ya existía:

```text
IBMUSER.SMF.LAB14.RUN01
```

El sistema rechazó la creación con mensajes de duplicate data set name.

## Hallazgo 3 — Corrección con salida específica del lab

Se cambió la salida a:

```text
IBMUSER.SMF.LAB18.RUN01
```

El job pudo ejecutarse correctamente y catalogar el dump.

## Hallazgo 4 — SMF quedó operativo

Después del dump, `D SMF` mostró:

```text
SYS1.MAN1  0  ALTERNATE
SYS1.MAN2  0  ACTIVE
SYS1.MAN3  0  ALTERNATE
```

Y `D R,L` quedó sin mensajes pendientes.

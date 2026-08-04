# LAB 18 — SMF MAN Dataset Maintenance and Operational Cleanup

## Objetivo

Resolver una incidencia operacional real en el laboratorio z/OS ADCD sobre Hercules: los datasets activos de SMF (`SYS1.MAN1`, `SYS1.MAN2`, `SYS1.MAN3`) estaban al 100% y requerían dump.

El objetivo técnico fue ejecutar un ciclo controlado de diagnóstico, corrección, dump/export y verificación final de los datasets MAN de SMF.

## Entorno

- Plataforma: z/OS ADCD 1.11 sobre Hercules
- Consola: MASTER L700 / SDSF
- Usuario operativo: IBMUSER
- Componente: SMF / IFASMFDP
- Datasets MAN: `SYS1.MAN1`, `SYS1.MAN2`, `SYS1.MAN3`
- Dataset de salida: `IBMUSER.SMF.LAB18.RUN01`
- Volumen de salida: `ZVOL00`

## Situación inicial

La consola mostraba mensajes operacionales pendientes relacionados con SMF:

```text
IEE362A SMF ENTER DUMP FOR SYS1.MAN1 ON SBSYS1
IEE362A SMF ENTER DUMP FOR SYS1.MAN2 ON SBSYS1
IEE362A SMF ENTER DUMP FOR SYS1.MAN3 ON SBSYS1
```

El comando `D SMF` confirmó:

```text
SYS1.MAN1  100%  DUMP REQUIRED
SYS1.MAN2  100%  DUMP REQUIRED
SYS1.MAN3  100%  DUMP REQUIRED
```

## Incidencia encontrada

El primer intento de `SMFDMP` falló antes de ejecutar `IFASMFDP` porque el dataset de salida ya existía:

```text
IEF253I ... DUPLICATE NAME ON DIRECT ACCESS VOLUME
IGD17001I DUPLICATE DATA SET NAME ON VOLUME ZVOL00
DATA SET IBMUSER.SMF.LAB14.RUN01
IEF272I STEP01 NOT EXECUTED
```

La causa no era SMF, sino una salida de dump reutilizada de un lab anterior.

## Corrección aplicada

Se cambió el dataset de salida a un nombre específico del lab actual:

```text
IBMUSER.SMF.LAB18.RUN01
```

También se añadió un paso `CLEANUP` con `IDCAMS DELETE` y `SET MAXCC = 0` para permitir reejecuciones controladas.

## Resultado final

El job corregido terminó correctamente:

```text
SMFDMP STEP01 - COND CODE 0000
OUTSMF catalogado
IFASMFDP ejecutado
```

Después, `D SMF` mostró los MAN datasets ya descargados y reutilizables:

```text
SYS1.MAN1  0  ALTERNATE
SYS1.MAN2  0  ACTIVE
SYS1.MAN3  0  ALTERNATE
```

Y `D R,L` confirmó:

```text
NO MESSAGES OUTSTANDING
```

## Valor profesional

Este lab demuestra operación realista de z/OS:

- detección de datasets SMF llenos,
- diagnóstico con `D SMF` y `D R,L`,
- corrección de una salida duplicada,
- ejecución de `IFASMFDP`,
- descarga de MAN datasets,
- recuperación de consola limpia.

No es solo ejecutar un job: es cerrar una incidencia operacional completa con evidencia antes/después.

## Estado final

```text
SMF activo                         OK
MAN datasets monitorizados          OK
Dump/clear operativo                OK
Salida SMF archivada en ZVOL00      OK
Consola sin mensajes pendientes     OK
LAB 18 cerrado                      OK
```

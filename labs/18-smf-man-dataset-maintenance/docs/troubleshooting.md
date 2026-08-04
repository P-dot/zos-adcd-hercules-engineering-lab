# Troubleshooting — LAB 18

## Error: duplicate dataset name

Mensaje observado:

```text
IEF253I ... DUPLICATE NAME ON DIRECT ACCESS VOLUME
IGD17001I DUPLICATE DATA SET NAME ON VOLUME ZVOL00
DATA SET IBMUSER.SMF.LAB14.RUN01
IEF272I STEP01 NOT EXECUTED
```

### Causa

El job intentaba crear una salida de SMF ya existente de un lab anterior.

### Solución

Usar un nombre de salida nuevo para el lab actual:

```text
IBMUSER.SMF.LAB18.RUN01
```

O borrar previamente la salida con `IDCAMS DELETE` y `SET MAXCC = 0`.

## Validación posterior

Comandos:

```text
/D SMF
/D R,L
```

Criterio de éxito:

```text
MAN datasets por debajo del 100%
No DUMP REQUIRED
NO MESSAGES OUTSTANDING
```

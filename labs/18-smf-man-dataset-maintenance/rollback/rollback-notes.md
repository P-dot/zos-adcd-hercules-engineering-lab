# Rollback Notes — LAB 18

Este lab no modificó parámetros permanentes de SMF ni parmlib.

Acciones realizadas:

- Se ejecutó `IFASMFDP` para descargar `SYS1.MAN1`, `SYS1.MAN2`, `SYS1.MAN3`.
- Se creó/catologó `IBMUSER.SMF.LAB18.RUN01` como salida del dump.
- No se modificó `SMFPRMxx`.
- No se alteraron datasets del sistema fuera del ciclo normal de dump/clear de SMF.

## Limpieza opcional

Si se desea eliminar la salida del lab:

```jcl
//DELSMF18 JOB (ACCT),'DEL SMF18',CLASS=A,MSGCLASS=X
//STEP01   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 DELETE IBMUSER.SMF.LAB18.RUN01 PURGE
 SET MAXCC = 0
/*
```

No borrar `SYS1.MAN1`, `SYS1.MAN2` ni `SYS1.MAN3`.

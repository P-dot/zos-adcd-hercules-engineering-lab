# Commands - Lab 09 ADRDSSU Backup to Hercules Virtual Tape

## 1. Inventario z/OS

Desde SDSF:

```text
/D U,,,0580,16
/D U,,,0A9B,2
```

Objetivo:

- confirmar unidades de cinta 3490 `0580`/`0581`;
- confirmar `ZVOL00` y `ZVOL01` como volúmenes de laboratorio.

## 2. Crear cinta HET en Windows

En Windows CMD, no en SDSF ni en ISPF:

```bat
mkdir F:\ZOS111\TAPES
cd /d F:\ZOS111\HERCULES
hetinit.exe F:\ZOS111\TAPES\BK0001.het BK0001
dir F:\ZOS111\TAPES
```

## 3. JCL usado para el backup

Versión simple, sin continuaciones JCL delicadas:

```jcl
//DMPZV00  JOB (ACCT),'DUMP ZVOL00',CLASS=A,MSGCLASS=X
//STEP01   EXEC PGM=ADRDSSU,REGION=0M
//SYSPRINT DD SYSOUT=*
//DASD1    DD UNIT=3390,VOL=SER=ZVOL00,DISP=SHR
//TAPE1    DD UNIT=3490,DSN=DMP.ZVOL00A,DISP=(NEW,CATLG,DELETE)
//SYSIN    DD *
 DUMP FULL INDDNAME(DASD1) OUTDDNAME(TAPE1) ALLEXCP
/*
```

## 4. Montar cinta cuando z/OS pide IEF233A

Cuando z/OS emite:

```text
IEF233A M 0581,PRIVAT,SL,DMPZV00,STEP01,DMP.ZVOL00A
```

En la consola de Hercules:

```text
devinit 0581 F:\ZOS111\TAPES\BK0001.het
```

Si z/OS pide `0580`, usar:

```text
devinit 0580 F:\ZOS111\TAPES\BK0001.het
```

## 5. Verificación

En SDSF:

```text
ST
```

Entrar en el job `DMPZV00` y revisar:

```text
JESMSGLG
JESYSMSG
SYSPRINT
```

Resultado validado:

```text
ADR013I TASK COMPLETED WITH RETURN CODE 0000
ADR012I DFSMSDSS PROCESSING COMPLETE
```

## 6. Verificar tamaño de cinta

En Windows CMD:

```bat
dir F:\ZOS111\TAPES
```

La cinta `BK0001.het` debe crecer después del backup.

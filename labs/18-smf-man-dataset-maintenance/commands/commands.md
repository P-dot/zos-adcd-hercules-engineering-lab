# LAB 18 Commands — SMF MAN Dataset Maintenance

## 1. Diagnóstico inicial

Desde SDSF o MASTER console:

```text
/D R,L
/D SMF
```

Resultado inicial observado:

```text
SYS1.MAN1  100  DUMP REQUIRED
SYS1.MAN2  100  DUMP REQUIRED
SYS1.MAN3  100  DUMP REQUIRED
```

## 2. JCL corregido: SMFDMP

Miembro:

```text
IBMUSER.HARDEN.CNTL(SMFDMP)
```

Contenido:

```jcl
//SMFDMP  JOB (ACCT),'SMF MAN DUMP',CLASS=A,MSGCLASS=X
//CLEANUP EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 DELETE IBMUSER.SMF.LAB18.RUN01 PURGE
 SET MAXCC = 0
/*
//STEP01  EXEC PGM=IFASMFDP
//SYSPRINT DD SYSOUT=*
//MAN1     DD DSN=SYS1.MAN1,DISP=SHR
//MAN2     DD DSN=SYS1.MAN2,DISP=SHR
//MAN3     DD DSN=SYS1.MAN3,DISP=SHR
//OUTSMF   DD DSN=IBMUSER.SMF.LAB18.RUN01,
//            DISP=(NEW,CATLG,DELETE),
//            UNIT=3390,VOL=SER=ZVOL00,
//            SPACE=(CYL,(50,5)),
//            DCB=(RECFM=VBS,LRECL=32760,BLKSIZE=27998)
//SYSIN    DD *
 INDD(MAN1,OPTIONS(ALL))
 INDD(MAN2,OPTIONS(ALL))
 INDD(MAN3,OPTIONS(ALL))
 OUTDD(OUTSMF,TYPE(0:255))
/*
```

## 3. Submit

Desde ISPF edit:

```text
SUB
```

O desde TSO:

```text
SUBMIT 'IBMUSER.HARDEN.CNTL(SMFDMP)'
```

## 4. Verificación en SDSF

```text
ST
S SMFDMP
```

Comprobar:

```text
SMFDMP STEP01 - COND CODE 0000
OUTSMF catalogado
```

## 5. Verificación final

```text
/D SMF
/D R,L
```

Resultado final esperado:

```text
SYS1.MAN1  0  ALTERNATE
SYS1.MAN2  0  ACTIVE
SYS1.MAN3  0  ALTERNATE
NO MESSAGES OUTSTANDING
```

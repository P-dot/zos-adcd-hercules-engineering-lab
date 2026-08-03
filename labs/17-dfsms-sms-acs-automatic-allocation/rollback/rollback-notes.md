# Rollback Notes — LAB 17

This lab changed the active SMS configuration by activating `SYS1.SCDS` and enabling `SMSPOOL` with volumes `SMS000`, `SMS001`, and `SMS002`.

## Safe cleanup of the test dataset

```jcl
//DELSMS   JOB (ACCT),'DEL SMSLAB',CLASS=A,MSGCLASS=X
//STEP01   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 DELETE IBMUSER.SMSLAB.TEST1 PURGE
 SET MAXCC = 0
/*
```

## Disable lab volumes from SMS allocation

MASTER console:

```text
V SMS,VOLUME(SMS000),DISABLE
V SMS,VOLUME(SMS001),DISABLE
V SMS,VOLUME(SMS002),DISABLE
V SMS,STORGRP(SMSPOOL),DISABLE
```

## Revert ACS routing to original lab-default behavior

Only do this if the goal is to remove the `IBMUSER.SMSLAB.*` route.

`IBMUSER.HARDEN.CNTL(ACSSTOR)`:

```text
PROC STORCLAS
SET &STORCLAS = ''
END
```

`IBMUSER.HARDEN.CNTL(ACSGRP)`:

```text
PROC STORGRP
SET &STORGRP = 'DBCLASS'
END
```

Then translate, validate, test if needed, and activate `SYS1.SCDS` again from ISMF.

## Caution

Do not delete `SMS000/SMS001/SMS002` CCKD files while catalog entries still reference datasets on those volumes. If the system has cataloged datasets on `SMS001`, removing the device from Hercules without cleanup will leave catalog entries pointing to unavailable volumes.

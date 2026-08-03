# Findings — LAB 17 DFSMS/SMS ACS Automatic Allocation

## Baseline

At the start of the lab, SMS infrastructure existed but the new lab pool was not operational.

Observed baseline:

```text
D SMS
SCDS = SYS1.SCDS
ACDS = SYS1.ACDS
COMMDS = SYS1.COMMDS
```

But:

```text
D SMS,STORGRP(SMSPOOL)
STORAGE GROUP SMSPOOL IS NOT DEFINED

D SMS,VOLUME(SMS000)
VOLUME SMS000 IS NOT AN SMS MANAGED DASD VOLUME
```

## ACS policy created

Storage Class routine:

```text
PROC STORCLAS
IF &DSN(1) = 'IBMUSER' AND &DSN(2) = 'SMSLAB' THEN
  SET &STORCLAS = 'SMSLAB'
ELSE
  SET &STORCLAS = ''
END
```

Storage Group routine:

```text
PROC STORGRP
IF &STORCLAS = 'SMSLAB' THEN
  SET &STORGRP = 'SMSPOOL'
ELSE
  SET &STORGRP = 'DBCLASS'
END
```

This preserves the active default behavior from `SYS1.SMS.CNTL(DUMMYCL)` and `SYS1.SMS.CNTL(DUMMYGP)` while adding controlled routing for `IBMUSER.SMSLAB.*`.

## Validation and test

ACS test result:

```text
ACS TESTING RC: 00
SC = SMSLAB
SG = SMSPOOL
```

This proved the ACS decision path before activation.

## Activation

`SYS1.SCDS` was activated successfully.

Observed message:

```text
NEW CONFIGURATION ACTIVATED FROM SCDS SYS1.SCDS
```

After activation, `SMSPOOL` and volumes `SMS000`, `SMS001`, `SMS002` were visible under SMS.

## Real-world troubleshooting encountered

### Problem 1 — volumes not initialized as SMS-managed

Failure:

```text
IGD17273I ALLOCATION HAS FAILED FOR ALL VOLUMES SELECTED
IGD17279I 3 VOLUMES WERE REJECTED BECAUSE THEY WERE NOT INITIALIZED (04160054)
```

Resolution:

Use ICKDSF `INIT` with indexed VTOC and `SG`.

### Problem 2 — SMS volume status disabled

Failure:

```text
IGD17279I 3 VOLUMES WERE REJECTED BECAUSE THE SMS VOLUME STATUS WAS DISABLED
```

Resolution:

```text
V SMS,STORGRP(SMSPOOL),ENABLE
V SMS,VOLUME(SMS000),ENABLE
V SMS,VOLUME(SMS001),ENABLE
V SMS,VOLUME(SMS002),ENABLE
```

## Final verification

Final LISTCAT shows:

```text
NONVSAM -------- IBMUSER.SMSLAB.TEST1
STORAGECLASS --- SMSLAB
VOLSER --------- SMS001
IDCAMS PROCESSING COMPLETE - MAXIMUM CONDITION CODE WAS 0
```

`SMS001` was previously shown as a volume in `SMSPOOL`, proving policy-driven placement.

## Remaining controlled warning

Validation still warned that `HFSCLASS` is not referenced by the Storage Group ACS routine. This is accepted for this controlled lab, but an enterprise-grade SMS policy would preserve or implement explicit routing for HFS/zFS-related storage classes.

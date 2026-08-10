# JCL and Member Changes

## ADCD.Z111S.PARMLIB(EDGRMM00)

Configured to use the local DFSMSrmm infrastructure:

```text
RMM.CONTROL.DATASET
RMM.JOURNAL.DATASET
CDSID(RMM1)
```

## ADCD.Z111S.PROCLIB(DFRMM)

Copied from the installed IBM sample and retained as the local DFSMSrmm started procedure.

The PDA DD statements resolve through `&SYSNAME` to:

```text
RMM.ADCD.EDGPDOX
RMM.ADCD.EDGPDOY
```

## RMM control-data-set initialization

```jcl
//CREATE   EXEC PGM=EDGUTIL,PARM='CREATE'
//MASTER   DD DISP=SHR,DSN=RMM.CONTROL.DATASET
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  CONTROL CDSID(RMM1)
/*
```

## ADCD.Z111S.PARMLIB(IEFSSNDB)

DFSMSrmm SSI definition:

```text
SUBSYS SUBNAME(DFRM)
  INITRTN(EDGSSSI)
```

This change requires an IPL before the new subsystem definition is available in the running system.

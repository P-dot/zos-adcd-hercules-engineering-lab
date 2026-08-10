# LAB 19 — DFSMSrmm Activation and Runtime Validation

## Objective

Activate IBM DFSMSrmm on the personal z/OS ADCD 1.11 system running under Hercules and validate the complete runtime chain from PARMLIB/PROCLIB configuration to SSI registration and successful started-task initialization.

This lab was not treated as a simple `START` command exercise. The implementation was built from the IBM-supplied DFSMSrmm samples available in the installed system, adapted to the actual ADCD environment, tested through multiple failure modes, and validated after an IPL.

## Environment

- Platform: IBM z/OS ADCD 1.11 on Hercules
- System name: `ADCD`
- Operator console: MASTER / L700
- Operational user: `IBMUSER`
- Active PARMLIB: `ADCD.Z111S.PARMLIB`
- Local PROCLIB: `ADCD.Z111S.PROCLIB`
- Active IEASYS member: `IEASYSDB`
- SSI member selected by IEASYS: `IEFSSNDB`
- Target component: IBM DFSMSrmm
- Started task: `DFRMM`
- SSI subsystem name: `DFRM`

## Initial State

DFSMSrmm was installed in the ADCD image but was not fully activated as an operational subsystem.

The implementation therefore required more than copying a procedure. The following pieces had to be aligned:

1. DFSMSrmm PARMLIB options.
2. The DFRMM started procedure.
3. The RMM control data set.
4. The RMM journal.
5. Problem Determination Aid (PDA) data sets.
6. SSI subsystem registration.
7. IPL processing of the new SSI definition.
8. Runtime validation from the console and SDSF.

## IBM-Supplied Samples Used

The implementation was based on the samples already present in `SYS1.SAMPLIB`, including:

- `EDGRMM00` — DFSMSrmm PARMLIB sample.
- `EDGDFRMM` — DFSMSrmm started procedure sample.
- `EDGUTIL` / `EDGJUTIL` — control-record initialization.
- `EDGJMFAL` — control data set allocation sample.
- `EDGJNLAL` — journal allocation sample.

Using the installed samples was important because the lab is tied to the actual DFSMSrmm level shipped with this ADCD system rather than to assumptions from a newer release.

## 1. DFSMSrmm PARMLIB Configuration

A local DFSMSrmm parameter member was prepared as:

```text
ADCD.Z111S.PARMLIB(EDGRMM00)
```

The configuration references the local RMM infrastructure created in this lab, including:

```text
RMM.CONTROL.DATASET
RMM.JOURNAL.DATASET
CDSID(RMM1)
```

The successful startup later confirmed that DFSMSrmm was reading this exact member:

```text
EDG0204I DFSMSRMM BEING INITIALIZED FROM MEMBER
EDGRMM00 IN ADCD.Z111S.PARMLIB
```

## 2. DFRMM Started Procedure

The IBM sample procedure was copied into the local PROCLIB:

```text
SYS1.SAMPLIB(EDGDFRMM)
        ->
ADCD.Z111S.PROCLIB(DFRMM)
```

The procedure uses the `M=00` suffix to select `EDGRMM00`.

The local master JCL confirms that `ADCD.Z111S.PROCLIB` is searched before `SYS1.PROCLIB`, so the local `DFRMM` procedure is available to the START command.

## 3. RMM Control Data Set

Before allocation, the catalog was checked:

```text
LISTCAT ENT('RMM.CONTROL.DATASET') ALL
```

The entry did not exist.

A working copy of the IBM `EDGJMFAL` sample was customized in:

```text
IBMUSER.HARDEN.CNTL(RMMCDS)
```

The control data set was defined as a VSAM cluster using the attributes supplied by the installed IBM sample, including:

```text
NAME(RMM.CONTROL.DATASET)
KEYS(56 0)
RECORDSIZE(512 9216)
FREESPACE(15 0)
SHR(3 3)
```

The target DASD volume was the ADCD system volume selected during the lab:

```text
SBSYS1
```

The allocation completed with condition code `0000`.

## 4. Control Record Initialization

The newly allocated control data set then had to be initialized.

A working copy of the EDGUTIL sample was created as:

```text
IBMUSER.HARDEN.CNTL(RMMINIT)
```

The key execution statements were:

```jcl
//CREATE   EXEC PGM=EDGUTIL,PARM='CREATE'
//MASTER   DD DISP=SHR,DSN=RMM.CONTROL.DATASET
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  CONTROL CDSID(RMM1)
/*
```

This initialized the CDS with the identifier used by `EDGRMM00`.

The job completed successfully.

## 5. RMM Journal

The IBM `EDGJNLAL` sample was adapted to create:

```text
RMM.JOURNAL.DATASET
```

The working member was:

```text
IBMUSER.HARDEN.CNTL(RMMJRN)
```

The journal allocation completed successfully with condition code `0000`.

## 6. First DFRMM Startup Failure — Device Allocation

The first attempts to start DFSMSrmm produced:

```text
IEF132I START COMMAND DEVICE ALLOCATION ERROR
```

Inspection of the local `DFRMM` procedure showed two active DD statements:

```text
//EDGPDOX DD DISP=SHR,DSN=RMM.&SYSNAME..EDGPDOX
//EDGPDOY DD DISP=SHR,DSN=RMM.&SYSNAME..EDGPDOY
```

With `SYSNAME=ADCD`, these resolve to:

```text
RMM.ADCD.EDGPDOX
RMM.ADCD.EDGPDOY
```

Catalog checks confirmed that both data sets were missing.

They were allocated as the DFSMSrmm PDA log data sets. After this correction, the device-allocation failure disappeared.

This was an important troubleshooting point: the failure occurred before DFSMSrmm initialization and was caused by DD allocation requirements in the started procedure, not by the CDS or journal.

## 7. Second Startup Failure — SSI Subsystem Missing

After fixing the PDA data sets, `DFRMM` advanced far enough to issue:

```text
EDG0102E STARTED TASK ENDED BECAUSE THE DFSMSRMM
SUBSYSTEM IS NOT DEFINED AS A SUBSYSTEM
```

The runtime IPL configuration was traced through:

```text
D IPLINFO
```

which confirmed:

```text
IEASYS LIST = DB
```

`IEASYSDB` contained:

```text
SSN=DB
```

Therefore the active SSI definition member was:

```text
ADCD.Z111S.PARMLIB(IEFSSNDB)
```

The DFSMSrmm subsystem was added using the same structured syntax already used by the existing subsystem definitions:

```text
SUBSYS SUBNAME(DFRM)
  INITRTN(EDGSSSI)
```

An IPL was then required so z/OS could process the modified `IEFSSNDB`.

## 8. IPL and SSI Validation

After the IPL, SYSLOG evidence confirmed that the new subsystem definition had been processed and that `DFRM` was registered.

The SYSLOG search also confirmed that `IEFSSNDB` was the member processed during system initialization.

This established the complete relationship:

```text
IEASYSDB
   |
   +-- SSN=DB
         |
         +-- IEFSSNDB
               |
               +-- SUBSYS SUBNAME(DFRM)
                     INITRTN(EDGSSSI)
```

## 9. Successful DFSMSrmm Startup

DFSMSrmm was started manually:

```text
S DFRMM
```

The decisive runtime messages were:

```text
$HASP373 DFRMM STARTED

EDG0204I DFSMSRMM BEING INITIALIZED FROM MEMBER
EDGRMM00 IN ADCD.Z111S.PARMLIB

EDG0117I PROBLEM DETERMINATION OUTPUT DATA SETS SWAPPED

EDG0105I DFSMSRMM SUBSYSTEM INITIALIZATION COMPLETE
```

`EDG0105I` is the key completion message for this lab.

SDSF `DA` then showed `DFRMM` as an active started task.

## 10. Command-Syntax Troubleshooting

After the successful startup, the following command was tested:

```text
F DFRMM,D
```

DFSMSrmm returned:

```text
EDG1102E INCORRECT DFSMSrmm COMMAND OPERAND - D
```

This was not an initialization failure. It only showed that `D` is not a valid DFSMSrmm MODIFY operand.

The started task remained operational.

## Architecture Established by the Lab

```text
IEASYSDB
   |
   +-- SSN=DB
         |
         +-- IEFSSNDB
               |
               +-- DFRM / EDGSSSI
                         |
                         +-- DFRMM started procedure
                               |
                               +-- EDGRMM00
                               |
                               +-- RMM.CONTROL.DATASET
                               |
                               +-- RMM.JOURNAL.DATASET
                               |
                               +-- RMM.ADCD.EDGPDOX
                               |
                               +-- RMM.ADCD.EDGPDOY
```

## Evidence

The `evidence/` directory contains the complete implementation trail.

The most important final evidence is:

- `39-iefssndb-dfrm-subsystem-definition.png` — DFRM added to the active SSI member.
- `42-syslog-dfrm-subsystem-registration-after-ipl.png` — DFRM registered after IPL.
- `43-syslog-iefssndb-processing-evidence.png` — SYSLOG evidence that IEFSSNDB was processed.
- `44-dfsmsrmm-successful-initialization-edg0105i.png` — successful DFSMSrmm initialization.
- `45-sdsf-da-dfrmm-active-started-task.png` — DFRMM active in SDSF DA.

See [`evidence/README.md`](evidence/README.md) for a description of every screenshot.

## Final State

```text
DFSMSrmm parameter member             OK
DFRMM local started procedure         OK
RMM control data set                  OK
RMM control record / CDSID(RMM1)      OK
RMM journal                           OK
PDA data sets                         OK
DFRM SSI subsystem                    OK
IEFSSNDB processed at IPL              OK
DFSMSrmm initialization               OK
DFRMM active in SDSF                  OK
LAB 19                                CLOSED
```

## Professional Value

This lab demonstrates end-to-end z/OS systems-programming work rather than a single command:

- installed-product discovery,
- IBM sample analysis,
- PARMLIB and PROCLIB engineering,
- VSAM control-data-set creation,
- journal provisioning,
- started-task troubleshooting,
- SSI subsystem configuration,
- IPL dependency analysis,
- SYSLOG validation,
- SDSF runtime verification.

The result is a reproducible evidence trail showing how an installed z/OS component was taken from an incomplete configuration to a verified operational state.

# Lab 38 — LOGREC Dataset Maintenance and SMF Exit Operational Validation

## Objective

Perform controlled maintenance of the active z/OS LOGREC data set on the
ADCD z/OS 1.11 system, diagnose and correct an initial JCL allocation failure
using IBM samples installed with the running release, verify system health
after the operation, and correlate SMF exit configuration with effective SMF
options and the Dynamic Exits Facility.

The lab is intentionally evidence-driven. No destructive change is accepted
until the active LOGREC target and system state are identified, and no dynamic
SMF exit registration is forced merely to produce a successful display.

## Environment

- IBM z/OS V1R11 ADCD laboratory system
- Hercules/zPDT-style single-system lab environment
- TSO/ISPF
- SDSF / JES2
- SMF
- LOGREC / Hardware Event Recorder
- IBM utility `IFCDIP00`
- PARMLIB and `SYS1.SAMPLIB`

## Scope

This lab covers two related operational areas:

1. controlled reinitialization/maintenance of the existing `SYS1.LOGREC` data
   set;
2. read-only validation of SMF exit configuration and its relationship with
   the Dynamic Exits Facility.

It does **not** install an SMF exit, alter `SMFPRM00`, issue `SETPROG EXIT`
changes, delete/reallocate LOGREC, or change the active SMF MAN data sets.

## Starting baseline

### SMF

`D SMF` showed a healthy MAN data-set configuration inherited from the earlier
SMF sizing/rotation work. `SYS1.MAN1` was ACTIVE and the remaining MAN data
sets were available as ALTERNATE data sets, including the additional MAN4,
MAN5 and MAN6 allocations on the laboratory volume.

### Dynamic exits

`D PROG,EXIT` returned the system Dynamic Exits Facility inventory. This was
recorded as an infrastructure baseline only; it was not treated as proof that
every IEFUxx exit configured for SMF was dynamically registered.

### LOGREC identification

ISPF and SYSLOG evidence identified the active Hardware Event Recorder data
set as:

```text
SYS1.LOGREC
```

The recorded allocation/catalog characteristics included:

| Attribute | Observed value |
|---|---|
| Data set | `SYS1.LOGREC` |
| Volume | `SBSYS1` |
| Device type | `3390` |
| Organization | `PSU` |
| Record format | `U` |
| Block size | `1944` |
| Allocated cylinders | `6` |
| Used cylinders at baseline | `6` |
| Allocated extents | `1` |
| Catalog | `CATALOG.Z111S.MASTER` |

`LISTCAT ENT('SYS1.LOGREC') ALL` independently confirmed the non-VSAM catalog
entry and volume association.

## Pre-maintenance control

`D A,L` was captured before maintenance to establish the active address-space
baseline. JES2, VTAM, RACF, TSO, SDSF, TCP/IP, Db2 and CICS-related work was
visible in the system state.

The purpose was not to prove application functionality, but to establish a
repeatable before/after operational checkpoint.

## Initial JCL failure and diagnosis

The first LOGR38 submission failed during JCL processing:

```text
IEFC001I LOGR38 CLEAR SERERDS - UNIT FIELD SPECIFIES INCORRECT DEVICE NAME
IEF272I LOGR38 CLEAR - STEP WAS NOT EXECUTED
```

This distinction matters: `IFCDIP00` had **not executed**, therefore that
submission did not perform LOGREC maintenance.

The failed definition is retained under
`jcl/LOGR38-failed-reference.jcl` strictly as troubleshooting evidence and is
marked **DO NOT SUBMIT**.

## Release-local IBM sample investigation

Instead of continuing to guess allocation parameters, the installed z/OS 1.11
sample library was searched. `SYS1.SAMPLIB` contained:

```text
IFCDIPS1
IFCDIPS2
```

Both are IBM-supplied `IFCDIP00` samples for LOGREC processing. Their relevant
pattern established the release-local requirements:

```jcl
//STEP1    EXEC PGM=IFCDIP00
//SYSPRINT DD SYSOUT=*
//SYSABEND DD SYSOUT=*
//SERERDS  DD DSN=<LOGREC>,DISP=SHR
```

This was the decisive troubleshooting step. The final laboratory JCL was
aligned with the samples installed on the same z/OS release rather than with
assumptions derived from a different release.

## Final controlled maintenance JCL

The successful member was `IBMUSER.HARDEN.CNTL(LOGR38)`:

```jcl
//LOGR38   JOB (ACCT),'LAB38 LOGREC',
//             CLASS=A,MSGCLASS=H,MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID
//*
//* LAB 38 - LOGREC CONTROLLED MAINTENANCE
//* TARGET: SYS1.LOGREC
//* JCL ALIGNED WITH SYS1.SAMPLIB(IFCDIPS1/IFCDIPS2)
//*
//CLEAR    EXEC PGM=IFCDIP00
//SYSPRINT DD SYSOUT=*
//SYSABEND DD SYSOUT=*
//SERERDS  DD DSN=SYS1.LOGREC,DISP=SHR
```

The reusable source is stored in `jcl/LOGR38.jcl`.

## Successful execution

The corrected job was submitted only after the release-local sample validation.
JES executed the `CLEAR` step and the job completed successfully with condition
code 0000.

The `IFCDIP00` output included:

```text
IFC001I ... DIP COMPLETE
```

This is the primary execution evidence that the LOGREC maintenance operation
completed rather than merely passing JCL conversion.

## Post-maintenance validation

The operation was followed by read-only checks:

```text
D A,L
D SMF
```

The principal system components remained active and the SMF MAN configuration
remained healthy. SYSLOG was also searched again for LOGREC-related messages,
confirming that the system continued to identify `SYS1.LOGREC` after the
operation.

The lab therefore records both the utility RC and the operational state around
the change.

## SMF exit validation

The second half of the lab examined the effective SMF exit configuration.

`D SMF,O` displayed the effective SMF parameters. Exit-related options were
shown as originating from PARMLIB. The active configuration was then compared
with the read-only contents of:

```text
ADCD.Z111S.PARMLIB(SMFPRM00)
```

The member contains `SYS(EXITS(...))` and `SUBSYS(STC,EXITS(...))` definitions,
including exits such as `IEFU83` and `IEFU84`.

Targeted displays were then issued:

```text
D PROG,EXIT,EXITNAME=IEFU83
D PROG,EXIT,EXITNAME=IEFU84
```

The key operational conclusion is that these are different layers of evidence:

```text
SMFPRM00
   -> configured SMF exit options

D SMF,O
   -> effective SMF options

D PROG,EXIT
   -> Dynamic Exits Facility registrations
```

An IEFUxx exit being configured and effective for SMF does not, by itself,
prove that the same exit is registered through the Dynamic Exits Facility.
The lab deliberately stops at read-only validation and does not issue a
`SETPROG` change to manufacture a registration.

## Commands used

The complete ordered command/runbook is in:

```text
commands/commands.txt
```

Core operator commands were:

```text
D SMF
D PROG,EXIT
D A,L
D SMF,O
D PROG,EXIT,EXITNAME=IEFU83
D PROG,EXIT,EXITNAME=IEFU84
```

Additional investigation used ISPF 3.4, SDSF SYSLOG searches, `SYS1.SAMPLIB`,
`SMFPRM00`, and:

```text
LISTCAT ENT('SYS1.LOGREC') ALL
```

## Safety and change-control decisions

The lab intentionally did **not** perform the following actions:

- no direct edit of `SYS1.LOGREC`;
- no delete/reallocate cycle for `SYS1.LOGREC`;
- no speculative third-party JCL once the z/OS 1.11 samples were located;
- no `SET SMF=xx` change during this workflow;
- no modification of `SMFPRM00`;
- no `SETPROG EXIT` modification;
- no forced dynamic registration of IEFU83/IEFU84.

The initial failed job is retained because it demonstrates a realistic
problem-determination sequence: detect the failure, prove that the utility did
not run, consult the release-local IBM samples, correct the JCL, execute with
RC=0000, and perform post-change validation.

## Results

| Control point | Result |
|---|---|
| Active LOGREC identified | PASS |
| LOGREC physical/catalog attributes recorded | PASS |
| Pre-change active-system baseline | PASS |
| Initial JCL failure diagnosed | PASS |
| Failed step proven not executed | PASS |
| z/OS 1.11 IBM IFCDIP samples located | PASS |
| Final JCL aligned to installed samples | PASS |
| `IFCDIP00` executed | PASS |
| `DIP COMPLETE` observed | PASS |
| Condition code | `0000` |
| Post-change active-system check | PASS |
| Post-change SMF check | PASS |
| Effective SMF exit options inspected | PASS |
| `SMFPRM00` correlated read-only | PASS |
| IEFU83/IEFU84 dynamic-exit checks | PASS |
| Unnecessary configuration changes avoided | PASS |

## Evidence

The screenshots under `evidence/screenshots/` preserve the full working record
supplied for the lab, including:

- SMF and Dynamic Exits Facility baselines;
- SYSLOG LOGREC identification;
- `SYS1.LOGREC` allocation and LISTCAT evidence;
- pre-maintenance `D A,L`;
- initial JCL error;
- `SYS1.SAMPLIB` discovery;
- `IFCDIPS1` and `IFCDIPS2` source;
- corrected LOGR38 JCL;
- successful JES/IFCDIP00 output and `DIP COMPLETE`;
- post-maintenance `D A,L` and `D SMF`;
- `D SMF,O` effective parameters;
- `SMFPRM00` exit definitions;
- targeted IEFU83/IEFU84 dynamic-exit displays.

## Repository layout

```text
lab38-final/
├── README.md
├── commands/
│   └── commands.txt
├── docs/
│   ├── smf-exit-validation.md
│   └── troubleshooting.md
├── jcl/
│   ├── LOGR38.jcl
│   └── LOGR38-failed-reference.jcl
└── evidence/
    └── screenshots/
```

## Operational lessons

1. A JCL conversion/allocation failure must not be described as a utility
   execution failure when the step never ran.
2. Installed IBM samples for the running release are a high-value source when
   system utilities have release-sensitive JCL requirements.
3. Successful maintenance requires post-change system validation, not only an
   RC=0000.
4. SMF exit configuration, effective SMF options and Dynamic Exits Facility
   registration are related but distinct concepts.
5. A read-only validation is preferable to an unnecessary configuration
   change when the learning objective has already been proven.

## References

- IBM z/OS V1R11 installed sample library: `SYS1.SAMPLIB(IFCDIPS1)`
- IBM z/OS V1R11 installed sample library: `SYS1.SAMPLIB(IFCDIPS2)`
- Active PARMLIB member: `ADCD.Z111S.PARMLIB(SMFPRM00)`
- IBM z/OS system messages and operator-command output captured in the lab
- Previous repository SMF/LOGREC baseline work used only as environmental
  context; this lab focuses on controlled LOGREC maintenance and exit
  validation.

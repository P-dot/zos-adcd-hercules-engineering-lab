# Lab 23 — RACF Security Baseline & Privileged Authority Audit — Part 1

**Status:** COMPLETED — PART 1  
**Assessment mode:** Read-only security assessment  
**Platform:** IBM z/OS ADCD under Hercules

## Objective

Establish a repeatable RACF security baseline and identify privileged
authorities using native IBM facilities.

The lab covers:

- RACF user/group discovery
- SETROPTS baseline
- DSMON security reporting
- RACF database topology
- IRRDBU00 database unload
- RACF unload inspection
- IBM RACFICE deployment
- DFSORT / ICETOOL troubleshooting
- UGRP group authority review
- UGLB global privileged authority review

No destructive RACF hardening was performed in Part 1.

## Initial discovery

Commands used included:

    LISTUSER IBMUSER
    LISTGRP SYS1
    SEARCH CLASS(USER)
    SETROPTS LIST
    RVARY LIST

The objective was to understand the current RACF security model before
performing any remediation.

## DSMON baseline

DSMON was executed with:

    PGM=ICHDSM00

Final result:

    RC=0000

The resulting reports included selected user attributes, started
procedures, RACF classes, global access information, group hierarchy,
program properties and selected data sets.

## RACF database topology

RVARY LIST confirmed:

    PRIMARY : SYS1.RACFDS
    BACKUP  : SYS1.RACFDS.BACKUP

The backup database was used as the input source for the unload.

## IRRDBU00

IRRDBU00 was used to produce:

    IBMUSER.RACF.UNLOAD

The first execution failed because a mandatory input-handling option
was missing.

Corrected execution:

    PARM=LOCKINPUT

Final result:

    RC=0000

## RACF unload

The resulting unload data set was validated in ISPF:

    DSNAME : IBMUSER.RACF.UNLOAD
    DSORG  : PS
    RECFM  : VB
    LRECL  : 4096

Direct Browse inspection confirmed real RACF user, group, data set,
certificate, started-task and general-resource information.

## DFSORT / ICETOOL diagnostics

Troubleshooting included:

    ICE251A
    MISSING RDW OR DATA FOR OUTREC

and:

    ICE218A
    VARIABLE RECORD IS SHORTER THAN REQUIRED MINIMUM

Key lessons:

- VB records contain a 4-byte RDW
- logical data begins at position 5
- VLSHRT can be required
- RC=0000 alone does not prove semantic correctness

## IBM RACFICE

IBM RACFICE material was located in:

    SYS1.SAMPLIB(IRRICE)

IEBUPDTE was used to build:

    IBMUSER.RACFICE

Final build:

    RC=0000

The resulting library includes:

    RACFICE
    UGLB
    UGLBCNTL
    UGRP
    UGRPCNTL
    CONN

The local RACFICE procedure was configured to use:

    DBUDATA = IBMUSER.RACF.UNLOAD
    ICECNTL = IBMUSER.RACFICE

## UGRP result

Extraordinary group-level authority:

    GROUP-SPECIAL      : 0
    GROUP-OPERATIONS   : 0
    GROUP-AUDITOR      : 0

## UGLB result

IBM RACFICE UGLB completed:

    RC=0000

| User ID | SPECIAL | OPERATIONS | AUDITOR |
|---|---|---|---|
| ADCDMST | YES | YES | NO |
| DB8GRFSH | NO | YES | NO |
| DB9GENV5 | NO | YES | NO |
| DB9GRFSH | NO | YES | NO |
| IBMUSER | YES | YES | NO |
| START1 | NO | YES | NO |
| SYSOPR | YES | NO | NO |

Totals:

    SPECIAL      : 3
    OPERATIONS   : 6
    AUDITOR      : 0

SPECIAL users:

    ADCDMST
    IBMUSER
    SYSOPR

OPERATIONS users:

    ADCDMST
    DB8GRFSH
    DB9GENV5
    DB9GRFSH
    IBMUSER
    START1

SPECIAL + OPERATIONS:

    ADCDMST
    IBMUSER

## Security observations

IBMUSER remains a highly privileged administrative identity.

START1 is a technical/start-task-oriented identity and must not be
treated as a normal interactive account.

Several DB2-related identities retain OPERATIONS and require functional
analysis before any hardening decision.

## Troubleshooting evidence

Part 1 intentionally retains failures as engineering evidence.

Examples include:

    IEFC621I EXPECTED CONTINUATION NOT RECEIVED
    IEFC605I UNIDENTIFIED OPERATION FIELD
    ICE251A
    ICE218A
    IRRDBU00 RC=0016
    RACFICE symbolic-allocation issues

The final IRRDBU00, RACFICE build and UGLB report all completed
successfully.

## Completion criteria

- [x] RACF user/group discovery
- [x] SETROPTS baseline
- [x] DSMON RC=0000
- [x] primary/backup RACF database inventory
- [x] IRRDBU00 unload RC=0000
- [x] RACF unload validation
- [x] unload record inspection
- [x] DFSORT/ICETOOL troubleshooting
- [x] IBM RACFICE deployment
- [x] RACFICE build RC=0000
- [x] UGRP assessment
- [x] UGLB RC=0000
- [x] SPECIAL inventory
- [x] OPERATIONS inventory
- [x] evidence preserved
- [x] no destructive RACF changes

## Part 2

Part 2 will continue with:

    CONN
      ↓
    privileged group connections
      ↓
    full privileged identity matrix
      ↓
    technical vs human account classification
      ↓
    least-privilege assessment
      ↓
    controlled remediation plan
      ↓
    rollback + validation

## Final status

**LAB 23 PART 1 — COMPLETED**

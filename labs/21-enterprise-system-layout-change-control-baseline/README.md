# LAB 21 - Enterprise System Layout and Change-Control Baseline

## Purpose

This lab establishes an enterprise-style baseline for a single-system z/OS ADCD 1.11 environment running on Hercules.

The goal is not to change the system. The goal is to understand and document the current state before applying future hardening, automation, RACF, SMF, DFSMS, z/OS UNIX, CICS or DB2 changes.

A real z/OS installation is operated through controlled baselines: hardware/logical devices, volumes, catalogs, PARMLIB, PROCLIB, started tasks, security classes, audit status and rollback paths. This lab creates that first controlled baseline.

## Environment

```text
Platform:        z/OS ADCD 1.11
Emulation:       Hercules
System name:     ADCD
Sysplex name:    ADCDPL
Primary user:    IBMUSER
Main interface:  3270 / ISPF / SDSF / TSO command shell
Repository path: labs/21-enterprise-system-layout-change-control-baseline
```

## Scope

This lab documents:

```text
1. IPL and system identity
2. PARMLIB concatenation
3. System symbols
4. Online DASD and selected volume details
5. SMF and SMS status
6. Pending system requests
7. SDSF DA/ST runtime inventory
8. SYSLOG startup/runtime evidence
9. ADCD/SYS1/IBMUSER dataset layout
10. Catalog aliases and user catalogs through IDCAMS LISTCAT
11. RACF user/group/global options baseline
12. RACF STARTED class baseline
13. RACF FACILITY class baseline
14. RACF OPERCMDS class baseline
```

## Commands executed

The full command explanation is documented in [COMMANDS.md](COMMANDS.md). The command families were:

```text
D IPLINFO
D PARMLIB
D SYMBOLS
D U,DASD,ONLINE
D U,VOL=SBRES1
D U,VOL=SBRES2
D U,VOL=SBSYS1
D U,VOL=ZVOL00
D SMF
D SMS
D R,L
SDSF DA
SDSF ST
SDSF LOG
SDSF SR
ISPF 3.4: ADCD.*, SYS1.*, IBMUSER.*, **.PARMLIB, **.PROCLIB
IDCAMS LISTCAT ALIAS
IDCAMS LISTCAT UCAT ALL
LISTUSER IBMUSER
LISTGRP SYS1
SETROPTS LIST
RLIST STARTED * ALL
RLIST FACILITY * ALL
RLIST OPERCMDS * ALL
```

## Key findings

### System identity

```text
z/OS release:     01.11.00
System name:      ADCD
Sysplex name:     ADCDPL
IEASYS list:      00
IEASYM list:      00
```

### PARMLIB chain

The system uses a layered PARMLIB structure:

```text
USER.PARMLIB
ADCD.Z111S.PARMLIB
SYS1.PARMLIB
```

Enterprise interpretation:

```text
USER.PARMLIB         local/user customization layer
ADCD.Z111S.PARMLIB  ADCD customization layer
SYS1.PARMLIB        base system layer
```

### DASD / volume baseline

Initial online DASD and selected volume details were captured. Important volumes include:

```text
SBRES1
SBRES2
SRSYS1
SBUSS1
SBSYS1
SBBBN2
SBPRD1
SBPRD2
ZVOL00
```

### SMF status

SMF is active and multiple MAN datasets are configured. One important operational finding was observed:

```text
SYS1.MAN4 on ZVOL00: DUMP REQUIRED
```

This is not remediated in this lab. It becomes a controlled follow-up task for SMF MANx dump/rotation.

### SMS status

SMS is active and uses:

```text
SCDS:   SYS1.SCDS
ACDS:   SYS1.ACDS
COMMDS: SYS1.COMMDS
```

### Catalog baseline

IDCAMS completed successfully with:

```text
MAXCC=0
```

Catalog aliases and user catalog information were collected through:

```text
LISTCAT ALIAS
LISTCAT UCAT ALL
```

### RACF baseline

RACF was reviewed in read-only mode. The lab captured:

```text
IBMUSER profile
SYS1 group
SETROPTS global options
STARTED class profiles
FACILITY class profiles
OPERCMDS class profiles
```

Important interpretation:

```text
IBMUSER is a highly privileged laboratory administrator.
Many critical profiles are owned or alterable by IBMUSER.
UACC(NONE) appears on several sensitive profiles.
STARTED, FACILITY and OPERCMDS provide a realistic base for enterprise-style hardening labs.
```

## Evidence

All screenshots are stored under:

```text
evidence/01-system-runtime/
evidence/02-storage-catalog-racf/
```

The evidence index is in:

```text
docs/evidence-index.md
```

## Change-control status

No destructive configuration change was applied in this lab.

```text
Mode:             read-only baseline
System changed:   no
RACF changed:     no
PARMLIB changed:  no
PROCLIB changed:  no
Catalog changed:  no
Risk:             low
Rollback needed:  no
```

## Follow-up labs

Recommended next controlled labs:

```text
LAB 22 - SMF MANx dump and rotation operational procedure
LAB 23 - RACF privileged user and group baseline
LAB 24 - RACF STARTED class hardening review
LAB 25 - FACILITY and OPERCMDS security review
LAB 26 - PARMLIB/PROCLIB change-register and rollback model
```

## Final result

```text
Enterprise baseline: established
System inventory: captured
Storage baseline: captured
Catalog baseline: captured
Security baseline: captured
Change control posture: ready for next phase
```

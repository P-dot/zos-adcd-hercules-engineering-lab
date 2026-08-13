# LAB 21 - Enterprise System Layout and Change-Control Baseline - Commands

This file explains each command used in the lab. The intention is to understand what each command proves, not to run commands blindly.

---

## 1. System identity

### `D IPLINFO`

```text
D IPLINFO
```

Displays how the current z/OS image was IPLed. It shows the active z/OS release, IPL time, load parameters, IEASYS list, IEASYM list, IODF information and selected IPL device information.

Use it to prove:

```text
which system is running
when it was IPLed
which system parameter members were selected
which IODF/load configuration is active
```

---

### `D PARMLIB`

```text
D PARMLIB
```

Displays the active PARMLIB concatenation. PARMLIB contains system parameter members such as `IEASYSxx`, `IEASYMxx`, `SMFPRMxx`, `CONSOLxx`, `BPXPRMxx`, `PROGxx`, `COMMNDxx` and product configuration members.

Use it to prove:

```text
which parameter libraries z/OS is using
where custom changes should be searched
whether USER.PARMLIB, ADCD.Z111S.PARMLIB and SYS1.PARMLIB are in the chain
```

Enterprise reading:

```text
USER.PARMLIB         local custom layer
ADCD.Z111S.PARMLIB  ADCD custom layer
SYS1.PARMLIB        base system layer
```

---

### `D SYMBOLS`

```text
D SYMBOLS
```

Displays active static system symbols. These symbols can be used by PARMLIB/JCL members to avoid hardcoding values.

Use it to prove:

```text
system name
sysplex name
volume symbols
ADCD naming symbols
runtime substitution values
```

Typical values observed in this environment:

```text
&SYSNAME = ADCD
&SYSPLEX = ADCDPL
&SYSR1   = SBRES1
&SYSP1   = SBPRD1
&SYSP2   = SBPRD2
&SYSP3   = SBPRD3
```

---

## 2. DASD and volume inventory

### `D U,DASD,ONLINE`

```text
D U,DASD,ONLINE
```

Displays online DASD devices.

Column meaning:

```text
UNIT      device address
TYPE      device type, for example 3390
STATUS    device status
VOLSER    volume serial
VOLSTATE  volume state, for example PRIV/RSDNT
```

Use it to prove:

```text
which disk volumes are online
which device addresses they use
which volumes form the base system layout
```

---

### `D U,VOL=volser`

```text
D U,VOL=SBRES1
D U,VOL=SBRES2
D U,VOL=SBSYS1
D U,VOL=ZVOL00
```

Displays the unit status for one specific volume.

Use it to prove:

```text
where a specific volume is mounted
whether the volume is online
whether it is private/resident
which device address belongs to that VOLSER
```

Enterprise reason:

```text
You cannot build storage policy or catalog policy until you know which volumes are system, product, user, spool, SMF or lab volumes.
```

---

## 3. SMF, SMS and pending requests

### `D SMF`

```text
D SMF
```

Displays SMF status and MAN dataset status.

Important statuses:

```text
ACTIVE          currently used SMF MAN dataset
ALTERNATE       available alternate SMF MAN dataset
DUMP REQUIRED   dataset contains records and must be dumped before reuse
```

Observed finding:

```text
SYS1.MAN4 on ZVOL00: DUMP REQUIRED
```

This is a follow-up operational item. It is not resolved in this baseline lab.

---

### `D SMS`

```text
D SMS
```

Displays SMS status and the active SMS control datasets.

Use it to prove:

```text
whether SMS is active
which SCDS/ACDS/COMMDS datasets are in use
whether DFSMS/SMS is available for enterprise storage-policy work
```

Observed datasets:

```text
SCDS   = SYS1.SCDS
ACDS   = SYS1.ACDS
COMMDS = SYS1.COMMDS
```

---

### `D R,L`

```text
D R,L
```

Displays outstanding system requests requiring operator attention.

Use it to prove:

```text
which reply IDs are pending
which subsystem is asking for input
which operational issue must be handled next
```

Observed finding:

```text
SMF ENTER DUMP FOR SYS1.MAN4 ON ZVOL00
```

This confirms why SDSF `SR` is useful.

---

## 4. SDSF operational inventory

### `DA`

```text
DA
```

SDSF Display Active panel. Shows active address spaces and started tasks.

Use it to prove:

```text
which subsystems are currently active
JES2, VTAM, TCPIP, TN3270, RACF, SDSF, OMVS, ZFS, CICS, DB2, MQ, WLM, GRS, XCFAS
```

---

### `ST`

```text
ST
```

SDSF Status panel. Shows jobs, started tasks and output queue entries.

Use it to prove:

```text
which jobs are executing
which jobs produced output
which jobs are in PRINT/EXECUTION
which class/owner/sysname each job has
```

---

### `LOG`

```text
LOG
```

SDSF SYSLOG panel. Shows system log messages.

Use it to prove:

```text
IPL messages
PARMLIB processing
JES2 startup
RACF startup
catalog activity
VTAM/TCPIP startup
CICS/DB2/MQ startup
warnings and pending requests
```

---

### `SR`

```text
SR
```

SDSF System Requests panel. Shows outstanding requests requiring replies.

Use it to prove:

```text
SDSF SR option is operational
operator requests are visible outside the console
SMF MANx dump requirement is pending
```

---

## 5. ISPF 3.4 dataset inventory

### PARMLIB search

```text
3.4
**.PARMLIB
```

Searches for PARMLIB datasets.

Use it to identify:

```text
USER.PARMLIB
ADCD.Z111S.PARMLIB
SYS1.PARMLIB
```

---

### PROCLIB search

```text
3.4
**.PROCLIB
```

Searches for procedure libraries.

Use it to identify libraries containing started task procedures and application procedures.

Observed examples:

```text
ADCD.Z111S.PROCLIB
SYS1.PROCLIB
USER.PROCLIB
IBMUSER.JCL.PROCLIB
IBMUSER.NETSEC.PROCLIB.BKUP
```

---

### IBMUSER dataset inventory

```text
3.4
IBMUSER.*
```

Lists datasets owned or grouped under the `IBMUSER` high-level qualifier.

Use it to separate:

```text
system datasets:     SYS1.*
ADCD datasets:       ADCD.*
lab/user datasets:   IBMUSER.*
```

Observed lab areas include:

```text
IBMUSER.CICS.*
IBMUSER.COBOL.*
IBMUSER.DB2AAB.*
IBMUSER.HARDEN.*
IBMUSER.HZSPDATA
IBMUSER.SECLAB.*
IBMUSER.SMF.*
IBMUSER.VSAM.*
```

---

## 6. Catalog baseline with IDCAMS

### JCL used

```jcl
//CATLIST  JOB (ACCT),'LISTCAT',CLASS=A,MSGCLASS=X,
//         NOTIFY=&SYSUID
//STEP01   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  LISTCAT ALIAS
  LISTCAT UCAT ALL
/*
```

### What each part means

```jcl
//CATLIST JOB ...
```

Defines the batch job.

```jcl
//STEP01 EXEC PGM=IDCAMS
```

Runs IDCAMS, the IBM utility for catalog, VSAM and access-method administration.

```jcl
//SYSPRINT DD SYSOUT=*
```

Sends IDCAMS output to JES spool.

```jcl
//SYSIN DD *
```

Starts inline IDCAMS control statements.

```text
LISTCAT ALIAS
```

Lists catalog aliases.

```text
LISTCAT UCAT ALL
```

Lists user catalog information.

### Why this matters

z/OS locates datasets through catalogs. Enterprise systems use master catalog and user catalogs to avoid mixing every application dataset into one uncontrolled catalog.

Expected result:

```text
MAXCC=0
```

Meaning:

```text
IDCAMS completed successfully.
```

---

## 7. RACF read-only baseline

### `LISTUSER IBMUSER`

```text
LISTUSER IBMUSER
```

Displays the RACF user profile for IBMUSER.

Important fields:

```text
USER              user ID
OWNER             owner of the profile
DEFAULT-GROUP     default group at logon
ATTRIBUTES        special privileges such as SPECIAL or OPERATIONS
REVOKE DATE       whether the user is revoked
LAST-ACCESS       last recorded access
```

Enterprise reading:

```text
IBMUSER is a powerful lab administrator. In a production enterprise system, this level of privilege must be controlled and not used as a shared daily user.
```

---

### `LISTGRP SYS1`

```text
LISTGRP SYS1
```

Displays the RACF group profile for SYS1 and users connected to it.

Important fields:

```text
USER
AUTH
CONNECT-OWNER
CONNECT-DATE
CONNECT ATTRIBUTES
REVOKE DATE
RESUME DATE
```

Enterprise reading:

```text
The group structure explains how system and started-task IDs are grouped and administered.
```

---

### `SETROPTS LIST`

```text
SETROPTS LIST
```

Displays global RACF options.

Use it to identify:

```text
active classes
generic profile classes
generic command classes
password policy
JES/RACF settings
catalog/security options
auditing options
```

This is mandatory before changing RACF policy.

---

### `RLIST STARTED * ALL`

```text
RLIST STARTED * ALL
```

Lists STARTED class profiles.

The STARTED class maps started tasks to RACF identities.

Concept:

```text
Started task name
        -> STARTED profile
        -> RACF user/group assignment
        -> permissions available to that address space
```

Enterprise reading:

```text
If a started task runs with too powerful an ID, the subsystem becomes a security risk.
```

---

### `RLIST FACILITY * ALL`

```text
RLIST FACILITY * ALL
```

Lists FACILITY class profiles.

FACILITY protects sensitive system functions, not normal datasets.

Examples of sensitive areas:

```text
BPX.SUPERUSER
BPX.SERVER
BPX.DAEMON
STGADMIN.*
RACF/IRR functions
ICSF/CSF functions when configured
```

Enterprise reading:

```text
FACILITY tells you who can use privileged z/OS services.
```

---

### `RLIST OPERCMDS * ALL`

```text
RLIST OPERCMDS * ALL
```

Lists OPERCMDS class profiles.

OPERCMDS protects MVS operator commands.

Examples:

```text
MVS.START
MVS.STOP
MVS.MODIFY
MVS.DISPLAY
MVS.SETPROG
```

Enterprise reading:

```text
Not every user should be able to issue operator commands. OPERCMDS is how RACF can control this.
```

---

## 8. Repeated RACF fields

### `OWNER`

Who owns/administers the RACF profile.

### `UNIVERSAL ACCESS`

Default access for users not explicitly listed.

Common values:

```text
NONE
READ
UPDATE
CONTROL
ALTER
```

### `YOUR ACCESS`

What the current user can do to the profile.

### `WARNING`

If `YES`, access may be allowed with warning/logging instead of being denied. This is useful for transition but risky if left permanently.

### `USER ACCESS LIST`

Explicit users/groups with access to the profile.

---

## 9. Lab discipline

No destructive change is performed in this lab.

Correct enterprise sequence:

```text
1. Inventory
2. Understand
3. Document findings
4. Design change
5. Backup
6. Change one thing
7. Validate
8. Document rollback
```

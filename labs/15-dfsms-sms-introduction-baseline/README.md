# LAB 15 - DFSMS / SMS Introduction and Baseline

## Objective

Establish a DFSMS/SMS baseline on the ADCD z/OS 1.11 system running under Hercules.

This lab is read-only. It does not create an SMS pool and does not alter SMS configuration.

## Environment

- z/OS ADCD 1.11 on Hercules
- System: ADCD
- User: IBMUSER
- Console: L700 / MASTER console
- Tools: MVS console, ISPF, ISMF, ISPF 3.4

## Scope

The lab verifies:

- SMS subsystem status
- SMS control datasets
- SMS options
- Existing storage groups
- SMS-managed status of selected volumes
- ISMF Storage Administration availability
- Dataset context for SMF and IBMUSER lab datasets

## Commands executed

```text
D SMS
D SMS,OPTIONS
D SMS,STORGRP(ALL)
D SMS,STORGRP(ALL),DETAIL

D SMS,VOLUME(SBRES1)
D SMS,VOLUME(SBSYS1)
D SMS,VOLUME(SBSYS9)
D SMS,VOLUME(ZVOL00)
D SMS,VOLUME(ZVOL01)
```

## Findings

SMS control datasets:

```text
SCDS   = SYS1.SCDS
ACDS   = SYS1.ACDS
COMMDS = SYS1.COMMDS
```

Existing storage groups:

```text
DBCLASS
HFSCLASS
```

Checked volumes reported as not SMS-managed:

```text
SBRES1
SBSYS1
SBSYS9
ZVOL00
ZVOL01
```

ISMF Storage Administration was available and showed the expected DFSMS areas:

```text
Data Set
Volume
Management Class
Data Class
Storage Class
Storage Group
Automatic Class Selection
Control Data Set
RMM
```

## Result

DFSMS/SMS is available and queryable. The current lab volumes are not managed by SMS. No configuration changes were made.

## Next step

```text
LAB 16 - DFSMS SMS Pool Creation
```

That next lab should cover adding new Hercules DASD volumes, initializing them with ICKDSF, defining a storage group/pool in ISMF, and later associating allocation rules through ACS.

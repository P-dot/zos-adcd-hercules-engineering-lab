# LAB 21 - Technical Analysis

## What this lab proves

This lab proves that the environment is now mature enough to be treated as a managed z/OS installation rather than as a collection of isolated exercises.

The evidence shows:

```text
- identifiable IPL configuration
- active PARMLIB chain
- active system symbols
- online DASD inventory
- SMF and SMS status
- visible outstanding system requests
- SDSF operational views
- SYSLOG startup evidence
- catalog alias/user catalog structure
- RACF user/group/global policy baseline
- STARTED, FACILITY and OPERCMDS controls
```

## Enterprise interpretation

The system is not a production mainframe, but it now has enough structure to imitate enterprise practices:

```text
baseline before change
read-only discovery before hardening
separation of system and lab datasets
controlled catalog awareness
RACF privilege visibility
operator command visibility
started task identity awareness
SMF/SMS awareness
```

## Main risks observed

```text
1. IBMUSER is highly privileged.
2. Many resources are owned or alterable by IBMUSER.
3. SMF MAN4 requires dump.
4. This is still a single-system ADCD/Hercules environment, not a Parallel Sysplex.
5. There is not yet a complete enterprise change register for every PARMLIB/PROCLIB member previously modified.
```

## Why this matters

Future labs can now be linked to a stable baseline. RACF, SMF, DFSMS, z/OS UNIX, CICS, DB2 and automation work should reference this lab as the initial state.

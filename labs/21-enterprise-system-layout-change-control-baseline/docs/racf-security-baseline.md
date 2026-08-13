# RACF Security Baseline

## Commands used

```text
LISTUSER IBMUSER
LISTGRP SYS1
SETROPTS LIST
RLIST STARTED * ALL
RLIST FACILITY * ALL
RLIST OPERCMDS * ALL
```

## Interpretation

### IBMUSER

`IBMUSER` is the primary administrator used in the lab. The evidence shows a highly privileged account suitable for ADCD lab work, but not a production-style shared user model.

### SYS1 group

The `SYS1` group baseline was captured to understand central system group membership and authority.

### SETROPTS

`SETROPTS LIST` captured RACF global options, including active classes, generic classes, password-related options and other security-wide settings.

### STARTED

The STARTED class baseline was captured to understand how started task identities are protected.

### FACILITY

The FACILITY class baseline was captured to understand sensitive system function profiles.

### OPERCMDS

The OPERCMDS class baseline was captured to understand which MVS operator commands are protected by RACF.

## No changes applied

This was a read-only RACF baseline. No RACF profile, group, SETROPTS option or class was modified.

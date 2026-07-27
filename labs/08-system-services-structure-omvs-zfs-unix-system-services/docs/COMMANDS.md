# LAB08 Commands - OMVS, zFS and UNIX System Services

## SDSF commands used

```text
/D A,L
/D OMVS
/D OMVS,O
/D OMVS,PFS
/D OMVS,SERVER
/D OMVS,STORAGE
/D R,L
/D C,L
```

## SDSF panel used

```text
DA
```

## What each command demonstrates

```text
D A,L
Shows active address spaces and services.

D OMVS
Shows the overall OMVS / UNIX System Services status.

D OMVS,O
Shows active OMVS configuration options.

D OMVS,PFS
Shows registered Physical File Systems, including zFS.

D OMVS,SERVER
Attempted display of OMVS server information. In this environment it returned DISPLAY INVALID PARAMETER.

D OMVS,STORAGE
Attempted display of OMVS storage information. In this environment it returned DISPLAY INVALID PARAMETER.

D R,L
Checks whether there are pending operator replies or outstanding messages.

D C,L
Displays console status and confirms hardcopy log routing.

DA
Provides SDSF evidence of active USS-related address spaces such as OMVS, BPXOINIT and ZFS.
```

## Commands intentionally not used

```text
F OMVS
P OMVS
P ZFS
F BPXOINIT
MOUNT
UNMOUNT
VARY
CANCEL
FORCE
START
STOP
```

This lab is read-only and non-destructive.

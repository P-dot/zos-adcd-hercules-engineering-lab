# LAB11 Commands - JES2, Spool and Batch Flow

## SDSF panel commands

```text
DA
ST
H
O
```

## JES2 display commands from SDSF

```text
/$D A
/$D JOBQ
/$D INIT
/$D SPOOL
/$D SPOOLDEF
/$D JOBDEF
/$D OUTDEF
```

## z/OS operator display commands from SDSF

```text
/D A,L
/D R,L
/D C,L
```

## Same commands from the MCS master console

When entered directly on the master console, omit the leading slash:

```text
$D A
$D JOBQ
$D INIT
$D SPOOL
$D SPOOLDEF
$D JOBDEF
$D OUTDEF
D A,L
D R,L
D C,L
```

## Commands intentionally avoided

```text
$P
$C
$S
$T
$Z
PURGE
CANCEL
FORCE
START
STOP
MODIFY
```

These commands can change JES2 or workload state and were not required for this read-only lab.

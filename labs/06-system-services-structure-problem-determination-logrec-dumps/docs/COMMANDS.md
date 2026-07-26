# LAB06 Commands - Problem Determination, LOGREC and Dumps

## SDSF panel command

```text
LOG
```

Search terms used inside SYSLOG:

```text
IFB081I
LOGREC
SYS1.LOGREC
```

## Operator display commands from SDSF

```text
/D R,L
/D C,L
/D DUMP
/D SLIP
/D TRACE
/D A,L
```

## Equivalent commands from MASTER CONSOLE

```text
D R,L
D C,L
D DUMP
D SLIP
D TRACE
D A,L
```

## Purpose

- `LOG`: review SYSLOG / hardcopy log evidence.
- `D R,L`: check pending replies and outstanding messages.
- `D C,L`: confirm active console and SYSLOG hardcopy log.
- `D DUMP`: display dump status and dynamic allocation configuration.
- `D SLIP`: display active or enabled SLIP traps.
- `D TRACE`: display trace status.
- `D A,L`: confirm system activity and active address spaces.

## Safety boundary

Read-only lab. Do not issue commands that alter dump, trace, SLIP, console, workload or system state.

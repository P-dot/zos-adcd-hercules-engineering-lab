# LAB03 - Commands

IBM Course: DL00EZ20IG - z/OS System Services Structure  
Unit: UNIT 3 - Task management

## Commands executed

SDSF panels:

```text
DA
ST
H
O
```

Operator commands issued from SDSF:

```text
/D A,L
/$D A
/$D JOBQ
/$D INIT
/D WLM
/D PROG,LNKLST
/D PROG,APF
```

The same operator commands can be issued from the MCS/master console without the leading slash.

## Safety rule

This lab uses display-only commands. It does not start, stop, cancel, force, vary, or modify any system resource.

Do not use in this lab:

```text
P
C
S
CANCEL
FORCE
START
STOP
F
$P
$C
$S
SETPROG
```

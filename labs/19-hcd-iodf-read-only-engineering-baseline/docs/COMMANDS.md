# Commands and navigation

## Operator commands

Use `/` in SDSF command input. Use no `/` on the MASTER console.

```text
/D IPLINFO
/D IOS,CONFIG
/D U,DASD,ONLINE
/D U,DASD,OFFLINE
/D M=CHP(0A)
/D M=DEV(0A80)
/D M=DEV(0A82)
/D M=DEV(0A85)
/D C,L
/D R,L
```

Final verification:

```text
/D IOS,CONFIG
/D R,L
```

## ISPF / IPLPARM

Browse only:

```text
ISPF 3.4
SYS1.IPLPARM(LOADDB)
```

## HCD navigation

Read-only path used in the lab:

```text
ISPF MORE / HCD
I/O definition file: SYS1.IODF09
1 Define, modify, or view configuration data
```

Screens captured from:

```text
Generic List by Name
Switch List
View Processor Definition
Control Unit List
I/O Device List
Operating System Configuration List
```

## Prohibited actions in this lab

```text
ADD
DELETE
UPDATE
SAVE
BUILD
ACTIVATE
SUBMIT
F11 Add
Build production IODF
Build IOCDS
Activate configuration
Dynamic activation
```

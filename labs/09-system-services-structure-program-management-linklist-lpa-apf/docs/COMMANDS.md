# LAB09 Commands - Program Management, LINKLIST, LPA and APF

## SDSF / operator commands

```text
/D PROG,LNKLST
/D PROG,APF
/D PROG,EXIT
/D PROG,LPA
/D A,L
/D R,L
/D C,L
```

## MASTER CONSOLE equivalents

```text
D PROG,LNKLST
D PROG,APF
D PROG,EXIT
D PROG,LPA
D A,L
D R,L
D C,L
```

## Purpose

```text
D PROG,LNKLST   Display the active LINKLIST set and module search libraries.
D PROG,APF      Display APF-authorized libraries.
D PROG,EXIT     Display registered program exits.
D PROG,LPA      Attempt to display LPA information; captured as syntax/compatibility evidence.
D A,L           Display active address spaces related to system services.
D R,L           Check pending replies and outstanding messages.
D C,L           Confirm active console and SYSLOG hardcopy log.
```

## Safety rules

Do not execute:

```text
SETPROG
APF ADD
APF DELETE
LNKLST ACTIVATE
LNKLST UPDATE
PROGxx edits
VARY
START
STOP
FORCE
CANCEL
```

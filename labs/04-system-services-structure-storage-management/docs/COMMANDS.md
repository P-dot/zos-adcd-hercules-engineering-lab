# LAB04 Commands - Storage Management

## SDSF / MCS commands used

From SDSF, operator commands were issued with `/`:

```text
/D M=STOR
/D ASM
/D A,L
/D R,L
/D C,L
/D U,,,0A80,16
```

From a real MCS console, the same commands would be entered without `/`:

```text
D M=STOR
D ASM
D A,L
D R,L
D C,L
D U,,,0A80,16
```

## Command purpose

```text
D M=STOR
```
Displays real storage status.

```text
D ASM
```
Displays Auxiliary Storage Manager status and page datasets.

```text
D A,L
```
Displays active address spaces.

```text
D R,L
```
Displays pending requests, action messages, and outstanding replies.

```text
D C,L
```
Displays console status.

```text
D U,,,0A80,16
```
Displays sixteen devices starting at unit address 0A80.

## Safety boundary

This lab is display-only. Do not use the following commands as part of this lab:

```text
SETASM
VARY
CONFIG
ACTIVATE
CHNGDUMP
DUMPDS
CANCEL
FORCE
```

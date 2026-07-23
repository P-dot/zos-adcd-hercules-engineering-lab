# LAB02 Commands - Operating Environment Initialization

## SDSF format

```text
/D IPLINFO
/D SYMBOLS
/D IOS,CONFIG
/D U,DASD,OFFLINE
/D U,,,0A80,16
/D U,,,0A82,16
/D M=DEV(0A80)
/D M=DEV(0A82)
/D PROG,LPA
/D PROG,LNKLST
```

## Master console format

```text
D IPLINFO
D SYMBOLS
D IOS,CONFIG
D U,DASD,OFFLINE
D U,,,0A80,16
D U,,,0A82,16
D M=DEV(0A80)
D M=DEV(0A82)
D PROG,LPA
D PROG,LNKLST
```

## Safety note

All commands used in this lab are display/query commands. No VARY, SET, ACTIVATE, CHNGDUMP, DUMPDS, or configuration-changing commands were used.

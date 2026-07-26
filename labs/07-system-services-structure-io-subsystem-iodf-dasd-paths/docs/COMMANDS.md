# LAB07 Commands - I/O Subsystem, IODF, DASD and Paths

## SDSF commands

```text
/D IOS,CONFIG
/D U,DASD,ONLINE
/D U,DASD,OFFLINE
/D U,,,0A80,16
/D U,,,0A82,16
/D M=DEV(0A80)
/D M=DEV(0A82)
/D M=DEV(0A85)
/D M=CHP(0A)
/D R,L
/D C,L
```

## MASTER CONSOLE equivalents

When entering commands directly on the MCS console, omit the leading slash:

```text
D IOS,CONFIG
D U,DASD,ONLINE
D U,DASD,OFFLINE
D U,,,0A80,16
D U,,,0A82,16
D M=DEV(0A80)
D M=DEV(0A82)
D M=DEV(0A85)
D M=CHP(0A)
D R,L
D C,L
```

## Command purpose

| Command | Purpose |
|---|---|
| `D IOS,CONFIG` | Display active IODF, configuration ID, EDT ID and CSS information. |
| `D U,DASD,ONLINE` | Display online DASD devices. |
| `D U,DASD,OFFLINE` | Display defined DASD devices that are offline. |
| `D U,,,0A80,16` | Display devices around the IPL/SYSRES device range. |
| `D U,,,0A82,16` | Display devices around SBSYS1 and related ADCD volumes. |
| `D M=DEV(0A80)` | Validate the IPL/SYSRES device path status. |
| `D M=DEV(0A82)` | Validate the SBSYS1 device path status. |
| `D M=DEV(0A85)` | Validate an additional ADCD DASD device path status. |
| `D M=CHP(0A)` | Display device status for channel path 0A. |
| `D R,L` | Check pending replies and outstanding messages. |
| `D C,L` | Confirm console status and hardcopy log. |

## Safety boundary

Do not run destructive or state-changing commands in this lab:

```text
VARY
CONFIG
ACTIVATE
SETIOS
CHPF
CHPK
START
STOP
FORCE
CANCEL
```

# LAB14 - z/OS System Services Structure: IPLPARM, PARMLIB and Runtime Configuration Mapping

## Course alignment

IBM Course: DL00EZ20IG - z/OS System Services Structure  
Focus area: z/OS initialization, runtime configuration, IPLPARM, PARMLIB and I/O configuration mapping.

## Objective

Map the active z/OS runtime configuration back to the real initialization members used by the system.

This lab does not change the system. It uses read-only operator commands and ISPF browse/view evidence to correlate:

- `D IPLINFO`
- `SYS1.IPLPARM(LOADDB)`
- `IEASYSDB`
- `IEASYM00`
- `CONSOL00`
- `SMFPRM00`
- `MSTJCL00`
- `COMMNDDB`
- `D IOS,CONFIG`
- `SYS1.IODF09`

## Environment

- Platform: ADCD z/OS on Hercules
- System name: ADCD
- z/OS release observed: 01.11.00
- Console: L700
- Access method: 3270 / SDSF / ISPF browse

## Commands and views used

```text
/D IPLINFO
/D SYMBOLS
/D IOS,CONFIG
/D C,L
/D R,L
```

ISPF browse/view evidence:

```text
SYS1.IPLPARM(LOADDB)
ADCD.Z111S.PARMLIB(IEASYSDB)
ADCD.Z111S.PARMLIB(IEASYM00)
ADCD.Z111S.PARMLIB(CONSOL00)
ADCD.Z111S.PARMLIB(SMFPRM00)
ADCD.Z111S.PARMLIB(MSTJCL00)
ADCD.Z111S.PARMLIB(COMMNDDB)
```

## Evidence summary

### IPL and runtime identity

`D IPLINFO` shows that the system was IPLed as ADCD, running z/OS 01.11.00. The system used `LOADDB` in `SYS1.IPLPARM` on device `0A82`.

Observed values:

```text
SYS=ADCD
z/OS release=01.11.00
LOAD member=LOADDB
SYS1.IPLPARM device=0A82
IEASYM list=00
IEASYS list=DB
IODF device=0A82
IPL device=0A80
IPL volume=SBRES1
```

### System symbols

`D SYMBOLS` shows runtime symbols including:

```text
&SYSNAME=ADCD
&SYSPLEX=ADCDPL
&SYSR1=SBRES1
&SYSR2=SBRES2
&SYST1=SBSYS1
```

These values are mapped back to `ADCD.Z111S.PARMLIB(IEASYM00)`.

### I/O configuration

`D IOS,CONFIG` shows:

```text
ACTIVE IODF DATA SET = SYS1.IODF09
CONFIGURATION ID = OS390
EDT ID = 00
ACTIVE CSS: 0
CHANNEL MEASUREMENT BLOCK FACILITY IS ACTIVE
```

This links the runtime I/O configuration to the active IODF.

### IPLPARM mapping

`SYS1.IPLPARM(LOADDB)` provides the IPL load configuration and references the relevant configuration elements:

```text
IODF
SYSCAT
IEASYS DB
IEASYM 00
NUCLST 00
PARMLIB USER.PARMLIB
PARMLIB ADCD.Z111S.PARMLIB
PARMLIB SYS1.PARMLIB
SYSPLEX ADCDPL
```

### PARMLIB mapping

The following members were reviewed in browse/view mode:

- `IEASYSDB` - system initialization parameters
- `IEASYM00` - static system symbols
- `CONSOL00` - console definitions, including console/hardcopy log configuration
- `SMFPRM00` - SMF recording configuration
- `MSTJCL00` - master scheduler JCL context
- `COMMNDDB` - automatic commands issued during system initialization

### Console and pending messages

`D C,L` confirms console `L700` is active as an MCS console with `AUTH=MASTER` and hardcopy log `SYSLOG`.

`D R,L` confirms there were no outstanding reply requests at the time of capture.

## Key findings

```text
System: ADCD
Release: z/OS 01.11.00
LOAD member: SYS1.IPLPARM(LOADDB)
IEASYS: DB
IEASYM: 00
IODF: SYS1.IODF09
IPL device: 0A80
IPL volume: SBRES1
IPLPARM device: 0A82
Primary PARMLIB reviewed: ADCD.Z111S.PARMLIB
Console: L700 active MCS console
Hardcopy log: SYSLOG
Pending replies: none
```

## Safety notes

This lab is read-only. No IPL, SET, VARY, START, STOP, SAVE, REPLACE, EDIT or configuration-changing commands were used.

## Evidence files

Screenshots are stored under:

```text
evidence/screenshots/
```

The original Word source is stored as:

```text
evidence/LAB14_source.docx
```

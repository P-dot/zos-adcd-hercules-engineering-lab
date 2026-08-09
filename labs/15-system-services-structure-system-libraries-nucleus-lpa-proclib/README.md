# LAB15 - z/OS System Services Structure: System Libraries, Nucleus, LPA and PROCLIB Inventory

## Course alignment

IBM Course: DL00EZ20IG - z/OS System Services Structure

This lab maps the course concepts about z/OS initialization, program management, system libraries, LPA, LINKLIST, APF authorization, PROCLIB, PARMLIB, IPLPARM and I/O configuration to a real ADCD/Hercules z/OS system.

## Objective

Document the critical system libraries and datasets that support IPL, nucleus loading, LPA, LINKLIST, APF authorization, cataloged procedures, system parameters and I/O configuration.

The lab is read-only. No system libraries were edited, compressed, renamed, deleted or replaced.

## Environment

- Platform: ADCD z/OS on Hercules
- System name: ADCD
- z/OS release: 01.11.00
- Console: L700
- Access method: 3270 / SDSF / TSO / ISPF

## Commands executed

Operator commands from SDSF:

```text
/D IPLINFO
/D PROG,LNKLST
/D PROG,APF
/D IOS,CONFIG
/D C,L
/D R,L
```

TSO / ISPF option 6 commands:

```text
LISTDS 'SYS1.NUCLEUS'
LISTDS 'SYS1.LPALIB'
LISTDS 'SYS1.LINKLIB'
LISTDS 'SYS1.SVCLIB'
LISTDS 'SYS1.PROCLIB'
LISTDS 'SYS1.PARMLIB'
LISTDS 'SYS1.IPLPARM'
LISTDS 'ADCD.Z111S.PARMLIB'
LISTDS 'SYS1.IODF09'
```

ISPF 3.4 was also used to visually locate SYS1 and ADCD.Z111S datasets.

## Evidence summary

### IPL context

`D IPLINFO` confirms that the system was IPLed as ADCD running z/OS 01.11.00.

Observed values:

```text
LOAD member: SYS1.IPLPARM(LOADDB)
IEASYS list: DB
IEASYM list: 00
IODF device: 0A82
IPL device: 0A80
IPL volume: SBRES1
```

### LINKLIST

`D PROG,LNKLST` shows the active LINKLIST set:

```text
LNKLST set: LNKLST00
LNKAUTH: LNKLST
```

Important libraries observed include:

```text
SYS1.LINKLIB
SYS1.MIGLIB
SYS1.CSSLIB
SYS1.SIEALNKE
SYS1.SIEAMIGE
SYS1.SHASLNKE
USER.LINKLIB
CEE.SCEERUN
CEE.SCEERUN2
```

### APF authorization

`D PROG,APF` shows APF in dynamic format.

Examples of APF-authorized libraries observed:

```text
SYS1.LINKLIB
SYS1.SVCLIB
SYS1.SHASLNKE
SYS1.SIEAMIGE
SYS1.MIGLIB
SYS1.CSSLIB
TCPIP.SEZATCP
TCPIP.SEZALNK2
TCPIP.SEZADSI
SYS1.VTAMLIB
USER.VTAMLIB
```

### I/O configuration

`D IOS,CONFIG` confirms:

```text
Active IODF data set: SYS1.IODF09
Configuration ID: OS390
EDT ID: 00
Active CSS: 0
Channel Measurement Block Facility: active
```

### System libraries located

`LISTDS` and ISPF 3.4 evidence locate the following critical libraries:

```text
SYS1.NUCLEUS        SBRES1
SYS1.LPALIB         SBRES1
SYS1.LINKLIB        SBRES1
SYS1.SVCLIB         SBRES1
SYS1.PROCLIB        SBRES1
SYS1.PARMLIB        SBRES1
SYS1.IPLPARM        SBSYS1
ADCD.Z111S.PARMLIB  SBRES1
```

### Corrections and observations

An initial RACF-oriented `LISTDSD` command was captured as an attempted dataset profile query, then corrected to `LISTDS` for physical dataset inventory.

An initial typo `SYS1.LNKLIB` returned `NOT IN CATALOG`. The corrected dataset name `SYS1.LINKLIB` was then successfully located on `SBRES1`.

`D IOS,CONFIG` confirms `SYS1.IODF09` as the active IODF, although a direct `LISTDS 'SYS1.IODF09'` did not find it in the current catalog context. The authoritative operational evidence for the active IODF in this lab is the IOS display.

### Console and pending messages

`D C,L` confirms console `L700` as an active MCS console with `AUTH=MASTER` and `HARDCOPY LOG=(SYSLOG)`.

`D R,L` confirms no outstanding operator replies at the time of capture.

## Professional value

This lab demonstrates the ability to map high-level z/OS system structure concepts to real system libraries and runtime displays. It proves that the operator can identify where z/OS loads executable modules, where authorized libraries are defined, where system parameters reside, and how IPL/IPLPARM/IODF evidence relates to physical datasets.

## Safety notes

No destructive commands were used. The following actions were intentionally avoided:

```text
EDIT
SAVE
REPLACE
DELETE
RENAME
COMPRESS
SUBMIT
SETPROG
APF ADD
APF DELETE
LNKLST ACTIVATE
START
STOP
VARY
IPL
```

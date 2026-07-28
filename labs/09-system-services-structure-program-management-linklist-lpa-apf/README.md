# LAB09 - z/OS System Services Structure: Program Management, LINKLIST, LPA and APF

## Course alignment

IBM Course: DL00EZ20IG - z/OS System Services Structure  
Lab theme: Program Management, Dynamic Linkage, Program Authorization, LINKLIST and APF

Related concepts:

- Dynamic linkage
- Program management
- LINKLIST search path
- APF authorization
- Program exits
- LLA / VLF / DLF
- Console and pending message verification

## Objective

Document how the ADCD z/OS system exposes its active program management configuration using non-destructive operator commands. The lab focuses on LINKLIST, APF-authorized libraries, program exits, active supporting address spaces, console status, and pending-message status.

## Environment

- Platform: ADCD z/OS on Hercules
- System name: ADCD
- Console: L700
- Access method: 3270 / SDSF / MCS console
- Evidence source: LAB09_source.docx

## Commands executed

```text
/D PROG,LNKLST
/D PROG,APF
/D PROG,EXIT
/D PROG,LPA
/D A,L
/D R,L
/D C,L
```

## Evidence

Screenshots are stored in:

```text
evidence/screenshots/
```

Main evidence files:

```text
01_d_prog_lnklist.png
02_d_prog_apf.png
03_d_prog_exit.png
04_d_prog_lpa_syntax_error.png
05_d_a_l_activity.png
06_d_r_l_no_messages.png
07_d_c_l_console_status.png
```

A visual contact sheet is also included:

```text
evidence/lab09_contact_sheet.jpg
```

## Findings

### LINKLIST

The active LINKLIST set is:

```text
LNKLST00
```

The display shows system and runtime libraries such as:

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

This demonstrates the active module search path used by z/OS for executable modules.

### APF authorization

The APF display shows:

```text
FORMAT=DYNAMIC
```

Observed APF-authorized libraries include:

```text
SYS1.LINKLIB
SYS1.SVCLIB
SYS1.SHASLNKE
SYS1.MIGLIB
SYS1.SERBLINK
SYS1.CSSLIB
TCPIP.SEZATCP
TCPIP.SEZALNK2
SYS1.VTAMLIB
```

This confirms that the system maintains a dynamic APF list containing core system, TCP/IP and VTAM libraries.

### Program exits

`D PROG,EXIT` shows multiple registered exits, including entries related to dumps, XCF/GRS, allocation, volume handling and OMVS/BPX processing.

Examples observed:

```text
CSVXDEX
IEASDUMP.QUERY
IEASDUMP.GLOBAL
IEASDUMP.LOCAL
IEASDUMP.PRESTR
IEASDUMP.POSTDMP
IXC_WORK_RESTART
IEF_SPEC_WAIT
IEF_VOLUME_ENQ
BPX_PREPROC_INIT
BPX_POSPROC_INIT
```

This demonstrates that program management also exposes controlled system extension points.

### LPA display attempt

The attempted LPA display was not accepted with the syntax used in this z/OS 1.11 ADCD environment.

This is documented as compatibility evidence, not as a system failure.

### Active address spaces

The activity display confirms active components related to program loading, caching, authorization and system services:

```text
LLA
VLF
DLF
RACF
JES2
TSO
TCPIP
TN3270
SDSF
```

### Console and pending messages

The console display confirms:

```text
L700 active
TYPE=MCS
AUTH=MASTER
HARDCOPY LOG=(SYSLOG)
```

The pending request display shows no outstanding messages requiring operator action.

## Operational safety

Only read-only display commands were used. No program libraries, APF lists, PROGxx members, LPA configuration or LINKLIST sets were modified.

Commands deliberately avoided:

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

## Conclusion

This lab validates the program management view of an ADCD z/OS system. It documents the active LINKLIST, dynamic APF authorization list, registered program exits, related address spaces, console status and pending-message state. It also records that the attempted LPA display syntax was not accepted in this environment, which is useful compatibility evidence for z/OS 1.11 ADCD on Hercules.

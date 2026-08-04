# LAB12 - z/OS System Services Structure: System Baseline and Operational Health Check

## Course alignment

IBM Course: DL00EZ20IG - z/OS System Services Structure  
Lab focus: non-destructive operational baseline of a running ADCD z/OS system.

This lab consolidates previous System Services Structure topics into one practical health check:

- IPL and system identity
- Address spaces and active services
- Logical CPUs
- Real storage
- Auxiliary storage and page data sets
- I/O configuration and IODF
- DASD online status
- JES2 spool
- WLM policy
- Pending messages
- Console status
- SDSF DA system map

## Objective

Build a safe, repeatable, operator-level baseline of the ADCD z/OS environment using display-only commands. The lab verifies that the system is IPLed, active, responsive, and able to report core runtime services without changing configuration.

## Environment

- Platform: ADCD z/OS on Hercules
- System name: ADCD
- z/OS release observed: 01.11.00
- IPL device observed: 0A80
- IPL volume observed: SBRES1
- Console observed: L700
- Access method: SDSF / MCS console

## Commands executed

```text
/D IPLINFO
/D A,L
/D M=CPU
/D M=STOR
/D ASM
/D IOS,CONFIG
/D U,DASD,ONLINE
/$D SPOOL
/$D SPOOLDEF
/D WLM
/D R,L
/D C,L
DA
```

## Evidence

| Evidence | Description |
|---|---|
| `evidence/screenshots/01_d_iplinfo.png` | IPL identity, SYSRES, IEASYS, IEASYM and IPLPARM. |
| `evidence/screenshots/02_d_a_l_activity.png` | System activity and active address spaces. |
| `evidence/screenshots/03_d_m_cpu.png` | Logical CPU status and Hercules LPAR identity. |
| `evidence/screenshots/04_d_m_stor_real_storage.png` | Real storage status. |
| `evidence/screenshots/05_d_asm_auxiliary_storage.png` | Auxiliary storage and page data sets. |
| `evidence/screenshots/06_d_ios_config.png` | Active IODF, configuration ID, EDT and CSS. |
| `evidence/screenshots/07_d_u_dasd_online.png` | DASD online volume map. |
| `evidence/screenshots/08_jes2_d_spool.png` | JES2 spool volume status. |
| `evidence/screenshots/09_jes2_d_spooldef.png` | JES2 spool definition. |
| `evidence/screenshots/10_d_wlm_policy_status.png` | WLM active policy. |
| `evidence/screenshots/11_d_r_l_no_messages.png` | Pending replies and messages. |
| `evidence/screenshots/12_d_c_l_console_status.png` | Console L700 status. |
| `evidence/screenshots/13_sdsf_da_system_baseline_part_1.png` | SDSF DA system components, part 1. |
| `evidence/screenshots/14_sdsf_da_system_baseline_part_2.png` | SDSF DA system components, part 2. |

A contact sheet is also included at:

```text
evidence/lab12_contact_sheet.jpg
```

## Findings

### IPL and system identity

The system is running as ADCD on z/OS 01.11.00. The IPL information shows:

```text
SYS=ADCD
IEASYS LIST=DB
IEASYM LIST=00
IPLPARM device=0A82
IODF device=0A82
IPL device=0A80
IPL volume=SBRES1
```

### Active system services

The activity display and SDSF DA evidence show a running system with core services and subsystems active, including:

```text
JES2
RACF
VTAM
TCPIP
TN3270
OMVS
ZFS
SMS
CATALOG
WLM
XCFAS
GRS
DUMPSRV
TRACE
LLA
VLF
CICSA
DB9GMSTR
CSQ7MSTR
SSHD4
FTPD1
```

### CPU baseline

The CPU display shows four logical CPUs online:

```text
00
01
02
03
```

The display also identifies the logical partition name as Hercules.

### Real storage

The real storage display shows:

```text
ONLINE-NOT RECONFIGURABLE: 0M-8192M
STORAGE INCREMENT SIZE: 1M
```

### Auxiliary storage and paging

The ASM display shows page data sets on device 0A82:

```text
SYS1.PLPA.PAGE
SYS1.COMMON.PAGE
SYS1.LOCAL.PAGE
```

The displayed status is OK.

### I/O configuration

The IOS configuration display shows:

```text
ACTIVE IODF DATA SET = SYS1.IODF09
CONFIGURATION ID = OS390
EDT ID = 00
ACTIVE CSS = 0
CHANNEL MEASUREMENT BLOCK FACILITY IS ACTIVE
```

### DASD baseline

The DASD online display shows the ADCD volumes online, including:

```text
SBRES1
SBRES2
SBSYS1
SBUSS1
SBBBN1
SBBBN2
SBPRD1
SBPRD2
SBPRD3
SBDIS1
SBDIS2
SBDIS3
SBDIS4
SBDIS5
SBDIS6
SARES1
```

### JES2 spool

The JES2 spool display shows SBSYS1 active. The spool definition shows:

```text
DSNAME=SYS1.HASPACE
BUFSIZE=3856
WARN=80
```

The spool had available free space at the time of capture.

### WLM

WLM shows an active service policy:

```text
ETPBASE
```

### Pending messages and console

The pending request display shows no outstanding messages or replies. The console display confirms:

```text
Console: L700
Type: MCS
Status: ACT-ADCD
Authority: MASTER
Hardcopy log: SYSLOG
```

## Operational value

This lab provides a single non-destructive system baseline that can be reused before and after future changes. It is useful for:

- verifying that the system IPLed correctly;
- confirming that core services are running;
- checking storage, paging and DASD status;
- validating JES2 spool state;
- confirming WLM policy activation;
- ensuring no operator replies are pending;
- documenting the ADCD/Hercules environment for portfolio evidence.

## Safety

Only display commands were used. No system settings, volumes, parmlib members, RACF profiles, JES2 definitions, SMS definitions, or storage settings were changed.

Commands intentionally avoided:

```text
VARY
SETIOS
SETASM
SETSMS
SETPROG
CHNGDUMP
DUMPDS
START
STOP
CANCEL
FORCE
$P
$C
$S
$T
```

## Conclusion

The ADCD z/OS system is active and responsive. The lab confirms IPL identity, active address spaces, logical CPUs, real and auxiliary storage, I/O configuration, DASD online status, JES2 spool configuration, WLM policy, console status, and absence of outstanding operator messages.

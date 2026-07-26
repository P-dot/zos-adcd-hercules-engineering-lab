# LAB07 - z/OS System Services Structure: I/O Subsystem, IODF, DASD and Paths

## Course alignment

IBM Course: DL00EZ20IG - z/OS System Services Structure  
Lab focus: I/O subsystem, IODF, DASD devices, channel paths and device status

This lab extends the operating-environment initialization work from LAB02.  
LAB02 identified IPL and initialization data. LAB07 focuses on how z/OS sees and accesses I/O devices.

## Objective

Validate the active z/OS I/O configuration in an ADCD/Hercules environment using non-destructive operator commands.

The lab documents:

- Active IODF
- Configuration ID and EDT ID
- Active Channel Subsystem
- Online and offline DASD devices
- SYSRES / IPL device relationship
- ADCD DASD volume layout
- Device paths for selected DASD volumes
- Channel path 0A status
- Console status and pending message status

## Environment

- Platform: ADCD z/OS on Hercules
- System name: ADCD
- Console: L700
- Access method: 3270 / SDSF / MCS console
- Command type: display-only operator commands

## Commands executed

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

## Evidence

Screenshots are stored under:

```text
evidence/screenshots/
```

Main evidence files:

```text
01_d_ios_config.png
02_d_u_dasd_online.png
03_d_u_dasd_offline.png
04_d_u_0a80_16.png
05_d_u_0a82_16.png
06_d_m_dev_0a80.png
07_d_m_dev_0a82.png
08_d_m_dev_0a85.png
09_d_m_chp_0a.png
10_d_r_l_logrec_message.png
11_d_c_l_console_status.png
```

The original Word document is preserved as:

```text
evidence/LAB07_source.docx
```

## Findings

### Active I/O configuration

`D IOS,CONFIG` showed:

```text
ACTIVE IODF DATA SET = SYS1.IODF09
CONFIGURATION ID = OS390
EDT ID = 00
ACTIVE CSS: 0
CHANNEL MEASUREMENT BLOCK FACILITY IS ACTIVE
```

This confirms that z/OS is using `SYS1.IODF09` as the active IODF and that CSS 0 is active.

### Online DASD volumes

The DASD online display showed core ADCD volumes, including:

```text
0A80  SBRES1
0A81  SBRES2
0A82  SBSYS1
0A83  SBUSS1
0A84  SBBBN1
0A85  SBBBN2
0A86  SBPRD1
0A87  SBPRD2
0A88  SBPRD3
0A89  SBDIS1
```

`0A80 / SBRES1` remains the key SYSRES / IPL device reference.  
`0A82 / SBSYS1` is also important because it has appeared in previous labs as a system volume related to IPLPARM, IODF and page datasets.

### Offline DASD definitions

`D U,DASD,OFFLINE` showed 3380 devices such as:

```text
0120
0121
0122
...
012E
```

These devices are defined but offline. In this ADCD/Hercules environment, this is documented as configuration evidence, not treated as an immediate failure. No `VARY` operation was performed.

### Device path validation

Selected devices were checked with `D M=DEV(...)`:

```text
0A80
0A82
0A85
```

The displays confirmed:

```text
DEVICE STATUS=ONLINE
CHP 0A
PATH ONLINE Y
CHP PHYSICALLY ONLINE Y
PATH OPERATIONAL Y
```

This validates that the selected DASD devices are online and accessible through channel path `0A`.

### Channel path 0A

`D M=CHP(0A)` returned a channel path device-status view with online devices in the `0A8x` / `0A9x` range.

This confirms the relationship between the displayed DASD devices and channel path `0A`.

### Pending messages

`D R,L` showed the recurring known LOGREC finding:

```text
IFB081I LOGREC DATA SET IS FULL
DSN=SYS1.LOGREC
```

This was already documented in LAB06 as a problem-determination finding. It is not acted on in this lab.

### Console status

`D C,L` confirmed:

```text
L700
TYPE=MCS
STATUS=ACT-ADCD
AUTH=MASTER
HARDCOPY LOG=(SYSLOG)
```

The L700 console was active and suitable for issuing display-only operator commands.

## Safety notes

The following commands were intentionally not used:

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

This lab is observation-only and does not alter the I/O configuration.

## Conclusion

This lab validates the active z/OS I/O configuration in the ADCD/Hercules system. It identifies the active IODF, confirms the CSS and EDT information, documents online and offline DASD devices, validates selected device paths, and confirms channel path 0A visibility.

The main operational findings are:

```text
IODF active: SYS1.IODF09
Configuration ID: OS390
EDT ID: 00
Active CSS: 0
SYSRES / IPL reference: 0A80 / SBRES1
Key system volume: 0A82 / SBSYS1
Selected devices 0A80, 0A82 and 0A85: online and operational
Channel path used: 0A
Console L700: active
Known recurring finding: SYS1.LOGREC full
```

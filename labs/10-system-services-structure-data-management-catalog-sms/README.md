# LAB10 - z/OS System Services Structure: Data Management, Catalog and SMS

## Course alignment

IBM course: `DL00EZ20IG - z/OS System Services Structure`  
Lab topic: Data Management, Catalog and SMS

This lab maps the course concepts of z/OS data management to a real ADCD/Hercules environment using non-destructive operator and TSO/IDCAMS commands.

## Objective

Document how the running z/OS system exposes SMS, catalog services, DASD volumes, storage groups, and cataloged `SYS1.*` datasets.

The lab focuses on observation only. No SMS, catalog, dataset, or volume configuration was modified.

## Environment

- Platform: ADCD z/OS on Hercules
- System name: `ADCD`
- Console: `L700`
- Evidence source: SDSF, MCS operator commands, and TSO/IDCAMS `LISTCAT`

## Commands executed

```text
/D A,L
/D SMS
/D SMS,STORGRP(ALL)
/D SMS,VOL(SBRES1)
/D SMS,VOL(SBSYS1)
/D U,DASD,ONLINE
/D U,,,0A80,16
/D R,L
/D C,L
```

Optional TSO/IDCAMS catalog checks:

```text
LISTCAT LEVEL(SYS1)
LISTCAT ENT(SYS1.LINKLIB)
```

## Evidence

Screenshots are stored in:

```text
evidence/screenshots/
```

The original Word evidence file is stored as:

```text
evidence/LAB10_source.docx
```

A contact sheet is also included:

```text
evidence/lab10_contact_sheet.jpg
```

## Findings

### SMS status

The system reports active SMS datasets:

```text
SCDS: SYS1.SCDS
ACDS: SYS1.ACDS
COMMDS: SYS1.COMMDS
```

This confirms that the ADCD system has SMS configuration datasets defined and active.

### SMS storage groups

The `D SMS,STORGRP(ALL)` display shows enabled SMS storage groups, including:

```text
DBSCLASS
HFSCLASS
```

These are shown as `POOL` storage groups.

### SMS volume query observation

A volume-related SMS display returned:

```text
CBR1910I DISPLAY rejected. OAM address space not started.
```

This was documented as an environment observation. OAM was not started because this lab is read-only.

### DASD volumes

The DASD displays show the main ADCD volumes online, including:

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

`SBRES1` remains the key system/boot reference volume and `SBSYS1` is a major system volume previously observed in IPL, IODF, and paging evidence.

### Catalog and SMS address spaces

SDSF `DA` shows components related to data management and allocation, including:

```text
CATALOG
SMS
SMSPDSE
SMSVSAM
ALLOCAS
```

This confirms that catalog, SMS, PDSE, VSAM/SMS, and allocation services are active in the running system.

### LISTCAT evidence

`LISTCAT LEVEL(SYS1)` returns many cataloged `SYS1.*` entries under:

```text
CATALOG.Z111S.MASTER
```

The specific `LISTCAT ENT(SYS1.LINKLIB)` check returned a not-found result in this environment:

```text
IDC3012I ENTRY SYS1.LINKLIB NOT FOUND
IDC1566I ** SYS1.LINKLIB NOT LISTED
```

This is documented as a catalog query result, not as an operational failure. `SYS1.LINKLIB` was already observed through `D PROG,LNKLST` in the Program Management/APF lab.

### Console and messages

The console display confirms:

```text
L700 TYPE=MCS STATUS=ACT-ADCD
HARDCOPY LOG=(SYSLOG)
```

`D R,L` showed no outstanding replies or pending operator action at the time of capture.

## Conclusion

This lab validates the data management layer of the ADCD z/OS system. It demonstrates active SMS configuration datasets, enabled SMS storage groups, online DASD volumes, catalog-related system address spaces, master catalog evidence through LISTCAT, and a controlled observation of an OAM-dependent display rejection.

All actions were non-destructive and suitable for operational documentation and GitHub evidence.

# LAB10 Commands - Data Management, Catalog and SMS

## SDSF / operator commands

Run from SDSF with `/`:

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

From the MCS/master console, use the same commands without `/`.

## SDSF panels

```text
DA
```

Capture the following address spaces if visible:

```text
CATALOG
SMS
SMSPDSE
SMSVSAM
ALLOCAS
LLA
VLF
JES2
RACF
OMVS
ZFS
```

## Optional TSO/IDCAMS catalog checks

From TSO/ISPF option 6 or batch IDCAMS:

```text
LISTCAT LEVEL(SYS1)
LISTCAT ENT(SYS1.LINKLIB)
```

## Do not execute in this lab

```text
VARY
SETSMS
MODIFY SMS
START SMS
STOP SMS
DELETE
ALTER
DEFINE
REPRO
IDCAMS DELETE
IDCAMS ALTER
```

This lab is read-only and evidence-focused.

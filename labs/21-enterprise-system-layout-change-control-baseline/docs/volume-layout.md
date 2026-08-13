# Volume Layout Baseline

## Commands used

```text
D U,DASD,ONLINE
D U,VOL=SBRES1
D U,VOL=SBRES2
D U,VOL=SBSYS1
D U,VOL=ZVOL00
```

## Volumes observed

```text
SBRES1
SBRES2
SRSYS1
SBUSS1
SBSYS1
SBBBN2
SBPRD1
SBPRD2
ZVOL00
```

## Interpretation

| Volume | Role in this baseline |
|---|---|
| SBRES1 | Base/resident system-related volume |
| SBRES2 | Base/resident system-related volume |
| SRSYS1 | System volume observed online |
| SBUSS1 | ADCD system/product/user support volume |
| SBSYS1 | System volume; SMF MAN datasets observed here |
| SBBBN2 | Additional online volume |
| SBPRD1 | Product/runtime volume |
| SBPRD2 | Product/runtime volume |
| ZVOL00 | Additional/lab volume; SMF MAN4-6 observed here |

This table is intentionally conservative. Final business roles should only be assigned after catalog and dataset inventory is complete.

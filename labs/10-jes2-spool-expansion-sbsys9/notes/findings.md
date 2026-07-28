# Findings

## Baseline

The system was running with only one active JES2 spool volume:

```text
SBSYS1 ACTIVE
TGNUM=3000
PERCENT=58
```

`SPOOLDEF` confirmed the active configuration:

```text
DSNAME=SYS1.HASPACE
VOLUME=SBSYS
TGSPACE=(MAX=32576,DEFINED=3000,ACTIVE=3000,PERCENT=58.600,FREE=1242,WARN=80)
```

This meant the system had significant spool pressure for a lab machine.

## Device selection

Device `0A9D` was available as a 3390 device without a mounted volume:

```text
0A9D 3390 F-NRD
```

That made it a good candidate for the new SPOOL DASD.

## Volume naming decision

The existing JES2 SPOOLDEF used:

```text
VOLUME=SBSYS
```

Therefore the new volume was named:

```text
SBSYS9
```

This avoided changing JES2PARM and avoided using `SBSYS2`, which already existed in the ADCD system.

## Allocation lesson

The final successful path avoided fragile long DD continuation and used TSO `ALLOCATE` inside `IKJEFT01`:

```text
ALLOC DA('SYS1.HASPACE') NEW KEEP UNIT(3390) -
 VOL(SBSYS9) SPACE(3000) CYL -
 DSORG(PS) RECFM(U) BLKSIZE(3856)
```

The allocation produced evidence of successful DASD allocation and `COND CODE 0000`.

## Final result

After `$S SPOOL(SBSYS9)`, JES2 reported:

```text
DEFINED=18000
ACTIVE=18000
PERCENT=9.8333
FREE=16230
```

The expansion was successful.

# LAB18B — SMF MAN Dataset Sizing and Rotation Stabilization

## Objective

Stabilize SMF recording in the ADCD z/OS 1.11 laboratory by moving beyond manual SMF cleanup and adding additional, larger MAN data sets for SMF rotation.

This lab continues LAB18. LAB18 proved that `SMFDMP` can recover full SMF MAN data sets. LAB18B improves the configuration so SMF has more recording capacity before entering repeated `DUMP REQUIRED` conditions.

## Environment

- Platform: z/OS ADCD 1.11 on Hercules
- System name: `ADCD`
- IPL context observed: `IEASYS=DB`, `IEASYM=00`
- IPL device: `0A80`, volume `SBRES1`
- IPLPARM device: `0A82`
- PARMLIB search order observed:
  1. `USER.PARMLIB`
  2. `ADCD.Z111S.PARMLIB`
  3. `SYS1.PARMLIB`

## Initial condition

`D SMF` showed only three MAN data sets:

```text
SYS1.MAN1  SBSYS1   7200   ACTIVE
SYS1.MAN2  SBSYS1   1800   ALTERNATE
SYS1.MAN3  SBSYS1   1800   ALTERNATE
```

`D R,L` showed no outstanding messages after the previous cleanup.

## Baseline findings

The active `ADCD.Z111S.PARMLIB(SMFPRM00)` used only:

```text
DSNAME(SYS1.MAN1,
       SYS1.MAN2,
       SYS1.MAN3)
```

`LISTCAT` confirmed that the existing MAN data sets were VSAM linear-style/nonindexed SMF data sets with attributes including:

- `NONINDEXED`
- `REUSE`
- `SPANNED`
- `SPEED`
- `CONTROLINTERVALSIZE(4096)`
- `RECORDSIZE(4086 32767)`
- `SHAREOPTIONS(2 3)`
- Volume: `SBSYS1`

The important sizing difference was:

```text
SYS1.MAN1  SPACE-PRI 40 CYL
SYS1.MAN2  SPACE-PRI 10 CYL
SYS1.MAN3  SPACE-PRI 10 CYL
```

## Change implemented

Three new larger MAN data sets were created on `ZVOL00`:

```text
SYS1.MAN4
SYS1.MAN5
SYS1.MAN6
```

Each was defined with `CYLINDERS(80 0)`, matching the SMF attributes of the original MAN data sets while increasing capacity.

They were then formatted/cleared with `IFASMFDP` and added to a new alternate SMF parameter member:

```text
USER.PARMLIB(SMFPRMB8)
```

The new `DSNAME` list is:

```text
DSNAME(SYS1.MAN1,
       SYS1.MAN2,
       SYS1.MAN3,
       SYS1.MAN4,
       SYS1.MAN5,
       SYS1.MAN6)
```

The active SMF configuration was switched with:

```text
/SET SMF=B8
```

## Final verification

Final `D SMF` showed six MAN data sets available to SMF:

```text
SYS1.MAN1  SBSYS1   7200   ACTIVE
SYS1.MAN2  SBSYS1   1800   ALTERNATE
SYS1.MAN3  SBSYS1   1800   ALTERNATE
SYS1.MAN4  ZVOL00  14400   ALTERNATE
SYS1.MAN5  ZVOL00  14400   ALTERNATE
SYS1.MAN6  ZVOL00  14400   ALTERNATE
```

`D R,L` showed:

```text
NO MESSAGES OUTSTANDING
```

The support jobs completed successfully:

```text
DEFMANB  CC 0000
FMTMANB  CC 0000
LCATMB   CC 0000
```

## Capacity improvement

Before:

```text
7200 + 1800 + 1800 = 10800 blocks
```

After:

```text
7200 + 1800 + 1800 + 14400 + 14400 + 14400 = 54000 blocks
```

Result:

```text
SMF MAN recording capacity increased by approximately 5x.
```

## Professional value

This lab demonstrates real z/OS operational engineering:

- diagnosis of repeated SMF MAN data set exhaustion;
- inspection of active SMF parameters;
- LISTCAT-based sizing analysis;
- safe addition of new MAN data sets without deleting original system data sets;
- use of `USER.PARMLIB` for an alternate SMF parameter member;
- controlled runtime activation with rollback path;
- final verification using operator commands and SDSF evidence.

## Scope intentionally not covered

This lab does not implement automated SMF offload, long-term retention, SMF record analytics, SMF exits, or SMFPRM persistence at IPL. Those are candidates for a later operational automation lab.

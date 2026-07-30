# Findings - LAB 13 SMF

## Finding 1 - SMF not recording initially

Initial console display showed:

```text
IEE351I SMF SYS1.MAN RECORDING NOT BEING USED
```

This means SMF was present but not writing records to MAN datasets.

## Finding 2 - IPL configuration points to SMF=00

`ADCD.Z111S.PARMLIB(IEASYSDB)` contains:

```text
SMF=00
```

Therefore the active SMF member is expected to be:

```text
ADCD.Z111S.PARMLIB(SMFPRM00)
```

## Finding 3 - SMFPRM00 disabled recording

`SMFPRM00` initially contained:

```text
NOACTIVE
```

That explains why `SET SMF=00` did not enable recording before the edit.

## Finding 4 - SYS1.MAN datasets exist

The system already had:

```text
SYS1.MAN1
SYS1.MAN2
SYS1.MAN3
```

They were VSAM-backed SMF MAN datasets and did not need deletion or redefinition in this lab.

## Finding 5 - Controlled activation succeeded

After backup and changing `NOACTIVE` to `ACTIVE`, `SET SMF=00` caused MAN datasets to be formatted and SMF began recording on `SYS1.MAN1`.

Final state:

```text
P-SYS1.MAN1  ACTIVE
S-SYS1.MAN2  ALTERNATE
S-SYS1.MAN3  ALTERNATE
```

## Out of scope

- SMF dump/export with IFASMFDP or DUMPXY.
- Redefinition of SYS1.MAN datasets.
- Changing SMF record types.
- RACF hardening of SYS1.MAN*.

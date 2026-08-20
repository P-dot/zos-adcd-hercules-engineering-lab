# Troubleshooting — Lab 26

## T26-01 — Invalid `SR` action during initial member comparison attempt

An early attempt to use `SR` from the member list returned an invalid-action message.

**Resolution:** switched to ISPF SuperC (3.13) for deterministic member comparison.

**Lesson:** do not assume line commands are available in every panel/profile.

## T26-02 — `$D PROCLIB` returned RC=52

Observed:

`$HASP003 RC=(52),D PROCLIB - NO SELECTABLE ENTRIES FOUND`

**Action:** stopped relying on the generic display form and inspected JES2/PARMLIB/PROCLIB configuration.

## T26-03 — Static PROC00 referenced data sets not found through ISPF 3.4

The observed static JES2 PROC contained:

- VENDOR.PROCLIB
- SVTSC.PROCLIB
- LVL0.PROCLIB
- SYS1.PROCLIB

The first three were not found through the performed ISPF 3.4 searches.

**Action:** retained the finding but did not delete or alter those references.

**Reason:** absence from the performed catalog search is not sufficient justification for changing JES2 startup configuration.

## T26-04 — Expected negative test unexpectedly succeeded

A test job without `JCLLIB` was expected to fail if `USER.PROCLIB` was not in the effective system search path.

Instead:

- `LAB26TST` was expanded using system library `USER.PRO...`;
- the step completed CC 0000.

**Resolution:** rejected the planned PROC00 modification as redundant.

**Lesson:** runtime evidence overrides an incomplete static-configuration assumption.

## T26-05 — `$D PROCLIB(PROC00)` also returned RC=52

Observed:

`$HASP003 RC=(52),D PROCLIB(PROC00) - NO SELECTABLE ENTRIES`

**Action:** no further command-guessing was performed.

**Final position:** the exact source of the effective `USER.PROCLIB` system-library registration remains outside the proven scope of this lab.

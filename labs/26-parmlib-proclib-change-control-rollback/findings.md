# Findings — Lab 26

## F26-01 — USER.PARMLIB participates in the active PARMLIB concatenation

`D PARMLIB` evidence shows `USER.PARMLIB` in the active concatenation ahead of the ADCD/system PARMLIB entries.

**Classification:** KEEP / DOCUMENT.

## F26-02 — SMF recovery member is byte/line equivalent at baseline

SuperC showed `SMFPRMB8` and `SMFBK25` as SAME before the controlled change.

**Classification:** CONTROL EFFECTIVE.

## F26-03 — Rollback restores exact observed baseline

After the documentary change produced DIFF, restoring from `SMFBK25` returned SuperC to SAME and restored the observed baseline hash `3186B11`.

**Classification:** CONTROL EFFECTIVE.

## F26-04 — Static JES2 PROC00 view did not fully explain runtime behavior

`SYS1.PROCLIB(JES2)` showed a static `PROC00` concatenation referencing `VENDOR.PROCLIB`, `SVTSC.PROCLIB`, `LVL0.PROCLIB` and `SYS1.PROCLIB`.

ISPF 3.4 did not find the first three data sets.

However, runtime execution later resolved `USER.PROCLIB(LAB26TST)` as a system library without `JCLLIB`.

**Classification:** REVIEW / RUNTIME PRECEDENCE OR ADDITIONAL CONFIGURATION SOURCE.

The lab intentionally does not claim to have identified the exact mechanism.

## F26-05 — USER.PROCLIB is structurally suitable for JCL procedures

Observed attributes:

- DSORG PO
- RECFM FB
- LRECL 80
- BLKSIZE 9040

`SYS1.PROCLIB` also uses PO / FB / LRECL 80.

**Classification:** KEEP.

## F26-06 — Recovery copy for JES2 PROC verified

`SYS1.PROCLIB(JES2)` and `USER.PROCLIB(JES2BK26)` compared SAME with 40 lines, 3200 bytes and hash `CC2224F`.

**Classification:** CONTROL EFFECTIVE.

## F26-07 — Local test procedure works through private-library resolution

`LAB26TST` executed through `JCLLIB ORDER=USER.PROCLIB` and completed CC 0000.

**Classification:** PASS.

## F26-08 — Local test procedure also resolves as a system library

The no-JCLLIB control test expanded `LAB26TST` using system library `USER.PRO...` and completed CC 0000.

**Classification:** IMPORTANT DISCOVERY / KEEP.

## F26-09 — Proposed JES2 change was redundant

Because runtime already provided the desired procedure resolution, the planned modification was not performed.

**Classification:** CHANGE REJECTED / NO CHANGE REQUIRED.

## F26-10 — Post-test system remained operational

Final `/D A,L` evidence showed normal system activity including JES2 and other major address spaces.

**Classification:** POST-CHANGE/POST-TEST VALIDATION PASS.

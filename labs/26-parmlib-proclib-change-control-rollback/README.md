# Lab 26 — PARMLIB / PROCLIB Change Control & Rollback

## Purpose

Establish and demonstrate a controlled z/OS change-management workflow for PARMLIB and PROCLIB objects in the IBM z/OS ADCD 1.11 / Hercules laboratory.

The lab focuses on evidence-driven administration:

- establish a pre-change baseline;
- create and verify recovery copies;
- introduce a controlled, low-risk change;
- detect the change objectively;
- perform rollback;
- verify exact restoration;
- perform pre-change analysis on PROCLIB;
- reject a redundant system change when runtime evidence shows that the desired capability already exists.

This lab does **not** claim a performance improvement. Its result is improved operational discipline, recoverability, traceability and change-risk control.

## Environment

- IBM z/OS ADCD 1.11
- Hercules
- TSO / ISPF
- SDSF
- JES2
- SMF
- SuperC
- PARMLIB / PROCLIB
- User: IBMUSER

## Scope

### PARMLIB
Controlled validation and rollback of:

- `USER.PARMLIB(SMFPRMB8)`
- recovery copy `USER.PARMLIB(SMFBK25)`

### PROCLIB
Discovery and validation involving:

- `SYS1.PROCLIB(JES2)`
- `USER.PROCLIB`
- recovery copy `USER.PROCLIB(JES2BK26)`
- test procedure `USER.PROCLIB(LAB26TST)`
- test jobs using and omitting `JCLLIB`

## Result

**PASS**

PARMLIB change/rollback was demonstrated end-to-end.

For PROCLIB, pre-change analysis showed that the proposed addition of `USER.PROCLIB` to the observed static `PROC00` definition was unnecessary: a job without `JCLLIB` successfully resolved `LAB26TST` from `USER.PROCLIB` as a **system library** and completed with condition code `0000`.

The proposed JES2 change was therefore rejected as redundant.

## PARMLIB workflow

1. Display active PARMLIB concatenation.
2. Confirm `USER.PARMLIB` and target members.
3. Verify `SMFPRMB8` and `SMFBK25` are identical with SuperC.
4. Capture the pre-change content of `SMFPRMB8`.
5. Make a documentary-only controlled change.
6. Verify SuperC reports a difference.
7. Restore `SMFPRMB8` from `SMFBK25`.
8. Verify SuperC returns to SAME and the original hash.

Observed baseline/rollback values:

- 25 lines
- 2000 bytes
- baseline hash shown by SuperC: `3186B11`

Controlled-change comparison produced a different hash (`0229C55`), after which rollback returned to the baseline hash.

## PROCLIB workflow

1. Attempted generic JES2 PROCLIB display; command returned `$HASP003 RC=(52)`.
2. Located JES2 initialization members in `ADCD.Z111S.PARMLIB`.
3. Observed `PROCLIB=00` / `PROC00` reference.
4. Located `SYS1.PROCLIB(JES2)` and its static `PROC00` concatenation.
5. Checked referenced data sets:
   - `VENDOR.PROCLIB` — not found by ISPF 3.4
   - `SVTSC.PROCLIB` — not found by ISPF 3.4
   - `LVL0.PROCLIB` — not found by ISPF 3.4
   - `SYS1.PROCLIB` — present
6. Confirmed `USER.PROCLIB` exists and is empty at discovery time.
7. Compared data-set attributes:
   - `USER.PROCLIB`: PO / FB / LRECL 80 / BLKSIZE 9040
   - `SYS1.PROCLIB`: PO / FB / LRECL 80 / BLKSIZE 6160
8. Copied `SYS1.PROCLIB(JES2)` to `USER.PROCLIB(JES2BK26)`.
9. Verified the copy with SuperC:
   - 40 lines
   - 3200 bytes
   - hash `CC2224F`
   - SAME
10. Created `USER.PROCLIB(LAB26TST)` using `IEFBR14`.
11. Tested it as a private procedure using `JCLLIB ORDER=USER.PROCLIB`.
12. Result: procedure expanded from private library; condition code `0000`.
13. Submitted a second test without `JCLLIB`.
14. Result: `LAB26TST` was expanded using system library `USER.PRO...`; condition code `0000`.
15. Because the desired capability already existed at runtime, no JES2/PROC00 functional change was made.
16. Final `/D A,L` evidence confirmed normal system activity after the investigation.

## Key engineering conclusion

Static configuration inspection alone was insufficient to describe the effective runtime procedure search path.

The lab therefore used runtime behavior as the deciding evidence. The intended system change was rejected because it would have been redundant.

This is the principal operational lesson of Lab 26:

> A proposed change must survive baseline, impact and runtime validation before it is implemented.

## Safety / limitations

- No JES2 restart was performed.
- No `$P JES2` / `$S JES2` sequence was performed.
- No production-like critical PROC was intentionally altered for testing.
- The SMF test changed only a comment; no SMF operational parameter was changed.
- No claim is made that the exact mechanism by which `USER.PROCLIB` is present in the effective system procedure search path was fully identified.
- `$D PROCLIB` and `$D PROCLIB(PROC00)` returned RC=52 in this environment; these failures are retained as troubleshooting evidence rather than hidden.

## Evidence

All screenshots are stored under:

`evidence/screenshots/`

The package contains the 34 screenshots embedded in the supplied 16-page evidence document plus the two final screenshots supplied after it, for a total of **36 evidence images**.

See `evidence/manifest.md` for the evidence map.

## Final status

**LAB 26 — COMPLETED / PASS**

Next logical phase: establish a measurable z/OS performance baseline (RMF/SMF/WLM) before attempting tuning, so future optimization can be justified with before/after metrics.

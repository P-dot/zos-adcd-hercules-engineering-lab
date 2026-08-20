# Change Record — Lab 26

## Change objective

Demonstrate controlled PARMLIB/PROCLIB administration with verified recovery and evidence-based go/no-go decisions.

## PARMLIB change

**Object:** `USER.PARMLIB(SMFPRMB8)`

**Recovery object:** `USER.PARMLIB(SMFBK25)`

**Risk level:** Low

**Change type:** Documentary-only validation change.

**Functional SMF parameter change:** None.

### Authorization criteria

- active PARMLIB identified;
- recovery member present;
- SuperC baseline = SAME;
- pre-change member captured.

### Validation

Pre-change:
- 25 lines;
- 2000 bytes;
- hash `3186B11`;
- SAME.

After documentary change:
- SuperC = DIFF;
- hash changed to `0229C55`.

After rollback:
- SuperC = SAME;
- 25 lines;
- 2000 bytes;
- hash restored to `3186B11`.

### Outcome

**ACCEPTED AS TEST, THEN ROLLED BACK SUCCESSFULLY.**

No operational SMF behavior was intentionally changed.

## PROCLIB proposed change

**Initial proposal:** add/use `USER.PROCLIB` as a system procedure library by modifying the JES2 `PROC00` path.

**Recovery object prepared:** `USER.PROCLIB(JES2BK26)` from `SYS1.PROCLIB(JES2)`.

**Backup validation:** SuperC SAME, 40 lines, 3200 bytes, hash `CC2224F`.

### Pre-change validation

`USER.PROCLIB(LAB26TST)` was created and tested.

Private test with `JCLLIB ORDER=USER.PROCLIB`:
- procedure expanded;
- CC 0000.

Negative/control test without `JCLLIB`:
- procedure still expanded;
- message identified `USER.PRO...` as SYSTEM LIBRARY;
- CC 0000.

### Decision

**CHANGE REJECTED — NO CHANGE REQUIRED.**

Runtime evidence demonstrated that the desired capability already existed. Modifying JES2/PROC00 would therefore have introduced unnecessary risk without adding demonstrated functionality.

## Rollback readiness

PARMLIB rollback: demonstrated.

PROCLIB rollback copy: prepared and verified, but not required because the proposed functional JES2 change was not implemented.

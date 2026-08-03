# LAB 17 — DFSMS SMS ACS Rules and Automatic Dataset Allocation

## Objective

Implement a controlled DFSMS/SMS laboratory flow on IBM ADCD z/OS under Hercules, moving from manual volume handling to policy-driven dataset allocation using SMS constructs and ACS routines.

The lab proves that a dataset matching `IBMUSER.SMSLAB.*` can be allocated without hardcoding `UNIT`, `VOL=SER`, `STORCLAS`, or `STORGRP`, and that SMS/ACS assigns it through the configured policy.

## Environment

- Platform: IBM ADCD z/OS 1.11 running on Hercules.
- Main user: `IBMUSER`.
- SMS CDS used: `SYS1.SCDS`.
- Active SMS datasets shown by `D SMS`: `SYS1.SCDS`, `SYS1.ACDS`, `SYS1.COMMDS`.
- Lab volumes:
  - `SMS000` on `0A9E`
  - `SMS001` on `0A9F`
  - `SMS002` on `0AA0`
- Storage Class: `SMSLAB`.
- Storage Group: `SMSPOOL`.
- ACS source library: `IBMUSER.HARDEN.CNTL`.

## Implemented flow

1. Created/attached three 3390 DASD volumes for SMS laboratory storage.
2. Created `SMSLAB` Storage Class in `SYS1.SCDS`.
3. Created `SMSPOOL` Storage Group and associated `SMS000`, `SMS001`, `SMS002`.
4. Built ACS routines:
   - `ACSSTOR`: assigns `STORCLAS=SMSLAB` for `IBMUSER.SMSLAB.*`.
   - `ACSGRP`: assigns `STORGRP=SMSPOOL` when `STORCLAS=SMSLAB`; otherwise preserves default allocation to `DBCLASS`.
5. Translated ACS routines successfully with RC 0000.
6. Validated the SCDS successfully, with a controlled warning for `HFSCLASS` not referenced by the Storage Group ACS routine.
7. Tested ACS routing successfully:
   - `SC = SMSLAB`
   - `SG = SMSPOOL`
   - `ACS TESTING RC = 00`
8. Activated `SYS1.SCDS`.
9. Diagnosed and fixed two real DFSMS allocation blockers:
   - `04160054`: candidate volumes were not initialized as SMS-managed.
   - SMS volume status was `DISABLED`.
10. Reinitialized the SMS volumes using ICKDSF with indexed VTOC and `SG`.
11. Enabled `SMSPOOL` and volumes `SMS000/SMS001/SMS002`.
12. Allocated `IBMUSER.SMSLAB.TEST1` without `UNIT`, `VOL=SER`, `STORCLAS`, or `STORGRP`.
13. Verified with IDCAMS LISTCAT that the dataset exists, has `STORAGECLASS=SMSLAB`, and resides on `SMS001`, a volume in `SMSPOOL`.

## Final result

The lab is complete. DFSMS/SMS is now not just present; it is making automatic allocation decisions through ACS rules.

Final proof:

- `ALCSMS` completed successfully.
- `LCATSMS` completed successfully.
- `IBMUSER.SMSLAB.TEST1` was found by LISTCAT.
- `STORAGECLASS = SMSLAB`.
- `VOLSER = SMS001`.
- `SMS001` is part of `SMSPOOL`.

## Professional value

This lab demonstrates practical mainframe storage administration skills:

- ISMF navigation and SMS construct management.
- ACS source creation, translation, validation, testing, display, and activation.
- Safe integration with existing active ACS routines.
- DFSMS allocation troubleshooting using `IGD17xxx` messages.
- ICKDSF initialization of SMS-managed DASD volumes.
- Verification of real SMS-managed allocation through batch JCL and LISTCAT.

## Evidence

All extracted screenshots from the working session are stored in:

```text
/evidence/screenshots/
```

Key screenshots include:

- Pre-activation `D SMS` and non-managed volumes.
- Storage Class and Storage Group definition.
- ACS translation and validation.
- ACS test with `SC=SMSLAB` and `SG=SMSPOOL`.
- `NEW CONFIGURATION ACTIVATED FROM SCDS SYS1.SCDS`.
- `SMSPOOL` and `SMS000/SMS001/SMS002` active.
- Allocation failures showing `04160054` and `SMS VOLUME STATUS WAS DISABLED`.
- ICKDSF reinitialization with `PURGE SG` and MAXCC 0.
- Final `ALCSMS` and `LCATSMS` success.
- Final LISTCAT showing `IBMUSER.SMSLAB.TEST1`, `STORAGECLASS=SMSLAB`, and `VOLSER=SMS001`.

## Repository placement

Recommended path:

```text
labs/17-dfsms-sms-acs-automatic-allocation/
```

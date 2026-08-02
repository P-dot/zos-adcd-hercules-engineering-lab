# LAB 16 - DFSMS SMS Pool Creation

## Objective

Create a controlled SMS storage pool in ADCD z/OS 1.11 on Hercules.

This lab creates three new DASD volumes, initializes them with ICKDSF, defines an SMS storage group called `SMSPOOL` in `SYS1.SCDS`, and adds `SMS000`, `SMS001`, and `SMS002` to the pool.

## Environment

- z/OS ADCD 1.11 on Hercules
- System: ADCD
- User: IBMUSER
- ISMF: z/OS DFSMS V1R11
- DASD: 3390-3 CCKD

## Devices and volumes

| Device | VOLSER | Physical file |
|---|---|---|
| 0A9E | SMS000 | F:\ZOS111\SMS000.CCKD |
| 0A9F | SMS001 | F:\ZOS111\SMS001B.CCKD |
| 0AA0 | SMS002 | F:\ZOS111\SMS002.CCKD |

`SMS001B.CCKD` was used because the original `SMS001.CCKD` produced a Windows/Hercules permission error.

## Final result

Evidence confirms:

```text
INISMS CC 0000
SMSPOOL SAVED
ALL VOLUMES DEFINED
SMS000 ADCD ENABLE / SMS SG ENABLE
SMS001 ADCD ENABLE / SMS SG ENABLE
SMS002 ADCD ENABLE / SMS SG ENABLE
```

## Not in scope

No global SMS activation was performed. No `SETSMS`, no ACS routine activation, no Storage Class/Data Class/Management Class rules, and no automatic allocation test were done in this lab.

## Next lab

`LAB 17 - SMS ACS Rules and Automatic Dataset Allocation`

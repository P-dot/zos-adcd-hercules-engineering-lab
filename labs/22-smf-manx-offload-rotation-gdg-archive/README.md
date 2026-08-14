# Lab 22 — SMF MAN Dataset Operations Continuation: Production-Style Offload, Rotation and GDG Archive

## Objective

Implement and validate an operational procedure for SMF MAN dataset
offload and rotation, extending the SMF baseline established in Labs
13, 14, 18 and 18B.

The lab covers:

- SMF MAN dataset operational states
- Detection of DUMP REQUIRED conditions
- Operator requests (IEE362A)
- IFASMFDP processing
- JCL and utility error diagnosis
- MAN dataset rotation
- Post-operation verification
- GDG-based SMF archive design

---

## Initial state

The system uses six SMF MAN datasets:

- SYS1.MAN1
- SYS1.MAN2
- SYS1.MAN3
- SYS1.MAN4
- SYS1.MAN5
- SYS1.MAN6

During the lab, `D SMF` showed MAN datasets in three relevant states:

- ACTIVE — currently receiving SMF records
- DUMP REQUIRED — contains SMF data requiring operational processing
- ALTERNATE — available for future SMF use

Operator requests were also visible through `D R,L` / SDSF SR:

    IEE362A SMF ENTER DUMP FOR SYS1.MANx

This provided a real operational condition for the lab.

---

## SMF offload

IBM utility IFASMFDP was used to process SMF MAN datasets.

The basic flow is:

    SYS1.MANx
         |
         v
     IFASMFDP
         |
         v
    SMF archive dataset

Existing operational members in:

    IBMUSER.HARDEN.CNTL

were reviewed and used during MAN dataset processing.

Relevant members:

    SMFDMP
    SMFDMP2

The lab also created an educational/test member to study IFASMFDP
processing and JCL behavior.

---

## Error diagnosis

The lab intentionally preserved real execution errors as engineering
evidence.

### IFASMFDP RC=0008

An IFASMFDP execution completed with:

    COND CODE 0008

and:

    IEE946I UNEXPECTED END OF TEXT IN SYSIN INPUT

This demonstrated the difference between:

- valid JCL followed by a program return code
- a JCL syntax error that prevents execution

The IFASMFDP SYSIN control statements were corrected and the job
subsequently completed successfully.

### JCL ERROR — IEF644I

While preparing the GDG offload procedure, JES detected:

    IEF452I ... JOB NOT RUN - JCL ERROR
    IEF644I INVALID NUMERIC IN THE SPACE FIELD

The incorrect SPACE parameter was corrected to:

    SPACE=(CYL,(10,10),RLSE)

This demonstrated that a JCL ERROR occurs before the application
program executes.

---

## Operational verification

After processing the pending MAN datasets, `D SMF` showed a clean
rotation state:

- one MAN dataset ACTIVE
- remaining MAN datasets ALTERNATE
- no MAN datasets in DUMP REQUIRED state

`D R,L` was also checked to confirm that the previous SMF IEE362A
operator requests were no longer pending.

This validates the operational cycle:

    ACTIVE
       |
       v
    rotation
       |
       v
    DUMP REQUIRED
       |
       v
    IFASMFDP
       |
       v
    ALTERNATE

---

## GDG archive

A GDG base was created to provide controlled historical retention of
future SMF offloads:

    IBMUSER.SMF.ARCHIVE

IDCAMS definition:

    DEFINE GDG -
      (NAME(IBMUSER.SMF.ARCHIVE) -
       LIMIT(10) -
       NOEMPTY -
       SCRATCH)

The definition completed with RC=0000.

`LISTCAT` confirmed:

- GDG base: IBMUSER.SMF.ARCHIVE
- LIMIT: 10
- NOEMPTY
- SCRATCH

Future offloads can create new generations using:

    IBMUSER.SMF.ARCHIVE(+1)

which will produce generation datasets such as:

    IBMUSER.SMF.ARCHIVE.G0001V00
    IBMUSER.SMF.ARCHIVE.G0002V00

---

## GDG offload procedure

The member:

    IBMUSER.HARDEN.CNTL(SMFGDG)

was prepared for future SMF MAN offloads.

The input MAN dataset must be changed to the MAN currently shown by
`D SMF` as:

    DUMP REQUIRED

The output uses:

    DSN=IBMUSER.SMF.ARCHIVE(+1)

The procedure must never be deliberately run against the current
ACTIVE MAN dataset.

---

## Operator runbook

1. Issue `D SMF`.
2. Identify any MAN dataset in `DUMP REQUIRED`.
3. Confirm which MAN dataset is `ACTIVE`.
4. Never select the ACTIVE MAN for the offload procedure.
5. Set the SMFGDG input DD to the MAN requiring processing.
6. Submit the IFASMFDP job.
7. Check JES/SDSF for JCL errors, return codes and IFASMFDP messages.
8. Require successful completion before considering the operation complete.
9. Issue `D SMF` again.
10. Confirm the processed MAN returned to `ALTERNATE`.
11. Issue `D R,L` / review SDSF SR.
12. Confirm the corresponding IEE362A request disappeared.
13. Verify the generated SMF archive dataset.

---

## Final state

At lab completion:

- SMF recording remained operational.
- One MAN dataset was ACTIVE.
- Remaining MAN datasets were ALTERNATE.
- No MAN dataset remained in DUMP REQUIRED.
- Previous IEE362A SMF requests were cleared.
- IBMUSER.SMF.ARCHIVE GDG was defined and cataloged.
- SMFGDG was prepared for the next natural MAN rotation.

The first production-style GDG generation was subsequently created
and validated during a natural SMF MAN dataset rotation.

---

## Result

**LAB 22: COMPLETED**

The system now has a documented operational procedure covering SMF
MAN dataset diagnosis, offload, rotation, verification and historical
archive preparation.

This extends the previous SMF engineering work from basic MAN dataset
maintenance into a repeatable operations-oriented procedure.

---

## Final End-to-End Validation

**Status: COMPLETED — END-TO-END VALIDATED**

The final phase of Lab 22 validated the complete SMF MAN dataset
operational cycle under a naturally occurring rotation condition.

### Natural SMF rotation observed

SMF had previously been recording on:

    SYS1.MAN3

During normal system activity, SMF naturally rotated away from MAN3.

The system issued:

    IEE362A SMF ENTER DUMP FOR SYS1.MAN3

and simultaneously reported that SMF had switched recording to:

    SYS1.MAN1

The resulting operational state was:

    SYS1.MAN1          ACTIVE
    SYS1.MAN3   94%    DUMP REQUIRED

This was not an artificially forced condition. It was a real SMF
rotation observed during normal operation of the system.

### Production-style GDG offload

The prepared member:

    IBMUSER.HARDEN.CNTL(SMFGDG)

was updated so that its MANX DD referenced:

    SYS1.MAN3

The ACTIVE MAN dataset, SYS1.MAN1, was deliberately left untouched.

IFASMFDP then processed the MAN dataset in DUMP REQUIRED status and
wrote the archived SMF records through:

    IBMUSER.SMF.ARCHIVE(+1)

The job completed successfully.

### Final SMF state

After the offload, `D SMF` confirmed:

    SYS1.MAN1   27%    ACTIVE
    SYS1.MAN2    0%    ALTERNATE
    SYS1.MAN3    0%    ALTERNATE
    SYS1.MAN4    0%    ALTERNATE
    SYS1.MAN5    0%    ALTERNATE
    SYS1.MAN6    0%    ALTERNATE

The important transition was therefore:

    SYS1.MAN3
    94% DUMP REQUIRED
            |
            | IFASMFDP / SMFGDG
            v
     0% ALTERNATE

SMF continued recording normally on SYS1.MAN1.

### Operator request verification

`D R,L` was checked after processing.

The previous:

    IEE362A SMF ENTER DUMP FOR SYS1.MAN3

request was no longer present.

This confirmed that the SMF dump requirement had been operationally
satisfied.

### GDG generation verification

The GDG base was queried with:

    LISTCAT ENT('IBMUSER.SMF.ARCHIVE') ALL

LISTCAT confirmed the existing GDG policy:

    LIMIT(10)
    NOEMPTY
    SCRATCH

and, critically, showed the first real generation:

    IBMUSER.SMF.ARCHIVE.G0001V00

This proves that:

    IBMUSER.SMF.ARCHIVE(+1)

was successfully resolved and cataloged as the first historical SMF
archive generation.

---

## End-to-End Result

The complete validated sequence is:

    SMF recording on SYS1.MAN3
                 |
                 v
          natural rotation
                 |
                 v
    SYS1.MAN3 = DUMP REQUIRED
    SYS1.MAN1 = ACTIVE
                 |
                 v
             IEE362A
                 |
                 v
       SMFGDG / IFASMFDP
                 |
                 v
    IBMUSER.SMF.ARCHIVE(+1)
                 |
                 v
    IBMUSER.SMF.ARCHIVE.G0001V00
                 |
                 v
    SYS1.MAN3 = ALTERNATE
                 |
                 v
       IEE362A cleared
                 |
                 v
      END-TO-END VALIDATED

---

## Relationship to Previous SMF Labs

Lab 22 is a continuation and operational consolidation of the previous
SMF engineering work in this repository.

The progression is:

    Lab 13
    SMF baseline and activation readiness
            |
            v
    Lab 14
    SMF MAN dump / IFASMFDP export
            |
            v
    Lab 18 / 18B
    MAN dataset maintenance, sizing,
    rotation and stabilization
            |
            v
    Lab 21
    Enterprise system baseline and
    outstanding operational review
            |
            v
    Lab 22
    Production-style MAN operations,
    natural rotation, offload,
    GDG archival and verification

Lab 22 therefore does not represent an isolated SMF exercise.

It closes the operational chain established by the earlier SMF labs
and converts the previous individual exercises into a repeatable
operations-oriented workflow.

---

## Final Result Summary

| Control / capability | Result |
|---|---|
| SMF recording | PASS |
| MAN dataset rotation | PASS |
| Natural DUMP REQUIRED condition observed | PASS |
| IEE362A operator request detected | PASS |
| IFASMFDP offload | PASS |
| MAN returned to ALTERNATE | PASS |
| Active MAN remained operational | PASS |
| IEE362A request cleared | PASS |
| GDG base creation | PASS |
| GDG retention policy | PASS |
| First `(+1)` allocation | PASS |
| `G0001V00` cataloged | PASS |
| End-to-end operational verification | PASS |

---

# LAB 22 STATUS

**COMPLETED — END-TO-END VALIDATED**

No SMF MAN dataset dump validation remains pending.

The system demonstrated a complete operational SMF lifecycle from
recording and natural MAN rotation through dump processing, recovery
to ALTERNATE status and generation-based historical archival.


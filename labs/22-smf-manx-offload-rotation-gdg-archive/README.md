# Lab 22 — SMF MANx Offload, Rotation and GDG Archive

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

The first production-style `(+1)` generation remains a future
validation point when the next natural DUMP REQUIRED condition occurs.

---

## Result

**LAB 22: COMPLETED**

The system now has a documented operational procedure covering SMF
MAN dataset diagnosis, offload, rotation, verification and historical
archive preparation.

This extends the previous SMF engineering work from basic MAN dataset
maintenance into a repeatable operations-oriented procedure.

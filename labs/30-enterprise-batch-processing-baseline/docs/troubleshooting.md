# Troubleshooting record

## 1. BATPROC remained in AWAITING EXECUTION

The first BATPROC submission was converted successfully and the private procedure
was expanded, but the job remained in `AWAITING EXECUTION`.

Observed state:
- job was not held (`HOLD=(NONE)`);
- `INIT(1)` was associated with `CLASS=A`;
- `JOBCLASS(A)` was enabled;
- WLM was active;
- JES2 exits 6, 50, 52, 53 and 54 were disabled;
- the internal reader default was `CLASS=A`.

The actual cause was then identified in the submitted JOB card: the test had been
entered as `CLASS=X,MSGCLASS=A` instead of the intended
`CLASS=A,MSGCLASS=X`.

Because no available initiator was servicing class X, the job remained waiting.
The controlled command:

    $T J'BATPROC',CLASS=A

made the already-converted job eligible. It was immediately selected by
`INIT 1` and completed successfully.

This incident demonstrates the operational difference between:
- `CLASS=`: execution/scheduling class;
- `MSGCLASS=`: output/message class.

It was not a WLM, JES2 exit, JCLLIB or initiator defect.

## 2. BATCOB JCL ERROR 613

The first generic COBOL PROC used a symbolic parameter named `PGM`:

    //RUNCOB PROC PGM=COBLAB01

and the caller used:

    //RUN EXEC PROC=RUNCOB,PGM=COBLAB01

JES2 reported that keyword `PGM` was mutually exclusive with keyword `PROC`
on the EXEC statement. The job was not run.

The symbolic parameter was renamed to `PROGRAM`:

    //RUNCOB PROC PROGRAM=COBLAB01
    //STEP01 EXEC PGM=&PROGRAM

and the caller became:

    //RUN EXEC PROC=RUNCOB,PROGRAM=COBLAB01

The corrected job expanded RUNCOB, loaded COBLAB01 through STEPLIB, produced
`FIRST COBOL PROGRAM LAB`, and completed with condition code 0000.

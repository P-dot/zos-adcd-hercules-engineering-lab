# Validation evidence

The baseline is considered complete because the following behaviours were
observed in the captured evidence:

1. JES2 job classes and initiators were inventoried before changes.
2. `INIT(1)` was confirmed for `CLASS=A`.
3. `IBMUSER.BATCH.PROCLIB` was allocated as a PDSE (`DSNTYPE=LIBRARY`),
   `RECFM=FB`, `LRECL=80`.
4. `JCLLIB ORDER=(IBMUSER.BATCH.PROCLIB)` successfully resolved the private
   procedure `HELLO`.
5. BATPROC eventually executed through `INIT 1 - CLASS A` and completed with
   condition code 0000.
6. `RUNCOB` was created as a reusable COBOL execution procedure using a symbolic
   `PROGRAM` parameter.
7. The first erroneous RUNCOB invocation produced JCL ERROR 613 and was
   corrected rather than hidden.
8. The corrected BATCOB job expanded RUNCOB from the private library.
9. `STEPLIB` allocated `IBMUSER.COBOL.LOAD`.
10. `COBLAB01` produced `FIRST COBOL PROGRAM LAB`.
11. BATCOB STEP01 completed with `COND CODE 0000`.

The lab therefore validates the path:

    SUBMIT -> JES2 CLASS A -> INIT(1) -> private JCLLIB/PROCLIB
           -> parameterized PROC -> COBOL load library -> SYSOUT -> CC 0000

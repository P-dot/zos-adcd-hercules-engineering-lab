# Lab 30 - Enterprise Batch Processing Baseline

## Objective

Build and validate a controlled enterprise-style batch foundation on the existing
z/OS ADCD/Hercules environment without modifying system PROCLIBs or introducing
unnecessary duplicate application libraries.

The lab establishes a reusable path from JES2 job submission to a private
procedure library and finally to a real COBOL load module.

## Scope

This is the baseline phase only. It covers:

- JES2 job-class and initiator inventory;
- private batch PROCLIB allocation;
- private PROC resolution through JCLLIB;
- job-class troubleshooting;
- WLM / JES2 exit / internal-reader diagnostics;
- parameterized COBOL execution through STEPLIB;
- real application SYSOUT;
- condition-code validation.

Dataset input/output flows, GDGs, restart/recovery, SMF correlation, RACF
segregation, Db2 integration and workload tuning are intentionally deferred to
later labs.

## Existing assets reused

The lab deliberately reuses existing portfolio assets instead of duplicating
them:

- application JCL library: `IBMUSER.COBOL.JCL`;
- COBOL load library: `IBMUSER.COBOL.LOAD`;
- tested COBOL module: `COBLAB01`.

The only new common batch library created in this phase is:

    IBMUSER.BATCH.PROCLIB

## New batch PROCLIB

`IBMUSER.BATCH.PROCLIB` was allocated as a PDSE with the following logical
attributes:

- DSNTYPE: LIBRARY
- RECFM: FB
- LRECL: 80
- Primary space: 5 tracks
- Secondary space: 5 tracks

A private JCLLIB was chosen so that the lab can be validated without changing
`SYS1.PROCLIB` or JES2 system PROCLIB definitions.

## Phase 1 - JES2 baseline

The environment was inventoried with JES2 display commands before changing
anything. The investigation established that `INIT(1)` services `CLASS=A`, and
that class A is a valid execution class.

An earlier production-like SMP/E job also provided evidence that class A jobs
can be selected by INIT 1.

## Phase 2 - Private procedure resolution

The first procedure was:

    IBMUSER.BATCH.PROCLIB(HELLO)

and the calling job used:

    //MYLIBS JCLLIB ORDER=(IBMUSER.BATCH.PROCLIB)
    //RUNPROC EXEC PROC=HELLO

JES2 reported that procedure HELLO was expanded using the private library.

This validated the key design principle of the lab:

    JOB -> JCLLIB -> private PROCLIB -> PROC -> STEP

## Phase 3 - Scheduling incident and diagnosis

The first BATPROC test remained in `AWAITING EXECUTION`.

The investigation checked:

- job HOLD state;
- JOBCLASS(A);
- initiator definitions;
- WLM state;
- JES2 exits 6, 50, 52, 53 and 54;
- internal-reader defaults.

Those checks did not reveal a JES2 infrastructure failure.

The root cause was eventually found in the submitted JOB card itself: the
execution class and message class had been entered in reverse during the test:

    CLASS=X,MSGCLASS=A

instead of:

    CLASS=A,MSGCLASS=X

Because no available initiator was servicing class X, the job waited. Changing
the in-flight job to class A made it immediately eligible for INIT 1.

This incident is retained because it provides direct evidence of the difference
between execution class and output class.

## Phase 4 - First reusable COBOL PROC

The lab then evolved from IEFBR14 to a real reusable COBOL runner:

    IBMUSER.BATCH.PROCLIB(RUNCOB)

Final form:

    //RUNCOB   PROC PROGRAM=COBLAB01
    //STEP01   EXEC PGM=&PROGRAM
    //STEPLIB  DD DISP=SHR,DSN=IBMUSER.COBOL.LOAD
    //SYSOUT   DD SYSOUT=*
    //SYSPRINT DD SYSOUT=*
    //         PEND

The calling job is `BATCOB` and supplies:

    PROGRAM=COBLAB01

This means the infrastructure is reusable: another compatible load module can
be selected without duplicating the PROC.

## Troubleshooting - JCL ERROR 613

The first generic version used a symbolic PROC parameter named `PGM`.

That collided with the EXEC `PGM` keyword and JES2 rejected the job with JCL
ERROR 613. The parameter was renamed to `PROGRAM`.

The failed execution is retained as evidence and the final JCL contains the
corrected form.

## Final validation

The final BATCOB execution demonstrated:

- RUNCOB expanded from `IBMUSER.BATCH.PROCLIB`;
- `IBMUSER.COBOL.LOAD` allocated to STEPLIB;
- `COBLAB01` executed;
- SYSOUT contained:

    FIRST COBOL PROGRAM LAB

- STEP01 completed with:

    COND CODE 0000

## Proven architecture

    IBMUSER.COBOL.JCL(BATCOB)
                |
                v
             JES2
            CLASS=A
                |
                v
             INIT(1)
                |
                v
    JCLLIB IBMUSER.BATCH.PROCLIB
                |
                v
             RUNCOB
        PROGRAM=COBLAB01
                |
                v
    STEPLIB IBMUSER.COBOL.LOAD
                |
                v
             COBLAB01
                |
                +--> SYSOUT: FIRST COBOL PROGRAM LAB
                |
                v
             CC=0000

## Result

**PASS**

Lab 30 establishes a reproducible enterprise batch baseline using the existing
ADCD environment and portfolio assets. The next phase should build on this
foundation with real batch input/output data flows rather than expanding this
baseline lab indefinitely.

# Lab 36 — Part 1: Batch Restart and Temporary Dataset Dependency

## Status
**Completed and validated**

## Objective
Demonstrate z/OS batch restart behavior and prove that a syntactically valid restart point is not necessarily an operationally recoverable restart point.

This Part 1 deliberately stops at the temporary-dataset limitation. Persistent checkpoints, lifecycle control, rerun safety and idempotency are reserved for Part 2.

## Context
Lab 35 established:

    SORTSTEP -> &&SORTED -> COBSTEP -> &&VALID -> PUBSTEP -> GDG(+1)

The temporary datasets make efficient intra-job handoff possible, but recovery must consider whether the data required by a restarted step still exists.

## Phase 1 — B36BASE: restart control-flow baseline
`B36BASE` contains three independent IEFBR14 steps.

Normal execution proved:

    STEP01 RC=0000
    STEP02 RC=0000
    STEP03 RC=0000

The JOB was then submitted with:

    RESTART=STEP02

Observed:

    STEP01 omitted
    STEP02 RC=0000
    STEP03 RC=0000

Therefore `RESTART=STEP02` establishes the execution starting point; it does not mean “execute only STEP02”.

## Phase 2 — B36TEMP: temporary dataset dependency
`STEP01` uses IEBGENER to create `&&RECOVER` with `DISP=(NEW,PASS)`. `STEP02` reads it with `DISP=(OLD,DELETE)` and writes it to SYSOUT.

Normal flow:

    STEP01
       |
       v
    &&RECOVER  -- PASSED -->
       |
       v
    STEP02
       |
       v
    SYSOUT
       |
       +--> &&RECOVER DELETED

Both steps completed RC=0000. SYSOUT proved that the record actually traversed the dependency:

    LAB36 TEMPORARY DATASET RECOVERY TEST

## Phase 3 — Controlled failure
The same job was then submitted with:

    RESTART=STEP02

STEP01 was skipped, so the temporary dataset was never created for that execution. STEP02 required it with `DISP=OLD`.

Observed JES messages:

    IEF212I B36TEMP STEP02 SYSUT1 - DATA SET NOT FOUND
    IEF272I B36TEMP STEP02 - STEP WAS NOT EXECUTED

The failure was intentional.

## Engineering conclusion
A usable restart point requires both:

1. **Control-flow validity** — JES can start execution at the requested step.
2. **Data validity** — every required input is still available or can be reconstructed under a defined recovery procedure.

`RESTART=` addresses the first condition. It does not reconstruct data produced by skipped steps.

> A step is a safe restart point only when its required input dependencies remain available or can be reconstructed in a controlled way.

Applied to the application pipeline, a theoretical `RESTART=PUBSTEP` is insufficient if the data PUBSTEP requires no longer exists.

## Scope boundary
Part 1 intentionally does not replace `&&RECOVER` with a permanent dataset and call the problem solved. Persistence creates further questions:

- Which execution owns the checkpoint?
- When is it deleted?
- What happens on a complete rerun?
- Can the same data be consumed twice?
- Can output be published twice?
- How do restart and rerun differ?
- How is the process made idempotent?

These belong to **Lab 36 — Part 2**.

## Part 2 — Deferred
Part 2 will create `B36PERS` and introduce a controlled persistent checkpoint.

    RESTART syntactically possible
              |
              v
       recovery impossible

will evolve into:

    RESTART
       +
    persistent checkpoint
       +
    lifecycle control
       +
    rerun/idempotency rules
              |
              v
    operational recovery

After validating that model, the conclusions will be applied to:

    SORTSTEP -> COBSTEP -> PUBSTEP

No additional GDG generations are created in Part 1.

## Result
**Lab 36 — Part 1 completed successfully.**

Validated: normal multi-step execution, `RESTART=stepname`, omission of earlier steps, continuation through later steps, `NEW/PASS`, `OLD/DELETE`, temporary dataset lifecycle, controlled `DATA SET NOT FOUND`, and the distinction between a logical restart point and an operationally recoverable restart point.

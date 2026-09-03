# Lab 36 — Part 2: Persistent Checkpoint, Restartability, Rerun and Idempotency

## Objective

Extend Lab 36 Part 1 from a failed restart dependency on job-scoped temporary data to a controlled recovery model based on persistent state.

The lab demonstrates, with z/OS/JES2 evidence, that:

- `RESTART=` only selects an execution entry point; it does not reconstruct skipped-step data.
- A cataloged checkpoint can remain available to a later submitted execution that starts at a downstream step.
- Restartability does not imply rerunability.
- Persistent state requires an explicit lifecycle policy.
- Cleanup can be made idempotent with a controlled IDCAMS return-code policy.
- Restartability and rerunability do not imply processing idempotency.
- A publication guard can prevent a second persistent effect when the output already exists.

## Scope and ownership

This is an integration/recovery lab in the master z/OS engineering repository.

It deliberately does **not** reimplement:
- GDG fundamentals already owned by the JCL labs.
- COBOL language fundamentals.
- RACF, SMF, WLM, Db2 or CICS integration.
- Additional generations of the Lab 35 GDG.

Lab 35 data is not modified. Lab 36 uses its own namespace:

- `IBMUSER.BATCH36.CHKPT`
- `IBMUSER.BATCH36.OUTPUT`

## Starting point from Part 1

Part 1 proved that a newly submitted execution with `RESTART=STEP02` cannot inherit the earlier job's `&&RECOVER` temporary dataset. The downstream step failed because its required input did not exist.

This Part 2 replaces that job-scoped dependency with a deliberately persistent checkpoint and then studies the new operational problems created by persistence.

> Precision: the evidence is based on submitted/resubmitted jobs using a restart entry point. It is not presented as proof of every JES checkpoint/restart retention scenario after an interrupted job.

## Experimental flow

### 1. Persistent checkpoint baseline — B36PERS

`STEP01` creates and catalogs `IBMUSER.BATCH36.CHKPT`.
`STEP02` reads it with `DISP=SHR`.

Observed:
- STEP01 CC=0000
- checkpoint CATALOGED
- STEP02 CC=0000
- checkpoint KEPT
- expected payload written to SYSOUT

### 2. Restart from STEP02

The same job was submitted with `RESTART=STEP02`.

Observed:
- STEP01 omitted
- STEP02 executed
- persistent checkpoint available
- STEP02 CC=0000

Result: persistent state made the downstream entry point operationally usable.

### 3. Full rerun with old checkpoint still present

`RESTART=STEP02` was removed and the job was submitted from STEP01 while `IBMUSER.BATCH36.CHKPT` still existed.

Observed:
- `DUPLICATE DATA SET NAME`
- STEP01 not executed
- job failed with JCL error

Result:

**Restartable != Rerunnable**

### 4. Explicit checkpoint lifecycle — B36CLEAN

A separate cleanup job owns deletion of the checkpoint.

First execution:
- checkpoint existed
- IDCAMS DELETE succeeded
- CC=0000

Second execution:
- checkpoint already absent
- IDCAMS returned MAXCC=8 for NOT FOUND
- policy `IF MAXCC = 8 THEN SET MAXCC = 0`
- final CC=0000

This proves an idempotent cleanup operation with respect to the desired state: checkpoint absent.

### 5. Controlled full rerun

After explicit cleanup, B36PERS was submitted from STEP01 again.

Observed:
- STEP01 CC=0000
- new checkpoint CATALOGED
- STEP02 CC=0000
- checkpoint KEPT

Result: a full rerun is possible when lifecycle state is explicitly reset.

### 6. Persistent output and double-processing risk — B36OUT

`B36OUT` consumes the persistent checkpoint and creates:

`IBMUSER.BATCH36.OUTPUT`

First execution:
- checkpoint KEPT
- output CATALOGED
- PROCESS CC=0000

Second identical execution without deleting output:
- `DUPLICATE DATA SET NAME`
- PROCESS not executed
- job failed with JCL error

Result:

**Restartable + Rerunnable != Idempotent processing**

### 7. Idempotent publication guard — B36IDEM

`CHECK` uses IDCAMS LISTCAT to determine whether the persistent output already exists.

If output exists:
- CHECK CC=0000
- conditional expression is false
- PROCESS is skipped
- existing output remains the single persistent effect

If output is absent:
- on this system LISTCAT returns CC=0004
- `CHECK.RC NE 0` is true
- PROCESS executes
- checkpoint is read
- output is cataloged
- PROCESS CC=0000

A final identical submission after output creation produced:
- CHECK CC=0000
- PROCESS skipped

Result: repeating the guarded publication does not create a second dataset effect.

## Operational model

```text
RESTART
  preserve checkpoint
        |
        v
  start downstream
        |
        v
  recovery succeeds

FULL RERUN
  explicit cleanup
        |
        v
  start from STEP01
        |
        v
  new checkpoint

IDEMPOTENT PUBLICATION
  check persistent effect
        |
   +----+----+
   |         |
 absent    present
   |         |
 process    skip
   |         |
   +----+----+
        |
        v
 one persistent output
```

## Key conclusions

1. A step is only a useful restart point when its required inputs remain available or can be reconstructed safely.
2. Persistence solves data availability for restart but introduces ownership and lifecycle state.
3. Cleanup and processing idempotency are separate concerns.
4. A job can be restartable while still being unsafe to rerun.
5. A job can be restartable and rerunnable while still being unsafe to repeat after a persistent business effect.
6. `DISP=MOD` would not solve this problem: silently appending repeated output could create duplicate business effects.
7. Automatically deleting persistent output before every restart would also be unsafe because it could destroy a previously successful effect.
8. The dataset-existence guard is a controlled teaching pattern, not a universal transactional idempotency mechanism. Db2, CICS, MQ, VSAM and other transactional workloads can require business keys, units of work, commit boundaries or execution identifiers.

## Final state

At lab close, preserve:

- `IBMUSER.BATCH36.CHKPT`
- `IBMUSER.BATCH36.OUTPUT`

They represent the validated final state and should not be deleted merely for repository publication.

## Members

- `B36PERS` — persistent checkpoint baseline / restart experiment
- `B36CLEAN` — explicit idempotent checkpoint cleanup
- `B36OUT` — deliberately non-idempotent persistent-output experiment
- `B36RESET` — explicit output reset for branch testing
- `B36IDEM` — guarded idempotent publication

## Result

**LAB 36 PART 2: COMPLETED**

Validated concepts:
- persistent checkpoint
- restartability
- rerun lifecycle
- idempotent cleanup
- persistent output
- duplicate-processing risk
- publication guard
- idempotent dataset publication

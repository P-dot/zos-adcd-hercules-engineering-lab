# Lab 35 — GDG Integration in the Batch Pipeline

## Status

**Completed and validated.**

This lab extends the batch-processing architecture built in Labs 31–34 by adding a persistent publication boundary based on a Generation Data Group (GDG). The purpose is **not to reteach GDG mechanics**. Those mechanics belong to the JCL learning track. Here, GDG is consumed as an already-understood z/OS facility and integrated into a working DFSORT + COBOL batch pipeline.

## Objective

Convert the Lab 34 processing flow from a pipeline that writes a fixed VALID output into one that separates **processing** from **publication**:

```text
IBMUSER.BATCH33.INPUT
          |
          v
       DFSORT
          |
          v
      &&SORTED
          |
          v
        BATMR
       /     \
      v       v
 &&VALID   BATCH35.REJECT
      |
      |  COBSTEP.RC <= 4
      v
   IEBGENER
      |
      v
IBMUSER.BATCH35.VALID.GDG(+1)
      |
      v
G0001V00
```

This gives the batch system a persistent, cataloged publication target while keeping intermediate processing datasets temporary.

## Relationship to Earlier Labs

This lab deliberately reuses capabilities already established elsewhere:

- **Lab 33** supplied the multi-record COBOL program `BATMR`, including VALID/REJECT routing and functional return codes.
- **Lab 34** supplied the validated `DFSORT -> &&SORTED -> BATMR` chained-step pattern.
- **JCL_LABS Lab 12** owns the learning scope for GDG fundamentals and future multi-generation/rollover exercises.
- **SMF Lab 22** already demonstrated GDG as an operational archive mechanism for SMF data.

Lab 35 therefore owns a different concern: **application batch publication using GDG**.

## Infrastructure Created

### GDG base

```text
IBMUSER.BATCH35.VALID.GDG
```

Policy:

```text
LIMIT(3)
NOEMPTY
SCRATCH
```

### Reject dataset

```text
IBMUSER.BATCH35.REJECT
```

Sequential dataset, `RECFM=FB`, `LRECL=80`.

## Processing and Publication Separation

The main architectural change is that `BATMR` no longer writes its accepted records directly to a permanent VALID dataset.

Instead:

```text
COBSTEP
   |
   v
&&VALID        <- temporary processing result
   |
   v
PUBSTEP
   |
   v
GDG(+1)        <- persistent published result
```

This separation matters because processing and publication can now be treated as distinct operational phases. That becomes the foundation for later restart, rerun and recovery design.

## Return-Code Policy

`BATMR` already implements a functional return-code contract:

| COBSTEP RC | Meaning | Publish? |
|---:|---|---|
| 0 | Processing completed with no rejects | Yes |
| 4 | Processing completed with rejected records | Yes |
| 8+ | Technical/error condition | No |

The JCL implements that policy with:

```jcl
//         IF (COBSTEP.RC LE 4) THEN
```

This is important: an RC=4 is not treated as a failed batch run. Valid records remain usable and are allowed to cross the publication boundary.

## Execution Result

The validated run produced:

```text
SORTSTEP   RC=0000
COBSTEP    RC=0004
PUBSTEP    RC=0000
```

DFSORT processed:

```text
IN  = 4
OUT = 4
```

`BATMR` reported:

```text
RECORDS READ      = 4
VALID RECORDS     = 3
REJECTED RECORDS  = 1
RC                 = 4
```

Despite the functional RC=4, the JCL condition permitted `PUBSTEP` to run. IEBGENER completed successfully and cataloged the first application output generation:

```text
IBMUSER.BATCH35.VALID.GDG.G0001V00
```

The catalog was then verified with IDCAMS `LISTCAT ALL`.

## Published Data Validation

Browsing `G0001V00` confirmed that the persistent generation contains exactly the three accepted records:

```text
VREGISTRO VALIDO 1
VREGISTRO VALIDO 2
VREGISTRO VALIDO 3
```

The rejected record did not enter the published GDG output and remained on the reject path.

## Temporary Dataset Lifecycle

Two temporary datasets are used intentionally:

```text
&&SORTED
&&VALID
```

`&&SORTED` exists only between DFSORT and COBOL processing. `&&VALID` exists only between COBOL processing and publication. JES2 evidence showed the temporary datasets being passed between the required steps and deleted when no longer needed.

Therefore the job leaves behind only the data that is meant to persist:

```text
BATCH35.REJECT
VALID.GDG.G0001V00
```

## What This Adds to the Batch System

Before Lab 35, the batch chain could prepare, process, validate and route records. Lab 35 adds a **persistent publication layer**.

The progression is now:

```text
Labs 31-34
execute -> control -> validate -> chain
                           |
                           v
Lab 35
process -> decide -> publish persistently
                           |
                           v
Future work
restart -> rerun -> recovery
```

This is the key engineering outcome of the lab. GDG is the mechanism; the architectural capability is **controlled publication of a validated batch result**.

## Scope Boundary

Only the first generation was created in this lab:

```text
G0001V00
```

Additional generations, relative-generation navigation, rollover behavior, `LIMIT`, `NOEMPTY`, `SCRATCH`, `ALTER`, and cleanup remain in the dedicated GDG work in `JCL_LABS`. They are intentionally not duplicated here.

When that work is completed, later master batch labs can consume the established multi-generation behavior for restart/rerun scenarios.

## Evidence

The `evidence/` directory contains the execution trail:

1. allocation of `IBMUSER.BATCH35.REJECT`;
2. complete `B35PIPE` JCL;
3. DFSORT processing of 4 input records;
4. BATMR result: 3 VALID, 1 REJECT, RC=4;
5. JES2 step execution and temporary-dataset lifecycle;
6. successful IEBGENER publication;
7. IDCAMS catalog verification;
8. ISPF display of the GDG base and `G0001V00`;
9. browse validation of the three published records.

## Final State

```text
                    z/OS Batch Pipeline
                           |
                     SORTSTEP RC=0
                           |
                       &&SORTED
                           |
                      COBSTEP RC=4
                      /          \
                 &&VALID       REJECT
                    |
              IF RC <= 4
                    |
                 PUBSTEP
                  RC=0
                    |
                IEBGENER
                    |
               GDG G0001V00
```

**Lab 35 completed successfully.**

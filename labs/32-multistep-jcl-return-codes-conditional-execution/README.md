# Lab 32 - Multi-step JCL, Return Codes and Conditional Execution

## Objective

Implement and prove a real z/OS batch control flow in which a COBOL program returns a condition code and JCL decides whether a downstream business-processing step is allowed to execute.

This lab extends the batch baseline by connecting program-level `RETURN-CODE` with JCL `STEP.RC` and `IF/THEN/ELSE/ENDIF`.

## Environment

- z/OS ADCD 1.11 on Hercules
- JES2
- Enterprise COBOL for z/OS 4.2
- TSO/ISPF and SDSF
- Existing `BATFILE` load module and sequential input/output datasets from Lab 31

## Flow

```text
STEP01 - BATRC
       |
       +-- RC = 0 --> STEP02 - BATFILE --> INPUT -> OUTPUT
       |
       +-- RC != 0 -> STEPERR - IEFBR14
```

## Components

- `src/BATRC.cbl` - COBOL control program.
- `jcl/BATRCOMP.jcl` - compile and link-edit job.
- `jcl/BATFLOW.jcl` - real conditional multi-step batch flow.
- `docs/validation.md` - observed evidence and acceptance criteria.
- `docs/troubleshooting.md` - problems and lessons learned.
- `evidence/screenshots/` - captured ISPF/SDSF evidence.

## What was demonstrated

### Positive path

`BATRC` returned `0000`. JES2 recorded `STEP01` with condition code 0000. The expression `IF (STEP01.RC = 0)` evaluated true, so `STEP02/BATFILE` executed. JES allocated `STEPLIB`, `INFILE`, `OUTFILE`, `SYSOUT` and `CEEDUMP`, and the step completed with CC 0000. `STEPERR` was not run.

### Negative path

`BATRC` was temporarily changed to return `0004` and recompiled. `STEP01` completed normally with CC 0004. The same unmodified `BATFLOW` evaluated the condition as false, did not execute `STEP02/BATFILE`, and executed `STEPERR` instead. The business step's input/output resources were therefore not allocated.

## Key lesson

A non-zero return code is not necessarily an abend. In this lab RC 4 was deliberately returned by a normally terminating COBOL program and used as application control information. JCL then made the execution decision.

## Result

Lab validated. Both branches of the same multi-step job were demonstrated with real JES2/SDSF evidence.

## Security

Publication material was checked for common private IPv4 and MAC-address patterns. No such patterns are intentionally included in the lab files.

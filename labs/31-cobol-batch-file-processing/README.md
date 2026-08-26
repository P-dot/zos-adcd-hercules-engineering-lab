# Lab 31 — COBOL Batch File Processing

## Objective
Build and validate an end-to-end z/OS batch flow in which a COBOL program reads a sequential input data set and writes the record to a sequential output data set under JES2.

## Environment
z/OS ADCD 1.11 on Hercules, JES2, SDSF, ISPF, Enterprise COBOL for z/OS 4.2, IBMUSER private libraries.

## Flow
`IBMUSER.BATCH.INPUT` → `INFILE` → `BATFILE` → `OUTFILE` → `IBMUSER.BATCH.OUTPUT`.

The test record is `DICIEMBRE`. Both sequential data sets use FB records with LRECL 80.

## Build
`BATFILE` is stored in `IBMUSER.COBOL.SRC`. Compilation and link-edit use `IGYWCL` with `LNGPRFX='IGY420'`, producing `IBMUSER.COBOL.LOAD(BATFILE)`.

## Execution
`BATFRUN` executes `PGM=BATFILE`. `STEPLIB` resolves the private load library, while `INFILE` and `OUTFILE` bind the COBOL SELECT/ASSIGN names to the physical z/OS data sets.

## Evidence and result
The lab deliberately preserves the diagnostic path: the default compiler prefix first produced a STEPLIB data-set-not-found condition, and an early fixed-format source produced COBOL RC=12. Both causes were identified and corrected.

Final validation:
- COBOL compile: RC=0000
- Link-edit: RC=0000
- BATFRUN RUN: COND CODE 0000
- Output verification: `IBMUSER.BATCH.OUTPUT` contains `DICIEMBRE`

This last check proves functional record movement, rather than relying only on a successful job return code.

## Repository contents
- `src/BATFILE.cbl` — COBOL source.
- `jcl/BATFCOMP.jcl` — compile/link JCL.
- `jcl/BATFRUN.jcl` — execution JCL.
- `docs/validation.md` — validation record.
- `docs/troubleshooting.md` — failures and resolutions.
- `commands/lab-commands.txt` — operational reference.
- `evidence/screenshots/` — supplied ISPF/SDSF evidence.

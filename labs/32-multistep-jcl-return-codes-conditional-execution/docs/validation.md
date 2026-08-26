# Validation

## Compile/link

`BATRCOMP` was used with the validated ADCD COBOL prefix `LNGPRFX='IGY420'`.

Expected and observed:
- COBOL compile return code: 0
- Binder/link-edit return code: 0
- Load module: `IBMUSER.COBOL.LOAD(BATRC)`

## Test A - RC 0 / THEN branch

Control program:
- `RETURN-CODE = 0`
- SYSOUT: `BATRC RETURN CODE = 0000`

Observed batch behavior:
- `STEP01` executed, CC 0000.
- `STEP02` executed, CC 0000.
- `STEPLIB`, `INFILE` and `OUTFILE` were allocated for `STEP02`.
- `STEPERR` was not run because of the conditional expression.

This proves the successful path from the COBOL return code through JCL conditional evaluation into real `BATFILE` processing.

## Test B - RC 4 / ELSE branch

The control program was temporarily changed to return 4 and display `BATRC RETURN CODE = 0004`, then recompiled.

Observed batch behavior:
- `STEP01` executed, CC 0004.
- `STEP02` was not run because of the conditional expression.
- `STEPERR` executed, CC 0000.
- The downstream `BATFILE` business step did not receive control.

## Acceptance

The same JCL selected different branches solely from `STEP01.RC`. Both positive and negative paths were captured in SDSF. The final source was restored to RC 0.

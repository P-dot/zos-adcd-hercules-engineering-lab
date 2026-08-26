# Validation

- Input data set: `IBMUSER.BATCH.INPUT`, PS, FB, LRECL 80.
- Test record: `DICIEMBRE`.
- Compiler PROC initially resolved `IGY.V4R2M0.SIGYCOMP`, which was unavailable.
- Correct compiler prefix: `LNGPRFX='IGY420'`.
- Initial COBOL source failed with RC=12 because fixed-format Area A/Area B placement was incorrect.
- Corrected source compiled with COBOL RC=0000.
- Link-edit completed with RC=0000 and produced `IBMUSER.COBOL.LOAD(BATFILE)`.
- `BATFRUN` allocated STEPLIB, INFILE, OUTFILE, SYSOUT and CEEDUMP.
- RUN step completed with COND CODE 0000.
- Functional verification: `IBMUSER.BATCH.OUTPUT` contains `DICIEMBRE`.

The final output proves actual end-to-end record processing, not only successful job termination.

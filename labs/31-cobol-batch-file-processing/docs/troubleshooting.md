# Troubleshooting evidence

## Compiler STEPLIB not found
`IGYWCL` defaulted to `IGY.V4R2M0.SIGYCOMP`. The environment's working Enterprise COBOL 4.2 libraries use prefix `IGY420`, so the compile invocation was corrected with `LNGPRFX='IGY420'`.

## COBOL RC=12
The first BATFILE source violated fixed-format Area A/Area B placement. The source was realigned and recompiled successfully.

These failures are retained as evidence because they show diagnosis of procedure expansion, compiler library resolution and COBOL fixed-format rules.

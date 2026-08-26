# Validation

## Build

`BATMRCMP` compiled and link-edited `BATMR` successfully.

Observed:
- COBOL: no statements flagged; return code 0.
- Binder: processing completed with return code 0.
- Entry point/load module: BATMR.

## Dataset geometry

The evidence shows INPUT, OUTPUT and REJECT as:
- Organization: PS
- Record format: FB
- Record length: 80
- Block size: 27920

This matches the three COBOL `PIC X(80)` records.

## Functional test

Corrected input:

```text
VREGISTRO VALIDO 1
VREGISTRO VALIDO 2
XREGISTRO INVALIDO
VREGISTRO VALIDO 3
```

Observed:

```text
RECORDS READ     = 00004
VALID RECORDS    = 00003
REJECTED RECORDS = 00001
```

OUTPUT contains the three V records. REJECT contains `XREGISTRO INVALIDO`.

## Final return-code test

After adding application return-code semantics, the same functional result was preserved and SYSOUT reported:

```text
BATCH COMPLETED WITH REJECTS - RC=0004
```

SDSF/JES recorded the RUN step with condition code 0004.

This proves that the program completed normally, produced the correct output/reject files, and deliberately communicated the presence of rejected data through RC 4.

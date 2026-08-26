# Troubleshooting

## Initial result: 4 valid / 0 rejected

The first functional execution returned:

```text
RECORDS READ     = 00004
VALID RECORDS    = 00004
REJECTED RECORDS = 00000
```

The JCL, OPEN processing and COBOL comparison were not the cause. Inspection of the test data showed that the intended invalid record had been entered with a leading `V`, so it satisfied:

```cobol
IF INPUT-RECORD(1:1) = 'V'
```

The test data was corrected to:

```text
XREGISTRO INVALIDO
```

No COBOL or JCL change was needed for that correction.

## Why this matters

A technically successful job (`CC=0`) does not prove that a functional test case was designed correctly. Input data must be checked against the exact business rule being tested.

## RC 4 is intentional

The final RC 4 does not indicate an abend. The program completed processing, closed its files, displayed its counters and deliberately set `RETURN-CODE` to 4 because `WS-REJECT-COUNT > 0`.

## RC 8

The program checks the `FILE STATUS` values after OPEN. A non-`00` status for INPUT, OUTPUT or REJECT causes a diagnostic message and RC 8.

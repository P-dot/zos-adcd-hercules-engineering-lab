# Lab 33 - COBOL Multi-record Validation, Counters and Reject Processing

## Objective

Build a COBOL batch program that reads multiple fixed-length sequential records, applies a record-level validation rule, separates accepted and rejected data into different datasets, counts the processing results, and communicates the functional outcome to JES through `RETURN-CODE`.

## Environment

- z/OS ADCD 1.11 on Hercules
- JES2 / SDSF
- Enterprise COBOL for z/OS 4.2
- TSO/ISPF
- PS datasets using FB / LRECL 80

## Processing model

```text
IBMUSER.BATCH33.INPUT
          |
          v
        BATMR
          |
   INPUT-RECORD(1:1)
       /       \
     'V'       other
      |          |
      v          v
   OUTPUT      REJECT
```

Test data:

```text
VREGISTRO VALIDO 1
VREGISTRO VALIDO 2
XREGISTRO INVALIDO
VREGISTRO VALIDO 3
```

Expected functional result:

- Records read: 4
- Valid records: 3
- Rejected records: 1

## Return-code policy

- `RC=0`: processing completed with no rejected records.
- `RC=4`: processing completed normally but at least one record was rejected.
- `RC=8`: file open error detected through COBOL `FILE STATUS`.

A return code of 4 is therefore an application-level warning/condition, not an abend.

## Datasets

- `IBMUSER.BATCH33.INPUT`
- `IBMUSER.BATCH33.OUTPUT`
- `IBMUSER.BATCH33.REJECT`

All three were validated as sequential PS datasets with FB records and LRECL 80.

## Final result

The final run processed four records, wrote three valid records to OUTPUT and one invalid record to REJECT, and returned CC 0004 because rejected data existed.

This lab connects record-level COBOL validation with the return-code concepts demonstrated in Lab 32.

## Evidence

The `evidence/screenshots` directory contains the supplied ISPF/SDSF evidence covering source, compile/link, dataset attributes, test data, the initial data-test issue, corrected processing, and the final RC=4 execution.

## Security

Before publication, run the supplied security check to detect common private IPv4 and MAC-address patterns.

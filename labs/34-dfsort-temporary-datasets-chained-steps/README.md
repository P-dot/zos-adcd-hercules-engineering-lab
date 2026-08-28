# Lab 34 - DFSORT, Temporary Datasets and Chained Steps

## Objective
Build a multi-step z/OS batch pipeline in which one step produces a temporary sequential dataset and a later step consumes it.

## Phase 1
`IBMUSER.BATCH33.INPUT -> DFSORT -> &&SORTOUT -> IEBGENER -> IBMUSER.BATCH34.OUTPUT`

Validated:
- SORTSTEP CC=0000
- COPYSTEP CC=0000
- DFSORT: 4 records IN, 4 OUT
- temporary dataset PASSED and later DELETED
- permanent OUTPUT KEPT
- sorted output physically verified

## Phase 2
`IBMUSER.BATCH33.INPUT -> DFSORT -> &&SORTED -> BATMR -> VALID / REJECT`

Validated:
- DFSORT: 4 IN, 4 OUT
- BATMR READ=4, VALID=3, REJECTED=1
- `BATCH COMPLETED WITH REJECTS - RC=0004`
- VALID physically contains the three V records
- REJECT physically contains `XREGISTRO INVALIDO`
- MAXCC=4 is intentional application semantics, not an abend

## Concepts demonstrated
DFSORT, `&&` temporary datasets, `DISP=(NEW,PASS)`, inter-step passing, temporary cleanup, IEBGENER, chained steps, DFSORT-to-COBOL integration and application return-code propagation.

## Evidence
See `evidence/screenshots/`.

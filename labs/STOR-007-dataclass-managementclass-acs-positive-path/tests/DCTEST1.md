# DCTEST1 — Positive Data Class ACS Routing Test

## Purpose

Prove that the Data Class ACS routine assigns `SMSDATA` to a dataset name in the controlled `IBMUSER.SMSLAB.*` namespace.

## Test definition

```text
ACS Test Library = IBMUSER.HARDEN.CNTL
ACS Test Member  = DCTEST1
Description      = Positive DATACLAS routing test
DSN              = IBMUSER.SMSLAB.TESTDC
```

No `DATACLAS` input is supplied. `SMSDATA` must be produced by the ACS routine as an output.

## Routine isolation

```text
DC = Y
SC = N
MC = N
SG = N
```

## Expected decision

```text
&DSN(1) = IBMUSER
&DSN(2) = SMSLAB
DATACLAS = SMSDATA
```

## Observed result

```text
DCTEST1    EXIT CODE 0    DC = SMSDATA
ACS TESTING RC: 00
```

## Result

**PASS**

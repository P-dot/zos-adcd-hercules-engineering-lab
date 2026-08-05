# Troubleshooting — LAB18B

## Repeated IEE362A messages

Symptom:

```text
IEE362A SMF ENTER DUMP FOR SYS1.MANx
```

Meaning:

SMF has filled or marked a MAN data set as requiring dump/clear. If this happens repeatedly across all MAN data sets, SMF can run out of clean recording targets.

## Emergency condition

Symptom:

```text
IEE360I NO SMF DATA SETS AVAILABLE - DATA BEING BUFFERED
```

Meaning:

SMF has no clean MAN data set available and is buffering records. This is an operational priority.

Immediate recovery:

```text
SUBMIT IBMUSER.HARDEN.CNTL(SMFDMP)
/D SMF
/D R,L
```

## Duplicate output data set in SMFDMP

Earlier LAB18 finding:

```text
DUPLICATE DATA SET NAME ON VOLUME ZVOL00
```

Cause:

The SMF dump job attempted to write to an already existing output data set.

Correction:

Use a new output name or add IDCAMS cleanup before allocation.

## Define failures

If `DEFMANB` fails because MAN4/MAN5/MAN6 already exist, verify whether they are the expected lab data sets before deleting. Do not delete unknown system data sets.

## Activation failure after SET SMF=B8

Use rollback:

```text
/SET SMF=00
/D SMF
/D R,L
```

Do not delete `SYS1.MAN4/5/6` immediately. Keep them for diagnosis and retry.

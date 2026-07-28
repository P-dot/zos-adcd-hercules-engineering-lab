# Troubleshooting notes

## 1. JCL continuation errors

Symptoms:

```text
IEF621I EXPECTED CONTINUATION NOT RECEIVED
IEF605I UNIDENTIFIED OPERATION FIELD
```

Meaning: the converter did not treat the following record as continuation of the DD statement.

Resolution used in this lab: avoid fragile long DD continuation and allocate the dataset using `IKJEFT01` with TSO `ALLOCATE` commands in `SYSTSIN`.

## 2. Space request not available

Symptom:

```text
IEF257I ... SPACE REQUESTED NOT AVAILABLE
```

Meaning: the requested primary DASD space could not be allocated with the specified constraints.

In this lab, earlier tests using large contiguous requests were not the final path. The successful evidence came from `IKJEFT01` allocation of `SYS1.HASPACE` on `SBSYS9`.

## 3. Duplicate dataset name on volume

Symptom:

```text
DUPLICATE NAME ON DIRECT ACCESS VOLUME
DUPLICATE DATA SET NAME FOUND ON VOLUME SBSYS9
FOR DATA SET SYS1.HASPACE
```

Meaning: `SYS1.HASPACE` already exists on `SBSYS9`.

Correct action: stop submitting allocation JCL and proceed to:

```text
/$S SPOOL(SBSYS9)
```

## 4. LOGREC full is separate

During the lab, the console also showed:

```text
IFB081I LOGREC DATA SET IS FULL
DSN=SYS1.LOGREC
```

This is a separate system-maintenance issue. It is not a failure of JES2 SPOOL expansion.

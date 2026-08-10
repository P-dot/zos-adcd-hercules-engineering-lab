# Console and TSO Commands Used

## Runtime discovery

```text
D IPLINFO
D SSI
D PROG,LNKLST
D PARMLIB
```

## Catalog validation

```text
LISTCAT LEVEL(RMM) ALL
LISTCAT ENT('RMM.CONTROL.DATASET') ALL
LISTCAT ENT('RMM.ADCD.EDGPDOX') ALL
LISTCAT ENT('RMM.ADCD.EDGPDOY') ALL
```

## DFSMSrmm startup

```text
S DFRMM
```

## Important note

The following command was tested but is **not valid** as a DFSMSrmm MODIFY operand:

```text
F DFRMM,D
```

It returned:

```text
EDG1102E INCORRECT DFSMSrmm COMMAND OPERAND - D
```

This was a command-syntax error after successful initialization, not a DFSMSrmm startup failure.

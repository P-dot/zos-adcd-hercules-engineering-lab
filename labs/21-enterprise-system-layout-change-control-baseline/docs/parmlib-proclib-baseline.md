# PARMLIB and PROCLIB Baseline

## PARMLIB

PARMLIB datasets observed:

```text
USER.PARMLIB
ADCD.Z111S.PARMLIB
SYS1.PARMLIB
```

Interpretation:

```text
USER.PARMLIB         local/custom layer
ADCD.Z111S.PARMLIB  ADCD layer
SYS1.PARMLIB        system layer
```

## PROCLIB

PROCLIB datasets observed include:

```text
ADCD.Z111S.PROCLIB
SYS1.PROCLIB
USER.PROCLIB
IBMUSER.JCL.PROCLIB
IBMUSER.NETSEC.PROCLIB.BKUP
```

## Enterprise rule

No future system-level change should be made without identifying:

```text
member changed
library changed
backup member/name
reason for change
validation command
rollback command
```

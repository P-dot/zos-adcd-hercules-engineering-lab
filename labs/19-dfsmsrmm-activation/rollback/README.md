# Rollback / Recovery Notes

This lab changed system configuration and created persistent RMM data sets.

A rollback should be performed only when DFSMSrmm is stopped and the operator understands the dependency chain.

## Configuration rollback

1. Stop DFSMSrmm using the IBM-supported shutdown procedure for the installed release.
2. Remove or comment the local DFRM definition from `ADCD.Z111S.PARMLIB(IEFSSNDB)` only if DFSMSrmm is intentionally being deactivated.
3. An IPL is required for a PARMLIB-based SSI rollback to take effect.
4. Preserve the local `DFRMM` procedure and `EDGRMM00` until the rollback has been validated.

## Data-set caution

Do **not** delete these data sets as a casual cleanup step:

```text
RMM.CONTROL.DATASET
RMM.JOURNAL.DATASET
RMM.ADCD.EDGPDOX
RMM.ADCD.EDGPDOY
```

The control data set and journal are part of DFSMSrmm state and recovery infrastructure.

The screenshots in `evidence/` provide the before/after trail needed to reconstruct the implementation if required.

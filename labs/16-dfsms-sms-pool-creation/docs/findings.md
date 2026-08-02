# Findings

## DASD and Hercules

The initial devices appeared as `F-NRD`. After creating and attaching the CCKD files, z/OS displayed `SMS000`, `SMS001`, and `SMS002`.

The original `SMS001.CCKD` had a permission problem, so `SMS001B.CCKD` was created with internal VOLSER `SMS001`.

## ICKDSF

`INISMS` completed with `COND CODE 0000`, and VTOC/index creation succeeded.

## Persistence

`hercules.cnf` was updated with the three SMS devices.

## ISMF / SMS

`SMSPOOL` was defined in `SYS1.SCDS`.

ISMF showed:

- `SMSPOOL SAVED`
- `ALL VOLUMES DEFINED`
- `SMS000`, `SMS001`, and `SMS002` enabled for `ADCD`

## Boundary

The SCDS was updated, but no global SMS configuration activation or ACS rule activation was performed.

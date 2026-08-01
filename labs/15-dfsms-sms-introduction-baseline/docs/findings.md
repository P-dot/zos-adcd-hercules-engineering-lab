# Findings

## 1. SMS is available

`D SMS` returned a valid SMS display.

## 2. SMS control datasets identified

- `SCDS = SYS1.SCDS`
- `ACDS = SYS1.ACDS`
- `COMMDS = SYS1.COMMDS`

## 3. Existing storage groups

- `DBCLASS`
- `HFSCLASS`

## 4. Lab DASD volumes are not SMS-managed

The following volumes were checked and reported as not SMS-managed DASD volumes:

- `SBRES1`
- `SBSYS1`
- `SBSYS9`
- `ZVOL00`
- `ZVOL01`

## 5. ISMF Storage Administration is available

The ISMF menu shows the expected DFSMS administration areas: Data Set, Volume, Management Class, Data Class, Storage Class, Storage Group, ACS, Control Data Set and RMM.

## 6. No changes made

This was a baseline-only lab. No SCDS, ACDS, ACS routine, storage group or volume assignment was modified.

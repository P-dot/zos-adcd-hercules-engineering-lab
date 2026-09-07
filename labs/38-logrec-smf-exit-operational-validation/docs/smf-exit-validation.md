# SMF Exit Operational Validation

The lab distinguishes three different observations that should not be merged:

1. `SMFPRM00` is the static PARMLIB configuration inspected in read-only mode.
2. `D SMF,O` reports effective SMF options and showed exit-related parameters
   as originating from PARMLIB.
3. `D PROG,EXIT` reports the Dynamic Exits Facility inventory.

Selected SMF exits such as `IEFU83` and `IEFU84` were then queried explicitly
with `D PROG,EXIT,EXITNAME=...`.

The result is intentionally documented without forcing a configuration change:
an exit being configured/effective for SMF does not, by itself, establish that
it is registered through the Dynamic Exits Facility. No `SETPROG` operation
was required to prove this distinction.

This is an operational validation lab, not an exit-installation lab.

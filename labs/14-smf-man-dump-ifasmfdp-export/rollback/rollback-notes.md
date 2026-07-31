# Rollback / Recovery Notes

This lab does not require rollback because it performs a standard SMF dump/export and clears the MAN datasets using `IFASMFDP`.

If the output dataset already exists, rerun using another generation-like name, for example:

- `IBMUSER.SMF.LAB14.RUN02`
- `IBMUSER.SMF.LAB14.RUN03`

If SMF MAN messages reappear later, repeat the `IFASMFDP` procedure.

Do not delete or redefine `SYS1.MAN*` as a rollback action for this lab.

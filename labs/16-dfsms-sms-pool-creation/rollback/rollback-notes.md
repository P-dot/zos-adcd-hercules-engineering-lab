# Rollback Notes

## Hercules rollback

Restore the configuration backup if needed:

```powershell
Copy-Item F:\ZOS111\hercules.cnf.BEFORE_SMSPOOL F:\ZOS111\hercules.cnf -Force
```

For the active Hercules session:

```text
detach 0A9E
detach 0A9F
detach 0AA0
```

## SMS rollback

This lab only changed `SYS1.SCDS`; no activation was performed.

To rollback inside ISMF:

1. Enter ISMF.
2. Use Storage Group with `CDS Name = SYS1.SCDS`.
3. Select `SMSPOOL`.
4. Remove volumes or delete the `SMSPOOL` definition.

Do not run `SETSMS` or ACS activation as rollback for this lab.

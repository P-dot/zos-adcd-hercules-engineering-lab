# Rollback notes

Rollback is only needed if SMF activation causes an operational issue.

## Manual rollback

Edit:

```text
ADCD.Z111S.PARMLIB(SMFPRM00)
```

Change:

```text
ACTIVE
```

back to:

```text
NOACTIVE
```

Then apply from MASTER CONSOLE L700:

```text
SET SMF=00
D SMF
```

## Backup available

A backup member was created:

```text
IBMUSER.HARDEN.BACKUP(SMFBK00)
```

Original source:

```text
ADCD.Z111S.PARMLIB(SMFPRM00)
```

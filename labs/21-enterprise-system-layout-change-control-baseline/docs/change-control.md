# Change-Control Baseline

## Change-control posture for this lab

```text
Mode:              read-only
Destructive work:  no
RACF changes:      no
PARMLIB changes:   no
PROCLIB changes:   no
Catalog changes:   no
SMF changes:       no
```

## Enterprise change template for future labs

| Field | Required value |
|---|---|
| Change ID | Lab number and short title |
| Component | RACF, SMF, SDSF, JES2, DFSMS, z/OS UNIX, CICS, DB2, etc. |
| Object changed | Dataset/member/profile/command |
| Backup | Member/dataset/export before change |
| Command used | Exact command or JCL |
| Validation | Display command, SDSF output, return code, message ID |
| Rollback | Exact rollback command/procedure |
| Evidence | Screenshot/file path |

## Current pending change candidate

```text
SMF MAN4 on ZVOL00 requires dump.
```

This should be handled in a separate SMF lab with IFASMFDP and documented rollback/validation.

# Privileged Identity Matrix

| Identity | Type | SPECIAL | OPERATIONS | PROTECTED | Group authority > USE | STARTED context | Assessment |
|---|---|---:|---:|---:|---|---|---|
| IBMUSER | Interactive administrator | YES | YES | No observed | JOIN: SYSCTLG, SYS1, VSAMDSET | Not primary STC identity | High |
| ADCDMST | ADCD administrator | YES | YES | No observed | None detected | Not established | High / contextual |
| SYSOPR | Operations/admin | YES | NO | No observed | None detected | Not established | Medium-High |
| START1 | Technical service ID | NO | YES | YES | None detected | Multiple profiles, several TRUSTED=YES | High / technically contextualized |
| DB8GRFSH | DB2 technical ID | NO | YES | No observed | USE | Not established | Review |
| DB9GENV5 | DB2 technical ID | NO | YES | No observed | USE | Not established | Review |
| DB9GRFSH | DB2 technical ID | NO | YES | No observed | USE | Not established | Review |

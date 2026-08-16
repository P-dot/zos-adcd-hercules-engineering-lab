# Privileged Access Governance Register

| Identity | Authority | Context | Decision | Priority |
|---|---|---|---|---|
| IBMUSER | SPECIAL + OPERATIONS + JOIN x3 | Interactive administrative identity | ADMINISTRATIVE EXCEPTION | P2 |
| START1 | OPERATIONS + PROTECTED | Shared technical service identity / STARTED context | TECHNICAL EXCEPTION / ACCEPTED WITH REVIEW | P3 |
| ADCDMST | SPECIAL + OPERATIONS | ADCD administrative identity | ENVIRONMENT EXCEPTION / REVIEW | P3 |
| SYSOPR | SPECIAL | Administrative/legacy candidate; justification not established | REVIEW | P1 |
| DB8GRFSH | OPERATIONS | DB2 technical identity | REVIEW | P2 |
| DB9GENV5 | OPERATIONS | DB2 technical identity | REVIEW | P2 |
| DB9GRFSH | OPERATIONS | DB2 technical identity | REVIEW | P2 |

`REVIEW` means evidence is insufficient either to approve permanent exception status or to remove the privilege safely.

# Security Findings

## F-01 — IBMUSER privilege concentration — HIGH

SPECIAL + OPERATIONS + LOGON ALLOWED + JOIN authority to three groups.

## F-02 — START1 shared privileged technical identity — HIGH / CONTEXTUALIZED

START1 is PROTECTED, has OPERATIONS and is used by multiple STARTED
profiles. Several STDATA definitions use TRUSTED=YES.

## F-03 — DB2 technical identities with OPERATIONS — REVIEW REQUIRED

DB8GRFSH, DB9GENV5 and DB9GRFSH require subsystem dependency analysis
before privilege reduction.

## F-04 — SYSOPR with SPECIAL — MEDIUM-HIGH

Administrative role and segregation should be reviewed.

## F-05 — No extraordinary group attributes in UGRP — POSITIVE CONTROL RESULT

No group-SPECIAL, group-OPERATIONS or group-AUDITOR were identified.

## F-06 — IBMUSER JOIN authority — HIGH-INTEREST

CONN identified JOIN authority to SYSCTLG, SYS1 and VSAMDSET.

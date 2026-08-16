# Lab 24 — RACF Privileged Access Governance & Exception Review

**Status:** COMPLETED  
**Mode:** Read-only governance assessment  
**Platform:** IBM z/OS ADCD under Hercules

## Objective
Convert Lab 23 privileged-identity findings into governance decisions: classify identities, distinguish administrative from technical accounts, document justified exceptions, identify review candidates, and create a remediation backlog.

## Direct Lab 24 investigation — SYSOPR
`LISTUSER SYSOPR` showed:
- OWNER=IBMUSER
- DEFAULT-GROUP=SYS1
- SPECIAL
- LOGON ALLOWED
- LAST-ACCESS=10.191/16:40:46
- SYS1 AUTH=USE
- CONNECTS=00
- LAST-CONNECT=UNKNOWN

Targeted check:
`RLIST STARTED SYSOPR.* STDATA`

Result:
`SYSOPR.* NOT FOUND`

This does not prove SYSOPR is unused everywhere; it establishes that no directly named SYSOPR.* STARTED profile was found.

**Decision: REVIEW (P1).**

## Governance outcomes
- IBMUSER — ADMINISTRATIVE EXCEPTION
- START1 — TECHNICAL EXCEPTION / ACCEPTED WITH REVIEW
- ADCDMST — ENVIRONMENT EXCEPTION / REVIEW
- SYSOPR — REVIEW
- DB8GRFSH — REVIEW
- DB9GENV5 — REVIEW
- DB9GRFSH — REVIEW

No identity was classified REMEDIATE because the evidence did not establish that an elevated privilege could safely be removed.

## Relationship to Lab 23
Lab 23 answered **who has elevated authority** using UGLB, UGRP, CONN, LISTUSER and STARTED/STDATA.

Lab 24 answers **why the authority exists, what context supports it, and what governance action follows**.

## Final status
Lab 24 is complete. No RACF authority was changed.

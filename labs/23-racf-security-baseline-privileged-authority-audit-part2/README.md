# Lab 23 — RACF Security Baseline & Privileged Authority Audit — Part 2

**Status:** COMPLETED — PART 2  
**Mode:** Read-only privileged-access assessment  
**Platform:** IBM z/OS ADCD under Hercules

## Objective

Continue the RACF privileged-access assessment established in Part 1
and correlate global authority, group authority and started-task
identity assignments before proposing any hardening.

Part 2 focuses on:

- RACFICE CONN reporting
- group connection authority above USE
- individual LISTUSER validation
- privileged identity classification
- STARTED class / STDATA correlation
- service-ID analysis
- privileged identity matrix
- security findings
- remediation recommendations

No RACF authority was removed or changed.

---

## 1. Starting point from Part 1

Part 1 established the following reporting capability:

    RACF database
          |
          v
      IRRDBU00
          |
          v
    IBMUSER.RACF.UNLOAD
          |
          v
      IBM RACFICE
          |
       UGLB / UGRP

UGLB identified:

    SPECIAL      : 3
    OPERATIONS   : 6
    AUDITOR      : 0

Part 2 continues from this validated baseline.

---

## 2. RACFICE CONN report

The RACFICE CONN report was executed against the existing RACF unload.

Purpose:

Identify user-to-group connections whose authority is above ordinary
USE authority.

Final report:

    CONN: User IDs with Group Privileges Above Use

Observed result:

    IBMUSER  SYSCTLG   JOIN
    IBMUSER  SYS1      JOIN
    IBMUSER  VSAMDSET  JOIN

This shows that IBMUSER has three group connections with JOIN authority.

The report complements UGLB:

    UGLB -> extraordinary global attributes
    CONN -> group connection authority above USE

---

## 3. IBMUSER detailed validation

LISTUSER IBMUSER confirmed:

    ATTRIBUTES = SPECIAL OPERATIONS
    LOGON       = ALLOWED

Group connections include:

    SYSCTLG   AUTH=JOIN
    VSAMDSET  AUTH=JOIN
    SYS1      AUTH=JOIN

The SYS1 connection also showed active usage history.

Security interpretation:

IBMUSER combines:

    SPECIAL
    OPERATIONS
    interactive logon capability
    JOIN authority on three groups

This represents the highest concentration of administrative authority
identified during the assessment.

No privilege removal was performed.

---

## 4. Other privileged identities

LISTUSER inspection was performed for the privileged identities
identified by UGLB.

### ADCDMST

Observed:

    SPECIAL
    OPERATIONS

Interpretation:

Administrative ADCD identity with high global authority.

### SYSOPR

Observed:

    SPECIAL

Interpretation:

Operational / administrative identity requiring role and segregation
review.

### DB8GRFSH

Observed:

    OPERATIONS

### DB9GENV5

Observed:

    OPERATIONS

### DB9GRFSH

Observed:

    OPERATIONS

Interpretation for the DB2-related identities:

These are technical identities. Their OPERATIONS authority must be
reviewed against subsystem dependencies before any hardening.

### START1

Observed:

    OPERATIONS
    PROTECTED

Interpretation:

START1 behaves as a technical service identity rather than an ordinary
interactive human account.

---

## 5. STARTED class / STDATA correlation

The following read-only RACF query was executed:

    RLIST STARTED * STDATA

Purpose:

Identify the RACF identities assigned to started procedures and inspect
their STDATA attributes:

    USER
    GROUP
    TRUSTED
    PRIVILEGED
    TRACE

The evidence shows multiple STARTED profiles mapped to technical user
IDs.

A recurring pattern was identified:

    USER=START1
    GROUP=SYS1
    TRUSTED=YES
    PRIVILEGED=NO
    TRACE=NO

START1 is therefore not an orphan privileged account. It is actively
used as a technical identity for multiple started-task profiles.

Examples visible in the assessment evidence include system components
such as JES2 and several other z/OS infrastructure profiles.

Other STARTED profiles use dedicated service IDs instead of START1,
demonstrating both shared-service-ID and service-specific identity
models in the same environment.

---

## 6. Important distinction: OPERATIONS vs STDATA TRUSTED

These authorities must not be confused.

START1 user profile:

    OPERATIONS
    PROTECTED

STARTED profile STDATA:

    TRUSTED=YES
    PRIVILEGED=NO

They are separate security mechanisms.

Therefore a task can run with:

    STDATA TRUSTED=YES

while its associated user ID independently possesses:

    OPERATIONS

This creates layered authority and is important when evaluating
effective privilege.

---

## 7. Privileged identity matrix

| Identity | Type | SPECIAL | OPERATIONS | PROTECTED | Group auth > USE | STARTED / STDATA context | Assessment |
|---|---|---:|---:|---:|---|---|---|
| IBMUSER | Interactive administrator | YES | YES | NO observed | JOIN x3 | Not primary STC identity | High concentration |
| ADCDMST | ADCD administrator | YES | YES | NO observed | None detected | No direct STC evidence in this phase | High / environment-specific |
| SYSOPR | Operations/admin | YES | NO | NO observed | None detected | No direct STC evidence in this phase | Medium-High |
| START1 | Technical service ID | NO | YES | YES | None detected | Multiple STARTED profiles; several TRUSTED=YES | High but technically contextualized |
| DB8GRFSH | DB2 technical ID | NO | YES | NO observed | USE | No direct STC evidence established | Review required |
| DB9GENV5 | DB2 technical ID | NO | YES | NO observed | USE | No direct STC evidence established | Review required |
| DB9GRFSH | DB2 technical ID | NO | YES | NO observed | USE | No direct STC evidence established | Review required |

---

## 8. Security findings

### F-01 — IBMUSER privilege concentration

IBMUSER combines:

    SPECIAL
    OPERATIONS
    LOGON ALLOWED
    JOIN -> SYSCTLG
    JOIN -> SYS1
    JOIN -> VSAMDSET

Risk classification:

    HIGH

Reason:

Multiple high-authority mechanisms converge on one interactive
administrative identity.

Recommendation:

Review role separation and necessity of each authority before any
controlled remediation.

---

### F-02 — START1 shared privileged technical identity

START1 has:

    OPERATIONS
    PROTECTED

and is associated with multiple STARTED profiles.

Several profiles show:

    USER=START1
    GROUP=SYS1
    TRUSTED=YES

Risk classification:

    HIGH / TECHNICALLY CONTEXTUALIZED

This is not evidence that START1 is misconfigured. It demonstrates
privilege concentration in a shared technical identity.

Any change requires dependency analysis, controlled testing and
rollback.

---

### F-03 — DB2 technical identities with OPERATIONS

Observed:

    DB8GRFSH
    DB9GENV5
    DB9GRFSH

Risk classification:

    REVIEW REQUIRED

No privilege should be removed without validating DB2 operational
dependencies.

---

### F-04 — SYSOPR with SPECIAL

SYSOPR possesses SPECIAL but not OPERATIONS.

Risk classification:

    MEDIUM-HIGH

Recommendation:

Review administrative role boundaries and whether SPECIAL is necessary
for the intended operator function.

---

### F-05 — No extraordinary group attributes detected by UGRP

UGRP result from the established baseline:

    GROUP-SPECIAL      : 0
    GROUP-OPERATIONS   : 0
    GROUP-AUDITOR      : 0

This is a positive control result but does not eliminate other forms of
group privilege such as JOIN.

---

### F-06 — IBMUSER group authority above USE

CONN identified exactly three connections above USE:

    SYSCTLG   JOIN
    SYS1      JOIN
    VSAMDSET  JOIN

This finding is independently confirmed by LISTUSER IBMUSER.

---

## 9. Methodology

Part 2 used correlation rather than isolated commands:

    UGLB
      |
      v
    privileged global identities
      |
      +------ CONN
      |         |
      |         v
      |     group authority > USE
      |
      +------ LISTUSER
      |         |
      |         v
      |     individual profile validation
      |
      +------ STARTED / STDATA
                |
                v
          service-ID context
                |
                v
       privileged identity matrix
                |
                v
       findings + recommendations

---

## 10. Change-control decision

Part 2 intentionally remains read-only.

No:

    ALTUSER
    RALTER
    CONNECT changes
    REMOVE
    PERMIT changes

were performed.

Reason:

The assessment uncovered technical dependencies, particularly around
START1 and subsystem-related service identities.

Hardening should be implemented as a separate controlled lab with:

    before evidence
    explicit change
    impact validation
    rollback
    after evidence

---

## 11. Completion criteria

- [x] RACFICE CONN executed
- [x] group authority above USE identified
- [x] IBMUSER JOIN authority independently confirmed
- [x] privileged users individually reviewed
- [x] technical identities classified
- [x] START1 PROTECTED status correlated
- [x] STARTED class queried
- [x] STDATA assignments reviewed
- [x] TRUSTED / PRIVILEGED distinction documented
- [x] privileged identity matrix completed
- [x] security findings completed
- [x] remediation recommendations documented
- [x] no destructive RACF changes performed

---

## Final status

**LAB 23 PART 2 — COMPLETED**

Part 2 converts the Part 1 privilege inventory into an operationally
contextualized privileged-access assessment.

The resulting baseline is suitable for a future controlled RACF
least-privilege / remediation lab.

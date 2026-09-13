# Architecture V2 — Production Tracks

## Purpose

This document defines how Architecture V2 converts validated domain capabilities into cross-domain, production-like engineering workflows.

Production Tracks do not replace specialized repositories.

They consume capabilities from specialized repositories and prove that those capabilities can operate together as a coherent z/OS system.

The purpose is to move from:

```text
isolated capability validation
```

toward:

```text
integrated operational engineering
```

---

# 1. Architectural principle

Architecture V2 uses the following rule:

**Domain repositories validate capabilities. Production Tracks prove that those capabilities work together. Core Platform provides the common z/OS environment in which the tracks execute.**

A Production Track therefore:

- references existing domain capabilities;
- adds dependencies and execution order;
- introduces operational context;
- adds observability;
- validates failure and recovery;
- documents security relationships;
- produces cross-domain evidence.

A Production Track should avoid duplicating full standalone labs.

---

# 2. Production Track characteristics

A mature Production Track should define:

- operational objective
- participating domains
- participating repositories
- participating z/OS components
- prerequisites
- execution sequence
- expected state transitions
- evidence sources
- failure scenario
- diagnosis path
- recovery path
- security implications
- completion criteria
- future automation opportunities

Not every early track needs all of these on day one.

The track can mature progressively.

---

# 3. Track maturity

Production Tracks can evolve through four stages.

## T0 — Conceptual

The integration path is documented but not yet executed end to end.

## T1 — Connected

Multiple domain capabilities are executed in one sequence.

## T2 — Operational

The track includes runtime monitoring, result interpretation, and operational control.

## T3 — Resilient

The track includes controlled failure, diagnosis, recovery, and post-recovery validation.

## T4 — Automated

The track includes controlled orchestration and repeatable evidence collection.

## T5 — Production-like

The track demonstrates a complete operational workflow across multiple domains with:

- dependencies
- security
- observability
- controlled failure
- diagnosis
- recovery
- audit evidence
- performance context
- automation where appropriate

---

# 4. Production Track 01 — Enterprise Batch Operations

## Status

**ACTIVE / EMERGING**

## Objective

Demonstrate the lifecycle of an enterprise-style batch workload from execution and application processing through JES2 operations, failure/recovery, observability, diagnostics, and WLM/SRM analysis.

## Current historical sequence

The existing core repository already contains the following sequence:

```text
Lab 30
Enterprise Batch Processing Baseline
        |
        v
Lab 31
COBOL Batch File Processing
        |
        v
Lab 32
Multistep JCL / Return Codes / Conditional Execution
        |
        v
Lab 33
COBOL Multirecord Validation / Reject Processing
        |
        v
Lab 34
DFSORT Temporary Datasets / Chained Steps
        |
        v
Lab 35
GDG Batch Pipeline Integration
        |
        v
Lab 36
Batch Restart / Rerun / Recovery
        |
        v
Lab 37
JES2 Spool / JQE Controlled Housekeeping
        |
        v
Lab 38
LOGREC / SMF Exit Operational Validation
        |
        v
Lab 39
SMF Type 99 / SRM / WLM Decision Data
```

## Participating domains

- Workload and Batch Engineering
- Application and Data Engineering
- Operations and Service Management
- Recovery Engineering
- Observability
- Problem Determination and Diagnostics
- Performance and Capacity Engineering
- Integration Engineering

## Participating repositories

Current historical execution is concentrated in:

`zos-adcd-hercules-engineering-lab`

Future expansion should reference capabilities from:

- `JCL_LABS`
- `zos-batch-scheduler`
- `COBOL`
- `vsam01`
- `DB2-`
- `mainframe-racf-security-evidence`

## Current maturity

Approximate track maturity:

**T2 — Operational**, with partial T3 characteristics through restart/rerun recovery.

## Next engineering goals

- scheduler-controlled execution
- dependency handling
- explicit failure injection
- SDSF diagnosis
- RACF authority validation
- VSAM and/or Db2 workload integration
- post-recovery data validation
- SMF correlation
- WLM behavior comparison
- production-style runbook

---

# 5. Production Track 02 — Secure Batch Application

## Status

**PLANNED**

## Objective

Build a secured batch application path where workload execution, application processing, data access, security controls, and audit evidence operate together.

## Target architecture

```text
Scheduler
   |
   v
JCL
   |
   v
JES2
   |
   v
COBOL
   |
   v
VSAM
   |
   +------> RACF / SAF
   |
   +------> SMF / Audit
```

## Participating repositories

- `zos-batch-scheduler`
- `JCL_LABS`
- `COBOL`
- `vsam01`
- `mainframe-racf-security-evidence`
- Core Platform repository

## Engineering goals

- schedule workload
- submit controlled JCL
- execute COBOL
- access VSAM
- validate RACF controls
- capture RC/ABEND
- capture SMF/security evidence
- introduce an authorization or data failure
- diagnose
- recover
- rerun safely

## Target maturity

T3 first.

T4/T5 after orchestration and evidence collection are automated.

---

# 6. Production Track 03 — Online Transaction Processing

## Status

**PLANNED**

## Objective

Validate the interaction between security, CICS, COBOL, Db2, and operational evidence.

## Target architecture

```text
RACF / SAF
    |
    v
CICS
    |
    v
COBOL
    |
    v
Db2
    |
    +------> SMF / Operational Evidence
```

## Participating repositories

- `CICS`
- `COBOL`
- `DB2-`
- `mainframe-racf-security-evidence`
- Core Platform repository

## Candidate capabilities

- CICS resource definitions
- transaction execution
- CICS-to-COBOL flow
- Db2 connection
- SQL processing
- transaction result validation
- RACF authority
- CICS/Db2 failure diagnosis
- rollback or recovery
- operational evidence

## Existing historical seed

`labs/05-db2-cics-db2conn-integration`

This should be treated as early integration evidence rather than duplicated.

---

# 7. Production Track 04 — Secure Network Service

## Status

**PLANNED / PARTIALLY SEEDED**

## Objective

Validate a secure z/OS network service from identity and USS runtime through TCP/IP/Communications Server policy and observable service behavior.

## Target architecture

```text
RACF / OMVS identity
        |
        v
USS
        |
        v
TCP/IP
        |
        v
Communications Server
        |
        v
Network Service
        |
        +------> SMF / SYSLOG / Audit
```

## Participating repositories

- `mainframe-racf-security-evidence`
- `UNIX_System_Services-`
- `zos-communications-server-network-lab`
- Core Platform repository

## Candidate capabilities

- started task identity
- OMVS identity
- service configuration
- TCP/IP listener
- exposure validation
- Policy Agent
- AT-TLS
- certificate/keyring integration
- audit/logging
- controlled failure
- rollback

## Important limitation

Capabilities must be labelled accurately as:

- validated
- partially validated
- readiness assessed
- planned
- unavailable in current environment

Do not describe service-specific encrypted communication as implemented until end-to-end evidence exists.

---

# 8. Production Track 05 — Enterprise Batch Scheduling

## Status

**PLANNED**

## Objective

Demonstrate the relationship between scheduling, JCL, JES2 execution, application result codes, dependencies, restart/rerun, and operational history.

## Architectural principle

```text
Scheduler decides and controls
        |
        v
JCL describes the workload
        |
        v
JES2 executes the workload
```

## Target architecture

```text
Scheduler
   |
   v
JCL
   |
   v
JES2
   |
   v
COBOL / Utility / Db2 / VSAM
   |
   v
RC / ABEND
   |
   v
Scheduler state / History
```

## Participating repositories

- `zos-batch-scheduler`
- `JCL_LABS`
- `COBOL`
- `DB2-`
- `vsam01`
- Core Platform repository

## Candidate capabilities

- ordering
- conditions
- resources
- submission
- JOBID tracking
- RC classification
- ABEND classification
- dependency release
- HOLD/FREE
- restart
- rerun
- calendar logic
- history
- operational evidence

---

# 9. Production Track 06 — Batch Failure and Recovery

## Status

**PARTIALLY SEEDED**

## Objective

Convert failure handling into a deliberate cross-domain engineering scenario.

## Target architecture

```text
Scheduler / Operator
        |
        v
Batch execution
        |
        v
Controlled failure
        |
        v
SDSF / SYSLOG / SMF
        |
        v
Diagnosis
        |
        v
Correction
        |
        v
Restart / Rerun
        |
        v
Recovery validation
```

## Participating domains

- Workload
- Operations
- Diagnostics
- Recovery
- Observability
- Integration

## Existing seed

`labs/36-batch-restart-rerun-recovery-part1`

`labs/36-batch-restart-rerun-recovery-part2`

## Future expansion

- scheduler-driven failure state
- dependency impact
- application-level failure
- authorization failure
- dataset/resource failure
- RC/ABEND classification
- recovery decision tree
- post-recovery evidence
- resumed downstream execution

---

# 10. Production Track 07 — Storage Recovery

## Status

**PARTIALLY SEEDED**

## Objective

Prove that data or volume backup, restore, validation, and application/workload reuse form one recoverable workflow.

## Target architecture

```text
Storage baseline
      |
      v
Backup
      |
      v
Controlled loss / alternate target
      |
      v
Restore
      |
      v
Catalog / Dataset Validation
      |
      v
Application / Workload Validation
```

## Participating repositories

Future:

- `zos-storage-dfsms-engineering`
- Core Platform repository
- application/data repositories as consumers

## Existing seeds

- ADRDSSU backup
- ADRDSSU restore

## Future expansion

- catalog validation
- application reuse
- restart after restore
- security validation
- recovery evidence
- recovery runbook
- RPO/RTO reasoning at laboratory scale

---

# 11. Production Track 08 — Operations Automation

## Status

**PLANNED**

## Objective

Progress from manual TSO/ISPF operation toward controlled REXX, scheduler, shell, z/OSMF, and API-driven automation.

## Target architecture

```text
TSO / ISPF
    |
    v
REXX
    |
    v
Operational procedure
    |
    v
Scheduler / USS / z/OSMF
    |
    v
REST / External Automation
```

## Participating repositories

- `MVS_TSO_ISPF`
- `Rexx`
- `zos-batch-scheduler`
- `UNIX_System_Services-`
- future automation management work
- Core Platform repository

## Candidate capabilities

- ISPF automation
- command automation
- evidence collection
- batch orchestration
- shell integration
- API-driven operation
- validation
- failure handling
- rollback
- audit trail

---

# 12. Production Track 09 — Low-Level System Programming

## Status

**PLANNED / FOUNDATIONAL**

## Objective

Connect user interaction, JCL, HLASM, Binder/load modules, addressability, storage representation, and system-level concepts.

## Target architecture

```text
TSO / ISPF
     |
     v
JCL
     |
     v
HLASM
     |
     v
Object Module
     |
     v
Binder
     |
     v
Load Module
     |
     v
Execution / System Concepts
```

## Participating repositories

- `MVS_TSO_ISPF`
- `JCL_LABS`
- `z_Assembly`
- Core Platform repository

## Future expansion

Do not claim advanced system-programming capabilities until validated.

Potential future topics:

- macros
- linkage
- control blocks
- exits
- authorized execution concepts

These require separate evidence before being represented as validated.

---

# 13. Production Track 10 — Software Maintenance Lifecycle

## Status

**PLANNED**

## Objective

Convert SMP/E from inventory/discovery into a controlled software maintenance lifecycle.

## Target architecture

```text
CSI / Zones
    |
    v
SYSMOD / HOLDDATA
    |
    v
RECEIVE
    |
    v
APPLY CHECK
    |
    v
APPLY
    |
    v
Validation
    |
    v
ACCEPT CHECK / ACCEPT
    |
    v
Maintenance Evidence
```

## Existing seed

`labs/29-smpe-csi-query-sysmod-inventory`

## Future repository candidate

`zos-software-maintenance-smpe`

## Important constraint

Actual maintenance actions should only be performed when suitable, legitimate maintenance materials and a safe lab path exist.

---

# 14. Production Track 11 — Performance Diagnosis

## Status

**PLANNED / PARTIALLY SEEDED**

## Objective

Connect workload behavior, WLM, RMF, SMF, diagnosis, and controlled improvement.

## Target architecture

```text
Workload
   |
   v
WLM / SRM
   |
   v
RMF / SMF
   |
   v
Observation
   |
   v
Diagnosis
   |
   v
Controlled change
   |
   v
Comparison / Validation
```

## Existing seeds

- WLM ISPF access
- WLM/RMF performance baseline
- SMF Type 99 / SRM / WLM decision data

## Future repository candidate

`zos-performance-capacity-engineering`

## Future capabilities

- workload variation
- CPU/resource observation
- service-class behavior
- response analysis
- before/after comparison
- capacity trends
- automated evidence extraction

---

# 15. Production Track 12 — Problem Determination Workflow

## Status

**PLANNED / PARTIALLY SEEDED**

## Objective

Build a repeatable incident workflow from symptom to root-cause evidence and recovery.

## Target architecture

```text
Symptom
   |
   v
Message / SYSLOG / SDSF
   |
   v
LOGREC / Dump
   |
   v
IPCS / Diagnostic Analysis
   |
   v
Root Cause
   |
   v
Corrective Action
   |
   v
Recovery
   |
   v
Post-Incident Validation
```

## Existing seeds

- LOGREC/dump foundations
- console/SYSLOG handling
- LOGREC/SMF operational validation

## Future repository candidate

`zos-problem-determination-diagnostics`

---

# 16. Flagship future track — End-to-End Production Cycle

## Status

**STRATEGIC TARGET**

## Objective

Create the flagship cross-repository scenario that demonstrates the whole ecosystem operating as one controlled z/OS engineering environment.

## Target architecture

```text
Scheduler
    |
    v
JCL / JES2
    |
    v
IDCAMS / VSAM preparation
    |
    v
COBOL processing
    |
    +------> VSAM
    |
    +------> Db2
    |
    v
Output / Reporting
    |
    v
Backup / Housekeeping
    |
    v
RC / ABEND
    |
    v
Scheduler History
```

Cross-cutting:

```text
RACF / SAF
SMF
SDSF
USS
Communications Server
Storage / Recovery
WLM / RMF
Diagnostics
```

## Controlled failure requirement

The flagship scenario should intentionally include at least one recoverable failure.

Possible examples:

- application RC
- JCL dependency failure
- missing dataset
- RACF authorization failure
- workload step failure
- controlled resource issue

## Recovery requirement

The track should demonstrate:

- detection
- diagnosis
- correction
- restart/rerun
- downstream continuation
- final state validation

## Why this matters

This track becomes the clearest proof that the portfolio is not a collection of unrelated exercises.

It demonstrates system-level thinking.

---

# 17. Production Track documentation standard

Each track should contain:

```text
# Track title

## Objective

## Architecture

## Participating domains

## Participating repositories

## Prerequisites

## Execution flow

## Evidence flow

## Security controls

## Failure scenario

## Diagnosis

## Recovery

## Completion criteria

## Current maturity

## Gaps

## Next milestone
```

---

# 18. Track dependency rules

Production Tracks should reference validated labs where possible.

Do not duplicate complete domain procedures inside the track.

Preferred:

```text
Prerequisite:
JCL_LABS Lab X
COBOL Lab Y
RACF Lab Z
```

Then document only the integration-specific behavior.

This keeps ownership clear.

---

# 19. Track versioning

A track may evolve through versions.

Example:

```text
Enterprise Batch Operations v1
Manual execution

v2
Scheduler integration

v3
Controlled failure/recovery

v4
Security and audit

v5
Automated evidence and production-like orchestration
```

This allows gradual growth without rewriting validated history.

---

# 20. Relationship to the profile architecture

The GitHub profile architecture should eventually show three complementary views:

1. **System Architecture Map** — how technologies interact.
2. **Engineering Domain Map** — how work is organized.
3. **Production Track Map** — how capabilities become integrated workflows.

The existing profile diagram remains intact.

Architecture V2 adds the second and third perspectives below it.

---

# 21. Planning rule

A new Production Track should be created only when:

- several validated capabilities already exist;
- the cross-domain relationship is meaningful;
- the track adds operational value;
- the track can produce distinct integration evidence;
- it does not merely duplicate domain labs.

The goal is not to create many tracks.

The goal is to create a small number of increasingly realistic workflows that prove the ecosystem behaves as a system.

# z/OS Ecosystem Integration Roadmap

## Objective

Prioritize integration work that produces the greatest increase in engineering value without duplicating existing laboratories.

## Priority 1 — Architecture and repository consistency

Current phase:

1. document repository relationships
2. document learning paths
3. document integration tracks
4. adopt a consistent branching model
5. correct repository naming inconsistencies
6. add ecosystem links to individual repository READMEs

## Priority 2 — Scheduler + JCL + JES2

Branch:

```text
integration/scheduler-jcl-jes2
```

Goal: prove the scheduler can move from a logical active job definition to actual JES2 execution and observable completion state.

Components:

- scheduler
- JES2
- JCL
- SDSF
- RC/result tracking

This relationship is foundational for all later scheduled workloads.

## Priority 3 — Scheduler + COBOL + VSAM

Branch:

```text
integration/scheduler-cobol-vsam
```

```text
scheduler
→ JCL
→ COBOL
→ VSAM
→ return code
→ scheduler successor logic
```

## Priority 4 — Scheduler + COBOL + Db2

Branch:

```text
integration/scheduler-cobol-db2
```

Include SQL result interpretation, failure, successor blocking and rerun/restart.

## Priority 5 — RACF + Communications + SMF

Branch:

```text
integration/racf-network-smf
```

```text
RACF authorization
→ TCP/IP service
→ controlled access test
→ allow/deny behavior
→ SMF/audit evidence
```

## Priority 6 — USS + RACF + TCP/IP

Branch:

```text
integration/uss-racf-tcpip
```

```text
RACF OMVS identity
→ USS
→ file/process permissions
→ TCP/IP
→ service
→ evidence
```

## Priority 7 — CICS + COBOL + Db2

Branch:

```text
integration/cics-cobol-db2
```

```text
3270
→ CICS
→ COBOL
→ Db2
→ response
```

Later extension:

```text
CICS
→ COBOL
→ VSAM
```

## Priority 8 — REXX + ISPF Automation

Branch:

```text
integration/rexx-ispf-automation
```

Potential use cases:

- data set inspection
- repeated ISPF workflows
- scheduler queries
- system status collection
- batch preparation

## Priority 9 — Storage + Backup + Recovery

Branch:

```text
integration/storage-backup-recovery
```

```text
data
→ protect
→ dump
→ restore
→ catalog validation
→ content validation
→ RACF validation
```

## Priority 10 — Assembler + System Engineering

Branch:

```text
integration/assembler-system-programming
```

Do not create immediately. Begin only after the Assembler track progresses beyond basic instructions and storage definitions.

Potential later topics:

- system macros
- control-block interpretation
- authorized versus non-authorized execution concepts
- diagnostic routines
- low-level z/OS interfaces

## Priority 11 — Full Production Night Simulation

Branch:

```text
integration/end-to-end-production-cycle
```

Potential chain:

```text
Scheduler
→ JOB01 prepare files / IDCAMS
→ JOB02 COBOL + VSAM
→ JOB03 COBOL + Db2
→ JOB04 reporting / DFSORT
→ JOB05 backup / housekeeping
```

Introduce one controlled failure:

```text
failure
→ scheduler stop
→ SDSF diagnosis
→ root-cause identification
→ remediation
→ restart/rerun
→ chain recovery
→ SMF/history evidence
```

Cross-cutting components:

- RACF
- JES2
- scheduler
- JCL
- COBOL
- VSAM
- Db2
- SDSF
- SMF
- backup/recovery

## Repository role policy

Fundamental repositories teach individual technologies.

Integration branches prove relationships.

Do not duplicate introductory content across multiple repositories. Prefer explicit prerequisites and cross-links to already validated foundational labs.

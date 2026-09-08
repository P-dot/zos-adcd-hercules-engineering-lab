# Evolution of the z/OS Laboratory Environment

## Initial state

The environment began primarily as a personal z/OS ADCD laboratory for interactive experimentation and isolated technical exercises.

## Stage 1 — Core exploration

Initial work established familiarity with TSO, ISPF, JCL, JES2, data sets and basic application execution.

## Stage 2 — System engineering

The engineering track progressively added:

- system services
- initialization
- task management
- storage
- DASD
- I/O
- XCF / GRS
- z/OS UNIX
- problem determination
- LOGREC
- JES2
- restart/rerun behavior
- SMF
- WLM/SRM
- backup and restore

This changed the laboratory from a workload-only environment into a system-engineering environment.

## Stage 3 — Security engineering

RACF laboratories introduced least privilege, controlled delegation, real access tests, OPERCMDS, UNIX security, auditing, evidence and rollback.

A recurring engineering pattern emerged:

```text
baseline
→ controlled change
→ positive / negative validation
→ evidence
→ rollback / remediation
```

## Stage 4 — Communications engineering

Communications Server work added TCP/IP configuration review, service exposure analysis, TN3270, certificates/key rings, USS network services, logging readiness, hardening and rollback.

Networking therefore became tied to RACF, USS and SMF rather than being treated only as connectivity.

## Stage 5 — Application and data specialization

Dedicated tracks now exist for:

- JCL
- COBOL
- VSAM
- Db2
- CICS
- REXX
- PL/I
- High Level Assembler

## Stage 6 — Onboarding and self-training

MVS_TSO_ISPF introduces an explicit learning route for new z/OS users and for existing users progressing toward automation.

## Stage 7 — Batch orchestration

The native educational scheduler adds a production-control layer above JES2:

```text
scheduler
→ eligibility
→ dependencies
→ resources
→ JES2 submission
→ execution
→ RC / ABEND
→ successor decision
```

## Stage 8 — Recovery engineering

The laboratory now includes restart/rerun, idempotency, backup, restore, rollback and failure analysis.

## Current architecture

The environment has evolved from:

```text
ADCD
+
isolated exercises
```

toward:

```text
z/OS system engineering
+
security
+
networking
+
USS
+
JES2
+
batch orchestration
+
application workloads
+
data management
+
automation
+
SMF / LOGREC observability
+
backup / recovery
+
publication-quality evidence
```

## Engineering maturity model

1. Discover — understand an individual component
2. Execute — perform a controlled operation
3. Reproduce — preserve commands, JCL and configuration
4. Validate — record output, return codes and screenshots
5. Control change — use baseline, modification and rollback
6. Integrate — connect multiple z/OS components
7. Operate — coordinate workloads using scheduling and operational control
8. Recover — handle failures, restarts and restoration
9. Observe — use SMF, LOGREC, SDSF and related evidence
10. Simulate production — run complete chains with scheduling, security, monitoring, failure, remediation, recovery and audit evidence

The laboratory is now moving from isolated Level 5/6 work toward Levels 7-10.

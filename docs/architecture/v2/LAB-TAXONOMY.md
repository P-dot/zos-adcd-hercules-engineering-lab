# Architecture V2 — Lab Taxonomy

## Purpose

This document defines how existing and future laboratories are classified inside Architecture V2.

The taxonomy preserves historical lab identities while adding a professional engineering classification model based on:

- engineering domain
- capability
- lifecycle stage
- maturity level
- integration level
- dependencies
- evidence
- outcome
- next capability

The objective is to ensure that the laboratory ecosystem grows according to a coherent engineering roadmap rather than only by sequential lab numbering.

---

# 1. Historical identity

Existing labs keep their current repository path as their stable historical identity.

Examples:

```text
labs/04-zvol-dasd-engineering
labs/18b-smf-man-dataset-sizing-rotation-stabilization
labs/36-batch-restart-rerun-recovery-part2
```

This is important because the current repository contains repeated numerical identifiers and multi-part labs.

Architecture V2 therefore does not assume that the numeric prefix is globally unique.

## Rule

For historical labs:

```text
Primary historical identifier = repository path
```

Lab numbers remain human-friendly labels but are not the authoritative key.

---

# 2. Engineering domain

Every lab receives one primary engineering domain.

Valid initial Architecture V2 domains are:

- Core Platform Engineering
- Operations and Service Management
- Storage and DFSMS Engineering
- Workload and Batch Engineering
- Software Maintenance Engineering
- Performance and Capacity Engineering
- Problem Determination and Diagnostics
- Sysplex and Availability Engineering
- Recovery Engineering
- Security Engineering
- Communications Engineering
- UNIX System Services Engineering
- Application and Data Engineering
- Automation and Modern Operations
- Integration Engineering

A lab can reference secondary domains, but one primary domain must be selected.

## Primary-domain rule

The primary domain is chosen according to the engineering objective, not merely according to the commands or tools used.

Example:

A JCL job that extracts SMF records for WLM analysis is primarily a Performance/Observability activity, not a JCL lab.

---

# 3. Capability

The capability identifies the concrete engineering skill or system responsibility advanced by the lab.

Examples:

```text
Platform
- IPL configuration
- PARMLIB management
- PROCLIB change control
- system library inspection

Storage
- DASD engineering
- SMS policy
- ACS allocation
- catalog management

Workload
- JES2 spool operation
- JQE maintenance
- restart/rerun
- return-code control

Maintenance
- CSI inventory
- SYSMOD analysis
- APPLY CHECK
- ACCEPT

Performance
- WLM policy analysis
- RMF observation
- SMF Type 99 interpretation

Diagnostics
- LOGREC analysis
- dump collection
- IPCS analysis
- ABEND diagnosis
```

## Capability naming rule

Capability names should describe an engineering responsibility rather than only a command.

Preferred:

```text
SMF MAN dataset rotation
```

Avoid:

```text
Run IFASMFDP
```

The command is implementation detail. The capability describes why the lab exists.

---

# 4. Lifecycle stage

Each lab is classified by one or more operational lifecycle stages.

Architecture V2 uses:

```text
Discover
Baseline
Configure
Operate
Observe
Diagnose
Recover
Improve
Automate
Integrate
```

## Definitions

### Discover

Identify what exists, where it is configured, and how the component is structured.

Typical evidence:

- inventory
- display commands
- read-only configuration inspection
- component presence
- dataset/member discovery

### Baseline

Establish a known, documented starting state.

Typical evidence:

- status
- configuration snapshot
- capability inventory
- health state
- authority baseline

### Configure

Make a controlled configuration change.

Requirements:

- pre-change evidence
- implementation step
- validation
- rollback method

### Operate

Perform normal runtime or administrative operation.

Examples:

- start/stop
- queue handling
- spool management
- SDSF operation
- service status control

### Observe

Collect and interpret runtime evidence.

Examples:

- SMF
- RMF
- SYSLOG
- LOGREC
- SDSF
- Health Checker

### Diagnose

Investigate abnormal or unexpected behavior.

Requirements:

- symptom
- evidence
- hypothesis
- analysis
- conclusion

### Recover

Restore a valid operational state.

Examples:

- restart
- rerun
- restore
- rollback
- reallocation
- service recovery

### Improve

Modify the system or procedure based on observed evidence.

Examples:

- sizing correction
- policy refinement
- operational hardening
- housekeeping improvement

### Automate

Convert a validated manual procedure into controlled automation.

Requirements:

- manual behavior already understood
- predictable inputs
- evidence collection
- failure handling
- rollback or recovery awareness

### Integrate

Prove interaction between multiple components, domains, or repositories.

---

# 5. Maturity level

Lifecycle stage and maturity level are related but not identical.

Architecture V2 defines six maturity levels.

## M0 — Exploratory

The lab discovers a facility or validates that it exists.

Characteristics:

- read-only
- limited scope
- capability discovery
- no operational dependency

## M1 — Foundational

The basic capability is understood and repeatable.

Characteristics:

- documented objective
- repeatable commands
- expected output
- basic evidence
- known limitations

## M2 — Operational

The capability can be used safely during normal operation.

Characteristics:

- controlled procedure
- validation
- runtime evidence
- return-code interpretation
- operational context

## M3 — Resilient

Failure, rollback, or recovery is explicitly addressed.

Characteristics:

- controlled failure or exception
- recovery path
- rollback
- post-recovery validation

## M4 — Automated

The capability is repeatable through automation.

Characteristics:

- scripted or orchestrated execution
- predictable validation
- failure handling
- evidence collection

## M5 — Integrated

The capability participates in a cross-domain or production-like workflow.

Characteristics:

- multiple components or repositories
- operational dependencies
- observability
- failure/recovery awareness
- end-to-end validation

---

# 6. Integration level

Integration level describes scope rather than maturity.

## I0 — Standalone

One focused capability.

Example:

```text
Inspect WLM configuration
```

## I1 — Cross-component

Several components in the same environment participate.

Example:

```text
JES2 -> WLM -> SMF
```

## I2 — Cross-repository

Capabilities owned by multiple specialized repositories interact.

Example:

```text
Scheduler -> JCL -> JES2 -> COBOL -> VSAM
```

## I3 — Production-like

The workflow includes operational characteristics such as:

- execution
- dependencies
- observability
- security
- failure
- diagnosis
- recovery
- audit evidence
- performance analysis
- automation

A production-like lab does not need to reproduce a commercial production system. It must demonstrate production-oriented engineering behavior.

---

# 7. Validation status

Every lab should explicitly state its validation status.

Recommended values:

- `PLANNED`
- `IN PROGRESS`
- `VALIDATED`
- `PARTIALLY VALIDATED`
- `READ-ONLY VALIDATED`
- `BLOCKED`
- `NOT AVAILABLE IN CURRENT ENVIRONMENT`

## Rule

Do not present a capability as implemented when the evidence only proves discovery, readiness, or partial activation.

This distinction is especially important for:

- external networking
- AT-TLS
- Policy Agent
- zERT
- sysplex features
- SMP/E maintenance actions
- performance tooling
- facilities limited by the ADCD/ZPDT environment

---

# 8. Evidence model

A professional lab should contain evidence appropriate to its lifecycle stage.

## Minimum evidence classes

### Configuration evidence

Examples:

- PARMLIB member
- PROCLIB member
- RACF profile
- TCP/IP profile
- SMS definition
- JCL
- procedure
- source code

### Runtime evidence

Examples:

- console output
- SDSF output
- job output
- operator command response
- process status
- subsystem messages

### Result evidence

Examples:

- RC=0000
- expected return code
- expected failure
- allocation result
- successful restore
- service status
- policy state

### Diagnostic evidence

Examples:

- message IDs
- SYSLOG
- LOGREC
- SMF
- RMF
- dumps
- traces

### Recovery evidence

Examples:

- rollback
- restart
- rerun
- restore
- final state validation

### Publication-security evidence

Before publication, repositories should verify that screenshots and text do not expose unnecessary:

- private IP addresses
- MAC addresses
- host identifiers
- credentials
- tokens
- private keys
- passwords
- local secrets
- sensitive host-side paths

---

# 9. Standard lab metadata

Future labs should include a concise metadata section near the beginning of the README.

Recommended structure:

```yaml
lab:
  historical_id: "labs/39-smf-type99-srm-wlm-decision-data-part1"
  title: "SMF Type 99 SRM/WLM Decision Data"
  status: "VALIDATED"

architecture:
  domain: "Performance and Capacity Engineering"
  capability: "WLM decision observability"
  lifecycle:
    - Observe
    - Diagnose
  maturity: "M2"
  integration_level: "I1"

relationships:
  components:
    - JES2
    - WLM
    - SRM
    - SMF
  repositories:
    - zos-adcd-hercules-engineering-lab

evidence:
  - commands
  - system-output
  - smf-records
  - interpretation

next_capability:
  - controlled workload variation
```

YAML is recommended as documentation metadata only. It does not need to be consumed by automation initially.

---

# 10. README structure for future labs

Architecture V2 recommends the following README structure.

```text
# Lab title

## Architecture metadata

## Objective

## Engineering context

## Scope

## Preconditions

## Components involved

## Procedure

## Commands / JCL / Source

## Expected result

## Evidence

## Result

## Failure or exception analysis

## Recovery / rollback

## Security and publication review

## Cross-repository relationships

## Lessons learned

## Next capability

## References
```

Existing labs do not need to be rewritten immediately.

The template applies primarily to new work and to major future revisions of existing labs.

---

# 11. Historical-lab classification

Historical labs are classified without forcing relocation.

For each existing lab, Architecture V2 records:

```text
historical path
primary domain
secondary domains
capability
lifecycle
maturity
integration level
future architectural home
action
```

Allowed actions:

## KEEP

The lab remains in its current repository and its future capability work also belongs there.

## REFERENCE

The historical lab stays where it is, but future capability development belongs primarily to another specialized repository.

## MIGRATE-FUTURE

The historical lab remains untouched, but new labs in that capability family should be created in the new domain repository.

## INTEGRATION-TRACK

The lab is retained as part of a cross-domain or production-like sequence.

## DEPRECATE

Use only if a lab is technically invalid, obsolete, or superseded.

Deprecation requires explicit documentation and should not erase historical evidence.

---

# 12. Duplicate numbering policy

Architecture V2 recognizes that the existing repository contains repeated lab numbers.

Examples include multiple paths beginning with:

```text
04-
05-
09-
10-
11-
12-
13-
14-
15-
19-
23-
36-
```

Do not renumber historical directories solely for Architecture V2.

Future labs should avoid ambiguous numbering inside the same repository.

## Recommended future naming

Use:

```text
NN-domain-capability-slug
```

Examples:

```text
40-performance-wlm-service-class-observation
41-maintenance-smpe-zone-inventory
42-diagnostics-ipcs-dump-analysis
```

If domain repositories are later separated, their local numbering may restart independently, but the historical origin should be documented.

---

# 13. Domain capability roadmaps

Each mature domain should maintain a capability roadmap.

Example:

```text
Performance and Capacity Engineering

P01 WLM environment discovery
P02 WLM/RMF baseline
P03 SMF Type 99 analysis
P04 workload observation
P05 controlled workload variation
P06 degradation diagnosis
P07 tuning validation
P08 capacity trend analysis
P09 automation
P10 cross-domain integration
```

The roadmap determines which lab should be created next.

A missing capability has higher planning value than simply increasing the numeric lab count.

---

# 14. Production-track taxonomy

Production tracks combine labs from several domains.

Each track should define:

- business or operational objective
- participating domains
- participating repositories
- execution sequence
- dependencies
- expected state
- failure scenario
- observability
- diagnosis
- recovery
- evidence
- completion criteria

Example:

```text
Track: Enterprise Batch Operations

Workload
   ->
Application
   ->
Data
   ->
JES2 Operations
   ->
Observability
   ->
Failure / Recovery
   ->
Diagnostics
   ->
Performance
```

A production track does not duplicate domain labs.

It references and integrates them.

---

# 15. Lab dependency taxonomy

Dependencies should be explicit.

## D0 — None

Standalone discovery.

## D1 — Same-domain prerequisite

Depends on an earlier capability in the same domain.

## D2 — Cross-domain prerequisite

Depends on another engineering domain.

## D3 — Cross-repository prerequisite

Depends on a capability validated in another repository.

## D4 — Environment prerequisite

Depends on infrastructure, product availability, licensing, configuration, or runtime state.

Example:

```text
SMP/E APPLY lab

D1: CSI and zone understanding
D4: suitable maintenance package / environment
```

---

# 16. Failure taxonomy

Architecture V2 distinguishes different failure types.

## F0 — Expected validation failure

Used intentionally to prove controls or error handling.

## F1 — Configuration failure

Incorrect or incomplete configuration.

## F2 — Authorization failure

RACF/SAF or authority issue.

## F3 — Resource failure

Storage, spool, dataset, memory, device, or capacity issue.

## F4 — Workload failure

JCL, application, RC, ABEND, dependency, or scheduler failure.

## F5 — Service failure

Started task, subsystem, listener, or runtime service problem.

## F6 — Integration failure

Components work individually but fail when combined.

## F7 — Environment limitation

The desired capability cannot be fully validated in the current ADCD/ZPDT/Hercules environment.

Failure classification helps future diagnostic and recovery tracks reuse previous incidents as controlled scenarios.

---

# 17. Result taxonomy

A lab result should distinguish technical completion from educational value.

Recommended result fields:

```text
Execution result
Validation result
Operational result
Security result
Recovery result
Publication result
```

Example:

```text
Execution result: RC=0000
Validation result: expected SMF output produced
Operational result: MAN dataset lifecycle validated
Security result: no new privileged access introduced
Recovery result: rollback path documented
Publication result: IP/MAC scan clean
```

---

# 18. Cross-repository relationship tags

Labs may document relationships using stable tags.

Recommended initial tags:

```text
REL-PLATFORM
REL-RACF
REL-USS
REL-COMMS
REL-JCL
REL-JES2
REL-SCHED
REL-COBOL
REL-PLI
REL-ASM
REL-VSAM
REL-DB2
REL-CICS
REL-SMF
REL-WLM
REL-STORAGE
REL-RECOVERY
REL-DIAGNOSTICS
REL-AUTOMATION
```

These tags are documentation aids and do not need to become Git labels immediately.

---

# 19. Next-capability rule

Every new lab should end by identifying the next logical capability.

Example:

```text
Current:
SMF Type 99 observation

Next capability:
Introduce controlled workload variation and compare WLM decision data.
```

This creates a continuous roadmap from validated evidence.

---

# 20. Definition of a completed Architecture V2 lab

A lab is complete when all relevant conditions are satisfied:

- objective is explicit
- primary domain is defined
- capability is defined
- lifecycle stage is defined
- prerequisites are documented
- procedure is reproducible
- commands/JCL/source are preserved
- expected result is stated
- actual evidence exists
- result is interpreted
- RC/ABEND/result semantics are explained
- failure conditions are documented when relevant
- rollback/recovery is documented when relevant
- cross-repository relationships are identified
- publication security is reviewed
- next capability is identified

A successful command alone is not sufficient.

---

# 21. Architecture V2 planning rule

The planning model is:

```text
Domain roadmap
      +
Capability gap
      +
Lifecycle gap
      +
Maturity gap
      +
Integration roadmap
      |
      v
Next lab
```

This is the central planning rule of Architecture V2.

Lab numbering records sequence.

Architecture records purpose.

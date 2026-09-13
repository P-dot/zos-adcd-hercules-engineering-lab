# Architecture V2 — Engineering Domains

## Purpose

This document defines the engineering domains used by Architecture V2 of the P-dot z/OS laboratory ecosystem.

The objective is to give each laboratory, roadmap item, and future repository a clear responsibility boundary while preserving the existing Architecture V1 relationships and historical lab structure.

Architecture V2 does not force immediate repository migration. It first establishes a stable classification model and then allows repositories to evolve when a domain has sufficient depth.

## Domain model

The ecosystem is organized into the following engineering domains:

1. Core Platform Engineering
2. Operations and Service Management
3. Storage and DFSMS Engineering
4. Workload and Batch Engineering
5. Software Maintenance Engineering
6. Performance and Capacity Engineering
7. Problem Determination and Diagnostics
8. Sysplex and Availability Engineering
9. Recovery Engineering
10. Security Engineering
11. Communications Engineering
12. UNIX System Services Engineering
13. Application and Data Engineering
14. Automation and Modern Operations
15. Integration Engineering

Several cross-cutting planes operate across these domains:

- Security plane
- Observability plane
- Automation plane

These planes describe concerns that cannot be owned by only one repository.

---

# 1. Core Platform Engineering

## Mission

Provide the common z/OS platform foundation on which every specialized domain operates.

Core Platform is responsible for system structure, initialization, foundational configuration, shared libraries, system-level change control, and the platform baseline.

## Core capabilities

- z/OS system structure
- operating environment initialization
- IPL concepts and IPL parameters
- PARMLIB organization and member selection
- PROCLIB organization
- system libraries
- LPA
- LINKLIST
- APF authorization foundations
- started task foundations
- subsystem foundations
- platform layout
- system-wide configuration baselines
- controlled system changes
- rollback planning
- Health Checker integration
- common ADCD / ZPDT / Hercules environment

## Current repository

`zos-adcd-hercules-engineering-lab`

## Expected long-term role

The current engineering repository should progressively become the common **Core Platform and Integration Engineering** repository rather than the permanent home of every z/OS engineering topic.

## Belongs here

A lab belongs in Core Platform when its principal purpose is to establish or control the common operating environment.

Examples:

- IPL/PARMLIB configuration
- PROCLIB change control
- system library inspection
- foundational started task configuration
- common platform health baseline

## Does not belong here long term

Deep domain-specific work should stop expanding indefinitely inside Core once a specialized engineering domain becomes mature.

Examples:

- advanced DFSMS policy engineering
- advanced WLM/RMF analysis
- deep IPCS diagnostics
- mature SMP/E maintenance workflows

---

# 2. Operations and Service Management

## Mission

Operate the running z/OS environment safely, consistently, and observably.

This domain represents day-to-day system operation rather than static configuration.

## Core capabilities

- operator commands
- console operations
- system message handling
- SYSLOG interpretation
- SDSF operational use
- JES2 operational control
- started task lifecycle
- service status validation
- Health Checker operational use
- housekeeping
- incident handling
- operational baselines
- change execution
- post-change validation
- restart coordination
- runbook-oriented procedures

## Relationship to Core Platform

Core Platform defines the environment.

Operations runs and validates that environment.

## Relationship to Workload

Operations manages system execution conditions, while Workload Engineering focuses on batch flow, scheduling, JES2 processing, and workload behavior.

---

# 3. Storage and DFSMS Engineering

## Mission

Engineer the z/OS storage environment, including physical and logical storage resources, allocation policy, catalogs, SMS constructs, and storage lifecycle controls.

## Core capabilities

- DASD inventory and engineering
- volumes
- VTOC concepts
- I/O paths related to storage
- catalogs
- data set placement
- SMS
- DFSMS
- storage groups
- storage classes
- management classes
- data classes
- ACS routines
- allocation policy
- pool design
- DFSMShsm readiness where available
- DFSMSrmm / removable media foundations
- HCD/IODF relationships to storage devices
- storage-related backup and restore integration

## Current evidence

The existing core engineering repository already contains multiple labs covering:

- storage management
- ZVOL / DASD engineering
- IODF / DASD paths
- Catalog / SMS
- DFSMS/SMS baseline
- SMS pool creation
- ACS automatic allocation
- DFSMSrmm
- HCD/IODF baseline

This is already sufficient to justify Storage as a major Architecture V2 domain.

## Candidate future repository

`zos-storage-dfsms-engineering`

## Boundary with Recovery

Storage Engineering owns storage architecture and policy.

Recovery Engineering owns the recovery objective, recovery workflow, validation, and service restoration.

A tool such as ADRDSSU may participate in both domains depending on the lab objective.

---

# 4. Workload and Batch Engineering

## Mission

Engineer how batch work is described, submitted, executed, controlled, observed, and recovered.

## Core capabilities

- JCL
- JES2
- spool
- queues
- JQEs
- job execution lifecycle
- return codes
- conditional execution
- restart/rerun
- GDGs in workload pipelines
- DFSORT in batch workflows
- scheduler relationships
- workload dependencies
- SDSF interaction
- batch operational recovery

## Existing specialized repositories

- `JCL_LABS`
- `zos-batch-scheduler`

## Architectural principle

**Scheduler decides and controls. JCL describes the workload. JES2 executes the workload.**

## Relationship to Integration Engineering

A workload lab becomes an Integration Engineering scenario when it coordinates applications, data, security, observability, recovery, or multiple repositories.

---

# 5. Software Maintenance Engineering

## Mission

Manage the lifecycle of installed z/OS software and maintenance using controlled, auditable maintenance practices.

## Core capabilities

- SMP/E architecture
- CSI
- global zone
- target zones
- distribution zones
- SYSMOD inventory
- FUNCTION
- PTF
- APAR
- USERMOD
- HOLDDATA
- RECEIVE
- APPLY CHECK
- APPLY
- ACCEPT CHECK
- ACCEPT
- maintenance reporting
- maintenance failure analysis
- rollback / recovery strategy
- software maintenance automation

## Current evidence

The ecosystem already contains:

`29-smpe-csi-query-sysmod-inventory`

This lab is the seed of the domain but not yet enough by itself to justify immediate repository separation.

## Candidate future repository

`zos-software-maintenance-smpe`

## Promotion criterion

Create the repository when several validated SMP/E capabilities exist and the roadmap extends beyond a single discovery/inventory lab.

---

# 6. Performance and Capacity Engineering

## Mission

Understand, measure, explain, and improve system and workload behavior.

## Core capabilities

- WLM
- SRM
- RMF
- SMF performance records
- service classes
- goals
- workload classification
- resource consumption
- system utilization
- response behavior
- bottleneck analysis
- capacity trends
- performance baselines
- controlled degradation scenarios
- post-change performance validation

## Existing evidence

Current labs already include:

- WLM ISPF access
- WLM/RMF performance baseline
- SMF Type 99 / SRM / WLM decision data

## Candidate future repository

`zos-performance-capacity-engineering`

## Boundary with Observability

Observability collects and exposes evidence.

Performance Engineering interprets that evidence to explain workload and system behavior.

---

# 7. Problem Determination and Diagnostics

## Mission

Identify, isolate, explain, and document abnormal system or workload behavior.

## Core capabilities

- LOGREC
- dumps
- system messages
- SYSLOG
- ABEND analysis
- diagnostic data collection
- IPCS
- traces
- failure reproduction
- fault isolation
- incident evidence
- root cause analysis
- post-incident validation

## Existing evidence

Current labs already include:

- LOGREC and dump foundations
- console/SYSLOG message handling
- LOGREC/SMF operational validation

## Candidate future repository

`zos-problem-determination-diagnostics`

## Promotion criterion

The domain becomes a strong independent repository once IPCS, ABEND analysis, dump workflows, and repeatable incident scenarios are added.

## Boundary with Recovery

Diagnostics determines what failed and why.

Recovery restores the service or workload.

---

# 8. Sysplex and Availability Engineering

## Mission

Engineer z/OS coordination, serialization, shared-service foundations, and availability-oriented system behavior.

## Core capabilities

- XCF
- GRS
- System Logger
- monoplex concepts
- sysplex configuration foundations
- resource serialization
- signaling and membership concepts
- cross-system coordination
- availability architecture
- ARM concepts when available
- RRS relationships where appropriate

## Existing evidence

Current labs include:

- Sysplex / XCF / GRS / Logger structure
- XCF monoplex professional baseline

## Candidate future repository

`zos-sysplex-availability-engineering`

## Current decision

Keep as an Architecture V2 domain but do not create a dedicated repository yet.

---

# 9. Recovery Engineering

## Mission

Restore workloads, data, and services after a controlled or real failure and prove that recovery is valid.

## Core capabilities

- backup
- restore
- ADRDSSU
- restart
- rerun
- rollback
- recovery point reasoning
- recovery validation
- post-recovery verification
- controlled failure scenarios
- operational recovery procedures

## Existing evidence

Current labs include:

- ADRDSSU backup
- ADRDSSU restore
- batch restart/rerun recovery

## Candidate future repository

`zos-availability-recovery-engineering`

## Current decision

Keep Recovery as a domain and cross-domain capability. Delay repository creation until its scope is clearly broader than storage backup/restore and batch restart.

---

# 10. Security Engineering

## Mission

Protect z/OS resources and privileged operations through RACF/SAF controls, least privilege, identity management, auditing, and security validation.

## Existing specialized repository

`mainframe-racf-security-evidence`

## Core capabilities

- RACF identities
- groups
- data set profiles
- general resource profiles
- OPERCMDS
- FACILITY
- STARTED
- OMVS segments
- privileged authority review
- least privilege
- effective authority analysis
- audit evidence
- security rollback
- Health Checker security findings
- cross-domain authorization

## Cross-cutting role

Security is both a specialized domain and a system-wide engineering plane.

RACF/SAF affects:

- TSO/ISPF
- JES2
- USS
- Communications Server
- CICS
- Db2
- storage
- started tasks
- system commands
- automation

---

# 11. Communications Engineering

## Mission

Engineer secure and observable z/OS network connectivity and communication services.

## Existing specialized repository

`zos-communications-server-network-lab`

## Core capabilities

- TCP/IP
- Communications Server
- VTAM-related foundations
- TN3270
- FTP
- network started tasks
- service exposure
- network logging
- Policy Agent readiness
- AT-TLS readiness and implementation
- RACF integration
- certificate/keyring relationships
- external connectivity investigation
- rollback and hardening

## Boundary with Security

Communications Engineering owns network service design and operation.

Security Engineering owns authorization and security policy controls that protect those services.

---

# 12. UNIX System Services Engineering

## Mission

Engineer the POSIX/UNIX execution environment within z/OS.

## Existing specialized repository

`UNIX_System_Services-`

## Core capabilities

- OMVS
- POSIX identity
- filesystems
- HFS/zFS
- permissions
- links
- processes
- shell execution
- runtime management
- MVS-to-POSIX integration
- RACF/OMVS integration
- TCP/IP relationships

## Cross-domain relationships

USS connects Platform, Security, Communications, Automation, and modern application/tooling workflows.

---

# 13. Application and Data Engineering

## Mission

Develop and validate workloads that consume the system platform and provide realistic processing scenarios for integration.

## Existing specialized repositories

- `COBOL`
- `PL-I`
- `z_Assembly`
- `vsam01`
- `DB2-`
- `CICS`

## Core capabilities

### Languages

- COBOL
- PL/I
- HLASM / z/Assembly

### Data

- VSAM
- Db2
- sequential data sets
- application file processing

### Transaction processing

- CICS
- CICS-to-Db2 integration
- program/resource interaction

## Architectural role

Application/Data repositories validate technology-specific capabilities.

They should not duplicate system administration domains.

Integration tracks consume these capabilities to create realistic end-to-end workloads.

---

# 14. Automation and Modern Operations

## Mission

Reduce repetitive manual work using controlled, reviewable, observable automation.

## Existing foundations

- `Rexx`
- `zos-batch-scheduler`
- JCL-based automation
- USS shell capabilities

## Future capabilities

- REXX/ISPF automation
- command automation
- operational scripts
- scheduler-driven orchestration
- z/OSMF workflows
- z/OSMF REST APIs
- external Python/PowerShell tooling
- Git-driven configuration/documentation workflow
- automated evidence collection
- repeatable validation
- API-driven operations

## Candidate future repository

A dedicated repository such as `zos-automation-management` should be considered only when automation work becomes broad enough that it no longer belongs primarily to REXX, Scheduler, USS, or another domain.

---

# 15. Integration Engineering

## Mission

Prove that capabilities from multiple domains and repositories work together in realistic z/OS operational workflows.

Integration Engineering is not a technology repository.

It is the place where the system is exercised as a system.

## Integration levels

### Cross-component

Multiple components inside one system or domain.

Example:

JES2 -> WLM -> SMF

### Cross-repository

Capabilities from multiple specialized repositories.

Example:

Scheduler -> JCL -> JES2 -> COBOL -> VSAM

### Production-like

A complete operational scenario including several of:

- execution
- dependencies
- security
- observability
- controlled failure
- diagnosis
- recovery
- audit evidence
- performance analysis
- automation

## Existing integration repository

`mainframe-cobol-db2-cics-devops-lab`

Its role should be clarified as an integration/composite application track rather than a replacement for fundamental COBOL, Db2, or CICS repositories.

## Existing emerging production track

Labs 30–39 in the core engineering repository already form an early cross-domain batch operations track:

```text
Enterprise Batch Baseline
        ->
COBOL Processing
        ->
Multistep JCL / RC Control
        ->
Validation / Reject Processing
        ->
DFSORT Chained Processing
        ->
GDG Pipeline
        ->
Restart / Rerun Recovery
        ->
JES2 Operational Housekeeping
        ->
LOGREC / SMF Validation
        ->
WLM / SRM Decision Analysis
```

Architecture V2 preserves this sequence as integration evidence even when future capabilities move to specialized domain roadmaps.

---

# Cross-cutting plane A — Security

Security applies to every engineering domain.

A domain is not considered mature merely because its functional capability works. It should also consider:

- identity
- authority
- least privilege
- protected resources
- operational permissions
- auditability
- rollback
- publication security

The RACF repository remains the primary security specialization, while other repositories reference the relevant controls.

---

# Cross-cutting plane B — Observability

Observability provides the evidence needed to understand system behavior.

## Primary sources

- SMF
- SYSLOG
- LOGREC
- RMF
- JES/SDSF output
- Health Checker
- subsystem messages
- command output

## Consumers

- Operations
- Security
- Performance
- Capacity
- Diagnostics
- Workload Engineering
- Recovery Engineering
- Integration Engineering

SMF is therefore not owned exclusively by Performance Engineering.

---

# Cross-cutting plane C — Automation

Automation is applied after a process is understood and validated manually.

The preferred progression is:

```text
Manual understanding
        ->
Repeatable procedure
        ->
Controlled script
        ->
Observable automation
        ->
Recoverable automation
        ->
Cross-domain orchestration
```

Automation without diagnosis, rollback, or evidence is not treated as a mature engineering outcome.

---

# Repository specialization rules

A new repository should not be created simply because a domain exists in Architecture V2.

A domain becomes a dedicated repository when most of the following are true:

1. It has multiple validated labs.
2. It has a clear technical responsibility boundary.
3. It has a meaningful roadmap independent from Core Platform.
4. Future growth would make the Core repository less coherent.
5. It can provide its own evidence, rollback, and validation model.
6. Cross-domain relationships can be referenced instead of duplicated.
7. The repository name represents a stable professional discipline rather than one isolated utility.

## Current Architecture V2 assessment

### Strong candidate now

- `zos-storage-dfsms-engineering`

### Strong candidate as the next labs mature

- `zos-performance-capacity-engineering`
- `zos-problem-determination-diagnostics`

### Strategic domain, not yet enough depth

- `zos-software-maintenance-smpe`
- `zos-sysplex-availability-engineering`
- `zos-availability-recovery-engineering`

---

# Domain ownership rule

When a lab touches several technologies, assign the primary domain according to its engineering objective rather than the commands it happens to execute.

Examples:

- A job using JCL to dump SMF records for performance analysis belongs primarily to Performance/Observability, not JCL.
- ADRDSSU used to demonstrate storage movement may belong to Storage.
- ADRDSSU used to prove service recovery belongs primarily to Recovery.
- RACF commands used to authorize a TCP/IP service do not turn the lab into a RACF lab if the primary objective is Communications Server behavior.
- COBOL used as the workload generator in a WLM lab does not make the lab an application-development lab.

This rule prevents repository duplication.

---

# Evolution principle

Architecture V2 is intentionally designed to grow.

New domains may be introduced when:

- a new professional responsibility emerges;
- several labs form a coherent capability family;
- IBM z/OS architecture evolves;
- the laboratory gains new licensed or supported facilities;
- an integration track reveals a missing responsibility boundary.

Any future domain should be connected back to:

- the common Core Platform,
- cross-cutting Security and Observability,
- operational maturity,
- and at least one integration path.

The objective is a continuously improving engineering architecture, not a fixed taxonomy.

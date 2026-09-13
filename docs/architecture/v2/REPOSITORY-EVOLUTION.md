# Architecture V2 — Repository Evolution

## Purpose

This document defines how the P-dot z/OS laboratory ecosystem should evolve from its current repository structure into a more professional domain-oriented architecture without losing validated history.

Architecture V2 does not treat repository creation as a cosmetic exercise.

A new repository is created only when a professional engineering domain has enough capability depth, roadmap independence, and responsibility clarity to justify separation.

The default rule is:

```text
Preserve history
      +
Classify existing labs
      +
Grow domain capability
      +
Create repository when justified
      +
Continue future work there
      +
Reference historical origin
```

---

# 1. Evolution principles

## Preserve historical evidence

Existing labs should remain where they were validated unless there is a strong technical reason to move them.

Benefits:

- Git history remains intact.
- Existing URLs remain stable.
- screenshots and evidence keep their context.
- previous documentation references remain valid.
- the evolution of the engineering environment remains visible.

Architecture V2 therefore favors **future specialization** over historical relocation.

## Specialize by responsibility

A repository should represent a stable professional engineering responsibility.

Good repository boundaries are based on:

- system responsibility
- capability family
- operational lifecycle
- independent roadmap
- reusable evidence model

Avoid creating repositories around one command, one panel, or one isolated utility.

## Avoid duplication

A capability should have one primary technical home.

Other repositories should reference that capability rather than reimplement its full procedure.

Example:

RACF authorization used by a Communications Server lab should be referenced as a security dependency, not recreated as a second RACF curriculum.

## Integration is separate from specialization

Specialized repositories build capability depth.

Integration tracks prove system behavior across domains.

These are different responsibilities and should remain distinguishable.

---

# 2. Current ecosystem role model

The current ecosystem already contains several mature specialized repositories.

## Core Platform / Integration

`zos-adcd-hercules-engineering-lab`

Current state:

- contains the common ADCD/ZPDT/Hercules platform;
- contains historical system-programming labs;
- contains cross-domain operational work;
- currently includes several domains that have grown large enough to consider specialization.

Target state:

**z/OS Core Platform and Integration Engineering**

Primary long-term responsibilities:

- system structure
- initialization
- IPL
- PARMLIB
- PROCLIB
- system libraries
- foundational started tasks
- common platform baselines
- change control
- shared operational health
- cross-domain integration tracks

The repository remains central.

It does not disappear.

Its scope becomes clearer as specialized domains mature.

---

# 3. Existing specialized repositories that should remain specialized

Architecture V2 should not recreate these domains inside Core.

## Security

`mainframe-racf-security-evidence`

Owns:

- RACF/SAF
- identity
- authority
- profiles
- least privilege
- privileged access
- audit
- rollback
- security evidence

## Communications

`zos-communications-server-network-lab`

Owns:

- TCP/IP
- Communications Server
- network services
- service exposure
- network started tasks
- Policy Agent / AT-TLS progression
- network hardening
- network rollback

## UNIX System Services

`UNIX_System_Services-`

Owns:

- OMVS
- POSIX
- filesystem
- permissions
- processes
- shell
- MVS/POSIX relationships

## JCL

`JCL_LABS`

Owns:

- JCL syntax
- procedures
- datasets
- utilities
- GDGs
- batch execution description

## Batch Scheduling

`zos-batch-scheduler`

Owns:

- scheduling
- ordering
- dependencies
- conditions
- resources
- workload control
- job-state handling
- restart/rerun orchestration

## TSO / ISPF

`MVS_TSO_ISPF`

Owns:

- TSO/E interaction
- ISPF navigation
- logical screens
- user productivity
- onboarding
- future ISPF service usage

## REXX

`Rexx`

Owns:

- REXX language capability
- TSO/ISPF automation
- command automation foundations

## COBOL

`COBOL`

Owns:

- COBOL language capability
- data definitions
- procedural logic
- file processing
- application foundations

## PL/I

`PL-I`

Owns:

- PL/I language capability
- procedures
- I/O
- application development

## z/Assembly

`z_Assembly`

Owns:

- HLASM / zArchitecture programming
- registers
- addressing
- storage representation
- linkage foundations

## VSAM

`vsam01`

Owns:

- ESDS
- KSDS
- RRDS
- LDS
- access methods
- VSAM data structures

## Db2

`DB2-`

Owns:

- Db2 application and SQL foundations
- DDL / DML
- SPUFI / QMF
- catalog relationships
- application database work

## CICS

`CICS`

Owns:

- CICS fundamentals
- resources
- CECI/CEDF
- BMS
- transaction processing foundations

---

# 4. First specialization candidate — Storage and DFSMS

## Proposed repository

`zos-storage-dfsms-engineering`

## Status

**JUSTIFIED**

## Why it is justified now

The current core repository already contains a coherent set of capabilities:

- storage management foundations
- DASD / ZVOL engineering
- I/O paths
- Catalog / SMS
- DFSMS/SMS baseline
- SMS pool creation
- ACS allocation
- DFSMSrmm
- HCD/IODF relationships
- ADRDSSU-related recovery work

This is no longer one isolated topic.

It is a professional domain with enough breadth for an independent roadmap.

## Historical migration policy

Do not move the old labs immediately.

Instead:

```text
Historical storage labs
remain in Core
        |
        v
Architecture V2 references them
        |
        v
New Storage/DFSMS labs
start in the new repository
```

## Recommended initial roadmap

```text
STOR-001 Storage environment inventory
STOR-002 DASD and volume baseline
STOR-003 VTOC and free-space analysis
STOR-004 Catalog architecture
STOR-005 SMS fundamentals
STOR-006 Storage groups
STOR-007 Storage / Data / Management classes
STOR-008 ACS logic
STOR-009 Controlled allocation
STOR-010 DFSMSrmm
STOR-011 HCD/IODF relationship
STOR-012 Backup integration
STOR-013 Restore integration
STOR-014 Storage failure scenario
STOR-015 Recovery validation
```

## Relationship to Core

Core provides the z/OS system and platform configuration.

Storage Engineering owns storage policy and deeper data-placement behavior.

---

# 5. Second candidate — Performance and Capacity

## Proposed repository

`zos-performance-capacity-engineering`

## Status

**STRONG CANDIDATE**

## Current evidence

The current core repository already includes:

- WLM ISPF access
- WLM/RMF baseline
- SMF Type 99 / SRM / WLM analysis

## Why separation is useful

Performance engineering has a distinct professional responsibility:

- workload goals
- service classes
- system utilization
- workload observation
- resource behavior
- bottleneck analysis
- capacity analysis
- tuning validation

This responsibility becomes difficult to represent clearly if it remains mixed indefinitely with storage, recovery, diagnostics, and platform initialization.

## Recommended growth before repository creation

Add several capabilities such as:

```text
PERF-001 WLM environment discovery
PERF-002 Service definition baseline
PERF-003 RMF observation
PERF-004 SMF Type 99 interpretation
PERF-005 Controlled workload variation
PERF-006 Resource behavior comparison
PERF-007 Performance degradation scenario
PERF-008 Diagnosis
PERF-009 Improvement validation
PERF-010 Capacity trend analysis
```

Create the repository when enough of this roadmap is active.

---

# 6. Third candidate — Problem Determination and Diagnostics

## Proposed repository

`zos-problem-determination-diagnostics`

## Status

**STRONG CANDIDATE**

## Existing foundations

- LOGREC / dump foundations
- console and SYSLOG handling
- LOGREC / SMF operational validation

## Missing capabilities

Before separation becomes compelling, add:

- IPCS fundamentals
- dump capture
- ABEND analysis
- message-to-documentation workflow
- failure classification
- root-cause workflow
- incident evidence package
- post-incident validation

## Target professional role

The repository should answer:

```text
What failed?
How was it detected?
What evidence was collected?
How was the failure isolated?
What was the root cause?
What corrective action was taken?
How was recovery validated?
```

---

# 7. Strategic candidate — Software Maintenance / SMP/E

## Proposed repository

`zos-software-maintenance-smpe`

## Status

**DOMAIN DECLARED / REPOSITORY NOT YET JUSTIFIED**

## Existing seed

`labs/29-smpe-csi-query-sysmod-inventory`

## Required capability depth

Develop:

- CSI architecture
- zones
- SYSMOD types
- HOLDDATA
- RECEIVE
- APPLY CHECK
- APPLY
- ACCEPT CHECK
- ACCEPT
- reporting
- maintenance failure
- recovery
- automation

## Creation trigger

Create the repository when the domain moves beyond discovery and has several safely validated maintenance capabilities.

---

# 8. Strategic candidate — Sysplex and Availability

## Proposed repository

`zos-sysplex-availability-engineering`

## Status

**DOMAIN DECLARED / WAIT**

## Existing foundations

- XCF
- GRS
- System Logger
- monoplex baseline

## Future growth

Potential capabilities:

- XCF groups
- signaling
- GRS serialization
- System Logger usage
- RRS
- ARM concepts
- multi-system coordination
- availability behavior

## Constraint

Do not claim Parallel Sysplex or multi-LPAR validation unless the lab environment actually supports and proves it.

---

# 9. Strategic candidate — Recovery Engineering

## Proposed repository

`zos-availability-recovery-engineering`

## Status

**DOMAIN DECLARED / WAIT**

## Existing foundations

- ADRDSSU backup
- ADRDSSU restore
- batch restart/rerun

## Reason to wait

Current recovery work overlaps strongly with:

- Storage
- Workload
- Core Platform
- future Sysplex/Availability

A dedicated repository should be created only when Recovery gains enough cross-domain breadth.

Potential roadmap:

- dataset recovery
- volume recovery
- workload recovery
- started-task recovery
- configuration rollback
- application restart
- recovery validation
- runbooks
- recovery automation
- DR-oriented scenarios

---

# 10. Automation repository decision

## Candidate

`zos-automation-management`

## Status

**DO NOT CREATE YET**

Automation currently belongs naturally inside:

- `Rexx`
- `zos-batch-scheduler`
- `UNIX_System_Services-`
- Core Platform
- future z/OSMF work

Create an automation repository only when the ecosystem has substantial cross-domain orchestration that cannot be owned clearly by one existing repository.

---

# 11. Integration repository role

## Existing repository

`mainframe-cobol-db2-cics-devops-lab`

## Target role

This repository should represent composite/integration application scenarios.

It should not duplicate the fundamental curricula of:

- COBOL
- Db2
- CICS

Preferred role:

```text
Fundamental repositories
       |
       v
Validated capabilities
       |
       v
Composite integration scenario
```

Potential long-term tracks:

- COBOL + Db2
- CICS + COBOL + Db2
- build/deploy workflow
- application operational validation
- application observability
- application recovery

---

# 12. Core repository evolution phases

The central repository should evolve gradually.

## Phase 1 — Classification

Status: Architecture V2 work.

Actions:

- classify existing labs;
- define domains;
- define maturity;
- define integration tracks;
- identify specialization candidates.

## Phase 2 — Future ownership

Actions:

- keep historical labs;
- stop expanding mature specialized domains inside Core;
- create new labs in their future domain repository.

## Phase 3 — Core cleanup by documentation

Actions:

- update README;
- add domain navigation;
- identify historical domain labs;
- clearly distinguish Core from archived/historical specialization work.

No destructive moves required.

## Phase 4 — Cross-domain integration

Core increasingly hosts:

- platform baselines
- integration tracks
- cross-domain validation
- system-level change control
- common operational scenarios

## Phase 5 — Mature ecosystem

Target:

```text
Core Platform
      |
      +---- Storage
      |
      +---- Performance
      |
      +---- Diagnostics
      |
      +---- Maintenance
      |
      +---- Security
      |
      +---- Communications
      |
      +---- USS
      |
      +---- Workload
      |
      +---- Applications
      |
      +---- Automation
      |
      v
Integration Tracks
```

---

# 13. Repository creation gates

A new repository should normally satisfy at least five of these seven criteria.

## Gate 1 — Capability depth

At least several related capabilities exist or are actively planned.

## Gate 2 — Stable responsibility

The domain represents a stable professional responsibility.

## Gate 3 — Independent roadmap

The domain can grow without relying on Core for every new lab.

## Gate 4 — Evidence model

The repository can maintain its own evidence, validation, and rollback standards.

## Gate 5 — Distinct audience

The repository has a meaningful learning or engineering path of its own.

## Gate 6 — Low duplication

Its content can reference other repositories rather than copying them.

## Gate 7 — Future growth

Continued growth inside Core would reduce clarity.

---

# 14. Repository lifecycle

Architecture V2 defines a repository lifecycle.

```text
Capability family appears
        |
        v
Domain declared
        |
        v
Roadmap grows
        |
        v
Repository candidate
        |
        v
Repository created
        |
        v
Historical labs referenced
        |
        v
New domain labs developed
        |
        v
Cross-repository integration
```

This makes repository creation a consequence of engineering maturity.

---

# 15. Naming convention

Preferred names:

```text
zos-<domain>-engineering
```

Examples:

- `zos-storage-dfsms-engineering`
- `zos-performance-capacity-engineering`
- `zos-problem-determination-diagnostics`
- `zos-software-maintenance-smpe`
- `zos-sysplex-availability-engineering`

Existing repositories should not be renamed merely for visual consistency unless there is a strong reason.

History and discoverability matter more than perfect naming symmetry.

---

# 16. Cross-repository documentation requirements

When a capability changes future ownership:

The historical repository should document:

- original lab path
- original validation context
- future specialized repository

The specialized repository should document:

- historical origin
- previous labs
- capability continuation
- cross-repository dependencies

This avoids duplicated or orphaned history.

---

# 17. Git branch strategy for Architecture V2 evolution

Continue using short-lived branches.

Recommended patterns:

```text
docs/<topic>
lab/<number>-<slug>
integration/<track>
fix/<topic>
```

Potential future examples:

```text
docs/storage-domain-bootstrap
lab/01-storage-inventory
integration/storage-recovery-v1
integration/scheduler-jcl-jes2
integration/performance-diagnosis-v1
```

Do not create permanent technology branches.

`main` remains the published stable state.

---

# 18. Migration mechanics

When a new repository is created, do not immediately copy every historical lab.

Preferred sequence:

```text
1. Create repository README and roadmap
2. Reference historical labs
3. Add ecosystem integration document
4. Create first new domain-native lab
5. Connect to profile architecture
6. Add cross-repository links
7. Continue future capability development there
```

This provides continuity without destructive migration.

---

# 19. GitHub profile evolution

The profile should show architecture at three levels.

## View 1 — System Architecture

Already exists.

Purpose:

Show how z/OS technologies interact.

## View 2 — Engineering Domains

Architecture V2 addition.

Purpose:

Show how professional engineering work is organized.

## View 3 — Production Tracks

Later addition.

Purpose:

Show how domain capabilities combine into operational workflows.

Do not remove View 1.

The three views explain different dimensions of the same ecosystem.

---

# 20. Recommended domain-map hierarchy

The future profile-level domain map should conceptually resemble:

```text
IBM z/OS Engineering
        |
        +---- Core Platform
        |
        +---- Operations
        |
        +---- Storage / DFSMS
        |
        +---- Workload / Batch
        |
        +---- Software Maintenance
        |
        +---- Performance / Capacity
        |
        +---- Diagnostics
        |
        +---- Sysplex / Availability
        |
        +---- Recovery
        |
        +---- Security
        |
        +---- Communications
        |
        +---- USS
        |
        +---- Application / Data
        |
        +---- Automation
        |
        v
Integration Engineering
        |
        v
Production-Like Workflows
```

Cross-cutting:

```text
Security
Observability
Automation
```

---

# 21. Recommended implementation order

Architecture V2 should be implemented in this order.

## Step 1

Complete and merge Architecture V2 documentation.

## Step 2

Add the Engineering Domains diagram to the GitHub profile without deleting the current diagram.

## Step 3

Normalize the central repository README around Core Platform + Integration responsibilities.

## Step 4

Create `zos-storage-dfsms-engineering`.

## Step 5

Reference historical storage labs from the new repository.

## Step 6

Continue new storage work there.

## Step 7

Grow Performance and Diagnostics roadmaps.

## Step 8

Create those repositories when their gates are met.

## Step 9

Grow SMP/E, Sysplex, and Recovery capability depth.

## Step 10

Build the flagship `end-to-end-production-cycle`.

---

# 22. Immediate decisions

Architecture V2 currently recommends:

## Create when Architecture V2 documentation is merged

No new repository immediately during the documentation branch.

## First repository to create afterwards

`zos-storage-dfsms-engineering`

## Repositories to prepare next

- `zos-performance-capacity-engineering`
- `zos-problem-determination-diagnostics`

## Domains to grow before repository creation

- Software Maintenance / SMP/E
- Sysplex / Availability
- Recovery

## Keep central

`zos-adcd-hercules-engineering-lab`

with a progressively clearer Core Platform + Integration role.

---

# 23. What should not be done

Do not:

- delete historical labs;
- renumber old labs solely for Architecture V2;
- create empty repositories for every diagram box;
- duplicate entire procedures across repositories;
- move labs only for visual cleanliness;
- claim unvalidated capabilities;
- split domains before a useful roadmap exists;
- turn Core into only a directory of links.

Core remains an active engineering system.

---

# 24. Success criteria

Repository evolution is successful when:

- every active repository has a clear responsibility;
- new labs have an obvious home;
- historical labs remain discoverable;
- the central repository no longer grows randomly across unrelated domains;
- domain roadmaps determine future work;
- integration tracks combine capabilities without duplication;
- the profile architecture explains the ecosystem clearly;
- security and observability remain cross-cutting;
- the system can continue growing without another major structural reset.

---

# 25. Target state

The long-term target is:

```text
Specialized domain repositories
           |
           v
Validated capabilities
           |
           v
Core Platform environment
           |
           v
Cross-domain integration
           |
           v
Production Tracks
           |
           v
Observable, recoverable, increasingly automated
z/OS engineering laboratory ecosystem
```

The goal is not to make the GitHub account look larger.

The goal is to make the engineering system more coherent as it grows.

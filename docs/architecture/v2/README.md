# Architecture V2 — Engineering Domains and Operational Lifecycle

## Purpose

Architecture V2 extends the existing z/OS Laboratory Ecosystem Architecture. It does not replace Architecture V1.

Architecture V1 explains how specialized repositories and z/OS components relate to each other. Architecture V2 adds a second organizational layer that classifies engineering work by domain, capability, operational lifecycle, maturity, and integration level.

The objective is to let the laboratory ecosystem grow without turning the core engineering repository into an unstructured collection of unrelated exercises.

## Relationship with Architecture V1

Architecture V1 remains the authoritative component and cross-repository relationship model.

Architecture V2 complements it with an engineering-work model:

```text
Architecture V1
Component and repository relationships
        |
        v
Architecture V2
Engineering domains
        |
        v
Capabilities
        |
        v
Operational lifecycle
        |
        v
Cross-domain integration
        |
        v
Production-like z/OS workflows
```

The two architectures are intentionally complementary:

- **Architecture V1:** How do the technologies and repositories interact?
- **Architecture V2:** How is the engineering work organized and how does each capability mature?

## Core architectural principles

### 1. Preserve validated history

Existing laboratories remain historical evidence of the evolution of the environment. Architecture V2 classifies them; it does not automatically require moving or renumbering them.

A physical migration is justified only when repository boundaries, future development, maintainability, and cross-repository relationships clearly benefit from it.

### 2. Organize engineering by domain

Future work is planned inside explicit engineering domains rather than by selecting the next unrelated command, utility, or subsystem.

Initial domains include:

- Core Platform Engineering
- Operations and Service Management
- Storage and DFSMS Engineering
- Workload and Batch Engineering
- Software Maintenance
- Performance and Capacity Engineering
- Problem Determination and Diagnostics
- Sysplex and Availability Engineering
- Recovery Engineering
- Security Engineering
- Communications Engineering
- UNIX System Services
- Application and Data Engineering
- Automation and Modern Operations
- Integration Engineering

Domain boundaries may evolve as the laboratory gains new capabilities.

### 3. Model capabilities, not only technologies

A technology name is not sufficient to describe engineering progress.

Each domain is decomposed into capabilities. Examples include:

- IPL and initialization
- PARMLIB and PROCLIB management
- JES2 workload execution
- DFSMS/SMS policy management
- SMP/E maintenance
- WLM decision analysis
- RMF performance observation
- SMF collection and analysis
- LOGREC and dump analysis
- XCF/GRS foundations
- backup and restore
- restart and rerun

The roadmap should identify missing capabilities before selecting future laboratories.

### 4. Use a common operational lifecycle

Capabilities mature through a common engineering lifecycle:

```text
Discover
   |
Baseline
   |
Configure
   |
Operate
   |
Observe
   |
Diagnose
   |
Recover
   |
Improve
   |
Automate
   |
Integrate
```

Not every capability must implement every stage, but the lifecycle provides a consistent way to identify gaps and plan progression.

### 5. Separate capability validation from integration proof

**Domain repositories teach and validate capabilities. Integration tracks prove that those capabilities work together. Core Platform provides the common z/OS environment in which those capabilities are integrated.**

A specialized repository should therefore avoid duplicating complete workflows owned by another domain. Cross-domain behavior belongs in explicit integration tracks.

## Cross-cutting engineering planes

Some facilities cannot be assigned cleanly to only one domain.

### Security plane

RACF/SAF affects platform services, JES2, USS, Communications Server, CICS, Db2, storage resources, operational authority, and auditing.

Security is therefore treated as both a specialized domain and a cross-cutting engineering concern.

### Observability plane

SMF, SYSLOG, LOGREC, RMF data, JES/SDSF output, and Health Checker evidence support several domains.

Observability provides evidence for:

- operations
- security auditing
- workload analysis
- performance
- diagnostics
- capacity analysis
- recovery validation

Architecture V2 therefore avoids treating SMF as exclusively a performance facility.

### Automation plane

Automation can span REXX, JCL, scheduling, shell scripting, z/OSMF workflows, REST APIs, and external tooling.

The long-term progression is from repeatable manual operation toward controlled, observable, and recoverable automation.

## Lab classification model

Every existing and future laboratory can be described using the following dimensions:

```text
Historical lab identity
        +
Engineering domain
        +
Capability
        +
Lifecycle stage
        +
Maturity level
        +
Integration level
        +
Dependencies
        +
Evidence
        +
Result
        +
Next capability
```

The historical path remains the stable identifier for existing labs, especially where earlier numbering contains repeated lab numbers or multi-part exercises.

## Integration levels

Architecture V2 distinguishes four integration levels:

1. **Standalone** — validates one focused capability.
2. **Cross-component** — validates interaction between multiple components inside a domain or system.
3. **Cross-repository** — combines capabilities maintained by different specialized repositories.
4. **Production-like** — exercises an operational workflow including execution, observation, controlled failure or exception handling, diagnosis, recovery, and evidence.

## Production tracks

Existing labs can participate in higher-level tracks without being duplicated or physically moved.

The Labs 30–39 sequence in the core engineering repository is treated as the first emerging enterprise batch operations track because it connects batch processing, COBOL, JCL control flow, DFSORT, GDG processing, restart/rerun, JES2 operations, LOGREC/SMF diagnostics, and WLM/SRM analysis.

Future production tracks should reuse validated capabilities from specialized repositories.

## Repository evolution policy

Architecture V2 does not create repositories merely to match a diagram.

A new specialized repository is justified when:

- a domain has sufficient validated or planned capability depth;
- the responsibility boundary is technically clear;
- continued growth inside the core repository would reduce clarity;
- the new repository can maintain its own roadmap;
- integration with other repositories can be expressed without duplication.

Until those conditions are met, a capability may remain in Core Platform while being classified under its future engineering domain.

## Planning rule for future labs

Future lab selection should follow:

```text
Domain roadmap
      +
Capability gap
      +
Lifecycle gap
      +
Integration roadmap
      |
      v
Next laboratory
```

This replaces an exclusively sequential lab-number approach.

Lab numbers remain useful identifiers, but the roadmap determines why a lab exists and what capability it advances.

## Architecture V2 documents

This directory will contain:

- `ENGINEERING-DOMAINS.md` — domain definitions and responsibility boundaries.
- `LAB-TAXONOMY.md` — classification rules for existing and future labs.
- `LAB-MIGRATION-MATRIX.md` — mapping of historical labs to Architecture V2 domains and future homes.
- `OPERATIONAL-MATURITY.md` — lifecycle and maturity model.
- `PRODUCTION-TRACKS.md` — cross-domain and production-like engineering scenarios.
- `REPOSITORY-EVOLUTION.md` — criteria and roadmap for repository specialization.

## Target state

The target is not a larger collection of repositories.

The target is a coherent z/OS engineering system in which:

- repositories have explicit responsibilities;
- labs validate identifiable capabilities;
- operational maturity is measurable;
- security and observability are cross-cutting;
- integration tracks demonstrate system behavior;
- failures and recovery are documented;
- automation is introduced deliberately;
- architecture can evolve without discarding previous work.

Architecture V2 is therefore an evolutionary layer over the existing ecosystem, not a replacement for it.

# Architecture V2 — Operational Maturity Model

## Purpose

This document defines the operational maturity model used by Architecture V2.

The model complements the engineering-domain taxonomy by describing how a capability evolves from initial discovery into repeatable, resilient, automated, and integrated operation.

The goal is not to maximize maturity scores. The goal is to make capability growth explicit, measurable, and aligned with evidence.

---

# 1. Why maturity is separate from lifecycle

Architecture V2 distinguishes:

- **Lifecycle stage** — what kind of engineering activity is being performed.
- **Maturity level** — how developed and operationally reliable the capability has become.

Example:

A WLM lab may be in the `Observe` lifecycle stage while still being only `M1 Foundational`.

A restart/rerun lab may be in the `Recover` lifecycle stage and reach `M3 Resilient`.

Lifecycle and maturity must therefore be recorded independently.

---

# 2. Maturity levels

Architecture V2 defines six maturity levels.

## M0 — Exploratory

The capability is being discovered.

Typical characteristics:

- read-only investigation
- presence validation
- structure discovery
- inventory
- component identification
- limited operational impact
- incomplete dependency knowledge

Typical questions:

- Does the facility exist?
- Where is it configured?
- Which datasets, members, started tasks, or profiles are involved?
- What is active now?

Typical evidence:

- display commands
- dataset/member discovery
- status panels
- configuration inspection
- read-only reports

A capability at M0 should not be described as operationally implemented.

---

## M1 — Foundational

The capability is understood and repeatable at a basic level.

Characteristics:

- clear objective
- repeatable steps
- known inputs
- expected result
- initial evidence
- documented limitations
- basic terminology understood

Typical outcomes:

- baseline established
- configuration understood
- basic capability validated
- execution repeated successfully

Examples:

- WLM environment discovered and documented
- SMP/E CSI inventory captured
- SMS baseline established
- XCF monoplex status documented

---

## M2 — Operational

The capability can be used safely during normal operation.

Characteristics:

- controlled runtime procedure
- operational context
- result interpretation
- return-code or message interpretation
- expected-state validation
- documented prerequisites
- known failure conditions
- repeatable execution

Typical evidence:

- command output
- SDSF
- SYSLOG
- job output
- SMF/RMF data
- subsystem messages
- status transitions

Examples:

- JES2 spool operation
- SMF MAN dataset maintenance
- SDSF system requests
- Health Checker operation
- controlled SMS configuration

---

## M3 — Resilient

The capability explicitly handles failure, rollback, or recovery.

Characteristics:

- controlled failure or exception
- recovery procedure
- rollback procedure
- post-recovery validation
- preservation of service state where possible
- diagnostic evidence
- failure semantics documented

Typical questions:

- What can fail?
- How is the failure recognized?
- What is the safest recovery path?
- What state must be verified afterwards?
- What is the rollback boundary?

Examples:

- ADRDSSU restore with validation
- PARMLIB/PROCLIB rollback
- batch restart/rerun
- service recovery after configuration failure

---

## M4 — Automated

The capability is executed through controlled automation.

Characteristics:

- repeatable automation
- predictable inputs
- validation built into the process
- evidence collection
- failure handling
- idempotency considered where applicable
- rollback/recovery awareness
- human-readable logs

Automation can be implemented through:

- REXX
- JCL
- scheduler workflows
- shell
- z/OSMF workflows
- REST APIs
- external scripting

Automation does not automatically imply maturity.

A script without validation or recovery remains operationally weak.

---

## M5 — Integrated

The capability participates in a realistic cross-domain workflow.

Characteristics:

- multiple components or repositories
- explicit dependencies
- system-level outcome
- observability
- security awareness
- failure/recovery awareness
- end-to-end validation
- documented operational sequence

Typical examples:

```text
Scheduler
  ->
JCL
  ->
JES2
  ->
COBOL
  ->
VSAM / Db2
  ->
SMF
  ->
Diagnosis
  ->
Restart / Rerun
```

M5 represents integrated engineering, not perfection.

---

# 3. Lifecycle stages

Architecture V2 uses ten lifecycle stages.

## Discover

Find the component, configuration, datasets, runtime state, and relationships.

## Baseline

Establish a known starting point.

## Configure

Perform a controlled configuration change.

## Operate

Use the component during normal runtime administration.

## Observe

Collect and interpret runtime evidence.

## Diagnose

Investigate abnormal behavior.

## Recover

Restore a valid state.

## Improve

Change policy, sizing, procedure, or control based on evidence.

## Automate

Convert a validated manual procedure into controlled automation.

## Integrate

Combine the capability with other domains or repositories.

---

# 4. Capability maturity path

A common capability progression is:

```text
M0 Exploratory
     |
     v
M1 Foundational
     |
     v
M2 Operational
     |
     v
M3 Resilient
     |
     v
M4 Automated
     |
     v
M5 Integrated
```

This is not mandatory for every capability.

Some capabilities may stop at M2 because deeper automation is not useful.

Some may reach M5 before M4 because cross-domain integration can be validated manually before automation.

The model is descriptive, not rigidly sequential.

---

# 5. Operational maturity gates

Each maturity transition should satisfy explicit gates.

## M0 -> M1

Required:

- scope understood
- terminology documented
- component discovered
- configuration location known
- basic evidence preserved

## M1 -> M2

Required:

- procedure repeatable
- expected result known
- operational evidence available
- result semantics explained
- normal runtime use validated

## M2 -> M3

Required:

- failure mode identified
- rollback or recovery documented
- post-recovery validation defined
- abnormal state can be recognized

## M3 -> M4

Required:

- manual process is stable
- inputs are controlled
- validation can be automated
- failure handling exists
- automation produces evidence

## M4 -> M5

Required:

- dependencies are explicit
- cross-domain sequence documented
- observability exists
- security implications considered
- failure/recovery behavior understood
- end-to-end outcome validated

---

# 6. Maturity by engineering domain

Different domains mature differently.

## Core Platform

Typical progression:

```text
Discover IPL/PARMLIB structure
        ->
Baseline configuration
        ->
Controlled change
        ->
Runtime validation
        ->
Rollback
        ->
Automated validation
        ->
Cross-domain platform integration
```

## Storage

Typical progression:

```text
Inventory
  ->
DASD / Catalog / SMS baseline
  ->
Policy configuration
  ->
Allocation validation
  ->
Failure/recovery
  ->
Automation
  ->
Application/workload integration
```

## Performance

Typical progression:

```text
Discover WLM/RMF
  ->
Baseline
  ->
Observe workload
  ->
Interpret SMF/RMF
  ->
Diagnose degradation
  ->
Validate improvement
  ->
Automate collection
  ->
Cross-domain performance analysis
```

## Diagnostics

Typical progression:

```text
Message recognition
  ->
LOGREC / SYSLOG baseline
  ->
Dump collection
  ->
IPCS / analysis
  ->
Root-cause workflow
  ->
Recovery handoff
  ->
Automated evidence capture
  ->
Cross-domain incident scenario
```

## Software Maintenance

Typical progression:

```text
CSI discovery
  ->
Zone understanding
  ->
SYSMOD inventory
  ->
RECEIVE
  ->
APPLY CHECK
  ->
APPLY
  ->
ACCEPT CHECK
  ->
ACCEPT
  ->
Failure / recovery
  ->
Maintenance automation
```

---

# 7. Operational evidence requirements

Higher maturity requires stronger evidence.

## M0 evidence

- screenshots
- display commands
- inventory
- configuration references

## M1 evidence

- reproducible commands
- baseline outputs
- expected-state explanation
- limitations

## M2 evidence

- runtime output
- return codes
- system messages
- operational sequence
- result interpretation

## M3 evidence

- failure symptom
- diagnostic evidence
- recovery action
- final-state validation

## M4 evidence

- automation source
- execution log
- validation output
- failure handling
- rollback or recovery path

## M5 evidence

- cross-repository references
- dependency chain
- end-to-end execution
- observability
- failure/recovery
- integrated outcome

---

# 8. Security maturity overlay

Security maturity applies across all capability levels.

A technically successful lab should still consider:

- identity
- authority
- least privilege
- privileged commands
- started-task identity
- dataset/resource access
- auditability
- rollback
- publication security

A capability cannot be considered fully mature if its operation requires unexplained or excessive privilege.

---

# 9. Observability maturity overlay

Observability is required increasingly as maturity grows.

## M0 / M1

Basic command and configuration output may be sufficient.

## M2

Runtime evidence should exist.

## M3

Failure and recovery evidence must exist.

## M4

Automation should emit useful logs and validation results.

## M5

Cross-domain workflows should expose enough evidence to explain system behavior end to end.

Possible sources include:

- SMF
- RMF
- SYSLOG
- LOGREC
- SDSF
- Health Checker
- subsystem messages
- application output
- scheduler history

---

# 10. Failure maturity

Architecture V2 expects mature labs to treat failure as useful engineering evidence.

Failure progression:

```text
Failure ignored
    ->
Failure recognized
    ->
Failure classified
    ->
Failure diagnosed
    ->
Recovery validated
    ->
Recovery automated
    ->
Failure integrated into production-like scenario
```

The target is not to create artificial failures everywhere.

The target is to know how a capability behaves when its expected state is not achieved.

---

# 11. Recovery maturity

Recovery should evolve through:

```text
Documented rollback
        ->
Tested rollback
        ->
Controlled recovery
        ->
Post-recovery validation
        ->
Repeatable recovery procedure
        ->
Automated recovery assistance
        ->
Cross-domain recovery scenario
```

Examples:

- PARMLIB rollback
- ADRDSSU restore
- JES2 workload restart
- scheduler rerun
- TCP/IP configuration rollback
- RACF security rollback

---

# 12. Automation maturity

Automation should follow:

```text
Understand manually
      ->
Repeat manually
      ->
Standardize procedure
      ->
Script safely
      ->
Validate automatically
      ->
Handle failure
      ->
Integrate across domains
```

Automation should not be introduced merely to replace typing.

It should improve:

- repeatability
- consistency
- evidence
- safety
- recovery
- orchestration

---

# 13. Integration maturity

Integration maturity describes how broadly the capability interacts.

## Level A — Isolated component

Single component, local evidence.

## Level B — Same-domain integration

Several related components.

Example:

```text
JES2 spool -> JQE -> SDSF
```

## Level C — Cross-domain integration

Example:

```text
JES2 -> WLM -> SMF
```

## Level D — Cross-repository integration

Example:

```text
Scheduler -> JCL -> JES2 -> COBOL -> VSAM
```

## Level E — Production-like integration

Includes several operational dimensions:

- dependencies
- runtime execution
- observability
- controlled failure
- diagnosis
- recovery
- security
- audit
- performance
- automation

Architecture V2's `I0-I3` integration classification remains the official compact tag. These narrative levels help explain progression.

---

# 14. Capability scorecard

A mature domain may use a capability scorecard.

Example:

| Capability | Discover | Baseline | Configure | Operate | Observe | Diagnose | Recover | Automate | Integrate |
|---|---|---|---|---|---|---|---|---|---|
| WLM | ✓ | ✓ | △ | ✓ | ✓ | △ | — | — | △ |
| SMF | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| SMP/E | ✓ | ✓ | — | — | — | — | — | — | — |

Legend:

- `✓` validated
- `△` partially validated / in progress
- `—` not yet validated

This type of scorecard can later drive roadmap planning automatically.

---

# 15. Maturity and repository creation

A domain should not become a new repository only because it has one high-maturity lab.

Repository specialization should consider:

- number of capabilities
- capability breadth
- maturity distribution
- roadmap independence
- clear ownership
- future growth

Example:

Storage already has several capabilities across M1-M4 and therefore has strong repository justification.

SMP/E currently has important strategic value but still has limited capability breadth, so it remains a domain roadmap before repository creation.

---

# 16. Maturity and Production Tracks

Production Tracks consume capabilities at different maturity levels.

A track should not require every dependency to be M5.

Instead:

- foundational dependencies should be stable enough to use;
- critical operational dependencies should usually be at least M2;
- recovery-critical components should ideally reach M3;
- automation components should be at M4;
- the full track reaches M5 through integration.

This avoids circular logic where everything must already be integrated before integration can begin.

---

# 17. Lab completion and maturity declaration

At lab closure, the README should state:

```text
Lifecycle stage:
Maturity level:
Integration level:
Validation status:
```

Example:

```text
Lifecycle stage: Observe / Diagnose
Maturity level: M2 — Operational
Integration level: I1 — Cross-component
Validation status: VALIDATED
```

The declared maturity should match the evidence actually captured.

---

# 18. Reassessment rule

Maturity can increase later without rewriting history.

Example:

```text
Historical Lab 29
SMP/E CSI inventory
M1 Foundational
```

Later:

```text
New SMP/E labs
RECEIVE / APPLY CHECK / APPLY
M2 Operational
```

The original lab remains M1.

The capability family matures through additional labs.

Architecture V2 therefore measures both:

- individual lab maturity
- domain capability maturity

---

# 19. Roadmap planning rule

The operational maturity model feeds directly into lab planning.

```text
Domain
  +
Capability
  +
Current maturity
  +
Missing lifecycle stage
  +
Integration need
  |
  v
Next lab
```

Example:

```text
Domain: Performance
Capability: WLM
Current maturity: M2
Missing stage: Diagnose
Integration need: JES2 + SMF
        |
        v
Next lab:
Controlled workload variation and WLM decision diagnosis
```

---

# 20. Target operating model

The Architecture V2 target is a laboratory ecosystem where important capabilities can answer:

```text
What is it?
Where is it configured?
How is it baselined?
How is it changed?
How is it operated?
How is it observed?
How does it fail?
How is it diagnosed?
How is it recovered?
How is it automated?
How does it integrate with the rest of z/OS?
```

A capability that can answer these questions with evidence is no longer merely a training exercise.

It is part of a coherent engineering system.

# z/OS Known Good Configuration Baseline

## Purpose

This document defines the **Known Good Configuration Baseline (KGCB)** for the z/OS engineering laboratory.

The baseline is not a claim that the environment represents an IBM-certified production configuration. It is a controlled, evidence-backed description of a system state that has been observed, validated, and accepted for this laboratory.

Its purpose is to make future engineering changes measurable and reversible:

```text
KNOWN GOOD STATE
      |
BASELINE-A
      |
CONTROLLED CHANGE
      |
FUNCTIONAL VALIDATION
      |
HEALTH + OBSERVABILITY
      |
BASELINE-B
      |
DIFF
   /     \
PASS   DEVIATION
 |         |
ACCEPT   DIAGNOSE
           |
     ROLLBACK / RECOVER
```

A successful command or `RC=0000` is not, by itself, sufficient proof that the system remains in a known-good state.

---

## 1. Engineering principles

### 1.1 Baseline before change

A configuration-changing laboratory should identify the relevant pre-change state before modifying the system.

The required baseline is **scope-aware**. A change to SMS does not require reproducing every RACF or TCP/IP artifact, but it must capture the components that can reasonably be affected by that change.

### 1.2 Evidence before maturity

A component is included as validated only when existing laboratory evidence supports the claim.

Unknown, unavailable, or untested states remain explicitly marked as such.

### 1.3 Compare state, not screenshots alone

Screenshots can be evidence, but the engineering object is the **state being demonstrated**.

Where possible, retain reproducible commands, reports, configuration extracts, return codes, and machine-readable metadata in addition to screenshots.

### 1.4 Recovery is part of configuration engineering

A change is stronger when both the desired state and the path back to the previous accepted state are known.

For changes that cannot be safely reversed in the current environment, the limitation must be recorded before execution.

### 1.5 Publication security

The private engineering baseline can contain operational detail required to administer the laboratory. Public GitHub evidence must be sanitized according to the publication rules in this document.

---

## 2. Baseline status model

Each baseline item uses one of these states:

| Status | Meaning |
|---|---|
| `VALIDATED` | State is supported by reproducible evidence. |
| `PARTIALLY VALIDATED` | Some relevant state is proven, but the capability is incomplete. |
| `OBSERVED` | State has been inspected but not sufficiently validated. |
| `PLANNED` | Baseline capture is defined but not yet implemented. |
| `NOT AVAILABLE` | Current environment does not provide the required facility or capability. |
| `NOT APPLICABLE` | Item does not apply to the scoped change. |
| `UNKNOWN` | State has not yet been established. |

`UNKNOWN` must never be silently interpreted as healthy.

---

## 3. Baseline identity

Every formal baseline should identify:

| Field | Required content |
|---|---|
| Baseline ID | Stable identifier, for example `KGB-YYYYMMDD-NN`. |
| Architecture | Engineering Architecture version. |
| Scope | System/domain/capability covered. |
| Capture reason | Initial baseline, pre-change, post-change, recovery, incident, periodic verification. |
| Related lab/change | Historical lab path or change reference. |
| Capture time | Date/time of evidence collection. |
| Evidence location | Repository-relative path. |
| Validation status | One of the baseline statuses above. |
| Previous baseline | Baseline being compared, when applicable. |
| Publication status | Public, sanitized public, or private-only. |

Do not use the baseline identifier as a substitute for the historical laboratory path. Both provide different traceability.

---

## 4. Core Platform baseline

### 4.1 IPL and initialization

Capture the configuration state relevant to system initialization:

- active IPL configuration where safely publishable;
- PARMLIB selection and relevant members;
- initialization-related overrides;
- deviations from the accepted laboratory configuration;
- evidence that the expected system reached its intended operational state.

Existing engineering work provides evidence around IPL/PARMLIB discovery and controlled configuration handling. Future changes should use that evidence as lineage rather than rediscovering the same facts.

**Baseline objective:** know which initialization configuration is expected before a change and detect unintended drift afterwards.

### 4.2 PARMLIB and PROCLIB

For members affected by a change, capture:

- member identity;
- purpose;
- accepted pre-change content or checksum where practical;
- proposed modification;
- activation mechanism;
- rollback source;
- post-change state.

Do not publish host-side filesystem paths used to stage or edit artifacts.

### 4.3 System libraries

For system-library work, establish the relevant state of:

- system libraries under investigation;
- authorized-library relationships where applicable;
- expected concatenation or search relationships;
- controlled modifications and rollback artifacts.

The baseline should distinguish **discovery of a library** from **authorization to change it**.

### 4.4 APF, LNKLST and LPA

When relevant, record:

- expected APF state;
- expected LNKLST state;
- expected LPA-related state;
- intended delta;
- activation or refresh mechanism;
- post-change verification;
- recovery procedure.

A future change must not infer safety merely because a member was successfully edited.

### 4.5 HCD and IODF

Current evidence is primarily discovery/read-only oriented.

For baseline purposes:

- identify the active configuration only to the level needed for engineering validation;
- record relevant device/path relationships in sanitized form;
- avoid publishing unnecessary device or host-identifying details;
- mark unsupported write/change operations explicitly.

**Current posture:** baseline and discovery capability exist; broader controlled I/O reconfiguration remains a future capability.

---

## 5. Operations and Service Management baseline

### 5.1 Started tasks and system tasks

For changes that can affect services, capture:

- expected service/task presence;
- expected operational state;
- dependencies relevant to the change;
- abnormal or unexpected task state;
- restart/recovery requirements where known.

The objective is not to archive every task on every change. Capture the affected service boundary.

### 5.2 Health Checker

IBM Health Checker for z/OS is treated as a **cross-cutting validation mechanism**, not as an isolated laboratory topic.

For applicable changes:

1. capture relevant pre-change health state;
2. execute the controlled change;
3. perform functional validation;
4. capture relevant post-change health state;
5. compare new or changed exceptions;
6. explain accepted deviations.

A clean functional test does not override a newly introduced health exception without analysis.

### 5.3 Console and SYSLOG

For operationally significant changes, retain relevant:

- console messages;
- SYSLOG evidence;
- warnings and errors;
- activation/reconfiguration messages;
- recovery messages.

Do not publish terminal/session identifiers or unrelated operational metadata simply because they appear on screen.

### 5.4 SDSF

SDSF is a principal operational evidence source for:

- job state;
- JES output;
- return codes;
- system/task observations;
- spool evidence;
- failure diagnosis.

Relevant SDSF output should be correlated with the change rather than collected without scope.

---

## 6. Workload and Batch baseline

### 6.1 JES2

For JES2-affecting work, establish the relevant accepted state of:

- JES2 availability;
- spool condition;
- job flow;
- queues/resources affected by the change;
- operational messages;
- expected execution behavior.

Existing JES2/spool/JQE laboratories provide historical evidence for this domain.

### 6.2 Batch execution

For controlled batch changes, baseline:

- expected job/procedure;
- required input state;
- expected steps;
- expected RC/condition behavior;
- expected output artifacts;
- failure/restart point when relevant.

`RC=0000` proves successful completion of a step or job under its defined semantics; it does not independently prove the health of surrounding subsystems.

---

## 7. Storage and DFSMS baseline

Storage is a priority domain for formal baseline control because existing work already spans DASD, catalogs, SMS, ACS, storage pools, backup, restore, and policy evolution.

### 7.1 Volumes and DASD

For scoped storage changes, capture:

- relevant volume state using sanitized identifiers where publication requires it;
- online/offline or availability state where applicable;
- allocation impact;
- affected catalog/SMS relationships;
- recovery dependency.

Avoid publishing host device mappings or other host-side infrastructure details.

### 7.2 Catalog and SMS configuration

Capture the accepted state relevant to:

- catalog behavior;
- SMS status;
- active policy/configuration context;
- affected constructs;
- ACS logic/object state;
- intended policy delta.

Do not assume that successful ACS translation means the policy is active.

### 7.3 Storage Group and Storage Class

Existing historical DFSMS work should be referenced rather than duplicated.

Future baseline records should identify:

- construct used by the test;
- expected routing;
- relevant ACS decision;
- actual result;
- evidence lineage.

### 7.4 Data Class

The current structured Storage/DFSMS work establishes a controlled Data Class positive path.

The known evidence includes:

- Data Class construct foundation;
- Data Class ACS positive-path logic;
- successful translation;
- successful validation;
- controlled positive-path test;
- expected Data Class selection.

The baseline must preserve the distinction between what has been validated and what has not.

**Not yet proven by that work:**

- controlled activation of the new policy;
- real allocation through the newly defined Data Class;
- negative-path Data Class behavior;
- broad workload coverage.

These remain capability gaps, not assumed baseline facts.

### 7.5 Management Class

Current evidence establishes a Management Class foundation, but not the complete Management Class ACS lifecycle.

Until subsequent work proves it, record the capability as partial.

Future evidence should cover:

- ACSMGMT implementation;
- translation;
- validation;
- positive and negative tests;
- integrated Data Class/Management Class behavior;
- activation planning and rollback.

### 7.6 ACS source and objects

For ACS changes:

```text
SOURCE
  |
TRANSLATE
  |
VALIDATE
  |
CONTROLLED TEST
  |
ACTIVATION PLAN
  |
CONTROLLED ACTIVATION
  |
REAL ALLOCATION
  |
POST-CHANGE VALIDATION
```

Each completed stage must be distinguishable in the baseline.

### 7.7 Storage recovery

Where a storage change can affect recoverability, link to the appropriate backup/restore evidence.

A storage policy change with no data-loss risk may not require a full restore test, but the decision must be explicit.

---

## 8. Observability baseline

### 8.1 SMF

SMF is a cross-cutting observability plane.

Existing work demonstrates significant capability around SMF baseline, MAN data sets, extraction/offload, rotation/resilience, archive handling, and use in integrated diagnosis.

For applicable changes determine:

- what operational event should be observable;
- which SMF evidence is relevant;
- whether the required recording path is active;
- where the evidence is retained;
- what other evidence corroborates it.

Do not collect SMF merely to satisfy a documentation checkbox.

### 8.2 Correlated operational evidence

Where appropriate, correlate:

```text
CHANGE
  |
  +-- SMF
  +-- SYSLOG
  +-- SDSF / JES output
  +-- LOGREC
  +-- RMF / WLM evidence
  +-- Health Checker
```

Not every change requires every source.

The baseline must identify which evidence sources are expected for the scoped capability.

---

## 9. Performance and Capacity baseline

### 9.1 WLM

For WLM-related work capture:

- relevant service-definition/policy context;
- active or observed state;
- workload/service-class relationship relevant to the experiment;
- expected behavior;
- observed behavior;
- deviations.

Do not infer enterprise-wide performance health from a single successful workload.

### 9.2 RMF and SRM evidence

Existing work provides WLM/RMF and SRM decision-analysis evidence.

Future performance baselines should evolve toward:

```text
WORKLOAD
  |
RESOURCE / SERVICE OBJECTIVE
  |
MEASUREMENT
  |
OBSERVATION
  |
DIAGNOSIS
  |
CONTROLLED TUNING
  |
RE-MEASUREMENT
```

Capacity engineering remains less mature than the established SMF lifecycle and should not be overstated.

---

## 10. Problem Determination and Diagnostics baseline

### 10.1 LOGREC and dumps

Existing work provides LOGREC/dump foundations and integrated LOGREC/SMF diagnosis.

For diagnostic readiness, baseline:

- whether required diagnostic facilities are available;
- expected evidence source;
- retention/access path;
- known limitations;
- relationship to the affected component.

### 10.2 Diagnostic maturity gap

A complete production-like diagnostic workflow still requires deeper capability in areas such as:

- controlled failure generation;
- ABEND analysis;
- dump acquisition;
- IPCS analysis;
- evidence correlation;
- problem record;
- recovery;
- recurrence prevention.

Until demonstrated, these remain planned capabilities.

---

## 11. Sysplex and Availability baseline

Current laboratory evidence provides foundations around XCF, GRS, System Logger, and monoplex-oriented discovery/baseline work.

For applicable changes capture:

- expected XCF-related state;
- expected GRS-related state;
- relevant System Logger state;
- operational deviations;
- recovery implications.

Do not describe the environment as a fully engineered multi-system Parallel Sysplex unless evidence actually demonstrates that capability.

---

## 12. Recovery baseline

Recovery is a cross-domain engineering requirement.

Existing work provides evidence around:

- ADRDSSU backup;
- controlled restore;
- batch restart/rerun;
- selected configuration rollback practices.

A change should declare one of:

| Recovery state | Meaning |
|---|---|
| `TESTED` | Recovery path has been executed and validated. |
| `DEFINED` | Recovery path is documented but not yet executed. |
| `NOT REQUIRED` | Scoped change has a justified reason not to require rollback/recovery. |
| `NOT AVAILABLE` | Environment cannot currently provide the required recovery path. |
| `UNKNOWN` | Recovery behavior has not been established. |

`UNKNOWN` is a capability gap.

---

## 13. Security baseline

RACF/SAF is a cross-cutting control plane.

For applicable changes establish:

- resource class involved;
- intended authorization boundary;
- whether privileged authority is required;
- relevant audit state;
- expected access before change;
- expected access after change;
- rollback of authorization changes.

Public evidence should minimize exposure of real or reusable identifiers when they add no engineering value.

Security validation should answer both:

```text
SHOULD THIS IDENTITY/ROLE SUCCEED?
SHOULD THIS IDENTITY/ROLE FAIL?
```

Positive authorization alone is not sufficient least-privilege evidence.

---

## 14. UNIX System Services baseline

For USS-related changes capture relevant:

- OMVS operational state;
- filesystem/zFS state;
- mount or service dependencies;
- RACF/identity dependencies;
- TCP/IP dependencies;
- expected POSIX-side behavior;
- recovery requirements.

Future HFS/zFS SMS routing work must be integrated with the Storage/DFSMS baseline rather than implemented as an isolated configuration fact.

---

## 15. Communications baseline

For Communications Server changes capture the service state required to prove the capability, such as:

- required TCP/IP service availability;
- relevant z/OS-side configuration state;
- RACF/SAF dependencies;
- USS dependencies;
- security-policy dependencies;
- observable service behavior.

### Publication boundary

Public repositories must not expose unnecessary:

- host IP addresses;
- MAC addresses;
- host adapter identifiers;
- terminal/session identifiers;
- local routing details;
- credentials;
- private keys;
- tokens;
- connection strings;
- host usernames or identifying local paths.

Use sanitized placeholders or evidence redaction when those values are not essential to the engineering result.

---

## 16. Software Maintenance baseline

Current SMP/E evidence is foundational/discovery oriented.

Before future software-maintenance work, establish:

- CSI discovery/context;
- relevant zones;
- maintenance object/SYSMOD identity;
- prerequisite/HOLDDATA state where applicable;
- target scope;
- pre-change state;
- recovery strategy.

The intended future lifecycle is:

```text
DISCOVER
  |
RECEIVE
  |
CHECK
  |
APPLY
  |
VALIDATE
  |
ACCEPT
  |
REPORT / AUDIT
```

Exact steps must reflect what the current environment actually supports. Unsupported APPLY/ACCEPT scenarios must not be represented as validated.

---

## 17. Automation baseline

Automation is evaluated independently from functional maturity.

For a configuration or operational capability record the current automation level:

| Level | Meaning |
|---|---|
| `A0` | Manual/exploratory. |
| `A1` | Documented and manually repeatable. |
| `A2` | Scripted through JCL, REXX, shell, or equivalent tooling. |
| `A3` | Workflow/API driven. |
| `A4` | Controlled automated pipeline with validation gates. |

Automation must not remove the evidence, validation, or rollback requirements of the underlying change.

---

## 18. Baseline A / Baseline B change protocol

Every significant configuration-changing lab should use this sequence.

### Phase 1 — Scope

Define:

- domain;
- capability;
- reason for change;
- dependencies;
- affected components;
- expected result;
- recovery requirement.

### Phase 2 — Baseline A

Capture the relevant known-good pre-change state.

Questions:

- What is true now?
- What evidence proves it?
- Is the system healthy enough to begin?
- Are there pre-existing exceptions?
- Is rollback possible?

### Phase 3 — Controlled change

Execute only the scoped modification.

Record:

- commands/JCL/procedure used;
- change sequence;
- return codes/messages;
- unexpected deviations.

### Phase 4 — Functional validation

Prove that the intended capability behaves as expected.

Where appropriate include both:

- positive path;
- negative path.

### Phase 5 — Health and observability validation

Inspect the evidence sources appropriate to the change.

Potential sources include:

- Health Checker;
- SMF;
- SYSLOG;
- SDSF/JES;
- LOGREC;
- RMF/WLM;
- component-specific reports.

### Phase 6 — Baseline B

Capture the relevant post-change state using the same engineering dimensions as Baseline A.

### Phase 7 — Diff

Classify differences:

| Difference | Action |
|---|---|
| Intended and validated | Accept. |
| Expected side effect and validated | Document and accept. |
| Unexplained | Diagnose before acceptance. |
| Harmful/unacceptable | Roll back or recover. |
| Unable to determine | Do not promote baseline. |

### Phase 8 — Promotion

Baseline B becomes the new Known Good Configuration only when:

- intended function is validated;
- no unexplained critical deviation remains;
- relevant health/observability checks are acceptable;
- evidence is retained;
- recovery status is known;
- publication review is complete.

---

## 19. Baseline evidence package

A mature baseline/change evidence set should converge toward:

```text
docs/
  engineering-control/
  baselines/

evidence/
  pre-change/
  change/
  post-change/
  recovery/

commands/
source/
tests/
security/
```

Existing historical labs do not need to be physically rewritten to match this layout.

New structured work should adopt the model progressively.

---

## 20. Machine-readable baseline direction

Future structured labs may extend `lab.json` or introduce a baseline manifest with fields such as:

```json
{
  "baseline_id": "KGB-YYYYMMDD-NN",
  "architecture": "v2",
  "domain": "Storage & DFSMS Engineering",
  "capability": "example-capability",
  "capture_reason": "pre-change",
  "status": "VALIDATED",
  "previous_baseline": null,
  "health_check": "captured",
  "observability": ["SMF", "SYSLOG"],
  "recovery": "DEFINED",
  "publication_status": "sanitized-public"
}
```

This is a target model for new work. It does not require retroactive metadata rewrites across all historical laboratories.

---

## 21. Publication classification

Use three publication classes.

### PUBLIC

Suitable for public GitHub when engineering context is preserved:

- generic z/OS concepts;
- sanitized JCL/configuration examples;
- generic product/component names;
- return codes and messages that do not expose sensitive context;
- architecture and capability documentation;
- redacted evidence.

### REVIEW BEFORE PUBLICATION

Inspect before publishing:

- guest system names;
- sysplex names;
- volume/device identifiers;
- data set naming conventions;
- user IDs and job names;
- screenshots;
- console output;
- configuration extracts.

These are not automatically secrets, but they can disclose unnecessary environment structure.

### PRIVATE ONLY

Do not publish:

- credentials or passwords;
- access tokens;
- private keys;
- reusable secrets;
- host IP addresses when identifying;
- MAC addresses;
- host adapter details;
- local host usernames and identifying filesystem paths;
- terminal/session identifiers;
- private connection strings;
- unrelated infrastructure details.

---

## 22. Initial domain baseline posture

This table describes the engineering-control starting point, not a permanent scorecard.

| Domain | Current baseline posture | Main next gap |
|---|---|---|
| Core Platform | Established foundations | Formal Baseline-A/B change records |
| Operations | Established foundations | Make Health Checker a recurring change gate |
| Storage & DFSMS | Strong and actively structured | Negative path, activation, real allocation, Management Class lifecycle |
| Workload & Batch | Strong operational evidence | Broader automated recovery/orchestration |
| Observability | Strong SMF evidence | Standardize per-change observability requirements |
| Performance & Capacity | Partial/growing | Repeatable measurement/tuning/capacity workflow |
| Diagnostics | Partial | Controlled ABEND/dump/IPCS workflow |
| Sysplex & Availability | Foundational | Broader operational/recovery lifecycle |
| Recovery | Significant foundations | Cross-domain recovery exercises |
| Security | Strong dedicated evidence | Standard pre/post authorization gate across domains |
| USS | Established foundations | Deeper cross-domain policy integration |
| Communications | Established foundations | Formal service/security baseline without publishing network-sensitive data |
| Software Maintenance | Foundational | Deliberate SMP/E maintenance lifecycle |
| Automation | Mixed | Progress capabilities from A1 toward controlled A2/A3 |
| Integration | Strong emerging batch track | Full end-to-end production-like change/recovery cycle |

---

## 23. Relationship to the Capability Matrix

The Capability Matrix answers:

> What can this environment currently do, what evidence supports it, and what capability is missing next?

The Known Good Configuration Baseline answers:

> What system state must be known before and after we change that capability?

Together:

```text
CAPABILITY MATRIX
      |
CAPABILITY GAP
      |
KNOWN GOOD BASELINE
      |
CONTROLLED CHANGE
      |
VALIDATION
      |
UPDATED CAPABILITY EVIDENCE
```

Neither document replaces Architecture V2.

Architecture V2 defines the engineering model; the Capability Matrix drives planning; the Known Good Baseline controls state.

---

## 24. Next Engineering Control Plane component

The next control-plane artifact is **Change Management**.

It will formalize:

- change identity;
- why the change exists;
- capability and baseline references;
- risk;
- dependencies;
- implementation plan;
- pre-change checks;
- validation;
- rollback/recovery;
- evidence;
- publication review;
- acceptance.

The resulting control flow will be:

```text
CAPABILITY GAP
      |
KNOWN GOOD BASELINE
      |
CHANGE RECORD
      |
BRANCH / PR
      |
QUALITY GATE
      |
CONTROLLED EXECUTION
      |
VALIDATION
      |
ACCEPT OR RECOVER
      |
CAPABILITY MATRIX UPDATE
```

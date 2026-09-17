# z/OS Engineering Change Management Standard

## Purpose

This document defines the change-management standard for the z/OS engineering laboratory.

Architecture V2 defines how engineering work is organized. The Capability Matrix identifies what is proven and what is missing. The Known Good Configuration Baseline defines the accepted state before and after a change. This standard controls **how a proposed engineering change moves from identified need to accepted system state**.

```text
CAPABILITY GAP
      |
CHANGE RECORD
      |
BASELINE-A
      |
PRE-CHANGE GATES
      |
CONTROLLED IMPLEMENTATION
      |
FUNCTIONAL VALIDATION
      |
HEALTH + OBSERVABILITY
      |
BASELINE-B / DIFF
   /       |        \
ACCEPT  DIAGNOSE   RECOVER
   |
UPDATE ENGINEERING STATE
```

A laboratory exercise that changes system state is therefore treated as an engineering change, not merely as a sequence of commands.

---

## 1. Scope

This standard applies to new work that can change or materially validate z/OS laboratory state, including:

- Core Platform configuration;
- PARMLIB/PROCLIB and system-library work;
- JES2 and workload configuration;
- DFSMS/SMS/ACS changes;
- RACF/SAF authorization changes;
- USS and zFS changes;
- Communications Server changes;
- WLM/performance configuration;
- SMP/E maintenance;
- availability and recovery configuration;
- automation that can modify system state;
- cross-domain production-like integration.

Historical laboratories do not need to be retroactively rewritten. Their validated evidence should be referenced as lineage.

Read-only discovery may use a reduced change record when no persistent state is modified.

---

## 2. Change principles

### 2.1 No change without an engineering reason

A change must originate from at least one of:

- a Capability Matrix gap;
- a lifecycle gap;
- a maturity gap;
- an integration requirement;
- a defect or incident;
- a recovery requirement;
- an identified configuration drift;
- a documented architecture requirement.

“Next lab number” is not an engineering justification.

### 2.2 Baseline before modification

A persistent configuration change must identify the relevant Known Good Configuration before execution.

If the current state is unknown, establishing the baseline becomes part of the work before the modification.

### 2.3 Minimum necessary scope

Change only what is required to prove the target capability.

Unrelated cleanup, optimization, or configuration changes belong in separate change records unless they are inseparable dependencies.

### 2.4 Validation is broader than return code

`RC=0000` can be important evidence, but acceptance may also require:

- functional result;
- negative-path result;
- service health;
- Health Checker state;
- SMF evidence;
- SYSLOG messages;
- SDSF/JES output;
- LOGREC evidence;
- RMF/WLM observations;
- data/state verification;
- recovery verification.

Use only the evidence sources relevant to the scoped change.

### 2.5 Recovery must be considered before execution

Rollback or recovery is designed before a risky change, not after failure.

### 2.6 GitHub controls engineering history

GitHub records the proposal, documentation, configuration artifacts, evidence references, review gates, and accepted history.

GitHub does not replace native z/OS controls such as RACF, JES2, SMP/E, DFSMS, Health Checker, SMF, WLM, or system recovery mechanisms.

---

## 3. Change identity

Each formal change should have a stable identifier.

Recommended format:

```text
CHG-YYYYMMDD-NN
```

Example:

```text
CHG-20260917-01
```

The identifier is independent of the historical lab number/path.

A lab can implement a change, but:

```text
LAB = capability validation unit
CHANGE = controlled modification of system state
```

One lab may contain more than one change only when the changes are tightly coupled and separately traceable.

---

## 4. Change classes

### CLASS 0 — Discovery

Read-only inspection with no intended persistent state modification.

Examples:

- inventory;
- configuration discovery;
- capability-gap analysis;
- read-only reports.

Minimum controls:

- scope;
- commands;
- evidence;
- publication review.

### CLASS 1 — Low-impact controlled change

Localized, reversible change with limited dependency impact.

Examples may include isolated test artifacts or non-active configuration preparation.

Required:

- Baseline-A;
- implementation;
- validation;
- rollback definition;
- publication review.

### CLASS 2 — Operational configuration change

Change can affect an active subsystem, policy, workload, authorization, or service.

Required:

- full change record;
- dependency analysis;
- pre-change health;
- Baseline-A;
- tested or strongly defined recovery;
- functional validation;
- operational evidence;
- Baseline-B;
- diff and acceptance.

### CLASS 3 — High-impact/integration change

Cross-domain or system-significant change where failure can affect multiple capabilities or recovery boundaries.

Required:

- full controls;
- explicit failure modes;
- recovery checkpoint;
- cross-domain validation;
- observability plan;
- rollback/recovery execution criteria;
- post-change review.

The class represents laboratory engineering impact, not an enterprise regulatory classification.

---

## 5. Change states

Use the following lifecycle:

```text
PROPOSED
   |
ASSESSED
   |
READY
   |
IMPLEMENTING
   |
VALIDATING
   |
+--+-------------------+
|                      |
ACCEPTED            FAILED
                       |
                 DIAGNOSING
                       |
                RECOVERED /
                  ROLLED BACK
```

Additional state:

`BLOCKED` — prerequisites, evidence, access, or environment capability prevent safe execution.

A failed change is not erased from history. Failure and recovery are engineering evidence.

---

## 6. Mandatory change record

Every Class 1–3 change should answer these fields.

### Identity

- Change ID
- Title
- Related lab/path
- Git branch
- Architecture version
- Date
- Change class
- Status

### Engineering classification

- Domain
- Capability
- Lifecycle stage
- Maturity before
- Target maturity
- Integration level before
- Target integration level
- Automation level

### Reason

- Capability gap or problem being addressed
- Why the change is required now
- Expected engineering value
- Explicit out-of-scope items

### Dependencies

- Upstream capabilities
- Required services/subsystems
- Security/authority requirements
- Storage/data dependencies
- Recovery dependencies
- Cross-repository evidence

### Baseline

- Baseline-A reference
- Relevant accepted state
- Known pre-existing exceptions
- Health status
- Observability readiness

### Risk

- Failure modes
- Affected components
- Data/state risk
- Security risk
- Availability risk
- Publication risk

### Implementation

- Exact intended change
- Ordered procedure
- Activation mechanism
- Stop conditions
- Expected messages/RCs

### Validation

- Positive-path test
- Negative-path test where applicable
- Functional acceptance criteria
- Health checks
- Observability evidence
- Baseline-B
- Baseline diff

### Recovery

- Rollback/recovery state
- Trigger for recovery
- Recovery procedure
- Recovery validation
- Known limitations

### Closure

- Actual result
- Deviations
- Evidence location
- Publication review
- Capability Matrix impact
- New accepted baseline, if applicable
- Follow-up capability

---

## 7. Pre-change gate

A Class 2 or Class 3 change must not begin until these questions have acceptable answers:

1. What capability gap does this change close?
2. What exactly will change?
3. What will not change?
4. What is the relevant Baseline-A?
5. Is the starting system state sufficiently healthy?
6. What dependencies can be affected?
7. What authority is required?
8. What evidence should the change produce?
9. What constitutes success?
10. What constitutes failure?
11. When must execution stop?
12. How will the previous state be restored?
13. How will recovery itself be validated?
14. Is the evidence safe to publish?

If an answer is unknown and materially affects safety or validation, the change remains `BLOCKED` or returns to discovery.

---

## 8. Risk model

Use a simple engineering model rather than invented numerical precision.

### LOW

- localized;
- non-active or isolated;
- easily reversible;
- limited dependencies;
- no expected service interruption.

### MODERATE

- active configuration or workload behavior;
- multiple dependencies;
- recovery procedure required;
- failure may affect a subsystem or engineering track.

### HIGH

- system-significant;
- cross-domain;
- security/availability/recovery sensitive;
- rollback complexity;
- potential for broad state impact.

Risk level determines control depth; it is not a score of personal competence.

---

## 9. Dependency model

Record dependencies explicitly.

Recommended levels:

- `D0` — standalone/read-only;
- `D1` — single component;
- `D2` — multiple components in one domain;
- `D3` — cross-domain;
- `D4` — cross-repository production-like integration.

Example:

```text
SMS ACS change
  |
  +-- DFSMS configuration
  +-- construct definitions
  +-- test data set
  +-- security authority
  +-- allocation behavior
  +-- evidence / rollback
```

Dependency discovery is part of the change, not an optional documentation step.

---

## 10. Baseline-A

Before implementation capture only the state necessary to prove that the starting point is understood.

For example, a Storage/DFSMS change may require:

- active/accepted SMS context;
- affected constructs;
- current ACS source/object;
- current test behavior;
- relevant health state;
- relevant operational messages;
- rollback source.

It does not automatically require a full-system inventory.

Baseline-A must be referenced in the change record.

---

## 11. Pre-change health and observability

Before active configuration changes, determine whether relevant evidence channels are available.

Potential channels:

- Health Checker;
- SMF;
- SYSLOG;
- SDSF/JES;
- LOGREC;
- RMF/WLM;
- component-specific reports.

The goal is to distinguish:

```text
PRE-EXISTING CONDITION
```

from:

```text
CHANGE-INTRODUCED CONDITION
```

Without a pre-change observation, that distinction may be impossible.

---

## 12. Implementation plan

The implementation plan should be executable and auditable.

For each step record:

| Field | Purpose |
|---|---|
| Step | Ordered sequence |
| Action | What is being done |
| Why | Engineering reason |
| Expected result | Message, state, RC, artifact |
| Stop condition | Condition that prevents continuation |
| Evidence | What will be retained |

Commands should be explained before execution in technical documentation.

Avoid command dumps without context.

---

## 13. Stop conditions

A change must define when not to continue.

Typical stop conditions include:

- unexpected authorization failure;
- unexpected subsystem state;
- unexpected configuration target;
- translation/validation failure;
- unexpected return code;
- newly introduced severe health exception;
- evidence that the wrong resource would be modified;
- missing recovery prerequisite;
- unexplained data/state deviation.

Stopping safely is a successful control behavior, not a failed laboratory.

---

## 14. Functional validation

Validation proves the intended engineering behavior.

### Positive path

Demonstrate that the intended valid case succeeds.

### Negative path

Where meaningful, demonstrate that an invalid, unauthorized, unmatched, or rejected case behaves as designed.

Examples:

- RACF: authorized succeeds / unauthorized fails;
- ACS: matching case selects construct / non-matching case does not;
- JCL: intended RC path / controlled failure path;
- recovery: failure occurs / restart restores expected processing.

A negative path is not mandatory when it would create unnecessary risk or has no engineering meaning. Record the reason.

---

## 15. Health validation

After functional validation, inspect the relevant system health state.

Health Checker should be used when the component/change has applicable checks.

Questions:

- Did a new exception appear?
- Did an existing exception change?
- Is the exception related to the change?
- Is it acceptable in this laboratory?
- Is further diagnosis required?

Do not claim universal system health based on a limited check scope.

---

## 16. Observability validation

A change should produce or correlate operational evidence where appropriate.

```text
CHANGE
  |
  +-- Functional result
  +-- SMF
  +-- SYSLOG
  +-- SDSF / JES
  +-- LOGREC
  +-- RMF / WLM
  +-- Health Checker
```

The evidence plan must remain scope-aware.

A DFSMS ACS test and a WLM performance experiment do not require identical evidence.

---

## 17. Baseline-B

After implementation and validation, capture the same relevant dimensions used in Baseline-A.

Baseline-B should make the intended delta visible.

Example:

```text
BASELINE-A
  ACS source A
  expected routing A
  health state A

CHANGE
  controlled ACS modification

BASELINE-B
  ACS source B
  expected routing B
  health state B
```

The comparison is more valuable than two unrelated screenshot collections.

---

## 18. Baseline diff

Classify every material difference as:

- `INTENDED`;
- `EXPECTED SIDE EFFECT`;
- `UNEXPLAINED`;
- `UNACCEPTABLE`;
- `NOT DETERMINED`.

Acceptance rules:

- intended + validated → accept;
- expected side effect + understood → document and accept;
- unexplained → diagnose;
- unacceptable → recover/rollback;
- not determined → do not promote Baseline-B.

---

## 19. Recovery and rollback

Recovery status uses the KGCB model:

- `TESTED`;
- `DEFINED`;
- `NOT REQUIRED`;
- `NOT AVAILABLE`;
- `UNKNOWN`.

### Recovery triggers

Examples:

- functional acceptance fails;
- critical health regression;
- data/state inconsistency;
- service cannot return to expected state;
- unexpected authorization exposure;
- configuration activation affects unintended resources.

### Recovery validation

Do not stop at “rollback command completed.”

Prove:

```text
RECOVERY ACTION
      |
EXPECTED CONFIGURATION RESTORED
      |
FUNCTIONAL STATE RESTORED
      |
HEALTH / OBSERVABILITY CHECKED
      |
BASELINE COMPARISON
```

---

## 20. Failure and incident transition

A failed change can become an incident/problem-determination exercise.

Use this boundary:

```text
EXPECTED TEST FAILURE
        |
   LAB EVIDENCE

UNEXPECTED CHANGE FAILURE
        |
     INCIDENT
        |
    DIAGNOSIS
        |
    RECOVERY
        |
  PROBLEM REVIEW
```

Do not hide unexpected failure by editing the final README as though the first execution succeeded.

The failed path may be more valuable evidence than the successful retry.

---

## 21. Security change controls

For RACF/SAF or security-sensitive changes additionally record:

- affected resource class;
- profile/resource scope;
- authority before;
- authority after;
- test identity/role model;
- positive access test;
- negative access test where safe;
- audit implications;
- rollback of permissions;
- publication sanitization.

Least privilege requires proving the boundary, not only proving successful access.

---

## 22. Storage/DFSMS change controls

For SMS/ACS work additionally distinguish:

```text
DEFINE
  |
TRANSLATE
  |
VALIDATE
  |
TEST
  |
ACTIVATION PLAN
  |
ACTIVATE
  |
REAL ALLOCATION
  |
OBSERVE
  |
RECOVER
```

Do not collapse these stages into “SMS configured.”

For the current Storage capability line, historical evidence and STOR-007 should be referenced rather than recreated.

Future work should continue from the next unproven capability.

---

## 23. SMP/E change controls

Software maintenance requires especially strict separation of stages.

Future SMP/E changes should identify:

- CSI/zone context;
- maintenance object/SYSMOD;
- prerequisite state;
- HOLDDATA considerations where applicable;
- RECEIVE state;
- CHECK result;
- APPLY scope;
- validation;
- ACCEPT decision;
- recovery implications.

Only stages actually executed in the environment may be marked validated.

---

## 24. Automation change controls

Automation that modifies z/OS state is itself a change capability.

Progression:

```text
A0 Manual
 |
A1 Documented repeatability
 |
A2 JCL / REXX / shell
 |
A3 Workflow / API
 |
A4 Controlled pipeline
```

Automation must preserve:

- scope;
- authorization;
- validation;
- evidence;
- stop conditions;
- recovery;
- auditability.

Faster execution is not higher engineering maturity if controls disappear.

---

## 25. Git branch relationship

Recommended lifecycle:

```text
main
 |
 +-- lab/<number>-<slug>
 |
 +-- integration/<slug>
 |
 +-- docs/<slug>
 |
 +-- fix/<slug>
```

Persistent development should not occur directly on `main`.

The branch should represent a coherent engineering change or documentation unit.

After validation:

```text
BRANCH
  |
PULL REQUEST
  |
QUALITY GATE
  |
REVIEW / SELF-REVIEW
  |
MERGE
  |
DELETE SHORT-LIVED BRANCH
```

For a solo engineering portfolio, controls should provide traceability without inventing an unnecessary human approval bureaucracy.

---

## 26. Pull Request relationship

The Pull Request is the GitHub-side change envelope.

It should summarize:

- why;
- domain/capability;
- change ID;
- baseline;
- risk;
- implementation;
- validation;
- recovery;
- evidence;
- publication review;
- resulting engineering state.

The detailed lab/change documentation remains the source of engineering evidence.

The PR should make the decision to merge understandable without reproducing hundreds of lines of documentation.

---

## 27. Publication security gate

Before committing or merging public evidence, check for:

- credentials;
- passwords;
- access tokens;
- private keys;
- reusable secrets;
- host usernames;
- identifying local filesystem paths;
- host IP addresses where identifying;
- MAC addresses;
- host adapter identifiers;
- terminal/session identifiers;
- private connection strings;
- unrelated infrastructure details.

Also review context-sensitive guest metadata:

- system names;
- sysplex names;
- volume IDs;
- device IDs;
- data set names;
- user IDs;
- job names;
- screenshots.

Context-sensitive metadata may be publishable when it adds engineering value, but it must be deliberately reviewed.

---

## 28. Change evidence layout

New structured changes should converge toward:

```text
docs/
  change-record.md
  engineering-notes.md
  validation.md
  recovery.md

evidence/
  pre-change/
  implementation/
  post-change/
  recovery/

commands/
source/
tests/
security/
```

Do not migrate historical labs solely to satisfy this directory model.

---

## 29. Change record template

Use this compact template for future changes:

```markdown
# CHG-YYYYMMDD-NN — Change title

## Classification
- Domain:
- Capability:
- Lifecycle:
- Change class:
- Risk:
- Dependency level:
- Maturity before:
- Target maturity:
- Integration before:
- Target integration:
- Automation:

## Reason
- Capability gap:
- Why now:
- Out of scope:

## Baseline-A
- Baseline reference:
- Starting state:
- Pre-existing exceptions:
- Health/observability:

## Dependencies
- Components:
- Security:
- Data/storage:
- Recovery:
- Cross-repository evidence:

## Implementation
1. ...
2. ...
3. ...

## Stop conditions
- ...

## Expected result
- ...

## Validation
- Positive path:
- Negative path:
- Health:
- Observability:
- Baseline-B:
- Diff:

## Recovery
- Status:
- Trigger:
- Procedure:
- Validation:

## Result
- Actual result:
- Deviations:
- Evidence:
- Publication review:
- Baseline promoted:
- Capability Matrix update:
- Next capability:
```

---

## 30. Change acceptance gate

A Class 2 or Class 3 change can be accepted only when:

- the engineering reason remains valid;
- implementation stayed within scope or deviations are documented;
- functional acceptance criteria passed;
- relevant negative-path behavior is known;
- no unexplained critical health regression remains;
- required observability evidence is captured;
- Baseline-B is compared with Baseline-A;
- recovery state is known;
- evidence is retained;
- publication review is complete;
- resulting capability state is recorded.

If these conditions are not satisfied, the change remains in diagnosis, recovery, blocked, or failed state.

---

## 31. Change closure

Closure records what actually happened, not what was planned.

Record:

- final status;
- actual commands/procedure;
- actual RC/messages;
- successful and failed attempts;
- deviations;
- recovery actions;
- final accepted state;
- evidence paths;
- resulting capability;
- remaining gap.

A clean final narrative must not erase troubleshooting history that materially explains the engineering result.

---

## 32. Capability Matrix update

After an accepted change ask:

1. Did the capability materially improve?
2. Did lifecycle coverage increase?
3. Did maturity increase?
4. Did integration increase?
5. Did automation increase?
6. Was recovery tested?
7. Was configuration versioned?
8. Is the evidence sufficient to justify promotion?

Only update maturity/integration when evidence supports it.

A new lab does not automatically increase maturity.

---

## 33. Example — Storage/DFSMS continuation

Current evidence establishes a Data Class positive path and Management Class foundation without active-policy proof.

A valid next change should therefore begin from that state rather than recreating it.

Example progression:

```text
EXISTING EVIDENCE
STOR-007 positive path
        |
CAPABILITY GAP
Data Class negative path
        |
CHANGE RECORD
        |
BASELINE-A
existing source/object/test state
        |
IMPLEMENT DCTEST2
        |
VALIDATE NON-MATCHING BEHAVIOR
        |
HEALTH / EVIDENCE
        |
BASELINE-B
        |
ACCEPT
        |
NEXT GAP
broader coverage / ACSMGMT
```

This is the intended difference between Architecture V2 engineering and topic-by-topic lab accumulation.

---

## 34. Example — SMP/E future work

Current SMP/E evidence is foundational.

Do not jump directly to an arbitrary APPLY exercise.

A controlled sequence should grow the capability deliberately:

```text
CSI DISCOVERY
   |
ZONE UNDERSTANDING
   |
SYSMOD ANATOMY
   |
HOLDDATA / PREREQUISITES
   |
RECEIVE
   |
APPLY CHECK
   |
CONTROLLED APPLY
   |
VALIDATION
   |
ACCEPT CHECK / ACCEPT
   |
REPORTING / RECOVERY / AUTOMATION
```

Each stage becomes a change only when the environment and previous evidence justify it.

---

## 35. Example — Integrated batch change

For Production Track 01, a future cross-domain change might involve:

```text
Scheduler
   |
JCL / JES2
   |
COBOL
   |
VSAM / Db2
   |
SMF / SDSF
   |
controlled failure
   |
diagnosis
   |
restart / recovery
```

This should normally be Class 3 because the evidence boundary spans multiple domains and repositories.

The change record should reference existing component capabilities instead of duplicating their foundational labs.

---

## 36. Change review questions

Before closure, answer:

- What did we intend to change?
- What actually changed?
- What evidence proves it?
- What else changed unexpectedly?
- Did the system remain healthy in the relevant scope?
- Could we detect the change operationally?
- Could we recover?
- What did failure teach us?
- Is Baseline-B acceptable?
- What capability is now proven?
- What remains unproven?
- What is the next justified engineering action?

These questions should drive the README conclusion and PR summary.

---

## 37. Relationship to Incident and Recovery records

Change Management controls planned modification.

The later Incident/Recovery model will control unexpected operational deviation.

```text
PLANNED MODIFICATION
      |
CHANGE MANAGEMENT

UNEXPECTED DEVIATION
      |
INCIDENT / DIAGNOSIS
      |
RECOVERY
      |
PROBLEM REVIEW
```

A change can transition into an incident when its behavior departs materially from the planned failure envelope.

---

## 38. Relationship to GitHub Quality Gate

The future automated quality gate should verify what can be checked safely and deterministically, such as:

- whitespace;
- required structured files;
- metadata presence;
- documentation structure;
- obvious local host paths;
- MAC-address patterns;
- private-key headers;
- obvious credential/token patterns;
- publication-control files;
- broken or missing required references where practical.

Automation must not pretend to judge technical z/OS correctness that requires system evidence.

Human engineering interpretation remains necessary for:

- system health;
- operational meaning;
- risk acceptance;
- recovery adequacy;
- capability promotion.

---

## 39. Engineering Control Plane state after this standard

With this document, the control plane becomes:

```text
ARCHITECTURE V2
      |
CAPABILITY MATRIX
      |
KNOWN GOOD BASELINE
      |
CHANGE MANAGEMENT
      |
GITHUB PR STANDARD
      |
AUTOMATED QUALITY GATE
      |
INCIDENT / RECOVERY MODEL
```

The next component is the GitHub Pull Request and issue/change interface that will encode these controls into the repository workflow.

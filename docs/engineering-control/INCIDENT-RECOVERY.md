# z/OS Incident, Diagnosis, Recovery and Problem Review Standard

## Purpose

This document defines how the z/OS engineering laboratory handles an **unexpected operational deviation** after or outside a planned change.

Change Management controls intended modification. This standard controls what happens when observed system behavior no longer matches the expected state.

```text
EXPECTED STATE
      |
UNEXPECTED DEVIATION
      |
DETECT
      |
CONTAIN
      |
COLLECT EVIDENCE
      |
DIAGNOSE
      |
RECOVER / ROLLBACK
      |
VALIDATE RESTORATION
      |
COMPARE WITH KGCB
      |
PROBLEM REVIEW
      |
IMPROVE BASELINE / PROCEDURE / AUTOMATION
      |
CAPABILITY MATRIX
```

The objective is not to imitate an enterprise ticketing process for appearance. The objective is to build repeatable operational behavior: preserve evidence, understand failure, restore service/state, and prevent recurrence.

---

## 1. Scope

This standard applies when an unexpected condition materially affects or may affect:

- system initialization or Core Platform state;
- started tasks or system services;
- JES2 or batch execution;
- storage, catalogs, SMS, ACS, DASD, backup or restore;
- RACF/SAF authorization;
- USS or zFS;
- Communications Server;
- SMF or operational evidence;
- WLM/performance behavior;
- XCF, GRS, System Logger or availability;
- SMP/E maintenance;
- application/data integration;
- automated workflows;
- cross-domain production-like tracks.

It also applies when a planned change exceeds its documented failure envelope and becomes an operational problem.

---

## 2. Incident versus expected test failure

Not every failure is an incident.

### Expected test failure

A deliberately designed negative path is laboratory evidence.

Examples:

- unauthorized RACF access is denied;
- an ACS non-match behaves as designed;
- a controlled batch step fails to test restart;
- invalid input is rejected.

### Unexpected deviation

An incident begins when actual behavior materially departs from the expected state.

Examples:

- an unrelated service becomes unavailable;
- a change affects an unintended resource;
- expected rollback does not restore state;
- an unexplained ABEND occurs;
- a new severe health exception appears;
- expected SMF/operational evidence disappears;
- data/state differs from the accepted baseline.

```text
DESIGNED FAILURE
     |
VALIDATION EVIDENCE

UNEXPECTED FAILURE
     |
INCIDENT CONTROL
```

---

## 3. Core principles

### 3.1 Preserve the first failure

Do not immediately overwrite the failing state if evidence can be collected safely.

Capture the messages, RC/ABEND, job output, relevant system state, and timeline before retrying when practical.

### 3.2 Facts before hypotheses

Separate:

```text
OBSERVED
```

from:

```text
SUSPECTED CAUSE
```

A hypothesis may guide diagnosis, but it must not be written as established root cause without evidence.

### 3.3 Contain before optimizing

The first objective is to prevent unnecessary additional impact.

Do not combine incident recovery with unrelated tuning, cleanup, or architecture improvement.

### 3.4 Recovery before root-cause perfection when appropriate

Restoring a known-good state can take priority over completing root-cause analysis when continued abnormal state increases risk.

The unresolved cause then remains a Problem Review item.

### 3.5 Evidence is cross-cutting

Use the evidence sources that fit the incident:

- SDSF/JES;
- SYSLOG/console;
- SMF;
- LOGREC;
- dumps/IPCS;
- Health Checker;
- RMF/WLM;
- component-specific reports;
- configuration/baseline diff.

Do not collect every source mechanically.

---

## 4. Incident identity

Recommended identifier:

```text
INC-YYYYMMDD-NN
```

Record:

- Incident ID
- Related change/lab
- Detection time
- Affected domain/capability
- Initial symptom
- Expected state
- Current status
- Evidence location
- Recovery status
- Problem Review status

---

## 5. Incident states

Use:

```text
DETECTED
   |
CONTAINING
   |
DIAGNOSING
   |
RECOVERING
   |
VALIDATING
   |
+--+----------------+
|                   |
RESOLVED          BLOCKED
|
PROBLEM REVIEW
|
CLOSED
```

`RESOLVED` means the required service/state has been restored and validated.

`CLOSED` means the incident record and required follow-up have been completed.

Resolution and root-cause completion are not necessarily the same moment.

---

## 6. Severity model

Use a laboratory engineering severity model.

### SEV-4 — Minor

Localized deviation with little operational effect and straightforward recovery.

### SEV-3 — Significant

Capability or workload affected; diagnosis/recovery required; limited scope.

### SEV-2 — Major

Subsystem or cross-domain operation materially affected; recovery is operationally important.

### SEV-1 — Critical laboratory state

Broad system state, recoverability, security boundary, or major availability is at risk.

Severity is based on observed impact, not on how difficult the problem feels.

---

## 7. Detection sources

An incident may be detected through:

- console/SYSLOG message;
- SDSF/JES output;
- unexpected RC;
- ABEND;
- Health Checker exception;
- SMF evidence;
- LOGREC;
- RMF/WLM observation;
- failed allocation;
- RACF authorization behavior;
- USS/service failure;
- TCP/IP/service behavior;
- configuration comparison;
- failed recovery;
- application/data validation.

Record **how the deviation was first detected**.

This later helps assess observability maturity.

---

## 8. Immediate containment

Containment limits additional impact while preserving diagnostic value.

Possible actions include:

- stop further change execution;
- hold a dependent workload;
- avoid activating additional configuration;
- preserve current output/evidence;
- isolate the test resource;
- revert an unsafe authorization exposure;
- prevent repeated failing automation;
- stop retries that could overwrite evidence.

Containment must remain proportional to the incident.

Do not stop unrelated services without evidence that doing so is necessary.

---

## 9. Evidence collection order

A useful default sequence is:

```text
1. TIME / SYMPTOM
2. JOB / TASK / COMPONENT
3. MESSAGE / RC / ABEND
4. CURRENT STATE
5. RECENT CHANGE
6. RELEVANT SYSTEM EVIDENCE
7. BASELINE COMPARISON
```

The exact order may change when immediate recovery is required.

---

## 10. SDSF and JES evidence

Use SDSF/JES when the problem involves jobs, started tasks, spool, batch execution, or JES-managed output.

Potential evidence:

- JOBID;
- job/step status;
- return codes;
- ABEND;
- JES messages;
- SYSOUT;
- execution sequence;
- held/output state;
- restart point.

Public evidence should sanitize unnecessary user/job/session context where appropriate.

---

## 11. SYSLOG and console evidence

SYSLOG/console can establish:

- system message sequence;
- service start/stop state;
- configuration activation;
- warnings;
- failures;
- recovery messages;
- timing relationship between events.

Capture enough surrounding context to understand sequence without publishing unrelated operational detail.

---

## 12. SMF evidence

SMF is an observability plane, not merely a standalone lab topic.

For an incident ask:

- Is there an SMF record relevant to the event?
- Was recording active?
- Can the event be correlated with job/service/configuration evidence?
- Does SMF show a state change or operational decision?
- Is absence of expected evidence itself meaningful?

Existing SMF lifecycle work provides a strong base for future incident correlation.

---

## 13. LOGREC evidence

LOGREC is relevant when hardware/software error recording contributes to diagnosis.

Use it to correlate recorded errors with:

- time;
- component;
- system event;
- other diagnostic sources.

Do not treat every LOGREC entry as causal merely because its timestamp is nearby.

Correlation requires engineering interpretation.

---

## 14. Dumps and IPCS

Dump/IPCS capability is a major future maturity area.

When a failure produces or requires a dump, record:

- why the dump is relevant;
- what type/source of dump exists;
- capture status;
- retention/access status;
- analysis status;
- limitations of the current environment.

Do not claim IPCS diagnosis until IPCS analysis has actually been performed and evidenced.

Future diagnostic labs should deliberately develop:

```text
CONTROLLED FAILURE
      |
DUMP CAPTURE
      |
IPCS ENTRY
      |
SYMPTOM / CONTROL BLOCK ANALYSIS
      |
CORRELATION
      |
ROOT CAUSE
```

---

## 15. Health Checker evidence

Health Checker can identify configuration or operational exceptions before and after an incident.

Use it to ask:

- Was the exception present before the event?
- Did it appear after the change?
- Did recovery remove it?
- Is the check relevant to the affected component?
- Is the exception accepted or unresolved?

A Health Checker exception is evidence requiring interpretation, not automatic proof of root cause.

---

## 16. RMF and WLM evidence

For performance/workload incidents use RMF/WLM evidence where applicable.

Questions:

- Did workload behavior change?
- Was resource pressure observed?
- Did WLM/SRM behavior contribute to the symptom?
- Is the observation a cause, consequence, or unrelated condition?
- Does behavior return to the accepted state after recovery?

Do not infer capacity conclusions from a single short observation without sufficient measurement.

---

## 17. Security evidence

For RACF/SAF-related incidents capture:

- affected resource/class;
- expected authority;
- observed authority;
- relevant audit evidence;
- whether access was incorrectly allowed or denied;
- scope of exposure;
- containment;
- rollback/recovery;
- post-recovery positive/negative tests.

Never publish credentials or reusable secrets as evidence.

---

## 18. Storage and DFSMS evidence

For storage incidents consider:

- allocation result;
- catalog behavior;
- SMS construct selection;
- ACS decision;
- volume/storage state;
- relevant messages;
- active versus prepared configuration;
- data integrity;
- backup/recovery dependency.

For ACS problems distinguish carefully:

```text
SOURCE ERROR
TRANSLATION ERROR
VALIDATION ERROR
TEST ERROR
ACTIVATION ERROR
ALLOCATION ERROR
POLICY LOGIC ERROR
```

These are different failure stages.

---

## 19. USS and Communications evidence

For USS/Communications incidents consider:

- service/task state;
- OMVS/zFS dependency;
- RACF/identity dependency;
- TCP/IP-side state;
- relevant z/OS messages;
- application/service behavior;
- configuration delta.

Public evidence must not expose identifying host network details, MAC addresses, host adapters, local routes, credentials, or private connection data.

---

## 20. SMP/E maintenance incidents

Future SMP/E incident diagnosis should identify the exact maintenance stage:

```text
RECEIVE
CHECK
APPLY
VALIDATE
ACCEPT
```

Record:

- CSI/zone context;
- SYSMOD involved;
- prerequisite/HOLD condition;
- messages/RC;
- partial state;
- recovery implications.

Do not jump to corrective APPLY/ACCEPT actions without understanding current SMP/E state.

---

## 21. Timeline

Every significant incident should build a simple factual timeline.

Example:

| Time | Event | Evidence | Interpretation |
|---|---|---|---|
| T0 | Baseline accepted | baseline reference | known-good state |
| T1 | Change executed | command/job | planned action |
| T2 | Unexpected message | SYSLOG/SDSF | incident detected |
| T3 | Work stopped | incident record | containment |
| T4 | Evidence collected | evidence paths | diagnosis begins |
| T5 | Recovery executed | recovery evidence | restoration attempt |
| T6 | Validation passes | tests/health | service restored |

Use real timestamps in actual records when they add diagnostic value.

---

## 22. Diagnostic hypothesis model

For each hypothesis record:

| Field | Meaning |
|---|---|
| Hypothesis | Possible cause |
| Supporting evidence | Facts consistent with it |
| Contradicting evidence | Facts inconsistent with it |
| Test | Safe way to evaluate it |
| Result | Supported / rejected / unresolved |

This prevents troubleshooting from becoming random command execution.

---

## 23. Diagnostic loop

Use:

```text
OBSERVE
   |
HYPOTHESIS
   |
SAFE TEST
   |
NEW EVIDENCE
   |
+--+-----------+
|              |
SUPPORTED    REJECTED
|              |
NARROW       NEXT
CAUSE        HYPOTHESIS
```

Each diagnostic action should answer a question.

If a command cannot change the diagnosis or recovery decision, question why it is being run.

---

## 24. Root cause

Use `ROOT CAUSE CONFIRMED` only when evidence supports the causal explanation.

Otherwise use:

- probable cause;
- contributing factor;
- unresolved;
- environment limitation.

Do not convert temporal correlation into causation.

---

## 25. Recovery decision

Recovery may use:

- configuration rollback;
- dataset/object restoration;
- service restart;
- job restart/rerun;
- authorization rollback;
- policy restoration;
- backup/restore;
- return to previous known configuration.

Choose the smallest safe action that can restore the required state.

---

## 26. Recovery execution

Before recovery record:

- target state;
- recovery method;
- prerequisites;
- expected result;
- stop conditions;
- validation method.

During recovery record:

- actual actions;
- messages/RC;
- deviations;
- evidence.

Recovery is itself controlled engineering work.

---

## 27. Recovery validation

A successful recovery command is not enough.

Validate:

```text
CONFIGURATION
     +
FUNCTION
     +
HEALTH
     +
OBSERVABILITY
     +
DATA / STATE
     =
RESTORED ACCEPTED STATE
```

Only the dimensions relevant to the incident are required.

---

## 28. KGCB comparison

After recovery compare the restored state with the relevant Known Good Configuration Baseline.

Classify differences:

- restored exactly;
- restored functionally with understood difference;
- residual deviation;
- unable to determine.

A residual unexplained deviation prevents full closure.

---

## 29. Incident resolution

An incident can be marked `RESOLVED` when:

- required function/state is restored;
- relevant health is acceptable;
- critical unexplained impact is absent;
- evidence is retained;
- recovery result is known;
- remaining investigation is explicitly tracked.

---

## 30. Problem Review

Problem Review asks why the incident could occur and how recurrence can be reduced.

It is not blame assignment.

Review:

- technical cause;
- contributing conditions;
- detection quality;
- containment quality;
- evidence gaps;
- recovery quality;
- baseline gaps;
- documentation gaps;
- automation opportunities;
- architecture implications.

---

## 31. Corrective action types

Classify follow-up as:

### BASELINE

Known Good state was incomplete or outdated.

### PROCEDURE

Execution or recovery procedure needs correction.

### CONFIGURATION

Accepted system configuration requires deliberate change.

### OBSERVABILITY

Failure was difficult to detect or correlate.

### DIAGNOSTICS

Required evidence/tooling was unavailable or insufficient.

### RECOVERY

Recovery was incomplete, untested, or too slow/manual.

### SECURITY

Authorization/audit boundary needs correction.

### AUTOMATION

Repeatable control should be scripted/workflow-driven.

### ARCHITECTURE

Repository/domain/integration design needs adjustment.

---

## 32. Recurrence prevention

A Problem Review should produce concrete engineering action.

Weak:

```text
Be more careful next time.
```

Strong:

```text
Add pre-change ACS validation to the change gate.
```

or:

```text
Capture relevant Health Checker state in Baseline-A and Baseline-B.
```

or:

```text
Create an IPCS capability lab because dump analysis was blocked by missing diagnostic capability.
```

---

## 33. Capability Matrix feedback

An incident can reveal that a capability was less mature than previously assumed.

After closure ask:

- Was the capability truly repeatable?
- Was observability sufficient?
- Was recovery tested?
- Was diagnosis possible?
- Was automation safe?
- Was integration understood?

The Capability Matrix may be promoted, left unchanged, or **downgraded** when evidence justifies it.

Maturity is evidence-driven, not monotonic.

---

## 34. Incident record template

```markdown
# INC-YYYYMMDD-NN — Incident title

## Identity
- Related change/lab:
- Domain:
- Capability:
- Severity:
- Detection time:
- Status:

## Expected state
- KGCB reference:
- Expected behavior:

## Observed deviation
- Symptom:
- First detection source:
- Impact:

## Containment
- Actions:
- Result:

## Evidence
- SDSF/JES:
- SYSLOG/console:
- SMF:
- LOGREC:
- Dump/IPCS:
- Health Checker:
- RMF/WLM:
- Component-specific:
- Baseline/configuration diff:

## Timeline
| Time | Event | Evidence | Interpretation |
|---|---|---|---|

## Hypotheses
### Hypothesis 1
- Supporting evidence:
- Contradicting evidence:
- Test:
- Result:

## Cause
- Status: confirmed / probable / unresolved
- Cause:
- Contributing factors:

## Recovery
- Target state:
- Method:
- Actions:
- Result:
- Validation:
- KGCB comparison:

## Resolution
- Service/state restored:
- Residual deviations:
- Evidence retained:

## Problem Review
- Baseline gap:
- Procedure gap:
- Observability gap:
- Diagnostic gap:
- Recovery gap:
- Automation opportunity:
- Corrective actions:

## Engineering impact
- Capability Matrix change:
- New lab/change required:
- Next capability:
- Publication review:
```

---

## 35. Evidence directory direction

New incident-capable structured work should converge toward:

```text
evidence/
  incident/
    detection/
    diagnosis/
    recovery/
    post-recovery/

docs/
  incident-record.md
  problem-review.md
```

Historical labs do not need retroactive restructuring.

---

## 36. Publication security

Incident evidence often contains more operational detail than normal lab documentation.

Before public publication review:

- credentials/passwords;
- access tokens;
- private keys;
- reusable secrets;
- host usernames;
- local host filesystem paths;
- identifying IP/MAC information;
- adapter/routing details;
- terminal/session identifiers;
- connection strings;
- guest system/sysplex names;
- volume/device identifiers;
- user/job names;
- raw screenshots and dumps.

Full dumps should not be published merely to prove that a dump existed.

Publish the minimum evidence necessary to demonstrate the engineering result.

---

## 37. Failure taxonomy

Use a simple taxonomy to support future analysis:

- `F0` — documentation/procedure;
- `F1` — syntax/input;
- `F2` — authorization/security;
- `F3` — configuration/state;
- `F4` — workload/application;
- `F5` — resource/performance;
- `F6` — infrastructure/service;
- `F7` — recovery/availability.

Multiple classifications may apply when evidence supports them.

---

## 38. Relationship to Change Management

```text
CHANGE
  |
EXPECTED RESULT
  |
+--------------------+
|                    |
PASS             UNEXPECTED
|                    |
ACCEPT             INCIDENT
                     |
                  DIAGNOSE
                     |
                  RECOVER
                     |
               PROBLEM REVIEW
                     |
               FOLLOW-UP CHANGE
```

An incident should link back to the change that introduced or exposed it when known.

A follow-up corrective modification becomes a new controlled change.

---

## 39. Relationship to Production Tracks

Production-like tracks should deliberately exercise incident/recovery behavior.

A mature track is not merely:

```text
WORKLOAD -> SUCCESS
```

It becomes:

```text
WORKLOAD
   |
OBSERVE
   |
CONTROLLED FAILURE
   |
DETECT
   |
DIAGNOSE
   |
RECOVER
   |
VALIDATE
   |
RESUME
```

Production Track 01 already contains foundations in restart/recovery, JES2 operations, LOGREC/SMF diagnosis, and WLM/SRM observation. Future work should connect these capabilities into explicit incident scenarios rather than duplicate their foundational labs.

---

## 40. Diagnostic maturity path

A useful maturity progression is:

```text
M0  Failure noticed
M1  Failure evidence captured
M2  Repeatable diagnosis procedure
M3  Recovery validated
M4  Correlated evidence + automated collection
M5  Cross-domain incident/recovery workflow
```

This is a diagnostic capability path, not a replacement for Architecture V2 maturity.

---

## 41. Recovery maturity path

```text
R0  Recovery unknown
R1  Recovery documented
R2  Recovery executed
R3  Recovery validated against baseline
R4  Recovery repeatable/automated
R5  Recovery integrated into production-like track
```

The Capability Matrix should continue to use its main maturity model while recording recovery status explicitly.

---

## 42. Example — batch failure

```text
JOB SUBMITTED
    |
UNEXPECTED STEP FAILURE
    |
SDSF / JES EVIDENCE
    |
RC / ABEND CLASSIFICATION
    |
INPUT / DATA / CONFIG CHECK
    |
ROOT CAUSE OR PROBABLE CAUSE
    |
CORRECTIVE CHANGE
    |
RESTART FROM CONTROLLED POINT
    |
OUTPUT VALIDATION
    |
SMF / OPERATIONAL CORRELATION
    |
RESUME CHAIN
```

Existing batch recovery evidence can serve as lineage.

---

## 43. Example — DFSMS policy deviation

```text
ALLOCATION TEST
    |
UNEXPECTED CLASS / ROUTING
    |
PRESERVE TEST RESULT
    |
CHECK ACTIVE VS PREPARED POLICY
    |
CHECK ACS SOURCE / OBJECT
    |
CHECK TEST INPUT
    |
CHECK MESSAGES
    |
COMPARE WITH BASELINE
    |
CORRECT / ROLLBACK
    |
RETEST
```

Do not assume an ACS translation problem when the failure may instead be activation, test-input, or allocation behavior.

---

## 44. Example — security deviation

```text
ACCESS RESULT
    |
EXPECTED? -- YES --> VALIDATION
    |
    NO
    |
PRESERVE RACF/AUDIT EVIDENCE
    |
CHECK RESOURCE / CLASS / PROFILE
    |
CHECK EFFECTIVE AUTHORITY
    |
CONTAIN EXPOSURE IF NEEDED
    |
CORRECTIVE CHANGE
    |
POSITIVE + NEGATIVE RETEST
```

---

## 45. Example — performance deviation

```text
WORKLOAD SYMPTOM
    |
TIME / WORKLOAD IDENTIFIED
    |
RMF / WLM / SMF EVIDENCE
    |
RESOURCE OR SERVICE BEHAVIOR
    |
HYPOTHESIS
    |
CONTROLLED TEST
    |
RECOVER OR TUNE THROUGH CHANGE CONTROL
    |
RE-MEASURE
```

Avoid tuning first and diagnosing later.

---

## 46. Example — failed recovery

A recovery action can itself fail.

```text
PRIMARY INCIDENT
     |
RECOVERY ATTEMPT
     |
RECOVERY FAILURE
     |
STOP / PRESERVE EVIDENCE
     |
REASSESS KNOWN STATE
     |
ESCALATE SEVERITY IF REQUIRED
     |
ALTERNATE RECOVERY
```

Do not repeatedly execute the same recovery action without new evidence.

---

## 47. Escalation in a solo laboratory

Enterprise escalation paths cannot be reproduced literally by one engineer.

Instead use **technical escalation**:

- broaden evidence scope;
- stop risky execution;
- return to IBM documentation;
- inspect existing portfolio evidence;
- create a dedicated diagnostic capability lab;
- classify the issue as blocked when the environment lacks the necessary facility.

Do not fabricate team approvals or escalation roles that do not exist.

---

## 48. GitHub relationship

The GitHub Incident Issue Form is the entry point.

The detailed incident record provides the engineering history.

A corrective action should normally become:

```text
INCIDENT
   |
PROBLEM REVIEW
   |
ISSUE / CHANGE
   |
SHORT-LIVED BRANCH
   |
PR
   |
QUALITY GATE
   |
MERGE
```

This preserves the relationship between failure and corrective engineering work.

---

## 49. Quality Gate relationship

The automated GitHub Quality Gate can detect repository-quality and publication-safety problems.

It cannot diagnose z/OS incidents.

Automation can check:

- syntax;
- whitespace;
- expected structure;
- obvious publication hazards.

System evidence determines:

- operational health;
- causal diagnosis;
- recovery success;
- capability maturity.

---

## 50. Engineering Control Plane v1

With this standard the first Engineering Control Plane is:

```text
                 ARCHITECTURE V2
                       |
                CAPABILITY MATRIX
                       |
              CAPABILITY / GAP
                       |
             KNOWN GOOD BASELINE
                       |
               CHANGE MANAGEMENT
                       |
                 BRANCH / PR
                       |
                QUALITY GATE
                       |
               z/OS EXECUTION
                       |
              VALIDATE / OBSERVE
                  /          \
              ACCEPT       INCIDENT
                |              |
             BASELINE       DIAGNOSE
                |              |
             MATRIX         RECOVER
                               |
                          PROBLEM REVIEW
                               |
                         FOLLOW-UP CHANGE
```

This creates a closed engineering loop.

Future laboratories should enter this loop because a capability requires evidence, not because the next numeric lab identifier is available.

---

## 51. Control Plane review criteria

Before Engineering Control Plane v1 is merged, verify:

- Capability Matrix exists and is evidence-driven;
- Known Good Baseline defines pre/post state control;
- Change Management defines scope, risk, validation and recovery;
- GitHub templates encode the methodology;
- automated Quality Gate performs objective repository checks;
- Incident/Recovery defines evidence-led diagnosis and restoration;
- publication security is present across all layers;
- historical labs are preserved rather than rewritten unnecessarily;
- Architecture V2 remains the governing model;
- future work has a clear path from capability gap to validated integration.

The Control Plane is successful when it changes how the next lab is selected, executed, validated, recovered, documented, and merged.

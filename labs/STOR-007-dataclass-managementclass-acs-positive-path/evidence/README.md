# Guided Evidence — STOR-007 — DFSMS Data/Management Class Foundation and Data Class ACS Positive-Path Validation

[← Lab lesson](../README.md) · [Academy](https://github.com/P-dot/P-dot/blob/main/docs/ACADEMY.md) · [Evidence standard](https://github.com/P-dot/P-dot/blob/main/docs/LAB-STANDARD.md)

## How to read this evidence

This page is the evidence companion to the lab, not a screenshot gallery. Read the artifacts in execution order and correlate each image or file with the command, job, subsystem state or result described by the lab.

Use four questions while reviewing the evidence:

1. **Intent** — what state or behavior was the lab trying to create or inspect?
2. **Mechanism** — which z/OS component, command, utility or program performed the work?
3. **Observation** — what concrete message, return code, object or state was captured?
4. **Boundary** — what does that artifact support, and what would require additional evidence?

The manifest below is retained as the factual index from the executed lab. Its descriptions are the source of truth for what each artifact was captured to demonstrate.

## Evidence manifest

# Evidence Matrix

| ID | File | What it proves |
|---|---|---|
| E01 | `01-smsdata-data-class-list.png` | `SMSDATA` exists in the Data Class list for `SYS1.SCDS`. |
| E02 | `02-smsmgmt-management-class-list.png` | `SMSMGMT` exists in the Management Class list for `SYS1.SCDS`. |
| E03 | `03-acsdata-source.png` | `IBMUSER.HARDEN.CNTL(ACSDATA)` contains the intended `PROC DATACLAS` logic. |
| E04 | `04-acsdata-translate-input.png` | Translation targets `SYS1.SCDS`, member `ACSDATA`, and the dedicated listing. |
| E05 | `05-acsdata-translation-rc0000.png` | ACS object saved and `TRANSLATION RETURN CODE: 0000`. |
| E06 | `06-acsdata-validation-input.png` | Validation is isolated to routine type `DC`. |
| E07 | `07-acsdata-validation-success.png` | `VALIDATION SUCCESSFUL` for Data Class ACS. |
| E08 | `08-dctest1-positive-case.png` | Positive test case uses `IBMUSER.SMSLAB.TESTDC`. |
| E09 | `09-dctest1-isolated-dc-selection.png` | Test runs `DC=Y` with `SC/MC/SG=N`. |
| E10 | `10-dctest1-results-rc00.png` | `EXIT CODE 0`, `DC = SMSDATA`, `ACS TESTING RC: 00`. |

## Evidence quality rule

The evidence set is curated, not exhaustive. Intermediate navigation screenshots are deliberately excluded when they do not prove a distinct acceptance criterion.

## Interpretation discipline

A successful command, return code or panel is interpreted only within the scope described by the lab. It must not be promoted into proof of unrelated production properties such as availability, performance, security hardening or recovery unless those properties have their own evidence.

When troubleshooting, walk the artifacts in order and locate the first point where **expected state** and **observed state** diverge. That point is normally more useful than the final symptom.

## Evidence boundary

**Evidence-backed:** the individual observations explicitly identified in the manifest and the parent lab.

**Not automatically implied:** production readiness, enterprise scale, security completeness, performance characteristics or cross-subsystem behavior that was not exercised by this lab.

## Review questions

- Which artifact establishes the initial or prerequisite state?
- Which artifact is the strongest execution/result proof?
- Is there a separate final-state validation, or only a successful command?
- Which z/OS subsystem owns the observed messages or objects?
- What additional artifact would be required to make a stronger claim?

---
### Continue learning

**Lab:** [Return to the lesson](../README.md)
**Academy:** [z/OS Engineering Academy](https://github.com/P-dot/P-dot/blob/main/docs/ACADEMY.md) · [Curriculum](https://github.com/P-dot/P-dot/blob/main/docs/CURRICULUM.md) · [Relationships](https://github.com/P-dot/P-dot/blob/main/docs/RELATIONSHIPS.md)

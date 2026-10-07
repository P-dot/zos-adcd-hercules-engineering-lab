# Guided Evidence — Lab 12 — WLM direct access from the ISPF Primary Option Menu

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

# Evidence index

- `01-wlm-active-policy.png`
- `02-xcf-overview.png`
- `03-wlm-couple-datasets.png`
- `04-wlm-splash.png`
- `05-extract-service-definition.png`
- `06-wlm-definition-menu.png`
- `07-service-policy-list.png`
- `08-service-policy-browse.png`
- `09-isrddn-allocations.png`
- `10-ispplib-concatenation.png`
- `11-isrprim-member-search.png`
- `12-isrprim-panel-source.png`
- `13-isrprim-primary-menu-source.png`
- `14-isrprim-init-proc-source.png`
- `15-isrprim-zsel-before-change.png`
- `16-ibmprods-wlm-option.png`
- `17-user-isrprim-menu-edit.png`
- `18-user-isrprim-zsel-edit.png`
- `19-user-isrprim-precedence.png`
- `20-primary-menu-wlm-option.png`
- `21-troubleshooting-wrong-exec-name.png`
- `22-ibmprods-correct-iwmarin0.png`
- `23-wlm-direct-launch-success.png`

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

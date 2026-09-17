# z/OS Engineering Pull Request

## Engineering intent
- **Change / Lab ID:**
- **Domain:**
- **Capability:**
- **Architecture:** V2
- **Change class:**
- **Risk:**
- **Lifecycle stage:**
- **Maturity:** before → target
- **Integration:** before → target
- **Automation:**

## Why
Describe the capability gap, defect, integration need, recovery need, or documented architecture requirement that justifies this work.

## Scope
### In scope
-

### Out of scope
-

## Baseline
- **Baseline-A / existing evidence:**
- **Known pre-existing exceptions:**
- **Relevant health state:**
- **Observability available:**

## Implementation
Summarize the controlled implementation and link to the detailed lab/change record.

## Validation
- [ ] Intended functional result validated
- [ ] Negative path validated, or reason documented when not applicable
- [ ] Relevant Health Checker state reviewed
- [ ] Relevant SMF / SYSLOG / SDSF / JES / LOGREC / RMF evidence reviewed
- [ ] Baseline-B captured when system state changed
- [ ] Baseline-A ↔ Baseline-B differences classified
- [ ] Unexpected deviations documented

## Recovery
- **Recovery state:** TESTED / DEFINED / NOT REQUIRED / NOT AVAILABLE / UNKNOWN
- **Recovery trigger:**
- **Recovery evidence:**

## Evidence
- **Documentation:**
- **Commands / source:**
- **Tests:**
- **Screenshots / reports:**

## Publication security
- [ ] No credentials, passwords, access tokens, private keys, or reusable secrets
- [ ] No identifying host IP/MAC/adapter/session information
- [ ] No identifying local host usernames or filesystem paths
- [ ] Guest z/OS metadata and screenshots reviewed before publication
- [ ] Evidence is public-safe or deliberately sanitized

## Engineering result
- **Actual result:**
- **Baseline promoted:** yes / no / not applicable
- **Capability Matrix impact:**
- **Remaining gap / next capability:**

## Merge gate
- [ ] `git diff --check` passes
- [ ] Documentation reflects actual execution, including material failures/troubleshooting
- [ ] Required evidence is present
- [ ] Recovery status is known
- [ ] Publication review is complete
- [ ] This PR does not overstate capabilities not demonstrated by evidence

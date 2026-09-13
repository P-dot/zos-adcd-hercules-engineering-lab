# DFSMS Policy Engineering — Baseline and Capability Gap Analysis

## Status

**COMPLETED — discovery / baseline phase**

This lab establishes the current DFSMS/SMS policy baseline without changing the active configuration. Its purpose is to determine what is already implemented, trace it back to prior engineering work in the portfolio, and identify the next capability gaps before making further storage-policy changes.

## Engineering objective

The lab answers four questions:

1. What SMS configuration is active?
2. Which Storage Groups and volumes are currently defined?
3. Which ACS objects currently drive allocation policy?
4. Which of those objects were already engineered and documented in previous portfolio labs?

The key methodological improvement is that the repository is treated as an engineering knowledge base. Once the current system state matched artifacts from an earlier lab, the investigation stopped rediscovering already-proven implementation details and reused the existing evidence instead.

## Baseline discovered

Operator and ISMF inspection established:

- SCDS: `SYS1.SCDS`
- ACDS: `SYS1.ACDS`
- COMMDS: `SYS1.COMMDS`
- Storage Groups visible to SMS: `DBCLASS`, `HFSCLASS`, `SMSPOOL`
- `SMSPOOL` type: `POOL`
- `SMSPOOL` volumes: `SMS000`, `SMS001`, `SMS002`
- `SMSPOOL` automatic migration: `NO`
- translated ACS objects present for `STORCLAS` and `STORGRP`
- no translated ACS objects displayed for `DATACLAS` or `MGMTCLAS`
- ACS source library: `IBMUSER.HARDEN.CNTL`
- Storage Class source member: `ACSSTOR`
- Storage Group source member: `ACSGRP`

## Proven allocation path

The current policy was correlated with the already-completed Lab 17 implementation:

```text
IBMUSER.SMSLAB.*
        |
        v
ACSSTOR
        |
        v
STORCLAS = SMSLAB
        |
        v
ACSGRP
        |
        v
STORGRP = SMSPOOL
        |
        +--> SMS000
        +--> SMS001
        +--> SMS002
```

Lab 17 had already created, translated, validated, tested and activated this path and had proven a real policy-driven allocation without explicit `UNIT`, `VOL=SER`, `STORCLAS` or `STORGRP` in the allocation JCL.

## What was deliberately not changed

This phase was read-only. It did not:

- alter `SYS1.SCDS`;
- activate a new SMS configuration;
- change ACS source;
- translate new ACS objects;
- change Storage Groups or volume membership;
- enable DFSMShsm functions;
- introduce Data Class or Management Class policy.

This preserves a clean baseline for the next controlled change.

## Portfolio reuse and investigation-time reduction

A major result of this lab is methodological rather than purely technical.

During discovery, the system exposed `IBMUSER.HARDEN.CNTL(ACSSTOR)` and `IBMUSER.HARDEN.CNTL(ACSGRP)`. Instead of continuing to reverse-engineer these members manually, the portfolio was searched and they were located in **Lab 17 — DFSMS SMS ACS Rules and Automatic Dataset Allocation**.

That prior lab already contained:

- the origin and purpose of both ACS members;
- the definition of `SMSLAB` and `SMSPOOL`;
- the association of `SMS000`, `SMS001` and `SMS002`;
- ACS source code;
- translation and validation results;
- activation procedure;
- allocation tests;
- LISTCAT proof;
- troubleshooting history;
- documented follow-on gaps.

This reduced investigation time because the workflow changed from:

```text
observe -> rediscover -> reconstruct -> retest old work -> continue
```

to:

```text
observe -> identify artifact -> search portfolio -> correlate evidence -> continue from known state
```

The repository therefore functions as an operational engineering memory, not only as a publication archive.

## Capability gap identified

The current policy is not yet a complete DFSMS policy model:

| Capability | Current state |
|---|---|
| Storage Group | Implemented |
| Storage Class | Implemented |
| Storage Group ACS | Implemented |
| Storage Class ACS | Implemented |
| Data Class ACS | Gap identified |
| Management Class ACS | Gap identified |
| HFS/zFS-specific routing | Gap / incomplete integration |
| Workload-aware storage policy | Partial |
| DFSMShsm lifecycle | Future capability |
| Cross-domain SMF storage policy | Future integration |

`HFSCLASS` exists as a Storage Group, but the inspected `ACSGRP` path does not select it. This remains an explicit integration gap rather than something to infer or silently change.

## Next work — DFSMS Policy Engineering Phase 2

The next controlled engineering phase will extend the existing Lab 17 policy rather than recreate it.

### Primary objective

Implement and validate **Data Class + Management Class policy**, then integrate **HFS/zFS-aware routing** with the existing Storage Class / Storage Group path.

### Planned lifecycle

```text
DISCOVER existing constructs
        |
        v
DEFINE intended data lifecycle requirements
        |
        v
DESIGN Data Class policy
        |
        v
DESIGN Management Class policy
        |
        v
EXTEND ACS routing
        |
        v
VALIDATE SCDS
        |
        v
TEST ACS cases before activation
        |
        v
PLAN rollback
        |
        v
ACTIVATE controlled configuration
        |
        v
PROVE real allocations
        |
        v
OBSERVE / DIAGNOSE
        |
        v
DOCUMENT integration impact
```

### Expected later integrations

After Data Class / Management Class and HFS/zFS routing are proven, the Storage & DFSMS track can continue toward workload-specific storage policy, SMF dataset policy, RACF protection around storage-management capabilities, DFSMShsm discovery and lifecycle management, and recovery/automation scenarios.

## New working rule established

Before reverse-engineering an existing z/OS object, member, PROC, dataset, policy or subsystem customization, search the portfolio for its origin and previous evidence.

The preferred workflow is now:

```text
CURRENT SYSTEM STATE
        |
        v
PORTFOLIO CORRELATION
        |
        +--> already proven? -> reuse evidence
        |
        +--> partially proven? -> extend capability
        |
        +--> absent? -> create new engineering work
```

This avoids duplicate labs, reduces repeated investigation, preserves technical history, and makes the portfolio itself part of the engineering operating model.

## Evidence

The `evidence/screenshots/` directory contains the screenshots captured during this baseline session, including:

- `D SMS` baseline;
- Storage Group discovery;
- ISMF Storage Group navigation;
- `SMSPOOL` volume listing;
- ACS application/object display;
- `ACSGRP` and `ACSSTOR` source inspection.

## Result

**DFSMS Policy Baseline & Capability Gap Analysis: COMPLETED.**

The next work begins from the existing Lab 17 implementation and targets missing policy capabilities instead of repeating SMS fundamentals.

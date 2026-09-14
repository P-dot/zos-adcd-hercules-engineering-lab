# STOR-007 — DFSMS Data/Management Class Foundation and Data Class ACS Positive-Path Validation

## Status

**COMPLETED — controlled pre-activation validation**

## Domain ownership

- **Engineering domain:** Storage & DFSMS Engineering
- **Target repository:** `zos-storage-dfsms-engineering`
- **Architecture model:** z/OS Engineering Architecture V2
- **Platform:** IBM z/OS ADCD 1.11 under Hercules
- **Working SCDS:** `SYS1.SCDS`
- **ACS source library:** `IBMUSER.HARDEN.CNTL`

This lab is a **new domain-native Storage/DFSMS lab**. Historical DFSMS work remains in the Core repository and is referenced rather than copied or migrated.

## Engineering objective

Extend the previously proven SMS allocation policy with missing class constructs and a new Data Class ACS path, while stopping before activation or real allocation.

The lab establishes and proves the following controlled progression:

```text
Existing Storage Class / Storage Group policy
                 |
                 v
Define SMSDATA Data Class
                 |
                 v
Define SMSMGMT Management Class foundation
                 |
                 v
Create ACSDATA source
                 |
                 v
Translate Data Class ACS object
                 |
                 v
Validate against SYS1.SCDS
                 |
                 v
Execute isolated positive-path ACS test
                 |
                 v
DC = SMSDATA / EXIT CODE 0 / ACS TESTING RC 00
```

## Historical lineage

This work intentionally continues, rather than duplicates, earlier validated capability from the Core repository:

- `15-dfsms-sms-introduction-baseline`
- `16-dfsms-sms-pool-creation`
- `17-dfsms-sms-acs-automatic-allocation`
- `dfsmspolicy-baseline-capability-gap-analysis`

The gap-analysis phase identified missing `DATACLAS` and `MGMTCLAS` policy. This lab closes the **Data Class construct + Data Class ACS positive-path** portion of that gap and prepares the Management Class construct for the next controlled phase.

## Implemented constructs

### Data Class

A Data Class named `SMSDATA` was defined and saved in `SYS1.SCDS`.

The construct is intentionally simple at this stage: the engineering goal is to establish policy ownership and routing first, then deepen allocation attributes in later controlled work.

### Management Class foundation

A Management Class named `SMSMGMT` was defined and saved in `SYS1.SCDS`.

`SMSMGMT` is present as a construct foundation only. **No Management Class ACS routine was implemented or tested in this lab.** That boundary is deliberate and is carried into the next phase.

## Data Class ACS implementation

Source member:

```text
IBMUSER.HARDEN.CNTL(ACSDATA)
```

Implemented logic:

```text
PROC DATACLAS

IF &DSN(1) = 'IBMUSER' AND &DSN(2) = 'SMSLAB' THEN
  SET &DATACLAS = 'SMSDATA'
ELSE
  SET &DATACLAS = ''

END
```

### Decision semantics

For a new data set matching:

```text
IBMUSER.SMSLAB.*
```

the routine assigns:

```text
DATACLAS = SMSDATA
```

For names outside that branch, the routine returns a blank Data Class. The negative path is intentionally **not yet functionally tested**; that is reserved for the next lab.

## Translation

The Data Class ACS routine was translated from source to ACS object form using ISMF.

Input:

```text
SCDS Name           = SYS1.SCDS
ACS Source Data Set = IBMUSER.HARDEN.CNTL
ACS Source Member   = ACSDATA
Listing Data Set    = IBMUSER.ACSDATA.LIST
```

Observed result:

```text
TRANSLATION RETURN CODE: 0000
ACS OBJECT SAVED
```

This proves that the ACS source was accepted and object generation completed successfully.

## Validation

Validation was deliberately isolated to the Data Class routine:

```text
SCDS Name        = SYS1.SCDS
ACS Routine Type = DC
Listing Data Set = IBMUSER.ACSDATA.VAL
```

Observed result:

```text
VALIDATION RESULT: VALIDATION SUCCESSFUL
ACS ROUTINE TYPE: DC
```

This proves that the translated Data Class ACS object is valid against the storage constructs available in `SYS1.SCDS`.

## Functional ACS test

A dedicated test case was created instead of overwriting earlier ACS test evidence.

```text
ACS Test Library = IBMUSER.HARDEN.CNTL
ACS Test Member  = DCTEST1
Description      = Positive DATACLAS routing test
DSN              = IBMUSER.SMSLAB.TESTDC
```

The routine selection was intentionally isolated:

```text
DC = Y
SC = N
MC = N
SG = N
```

This prevents existing Storage Class or Storage Group logic from contaminating the evidence for the Data Class decision.

### Observed result

```text
ACS ROUTINE TYPES: DC
ACS TEST MEMBER: DCTEST1
EXIT CODE: 0
RESULTS: DC = SMSDATA
ACS TESTING RC: 00
```

## Acceptance criteria

| Criterion | Evidence | Result |
|---|---|---|
| `SMSDATA` exists in `SYS1.SCDS` | Data Class list | PASS |
| `SMSMGMT` construct foundation exists | Management Class list | PASS |
| `ACSDATA` source exists | ISPF Edit evidence | PASS |
| ACS source translates | Translation listing | **RC 0000** |
| Data Class ACS validates against SCDS | Validation listing | **SUCCESSFUL** |
| Positive-path case routes correctly | `DCTEST1` result | `DC = SMSDATA` |
| Test execution completes cleanly | ACS test listing | **RC 00** |

## Scope boundary

The following actions were **not** performed in this lab:

- no activation of the modified SCDS as the active SMS configuration;
- no real dataset allocation using the new Data Class policy;
- no negative-path `DATACLAS` test;
- no `ACSMGMT` source implementation;
- no Management Class ACS translation/validation/test;
- no HFS/zFS-specific routing;
- no Storage Class or Storage Group policy changes;
- no migration of historical Core DFSMS labs.

This boundary leaves the system at a clean pre-activation engineering checkpoint.

## Evidence set

Curated evidence is stored under:

```text
evidence/screenshots/
```

The evidence set is intentionally limited to screenshots that prove the lab's acceptance criteria. See `evidence/README.md` for the evidence matrix.

## Professional engineering value

This lab demonstrates:

- DFSMS/SMS construct administration through ISMF;
- controlled extension of an existing storage-policy baseline;
- ACS source lifecycle management;
- translation and object creation;
- routine-specific validation against SCDS constructs;
- isolated functional ACS testing;
- positive-path policy verification;
- explicit pre-activation change boundaries;
- traceability to historical platform engineering work;
- evidence-driven completion criteria.

## Next controlled phase

The next Storage/DFSMS lab should continue from this checkpoint with:

```text
1. DCTEST2 negative-path validation
2. Additional Data Class decision coverage
3. ACSMGMT implementation
4. Management Class translation and validation
5. Integrated DC/MC testing
6. Activation planning and rollback criteria
7. Controlled activation only after pre-activation gates pass
8. Real allocation proof
```

## Final result

**STOR-007 is complete at the pre-activation validation stage.**

The new Data Class policy is syntactically translated, structurally validated, and functionally proven for the positive path:

```text
IBMUSER.SMSLAB.TESTDC
        -> ACSDATA
        -> DATACLAS SMSDATA
        -> EXIT CODE 0
        -> ACS TESTING RC 00
```

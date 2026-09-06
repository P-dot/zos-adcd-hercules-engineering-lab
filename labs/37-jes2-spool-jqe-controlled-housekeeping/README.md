# Lab 37 — JES2 Spool and JQE Controlled Housekeeping with SDSF REXX

## Objective

Diagnose and remediate excessive JES2 historical output accumulation in the
z/OS ADCD/Hercules environment without disrupting active started tasks,
TSO sessions, or batch execution.

The lab implements a controlled housekeeping workflow using SDSF REXX:
baseline measurement, dry-run discovery, progressively hardened filtering,
single-entry destructive validation, full controlled purge, and post-change
verification.

## Why Lab 37

The engineering repository already contains Labs 1–36. Lab 12 covers JES2 JQE
maintenance, so this lab does not replace it. Lab 37 records a later,
production-style operational remediation performed against the evolved system:
a real backlog was detected, selection logic was engineered and validated, and
the resulting resource recovery was measured.

## Incident / Trigger

The system had accumulated a very large number of historical JES2 output
entries. The operational symptoms included a JES2 JQE resource-shortage
condition and unusually high spool occupancy.

The baseline evidence showed:

- JES2 spool utilization: **11.0222%**
- `SBSYS1`: **40%**
- `SBSYS9`: **5%**
- `BERTNUM=2000`
- `BERTFREE=1743`
- SDSF ST contained roughly **893–894 rows** during the investigation.

See:

- `evidence/01-before-ckptspace.png`
- `evidence/02-before-jobdef.png`
- `evidence/03-before-spool-utilization.png`

## Safety Model

The cleanup was not performed as an unrestricted purge.

A candidate had to satisfy all of the following:

```text
QUEUE = PRINT
JOBID prefix = STC
numeric STC job number < 6400
```

This deliberately protected:

- active entries in `EXECUTION`;
- current/recent STCs at or above the cutoff;
- TSO users (`TSUxxxxx`);
- ordinary batch jobs (`JOBxxxxx`);
- malformed or non-numeric identifiers.

The job name itself was **not** used as the safety criterion. A historical
`TCPIP`, `CICS`, Db2, MQ, SDSF, or other subsystem entry in `PRINT` is JES
output from a completed invocation; the active address space is a different
JES instance and remained protected by state and job-number checks.

## Controlled Change Workflow

### 1. Baseline

JES2 checkpoint, job-definition, spool-volume and SDSF state were captured
before any destructive action.

### 2. Dry-run discovery

The first dry-run identified **860 PRINT entries below the cutoff** and
**33 protected/skipped rows**.

### 3. Filter hardening

The selection was tightened to require an `STC` JOBID prefix.

The hardened dry-run produced:

```text
OLD STC PRINT CANDIDATES : 843
PROTECTED/SKIPPED ROWS   : 50
CUTOFF JNUM              : 6400
DRY RUN ONLY - NOTHING WAS PURGED
```

The additional protection removed non-STC entries from the destructive set.

### 4. Single destructive validation

Before scaling the change, one historical STC entry was purged using the SDSF
token returned by `ISFEXEC ST`.

Validated SDSF action:

```rexx
address SDSF,
  "ISFACT ST TOKEN('"token.i"')",
  "PARM(NP P)"
```

The test successfully purged one old STC entry and demonstrated that the
destructive action worked in this z/OS V1R11 SDSF environment.

### 5. Full controlled cleanup

After the dry-run and one-entry validation, the full guarded REXX procedure was
executed.

Observed result:

```text
INITIAL CANDIDATES : 843
ACTION ATTEMPTS    : 843
PURGED             : 843
FAILED             : 0
```

The post-cleanup SDSF snapshot contained approximately **51 rows**. One
additional old PRINT entry was observed in the immediate dynamic snapshot, but
the operational cleanup was subsequently confirmed as complete.

### 6. Post-change verification

Active/current started tasks remained present and executing after the purge.
The cleanup therefore removed historical JES output rather than terminating
live subsystem address spaces.

Measured post-cleanup state:

```text
SBSYS1 spool use       : 1%
SBSYS9 spool use       : 1%
Total spool utilization: 0.4111%

BERTNUM                : 2000
BERTFREE                : 1812
```

## Measured Improvement

| Metric | Before | After | Result |
|---|---:|---:|---:|
| JES2 spool utilization | 11.0222% | 0.4111% | major reduction |
| SBSYS1 utilization | 40% | 1% | recovered |
| SBSYS9 utilization | 5% | 1% | recovered |
| BERTFREE | 1743 | 1812 | +69 free BERTs |
| Purge attempts | — | 843 | completed |
| Purge failures | — | 0 | no SDSF action failures |

The spool-utilization reduction was approximately **96.3%** relative to the
baseline.

## Evidence

1. `01-before-ckptspace.png` — JES2 checkpoint/BERT baseline.
2. `02-before-jobdef.png` — JES2 JOBDEF/JQE-related baseline.
3. `03-before-spool-utilization.png` — 11.0222% spool baseline.
4. `04-rexx-filter-development.png` — SDSF REXX selection development.
5. `05-rexx-dry-run-validation.png` — dry-run validation.
6. `06-dry-run-summary.png` — candidate/protection accounting.
7. `07-single-purge-validated.png` — guarded one-entry purge implementation.
8. `08-single-purge-result.png` — single destructive action result.
9. `09-mass-purge-execution.png` — controlled full execution.
10. `10-mass-purge-summary.png` — 843 purged, 0 failed.
11. `11-post-cleanup-sdsf-st.png` — active workload retained.
12. `12-post-cleanup-spool-volumes.png` — spool volumes after cleanup.
13. `13-post-cleanup-spool-utilization.png` — 0.4111% total spool use.
14. `14-post-cleanup-ckptspace.png` — checkpoint/BERT state after cleanup.
15. `15-post-cleanup-bertuse.png` — post-cleanup BERT usage detail.

## Operational Result

**SUCCESS**

The historical JES2 backlog was removed through a staged and auditable change
process. The procedure demonstrated:

- incident-driven JES2 diagnosis;
- SDSF REXX automation;
- dry-run/change-control discipline;
- explicit protection of active workloads;
- destructive-action validation before scale-up;
- stop-on-error behavior;
- before/after resource measurement;
- measurable spool and checkpoint-resource recovery.

No JES2 restart was required.

## Important Operational Note

A JES2 purge permanently removes the selected historical SYSOUT from the
spool. This can include JESMSGLG, JESJCL, JESYSMSG and application SYSOUT.
For a production implementation, retention requirements and external archival
policy must be evaluated before applying an equivalent cleanup.

## Environment

- IBM z/OS V1R11 ADCD
- Hercules / zPDT-style laboratory environment
- JES2
- SDSF
- TSO/E REXX
- REXX library: `IBMUSER.REXX.EXEC`

## References

- IBM z/OS SDSF Operation and Customization
- IBM JES2 Initialization and Tuning Guide
- IBM z/OS MVS System Commands
- Existing repository Lab 12 — JES2 JQE Maintenance

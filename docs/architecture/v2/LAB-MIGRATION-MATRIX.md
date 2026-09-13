# Architecture V2 — Lab Migration Matrix

## Purpose

This document maps the existing laboratory history of `zos-adcd-hercules-engineering-lab` into the Architecture V2 classification model.

The matrix is a **classification and planning artifact**, not an instruction to move historical directories immediately.

Existing paths remain the authoritative historical identifiers. Architecture V2 uses the matrix to decide:

- which capabilities remain part of Core Platform;
- which capabilities should stop growing inside Core and continue in specialized domain repositories;
- which labs are historical references to capabilities already represented by another repository;
- which labs form cross-domain integration tracks;
- which future repositories are justified by real lab density rather than by diagram design.

## Action semantics

- **KEEP** — historical lab and future capability development remain appropriate in Core.
- **REFERENCE** — historical lab remains in place; future work should primarily be referenced or developed in the specialized domain.
- **MIGRATE-FUTURE** — do not move the historical lab now, but create new capability labs in the specialized repository when that repository is established.
- **INTEGRATION-TRACK** — retain as part of a cross-domain sequence.
- **DEPRECATE** — reserved for technically invalid or superseded work; no current lab is classified this way.

## Important constraint

The existing repository contains repeated numeric prefixes and multi-part exercises. Therefore the full path, not the numeric prefix alone, is the stable historical identifier.

## Current matrix

| Historical path | Primary domain | Capability | Lifecycle | Maturity | Integration | Future architectural home | Action |
|---|---|---|---|---:|---:|---|---|
| `labs/01-system-services-structure-system-introduction` | Core Platform Engineering | z/OS system structure | Discover / Baseline | M1 | I0 | Core Platform | KEEP |
| `labs/02-system-services-structure-operating-environment-initialization` | Core Platform Engineering | Operating environment initialization | Baseline / Configure | M1 | I0 | Core Platform | KEEP |
| `labs/03-system-services-structure-task-management` | Operations and Service Management | Task management | Operate | M1 | I0 | Core / Operations | KEEP |
| `labs/04-system-services-structure-storage-management` | Storage and DFSMS Engineering | Storage management foundations | Discover / Baseline | M1 | I0 | zos-storage-dfsms-engineering | MIGRATE-FUTURE |
| `labs/04-zvol-dasd-engineering` | Storage and DFSMS Engineering | DASD and volume engineering | Configure / Operate | M2 | I0 | zos-storage-dfsms-engineering | MIGRATE-FUTURE |
| `labs/05-db2-cics-db2conn-integration` | Integration Engineering | CICS-Db2 DB2CONN integration | Integrate | M5 | I2 | Integration track / CICS-Db2 | INTEGRATION-TRACK |
| `labs/05-system-services-structure-sysplex-xcf-grs-logger` | Sysplex and Availability Engineering | XCF / GRS / System Logger foundations | Discover / Baseline | M1 | I1 | Future sysplex/availability domain | REFERENCE |
| `labs/06-system-services-structure-problem-determination-logrec-dumps` | Problem Determination and Diagnostics | LOGREC and dump foundations | Observe / Diagnose | M1 | I1 | zos-problem-determination-diagnostics | MIGRATE-FUTURE |
| `labs/07-system-services-structure-io-subsystem-iodf-dasd-paths` | Storage and DFSMS Engineering | I/O subsystem, IODF and DASD path baseline | Discover / Baseline | M1 | I1 | Storage / Platform boundary | REFERENCE |
| `labs/08-system-services-structure-omvs-zfs-unix-system-services` | UNIX System Services Engineering | OMVS / zFS / USS foundations | Discover / Baseline | M1 | I1 | UNIX_System_Services- | REFERENCE |
| `labs/09-adrdssu-backup-hercules-virtual-tape` | Recovery Engineering | ADRDSSU backup to virtual tape | Operate / Recover | M2 | I1 | Future recovery domain | REFERENCE |
| `labs/09-adrdssu-restore-hercules-virtual-tape` | Recovery Engineering | ADRDSSU controlled restore | Recover | M3 | I1 | Future recovery domain | REFERENCE |
| `labs/09-system-services-structure-program-management-linklist-lpa-apf` | Core Platform Engineering | Program management / LINKLIST / LPA / APF | Discover / Baseline / Configure | M2 | I1 | Core Platform | KEEP |
| `labs/10-jes2-spool-expansion-sbsys9` | Workload and Batch Engineering | JES2 spool expansion | Configure / Operate | M2 | I1 | Workload / JES2 integration | REFERENCE |
| `labs/10-system-services-structure-data-management-catalog-sms` | Storage and DFSMS Engineering | Catalog and SMS foundations | Discover / Baseline | M1 | I1 | zos-storage-dfsms-engineering | MIGRATE-FUTURE |
| `labs/11-hzsproc-health-checker-bootstrap` | Operations and Service Management | Health Checker bootstrap | Configure / Observe | M2 | I1 | Core / Operations | KEEP |
| `labs/11-system-services-structure-jes2-spool-batch-flow` | Workload and Batch Engineering | JES2 spool and batch flow | Operate / Observe | M2 | I1 | Workload / JES2 integration | REFERENCE |
| `labs/12-jes2-jqes-maintenance` | Workload and Batch Engineering | JES2 JQE maintenance | Maintain / Operate | M2 | I1 | Workload / JES2 integration | REFERENCE |
| `labs/12-system-services-structure-system-baseline-operational-health-check` | Operations and Service Management | Operational health baseline | Baseline / Observe | M2 | I1 | Core / Operations | KEEP |
| `labs/12-wlm-ispf-direct-access` | Performance and Capacity Engineering | WLM access and discovery | Discover / Baseline | M1 | I0 | zos-performance-capacity-engineering | MIGRATE-FUTURE |
| `labs/13-smf-baseline-and-activation-readiness` | Observability plane | SMF baseline and readiness | Discover / Baseline | M1 | I1 | Cross-cutting observability | REFERENCE |
| `labs/13-system-services-structure-console-syslog-message-handling` | Operations and Service Management | Console / SYSLOG message handling | Operate / Observe | M2 | I1 | Core / Operations | KEEP |
| `labs/14-smf-man-dump-ifasmfdp-export` | Observability plane | SMF MAN dump / IFASMFDP export | Operate / Observe | M2 | I1 | Cross-cutting observability | REFERENCE |
| `labs/14-system-services-structure-iplparm-parmlib-runtime-configuration` | Core Platform Engineering | IPL parameters / PARMLIB runtime configuration | Configure / Operate | M2 | I1 | Core Platform | KEEP |
| `labs/15-dfsms-sms-introduction-baseline` | Storage and DFSMS Engineering | DFSMS/SMS baseline | Discover / Baseline | M1 | I0 | zos-storage-dfsms-engineering | MIGRATE-FUTURE |
| `labs/15-system-services-structure-system-libraries-nucleus-lpa-proclib` | Core Platform Engineering | System libraries / nucleus / LPA / PROCLIB | Discover / Baseline | M1 | I1 | Core Platform | KEEP |
| `labs/16-dfsms-sms-pool-creation` | Storage and DFSMS Engineering | SMS pool creation | Configure | M2 | I1 | zos-storage-dfsms-engineering | MIGRATE-FUTURE |
| `labs/17-dfsms-sms-acs-automatic-allocation` | Storage and DFSMS Engineering | ACS-based automatic allocation | Configure / Automate | M4 | I1 | zos-storage-dfsms-engineering | MIGRATE-FUTURE |
| `labs/18-smf-man-dataset-maintenance` | Observability plane | SMF MAN dataset maintenance | Operate / Improve | M2 | I1 | Cross-cutting observability | REFERENCE |
| `labs/18b-smf-man-dataset-sizing-rotation-stabilization` | Observability plane | SMF MAN sizing / rotation / stabilization | Observe / Improve / Recover | M3 | I1 | Cross-cutting observability | REFERENCE |
| `labs/19-dfsmsrmm-activation` | Storage and DFSMS Engineering | DFSMSrmm activation | Configure / Operate | M2 | I1 | zos-storage-dfsms-engineering | MIGRATE-FUTURE |
| `labs/19-hcd-iodf-read-only-engineering-baseline` | Core Platform Engineering | HCD / IODF read-only baseline | Discover / Baseline | M1 | I1 | Core Platform with Storage relationship | KEEP |
| `labs/20-sdsf-system-requests-sr` | Operations and Service Management | SDSF system requests | Operate | M2 | I1 | Core / Operations | KEEP |
| `labs/21-enterprise-system-layout-change-control-baseline` | Core Platform Engineering | Enterprise layout and change-control baseline | Baseline / Improve | M2 | I1 | Core Platform | KEEP |
| `labs/22-smf-manx-offload-rotation-gdg-archive` | Observability plane | SMF MANx offload / rotation / GDG archive | Operate / Automate | M4 | I1 | Cross-cutting observability | REFERENCE |
| `labs/23-racf-security-baseline-privileged-authority-audit-part1` | Security Engineering | Privileged authority audit baseline | Baseline / Observe | M2 | I1 | mainframe-racf-security-evidence | REFERENCE |
| `labs/23-racf-security-baseline-privileged-authority-audit-part2` | Security Engineering | Privileged authority audit continuation | Observe / Diagnose | M2 | I1 | mainframe-racf-security-evidence | REFERENCE |
| `labs/24-racf-privileged-access-governance-exception-review` | Security Engineering | Privileged access governance / exception review | Observe / Improve | M2 | I1 | mainframe-racf-security-evidence | REFERENCE |
| `labs/26-parmlib-proclib-change-control-rollback` | Core Platform Engineering | PARMLIB / PROCLIB change control and rollback | Configure / Recover | M3 | I1 | Core Platform | KEEP |
| `labs/27-wlm-rmf-performance-baseline` | Performance and Capacity Engineering | WLM / RMF performance baseline | Baseline / Observe | M2 | I1 | zos-performance-capacity-engineering | MIGRATE-FUTURE |
| `labs/28-sysplex-xcf-monoplex-professional-baseline` | Sysplex and Availability Engineering | XCF monoplex professional baseline | Discover / Baseline | M1 | I1 | Future sysplex/availability domain | REFERENCE |
| `labs/29-smpe-csi-query-sysmod-inventory` | Software Maintenance Engineering | SMP/E CSI and SYSMOD inventory | Discover / Baseline | M1 | I0 | Future zos-software-maintenance-smpe | REFERENCE |
| `labs/30-enterprise-batch-processing-baseline` | Integration Engineering | Enterprise batch processing baseline | Baseline / Integrate | M5 | I2 | Production Track 01 | INTEGRATION-TRACK |
| `labs/31-cobol-batch-file-processing` | Integration Engineering | COBOL batch file processing | Operate / Integrate | M5 | I2 | Production Track 01 | INTEGRATION-TRACK |
| `labs/32-multistep-jcl-return-codes-conditional-execution` | Integration Engineering | Multistep JCL / RC / conditional execution | Operate / Integrate | M5 | I2 | Production Track 01 | INTEGRATION-TRACK |
| `labs/33-cobol-multirecord-validation-reject-processing` | Integration Engineering | COBOL multirecord validation / reject flow | Operate / Diagnose / Integrate | M5 | I2 | Production Track 01 | INTEGRATION-TRACK |
| `labs/34-dfsort-temporary-datasets-chained-steps` | Integration Engineering | DFSORT chained temporary dataset pipeline | Operate / Integrate | M5 | I2 | Production Track 01 | INTEGRATION-TRACK |
| `labs/35-gdg-batch-pipeline-integration` | Integration Engineering | GDG batch pipeline | Integrate | M5 | I2 | Production Track 01 | INTEGRATION-TRACK |
| `labs/36-batch-restart-rerun-recovery-part1` | Integration Engineering | Batch restart / rerun / recovery part 1 | Diagnose / Recover / Integrate | M5 | I3 | Production Track 01 | INTEGRATION-TRACK |
| `labs/36-batch-restart-rerun-recovery-part2` | Integration Engineering | Batch restart / rerun / recovery part 2 | Recover / Integrate | M5 | I3 | Production Track 01 | INTEGRATION-TRACK |
| `labs/37-jes2-spool-jqe-controlled-housekeeping` | Integration Engineering | JES2 spool / JQE controlled housekeeping | Operate / Improve / Integrate | M5 | I2 | Production Track 01 | INTEGRATION-TRACK |
| `labs/38-logrec-smf-exit-operational-validation` | Integration Engineering | LOGREC / SMF exit operational validation | Observe / Diagnose / Integrate | M5 | I2 | Production Track 01 | INTEGRATION-TRACK |
| `labs/39-smf-type99-srm-wlm-decision-data-part1` | Integration Engineering | SMF Type 99 / SRM / WLM decision analysis | Observe / Diagnose / Integrate | M5 | I2 | Production Track 01 | INTEGRATION-TRACK |

---

# Domain density observed in the current repository

The migration matrix shows several clear concentrations.

## Core Platform

The repository contains a coherent platform foundation around:

- system structure
- initialization
- task management
- LINKLIST / LPA / APF
- IPL / PARMLIB
- system libraries
- HCD/IODF baseline
- SDSF/operations
- change control
- rollback

These capabilities justify retaining a central Core Platform repository.

## Storage / DFSMS

Storage is already a substantial capability family:

- storage management
- DASD / ZVOL
- I/O paths
- Catalog / SMS
- DFSMS/SMS baseline
- SMS pool creation
- ACS allocation
- DFSMSrmm

Architecture V2 therefore treats `zos-storage-dfsms-engineering` as the strongest immediate repository-specialization candidate.

## Performance / Capacity

The repository already contains:

- WLM access
- WLM/RMF baseline
- SMF Type 99 / SRM / WLM decision analysis

This domain has enough direction to warrant a dedicated roadmap and is a strong candidate for future repository separation.

## Diagnostics

Existing LOGREC, dump, SYSLOG, and operational validation work establishes the beginnings of a dedicated diagnostics discipline.

Repository separation becomes stronger once IPCS, ABEND analysis, dump workflows, and controlled incident scenarios are added.

## Software Maintenance

SMP/E has one clear seed lab:

`labs/29-smpe-csi-query-sysmod-inventory`

This is enough to declare the domain but not enough to justify a dedicated repository yet.

## Sysplex / Availability

XCF/GRS/System Logger and XCF monoplex work establish the domain, but the current depth is still modest.

## Recovery

ADRDSSU backup/restore and batch restart/rerun already establish recovery as a real capability, but its long-term boundary with Storage, Workload, and Sysplex should remain under observation before creating another repository.

---

# Production Track 01 — Enterprise Batch Operations

Labs 30–39 are classified as a single emerging integration sequence rather than being redistributed as isolated domain labs.

```text
30 Enterprise Batch Processing Baseline
        |
31 COBOL Batch File Processing
        |
32 Multistep JCL / RC / Conditional Execution
        |
33 COBOL Validation / Reject Processing
        |
34 DFSORT Temporary Dataset Chaining
        |
35 GDG Batch Pipeline
        |
36 Restart / Rerun / Recovery
        |
37 JES2 Spool / JQE Housekeeping
        |
38 LOGREC / SMF Operational Validation
        |
39 SMF Type 99 / SRM / WLM Decision Analysis
```

The sequence already demonstrates the Architecture V2 principle:

**Domain repositories validate capabilities. Integration tracks prove that those capabilities work together.**

The historical labs remain in the current repository because the sequence itself is valuable evidence of the evolution from isolated platform exercises toward integrated operational engineering.

---

# Recommended repository-evolution decisions

## Keep Core Platform central

`zos-adcd-hercules-engineering-lab` should evolve toward a clearer Core Platform and Integration role.

It should continue to own:

- system initialization
- PARMLIB / PROCLIB foundations
- system libraries
- common platform configuration
- system-level change control
- shared operational baselines
- cross-domain integration tracks

## First specialization candidate

`zos-storage-dfsms-engineering`

Reason:

The current repository already contains a coherent set of Storage/DFSMS capabilities large enough to support an independent roadmap without inventing artificial content.

## Next specialization candidates

`zos-performance-capacity-engineering`

`zos-problem-determination-diagnostics`

These domains should gain several additional labs before historical content is formally referenced as a mature specialized line.

## Strategic domains to grow before repository creation

`zos-software-maintenance-smpe`

`zos-sysplex-availability-engineering`

`zos-availability-recovery-engineering`

---

# Migration policy

Architecture V2 favors **future specialization over historical relocation**.

Default policy:

```text
Historical lab stays where it was validated
        |
Architecture V2 classifies it
        |
Future domain work moves to the specialized roadmap
        |
Cross-repository documentation links both histories
```

This preserves:

- Git history
- existing URLs
- evidence locations
- chronological evolution
- current references
- the educational story of how the lab ecosystem matured

A historical move should happen only when a specific technical or maintainability reason outweighs those benefits.

---

# Review status

This matrix is the initial Architecture V2 classification baseline.

It should be reviewed when:

- a new domain repository is created;
- several labs materially deepen one domain;
- an existing repository changes responsibility;
- a production track is completed;
- a new z/OS facility becomes available in the lab environment;
- Architecture V2 evolves into a later architecture revision.

The matrix is intended to grow with the laboratory ecosystem.

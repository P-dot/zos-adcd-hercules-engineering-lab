# IBM z/OS Engineering Laboratory

Hands-on engineering environment built on **z/OS ADCD 1.11 running under Hercules**, organized as a connected portfolio of system programming, security, batch, storage, networking, UNIX and application laboratories.

The objective is not to maintain isolated exercises, but to model the platform as an integrated z/OS environment in which subsystems, applications and operational disciplines interact.

---

## Platform Scope

```text
                           z/OS ADCD 1.11
                                  |
                               Hercules
                                  |
        +-------------------------+-------------------------+
        |                         |                         |
     SYSTEM                    SECURITY                 APPLICATIONS
        |                         |                         |
   Core z/OS                  RACF / SAF                 COBOL
   JES2 / SDSF                SMF / Audit                CICS
   DFSMS / DASD               Hardening                  Db2
   WLM / RMF                                             REXX
   SMP/E                                                 PL/I
   XCF / GRS                                             HLASM
        |
        +-------------------------+
                                  |
                         BATCH ORCHESTRATION
                                  |
                       Scheduler -> JES2
                                  |
                         JCL / DFSORT / COBOL
                                  |
                    Temporary datasets / RC
                                  |
                      GDG / Restart / Recovery
                                  |
                  +---------------+---------------+
                  |                               |
                 USS                       Communications
          OMVS / zFS / POSIX            TCP/IP / VTAM
                                        TN3270 / Policy
```

---

## Engineering Domains

| Domain | Repository | Focus |
|---|---|---|
| Onboarding / TSO / ISPF | [MVS_TSO_ISPF](https://github.com/P-dot/MVS_TSO_ISPF) | TSO/E, ISPF navigation, interactive workflows and future ISPF automation |
| Core z/OS / System Programming | [zos-adcd-hercules-engineering-lab](https://github.com/P-dot/zos-adcd-hercules-engineering-lab) | IPL, PARMLIB, PROCLIB, JES2, SDSF, DFSMS, WLM, SMF, SMP/E, XCF/GRS |
| RACF / SAF Security | [mainframe-racf-security-evidence](https://github.com/P-dot/mainframe-racf-security-evidence) | Identity, authorization, audit, OPERCMDS, FACILITY, hardening |
| Communications Server | [zos-communications-server-network-lab](https://github.com/P-dot/zos-communications-server-network-lab) | TCP/IP, VTAM, TN3270, network services, security and diagnostics |
| UNIX System Services | [UNIX_System_Services-](https://github.com/P-dot/UNIX_System_Services-) | OMVS, shell, zFS, POSIX, MVS/USS integration |
| Batch Scheduler | [zos-bacth-scheduler](https://github.com/P-dot/zos-bacth-scheduler) | Native educational scheduler layer above JES2: ordering, state, dependencies, execution tracking and recovery |
| JCL / JES2 / Batch | [JCL_LABS](https://github.com/P-dot/JCL_LABS) | JOB/EXEC/DD, procedures, symbols, dataset processing |
| COBOL | [COBOL](https://github.com/P-dot/COBOL) | Compile/link, runtime, file processing and batch applications |
| VSAM | [vsam01](https://github.com/P-dot/vsam01) | VSAM datasets and access methods |
| Db2 for z/OS | [DB2-](https://github.com/P-dot/DB2-) | SQL, SPUFI, DDL/DML and application integration |
| CICS | [CICS](https://github.com/P-dot/CICS) | Transaction processing, runtime and diagnostics |
| REXX | [Rexx](https://github.com/P-dot/Rexx) | TSO/E and ISPF automation |
| PL/I | [PL-I](https://github.com/P-dot/PL-I) | PL/I application development |
| z/Architecture Assembler | [z_Assembly](https://github.com/P-dot/z_Assembly) | HLASM, storage definitions, linkage, execution and low-level z/OS programming |
| Integrated application lab | [mainframe-cobol-db2-cics-devops-lab](https://github.com/P-dot/mainframe-cobol-db2-cics-devops-lab) | Cross-component application and DevOps integration |

---

## Current Batch Architecture

The batch track is being developed as a progressive system, not as isolated JCL examples.

```text
JCL fundamentals
      |
Procedures / Symbols
      |
Sequential datasets
      |
COBOL compile / link
      |
COBOL batch I/O
      |
Multi-step jobs
      |
RETURN-CODE / conditional execution
      |
Multi-record processing
      |
VALID / REJECT routing
      |
DFSORT
      |
&&TEMP / PASS / DELETE
      |
Chained DFSORT -> COBOL processing
      |
GDG
      |
Restart / Recovery
      |
Scheduler / JES2 orchestration
      |
SMF / RACF / WLM / Db2 integration
```

### Recent integrated batch labs

- **Lab 31** — COBOL batch file processing
- **Lab 32** — Multi-step control and return-code driven flow
- **Lab 33** — Multi-record validation, counters, VALID/REJECT and RC 0/4/8
- **Lab 34** — DFSORT, temporary datasets and chained steps
- **Lab 35** — GDG batch pipeline integration
- **Lab 36** — Batch restart, rerun and idempotency
- **Lab 37** — JES2 spool and JQE controlled housekeeping
- **Lab 38** — LOGREC maintenance and SMF exit validation
- **Lab 39 Part 1** — SMF Type 99 SRM/WLM decision-data analysis
- **Next integration step** — Scheduler -> JES2 -> JCL orchestration

---

## Cross-Subsystem Integration

The long-term architecture connects system components instead of keeping them isolated.

```text
                          Scheduler
                              |
                              v
                            JES2
                              |
                              v
                             JCL
                              |
          +-------------------+-------------------+
          |                                       |
       DFSORT                                  BPXBATCH
          |                                       |
          v                                       v
       &&TEMP                                   USS
          |                                  OMVS / zFS
          v
        COBOL
       /     \
      v       v
   VALID    REJECT
      |
      v
     GDG
      |
      v
     Db2
      |
      v
 RC / Recovery
      |
 +----+----+
 |         |
RACF      SMF
 |         |
 +----+----+
      |
     WLM
```

---

## Engineering Method

Every lab follows the same operational cycle:

```text
Understand
    |
Configure
    |
Execute
    |
Observe
    |
Diagnose
    |
Correct
    |
Validate
    |
Document
    |
Integrate
```

Evidence is collected from the actual z/OS environment using combinations of:

- ISPF
- SDSF
- JES2 output
- system console
- RACF messages
- SMF data
- dataset contents
- application output
- subsystem diagnostics

---

## Repository Navigation

The canonical ecosystem architecture is maintained under:

- [Architecture index](docs/architecture/README.md)
- [Laboratory ecosystem](docs/architecture/LAB-ECOSYSTEM.md)
- [Learning paths](docs/architecture/LEARNING-PATHS.md)
- [Cross-repository lab chains](docs/architecture/CROSS-REPO-LAB-CHAINS.md)
- [System evolution](docs/architecture/SYSTEM-EVOLUTION.md)
- [Branching strategy](docs/architecture/BRANCHING-STRATEGY.md)
- [Integration roadmap](docs/architecture/INTEGRATION-ROADMAP.md)

Compatibility navigation:

- [Repository map](docs/REPOSITORIES.md)
- [Legacy ecosystem entry point](docs/ECOSYSTEM.md)

---

## Portfolio Goal

The purpose of this environment is to progressively reproduce, document and connect the engineering workflows found in a real z/OS installation within the practical limits of an ADCD/Hercules laboratory.

The portfolio therefore focuses on:

- system programming
- batch operations
- storage
- security
- observability
- networking
- UNIX System Services
- transaction processing
- database integration
- mainframe application development
- TSO/ISPF onboarding and automation
- low-level Assembler programming
- batch orchestration and recovery

---

## Disclaimer

This is a personal laboratory environment for technical learning and engineering practice. It does not represent a production IBM Z installation and is intentionally documented with publication-safe evidence.

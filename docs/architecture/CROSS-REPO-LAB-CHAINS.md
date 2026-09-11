# Cross-Repository Integration Tracks

These tracks define future end-to-end laboratories that combine capabilities already developed in separate repositories. Their purpose is integration, not duplication.

## Track A — z/OS New Starter

Repositories:

- MVS_TSO_ISPF
- JCL_LABS
- zos-adcd-hercules-engineering-lab

```text
TSO/E logon
→ ISPF navigation
→ data set/member work
→ SDSF
→ submit JCL
→ JES2 execution
→ interpret output
```

## Track B — ISPF Power User Automation

Repositories:

- MVS_TSO_ISPF
- Rexx

```text
manual ISPF task
→ identify repetition
→ REXX
→ ISPF services
→ repeatable automated task
```

## Track C — Scheduler + JCL + JES2

Repositories:

- zos-batch-scheduler
- JCL_LABS
- zos-adcd-hercules-engineering-lab

```text
scheduler definition
→ active order
→ eligibility
→ JES2 submission
→ JCL execution
→ JOBID / RC
→ scheduler state update
```

This should be the first major scheduler integration track.

## Track D — Secure Batch Application

Repositories:

- zos-batch-scheduler
- JCL_LABS
- COBOL
- vsam01
- mainframe-racf-security-evidence
- zos-adcd-hercules-engineering-lab

```text
Scheduler
→ JCL
→ COBOL
→ VSAM
→ RC
→ Scheduler
→ SMF
```

Security boundary:

```text
RACF
→ submit authority
→ data set authority
→ workload identity
```

## Track E — Batch Db2 Processing

Repositories:

- zos-batch-scheduler
- JCL_LABS
- COBOL
- DB2-

```text
Scheduler
→ JCL
→ COBOL batch
→ Db2
→ SQLCODE / RC
→ scheduler result
```

Negative scenario:

```text
JOB01 OK
→ JOB02 SQL/JCL failure
→ successor blocked
→ SDSF diagnosis
→ remediation
→ restart/rerun
```

## Track F — CICS Online Transaction

Repositories:

- CICS
- COBOL
- DB2-
- vsam01
- zos-communications-server-network-lab
- mainframe-racf-security-evidence

```text
TN3270
→ CICS
→ transaction
→ COBOL
→ Db2 / VSAM
→ response
```

## Track G — Secure Network Service / RACF-to-AT-TLS Handoff

Repositories:

- mainframe-racf-security-evidence
- zos-communications-server-network-lab
- zos-adcd-hercules-engineering-lab

Validated prerequisite chain:

```text
Communications Server Lab 09
certificate / key-ring inventory
        ↓
RACF Lab 31
cryptographic authorization baseline
        ↓
RACF Lab 32
controlled RACDCERT delegation
        ↓
RACF Lab 33
LAB33CERT + LAB33RING
```

Lab 33 leaves a controlled RACF-side cryptographic handoff state: the synthetic certificate, RACF-managed private key, dedicated key ring and certificate-to-ring association are retained, while temporary administrative delegation is removed.

Planned network integration:

```text
LAB33CERT + LAB33RING
        ↓
Communications Server
Policy Agent / PAGENT
        ↓
TTLSRule
        ↓
AT-TLS-enabled service
        ↓
controlled TLS connection
        ↓
TLS validation
        ↓
SMF / observability
```

Current boundary:

```text
RACF cryptographic identity     VALIDATED
Network consumption by AT-TLS  PLANNED
End-to-end TLS validation       PLANNED
SMF correlation                 PLANNED
```

The track must not present AT-TLS as active until the Communications Server policy, service binding and controlled connection test have been validated.

## Track H — Secure USS Service

Repositories:

- UNIX_System_Services-
- mainframe-racf-security-evidence
- zos-communications-server-network-lab

```text
RACF OMVS identity
→ USS UID/GID
→ file permissions
→ process/service
→ TCP/IP exposure
→ authorization / logging
```

## Track I — Storage Protection and Recovery

Repositories:

- zos-adcd-hercules-engineering-lab
- mainframe-racf-security-evidence
- vsam01

```text
DASD volume
→ cataloged data
→ VSAM / PS / PDS
→ RACF protection
→ ADRDSSU dump
→ controlled restore target
→ restore
→ catalog validation
→ content validation
→ security validation
```

## Track J — Scheduler Failure and Recovery

Repositories:

- zos-batch-scheduler
- JCL_LABS
- zos-adcd-hercules-engineering-lab

```text
Scheduler
→ JOB01 RC=0000
→ JOB02 ABEND / JCL ERROR / bad RC
→ chain stops
→ SDSF diagnosis
→ remediation
→ restart / rerun
→ successor released
→ history / audit
```

## Track K — Assembler Execution Pipeline

Repositories:

- z_Assembly
- JCL_LABS
- MVS_TSO_ISPF
- zos-adcd-hercules-engineering-lab

```text
Assembler source
→ HLASM
→ object module
→ link-edit
→ load module
→ JES2 execution
→ R15 / RC / SDSF evidence
```

Future progression:

```text
storage
→ addressing
→ macros
→ system control structures
→ diagnostic/system interfaces
```

## Track L — PL/I Enterprise Workload

Repositories:

- PL-I
- JCL_LABS
- DB2-
- CICS

```text
PL/I source
→ compile
→ link
→ execution
→ Db2 / CICS
```

## Track M — Integrated Application Delivery

Repository:

- mainframe-cobol-db2-cics-devops-lab

Consumes concepts from:

- COBOL
- DB2-
- CICS
- JCL_LABS
- mainframe-racf-security-evidence

```text
source
→ build
→ JCL
→ COBOL
→ Db2 / CICS
→ test
→ evidence
→ repeatable delivery
```

## Track N — Production Night Simulation

This should become a flagship integration laboratory.

```text
Scheduler
→ JOB01 IDCAMS / preparation
→ JOB02 COBOL + VSAM
→ JOB03 Db2 processing
→ JOB04 DFSORT / reporting
→ JOB05 backup / housekeeping
→ history / SMF / audit
```

Introduce one controlled failure:

```text
JOB03 failure
→ scheduler blocks successors
→ SDSF diagnosis
→ remediation
→ restart/rerun
→ production chain resumes
```

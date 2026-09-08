# z/OS Laboratory Ecosystem

## Purpose

The P-dot mainframe repositories form a progressive z/OS learning and engineering environment. Each repository has independent educational value, but the long-term architecture is designed around relationships between them.

The ecosystem is organized into ten functional domains:

1. Onboarding and self-training
2. Core z/OS system engineering
3. Security and authorization
4. Communications and network security
5. z/OS UNIX
6. Batch execution and orchestration
7. Application development and data
8. Low-level programming
9. Integrated application delivery
10. Cross-domain production simulation

## 1. Onboarding and self-training

### MVS_TSO_ISPF

Repository: `https://github.com/P-dot/MVS_TSO_ISPF`

Primary role:

- introduction to TSO/E
- ISPF navigation
- 3270-oriented work
- data set and member interaction
- operational navigation
- preparation for SDSF
- progression toward REXX and ISPF automation

This repository supports both a new z/OS team member and an experienced MVS/TSO/ISPF user who wants to improve productivity and move toward automation.

```text
TSO/E
  |
  v
ISPF
  |
  v
Data sets / members
  |
  v
SDSF / utilities
  |
  v
REXX
  |
  v
ISPF services
  |
  v
Operational automation
```

It acts as the natural entry point into the rest of the ecosystem.

## 2. Core z/OS system engineering

### zos-adcd-hercules-engineering-lab

Repository: `https://github.com/P-dot/zos-adcd-hercules-engineering-lab`

Role:

- z/OS system structure and initialization
- address-space and task observation
- storage and DASD engineering
- I/O subsystem
- XCF / GRS
- problem determination
- JES2 engineering
- z/OS UNIX / zFS
- LOGREC
- SMF
- WLM / SRM observation
- restart/rerun behavior
- backup and recovery
- system-level integration

This repository is the infrastructure foundation of the ecosystem.

## 3. Security and authorization

### mainframe-racf-security-evidence

Repository: `https://github.com/P-dot/mainframe-racf-security-evidence`

Role:

- RACF users and groups
- SAF-based access control
- data set protection
- least privilege
- controlled delegation
- access review
- OPERCMDS
- UNIX security integration
- auditing
- Health Checker
- SMF-related evidence
- positive and negative access validation
- rollback/remediation

RACF is a cross-cutting control that interacts with TSO/E, JES2, scheduler execution, data sets, VSAM, USS, Communications Server, operator commands, CICS, Db2 and started tasks.

## 4. Communications and network security

### zos-communications-server-network-lab

Repository: `https://github.com/P-dot/zos-communications-server-network-lab`

Role:

- Communications Server
- TCP/IP configuration
- service exposure review
- TN3270
- FTP
- USS network services
- authorization review
- certificates and RACF key rings
- SMF logging readiness
- hardening and rollback

```text
RACF / SAF
     |
     v
Communications Server
     |
     v
TCP/IP services
     |
     v
TN3270 / FTP / USS services
     |
     v
SMF / audit evidence
```

## 5. z/OS UNIX

### UNIX_System_Services-

Repository: `https://github.com/P-dot/UNIX_System_Services-`

Role:

- OMVS and shell usage
- files and directories
- UNIX permissions
- processes
- zFS-oriented work
- bridge between MVS and POSIX-style operation

```text
TSO/ISPF
   |
   v
OMVS / shell
   |
   v
USS files / processes
   |
   +---- RACF OMVS identity
   |
   +---- TCP/IP services
   |
   +---- REXX / scripting
```

## 6. Batch execution and orchestration

### JCL_LABS

Repository: `https://github.com/P-dot/JCL_LABS`

Role:

- JOB / EXEC / DD
- procedures and symbolics
- PS / PDS
- utilities
- IDCAMS
- GDG
- allocation and data set lifecycle
- batch resource definition

JCL describes what JES2 must execute.

### zos-batch-scheduler

Current repository: `https://github.com/P-dot/zos-bacth-scheduler`

Recommended canonical name: `https://github.com/P-dot/zos-batch-scheduler`

Role:

- educational native batch scheduler
- job definitions
- active state
- ordering
- time eligibility
- conditions and dependencies
- resources
- JES2 submission
- JOBID and execution tracking
- RC / ABEND classification
- HOLD / FREE
- restart / rerun
- calendars and logical production day
- history
- ISPF active environment
- started-task monitor
- RACF integration
- SMF observability
- event-driven triggering

JES2 remains the execution engine. The scheduler is the production-control layer above JES2.

```text
JOB DEFINITIONS
      |
      v
   ORDERING
      |
      v
 ACTIVE JOBS
      |
 +----+----------+---------+
 |               |         |
TIME        CONDITIONS  RESOURCES
 |               |         |
 +---------------+---------+
                 |
                 v
               JES2
                 |
                 v
                JCL
                 |
        +--------+--------+
        |        |        |
      COBOL    DFSORT    USS
        |        |        |
        +--------+--------+
                 |
             RC / ABEND
                 |
                 v
        HISTORY / AUDIT
```

## 7. Application development and data

### COBOL

Repository: `https://github.com/P-dot/COBOL`

Relationships:

```text
COBOL
  |
  +---- JCL
  +---- VSAM
  +---- Db2
  +---- CICS
```

### VSAM

Repository: `https://github.com/P-dot/vsam01`

Role:

- ESDS
- KSDS
- RRDS
- LDS
- IDCAMS
- catalog interaction
- batch access
- validation and rollback

```text
JCL
 |
 v
IDCAMS
 |
 v
VSAM cluster
 |
 v
COBOL workload
```

### Db2

Repository: `https://github.com/P-dot/DB2-`

Role:

- subsystem and catalog foundations
- SPUFI
- SQL
- DDL / DML
- subqueries and aggregation
- constraints
- application data

```text
COBOL ----> Db2

CICS
 |
 v
COBOL ----> Db2

Scheduler
 |
 v
JCL
 |
 v
batch workload ----> Db2
```

### CICS

Repository: `https://github.com/P-dot/CICS`

Role:

- transaction processing
- runtime resources
- CECI / CEDF
- 3270 interaction
- BMS
- online application execution

```text
TN3270
   |
   v
 CICS
   |
   v
transaction
   |
   v
COBOL
   |
   +---- Db2
   +---- VSAM
```

### REXX

Repository: `https://github.com/P-dot/Rexx`

Role:

- TSO/E scripting
- repeatable operations
- command processing
- ISPF-service integration
- system and application administration support

```text
MVS_TSO_ISPF
      |
      v
     REXX
      |
      v
ISPF services
      |
      v
automation
```

Future targets include scheduler administration, Db2, USS, system inspection and JCL generation.

### PL/I

Repository: `https://github.com/P-dot/PL-I`

Role:

- Enterprise PL/I programming
- JCL-driven compilation
- link-edit
- execution
- future Db2 and CICS integration

## 8. Low-level programming

### z_Assembly

Repository: `https://github.com/P-dot/z_Assembly`

Role:

- z/Architecture concepts
- High Level Assembler
- storage representation
- instruction-level behavior
- assembly
- link-edit
- load modules
- runtime return codes
- progression toward systems-programming concepts

```text
source
  |
  v
HLASM
  |
  v
object module
  |
  v
link-edit
  |
  v
load module
  |
  v
execution
```

Assembler occupies two positions in the ecosystem:

1. programming language track
2. bridge toward deeper systems programming

## 9. Integrated application and DevOps track

### mainframe-cobol-db2-cics-devops-lab

Repository: `https://github.com/P-dot/mainframe-cobol-db2-cics-devops-lab`

Role:

- application integration
- build flow
- COBOL / Db2 / CICS interaction
- repeatable delivery

This repository should consume skills proven in the foundational repositories instead of duplicating their introductory labs.

## 10. Ecosystem architecture

```text
                       z/OS LAB ECOSYSTEM
                              |
        +---------------------+----------------------+
        |                     |                      |
   ONBOARDING          SYSTEM ENGINEERING        OPERATIONS
        |                     |                      |
 MVS_TSO_ISPF     zos-adcd-hercules...        Scheduler
        |             |   |   |   |              |
        |           JES2 DASD USS SMF             |
        |             |   |   |   |              |
        +--------+----+   |   |   +--------------+
                 |        |   |
                JCL       |   +---- RACF
                 |        |           |
      +----------+--------+       Communications
      |          |        |           |
    COBOL      REXX      PL/I       TCP/IP
      |          |                    |
      +-- VSAM --+                  TN3270/FTP
      |
      +-- Db2
      |
      +-- CICS

               z_Assembly
                   |
            HLASM / linkage
                   |
          low-level z/OS concepts
                   |
             system engineering

       mainframe-cobol-db2-cics-devops-lab
                   |
           integrated delivery track
```

## Architectural objective

The ecosystem should evolve from independent technology labs toward technology-specific foundations plus cross-repository integration, security, observability, failure handling, recovery and documented evidence.

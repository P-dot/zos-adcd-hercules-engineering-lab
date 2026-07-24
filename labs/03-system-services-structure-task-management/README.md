# LAB03 - z/OS System Services Structure: Task Management

## Course alignment

IBM Course: **DL00EZ20IG - z/OS System Services Structure**  
Unit: **UNIT 3 - Task management**

Related sections:

- 3:1 - Introduction and Submitting Jobs
- 3:2 - Enclaves, PR/SM and CPU Management
- 3:3 - Address Spaces Revisited
- 3:4 - Dynamic Linkage
- 3:5 - SVCs and Program Authorization

## Objective

Observe how a running ADCD z/OS system organizes work through SDSF, JES2, address spaces, initiators, WLM, LINKLIST, and APF authorization.

This lab maps the theoretical task-management concepts from the course to non-destructive operator evidence collected from a real ADCD/Hercules environment.

## Environment

- Platform: ADCD z/OS on Hercules
- System name: ADCD
- Access method: 3270 / SDSF / MCS console
- Lab type: non-destructive operator observation

## Commands executed

SDSF panels:

```text
DA
ST
H
O
```

Operator commands issued from SDSF:

```text
/D A,L
/$D A
/$D JOBQ
/$D INIT
/D WLM
/D PROG,LNKLST
/D PROG,APF
```

The same operator commands can be issued from the master console without the leading slash.

## Evidence overview

A contact sheet is included for quick visual review:

![LAB03 contact sheet](evidence/lab03_contact_sheet.jpg)

## Evidence and findings

### 1. SDSF DA - active address spaces

Command:

```text
DA
```

Evidence:

![SDSF DA part 1](evidence/screenshots/01_sdsf_da_part_1.png)
![SDSF DA part 2](evidence/screenshots/02_sdsf_da_part_2.png)

Observed examples:

```text
*MASTER*
PCAUTH
RASP
TRACE
DUMPSRV
XCFAS
GRS
WLM
OMVS
JES2
RACF
VTAM
TCPIP
TN3270
SDSF
CICSA
DB9GMSTR
DB9GDBM1
DB9GIRLM
DB9GDIST
CSQ7MSTR
HTTPD1
FTPD1
SSHD4
IBMUSER
```

Interpretation:

SDSF `DA` shows the major address spaces active in the system. This evidence connects to **3:3 - Address Spaces Revisited** and demonstrates the coexistence of system address spaces, started tasks, subsystem address spaces, and TSO user work.

---

### 2. SDSF ST - status display and JES2-managed work

Command:

```text
ST
```

Evidence:

![03_sdsf_status_display_part_01](evidence/screenshots/03_sdsf_status_display_part_01.png)
![04_sdsf_status_display_part_02](evidence/screenshots/04_sdsf_status_display_part_02.png)
![05_sdsf_status_display_part_03](evidence/screenshots/05_sdsf_status_display_part_03.png)
![06_sdsf_status_display_part_04](evidence/screenshots/06_sdsf_status_display_part_04.png)
![07_sdsf_status_display_part_05](evidence/screenshots/07_sdsf_status_display_part_05.png)
![08_sdsf_status_display_part_06](evidence/screenshots/08_sdsf_status_display_part_06.png)
![09_sdsf_status_display_part_07](evidence/screenshots/09_sdsf_status_display_part_07.png)
![10_sdsf_status_display_part_08](evidence/screenshots/10_sdsf_status_display_part_08.png)
![11_sdsf_status_display_part_09](evidence/screenshots/11_sdsf_status_display_part_09.png)
![12_sdsf_status_display_part_10](evidence/screenshots/12_sdsf_status_display_part_10.png)
![13_sdsf_status_display_part_11](evidence/screenshots/13_sdsf_status_display_part_11.png)
![14_sdsf_status_display_part_12](evidence/screenshots/14_sdsf_status_display_part_12.png)
![15_sdsf_status_display_part_13](evidence/screenshots/15_sdsf_status_display_part_13.png)
![16_sdsf_status_display_part_14](evidence/screenshots/16_sdsf_status_display_part_14.png)
![17_sdsf_status_display_part_15](evidence/screenshots/17_sdsf_status_display_part_15.png)
![18_sdsf_status_display_part_16](evidence/screenshots/18_sdsf_status_display_part_16.png)
![19_sdsf_status_display_part_17](evidence/screenshots/19_sdsf_status_display_part_17.png)
![20_sdsf_status_display_part_18](evidence/screenshots/20_sdsf_status_display_part_18.png)
![21_sdsf_status_display_part_19](evidence/screenshots/21_sdsf_status_display_part_19.png)

Interpretation:

SDSF `ST` provides a status view of jobs, started tasks, TSO users, execution state, print output, and spool-related entries. This supports **3:1 - Introduction and Submitting Jobs** by showing how work appears under JES2/SDSF control.

---

### 3. SDSF H - held output

Command:

```text
H
```

Evidence:

![SDSF held output](evidence/screenshots/22_sdsf_held_output_display.png)

Interpretation:

SDSF `H` shows held output. In this lab, held output includes several IBMUSER entries retained locally, demonstrating how job and TSO output can remain available for review in spool.

---

### 4. SDSF O - output display

Command:

```text
O
```

Evidence:

![SDSF output part 1](evidence/screenshots/23_sdsf_output_display_part_01.png)
![SDSF output part 2](evidence/screenshots/24_sdsf_output_display_part_02.png)
![SDSF output part 3](evidence/screenshots/25_sdsf_output_display_part_03.png)

Interpretation:

SDSF `O` shows output available through the spool. The screenshots show SDSF and SYSLOG-related output entries, which is useful operator evidence for understanding JES2 output handling.

---

### 5. Operator display of active work

Command:

```text
D A,L
```

Evidence:

![D A,L](evidence/screenshots/26_d_a_l_operator_display.png)

Observed examples:

```text
JES2
VTAM
RACF
TSO
TCPIP
TN3270
DB9GMSTR
DB9GIRLM
CICSA
HTTPD1
CSQ7MSTR
SSHD4
FTPD1
IBMUSER
```

Interpretation:

`D A,L` confirms active address spaces from the operator-command perspective. It complements SDSF `DA` and proves that the same task-management picture can be observed from system commands.

---

### 6. JES2 active work

Command:

```text
$D A
```

Evidence:

![JES2 D A](evidence/screenshots/27_jes2_d_a_no_active_jobs.png)

Observed finding:

```text
$HASP612 NO ACTIVE JOBS
```

Interpretation:

JES2 was active, but no batch jobs were active at the moment the command was issued. This is a normal state and not a fault.

---

### 7. JES2 job queue

Command:

```text
$D JOBQ
```

Evidence:

![JES2 D JOBQ](evidence/screenshots/28_jes2_d_jobq_mascomm.png)

Observed finding:

```text
$HASP890 JOB($MASCOMM) STATUS=(AWAITING HARDCOPY), CLASS=A, PRIORITY=15
```

Interpretation:

The command shows JES2 queue information. This supports the course section about job submission and JES2-managed workload.

---

### 8. JES2 initiators

Command:

```text
$D INIT
```

Evidence:

![JES2 D INIT part 1](evidence/screenshots/29_jes2_d_init_part_1.png)
![JES2 D INIT part 2](evidence/screenshots/30_jes2_d_init_part_2.png)

Observed findings:

```text
INIT(1) STATUS=INACTIVE, CLASS=A
INIT(2) STATUS=INACTIVE, CLASS=AB
```

Interpretation:

The system has JES2 initiators defined. They are inactive at the time of the display. This is important because initiators are the execution mechanism used by JES2 to run batch jobs.

---

### 9. WLM status

Command:

```text
D WLM
```

Evidence:

![D WLM](evidence/screenshots/31_d_wlm_policy_status.png)

Observed findings:

```text
Active WLM service policy: ETPBASE
Description: ETP WLM Policy w/DB2 StoredProcs
WLM version level: LEVEL023
WLM functionality level: LEVEL006
```

Interpretation:

WLM is active with policy `ETPBASE`. This connects to **3:2 - Enclaves, PR/SM and CPU Management**, because WLM is the component that manages service goals and workload classification.

---

### 10. Dynamic linkage - LINKLIST

Command:

```text
D PROG,LNKLST
```

Evidence:

![D PROG,LNKLST](evidence/screenshots/32_d_prog_lnklist.png)

Observed examples:

```text
LNKLST SET LNKLST00
LNKAUTH=LNKLST
SYS1.LINKLIB
SYS1.MIGLIB
SYS1.CSSLIB
USER.LINKLIB
```

Interpretation:

LINKLIST is the system search path for executable modules. This evidence maps directly to **3:4 - Dynamic Linkage**.

---

### 11. SVCs and program authorization - APF

Command:

```text
D PROG,APF
```

Evidence:

![D PROG,APF](evidence/screenshots/33_d_prog_apf.png)

Observed examples:

```text
FORMAT=DYNAMIC
SYS1.LINKLIB
SYS1.SVCLIB
SYS1.SHASLNKE
SYS1.MIGLIB
TCPIP.SEZATCP
SYS1.VTAMLIB
```

Interpretation:

APF identifies authorized libraries. Programs loaded from APF-authorized libraries can perform privileged operations when other authorization conditions are also met. This evidence maps to **3:5 - SVCs and Program Authorization**.

---

## Safety notes

This lab uses display-only commands. It does not start, stop, cancel, vary, force, or modify system resources.

Commands intentionally not used:

```text
P
C
S
CANCEL
FORCE
START
STOP
F
$P
$C
$S
SETPROG
```

## Conclusion

This lab validates task-management concepts from IBM z/OS System Services Structure UNIT 3 using a real ADCD/Hercules environment. It demonstrates active address spaces, JES2-managed work, held and output queues, job queue status, initiators, WLM policy status, dynamic LINKLIST configuration, and APF-authorized libraries.

The screenshots provide direct operational evidence suitable for a mainframe engineering portfolio.

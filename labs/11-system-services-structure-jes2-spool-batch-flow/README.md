# LAB11 - z/OS System Services Structure: JES2, Spool and Batch Flow

## Course alignment

IBM Course: DL00EZ20IG - z/OS System Services Structure  
Lab topic: JES2, spool and batch flow observation

This lab documents how a running z/OS ADCD system exposes JES2 workload, job queues, initiators, spool configuration and output definitions through SDSF and non-destructive operator commands.

## Objective

Observe JES2 and batch flow from an operator perspective without changing the system.

The lab validates:

- JES2 activity display
- JES2 job queue status
- JES2 initiator status
- JES2 spool volume usage
- JES2 spool definition
- JES2 job definition parameters
- JES2 output definition parameters
- Active z/OS address spaces
- Pending message status
- MCS console status

## Environment

- Platform: ADCD z/OS on Hercules
- System name: ADCD
- Console: L700
- Access method: 3270 / SDSF / MCS console
- Scope: read-only operator observation

## Commands executed

```text
/$D A
/$D JOBQ
/$D INIT
/$D SPOOL
/$D SPOOLDEF
/$D JOBDEF
/$D OUTDEF
/D A,L
/D R,L
/D C,L
```

## Evidence

| Evidence | Description |
|---|---|
| `01_jes2_d_a_no_active_jobs.png` | JES2 activity display showing no active batch jobs at capture time. |
| `02_jes2_d_jobq_mascomm.png` | JES2 job queue entry for `$MASCOMM`, awaiting hardcopy. |
| `03_jes2_d_init_status.png` | JES2 initiator status. |
| `04_jes2_d_spool_status.png` | JES2 spool volumes and utilization. |
| `05_jes2_d_spooldef.png` | JES2 spool definition and space values. |
| `06_jes2_d_jobdef.png` | JES2 job definition parameters. |
| `07_jes2_d_outdef.png` | JES2 output definition parameters. |
| `08_d_a_l_activity.png` | z/OS activity display with active address spaces. |
| `09_d_r_l_no_messages.png` | Pending requests display. |
| `10_d_c_l_console_status.png` | MCS console status for L700. |

## Findings

### JES2 activity

The JES2 activity display returned:

```text
$HASP612 NO ACTIVE JOBS
```

This means JES2 was active, but no batch jobs were running at the moment of capture.

### JES2 job queue

The job queue showed `$MASCOMM` with status:

```text
STATUS=(AWAITING HARDCOPY)
CLASS=A
PRIORITY=15
SYSAFF=(ANY)
HOLD=(NONE)
```

This confirms that the JES2 job queue is available and can be inspected from the operator interface.

### JES2 initiators

The initiator display showed an initiator defined but inactive at the time of capture:

```text
INIT(1) STATUS=INACTIVE, CLASS=A
```

This connects JES2 queue management with batch initiator execution.

### JES2 spool

The spool display showed active spool volumes:

```text
VOLUME(SBSYS1) STATUS=ACTIVE, PERCENT=62
VOLUME(SBSYS9) STATUS=ACTIVE, PERCENT=1
```

This confirms that JES2 spool is active and distributed across visible spool volumes.

### JES2 spool definition

The spool definition showed:

```text
DSNAME=SYS1.HASPACE
VOLUME=SBSYS1
BUFSIZE=3856
TGSPACE=(MAX=32576,DEFINED=18000,ACTIVE=18000,PERCENT=10.8555,FREE=16046,WARN=80)
```

This identifies `SYS1.HASPACE` as the spool dataset and documents available spool capacity and warning threshold.

### JES2 job definition

The job definition display showed parameters including job numbering, priority range and duplicate job handling:

```text
JOBNUM=1000
JOBWARN=90
PRTYHIGH=10
PRTYLOW=0
DUPL_JOB=DELAY
RANGE=(1,9999)
```

### JES2 output definition

The output definition display showed output-related parameters including copies, JOE values, priority range and standard form:

```text
COPIES=30
JOENUM=1500
JOEFREE=544
JOEWARN=80
PRTYLOW=0
PRTYHIGH=255
STDFORM=STD
```

### z/OS system activity

The system activity display confirmed that the system was active and running key services such as JES2, RACF, TSO, VTAM, TCPIP, TN3270, DB2, CICS, HTTPD, SSHD, FTPD and IBMUSER.

### Pending messages

The pending requests display showed:

```text
NO MESSAGES OUTSTANDING
```

No operator reply was required at the time of capture.

### Console status

Console `L700` was active as an MCS console with MASTER authority and SYSLOG hardcopy logging.

## Non-destructive scope

No JES2 parameters were changed. The lab avoided commands such as:

```text
$P
$C
$S
$T
$Z
PURGE
CANCEL
FORCE
START
STOP
MODIFY
```

## Conclusion

This lab demonstrates a read-only JES2 operator workflow in a real ADCD/Hercules z/OS environment. It validates batch workload visibility, JES2 queue inspection, initiator status, spool capacity, job/output definitions, system activity, pending message status and active console status.

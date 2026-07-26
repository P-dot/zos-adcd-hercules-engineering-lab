# LAB06 - z/OS System Services Structure: Problem Determination, LOGREC and Dumps

## Course alignment

IBM Course: DL00EZ20IG - z/OS System Services Structure  
Unit area: Problem determination, Recovery Termination Manager, SYSLOG, LOGREC, dumps, SLIP and trace support.

## Objective

Document how a running ADCD z/OS system exposes diagnostic information using non-destructive operator displays and SDSF. The lab focuses on SYSLOG, LOGREC evidence, pending message status, console status, dump configuration, SLIP traps, trace status and active address spaces.

## Environment

- Platform: ADCD z/OS on Hercules
- System name: ADCD
- Console: L700
- Access method: 3270 / SDSF
- Evidence source: LAB06_source.docx

## Commands executed

```text
LOG
/D R,L
/D C,L
/D DUMP
/D SLIP
/D TRACE
/D A,L
```

The SDSF `LOG` panel was used to search for diagnostic messages related to LOGREC, including `IFB081I`, `LOGREC` and `SYS1.LOGREC`.

## Evidence captured

```text
evidence/screenshots/01_sdsf_log_ifb081i_logrec.png
evidence/screenshots/02_sdsf_log_logrec_search.png
evidence/screenshots/03_sdsf_log_logrec_context.png
evidence/screenshots/04_d_r_l_no_messages.png
evidence/screenshots/05_d_c_l_console_status.png
evidence/screenshots/06_d_dump_status.png
evidence/screenshots/07_d_slip_display.png
evidence/screenshots/08_d_trace_display.png
evidence/screenshots/09_d_a_l_activity.png
```

A contact sheet is also included at:

```text
evidence/lab06_contact_sheet.jpg
```

## Key findings

### SYSLOG and LOGREC evidence

SDSF SYSLOG was used to locate LOGREC-related messages. The evidence includes a visible `IFB081I LOGREC DATA SET` message and references to `SYS1.LOGREC`. This documents the system's problem-recording evidence source without making any corrective change.

### Pending requests

`D R,L` showed:

```text
RM=0 IM=0 CEM=0 EM=0 RU=0 IR=0
NO MESSAGES OUTSTANDING
```

This indicates that no operator reply was pending at the time of capture.

### Console status

`D C,L` confirmed console `L700` as an active MCS console with `AUTH=(MASTER)` and hardcopy log routed to `SYSLOG`.

### Dump status

`D DUMP` showed:

```text
SYS1.DUMP DATA SETS AVAILABLE=000 AND FULL=000
CAPTURED DUMPS=0000
AUTOMATIC ALLOCATION IS: ACTIVE
AVAILABLE DASD VOLUMES: SBSYS1
NAME=SYS1.&SYSNAME..DMP&SEQ
EXAMPLE=SYS1.ADCD.DMP00000
```

The system has dynamic dump allocation active and SBSYS1 available for automatically allocated dump data sets.

### SLIP display

`D SLIP` displayed several enabled SLIP entries. These are diagnostic traps used to capture specific error or event conditions. The lab only documents their presence.

### Trace status

`D TRACE` showed system trace information with tracing active. This confirms that tracing support is visible from the operator interface.

### System activity

`D A,L` confirmed that the ADCD system was active with system address spaces and subsystems running, including JES2, VTAM, RACF, TCPIP, TN3270, Db2, CICS, MQ-related address spaces and IBMUSER.

## Safety notes

This lab is read-only. No dump, trace, SLIP, VARY, START, STOP, CANCEL, FORCE or configuration-changing command was issued.

Commands intentionally avoided:

```text
DUMP
CHNGDUMP
DUMPDS CLEAR
DUMPDS DEL
SLIP SET
TRACE CT
TRACE ST
TRACE MT
WRITELOG
IPCS
CANCEL
FORCE
VARY
START
STOP
```

## Conclusion

This lab validates the basic problem-determination visibility of the ADCD z/OS environment. It demonstrates how an operator can use SDSF SYSLOG and non-destructive display commands to inspect LOGREC evidence, pending messages, console state, dump allocation status, SLIP traps, trace status and active system work.

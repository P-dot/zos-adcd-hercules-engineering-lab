# LAB13 - z/OS System Services Structure: Console, SYSLOG and Message Handling

## Course alignment

IBM Course: DL00EZ20IG - z/OS System Services Structure  
Lab focus: operator-level review of console state, SYSLOG, message handling, JES2 messages and IPL context.

This lab connects previous System Services Structure topics into one operational message-handling exercise:

- MCS console status
- Hardcopy log / SYSLOG
- SDSF LOG navigation
- Historical system messages
- LOGREC-related messages
- IEE initialization messages
- JES2 `$HASP` messages
- Pending replies and outstanding messages
- System activity and IPL context

## Objective

Build a safe, repeatable, operator-level procedure for reviewing system messages without changing configuration. The lab demonstrates that an operator can inspect SYSLOG, search for important message families, distinguish historical messages from current pending replies, and verify the console and system context before taking action.

## Environment

- Platform: ADCD z/OS on Hercules
- System name observed: ADCD
- z/OS release observed: 01.11.00
- Console observed: L700
- Hardcopy log observed: SYSLOG
- Access method: SDSF / MCS console

## Commands and searches executed

```text
LOG

IFB081I
LOGREC
IEE
$HASP

/D C,L
/D R,L
/D A,L
/$D A
/$D JOBQ
/D IPLINFO
```

## Evidence

| Evidence | Description |
|---|---|
| `evidence/screenshots/01_sdsf_syslog_general_hasp_purged_and_pending_request.png` | General SDSF SYSLOG context with JES2 messages and a prior D R,L entry. |
| `evidence/screenshots/02_sdsf_syslog_ifb081i_logrec_found_startup_context.png` | SYSLOG search for IFB081I showing LOGREC data set message. |
| `evidence/screenshots/03_sdsf_syslog_ifb081i_logrec_page_datasets_part_1.png` | IFB081I / LOGREC context around initialization and page data set messages. |
| `evidence/screenshots/04_sdsf_syslog_ifb081i_logrec_page_datasets_part_2.png` | Additional IFB081I / LOGREC context in SYSLOG. |
| `evidence/screenshots/05_sdsf_syslog_ifb081i_logrec_page_datasets_part_3.png` | Additional IFB081I / LOGREC context in SYSLOG. |
| `evidence/screenshots/06_sdsf_syslog_ifb081i_logrec_page_datasets_part_4.png` | Additional IFB081I / LOGREC context in SYSLOG. |
| `evidence/screenshots/07_sdsf_syslog_ifb081i_logrec_page_datasets_part_5.png` | Additional IFB081I / LOGREC context in SYSLOG. |
| `evidence/screenshots/08_sdsf_syslog_logrec_search_xcf_grs_context_part_1.png` | LOGREC search context around XCF, GRS and page data set initialization. |
| `evidence/screenshots/09_sdsf_syslog_logrec_search_xcf_grs_context_part_2.png` | LOGREC search context around XCF, GRS and sysplex initialization. |
| `evidence/screenshots/10_sdsf_syslog_logrec_dump_capturetime_part_1.png` | LOGREC search context showing dump capture time / related procedure messages. |
| `evidence/screenshots/11_sdsf_syslog_logrec_dump_capturetime_part_2.png` | Additional dump capture time context from SYSLOG. |
| `evidence/screenshots/12_sdsf_syslog_logrec_dump_capturetime_part_3.png` | Additional dump capture time context from SYSLOG. |
| `evidence/screenshots/13_sdsf_syslog_logrec_dump_capturetime_part_4.png` | Additional dump capture time context from SYSLOG. |
| `evidence/screenshots/14_sdsf_syslog_logrec_page_datasets_and_sysplex_context.png` | LOGREC context showing page data sets and sysplex messages. |
| `evidence/screenshots/15_sdsf_syslog_logrec_dump_capturetime_part_5.png` | Additional LOGREC / dump capture time context. |
| `evidence/screenshots/16_sdsf_syslog_logrec_dump_capturetime_part_6.png` | Additional LOGREC / dump capture time context. |
| `evidence/screenshots/17_sdsf_syslog_iee_ipl_initialization_part_1.png` | IEE search showing IPL initialization, IPLPARM, IODF and system symbols. |
| `evidence/screenshots/18_sdsf_syslog_iee_static_symbols_and_page_datasets.png` | IEE search showing static system symbols and page data sets. |
| `evidence/screenshots/19_sdsf_syslog_iee_xcf_grs_sysplex_initialization.png` | IEE search showing XCF, GRS and sysplex initialization messages. |
| `evidence/screenshots/20_sdsf_syslog_hasp_jes2_checkpoint_and_spool_part_1.png` | $HASP search showing JES2 checkpoint and spool initialization context. |
| `evidence/screenshots/21_sdsf_syslog_hasp_jes2_checkpoint_and_spool_part_2.png` | $HASP search showing JES2 checkpoint and cold start context. |
| `evidence/screenshots/22_sdsf_syslog_hasp_jes2_cold_start_part_1.png` | $HASP search showing JES2 cold start and checkpoint activity. |
| `evidence/screenshots/23_sdsf_syslog_hasp_jes2_cold_start_part_2.png` | $HASP search showing JES2 cold start and SYSLOG activation context. |
| `evidence/screenshots/24_sdsf_syslog_hasp_jes2_started_tasks_and_init.png` | $HASP search showing started tasks and initiator activity. |
| `evidence/screenshots/25_d_c_l_console_status.png` | D C,L output: console L700 active and hardcopy log SYSLOG. |
| `evidence/screenshots/26_d_r_l_no_messages_outstanding.png` | D R,L output: no outstanding messages or replies. |
| `evidence/screenshots/27_d_a_l_system_activity.png` | D A,L output: system activity and active address spaces. |
| `evidence/screenshots/28_jes2_d_a_no_active_jobs.png` | $D A output: no active JES2 jobs. |
| `evidence/screenshots/29_jes2_d_jobq_mascomm.png` | $D JOBQ output: $MASCOMM awaiting hardcopy. |
| `evidence/screenshots/30_d_iplinfo_context.png` | D IPLINFO output: IPL context for the message review. |

A contact sheet is also included at:

```text
evidence/lab13_contact_sheet.jpg
```

## Findings

### SYSLOG and hardcopy log review

SDSF LOG was used as the main historical message source. The evidence shows SYSLOG entries for JES2 activity, system initialization, LOGREC messages, and operator display commands.

### LOGREC message evidence

The SYSLOG search shows the recurring LOGREC message:

```text
IFB081I LOGREC DATA SET
DSN=SYS1.LOGREC
```

This is an operational finding, not a reply request. It should be documented and handled through a maintenance procedure, not answered with `R`.

### IEE initialization messages

The SYSLOG search for `IEE` shows initialization context such as:

```text
SYS1.IPLPARM ON DEVICE 0A82 SELECTED FOR IPL
IODF device information
IEASYS / IEASYM members
Static system symbol values
Page data sets in use
```

This demonstrates that SYSLOG can be used to reconstruct important parts of the IPL and initialization timeline.

### JES2 `$HASP` messages

The SYSLOG search for `$HASP` shows JES2 initialization and operational messages, including checkpoint and spool activity, cold start progress, started tasks and initiator-related messages.

### Pending replies and outstanding messages

The `D R,L` output shows:

```text
RM=0
IM=0
CEM=0
EM=0
RU=0
IR=0
NO MESSAGES OUTSTANDING
```

This confirms that there were no outstanding messages or pending replies at the time of capture.

### Console status

The `D C,L` output confirms:

```text
Console: L700
Type: MCS
Status: ACT-ADCD
Hardcopy log: SYSLOG
Authority: MASTER
```

### System and JES2 context

The `D A,L`, `$D A`, `$D JOBQ` and `D IPLINFO` outputs confirm that the system was active, JES2 was responsive, no jobs were active at that moment, `$MASCOMM` was awaiting hardcopy, and the IPL context was available.

## Operational distinction

This lab documents the difference between three message situations:

```text
Informational message:
    Records an event. No operator reply is required.

Action message:
    Requires attention, but not necessarily a reply.

Reply pending:
    Only answered when D R,L shows a real reply request.
```

The LOGREC message is important, but it is not a command to issue `R xx,...`.

## Safety notes

Only display and review commands were used. No configuration changes were made.

Commands intentionally avoided:

```text
R xx,...
K
VARY
START
STOP
CANCEL
FORCE
$P
$C
$S
$T
WRITELOG
```

## Conclusion

This lab validates a safe operator workflow for console and message handling in the ADCD z/OS environment. It shows how to review SYSLOG, locate LOGREC and JES2 messages, confirm the active console, verify that no replies are pending, and place historical messages in the correct IPL and system activity context.

# Guided Evidence — LAB13 - z/OS System Services Structure: Console, SYSLOG and Message Handling

[← Lab lesson](../README.md) · [Academy](https://github.com/P-dot/P-dot/blob/main/docs/ACADEMY.md) · [Evidence standard](https://github.com/P-dot/P-dot/blob/main/docs/LAB-STANDARD.md)

## How to read this evidence

This page is the evidence companion to the lab, not a screenshot gallery. Read the artifacts in execution order and correlate each image or file with the command, job, subsystem state or result described by the lab.

Use four questions while reviewing the evidence:

1. **Intent** — what state or behavior was the lab trying to create or inspect?
2. **Mechanism** — which z/OS component, command, utility or program performed the work?
3. **Observation** — what concrete message, return code, object or state was captured?
4. **Boundary** — what does that artifact support, and what would require additional evidence?

The manifest below is retained as the factual index from the executed lab. Its descriptions are the source of truth for what each artifact was captured to demonstrate.

## Evidence manifest

# LAB13 Evidence

This folder contains the source Word document, a contact sheet, and individual screenshots extracted from the lab evidence.

## Source

```text
LOGREC_source.docx
```

## Contact sheet

```text
lab13_contact_sheet.jpg
```

## Screenshots

```text
01_sdsf_syslog_general_hasp_purged_and_pending_request.png
02_sdsf_syslog_ifb081i_logrec_found_startup_context.png
03_sdsf_syslog_ifb081i_logrec_page_datasets_part_1.png
04_sdsf_syslog_ifb081i_logrec_page_datasets_part_2.png
05_sdsf_syslog_ifb081i_logrec_page_datasets_part_3.png
06_sdsf_syslog_ifb081i_logrec_page_datasets_part_4.png
07_sdsf_syslog_ifb081i_logrec_page_datasets_part_5.png
08_sdsf_syslog_logrec_search_xcf_grs_context_part_1.png
09_sdsf_syslog_logrec_search_xcf_grs_context_part_2.png
10_sdsf_syslog_logrec_dump_capturetime_part_1.png
11_sdsf_syslog_logrec_dump_capturetime_part_2.png
12_sdsf_syslog_logrec_dump_capturetime_part_3.png
13_sdsf_syslog_logrec_dump_capturetime_part_4.png
14_sdsf_syslog_logrec_page_datasets_and_sysplex_context.png
15_sdsf_syslog_logrec_dump_capturetime_part_5.png
16_sdsf_syslog_logrec_dump_capturetime_part_6.png
17_sdsf_syslog_iee_ipl_initialization_part_1.png
18_sdsf_syslog_iee_static_symbols_and_page_datasets.png
19_sdsf_syslog_iee_xcf_grs_sysplex_initialization.png
20_sdsf_syslog_hasp_jes2_checkpoint_and_spool_part_1.png
21_sdsf_syslog_hasp_jes2_checkpoint_and_spool_part_2.png
22_sdsf_syslog_hasp_jes2_cold_start_part_1.png
23_sdsf_syslog_hasp_jes2_cold_start_part_2.png
24_sdsf_syslog_hasp_jes2_started_tasks_and_init.png
25_d_c_l_console_status.png
26_d_r_l_no_messages_outstanding.png
27_d_a_l_system_activity.png
28_jes2_d_a_no_active_jobs.png
29_jes2_d_jobq_mascomm.png
30_d_iplinfo_context.png
```

## Interpretation discipline

A successful command, return code or panel is interpreted only within the scope described by the lab. It must not be promoted into proof of unrelated production properties such as availability, performance, security hardening or recovery unless those properties have their own evidence.

When troubleshooting, walk the artifacts in order and locate the first point where **expected state** and **observed state** diverge. That point is normally more useful than the final symptom.

## Evidence boundary

**Evidence-backed:** the individual observations explicitly identified in the manifest and the parent lab.

**Not automatically implied:** production readiness, enterprise scale, security completeness, performance characteristics or cross-subsystem behavior that was not exercised by this lab.

## Review questions

- Which artifact establishes the initial or prerequisite state?
- Which artifact is the strongest execution/result proof?
- Is there a separate final-state validation, or only a successful command?
- Which z/OS subsystem owns the observed messages or objects?
- What additional artifact would be required to make a stronger claim?

---
### Continue learning

**Lab:** [Return to the lesson](../README.md)  
**Academy:** [z/OS Engineering Academy](https://github.com/P-dot/P-dot/blob/main/docs/ACADEMY.md) · [Curriculum](https://github.com/P-dot/P-dot/blob/main/docs/CURRICULUM.md) · [Relationships](https://github.com/P-dot/P-dot/blob/main/docs/RELATIONSHIPS.md)

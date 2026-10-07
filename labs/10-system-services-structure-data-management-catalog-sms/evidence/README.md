# Guided Evidence — LAB10 - z/OS System Services Structure: Data Management, Catalog and SMS

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

# Evidence - LAB10

This directory contains the evidence for LAB10.

## Files

- `LAB10_source.docx` - original Word file supplied for the lab.
- `lab10_contact_sheet.jpg` - overview sheet containing all screenshots.
- `screenshots/` - extracted screenshots in execution order.

## Screenshot count

```text
32 screenshots
```

## Screenshot list

- `screenshots/01_d_a_l_activity.png`
- `screenshots/02_d_sms_status.png`
- `screenshots/03_d_sms_storgrp_all.png`
- `screenshots/04_d_sms_volume_query_oam_rejected.png`
- `screenshots/05_d_u_dasd_online.png`
- `screenshots/06_d_u_0a80_16.png`
- `screenshots/07_d_r_l_no_messages.png`
- `screenshots/08_d_c_l_console_status.png`
- `screenshots/09_sdsf_da_catalog_sms_components.png`
- `screenshots/10_listcat_level_sys1_part_01.png`
- `screenshots/11_listcat_level_sys1_part_02.png`
- `screenshots/12_listcat_level_sys1_part_03.png`
- `screenshots/13_listcat_level_sys1_part_04.png`
- `screenshots/14_listcat_level_sys1_part_05.png`
- `screenshots/15_listcat_level_sys1_part_06.png`
- `screenshots/16_listcat_level_sys1_part_07.png`
- `screenshots/17_listcat_level_sys1_part_08.png`
- `screenshots/18_listcat_level_sys1_part_09.png`
- `screenshots/19_listcat_level_sys1_part_10.png`
- `screenshots/20_listcat_level_sys1_part_11.png`
- `screenshots/21_listcat_level_sys1_part_12.png`
- `screenshots/22_listcat_level_sys1_part_13.png`
- `screenshots/23_listcat_level_sys1_part_14.png`
- `screenshots/24_listcat_level_sys1_part_15.png`
- `screenshots/25_listcat_level_sys1_part_16.png`
- `screenshots/26_listcat_level_sys1_part_17.png`
- `screenshots/27_listcat_level_sys1_part_18.png`
- `screenshots/28_listcat_level_sys1_part_19.png`
- `screenshots/29_listcat_level_sys1_part_20.png`
- `screenshots/30_listcat_level_sys1_part_21.png`
- `screenshots/31_listcat_level_sys1_part_22.png`
- `screenshots/32_listcat_ent_sys1_linklib_result.png`

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

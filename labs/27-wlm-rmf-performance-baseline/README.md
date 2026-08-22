# Lab 27 — WLM and RMF Performance Baseline

## Objective

Establish a defensible performance and workload-management baseline for the IBM z/OS 1.11 ADCD system running under Hercules, using the active WLM service definition and RMF Monitor II observations before making any tuning changes.

The lab deliberately follows a **measure-first, change-later** approach. No WLM policy, service class, classification rule, or performance goal was changed as part of the final baseline.

## Environment

- IBM z/OS 1.11 ADCD
- Hercules emulator
- SDSF / ISPF
- Workload Manager (WLM)
- Resource Measurement Facility (RMF)
- SMF archive datasets from the existing SMF offload/rotation lab

## Scope

The lab covers:

1. Identification of the active WLM service policy.
2. Review of workloads, service classes, goals, and selected classification rules.
3. RMF Monitor II baseline for paging, central storage, processor/SRM, enqueue contention, and address-space activity.
4. Correlation of live address spaces with WLM service classes through ASRM.
5. Attempted RMF Postprocessor processing of an existing SMF archive.
6. Documentation of limitations and deferred troubleshooting without introducing speculative tuning changes.

## Key findings

### WLM

The runtime display identified:

- Active service policy: `ETPBASE`
- Related service definition: `ETPWlm`
- WLM functionality level: `LEVEL006`

The policy contains workloads and service classes for batch, started tasks, servers, TSO, DB2/DDF and other subsystem types. Classification rules for JES and STC were inspected to understand how work is mapped to service classes.

### RMF Monitor II

Representative observations captured during the lab include:

- **SPAG — System Paging Activity:** `PR=0` in the observed sample; no paging pressure was visible in that snapshot.
- **SRCS — Central Storage / Processor / SRM:** CPU utilization was approximately 30% in the captured sample, with `PR=0` and available central storage visible.
- **SENQ — System Enqueue Contention:** no data matched the selection criteria during the observed sample, so no enqueue contention was demonstrated at that instant.
- **ARD — Address Space Resource Data:** active z/OS address spaces and subsystem workloads were observed, including system, JES2, TCP/IP, CICS, DB2 and user activity.
- **ASRM — Address Space SRM Data:** address spaces were correlated with active WLM service classes such as `SYSTEM`, `STCLOM`, `STCHIM`, `SYSSTC`, and `TSO01`.

These are point-in-time measurements. They are useful for a baseline but are not sufficient on their own to justify production-style tuning decisions.

## RMF Monitor III troubleshooting boundary

RMF Monitor III failed with a module-load error (`ADM00000` / S806-04). The investigation reached GDDM, ISPLLIB, LNKLST and PARMLIB/PROGxx analysis. A temporary change-control experiment was performed and then rolled back after it did not provide the expected runtime result.

That issue is **not treated as a tuning result of this lab**. It is recorded as a separate troubleshooting candidate so that the performance-baseline objective does not become blocked by a secondary Monitor III dependency problem.

## RMF Postprocessor attempt

An existing SMF archive was selected:

`IBMUSER.SMF.ARCHIVE.G0006V00`

Dataset characteristics observed:

- DSORG: PS
- RECFM: VBS
- LRECL: 32767
- BLKSIZE: 27998
- Device: 3390

The RMF Postprocessor job was submitted successfully, but the generated RMFSORT processing did not complete. The spool showed:

`IEF212I ... RMFSORT SORTIN - DATA SET NOT FOUND`

followed by steps not executed.

Therefore, this execution **does not prove whether the archive contains usable RMF historical records**. No historical performance conclusions were derived from that Postprocessor run.

## Conclusion

The lab established a live WLM/RMF baseline without introducing speculative tuning changes. The captured samples do not demonstrate CPU saturation, paging pressure, or enqueue contention severe enough to justify changing WLM goals, importance, or classification.

The correct engineering conclusion is therefore:

> **Observe first; do not tune without evidence.**

The system has now moved from “WLM/RMF not sufficiently assessed” to “active WLM policy documented and RMF Monitor II baseline captured.” Historical RMF processing and Monitor III module resolution remain follow-up items.

## Evidence

All screenshots supplied during the lab are preserved under:

`evidence/screenshots/`

See `docs/evidence-index.md` for the curated evidence map.

## Repository placement

Expected repository:

`zos-adcd-hercules-engineering-lab`

Expected path:

`labs/27-wlm-rmf-performance-baseline`

## Result

**Status: COMPLETE — baseline established, no tuning change justified.**

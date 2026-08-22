# Results and Next Actions

## What was proven

- WLM is active and its current service policy was identified.
- Workloads, service classes and selected classification rules were inspected.
- RMF Monitor II is operational.
- Paging, CPU/storage/SRM and enqueue views were captured.
- Address-space activity was correlated with WLM service classes.
- Existing SMF archive infrastructure is available from previous SMF engineering work.

## What was not proven

- Long-term CPU utilization.
- Peak-load capacity.
- Historical RMF trend behavior from the selected archive.
- Monitor III operability.
- That any WLM goal or classification change would improve the system.

## Decision

No WLM tuning change is justified by the evidence collected in this lab.

## Suggested continuation

A future performance lab should generate a controlled workload, collect RMF/SMF data for a defined interval, and then compare results against this baseline. Only after a repeatable bottleneck is demonstrated should WLM tuning be considered.

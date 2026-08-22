# WLM Baseline

## Active configuration

The runtime WLM display identified the active policy as `ETPBASE` and the related service definition as `ETPWlm`.

The service definition was explored through the WLM ISPF application. The lab reviewed:

- Policies
- Workloads
- Service classes
- Classification rules
- Selected subsystem classifications

The purpose was not to redesign the policy, but to understand the current workload-management model before considering any tuning.

## Observed workload structure

The policy contains workload groupings for batch, servers, started tasks, TSO, DB2/DDF and other system work. Service classes visible in the evidence include examples such as:

- `BATHIM`, `BATHDM`, `BATLOM`
- `SRVHIM`, `SRVMDM`, `SRVLOM`
- `STCHIM`, `STCMDM`, `STCLOM`
- `TSO01`
- system-oriented classes such as `SYSTEM` / `SYSSTC`

## Classification review

JES classification rules were inspected to understand how batch work maps into the batch service classes. STC classification rules were also reviewed to understand started-task routing into service classes.

This creates the baseline needed for later questions such as:

- Is a workload in the service class we expect?
- Are goals appropriate for the observed behavior?
- Is a workload being unintentionally classified by a default rule?
- Is WLM actually the bottleneck, or is the limiting factor elsewhere?

## Change policy

No WLM policy changes were retained in this lab. Any future tuning should be based on repeated RMF measurements and a defined workload scenario, not on a single interactive sample.

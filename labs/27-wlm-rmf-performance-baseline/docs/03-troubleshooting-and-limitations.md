# Troubleshooting and Limitations

## RMF Monitor III

Monitor III failed with a module-load problem involving `ADM00000` and an S806-04 condition.

The investigation included:

- RMF menu validation
- GDDM module-library inspection
- ISPLLIB inspection
- LNKLST runtime display
- PARMLIB / PROGxx examination
- change-control backup and SuperC comparison
- controlled test and rollback

The investigation became secondary to the main purpose of the lab, so it was explicitly stopped and deferred. This preserves scope discipline.

## Temporary PROGxx investigation

A controlled PARMLIB experiment was used during troubleshooting. Backup copies were verified with SuperC before changes. When the runtime result did not match the expected outcome, the modified member was restored and SuperC returned `SAME`.

No unresolved PROGxx test change is intended to remain as part of this lab's final state.

## RMF Postprocessor

The existing SMF archive `IBMUSER.SMF.ARCHIVE.G0006V00` was selected as input.

The Postprocessor job was submitted, but the RMFSORT step did not execute because the spool reported:

`IEF212I IBMUSER RMFSORT SORTIN - DATA SET NOT FOUND`

Consequences:

- No historical RMF report was produced.
- The failure does not prove that the SMF archive lacks RMF records.
- No historical trend conclusion is made.

## Follow-up candidates

The following are intentionally outside the completed baseline:

1. Resolve RMF Monitor III GDDM/module loading as a separate troubleshooting lab.
2. Reproduce RMF Postprocessor input allocation with generated JCL visible and validated.
3. Capture interval-based measurements under a defined synthetic workload.
4. Compare repeated CPU, paging, DASD and service-class behavior before considering WLM tuning.

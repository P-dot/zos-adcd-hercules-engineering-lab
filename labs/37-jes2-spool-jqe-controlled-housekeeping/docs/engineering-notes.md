# Engineering Notes

## Change classification

This lab is a controlled operational remediation rather than a basic JES2
tutorial. The system already had prior JES2 engineering work in Lab 12. The
value of Lab 37 is the complete incident lifecycle and the measured result.

## Why the cutoff mattered

The cutoff (`6400`) was selected from the live JES2/SDSF state observed during
the investigation. Current started tasks were using later job numbers. It was
therefore used together with `QUEUE=PRINT` and the `STC` prefix as a
defense-in-depth boundary.

The cutoff must not be copied blindly to another system or another date. A
future run must derive and validate a new boundary from the current SDSF state.

## Why job names were not whitelisted/blacklisted

Subsystem names alone do not distinguish an active address space from old JES
output. The cleanup therefore classified rows by JES state, identifier type,
and validated age boundary instead of assuming that names such as TCPIP, CICS,
Db2, MQ, or SDSF were safe or unsafe.

## Rollback

Purged JES SYSOUT cannot be restored by a REXX rollback. The rollback strategy
for this change is preventive:

1. dry-run;
2. candidate accounting;
3. protected filters;
4. one-entry destructive validation;
5. stop on first SDSF action failure;
6. post-change verification.

In production, required SYSOUT should be archived before purge.

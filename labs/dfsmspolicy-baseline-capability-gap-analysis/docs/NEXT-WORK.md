# Next Work — DFSMS Policy Engineering Phase 2

## Scope

Extend the existing policy-driven allocation model with Data Class, Management Class and HFS/zFS-aware routing.

## Do not repeat

Do not recreate `SMSLAB`, `SMSPOOL`, `SMS000`/`SMS001`/`SMS002`, `ACSSTOR`, or `ACSGRP` merely to demonstrate fundamentals. These are established Lab 17 capabilities.

## First change gate

Before changing `SYS1.SCDS`:

1. Inventory existing Data Classes and Management Classes.
2. Define intended dataset attributes and lifecycle requirements.
3. Inspect the existing `HFSCLASS` definition and intended consumers.
4. Capture current ACS sources as rollback evidence.
5. Design test cases for positive routing, default routing and non-matching datasets.
6. Validate and test the SCDS before activation.
7. Define rollback before production of any new active configuration.

## Success criteria

The next phase is complete only when the new policy is translated/validated/tested, activated under a controlled change, demonstrated by real allocation evidence, and documented with rollback and post-change verification.

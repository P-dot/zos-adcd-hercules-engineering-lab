# Lab 36 — Part 2 Roadmap
Deferred to a later session.

1. Create `B36PERS`.
2. Introduce a controlled persistent checkpoint.
3. Validate normal execution.
4. Cause a controlled downstream failure.
5. Recover without rebuilding completed work.
6. Define checkpoint lifecycle.
7. Compare restart and full rerun.
8. Test duplicate-processing/publication risk.
9. Establish idempotency rules.
10. Apply the design to `SORTSTEP -> COBSTEP -> PUBSTEP`.

The objective is operationally safe recovery, not merely making `RESTART=` succeed.

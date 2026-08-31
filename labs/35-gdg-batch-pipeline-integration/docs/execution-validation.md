# Execution and Validation

## Phase 1 — GDG infrastructure

`B35DEF` used IDCAMS to define `IBMUSER.BATCH35.VALID.GDG` with `LIMIT(3)`, `NOEMPTY`, and `SCRATCH`. IDCAMS completed with maximum condition code 0.

`B35LIST` established the pre-publication catalog baseline: one GDG base and no generation datasets.

## Phase 2 — Pipeline execution

`B35PIPE` executed three logical stages.

### SORTSTEP

DFSORT read four records and produced four sorted records. `SORTSTEP` completed with RC=0000.

### COBSTEP

`BATMR` consumed `&&SORTED` and produced three valid records and one rejected record. Its functional contract returned RC=0004 because rejects existed.

### PUBSTEP

The JCL condition `IF (COBSTEP.RC LE 4)` evaluated true. IEBGENER copied `&&VALID` into `IBMUSER.BATCH35.VALID.GDG(+1)` and completed with RC=0000.

The cataloged physical generation was `IBMUSER.BATCH35.VALID.GDG.G0001V00`.

## Phase 3 — Catalog and content validation

A subsequent `LISTCAT ALL` showed the GDG base associated with `G0001V00`. ISPF 3.4 showed both the base and the physical generation. Browsing the generation showed exactly three accepted records.

## Deliberate stopping point

No second generation was created. Multi-generation GDG behavior is intentionally reserved for the dedicated JCL GDG lab so the portfolio keeps a single owner for that learning scope.

# Architecture Notes — Lab 35

## Why the GDG is not the COBOL OUTFILE

A direct `BATMR -> GDG(+1)` design would couple application processing to publication. Lab 35 intentionally introduces an intermediate `&&VALID` dataset so that the two responsibilities remain separate.

```text
Processing phase                Publication phase
----------------                -----------------
DFSORT                          IEBGENER
   |                               |
&&SORTED                        GDG(+1)
   |
BATMR
   |
&&VALID
```

This creates a clean operational boundary. A later recovery design can reason independently about whether processing must be repeated or only publication must be recovered.

## Ownership Across the Portfolio

```text
JCL_LABS Lab 12
    GDG mechanics
         |
         +--------------------+
         |                    |
         v                    v
SMF Lab 22                 Batch Lab 35
SMF archival               application publication
```

The same z/OS capability is reused for different system purposes without duplicating its foundational teaching.

## Data Lifetime

```text
Persistent input
IBMUSER.BATCH33.INPUT
        |
        v
Temporary
&&SORTED
        |
        v
Temporary
&&VALID
        |
        v
Persistent publication
IBMUSER.BATCH35.VALID.GDG.G0001V00
```

Rejects follow a separate persistent path through `IBMUSER.BATCH35.REJECT`.

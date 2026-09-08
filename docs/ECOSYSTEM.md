# Ecosystem Architecture

This file is retained as a compatibility entry point for existing links.

The canonical and maintained z/OS laboratory architecture now lives under:

- [Architecture index](architecture/README.md)
- [Laboratory ecosystem](architecture/LAB-ECOSYSTEM.md)
- [Learning paths](architecture/LEARNING-PATHS.md)
- [Cross-repository lab chains](architecture/CROSS-REPO-LAB-CHAINS.md)
- [System evolution](architecture/SYSTEM-EVOLUTION.md)
- [Branching strategy](architecture/BRANCHING-STRATEGY.md)
- [Integration roadmap](architecture/INTEGRATION-ROADMAP.md)

## High-Level Model

```text
MVS / TSO / ISPF
        |
        v
Core z/OS Engineering
        |
        +--------------------+--------------------+
        |                    |                    |
        v                    v                    v
   RACF / SAF        Communications Server       USS
        |                    |                    |
        +--------------------+--------------------+
                             |
                             v
                       Batch Control
                             |
                  Scheduler -> JES2 -> JCL
                             |
          +------------------+------------------+
          |                  |                  |
          v                  v                  v
        COBOL              VSAM                Db2
          |                                      |
          +------------------+-------------------+
                             |
                             v
                            CICS

Automation: REXX / ISPF
Languages: COBOL / PL/I / HLASM
Observability: SDSF / SMF / WLM
Recovery: DASD / catalog / backup / restore / restart
```

This compatibility file should remain intentionally brief so the detailed architecture is maintained in one place only.

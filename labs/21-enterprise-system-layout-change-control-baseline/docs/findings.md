# LAB 21 - Findings

| Area | Finding | Impact | Next action |
|---|---|---|---|
| IPL | z/OS ADCD 1.11 system identity captured | Establishes system baseline | Keep as reference for future labs |
| PARMLIB | USER.PARMLIB, ADCD.Z111S.PARMLIB and SYS1.PARMLIB identified | Enables change tracking | Build PARMLIB change register |
| DASD | Base volumes and selected volumes identified | Enables volume layout mapping | Expand to all online volumes if needed |
| SMF | SYS1.MAN4 on ZVOL00 requires dump | Operational pending request | Create SMF dump/rotation lab |
| SMS | SYS1.SCDS, SYS1.ACDS and SYS1.COMMDS identified | SMS is available for DFSMS policy work | Create SMS policy baseline lab |
| Catalogs | IDCAMS LISTCAT completed with MAXCC=0 | Catalog baseline captured | Document aliases and user catalogs |
| RACF user | IBMUSER is highly privileged | Acceptable in lab, risky in production | Build privileged-user review lab |
| RACF group | SYS1 group captured | Security structure visible | Create group/role model later |
| STARTED | Started task profiles captured | Enables STC identity review | Build STARTED hardening review |
| FACILITY | Sensitive function profiles captured | Enables privilege review | Build FACILITY review |
| OPERCMDS | Operator command profiles captured | Enables command-control review | Build OPERCMDS review |

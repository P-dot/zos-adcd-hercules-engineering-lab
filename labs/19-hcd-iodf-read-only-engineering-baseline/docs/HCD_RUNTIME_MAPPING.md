# HCD to runtime mapping

| Layer | Evidence | Meaning |
|---|---|---|
| IPL | `D IPLINFO` | Shows LOADDB, IEASYS DB, IEASYM 00, IPL device and SYSRES volume. |
| IPLPARM | `SYS1.IPLPARM(LOADDB)` | Provides the IPL configuration member used by the system. |
| Runtime I/O | `D IOS,CONFIG` | Shows active IODF, OS configuration, EDT and CSS. |
| DASD runtime | `D U,DASD,ONLINE` | Shows online volumes such as SBRES1, SBSYS1 and related ADCD volumes. |
| Path runtime | `D M=CHP(0A)` | Shows device status for channel path 0A. |
| Device runtime | `D M=DEV(0A80/0A82/0A85)` | Shows specific devices online and operational. |
| HCD | I/O Device List | Shows logical I/O device definitions from the IODF. |
| HCD | Control Unit List | Shows control units behind device definitions. |
| HCD | Processor Definition | Shows logical processor and channel-related configuration context. |
| Console | `D C,L` | Confirms L700 as active MCS console with MASTER authority. |
| Health check | `D R,L` | Confirms no outstanding messages after read-only review. |

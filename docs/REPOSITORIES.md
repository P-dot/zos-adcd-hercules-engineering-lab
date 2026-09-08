# Repository Map

This portfolio is organized as one connected z/OS Engineering Laboratory.

The canonical architecture is documented in:

- [Architecture index](architecture/README.md)
- [Laboratory ecosystem](architecture/LAB-ECOSYSTEM.md)
- [Cross-repository lab chains](architecture/CROSS-REPO-LAB-CHAINS.md)
- [Integration roadmap](architecture/INTEGRATION-ROADMAP.md)

## Repository Roles

| Repository | Role |
|---|---|
| `MVS_TSO_ISPF` | Onboarding, TSO/E, ISPF navigation and future interactive automation |
| `zos-adcd-hercules-engineering-lab` | Master architecture, core z/OS engineering and system programming |
| `mainframe-racf-security-evidence` | RACF / SAF security, authorization, audit and hardening |
| `zos-communications-server-network-lab` | Communications Server, TCP/IP, VTAM, TN3270 and network diagnostics |
| `UNIX_System_Services-` | USS / OMVS / POSIX / zFS and MVS-to-USS integration |
| `zos-bacth-scheduler` | Educational native batch scheduler and production-control layer above JES2 |
| `JCL_LABS` | JCL, JES2 and batch-processing fundamentals |
| `COBOL` | COBOL development, compile/link and batch processing |
| `vsam01` | VSAM data organization and access methods |
| `DB2-` | Db2 for z/OS, SQL and application data integration |
| `CICS` | Online transaction processing and CICS runtime |
| `Rexx` | TSO/E and ISPF automation |
| `PL-I` | PL/I development on z/OS |
| `z_Assembly` | z/Architecture Assembler, HLASM and low-level programming |
| `mainframe-cobol-db2-cics-devops-lab` | Cross-component application and DevOps integration |

## Architectural Principle

Technology-specific repositories establish focused skills and capabilities.

Cross-repository laboratories demonstrate how those capabilities operate together in realistic z/OS workflows.

The main repository is therefore the architectural hub, while the specialized repositories remain independently reproducible.

Return to the [master repository](https://github.com/P-dot/zos-adcd-hercules-engineering-lab).

# Technical Baseline - ADCDPL

## Classification

| Capability | State |
|---|---|
| XCF | Active |
| Sysplex | ADCDPL |
| Active z/OS member | ADCD |
| Operating mode | MONOPLEX |
| Sysplex CDS primary/alternate | Active |
| WLM CDS primary/alternate | Active |
| LOGR CDS | Active |
| XCF groups | Present |
| GRS baseline | Healthy; no ENQ/latch contention observed |
| SYSPXCF CDS | Not defined to active sysplex |
| ARM CDS | Not defined to active sysplex |
| SFM CDS | Not defined to active sysplex |
| CFRM CDS | Not defined to active sysplex |
| Second z/OS member | Not implemented |
| Coupling Facility | Not demonstrated |
| Parallel Sysplex | Not implemented/demonstrated |

## Key interpretation

The presence of configuration statements in alternate `COUPLExx` members is not evidence that those facilities are active. Runtime `DISPLAY XCF,COUPLE,TYPE=...` output is treated as the authoritative evidence for this lab.

The lab therefore distinguishes three layers:

1. **Present in PARMLIB**
2. **Selected by the active IPL**
3. **Active at runtime**

This prevents overstating the capabilities of the ADCD/Hercules environment.

## Future path

A future lab may assess multi-system feasibility. That work should be isolated from this baseline and should first design separate system identity, IPL parameters, shared-DASD rules, XCF signaling, GRS behavior, dataset ownership and rollback.

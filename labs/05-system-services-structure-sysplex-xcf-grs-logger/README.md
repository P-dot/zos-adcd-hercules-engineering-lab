# LAB05 - z/OS System Services Structure: Sysplex, XCF, GRS and System Logger

## Course alignment

IBM Course: DL00EZ20IG - z/OS System Services Structure  
Unit: Sysplex, XCF, GRS, WLM and system coordination

Related topics:

- Parallel Sysplex concepts
- XCF and XCF groups
- Couple data sets
- Global Resource Serialization (GRS)
- Workload Manager (WLM)
- System Logger / IXGLOGR
- Console and pending-message verification

## Objective

Observe the sysplex and coordination components available in an ADCD z/OS system running on Hercules. The lab uses non-destructive display commands to verify XCF, GRS, WLM, couple data set information, system logger presence, console state, and pending message status.

This lab does not attempt to configure or modify Sysplex, GRS, WLM, or logger resources.

## Environment

- Platform: ADCD z/OS on Hercules
- System name: ADCD
- Sysplex name: ADCDPL
- Console: L700
- Access method: 3270 / SDSF / MCS console

## Commands executed

```text
/D A,L
/D XCF
/D XCF,COUPLE
/D XCF,GROUP
/D GRS
/D WLM
/D R,L
/D C,L
DA
```

## Evidence

Evidence screenshots are stored under:

```text
evidence/screenshots/
```

The original Word document used to build the lab is stored as:

```text
evidence/LAB05_source.docx
```

A contact sheet is also included:

```text
evidence/lab05_contact_sheet.jpg
```

## Findings

### Active address spaces

`D A,L` and SDSF `DA` showed the main system and coordination address spaces, including:

```text
XCFAS
GRS
WLM
IXGLOGR
JES2
RACF
SMS
CATALOG
DUMPSRV
TRACE
```

This confirms that the system has the expected z/OS coordination components active.

### XCF and sysplex identity

`D XCF` showed:

```text
SYSNAME: ADCD
SYSPLEX: ADCDPL
```

This confirms that the ADCD system belongs to the logical sysplex `ADCDPL`.

### Couple data set

`D XCF,COUPLE` showed a primary couple data set:

```text
SYS1.ADCDPL.CDS01
```

This documents the base XCF/sysplex configuration used by the ADCD environment. It does not prove a full physical Parallel Sysplex with external Coupling Facility resources.

### XCF groups

`D XCF,GROUP` showed several XCF groups, including system-related groups such as:

```text
GRS
SYSWLM
SYSXCF
SYSIOS
SYSGRS
SYSJES
SYSSMS
```

This demonstrates that z/OS components use XCF group services for internal coordination.

### GRS status

`D GRS` showed GRS active for system `ADCD`, including ring mode information.

Key observed values:

```text
SYNCHRES: YES
ENQMAXU: 16384
ENQMAXA: 250000
```

This confirms that Global Resource Serialization is active and available to coordinate ENQ/DEQ resource serialization.

### WLM status

`D WLM` showed an active WLM service policy:

```text
Policy name: ETPBASE
Description: ETP WLM Policy w/DB2 StoredProcs
```

This confirms that Workload Manager is active and using a defined service policy.

### Console and pending messages

`D R,L` showed no outstanding messages requiring a reply:

```text
NO MESSAGES OUTSTANDING
```

`D C,L` confirmed console `L700` as an active MCS console with hardcopy log routed to SYSLOG.

## Conclusion

This lab validates the logical sysplex and system coordination layer of the ADCD z/OS environment. It confirms that XCF, GRS, WLM, IXGLOGR and related system address spaces are present, that the system belongs to sysplex `ADCDPL`, and that a primary couple data set is configured.

The lab is intentionally read-only. No configuration changes were made.

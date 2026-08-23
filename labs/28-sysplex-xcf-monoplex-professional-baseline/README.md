# Lab 28 - Sysplex/XCF Monoplex Professional Baseline

## Objective

Establish a professional, evidence-based baseline of the Sysplex/XCF configuration of the IBM z/OS ADCD 1.11 system running under Hercules, without changing the active configuration.

The lab deliberately stops at **baseline and architecture discovery**. It does not claim a multi-system or Parallel Sysplex implementation.

## Environment

- IBM z/OS ADCD 1.11
- Hercules
- Active system name: `ADCD`
- Active sysplex: `ADCDPL`
- TSO/ISPF, SDSF and operator console
- Active PARMLIB path investigated through IPL/PARMLIB members

## Scope

The lab validates:

- XCF and active sysplex identity
- Current system membership and MONOPLEX status
- XCF groups
- Active Sysplex Couple Data Sets
- WLM and LOGR couple data sets
- Presence versus activation of SYSPXCF, ARM, SFM and CFRM definitions
- GRS baseline and contention state
- IPL -> IEASYM/IEASYS -> COUPLE configuration chain
- Active `SYSNAME` origin
- Existence of alternate COUPLExx definitions without activating them

## Verified results

### XCF / Sysplex

`DISPLAY XCF` identifies:

- Sysplex: `ADCDPL`
- System: `ADCD`

`DISPLAY XCF,SYSPLEX,ALL` confirms the system is operating in:

`MONOPLEX MODE`

This is therefore a real XCF-enabled single-system sysplex baseline, not a demonstrated multi-system Sysplex.

### Couple data sets

The active Sysplex Couple Data Sets are:

- Primary: `SYS1.ADCDPL.CDS01`
- Alternate: `SYS1.ADCDPL.CDS02`

The display also confirms that all couple-data-set types are supported and that GRS STAR mode is supported by the Sysplex CDS format.

WLM couple data sets are active:

- `SYS1.ADCDPL.WLM.CDS01`
- `SYS1.ADCDPL.WLM.CDS02`

LOGR is also defined with an active couple data set:

- `SYS1.ADCDPL.LOGR.CDS01`

### Defined in alternate PARMLIB members but not active

Inspection of `COUPLE85` and `COUPLEAX` showed definitions for additional Sysplex functions. Runtime queries demonstrated that the following are **not defined to the active sysplex**:

- SYSPXCF
- ARM
- SFM
- CFRM

No attempt was made to activate these functions.

### GRS

`DISPLAY GRS,ALL` reported:

- RNLs are not in effect
- No ENQ resource contention
- No latch contention

This establishes a clean GRS operational baseline for the current single-system configuration.

## IPL and PARMLIB configuration chain

The active configuration path was reconstructed from runtime evidence:

```text
IPL
 |
 +-- SYS1.IPLPARM(LOADDB)
       |
       +-- IEASYM list 00
       |     |
       |     +-- IEASYM00
       |           +-- SYSDEF SYSNAME(ADCD)
       |
       +-- IEASYS list DB
             |
             +-- IEASYSDB
                   +-- COUPLE=00
                         |
                         +-- COUPLE00
                               +-- ADCDPL
```

`IEASYM00` is the only IEASYM member found in the investigated ADCD PARMLIB and establishes `SYSNAME(ADCD)`.

## Professional conclusion

The system has a functioning **XCF-enabled z/OS monoplex** with active Sysplex, WLM and LOGR couple-data-set infrastructure.

It must **not** be described as a multi-system Sysplex or Parallel Sysplex. No second z/OS image, active Coupling Facility, active CFRM policy, or multi-system signaling architecture was demonstrated.

The correct baseline statement is:

> IBM z/OS ADCD 1.11 operates as system ADCD in sysplex ADCDPL, with XCF active, primary/alternate Sysplex CDS, WLM and LOGR couple-data-set infrastructure, and MONOPLEX MODE confirmed. Advanced multi-system/Parallel Sysplex capabilities remain outside the implemented scope.

## Change control

This lab is read-only.

- No PARMLIB member was modified.
- No COUPLExx member was activated.
- No IPL was performed for this lab.
- No CFRM, SFM, ARM or SYSPXCF activation was attempted.
- No second system was created.

This preserves the current stable ADCD baseline and leaves multi-system experimentation for a future, separately controlled lab.

## Evidence

Screenshots are stored under:

`evidence/screenshots/`

The supplied evidence includes XCF displays, couple-data-set displays, GRS status, IPLINFO, IEASYSDB/COUPLE selection, COUPLE members and IEASYM00.

## Result

**PASS - Professional Sysplex/XCF monoplex baseline established without configuration changes.**

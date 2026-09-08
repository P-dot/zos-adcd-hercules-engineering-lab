# Lab 39 — SMF Type 99 SRM/WLM Decision Data Analysis — Part 1

## Objective

Build a controlled, read-only path from the operational SMF environment to archived SMF Type 99 data, validate that SRM/WLM decision records exist, inspect the mapping installed on this z/OS release, and document the record-structure issue discovered before deeper decoding.

Part 1 deliberately stops before WLM tuning or modification. The objective is to understand the telemetry already produced by the system before changing workload-management behavior.

## Scope

This lab covers:

- effective SMF configuration and MAN data-set status;
- the existing GDG-based SMF archive;
- controlled IFASMFDP offload and archive validation;
- DASD/allocation troubleshooting during the offload workflow;
- selective extraction of SMF record type 99;
- validation of the extracted Type 99 population;
- inspection of `SYS1.AMODGEN(IRASMF99)`;
- identification of Type 99 subtypes and common-header fields;
- investigation of DFSORT and ICETOOL processing;
- identification of variable/short physical records and Type 99 reassembly structures;
- definition of the continuation lab.

## Environment

- IBM z/OS ADCD/Hercules laboratory
- SMF / SRM / WLM
- IFASMFDP
- DFSORT / ICETOOL
- ISPF / SDSF
- IDCAMS LISTCAT
- `SYS1.AMODGEN(IRASMF99)`
- GDG archive: `IBMUSER.SMF.ARCHIVE`
- Type 99 working data set: `IBMUSER.SMF.TYPE99`

## 1. SMF operational baseline

The effective SMF environment was inspected before Type 99 analysis. The active SMF configuration, PARMLIB definition, MAN data sets and their operational states were reviewed. MAN states observed during the workflow included `ACTIVE`, `ALTERNATE`, and `DUMP REQUIRED`.

This established the operational context before any historical analysis was performed.

## 2. Existing SMF archive lifecycle

The lab reused the SMF archival mechanism already built in previous labs rather than creating a parallel process:

```text
SMF recording
    |
    v
MAN data sets
    |
    v
IFASMFDP offload
    |
    v
IBMUSER.SMF.ARCHIVE GDG
    |
    v
Selective historical analysis
```

`LISTCAT ENT('IBMUSER.SMF.ARCHIVE') ALL` was used to verify the GDG and its generations.

## 3. Controlled SMF offload

IFASMFDP was used to preserve SMF data from a MAN data set requiring dump processing into a new archive generation. The IFASMFDP Summary Activity Report was retained as evidence because it provides the record-type inventory, counts, percentages and record-length statistics.

An allocation/space problem was encountered during the offload workflow. Available DASD space was investigated and the laboratory volume `ZVOL00` was used where appropriate. This demonstrated that SMF preservation depends not only on SMF itself but also on correct catalog, GDG and DASD management.

## 4. Selective Type 99 extraction

A dedicated IFASMFDP job read the latest archive generation and selected only Type 99 records:

```text
Input : IBMUSER.SMF.ARCHIVE(0)
Output: IBMUSER.SMF.TYPE99
Type  : 99
Result: RC=0000
```

The active MAN data sets were not used as the analysis workspace.

## 5. Quantitative result

The IFASMFDP Summary Activity Report showed:

```text
Total SMF records in selected archive : 24,612
SMF Type 99 records                   :    673
Type 99 percentage                    :   2.77%
```

This proves that the environment contains real SRM/WLM diagnostic data suitable for deeper analysis.

## 6. Installed Type 99 mapping

The local mapping macro was inspected directly:

```text
SYS1.AMODGEN(IRASMF99)
```

Using the mapping installed on the laboratory system avoids assuming that a newer z/OS mapping is identical to the one actually producing these records.

The installed macro documents Type 99 subtypes 1 through 12:

| Subtype | Purpose |
|---:|---|
| 1 | Current system state and resource-group information |
| 2 | Workload information for each service period |
| 3 | Service-period plot information |
| 4 | Device-cluster information |
| 5 | Monitored address-space information |
| 6 | Service-class-period summary and next policy-interval resource-control settings |
| 7 | PAV device information |
| 8 | WLM LPAR-management information |
| 9 | IOS subsystem / CHPID processing information |
| 10 | Dynamic processor-speed-change information |
| 11 | Group-capacity-limit information |
| 12 | Vertical CPU Management information |

## 7. Common header and subtype field

The common header investigation identified fields including:

```text
SMF99RTY
SMF99TME
SMF99DTE
SMF99SID
SMF99SSID
SMF99STY
```

`SMF99STY` is the record-subtype field and the installed mapping places it at offset `X'16'` in the logical Type 99 record structure.

## 8. DFSORT / ICETOOL investigation

Several analysis approaches were intentionally preserved as troubleshooting evidence.

The first DFSORT report attempt used `SECTIONS`, `TRAILER3`, and `COUNT` and ended with `ICE007A SYNTAX ERROR`, `MAXCC=16` on this DFSORT level.

A simplified attempt exposed variable-record handling. DFSORT repeatedly reported:

```text
ICE201I ... RECORD TYPE IS V - DATA STARTS IN POSITION 5
```

This is informational, not the root error. Positions 1-4 contain the RDW and data begins at position 5.

Further processing produced errors including:

```text
ICE251A MISSING RDW OR DATA FOR OUTREC
```

ICETOOL `OCCUR` was then evaluated for subtype counting. ICETOOL initialized correctly, but the internal DFSORT processing ultimately exposed the decisive condition:

```text
ICE218A ... 18 BYTE VARIABLE RECORD IS SHORTER THAN
            28 BYTE MINIMUM ...
```

The important finding is therefore not the recurring `DATA STARTS IN POSITION 5` message. The important finding is that the extracted Type 99 population includes physical records that cannot all be treated as independently complete logical records for direct generic field access.

## 9. Reassembly finding

Inspection of `IRASMF99` showed explicit Type 99 reassembly structures, including information associated with split/incomplete records, sequence information, total-record information, and reassembly blocks.

This explains why blindly applying a single logical-record field position to every physical record is unsafe.

The troubleshooting path therefore progressed as follows:

```text
Report syntax
    -> variable-record representation
    -> RDW awareness
    -> field-position investigation
    -> short physical records
    -> Type 99 reassembly requirement
```

This is the main architectural finding of Part 1.

## 10. Safety and change control

The analysis was intentionally performed from archived SMF data:

```text
Active SMF
   -> MAN data sets
   -> controlled offload
   -> archive GDG
   -> selective Type 99 extraction
   -> read-only analysis
```

The lab did **not** deliberately modify:

- WLM service definitions or policies;
- service-class goals;
- SRM controls;
- SMF Type 99 configuration;
- SMF exits;
- active MAN contents for analytical experimentation.

## Results

Part 1 demonstrated that:

1. the SMF recording and archival path is operational;
2. MAN status and dump requirements can be inspected safely;
3. IFASMFDP can preserve SMF data into the existing GDG archive;
4. storage/allocation problems affecting an SMF offload can be diagnosed;
5. Type 99 can be selectively extracted from archived SMF data;
6. the selected archive contained 24,612 SMF records;
7. 673 Type 99 records were extracted successfully with RC=0000;
8. the installed `IRASMF99` mapping documents subtypes 1-12;
9. the Type 99 common header and subtype field were identified;
10. generic DFSORT/ICETOOL processing exposed short variable physical records;
11. the installed macro confirms that Type 99 includes reassembly structures;
12. reassembly-aware processing is required before reliable subtype and SRM/WLM decision analysis.

## Evidence

`evidence/screenshots/` contains the complete evidence set captured during the lab, including:

- SMF configuration and PARMLIB inspection;
- MAN data-set status;
- GDG/LISTCAT evidence;
- IFASMFDP offload and storage troubleshooting;
- successful archive processing;
- successful Type 99 extraction;
- IFASMFDP Summary Activity Reports;
- `IRASMF99` mapping and subtype documentation;
- common-header and reassembly structures;
- DFSORT and ICETOOL attempts;
- the final short-variable-record diagnostics.

Failed attempts are retained intentionally as problem-determination evidence.

## Related work

This lab builds on earlier work covering SMF baseline/recording, MAN maintenance, IFASMFDP export, MAN sizing/rotation, GDG archival, WLM/RMF performance baselining, and SMF exit operational validation. It extends that work from SMF administration into SRM/WLM decision-data analysis.

## Final status

**Lab 39 — Part 1: COMPLETE**

```text
Selective Type 99 extraction : RC=0000
Type 99 records              : 673
Primary finding              : reassembly-aware processing is
                               required before reliable decoding
```

## Next lab — Lab 40

**SMF Type 99 Reassembly and SRM/WLM Decision Analysis**

Lab 40 will continue directly from this boundary. It will:

1. investigate the split/reassembly structures defined by `IRASMF99`;
2. distinguish physical segments from complete logical Type 99 records;
3. determine a reliable reassembly/decoding method for this z/OS level;
4. produce a trustworthy Type 99 subtype inventory;
5. select useful subtypes for detailed analysis;
6. decode system-state, workload, service-period and decision-related fields;
7. correlate Type 99 information with the existing WLM/RMF baseline;
8. determine which SRM/WLM decisions can be demonstrated from the captured data;
9. remain read-only until the existing decision telemetry is understood.

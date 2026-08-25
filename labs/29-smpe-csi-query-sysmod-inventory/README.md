# Lab 29 — SMP/E CSI Query and SYSMOD Inventory

## Objective

Use the SMP/E dialogs and a generated batch job to interrogate the active CSI, select the
`MVST` target zone, locate the `HBB7760` function, and obtain its associated SYSMOD
inventory. The lab also records the troubleshooting required to make the generated
SMP/E JCL execute correctly in this ADCD environment.

## Environment

- z/OS ADCD under Hercules
- SMP/E 35.31 dialogs
- CSI: `MVS.GLOBAL.CSI`
- Target zone: `MVST`
- Function/FMID investigated: `HBB7760`
- SMP/E batch program: `GIMMSMP`

## What was done

The exercise began from the SMP/E primary option menu. The CSI was queried through the
dialogs to identify the available GLOBAL and TARGET information. The command-generation
dialogs were then used to build a `LIST` request.

The first generated batch executions failed before SMP/E could process the control
statements. The evidence records JCL diagnostics including `IEFC621I EXPECTED CONTINUATION
NOT RECEIVED` and `IEFC605I UNIDENTIFIED OPERATION FIELD`. Rather than treating these
messages as an SMP/E database failure, the generated JCL and the available SMP/E load
libraries were inspected.

After correcting the batch execution path, the job was run with `SYS1.MIGLIB` available
to the SMP/E step. The final request was:

```text
SET BOUNDARY(MVST).
LIST
     FUNCTIONS
     FORFMID(HBB7760)
     SYSMODS
.
```

## Why these statements are used

`SET BOUNDARY(MVST)` tells SMP/E that the following operation is to be evaluated against
the `MVST` target zone. This matters because the same CSI can contain global, target and
distribution-zone information.

`LIST FUNCTIONS` asks SMP/E to report FUNCTION-type SYSMOD information. A FUNCTION is a
base element of installed software rather than an individual corrective PTF.

`FORFMID(HBB7760)` limits the request to the function associated with FMID `HBB7760`.
Without this filter the output can become unnecessarily broad.

`SYSMODS` requests the maintenance/SYSMOD relationships associated with the selected
function.

## Result

The final SMPLIST output successfully identifies `HBB7760` in target zone `MVST` as:

- `TYPE = FUNCTION`
- `DESCRIPTION = BCP Base`
- `FMID = HBB7760`
- `JCLIN = YES`
- `DELMID = YES`

The output then lists the maintenance relationships associated with the function. The
large multi-page result is expected; once the requested FMID and its SYSMOD relationships
were demonstrated, continuing to page through the complete list added no further value
to the objective.

## Troubleshooting value

A useful part of this lab is the failed path. The initial JCL errors were preserved as
evidence, the generated job was inspected, the available SMP/E library path was checked,
and the corrected execution produced valid SMP/E output. This distinguishes a JCL/load
environment problem from a CSI-content problem.

## Evidence

`docs/full-session-evidence.docx` preserves the complete 66-page working session supplied
at lab closure.

`evidence/screenshots/` contains the images embedded in that document plus the additional
SMP/E screenshots from the same troubleshooting sequence that were not present as
identical images in the final Word document.

The extra images retained at closure are:

- `extra-774b25fd-dc40-4e98-beda-38ae08a92037.PNG`
- `extra-8e73adaf-c432-4db7-96a8-7c4cf5f40f70.PNG`
- `extra-75468c49-f437-4468-ab82-28be3da46ae5.PNG`
- `extra-56f88d3a-1fd8-4409-b17f-c702417b4935.PNG`
- `extra-3766846c-1661-4abd-9871-d8a1f37a775c.PNG`
- `extra-719f00cb-763b-479c-b6ec-d7bea441eadf.PNG`

## Publication/security note

The evidence set was reviewed for the publication-oriented lab package. The screenshots
are 3270/SDSF/SMP/E material and the closure package does not intentionally add host
network configuration, private IP addresses, MAC addresses or adapter identifiers.

## Conclusion

The lab demonstrates an end-to-end SMP/E inventory workflow: CSI selection, target-zone
selection, command generation, diagnosis of a failed generated batch job, correction of
the execution environment, and successful interrogation of the `HBB7760` function and
its associated SYSMOD information.

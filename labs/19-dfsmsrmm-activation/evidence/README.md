# Evidence Index

Every image in this directory is retained as part of the implementation and troubleshooting trail.

## 01. `01-ispf-library-discovery-iefssn-members.png`

Initial ISPF discovery around the IEFSSN members available in the active ADCD PARMLIB.

## 02. `02-ispf-library-discovery-iefssn-members-continuation.png`

Continuation of the IEFSSN member discovery used to identify the local subsystem-definition candidates.

## 03. `03-sdsf-da-runtime-baseline.png`

SDSF DA baseline showing the active z/OS workload before DFSMSrmm activation.

## 04. `04-ssi-runtime-baseline.png`

Initial SSI display used as a runtime baseline before the DFRM subsystem was registered.

## 05. `05-sys1-samplib-edg-member-discovery.png`

SYS1.SAMPLIB member discovery in the EDG namespace, confirming DFSMSrmm installation samples are present.

## 06. `06-edgrmm00-sample-and-default-options.png`

IBM EDGRMM00 sample showing the DFSMSrmm parameter-member structure and defaults.

## 07. `07-edgrmm00-sample-continuation.png`

Continuation of the EDGRMM00 sample review.

## 08. `08-edgrmm00-customized-rmm-control-journal.png`

Customized EDGRMM00 in ADCD.Z111S.PARMLIB referencing the local RMM control data set and journal.

## 09. `09-dfrmm-procedure-header-and-documentation.png`

Header and IBM documentation in the DFRMM started-procedure sample.

## 10. `10-dfrmm-procedure-active-jcl.png`

Executable section of the DFRMM procedure, including the PDA DD statements.

## 11. `11-active-parmlib-concatenation.png`

Active PARMLIB concatenation, confirming ADCD.Z111S.PARMLIB participates in the system search order.

## 12. `12-dfrmm-procedure-local-copy.png`

Local DFRMM procedure copy in ADCD.Z111S.PROCLIB.

## 13. `13-listcat-rmm-not-found-baseline.png`

Catalog baseline showing that no RMM high-level entries existed before the new infrastructure was created.

## 14. `14-edgutil-control-record-sample.png`

EDGUTIL sample documentation explaining creation of the RMM control record.

## 15. `15-edgutil-create-control-record-jcl.png`

EDGUTIL CREATE JCL used as the basis for CDS initialization.

## 16. `16-edgjmfal-control-dataset-allocation-sample.png`

EDGJMFAL sample documentation for allocating the RMM control data set.

## 17. `17-edgjmfal-idcams-define-cluster-sample.png`

IDCAMS DEFINE CLUSTER section from EDGJMFAL with IBM-supplied VSAM attributes.

## 18. `18-edgjnlal-journal-allocation-sample.png`

EDGJNLAL sample documentation for allocating the RMM journal.

## 19. `19-edgjnlal-journal-jcl.png`

Journal allocation JCL from EDGJNLAL.

## 20. `20-listcat-ibmuser-volume-discovery-01.png`

Catalog/volume discovery used to identify the DASD placement convention in the ADCD environment.

## 21. `21-listcat-ibmuser-volume-discovery-02.png`

Continuation of catalog/volume discovery.

## 22. `22-listcat-ibmuser-volume-discovery-03.png`

Continuation of catalog/volume discovery.

## 23. `23-listcat-ibmuser-volume-discovery-04.png`

Continuation of catalog/volume discovery.

## 24. `24-listcat-ibmuser-volume-discovery-05.png`

Continuation of catalog/volume discovery.

## 25. `25-listcat-ibmuser-volume-discovery-06.png`

Continuation of catalog/volume discovery.

## 26. `26-listcat-ibmuser-volume-discovery-07.png`

Continuation of catalog/volume discovery.

## 27. `27-listcat-ibmuser-volume-discovery-08.png`

Continuation of catalog/volume discovery.

## 28. `28-listcat-ibmuser-volume-discovery-09.png`

Continuation of catalog/volume discovery.

## 29. `29-listcat-ibmuser-volume-discovery-10.png`

Final catalog/volume-discovery evidence used to select the target volume.

## 30. `30-rmmcds-idcams-template-before-customization.png`

Working RMMCDS member before all placeholders were replaced.

## 31. `31-rmmcds-idcams-customized-control-dataset.png`

RMMCDS after customization of the control-data-set name and target volume.

## 32. `32-rmmcds-idcams-final-control-dataset-definition.png`

Final IDCAMS VSAM definition for RMM.CONTROL.DATASET.

## 33. `33-listcat-rmm-control-dataset-not-found-precheck.png`

Pre-allocation LISTCAT proving that RMM.CONTROL.DATASET did not already exist.

## 34. `34-rmminit-edgutil-control-cdsid-rmm1.png`

RMMINIT EDGUTIL job with CONTROL CDSID(RMM1).

## 35. `35-linklist-display-after-rmm-init.png`

Link-list display captured during runtime validation and troubleshooting.

## 36. `36-listcat-edgpdox-not-found.png`

LISTCAT proving RMM.ADCD.EDGPDOX did not exist during diagnosis of IEF132I.

## 37. `37-listcat-edgpdoy-not-found.png`

LISTCAT proving RMM.ADCD.EDGPDOY did not exist during diagnosis of IEF132I.

## 38. `38-ieasysdb-ssn-db-selection.png`

IEASYSDB showing SSN=DB, which selects IEFSSNDB for SSI definitions.

## 39. `39-iefssndb-dfrm-subsystem-definition.png`

IEFSSNDB updated with SUBSYS SUBNAME(DFRM) and INITRTN(EDGSSSI).

## 40. `40-commnddb-startup-command-review.png`

COMMNDDB review showing the normal early-start command set; no unnecessary automatic DFRMM start was added during first validation.

## 41. `41-mstjcl00-proclib-concatenation-review.png`

MSTJCL00 review showing ADCD.Z111S.PROCLIB ahead of SYS1.PROCLIB in the started-procedure search path.

## 42. `42-syslog-dfrm-subsystem-registration-after-ipl.png`

SYSLOG search confirming that DFRM is registered after IPL.

## 43. `43-syslog-iefssndb-processing-evidence.png`

SYSLOG evidence that IEFSSNDB was processed during system initialization.

## 44. `44-dfsmsrmm-successful-initialization-edg0105i.png`

Critical success evidence: EDG0204I followed by EDG0105I DFSMSrmm SUBSYSTEM INITIALIZATION COMPLETE.

## 45. `45-sdsf-da-dfrmm-active-started-task.png`

SDSF DA final runtime validation showing DFRMM active as a started task.

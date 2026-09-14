# Evidence Matrix

| ID | File | What it proves |
|---|---|---|
| E01 | `01-smsdata-data-class-list.png` | `SMSDATA` exists in the Data Class list for `SYS1.SCDS`. |
| E02 | `02-smsmgmt-management-class-list.png` | `SMSMGMT` exists in the Management Class list for `SYS1.SCDS`. |
| E03 | `03-acsdata-source.png` | `IBMUSER.HARDEN.CNTL(ACSDATA)` contains the intended `PROC DATACLAS` logic. |
| E04 | `04-acsdata-translate-input.png` | Translation targets `SYS1.SCDS`, member `ACSDATA`, and the dedicated listing. |
| E05 | `05-acsdata-translation-rc0000.png` | ACS object saved and `TRANSLATION RETURN CODE: 0000`. |
| E06 | `06-acsdata-validation-input.png` | Validation is isolated to routine type `DC`. |
| E07 | `07-acsdata-validation-success.png` | `VALIDATION SUCCESSFUL` for Data Class ACS. |
| E08 | `08-dctest1-positive-case.png` | Positive test case uses `IBMUSER.SMSLAB.TESTDC`. |
| E09 | `09-dctest1-isolated-dc-selection.png` | Test runs `DC=Y` with `SC/MC/SG=N`. |
| E10 | `10-dctest1-results-rc00.png` | `EXIT CODE 0`, `DC = SMSDATA`, `ACS TESTING RC: 00`. |

## Evidence quality rule

The evidence set is curated, not exhaustive. Intermediate navigation screenshots are deliberately excluded when they do not prove a distinct acceptance criterion.

# Technical Notes — Lab 39 Part 1

## Key operational facts

- SMF archive GDG: `IBMUSER.SMF.ARCHIVE`
- Type 99 working data set: `IBMUSER.SMF.TYPE99`
- Working DASD volume used for the Type 99 extraction: `ZVOL00`
- Mapping macro: `SYS1.AMODGEN(IRASMF99)`
- Archive population observed: 24,612 records
- Type 99 population observed: 673 records (2.77%)
- Successful Type 99 extraction: RC=0000

## Important diagnostic distinction

`ICE201I RECORD TYPE IS V - DATA STARTS IN POSITION 5` describes the layout of a variable DFSORT record. It is not itself the failure.

The decisive diagnostic in the final analysis attempt is the short-variable-record condition (`ICE218A`). Combined with the reassembly structures documented in `IRASMF99`, this establishes the technical boundary for Part 1.

## Engineering decision

Do not continue by guessing new DFSORT positions or forcing additional formatting operations. Lab 40 starts by solving the physical/logical record and reassembly problem, then performs subtype inventory and SRM/WLM decoding.

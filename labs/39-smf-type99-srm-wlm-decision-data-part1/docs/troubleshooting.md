# Troubleshooting Record

## Attempt 1 — DFSORT formatted subtype report

Goal: group Type 99 subtype values and print occurrence counts.

Result: `ICE007A SYNTAX ERROR`, `MAXCC=16` while using `SECTIONS/TRAILER3` report syntax.

## Attempt 2 — simplified DFSORT field processing

Goal: isolate the subtype field without report formatting.

Observed: `ICE201I RECORD TYPE IS V - DATA STARTS IN POSITION 5`.

Interpretation: variable input; positions 1-4 are the RDW. This message is informational.

Further processing exposed `ICE251A MISSING RDW OR DATA FOR OUTREC`.

## Attempt 3 — ICETOOL OCCUR

Goal: let ICETOOL count unique subtype values with `OCCUR` and `VALCNT`.

ICETOOL started correctly but its DFSORT call returned RC=16.

The final diagnostic showed a short variable record (`ICE218A`), proving that not every physical record can safely satisfy the requested direct field access.

## Conclusion

The installed `IRASMF99` macro contains explicit reassembly information. The next investigation must be reassembly-aware rather than another blind field-position experiment.

# Commands and Operator Actions

## Runtime displays used

```text
D WLM
D PROG,LNKLST
D IPLINFO
D PARMLIB
```

Depending on SDSF command mode, the commands may be entered with the leading `/`.

## RMF navigation

```text
TSO RMF
```

Monitor II path used for the final baseline:

```text
RMF
 -> 2 Monitor II
 -> 3 Resource
    -> 4 SPAG
    -> 5 SRCS
    -> 1 SENQ (sample returned no matching contention data)

RMF Monitor II
 -> 1 Address Spaces
    -> 1 ARD
    -> 3 ASRM
```

Postprocessor path:

```text
RMF
 -> 1 Postprocessor
 -> Input Data: DATASET
 -> SMF Data Set: IBMUSER.SMF.ARCHIVE.G0006V00
 -> Sort Input Data: YES
 -> Summary: INT,TOT
 -> Submit
```

## Change-control note

The Monitor III troubleshooting branch included PROGxx backup/compare testing. The experimental member was restored when the runtime outcome was not validated. The final lab does not depend on that change.

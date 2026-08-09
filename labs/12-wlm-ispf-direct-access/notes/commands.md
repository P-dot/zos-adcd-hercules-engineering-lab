# Commands and actions — Lab 12

## Operator console

```text
D WLM
D XCF,COUPLE
D XCF,COUPLE,TYPE=WLM
```

## Existing WLM path

```text
ISPF Primary Option Menu
M
12
```

## WLM definition inspection

```text
2  Extract definition from WLM couple data set
1  Policies
4  Browse ETPBASE
```

## Identify panels

From ISPF:

```text
PANELID
```

Observed panel IDs:

```text
ISR@PRIM   ISPF Primary Option Menu
IBMPRODS   IBM Products panel
```

## Inspect runtime allocations

From ISPF option 6:

```text
TSO ISRDDN
```

Inside ISRDDN:

```text
F ISPPLIB
M ISR@PRIM
M IBMPRODS
```

## Panel locations used in the lab

```text
ADCD.Z111S.ISPPLIB(ISR@PRIM)
ADCD.Z111S.DBS1.ISPPLIB(IBMPRODS)
USER.ISPPLIB(ISR@PRIM)
```

## Primary menu display change

Added to `USER.ISPPLIB(ISR@PRIM)`:

```text
12 WLM              Workload Manager
```

## Primary menu processing change

Added inside:

```text
&ZSEL = TRANS (TRUNC (&ZCMD,'.')
```

the following entry:

```text
12,'CMD(%IWMARIN0)'
```

The native invocation was copied from:

```text
ADCD.Z111S.DBS1.ISPPLIB(IBMPRODS)
```

## Required reload

Exit ISPF completely and start a fresh ISPF session.

Then execute from the Primary Option Menu:

```text
12
```

Expected result:

```text
Workload Manager opens directly.
```

## Troubleshooting evidence

Incorrect transcription:

```text
12,'CMD(%IWMRIN0)'
```

Result:

```text
IKJ56500I COMMAND WMRIN0 NOT FOUND
```

Correct system entry:

```text
12,'CMD(%IWMARIN0)'
```

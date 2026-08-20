# Commands and Actions — Lab 26

## Console / SDSF

```text
/D PARMLIB
$D PROCLIB
$D PROCLIB(PROC00)
/D A,L
```

The two `$D PROCLIB...` forms returned RC=52 in this environment and are retained as troubleshooting evidence.

## ISPF / SuperC

Compare PARMLIB baseline:

```text
NEW: 'USER.PARMLIB(SMFPRMB8)'
OLD: 'USER.PARMLIB(SMFBK25)'
```

Compare JES2 PROC backup:

```text
NEW: 'SYS1.PROCLIB(JES2)'
OLD: 'USER.PROCLIB(JES2BK26)'
```

## Test procedure

`USER.PROCLIB(LAB26TST)`

```jcl
//LAB26TST PROC
//STEP1    EXEC PGM=IEFBR14
//         PEND
```

## Private-library test

```jcl
//L26TEST  JOB (ACCT),'LAB26',CLASS=A,MSGCLASS=H,
//             NOTIFY=&SYSUID
//MYLIB    JCLLIB ORDER=USER.PROCLIB
//STEP1    EXEC LAB26TST
//
```

Expected/observed result: procedure expanded from private library, CC 0000.

## Runtime system-library control test

```jcl
//L26NEG   JOB (ACCT),'LAB26',CLASS=A,MSGCLASS=H,
//             NOTIFY=&SYSUID
//STEP1    EXEC LAB26TST
//
```

Observed result: procedure expanded using system library `USER.PRO...`, CC 0000.

## Explicitly NOT executed

```text
$P JES2
$S JES2
SET SMF=B8
```

No JES2 restart and no functional SMF activation were required for this lab.

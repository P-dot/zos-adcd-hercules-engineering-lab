# Lab 37 command record

## Console / JES2 diagnostic commands

$D CKPTSPACE
$D JOBDEF
$D SPOOL
$D CKPTSPACE,BERTUSE

## SDSF / TSO REXX execution

TSO EXEC 'IBMUSER.REXX.EXEC(JES2CLN)'
TSO EXEC 'IBMUSER.REXX.EXEC(JES2CLN1)'
TSO EXEC 'IBMUSER.REXX.EXEC(J2CLNALL)'

## Selection invariant used by the cleanup

QUEUE = PRINT
JOBID = STCxxxxx
numeric job number < 6400

## Destructive SDSF action validated in this environment

address SDSF,
  "ISFACT ST TOKEN('"token.i"')",
  "PARM(NP P)"

## Safety invariants

Never select EXECUTION rows.
Never select TSUxxxxx rows.
Never select JOBxxxxx rows.
Never select STC job numbers >= 6400.
Never act on a non-numeric STC suffix.
Stop on a non-zero SDSF action return code.

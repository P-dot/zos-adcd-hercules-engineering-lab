# Rollback Notes — LAB18B

The lab did not replace or delete `SYS1.MAN1`, `SYS1.MAN2`, or `SYS1.MAN3`.

Rollback from the alternate SMF parameters:

```text
/SET SMF=00
/D SMF
/D R,L
```

Expected rollback result:

```text
SYS1.MAN1
SYS1.MAN2
SYS1.MAN3
```

Only delete `SYS1.MAN4`, `SYS1.MAN5`, and `SYS1.MAN6` if deliberately cleaning up the lab and after verifying they are not active in `D SMF`.

Cleanup, if explicitly required:

```jcl
//DELMB    JOB (ACCT),'DELETE MAN B',CLASS=A,MSGCLASS=X
//STEP01   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 DELETE SYS1.MAN4 CLUSTER PURGE
 DELETE SYS1.MAN5 CLUSTER PURGE
 DELETE SYS1.MAN6 CLUSTER PURGE
 SET MAXCC = 0
/*
```

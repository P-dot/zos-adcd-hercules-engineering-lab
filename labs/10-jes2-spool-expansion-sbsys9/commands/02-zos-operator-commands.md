# z/OS and JES2 commands

## Baseline

In SDSF, use slash-prefixed MVS/JES2 commands:

```text
/$D SPOOLDEF
/$D SPOOL,ALL
/D U,,,0A90,32
/D U,,,0A9D,1
```

## Initialize and online the new volume

After submitting `INISPL9`:

```text
/V 0A9D,OFFLINE
```

If ICKDSF asks for confirmation:

```text
/R nn,U
```

After successful initialization:

```text
/V 0A9D,ONLINE
/D U,,,0A9D,1
```

Expected:

```text
0A9D 3390 O SBSYS9 PRIV/RSDNT
```

## Start new JES2 SPOOL volume

After `SYS1.HASPACE` exists on `SBSYS9`:

```text
/$S SPOOL(SBSYS9)
```

Verify:

```text
/$D SPOOL,ALL
/$D SPOOLDEF
```

Expected final result:

```text
DEFINED=18000
ACTIVE=18000
PERCENT around 9.8
```

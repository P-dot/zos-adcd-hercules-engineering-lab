# CICSA PROC - STEPLIB change

Miembro editado:

```text
ADCD.Z111S.PROCLIB(CICSA)
```

Antes:

```jcl
//         DD DSN=CEE.SCEERUN,DISP=SHR
//         DD DSN=DSN910.SDSNLOAD,DISP=SHR
```

Después:

```jcl
//         DD DSN=CEE.SCEERUN,DISP=SHR
//         DD DSN=DSN910.DB9G.SDSNEXIT,DISP=SHR
//         DD DSN=DSN910.SDSNLOAD,DISP=SHR
```

`SDSNEXIT` debe ir antes de `SDSNLOAD`.

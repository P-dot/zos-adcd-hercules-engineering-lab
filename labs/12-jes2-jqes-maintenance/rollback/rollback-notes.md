# Rollback Notes

La mitigación aplicada en este lab fue:

```text
$T JOBDEF,JNUMWARN=90
```

Rollback al valor anterior observado:

```text
$T JOBDEF,JNUMWARN=80
$D JOBDEF
```

Notas:

- Este cambio dinámico no modifica JES2PARM permanentemente.
- Tras IPL, el valor dependerá de la configuración persistente de JES2.
- No se modificó `JOBNUM`.
- No se ejecutó purge masivo de jobs/salidas.

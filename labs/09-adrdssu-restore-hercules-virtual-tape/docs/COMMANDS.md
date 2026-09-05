# Comandos utilizados

## Iniciar DFSMSrmm

```text
S DFRMM
```

## Montar la cinta en Hercules

```text
devinit 0581 F:\ZOS111\TAPES\BK0001.het
```

## Autorizar VTOCIX para el mensaje ADR369D

```text
R 04,U
```

`U` continúa la operación; `T` la termina.

## Verificar el volumen

```text
D U,,,0A9C,2
```

La respuesta debe identificar `ZVOL01`.

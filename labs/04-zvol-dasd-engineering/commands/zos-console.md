# z/OS Console - ZVOL operations

```text
D U,,,0A9B,2
VARY 0A9B,OFFLINE
D U,,,0A9B,1
```

Ejecutar `INITZV00`.

Si ICKDSF pide confirmación:

```text
R xx,U
```

Volver online:

```text
VARY 0A9B,ONLINE
D U,,,0A9B,1
```

Repetir para `ZVOL01`:

```text
VARY 0A9C,OFFLINE
D U,,,0A9C,1
R xx,U
VARY 0A9C,ONLINE
D U,,,0A9C,1
```

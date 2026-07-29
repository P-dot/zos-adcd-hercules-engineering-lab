# Rollback notes

## BPX.DAEMON

Solo si hubiera un problema operativo demostrado:

```text
RALTER FACILITY BPX.DAEMON UACC(READ)
SETROPTS RACLIST(FACILITY) REFRESH
RLIST FACILITY BPX.DAEMON ALL
```

## UNIXPRIV

No borrar perfiles salvo necesidad. Si fuera imprescindible desactivar la clase:

```text
SETROPTS NOCLASSACT(UNIXPRIV)
```

## HZSPDATA

No borrar `SYS1.ADCD.HZSPDAT2` mientras HZSPROC lo este usando.

## OPERCMDS

No forma parte de este lab. Cualquier intento sobre OPERCMDS queda fuera de alcance y debe tratarse en un lab nuevo.

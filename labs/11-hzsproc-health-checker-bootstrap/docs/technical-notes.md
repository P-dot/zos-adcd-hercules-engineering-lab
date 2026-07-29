# Technical notes

## HZSPROC

HZSPROC es el started task que ejecuta IBM Health Checker for z/OS. En este lab se valida que el procedimiento arranca, responde a comandos MODIFY y muestra checks desde SDSF CK.

## HZSPDATA

HZSPDATA es el dataset usado por Health Checker para persistir informacion de checks. El dataset original presento error, por lo que se creo `SYS1.ADCD.HZSPDAT2` como dataset nuevo y vacio y se respondio a la peticion de HZSPROC con ese nombre.

## OMVS

El check `USS_MAXSOCKETS_MAXFILEPROC` exigia aumentar valores de proceso/ficheros y sockets. Se ajusto dinamicamente:

```text
MAXFILEPROC=64000
MAXSOCKETS=64000
```

## BPX.DAEMON

`BPX.DAEMON` aparecia con `UACC(READ)`. Se cambio a `UACC(NONE)` y se refresco la clase FACILITY. Es una remediacion segura porque se conserva la access list explicita y se reduce el acceso universal.

## UNIXPRIV

Se crearon perfiles minimos `SUPERUSER.FILESYS*` con `UACC(NONE)`, se activo la clase `UNIXPRIV`, se activo RACLIST y se valido que el check `RACF_UNIXPRIV_ACTIVE` queda `SUCCESSFUL`.

## RACF_SENSITIVE_RESOURCES

El check permanece en `EXCEPTION-HIGH`. Este resultado se conserva como hallazgo y se deriva a un lab de seguridad RACF. No debe mezclarse con el cierre operativo de HZSPROC.

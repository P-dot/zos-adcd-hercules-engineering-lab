# LAB 11 - HZSPROC Health Checker bootstrap and safe RACF remediation

## Objetivo

Levantar IBM Health Checker for z/OS en el entorno ADCD sobre Hercules, corregir los problemas operativos necesarios para que HZSPROC funcione de forma estable y documentar remediaciones RACF seguras derivadas de los checks.

Este lab se centra solo en lo valido para HZSPROC y en remediaciones controladas de bajo riesgo. El endurecimiento completo de RACF queda fuera de alcance y se deriva al bloque de Seguridad z/OS/RACF.

## Alcance valido del lab

Incluido:

- Arranque y verificacion de HZSPROC.
- Reparacion del dataset HZSPDATA mediante un dataset nuevo vacio.
- Ajuste dinamico de parametros OMVS necesarios para el check USS_MAXSOCKETS_MAXFILEPROC.
- Validacion de Health Checker mediante panel CK y comandos MODIFY.
- Remediacion controlada de BPX.DAEMON cambiando UACC(READ) a UACC(NONE).
- Creacion y activacion minima de UNIXPRIV.
- Evidencia de RACF_UNIXPRIV_ACTIVE en estado SUCCESSFUL.

Fuera de alcance:

- OPERCMDS.
- TEMPDSN.
- TAPEVOL.
- Revocacion de IBMUSER.
- Proteccion masiva de SYS1.* o ADCD.Z111S.*.
- Correccion total de RACF_SENSITIVE_RESOURCES.

## Resultado final

Estado alcanzado:

```text
HZSPROC activo                         OK
HZSPDATA operativo                     OK
SYS1.ADCD.HZSPDAT2 en uso              OK
MAXFILEPROC=64000                      OK
MAXSOCKETS=64000                       OK
USS_MAXSOCKETS_MAXFILEPROC             SUCCESSFUL
BPX.DAEMON UACC READ -> NONE           OK
UNIXPRIV profiles creados              OK
UNIXPRIV class active                  OK
UNIXPRIV RACLIST activo                OK
RACF_UNIXPRIV_ACTIVE                   SUCCESSFUL
```

## Evidencias recomendadas

Guardar en `evidence/screenshots/`:

```text
01-hzsproc-active.png
02-hzsdata-error.png
03-hzsdata-new-dataset.png
04-uss-maxfileproc-maxsockets-before.png
05-uss-check-successful.png
06-bpx-daemon-before-after.png
07-unixpriv-profiles-uacc-none.png
08-racf-unixpriv-active-successful.png
09-racf-sensitive-resources-still-exception-high.png
```

## Interpretacion profesional

El objetivo del lab no era dejar todo RACF endurecido, sino habilitar IBM Health Checker, reparar su infraestructura basica y demostrar que los checks pueden guiar remediaciones controladas.

La excepcion `RACF_SENSITIVE_RESOURCES` continua siendo valida como hallazgo de seguridad. No se corrige en este lab porque implica datasets y clases sensibles que requieren un plan RACF independiente, control de rollback y pruebas de IPL/subsistemas.

## Conclusion

El lab queda cerrado como bootstrap operativo de HZSPROC + primer endurecimiento RACF seguro. El siguiente trabajo debe abrirse como un lab separado de Seguridad z/OS/RACF.

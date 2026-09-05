# Seguridad y rollback

- El origen fue el dump de `ZVOL00`; el destino autorizado fue únicamente `ZVOL01`.
- No se modificó `ZVOL00` ni volúmenes del sistema.
- No se borró ni se recreó el CDS de DFSMSrmm.
- No se utilizó `OPT=RESET`.
- En caso de fallo futuro, detener el job y conservar `SYSPRINT` antes de cualquier acción correctiva.

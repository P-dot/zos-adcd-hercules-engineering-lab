# LAB 14 - SMF MAN Dump / IFASMFDP Export

## Objetivo

Resolver los mensajes pendientes `IEE362A SMF ENTER DUMP FOR SYS1.MAN1`, `SYS1.MAN2` y `SYS1.MAN3` ejecutando un dump/export controlado de los datasets MAN de SMF con `IFASMFDP`.

## Contexto

Tras activar SMF en el lab anterior, el sistema comenzó a usar los datasets `SYS1.MAN*`. Posteriormente aparecieron mensajes `IEE362A`, indicando que los MAN necesitaban ser volcados y limpiados para poder seguir siendo reutilizados correctamente por SMF.

## Acciones ejecutadas

1. Creación del JCL `IBMUSER.HARDEN.CNTL(SMFDMP)`.
2. Ejecución de `IFASMFDP`.
3. Uso de `OPTIONS(ALL)` sobre `MAN1`, `MAN2` y `MAN3`.
4. Generación del dataset de salida `IBMUSER.SMF.LAB14.RUN01`.
5. Confirmación de `COND CODE 0000`.
6. Confirmación de limpieza de `SYS1.MAN1`, `SYS1.MAN2` y `SYS1.MAN3`.
7. Verificación posterior con `D R,L` y `D SMF`.

## Resultado

El job terminó correctamente y `IFASMFDP` confirmó que los tres datasets MAN fueron limpiados:

- `SYS1.MAN1` cleared.
- `SYS1.MAN2` cleared.
- `SYS1.MAN3` cleared.

La verificación final muestra SMF activo, con `SYS1.MAN2` como dataset activo y `SYS1.MAN1` / `SYS1.MAN3` como alternates.

## Estado final

- SMF sigue activo.
- El dataset de salida `IBMUSER.SMF.LAB14.RUN01` quedó catalogado.
- Los mensajes `IEE362A` dejaron de ser el problema operativo principal.
- Quedan fuera de este lab otros mensajes no relacionados: `IFB081I LOGREC DATA SET IS FULL` y `CSQ311I`.

## No realizado

- No se borraron datasets `SYS1.MAN*`.
- No se redefinieron MAN.
- No se modificó `SMFPRM00`.
- No se intentó interpretar el contenido binario del dataset SMF exportado.

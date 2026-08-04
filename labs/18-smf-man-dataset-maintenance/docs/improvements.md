# Improvements — LAB 18

## Mejora a nivel de laboratorio técnico

Antes del lab, SMF estaba activo pero los MAN datasets estaban llenos y exigían mantenimiento. Después del lab:

```text
SMF activo                         OK
MAN datasets descargados            OK
Salida SMF archivada                OK
Consola limpia                      OK
```

Esto mejora la capacidad del laboratorio para seguir generando evidencia de sistema, jobs, actividad operacional y auditoría.

## Mejora como imitación de mainframe real

En un entorno mainframe real, SMF no se deja indefinidamente en `DUMP REQUIRED`. Se monitoriza, se descarga, se archiva y se liberan los datasets MAN para continuar registrando actividad.

Este lab añade una práctica realista:

```text
Monitorización de SMF
Operación con MAN datasets
Dump/export con IFASMFDP
Gestión de errores de salida catalogada
Verificación posterior con consola limpia
```

## Nota de madurez tras el lab

```text
Laboratorio técnico z/OS personal:       8.9/10
Simulación de entorno empresarial real:  6.7/10
```

No sube más porque todavía faltan automatización SMF, políticas de retención, análisis de tipos SMF y hardening RACF/SAF más profundo.

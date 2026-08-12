# LAB 15 — SDSF System Requests (SR) mediante ISFPRM00

## Estado

**Completado correctamente.**

Este laboratorio documenta la activación de la opción **SR — System Requests** en SDSF, modificando el miembro activo de parámetros `ISFPRM00` en `ADCD.Z111S.PARMLIB`.

---

## Entorno

- Plataforma: z/OS ADCD 1.11 sobre Hercules
- Sistema: `ADCD`
- Componente: SDSF
- Started task: `SDSF`
- PARMLIB activa usada por SDSF: `ADCD.Z111S.PARMLIB`
- Miembro de parámetros: `ISFPRM00`
- Backup creado: `ISFPRMBK`

---

## Objetivo

Activar la opción SDSF:

```text
SR = System Requests
```

para visualizar desde SDSF las peticiones pendientes del sistema que requieren respuesta del operador.

Esto permite consultar mensajes pendientes sin depender únicamente de la consola principal.

---

## Situación inicial

Se revisó el started task `SDSF` y su salida de arranque. La evidencia confirma que SDSF utiliza el miembro:

```text
ADCD.Z111S.PARMLIB(ISFPRM00)
```

Dentro de `ISFPRM00`, el grupo relevante era:

```text
GROUP ISFSPROG - System Programmers
```

En la lista inicial de funciones autorizadas `AUTH(...)`, la opción `SR` no estaba incluida.

---

## Cambio realizado

Se añadió `SR` dentro de la lista `AUTH(...)` del grupo `ISFSPROG`.

Fragmento final documentado:

```text
AUTH(LOG,I,O,H,DA,DEST,PREF,
     SYSID,ABEND,ACTION,INPUT,
     FINDLIM,ST,INIT,PR,TRACE,
     ULOG,MAS,SYSNAME,LI,SO,NO,PUN,RDR,JC,SE,CK,SR,RES),
```

No se añadieron opciones no validadas como `RM`, para evitar errores de parámetros en esta versión/configuración.

---

## Procedimiento ejecutado

### 1. Revisión del SDSF activo

Desde SDSF se revisó el started task `SDSF` para confirmar el PROC y el miembro de parámetros usado.

Evidencia:

```text
evidence/01_sdsf_started_task_output.png
```

### 2. Revisión de `ISFPRM00`

Se navegó por:

```text
ADCD.Z111S.PARMLIB(ISFPRM00)
```

y se localizó el grupo `ISFSPROG` con su lista `AUTH(...)`.

Evidencias:

```text
evidence/02_isfprm00_initialization_header.png
evidence/03_isfsprog_auth_before_sr_missing.png
evidence/07_isfsprog_auth_browse_context.png
```

### 3. Backup del miembro activo

Antes de modificar el miembro activo, se creó copia de seguridad:

```text
ADCD.Z111S.PARMLIB(ISFPRM00)
        ->
ADCD.Z111S.PARMLIB(ISFPRMBK)
```

Evidencias:

```text
evidence/11_copy_isfprm00_to_backup_panel.png
evidence/12_copy_backup_target_isfprmbk_panel.png
```

### 4. Edición de `ISFPRM00`

Se editó `ISFPRM00` y se añadió `SR` en `AUTH(...)` del grupo `ISFSPROG`.

Evidencia:

```text
evidence/13_edit_isfprm00_isfsprog_auth_sr_added.png
```

### 5. Reinicio de SDSF

Desde consola se reinició SDSF:

```text
P SDSF
S SDSF
```

La activación quedó confirmada por mensajes de SDSF:

```text
ISF721I SDSF parameter processing started
ISF731I SDSF parameters being read from member ISFPRM00 of data set ADCD.Z111S.PARMLIB
ISF728I SDSF parameters have been activated
```

Evidencia:

```text
evidence/14_sdsf_restart_parameters_activated.png
```

### 6. Validación funcional

Tras reiniciar SDSF, se accedió a:

```text
SR
```

El panel `SDSF SYSTEM REQUESTS` quedó disponible y mostró peticiones pendientes del sistema.

Evidencia:

```text
evidence/15_sdsf_sr_system_requests_panel.png
```

---

## Resultado

| Validación | Resultado |
|---|---|
| SDSF arrancado | Correcto |
| `ISFPRM00` leído desde `ADCD.Z111S.PARMLIB` | Correcto |
| Parámetros activados | Correcto |
| Opción `SR` añadida al grupo `ISFSPROG` | Correcto |
| Panel `SDSF SYSTEM REQUESTS` accesible | Correcto |
| Backup previo creado | Correcto |

---

## Observación operativa

El panel `SR` permite ver peticiones pendientes, pero no implica que deban responderse automáticamente.

Durante la validación aparecieron peticiones relacionadas con el sistema, incluyendo mensajes de SMF/logrec. Esas peticiones se dejan fuera de este laboratorio y deben tratarse en un lab separado de **SMF / SYS1.MANx / dump de registros SMF**.

---

## Rollback

Si SDSF hubiera fallado al arrancar después del cambio, el procedimiento de reversión habría sido:

1. Restaurar el contenido original desde:

```text
ADCD.Z111S.PARMLIB(ISFPRMBK)
```

2. Volver a dejarlo como:

```text
ADCD.Z111S.PARMLIB(ISFPRM00)
```

3. Reiniciar SDSF:

```text
P SDSF
S SDSF
```

---

## Conclusión

Se modificó correctamente la configuración de SDSF en `ADCD.Z111S.PARMLIB(ISFPRM00)` para añadir la opción `SR` al grupo autorizado `ISFSPROG`.

Después del reinicio del started task `SDSF`, los mensajes de inicialización confirmaron que los parámetros fueron leídos y activados correctamente. La opción `SR` quedó disponible y permite visualizar las peticiones pendientes del sistema desde el panel `SDSF SYSTEM REQUESTS`.

**Lab cerrado correctamente.**

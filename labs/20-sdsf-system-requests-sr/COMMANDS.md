# LAB 20 — SDSF System Requests SR — Commands

## 1. Entrar en SDSF

Desde ISPF:

```text
SD
```

Objetivo: entrar en SDSF.

---

## 2. Localizar el started task SDSF

Dentro de SDSF:

```text
ST
```

Buscar SDSF:

```text
F SDSF
```

Seleccionar el job SDSF:

```text
S
```

Objetivo: revisar la salida del started task SDSF y confirmar qué miembro de parámetros está usando.

---

## 3. Confirmar miembro activo de SDSF

En la salida del started task se validó que SDSF leía:

```text
ADCD.Z111S.PARMLIB(ISFPRM00)
```

Miembro activo:

```text
ISFPRM00
```

Sufijo activo:

```text
00
```

---

## 4. Abrir PARMLIB en ISPF

Desde ISPF:

```text
3.4
```

Dataset:

```text
ADCD.Z111S.PARMLIB
```

Abrir en browse:

```text
B ISFPRM00
```

Buscar grupo de programadores de sistema:

```text
F ISFSPROG
```

Buscar autorización:

```text
F AUTH
```

Objetivo: comprobar si `SR` estaba o no autorizado.

---

## 5. Estado antes del cambio

Antes del cambio, el grupo `ISFSPROG` tenía una lista `AUTH(...)` sin `SR`.

Fragmento relevante antes:

```text
AUTH(LOG,I,O,H,DA,DEST,PREF,
     SYSID,ABEND,ACTION,INPUT,
     FINDLIM,ST,INIT,PR,TRACE,
     ULOG,MAS,SYSNAME,LI,SO,NO,PUN,RDR,JC,SE,CK,RES),
```

Problema: faltaba la opción:

```text
SR
```

---

## 6. Salir de Browse

```text
PF3
```

Objetivo: volver a la lista de miembros, porque en Browse no se modifica.

---

## 7. Crear backup de ISFPRM00

Desde ISPF:

```text
3.3
```

Seleccionar opción:

```text
C
```

Copiar desde:

```text
ADCD.Z111S.PARMLIB(ISFPRM00)
```

Copiar hacia:

```text
ADCD.Z111S.PARMLIB(ISFPRMBK)
```

Resultado esperado:

```text
ADCD.Z111S.PARMLIB(ISFPRM00)  -> miembro activo
ADCD.Z111S.PARMLIB(ISFPRMBK)  -> copia de seguridad
```

---

## 8. Editar ISFPRM00

Desde ISPF 3.4:

```text
ADCD.Z111S.PARMLIB
```

Editar:

```text
E ISFPRM00
```

Buscar:

```text
F ISFSPROG
```

Luego:

```text
F AUTH
```

---

## 9. Cambio realizado

Antes:

```text
AUTH(LOG,I,O,H,DA,DEST,PREF,
     SYSID,ABEND,ACTION,INPUT,
     FINDLIM,ST,INIT,PR,TRACE,
     ULOG,MAS,SYSNAME,LI,SO,NO,PUN,RDR,JC,SE,CK,RES),
```

Después:

```text
AUTH(LOG,I,O,H,DA,DEST,PREF,
     SYSID,ABEND,ACTION,INPUT,
     FINDLIM,ST,INIT,PR,TRACE,
     ULOG,MAS,SYSNAME,LI,SO,NO,PUN,RDR,JC,SE,CK,SR,RES),
```

Cambio exacto:

```text
SR
```

Añadido antes de:

```text
RES
```

---

## 10. Guardar cambios

En el editor ISPF:

```text
SAVE
```

Salir:

```text
PF3
```

---

## 11. Reiniciar SDSF

Desde consola z/OS:

```text
P SDSF
```

Esperar parada de SDSF.

Luego:

```text
S SDSF
```

Objetivo: forzar a SDSF a releer `ISFPRM00`.

---

## 12. Mensajes de validación

Mensajes observados:

```text
ISF721I SDSF parameter processing started
ISF731I SDSF parameters being read from member ISFPRM00 of data set ADCD.Z111S.PARMLIB
ISF728I SDSF parameters have been activated
```

Interpretación:

```text
ISF721I -> SDSF empieza a procesar parámetros.
ISF731I -> SDSF lee ISFPRM00 desde ADCD.Z111S.PARMLIB.
ISF728I -> los parámetros se activaron correctamente.
```

---

## 13. Probar SR

Entrar de nuevo en SDSF:

```text
SD
```

Ejecutar:

```text
SR
```

Resultado esperado:

```text
SDSF SYSTEM REQUESTS
```

---

## 14. Advertencia operativa

El panel `SR` permite ver peticiones pendientes del sistema, pero no se deben responder a ciegas.

En este lab apareció una petición relacionada con SMF:

```text
SMF ENTER DUMP FOR SYS1.MAN1
```

Eso pertenece a otro lab: SMF MANx dump/rotation.

---

## 15. Resultado final

```text
SDSF SR / System Requests: ACTIVADO
ISFPRM00 leído correctamente: SÍ
Parámetros SDSF activados: SÍ
Panel SDSF SYSTEM REQUESTS disponible: SÍ
Backup realizado: SÍ
Lab cerrado: SÍ
```

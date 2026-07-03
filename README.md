# Ingeniería de funcionamiento de z/OS ADCD sobre Hercules

Este repositorio documenta un laboratorio personal de ingeniería de sistemas mainframe basado en z/OS ADCD 1.11 ejecutado sobre Hercules en Windows.

El objetivo no es solo operar comandos, sino entender cómo funciona la máquina por dentro: hardware emulado, DASD, IPL, PARMLIB, PROCLIB, APF, LINKLIST, consola, subsistemas y superficies iniciales de auditoría.

## Objetivos del laboratorio

- Entender cómo Hercules presenta hardware emulado a z/OS.
- Mapear los volúmenes DASD y sus VOLSER.
- Reconstruir la cadena de arranque z/OS.
- Identificar qué miembros PARMLIB controlan el sistema.
- Documentar evidencias con capturas.
- Preparar una base para auditoría RACF, APF, PROCLIB y datasets críticos.

## Clases documentadas

| Clase | Tema | Resultado |
|---|---|---|
| Clase 1 | Operación básica y SDSF | Lectura de procesos, SYSLOG y LOGREC |
| Clase 2 | Radiografía de la máquina | Hardware emulado, CCKD, shadow files y fallo 0A85 |
| Clase 3 | Mapa DASD / VOLSER | Corrección de 0A85 y clasificación de volúmenes |
| Clase 4 | Cadena de arranque z/OS | IPL, IEASYSDB, PARMLIB, PROGDB, BPXPRMDB, IEFSSNDB |

## Entorno

- Host: Windows
- Emulador: Hercules
- Sistema: IBM ADCD z/OS 1.11
- Consola principal: L700 / 3270
- Herramientas: SDSF, ISPF, PARMLIB, dasdls, PowerShell, Git

## Aviso

Este repositorio documenta un laboratorio propio con fines educativos, defensivos y de ingeniería de sistemas. No contiene discos DASD, binarios de z/OS, contraseñas ni material propietario redistribuible.

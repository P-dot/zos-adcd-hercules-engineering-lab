# Findings - Lab 09

## Hallazgos

1. z/OS reconoce unidades de cinta 3490 emuladas en las direcciones `0580` y `0581`.
2. Los volúmenes sandbox `ZVOL00` y `ZVOL01` están online y disponibles para prácticas controladas.
3. La cinta virtual `BK0001.het` fue creada correctamente con `hetinit`.
4. El job `DMPZV00` solicitó montaje de cinta mediante `IEF233A`.
5. La cinta fue montada en Hercules con `devinit 0581`.
6. `ADRDSSU` procesó correctamente el comando `DUMP FULL`.
7. El backup terminó con `RETURN CODE 0000`.
8. El fichero HET creció tras el backup, confirmando escritura de datos en la cinta virtual.

## Problemas resueltos durante el lab

Durante el proceso se corrigieron errores de JCL relacionados con continuaciones y carga de `ADRDSSU`:

- se simplificó el JCL para evitar continuaciones delicadas en 3270;
- se añadió `REGION=0M` al paso `ADRDSSU`;
- se montó la cinta desde la consola Hercules, no desde Windows CMD.

## Conclusión

El entorno ADCD/Hercules queda preparado para prácticas de backup con DFSMSdss/ADRDSSU sobre cintas virtuales HET. La fase de restore queda explícitamente fuera de alcance y se realizará como lab separado con volumen destino controlado.

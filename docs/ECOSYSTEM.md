# Ecosystem Architecture

The portfolio models one integrated z/OS environment.

```text
z/OS ADCD 1.11 / Hercules
|
+-- Core z/OS
|   +-- JES2 / SDSF
|   +-- DFSMS / DASD
|   +-- WLM / RMF
|   +-- SMF
|   +-- SMP/E
|   +-- XCF / GRS
|
+-- Security
|   +-- RACF / SAF
|   +-- OPERCMDS / FACILITY
|   +-- Audit / hardening
|
+-- Batch
|   +-- JCL
|   +-- COBOL
|   +-- DFSORT
|   +-- TEMP datasets
|   +-- GDG
|   +-- Restart / recovery
|
+-- Data
|   +-- VSAM
|   +-- Db2
|
+-- Online
|   +-- CICS
|
+-- UNIX
|   +-- OMVS
|   +-- zFS
|   +-- POSIX
|
+-- Communications
|   +-- TCP/IP
|   +-- VTAM
|   +-- TN3270
|
+-- Languages / automation
    +-- COBOL
    +-- REXX
    +-- PL/I
```

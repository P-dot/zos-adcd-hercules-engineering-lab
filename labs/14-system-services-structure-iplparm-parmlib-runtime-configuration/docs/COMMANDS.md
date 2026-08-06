# LAB14 Commands and Evidence Collection

## SDSF operator commands

```text
/D IPLINFO
/D SYMBOLS
/D IOS,CONFIG
/D C,L
/D R,L
```

## ISPF browse/view evidence

Use browse/view only. Do not edit or save any member.

```text
SYS1.IPLPARM(LOADDB)
ADCD.Z111S.PARMLIB(IEASYSDB)
ADCD.Z111S.PARMLIB(IEASYM00)
ADCD.Z111S.PARMLIB(CONSOL00)
ADCD.Z111S.PARMLIB(SMFPRM00)
ADCD.Z111S.PARMLIB(MSTJCL00)
ADCD.Z111S.PARMLIB(COMMNDDB)
```

## Screenshot order

```text
01_d_iplinfo.png
02_d_symbols.png
03_d_ios_config.png
04_d_c_l_console_status.png
05_d_r_l_no_messages.png
06_sys1_iplparm_loaddb.png
07_parmlib_ieasysdb_part_1.png
08_parmlib_ieasysdb_part_2.png
09_parmlib_ieasym00.png
10_parmlib_consol00_part_1.png
11_parmlib_consol00_part_2.png
12_parmlib_smfprm00.png
13_parmlib_mstjcl00.png
14_parmlib_commnddb.png
```

## Do not execute

```text
EDIT
SAVE
REPLACE
SUBMIT
IPL
SET
SETLOAD
SETIOS
VARY
START
STOP
CANCEL
FORCE
```

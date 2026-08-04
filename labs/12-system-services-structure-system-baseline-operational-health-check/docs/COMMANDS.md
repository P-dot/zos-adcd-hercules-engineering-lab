# LAB12 Commands - System Baseline and Operational Health Check

## SDSF / operator commands

```text
/D IPLINFO
/D A,L
/D M=CPU
/D M=STOR
/D ASM
/D IOS,CONFIG
/D U,DASD,ONLINE
/$D SPOOL
/$D SPOOLDEF
/D WLM
/D R,L
/D C,L
```

## SDSF panel

```text
DA
```

## Capture checklist

```text
01_d_iplinfo.png
02_d_a_l_activity.png
03_d_m_cpu.png
04_d_m_stor_real_storage.png
05_d_asm_auxiliary_storage.png
06_d_ios_config.png
07_d_u_dasd_online.png
08_jes2_d_spool.png
09_jes2_d_spooldef.png
10_d_wlm_policy_status.png
11_d_r_l_no_messages.png
12_d_c_l_console_status.png
13_sdsf_da_system_baseline_part_1.png
14_sdsf_da_system_baseline_part_2.png
```

## Do not run in this lab

```text
VARY
SETIOS
SETASM
SETSMS
SETPROG
CHNGDUMP
DUMPDS
START
STOP
CANCEL
FORCE
$P
$C
$S
$T
```

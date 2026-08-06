# LAB19 - HCD / IODF Read-Only Engineering Baseline

## Objective

Map the active z/OS I/O runtime configuration to the Hardware Configuration Definition panels in a non-destructive way.

This lab validates how an ADCD z/OS 1.11 system running on Hercules relates operator displays, IPL configuration, the active IODF, operating system configuration, channel paths, control units, I/O devices, consoles and communications-related device definitions.

## Environment

- Platform: IBM ADCD z/OS 1.11 on Hercules
- System name: ADCD
- IPL device: 0A80
- IPL volume: SBRES1
- IPLPARM device: 0A82
- LOAD member: SYS1.IPLPARM(LOADDB)
- Active IODF: SYS1.IODF09
- Operating system configuration: OS390
- EDT ID: 00
- Active CSS: 0
- Console: L700 MCS, AUTH(MASTER), hardcopy log SYSLOG

## Scope

Read-only review only. No HCD activation, no IOCDS build, no production IODF build, no dynamic activation and no device changes were performed.

## Evidence summary

The lab captures:

- `D IPLINFO` showing LOADDB, IEASYS DB, IEASYM 00, IPL 0A80 and volume SBRES1.
- `D IOS,CONFIG` showing active IODF `SYS1.IODF09`, configuration `OS390`, EDT `00` and CSS `0`.
- DASD online/offline displays.
- Channel path and device displays for 0A, 0A80, 0A82 and 0A85.
- Console L700 status and no outstanding messages.
- `SYS1.IPLPARM(LOADDB)` as the IPL configuration member.
- HCD generic list, empty switch list, processor definition, control unit list and I/O device lists.
- HCD I/O devices around 0700, 0A80-0A8F and 0E20-0E23.
- Final `D IOS,CONFIG` and `D R,L` after leaving HCD, proving the review was non-disruptive.

## Main findings

1. The active runtime I/O configuration is `SYS1.IODF09`, `OS390`, `EDT 00`, `CSS 0`.
2. The IPL chain maps from `D IPLINFO` to `SYS1.IPLPARM(LOADDB)`.
3. HCD contains the expected logical hardware configuration objects: generics, processor definition, control units and I/O devices.
4. The processor definition shows `M3000H30`, processor type `7060`, configuration mode `BASIC`.
5. HCD I/O device ranges include 3270 console/terminal definitions, DASD 3390 ranges and communication-related CTC/LCS-style entries.
6. The post-HCD runtime check still shows the same active IODF and no outstanding messages.

## Professional value

This lab demonstrates the ability to read z/OS hardware configuration safely: connecting runtime operator commands, IPL configuration, HCD panels and IODF content without modifying the system.


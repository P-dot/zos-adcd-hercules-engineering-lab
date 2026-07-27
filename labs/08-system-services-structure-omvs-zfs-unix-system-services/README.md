# LAB08 - z/OS System Services Structure: OMVS, zFS and UNIX System Services

## Course alignment

IBM Course: DL00EZ20IG - z/OS System Services Structure  
Lab focus: UNIX System Services in z/OS

Related concepts:

- OMVS address space
- BPXOINIT and UNIX process initialization
- zFS and registered physical file systems
- OMVS configuration options
- UNIX-related servers and network services
- Console and pending message verification

## Objective

Observe UNIX System Services on a running ADCD z/OS system using non-destructive operator commands and SDSF evidence. The lab verifies that OMVS, zFS and related USS components are active, and records compatibility behaviour for OMVS DISPLAY parameters in this z/OS 1.11 ADCD environment.

## Environment

- Platform: ADCD z/OS on Hercules
- System name: ADCD
- Access method: 3270 / SDSF / MCS console
- Console: L700

## Commands executed

```text
/D A,L
/D OMVS
/D OMVS,O
/D OMVS,PFS
/D OMVS,SERVER
/D OMVS,STORAGE
/D R,L
/D C,L
DA
```

## Evidence summary

### Active address spaces

`D A,L` and SDSF `DA` show active services related to USS and networking, including:

```text
OMVS
BPXOINIT
ZFS
TCPIP
SSHD4
FTPD1
HTTPD1
INETD4
PORTMAP
NFSS
NFSC
```

### OMVS status

`D OMVS` shows OMVS as active:

```text
OMVS ACTIVE
OMVS=(DB)
```

This confirms that UNIX System Services is running and using the OMVS configuration suffix shown by the display.

### OMVS options

`D OMVS,O` displays active UNIX System Services configuration options such as process, file, thread, IPC and user-related limits. The display also shows relevant options such as:

```text
SUPERUSER = OMVSKERN
FORKCOPY = COW
SYSPLEX = YES
```

### Physical File Systems

`D OMVS,PFS` shows registered physical file systems, including:

```text
INET
NFS
ZFS
AUTOMNT
UDS
HFS
```

The key finding is that zFS appears as a registered PFS:

```text
ZFS  IOEFSCM1  ZFS  LOCAL
```

### Unsupported OMVS display parameters

Some display variants returned:

```text
IEE535I DISPLAY INVALID PARAMETER
```

This was captured as compatibility evidence for the ADCD z/OS 1.11 environment. No corrective action was taken.

### Console and pending messages

`D R,L` shows no outstanding messages requiring an operator reply. `D C,L` confirms console L700 is active as an MCS console and that the hardcopy log is SYSLOG.

## Findings

```text
OMVS is active.
OMVS configuration: OMVS=(DB).
BPXOINIT is active.
zFS is active and registered as a Physical File System.
SUPERUSER is configured as OMVSKERN.
FORKCOPY is configured as COW.
SYSPLEX appears as YES in OMVS options.
Related services are visible: TCPIP, SSHD4, FTPD1, HTTPD1, INETD4, PORTMAP, NFSS/NFSC.
No outstanding operator replies were present.
Console L700 is active.
Some OMVS DISPLAY parameters are not accepted in this z/OS 1.11 ADCD environment.
```

## Conclusion

This lab validates that UNIX System Services is active in the ADCD z/OS environment and that zFS is registered as a usable physical file system. It also demonstrates safe operator-level verification of USS-related address spaces, OMVS options, PFS configuration, pending messages and console status.

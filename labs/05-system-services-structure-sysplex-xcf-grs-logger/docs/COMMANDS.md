# LAB05 Commands

## SDSF / operator commands

```text
/D A,L
/D XCF
/D XCF,COUPLE
/D XCF,GROUP
/D GRS
/D WLM
/D R,L
/D C,L
```

## SDSF panel

```text
DA
```

## Purpose

```text
/D A,L        - Display active address spaces.
/D XCF        - Display XCF / sysplex identity.
/D XCF,COUPLE - Display couple data set information.
/D XCF,GROUP  - Display XCF groups.
/D GRS        - Display Global Resource Serialization status.
/D WLM        - Display Workload Manager policy/status.
/D R,L        - Display pending replies/messages.
/D C,L        - Display console status.
DA            - Review active address spaces from SDSF.
```

## Safety boundary

Do not run configuration-changing commands in this lab:

```text
SETXCF
SETGRS
VARY
START
STOP
CANCEL
FORCE
CHNGDUMP
```

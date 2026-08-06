# Findings

## Active runtime I/O configuration

`D IOS,CONFIG` showed:

```text
ACTIVE IODF DATA SET = SYS1.IODF09
CONFIGURATION ID = OS390
EDT ID = 00
ACTIVE CSS: 0
CHANNEL MEASUREMENT BLOCK FACILITY IS ACTIVE
```

## IPL and configuration chain

`D IPLINFO` and `SYS1.IPLPARM(LOADDB)` support the mapping:

```text
IPL device: 0A80
IPL volume: SBRES1
IPLPARM: 0A82
LOAD member: LOADDB
IEASYS: DB
IEASYM: 00
IODF: SYS1.IODF09
```

## HCD review

Captured HCD panels show:

- Generic List by Name.
- Switch List with no switches defined.
- Processor definition: `M3000H30`, processor type `7060`, configuration mode `BASIC`.
- Control Unit List with 3990 and 3174-style definitions.
- I/O Device List with terminal, DASD, tape and communication-related entries.
- Operating System Configuration List containing `OS390`.

## Safety result

After leaving HCD, the final displays showed the same active IODF and no outstanding messages. No configuration activation or build was performed.

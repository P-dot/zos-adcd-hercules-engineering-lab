# Lab 40 — Modern Zowe workstation integration with legacy z/OS V1R11 over FTP

## Objective

Integrate a modern VS Code + Zowe workstation with a legacy **z/OS ADCD V1R11** system running under **Hercules**, without depending on a modern z/OSMF stack.

The lab documents the complete engineering path from the original host/network boundary problem to a validated command-line workflow capable of:

- authenticating to z/OS FTP from Zowe;
- listing MVS data sets;
- reading sequential data sets;
- listing PDS members;
- reading an individual PDS member;
- downloading a member into a local VS Code workspace;
- preparing the workstation for controlled local-edit / upload / JES workflows.

> **Security note:** host IP addresses, adapter identifiers and other workstation-specific network details are intentionally sanitized in the published evidence. The lab preserves architecture and reproducibility without publishing host network identifiers.

---

## Environment

| Layer | Component |
|---|---|
| Workstation | Windows + Visual Studio Code |
| Client integration | Zowe Explorer 3.6.0 |
| FTP integration | Zowe Explorer FTP extension 3.6.0 |
| CLI | Zowe CLI + IBM z/OS FTP Plug-in |
| Emulator host | Windows + Hercules 3.13 |
| Mainframe guest | z/OS ADCD V1R11 |
| z/OS network | Communications Server TCP/IP + LCS |
| Server service | z/OS FTPD |
| Data | MVS sequential data sets and PDS members |

---

## Architecture reached

```text
Modern workstation / VS Code
        |
        | Zowe Explorer + Zowe CLI
        | FTP control + passive data channels
        v
Windows intermediary / Hercules host
        |
        | TCP port forwarding
        v
Hercules LCS boundary
        |
        v
z/OS V1R11 Communications Server
        |
        +--> FTPD :21
        |
        +--> MVS data sets / PDS
        |
        +--> USS / JES capabilities through FTP
```

The important engineering decision was to avoid treating the old Hercules/LCS-on-Wi-Fi path as if it were a transparent modern Layer-2 bridge. The working design uses the Windows host as an explicit intermediary for the FTP control connection and the configured passive data-port range.

---

## Engineering itinerary

### 1. Establish the legacy z/OS network baseline

The z/OS guest already exposed an LCS device and Ethernet link through Hercules. TCP/IP was configured with a guest home address on that link and FTPD was started from the z/OS TCP/IP environment.

Validation on z/OS established that:

- the LCS device was `Ready`;
- the Ethernet link was `Ready`;
- the z/OS guest owned its configured IPv4 home address;
- FTPD was listening on TCP port 21.

This separated **z/OS service readiness** from **external workstation reachability**.

### 2. Diagnose the external connectivity boundary

Direct workstation-to-guest FTP did not provide a reliable path. Earlier packet-level investigation showed that the failure was at the emulator/host networking boundary rather than at FTP authentication itself.

The key lesson was that successful internal z/OS TCP/IP configuration does not automatically imply transparent reachability through an old Hercules LCS backend, especially when the Windows host is connected through Wi-Fi.

### 3. Preserve the known-good Hercules/z/OS state

Rather than repeatedly changing the guest TCP/IP profile, the lab preserved the working z/OS configuration and moved the compatibility solution to the Windows intermediary layer.

This is an important operational pattern:

```text
Known-good guest service
        |
        +--> preserve
        |
Unreliable external transport
        |
        +--> adapt at boundary
```

### 4. Make FTP data-channel behavior deterministic

FTP is not a single-connection protocol. The control session uses port 21, while directory listings and file transfers require a separate data connection.

A bounded passive range was therefore configured in the z/OS FTP server:

```text
PASSIVEDATAPORTS (50000,50009)
```

FTPD was restarted and returned to listening state.

This step is fundamental because forwarding only the FTP control port is insufficient for `LIST`, `RETR` and `STOR` operations.

### 5. Introduce the Windows FTP intermediary

The Hercules host was configured to expose one workstation-facing TCP port for FTP control and the bounded passive range, forwarding them toward the z/OS guest.

Conceptually:

```text
<HOST_LAN_IP>:2121       -> <ZOS_GUEST_IP>:21
<HOST_LAN_IP>:50000      -> <ZOS_GUEST_IP>:50000
...
<HOST_LAN_IP>:50009      -> <ZOS_GUEST_IP>:50009
```

The exact host and guest addresses are intentionally omitted from the public lab.

The PowerShell template is preserved under `commands/01-portproxy-template.ps1`.

### 6. Install and configure Zowe Explorer

VS Code was equipped with:

```text
zowe.vscode-extension-for-zowe@3.6.0
zowe.zowe-explorer-ftp-extension@3.6.0
```

A `zftp` profile was configured to use the intermediary host and port 2121 with non-secure FTP for this isolated laboratory.

The sanitized configuration is stored in `config/zowe.config.sanitized.json`.

### 7. Validate Zowe Explorer data-set access

Zowe Explorer successfully authenticated through the FTP profile and listed `IBMUSER.*` data sets.

A sequential data set was opened and read successfully. A controlled edit added the line:

```text
PRUEBA ZOWE FTP
```

Although the graphical save operation remained in a pending state longer than expected, later CLI validation proved that the write had reached the MVS data set.

This distinction matters operationally: **UI completion state and server-side write completion are not always identical observations**.

### 8. Install the Zowe CLI FTP plug-in

Zowe CLI was present on the workstation, but initially had no plug-ins installed.

The IBM z/OS FTP plug-in was installed for the Zowe v3 LTS line:

```powershell
zowe.cmd plugins install @zowe/zos-ftp-for-zowe-cli@zowe-v3-lts
```

Validation reported successful installation.

After installation, the CLI exposed the `zos-ftp` command group, including operations for MVS data sets, USS files and JES/spool interaction.

### 9. Validate sequential data-set access from CLI

The first read-only CLI validation was:

```powershell
zowe.cmd zos-ftp view data-set "IBMUSER.BATCH.INPUT"
```

Observed content included:

```text
DICIEMBRE

PRUEBA ZOWE FTP
```

This simultaneously proved:

1. the CLI FTP path was operational end-to-end;
2. the previous graphical write had reached z/OS.

Evidence: `evidence/screenshots/01-zowe-cli-dataset-read-success.png`.

### 10. Validate catalog listing

The CLI successfully enumerated the user's data sets:

```powershell
zowe.cmd zos-ftp list data-set "IBMUSER.*"
```

The result included application, JCL, COBOL, CICS, Db2, REXX, RACF, SMF, VSAM and scheduler laboratory data sets.

This demonstrated that the workstation could perform MVS catalog-oriented discovery through the FTP plug-in.

### 11. Validate PDS directory access

The REXX PDS was selected as a controlled development example:

```powershell
zowe.cmd zos-ftp list data-set-members "IBMUSER.REXX.EXEC"
```

Seven members were returned:

```text
ADD2
ARITH04
GRADE02
JES2CLN
JES2CLN1
J2CLNALL
LEVEL02
```

### 12. Read an individual PDS member

The member `ARITH04` was retrieved directly to stdout:

```powershell
zowe.cmd zos-ftp view data-set "IBMUSER.REXX.EXEC(ARITH04)"
```

The REXX source was returned correctly, proving member-level retrieval.

### 13. Download a PDS member into a VS Code workspace

A local development directory was created:

```powershell
New-Item -ItemType Directory -Force "$HOME\zos-workspace\rexx" | Out-Null
Set-Location "$HOME\zos-workspace\rexx"
```

The PDS member was then downloaded:

```powershell
zowe.cmd zos-ftp download data-set "IBMUSER.REXX.EXEC(ARITH04)" --file "ARITH04.rexx"
```

Result:

```text
Data set downloaded successfully. ARITH04.rexx
```

Evidence: `evidence/screenshots/02-zowe-cli-pds-member-download-success.png`.

The local folder was opened as a VS Code workspace:

```powershell
code.cmd "$HOME\zos-workspace\rexx"
```

Evidence: `evidence/screenshots/03-vscode-local-rexx-workspace.png`.

### 14. Trust the controlled local workspace

VS Code initially opened the folder in Restricted Mode. Only the dedicated laboratory folder was marked as trusted so that extensions and future task automation can operate within the controlled workspace.

---

## Validated capabilities

| Capability | Result |
|---|---|
| FTP authentication from Zowe | PASS |
| List MVS data sets | PASS |
| Read sequential data set | PASS |
| Write sequential data set | PASS — server-side result verified by later read |
| List PDS members | PASS |
| Read PDS member | PASS |
| Download PDS member locally | PASS |
| Open local z/OS source workspace in VS Code | PASS |
| USS through `zos-ftp` | Available in CLI; not validated in this part |
| JES submit/spool through `zos-ftp` | Available in CLI; not validated in this part |
| Automated upload/edit cycle | Next controlled step |

---

## What this lab proves

This lab is not merely a VS Code installation exercise. It demonstrates a compatibility architecture between a current developer workstation and a legacy mainframe environment.

The final path is:

```text
VS Code
   |
Zowe Explorer / Zowe CLI
   |
IBM z/OS FTP integration
   |
Windows compatibility boundary
   |
Hercules
   |
z/OS V1R11 FTPD
   |
MVS data sets / PDS
```

The resulting workflow allows modern tooling to coexist with a legacy z/OS release while keeping the compatibility workaround outside the guest wherever possible.

---

## Operational lessons

1. Validate the z/OS service independently from external reachability.
2. Treat FTP control and data channels as separate network flows.
3. Bound passive FTP ports before building forwarding rules.
4. Preserve a known-good guest configuration while diagnosing the emulator/host boundary.
5. Use read-only tests before destructive or write operations.
6. Validate server-side state after a GUI operation appears stalled.
7. Keep credentials out of repository content.
8. Sanitize host IPs, MAC addresses and adapter identifiers before publication.
9. Use the FTP-specific Zowe command group for this legacy architecture rather than assuming modern z/OSMF services are available.

---

## Next part

Part 2 should extend the validated workstation path with controlled engineering operations:

```text
local source
    -> upload to test PDS member
    -> verify from z/OS
    -> submit controlled JCL through FTP/JES
    -> inspect job status and spool
    -> validate USS listing/download/upload
    -> package repeatable VS Code tasks
```

No production or security-sensitive data is required for those tests.

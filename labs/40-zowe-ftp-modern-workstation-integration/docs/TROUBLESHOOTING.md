# Troubleshooting notes

## Symptom: control connection works but LIST/RETR/STOR hangs

FTP uses separate control and data connections. A forwarded control port alone does not make directory listing or file transfer work.

For this lab, the z/OS FTP server was constrained to a known passive range:

```text
PASSIVEDATAPORTS (50000,50009)
```

The intermediary host forwards both the workstation-facing control port and every port in that passive range.

## Symptom: Zowe Explorer save appears to remain on “Writing into file...”

Do not assume that the server-side write failed solely from the UI state. Verify the target data set independently. In this lab, a later CLI `view data-set` showed `PRUEBA ZOWE FTP`, proving that the write had reached z/OS.

## Symptom: PowerShell blocks npm.ps1 or zowe.ps1

The workstation execution policy blocked PowerShell script shims. The lab avoided changing the system execution policy and invoked the Windows command shim instead:

```powershell
zowe.cmd ...
```

This kept the workstation security posture unchanged.

## Symptom: Zowe CLI has no `zos-ftp` group

Zowe Explorer's FTP extension and Zowe CLI plug-ins are separate components. Check:

```powershell
zowe.cmd plugins list
```

Install the FTP plug-in when absent:

```powershell
zowe.cmd plugins install @zowe/zos-ftp-for-zowe-cli@zowe-v3-lts
```

## Symptom: VS Code opens the downloaded source in Restricted Mode

Trust only the dedicated controlled workspace folder, not an unnecessarily broad parent directory.

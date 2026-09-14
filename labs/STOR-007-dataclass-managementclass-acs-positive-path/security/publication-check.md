# Publication Safety Check

## Scope

Curated screenshots and text artifacts were reviewed before packaging.

## Checks

- No host IP addresses are intentionally published.
- No MAC addresses are intentionally published.
- No local Windows paths are embedded in evidence screenshots.
- No passwords, tokens, SSH keys, or credentials are included.
- No external production hostnames are included.
- The evidence is limited to the isolated laboratory environment.

## Expected laboratory identifiers

The following are intentionally retained because they are necessary to understand and reproduce the lab:

```text
IBMUSER
SYS1.SCDS
IBMUSER.HARDEN.CNTL
SMSDATA
SMSMGMT
ACSDATA
DCTEST1
IBMUSER.SMSLAB.TESTDC
```

These identifiers describe the lab policy and are not secret credentials.

## Pre-push verification

Run the repository-wide grep checks from the installation command block before commit/push. Binary screenshots must also be visually reviewed because text grep cannot inspect PNG content reliably.

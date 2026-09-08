# Git Branching Strategy

## Objective

Keep every mainframe repository stable, understandable and reproducible.

`main` represents the latest validated and publishable state. Branches represent temporary work.

## Main branch

`main` should contain only work that has been documented, reviewed, validated and checked for publication security.

## Documentation branches

Format:

```text
docs/<topic>
```

Example:

```text
docs/ecosystem-architecture-v1
```

## Laboratory branches

Format:

```text
lab/<number>-<short-description>
```

Examples:

```text
lab/05-in-out-conditions
lab/13-racf-security-integration
lab/40-smf-scheduler-correlation
```

## Integration branches

Format:

```text
integration/<relationship>
```

Recommended names:

```text
integration/scheduler-jcl-jes2
integration/scheduler-cobol-vsam
integration/scheduler-cobol-db2
integration/cics-cobol-db2
integration/racf-network-smf
integration/uss-racf-tcpip
integration/storage-backup-recovery
integration/rexx-ispf-automation
integration/assembler-system-programming
integration/end-to-end-production-cycle
```

Create these only when implementation work begins. They should not become permanent architecture branches.

## Fix branches

Format:

```text
fix/<description>
```

Examples:

```text
fix/scheduler-repository-name
fix/readme-links
fix/lab-numbering
```

## Branch lifecycle

```text
main
 |
 +---- short-lived branch
            |
            +---- implementation
            +---- documentation
            +---- testing
            +---- security review
            |
            v
        Pull Request
            |
            v
          main
```

Delete temporary branches after merge unless there is a specific reason to preserve them.

## Do not use branches as folders

Avoid permanent branches such as:

```text
racf
db2
cics
network
assembly
scheduler
```

Those are architecture domains, not concurrent development lines.

## Commit principles

Prefer specific messages such as:

```text
Add scheduler JES2 submission tracking lab
Document RACF and TCP/IP integration path
Add COBOL VSAM batch integration evidence
Fix scheduler repository references
```

Avoid vague messages such as `update`, `changes`, `stuff`, `fix` or `test`.

## Pull Request standard

A significant lab or integration PR should describe:

- Objective
- Scope
- Systems/components affected
- Files changed
- Validation performed
- Expected RC/result
- Negative test if applicable
- Rollback
- Publication-security review
- Related repositories/labs

## Tags

Potential stable milestone tags:

```text
ecosystem-v1.0
scheduler-foundations-v1
racf-security-baseline-v1
network-security-baseline-v1
batch-integration-v1
production-cycle-v1
```

Tags represent stable states. Branches represent temporary work.

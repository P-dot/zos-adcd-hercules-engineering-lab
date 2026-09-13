# z/OS Laboratory Ecosystem Architecture

This directory documents how the P-dot mainframe repositories participate in a single learning, engineering and operational z/OS laboratory ecosystem.

The repositories are intentionally specialized, but they are not treated as isolated projects. Their long-term value comes from demonstrating how z/OS components interact across onboarding, system engineering, security, networking, batch operations, application development, data management, automation and recovery.

## Architecture V1 — Repository and component relationships

Architecture V1 documents how the repositories and z/OS components relate to one another.

### Documents

- `LAB-ECOSYSTEM.md` — repository roles and architectural relationships
- `LEARNING-PATHS.md` — structured learning paths for different mainframe profiles
- `CROSS-REPO-LAB-CHAINS.md` — end-to-end integration tracks across repositories
- `SYSTEM-EVOLUTION.md` — how the laboratory environment has matured
- `BRANCHING-STRATEGY.md` — Git workflow for labs, documentation and integration work
- `INTEGRATION-ROADMAP.md` — prioritized cross-repository work

## Architecture V2 — Engineering domains and operational lifecycle

Architecture V2 extends Architecture V1 without replacing it.

V1 answers:

> How do the technologies, repositories and components interact?

V2 adds:

> How is engineering work organized, how does each capability mature, and how are validated capabilities combined into production-like workflows?

Architecture V2 is located under [`v2/`](v2/).

### Architecture V2 documents

- [`v2/README.md`](v2/README.md) — Architecture V2 purpose, principles and target state
- [`v2/ENGINEERING-DOMAINS.md`](v2/ENGINEERING-DOMAINS.md) — engineering domains, ownership boundaries and cross-cutting planes
- [`v2/LAB-TAXONOMY.md`](v2/LAB-TAXONOMY.md) — lab identity, capability, lifecycle, maturity, integration and evidence taxonomy
- [`v2/LAB-MIGRATION-MATRIX.md`](v2/LAB-MIGRATION-MATRIX.md) — classification of the existing historical lab inventory
- [`v2/OPERATIONAL-MATURITY.md`](v2/OPERATIONAL-MATURITY.md) — maturity model from exploration through integrated engineering
- [`v2/PRODUCTION-TRACKS.md`](v2/PRODUCTION-TRACKS.md) — cross-domain and production-like integration tracks
- [`v2/REPOSITORY-EVOLUTION.md`](v2/REPOSITORY-EVOLUTION.md) — repository specialization criteria and controlled ecosystem evolution

## Relationship between V1 and V2

```text
Architecture V1
Repository and component relationships
        |
        v
Architecture V2
Engineering domains
        |
        v
Capabilities
        |
        v
Operational lifecycle and maturity
        |
        v
Cross-domain integration
        |
        v
Production-like workflows
```

Architecture V1 remains the architectural map of the ecosystem.

Architecture V2 adds the engineering operating model used to decide:

- where a capability belongs;
- how mature that capability is;
- what evidence is required;
- which repository should own future development;
- and when several capabilities are ready to become an integration or production track.

## Architectural principle

Technology-specific repositories establish individual skills and capabilities.

Cross-repository integration laboratories prove that those capabilities can operate together in realistic z/OS workflows.

Architecture V2 extends that principle:

> Domain repositories validate capabilities. Integration tracks prove that those capabilities work together. Core Platform provides the common z/OS environment in which those capabilities are integrated.

The objective is not simply to increase the number of laboratories, but to progressively build a documented, observable, secure, recoverable and increasingly automated z/OS engineering environment.

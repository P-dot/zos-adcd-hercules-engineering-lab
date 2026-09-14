# Capability Lineage

## Architecture rule

Architecture V2 preserves validated historical labs in the Core repository and sends **new domain-native Storage/DFSMS work** to the Storage repository.

This lab therefore references prior storage capability instead of relocating it.

## Upstream capability

```text
Core platform DFSMS baseline
        |
        +--> SMS fundamentals
        +--> SMS pool creation
        +--> Storage Class ACS
        +--> Storage Group ACS
        +--> automatic allocation proof
        |
        v
DFSMS policy capability-gap analysis
        |
        v
STOR-007 (this lab)
        |
        +--> SMSDATA Data Class
        +--> SMSMGMT construct foundation
        +--> ACSDATA
        +--> translate / validate / positive test
```

## Referenced historical Core paths

```text
labs/15-dfsms-sms-introduction-baseline/
labs/16-dfsms-sms-pool-creation/
labs/17-dfsms-sms-acs-automatic-allocation/
labs/dfsmspolicy-baseline-capability-gap-analysis/
```

## Downstream continuation

The next lab begins from this validated state and must not recreate `ACSDATA`, `SMSDATA`, or `DCTEST1` from scratch unless recovery requires it.

# Engineering Notes

## Why the test was isolated to `DC`

The environment already contains previously validated Storage Class and Storage Group ACS logic. Running `SC=Y` or `SG=Y` during this test would make the result less precise because several policy routines would participate in the same test execution.

The selected configuration:

```text
DC=Y  SC=N  MC=N  SG=N
```

produces evidence for one question only:

> Does the new Data Class ACS routine classify `IBMUSER.SMSLAB.*` as `SMSDATA`?

The observed answer is yes.

## Why `DCTEST1` was created instead of reusing an old member

Existing ACS test members are part of previous storage-policy evidence. A new test member preserves historical reproducibility and prevents a new lab from silently rewriting the proof set of an earlier lab.

## Why the lab stops before activation

Translation, validation, and ACS testing prove that the policy object is internally consistent and that the intended decision can be produced. They do not yet prove production-like allocation behavior after activation.

Activation therefore remains a separate change-control event with its own prerequisites and rollback evidence.

## Management Class boundary

`SMSMGMT` was created as a construct foundation during the same engineering session, but no Management Class ACS routine was built. The repository must not claim that `SMSMGMT` is automatically assigned until an `ACSMGMT` routine is implemented and proven.

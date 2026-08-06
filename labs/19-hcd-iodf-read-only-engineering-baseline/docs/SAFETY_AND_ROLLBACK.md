# Safety and rollback notes

No rollback was required because no changes were made.

## Safe behavior used

- Entered HCD with `SYS1.IODF09`.
- Reviewed lists and definitions.
- Avoided add/update/build/activate options.
- Exited without saving.
- Verified runtime with `D IOS,CONFIG` and `D R,L`.

## If a prompt asks to save or activate

Answer:

```text
NO
CANCEL
END
```

Then verify:

```text
/D IOS,CONFIG
/D R,L
```

## Operational rule

HCD must not be used casually. In this lab it is a read-only engineering baseline, not a configuration change exercise.

# Findings

## Finding 1 - SMF MAN datasets required dump/export

The console had pending `IEE362A SMF ENTER DUMP FOR SYS1.MAN1/2/3` messages after SMF activation.

## Finding 2 - IFASMFDP completed successfully

`SMFDMP` ended with condition code `0000`.

## Finding 3 - MAN datasets were cleared

`SYSPRINT` showed that `SYS1.MAN1`, `SYS1.MAN2` and `SYS1.MAN3` were cleared.

## Finding 4 - SMF remained active

Final `D SMF` showed SMF active, with `SYS1.MAN2` active and the other MAN datasets available as alternates.

## Finding 5 - Separate pending issues remain

`LOGREC DATA SET IS FULL` and `CSQ311I` are separate operational findings and are not part of this SMF MAN dump lab.

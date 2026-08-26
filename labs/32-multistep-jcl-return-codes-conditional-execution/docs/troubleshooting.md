# Troubleshooting and lessons learned

## RC from compilation versus RC from application execution

The compiler and binder returning RC 0 only mean that `BATRC` was built successfully. The program can later terminate normally while deliberately returning RC 4 to its caller/JES.

## Do not confuse RC 4 with an abend

The RC 4 test is an intentional application condition. It is used to prove that JCL can route execution without forcing an abnormal termination.

## Conditional suppression is stronger than program-side skipping

When `STEP02` is excluded by `IF/THEN/ELSE`, JES does not execute `BATFILE`. Its step resources are therefore not allocated. This is preferable to starting a business program merely to make it decide to do nothing.

## Keep the flow constant while testing branches

The strongest evidence came from leaving `BATFLOW` unchanged and changing only the return code produced by `BATRC`. This isolates the variable being tested.

## ADCD COBOL prefix

The compile procedure used the environment-specific override:

`EXEC IGYWCL,LNGPRFX='IGY420'`

This was already validated in the preceding batch lab.

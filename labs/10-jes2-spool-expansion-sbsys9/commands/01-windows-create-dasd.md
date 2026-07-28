# Windows - create the new Hercules DASD volume

Run from Windows CMD:

```bat
cd /d F:\ZOS111\HERCULES
dasdinit.exe -z -a F:\ZOS111\SBSYS9.CCKD 3390-3 SBSYS9
dir F:\ZOS111\SBSYS9.CCKD
```

Expected evidence:

```text
HHCDU041I 3340 cylinders successfully written
HHCDI001I DASD initialization successfully completed
```

Then in the Hercules console:

```text
attach 0A9D 3390 F:\ZOS111\SBSYS9.CCKD
```

If Hercules reports the device is already defined, use:

```text
devinit 0A9D F:\ZOS111\SBSYS9.CCKD
```

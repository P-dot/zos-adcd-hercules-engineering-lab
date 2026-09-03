# Evidence index

The `evidence/` directory contains the original screenshots embedded in the supplied lab capture document.

Key evidence represented across the set:
- B36PERS normal run and persistent checkpoint
- B36PERS restart from STEP02
- full rerun duplicate-name failure
- B36CLEAN successful delete
- repeated B36CLEAN with NOT FOUND normalized to CC=0
- controlled B36PERS rerun
- B36OUT first persistent publication
- repeated B36OUT duplicate-name failure
- B36IDEM guard with output present -> PROCESS skipped
- B36RESET output deletion
- B36IDEM with output absent -> CHECK CC=4 -> PROCESS CC=0 -> OUTPUT cataloged
- final B36IDEM repeat -> CHECK CC=0 -> PROCESS skipped

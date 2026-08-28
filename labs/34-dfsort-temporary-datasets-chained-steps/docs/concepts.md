# Concepts
`&&name` identifies a temporary JCL dataset for the job.
`DISP=(NEW,PASS)` creates it and passes it to a later step.
The consumer can use `DISP=(OLD,DELETE)` to consume and remove it.
This allows batch steps to exchange intermediate data without retaining a permanent cataloged dataset.

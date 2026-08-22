# RMF Monitor II Baseline

## Method

RMF Monitor II was used because it was operational and provided direct point-in-time measurements without requiring Monitor III.

## SPAG — System Paging Activity

Observed sample:

- `PR=0`
- `UIC=65K`
- available frame count visible around `1.9M`

Interpretation: no paging pressure was demonstrated in the captured instant.

## SRCS — Central Storage / Processor / SRM

Observed sample included:

- CPU utilization around 30%
- `PR=0`
- available central storage present
- SRM queue/activity counters visible

Interpretation: the sample shows real activity but does not demonstrate processor saturation or paging stress.

## SENQ — System Enqueue Contention

RMF returned:

`No data was found to fit your selection criteria.`

Interpretation: no enqueue contention was demonstrated by that sample. This must not be generalized into a claim that contention can never occur.

## ARD — Address Space Resource Data

ARD exposed live resource activity by address space. The evidence includes core z/OS and subsystem address spaces such as:

- MASTER
- WLM
- JES2
- VTAM
- TCPIP
- CICS
- DB2-related tasks
- SDSF
- user activity

## ASRM — Address Space SRM Data

ASRM added the WLM/SRM view and showed the service class assigned to each address space. This is the key bridge between the WLM definition reviewed earlier and real runtime work.

## Engineering interpretation

These observations are a baseline, not a performance certification. A single snapshot cannot establish peak-load behavior, capacity headroom, response-time compliance, or long-term contention.

The lab therefore intentionally stops short of changing WLM.

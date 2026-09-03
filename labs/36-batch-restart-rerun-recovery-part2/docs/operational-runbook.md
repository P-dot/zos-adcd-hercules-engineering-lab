# Operational Runbook — Lab 36 Part 2

## Recovery / restart

Use the persistent checkpoint and start at the required downstream step. Do not run checkpoint cleanup first.

## Full rerun

A full rerun is a different operator decision. Reset stale checkpoint state explicitly before starting from STEP01.

## Publication retry

Do not use the deliberately unsafe B36OUT pattern as a retry strategy. B36IDEM checks whether the persistent effect already exists and only creates it when absent.

## State ownership

- CHKPT = recovery state.
- OUTPUT = persistent publication/effect.
- B36CLEAN = explicit checkpoint lifecycle action.
- B36RESET = controlled test reset of OUTPUT.
- B36IDEM = publication guard.

## Safety rule

Never turn cleanup into an unconditional pre-step for recovery: doing so could destroy the state required to restart safely.

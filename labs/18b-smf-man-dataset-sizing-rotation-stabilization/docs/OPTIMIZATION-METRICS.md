# Optimization Metrics — LAB18B

## Before LAB18B

```text
Laboratorio técnico z/OS personal:       9.1/10
Simulación de entorno empresarial real:  7.2/10
```

## After LAB18B

Recommended updated score:

```text
Laboratorio técnico z/OS personal:       9.2/10
Simulación de entorno empresarial real:  7.4/10
```

## Why it improves

This lab is a real operational optimization because it increases available SMF recording capacity and reduces the chance of repeated `DUMP REQUIRED` and `NO SMF DATA SETS AVAILABLE` conditions.

## Why it does not go higher yet

The lab still lacks:

- automated scheduled SMF dump/offload;
- retention policy for SMF dump output data sets;
- SMF record analysis/reporting;
- IPL-persistent strategy decision for `SMFPRMB8`;
- integration with RACF/audit review;
- monitoring procedure for MAN percentage thresholds.

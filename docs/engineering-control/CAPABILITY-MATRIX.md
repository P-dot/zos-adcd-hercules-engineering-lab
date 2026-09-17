# z/OS Engineering Capability Matrix

## Purpose

This document is the operational capability inventory for the z/OS
Engineering Lab. Architecture V2 defines the engineering model; this
matrix applies it to capabilities actually evidenced in the repository
and turns the portfolio into a planning instrument.

Historical lab paths remain authoritative evidence. New work is selected
from demonstrated capability gaps, not from the next numeric lab
identifier.

## Decision rule

``` text
CURRENT SYSTEM STATE
        |
PORTFOLIO CORRELATION
        |
CAPABILITY MATRIX
        |
CAPABILITY / LIFECYCLE / MATURITY / INTEGRATION GAP
        |
NEXT ENGINEERING LAB
```

**Planning rule:** Domain roadmap + capability gap + lifecycle gap +
maturity gap + integration need -\> next laboratory.

## Classification

Architecture V2 maturity: **M0 Exploratory, M1 Foundational, M2
Operational, M3 Resilient, M4 Automated, M5 Integrated**.

Integration: **I0 Standalone, I1 Cross-component, I2 Cross-repository,
I3 Production-like**.

This matrix adds a separate automation dimension: **A0
Manual/exploratory, A1 documented/manual repeatable, A2 scripted with
JCL/REXX/shell, A3 workflow/API driven, A4 controlled automated
pipeline**.

Maturity is evidence-based. Multiple labs mentioning a technology do not
by themselves promote a capability.

## Capability matrix

  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  Domain          Capability           Existing         Lifecycle      Maturity   Integration   Automation Recovery   Current gap                              Next engineering action
                                       evidence
  --------------- -------------------- ---------------- ------------ ---------- ------------- ------------ ---------- ---------------------------------------- ---------------------------
  Core Platform   System structure /   Labs 01-02       Discover /           M1            I0           A1 No         No formal known-good baseline            Establish Known Good
                  initialization                        Baseline /                                                                                             Configuration
                                                        Configure

  Core Platform   LINKLIST / LPA / APF Labs 09, 15      Discover /           M2            I1           A1 Partial    Stronger before/after controls           Integrate with
                  / system libraries                    Baseline /                                                                                             change-management gate
                                                        Configure

  Core Platform   IPL / PARMLIB /      Labs 14, 26      Baseline /           M3            I1           A1 Yes        Formal baseline comparison missing       Baseline-A -\> change -\>
                  PROCLIB                               Configure /                                                                                            Baseline-B -\> rollback
                                                        Operate /
                                                        Recover

  Core Platform   HCD / IODF baseline  Lab 19 HCD/IODF  Discover /           M1            I1           A1 No         Read-only capability                     Extend only with a safe
                                                        Baseline                                                                                               configuration scenario

  Operations      Task / started-task  Lab 03           Operate              M1            I0           A1 No         Shallow lifecycle                        Controlled
                  operations                                                                                                                                   start/stop/validation
                                                                                                                                                               scenario

  Operations      Health Checker       Lab 11 HZSPROC   Configure /          M2            I1           A1 No         Not yet a universal change gate          Make pre/post-change health
                                                        Observe                                                                                                validation standard

  Operations      Operational health   Lab 12 health    Baseline /           M2            I1           A1 No         Not formalized as known-good state       Build reusable baseline
                  baseline             check            Observe                                                                                                specification

  Operations      Console / SYSLOG /   Labs 13, 20      Operate /            M2            I1           A1 No         No formal incident workflow              Connect to
                  SDSF                                  Observe                                                                                                Incident/Recovery model

  Storage & DFSMS DASD / volume / I/O  Labs 04,         Discover /           M2            I1           A1 Partial    Domain roadmap only recently formalized  Continue domain-native
                  foundations          04-ZVOL, 07      Baseline /                                                                                             Storage work
                                                        Configure /
                                                        Operate

  Storage & DFSMS Catalog / SMS        Labs 10, 15      Discover /           M1            I1           A1 No         Policy lifecycle incomplete              Continue from established
                  foundations                           Baseline                                                                                               baseline

  Storage & DFSMS SMS pool / SG        Labs 16-17       Configure /          M4            I1           A2 Partial    Broader policy/failure coverage          Integrate DC/MC policy
                  engineering                           Operate /
                                                        Automate

  Storage & DFSMS SC/SG ACS routing    Lab 17 + DFSMS   Baseline /           M4            I1           A2 Partial    HFS/zFS and workload-aware routing       Extend after DC/MC gates
                                       gap analysis     Configure /                                                   incomplete
                                                        Automate /
                                                        Validate

  Storage & DFSMS Data Class + ACS     Gap analysis +   Discover /           M2            I1           A1 No         Negative path, activation, real          DCTEST2 -\> coverage -\>
                  positive path        STOR-007         Baseline /                                                    allocation absent                        activation planning
                                                        Configure /
                                                        Validate

  Storage & DFSMS Management Class     STOR-007         Configure            M1            I0           A1 No         No ACSMGMT translation/validation/test   Implement ACSMGMT +
                  policy               foundation       foundation                                                                                             integrated DC/MC tests

  Storage & DFSMS DFSMSrmm             Lab 19 DFSMSrmm  Configure /          M2            I1           A1 No         Lifecycle/recovery depth limited         Build operational lifecycle
                                                        Operate

  Storage & DFSMS HFS/zFS-aware SMS    Gap analysis     Discover             M0            I0           A0 No         Capability absent/incomplete             Design after DC/MC
                  routing                                                                                                                                      validation

  Storage & DFSMS DFSMShsm lifecycle   Gap analysis     Discover             M0            I0           A0 No         Future capability                        Discovery/baseline before
                                                                                                                                                               configuration

  Workload &      JES2 spool / batch   Labs 10-12 JES2  Configure /          M2            I1           A1 Partial    Scheduler/recovery integration           Integrate scheduler +
  Batch           flow / JQE                            Operate /                                                     incomplete                               failure/recovery
                                                        Observe /
                                                        Maintain

  Observability   SMF                  Lab 13 SMF       Discover /           M1            I1           A1 No         Not universal change evidence            Add SMF evidence decision
                  baseline/readiness                    Baseline                                                                                               to change template

  Observability   SMF MAN lifecycle /  Labs 14, 18,     Operate /            M4            I1           A2 Yes        Cross-domain consumption limited         Use SMF as evidence plane
                  extraction / archive 18b, 22          Observe /
                                                        Improve /
                                                        Recover /
                                                        Automate

  Performance &   WLM / RMF baseline   Labs 12 WLM, 27  Discover /           M2            I1           A1 No         Capacity workflow incomplete             Workload -\> RMF -\> WLM
  Capacity                                              Baseline /                                                                                             diagnosis
                                                        Observe

  Performance &   SRM / WLM decision   Lab 39           Observe /          M5\*            I2           A1 No         Domain itself is not independently M5    Continue domain-native
  Capacity        analysis                              Diagnose /                                                                                             performance evidence
                                                        Integrate

  Diagnostics     LOGREC / dump        Labs 06, 38      Observe /            M2            I2           A1 No         IPCS / ABEND / controlled dump analysis  Incident -\> dump -\> IPCS
                  foundations                           Diagnose /                                                    absent                                   workflow
                                                        Integrate

  Sysplex &       XCF / GRS / Logger   Labs 05, 28      Discover /           M1            I1           A1 No         Operational/recovery lifecycle shallow   Add safe operational
  Availability                                          Baseline                                                                                               scenarios

  Recovery        ADRDSSU backup /     Labs 09          Operate /            M3            I1           A1 Yes        Cross-domain recovery limited            Integrate into
                  restore              backup/restore   Recover /                                                                                              production-like recovery
                                                        Validate                                                                                               track

  Security        Privileged authority Labs 23-24       Baseline /           M2            I1           A1 No         Security not yet mandatory in change     Add
                  / governance                          Observe /                                                     plane                                    authorization/publication
                                                        Diagnose /                                                                                             gates
                                                        Improve

  USS             OMVS / zFS           Lab 08 + USS     Discover /           M1            I1           A1 No         New work belongs in specialized domain   Integrate USS + RACF +
                  foundations          repository       Baseline                                                                                               TCP/IP + storage

  Software        SMP/E CSI / SYSMOD   Lab 29           Discover /           M1            I0           A1 No         RECEIVE/APPLY/ACCEPT/HOLDDATA/recovery   Build deliberate SMP/E
  Maintenance     inventory                             Baseline                                                      absent                                   capability sequence

  Integration     CICS-Db2 DB2CONN     Lab 05 DB2CONN   Integrate          M5\*            I2           A1 No         Security/observability/recovery          Use in Online Transaction
                                                                                                                      integration                              track

  Integration     Enterprise Batch     Labs 30-39       Baseline /         M5\*    I3 partial           A2 Yes        Scheduler/RACF/data services/gates not   Continue toward end-to-end
                  Operations                            Operate /                                                     fully fused                              production cycle
                                                        Observe /
                                                        Diagnose /
                                                        Recover /
                                                        Improve /
                                                        Integrate
  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**M5 note:** historical M5 values describe the integration role of those
labs. They do not prove that the underlying engineering domain is
independently mature at M5.

## Storage checkpoint

Storage is currently the clearest implementation of the new operating
model:

``` text
Historical DFSMS evidence
  -> Lab 15 SMS baseline
  -> Lab 16 SMS pool
  -> Lab 17 SC/SG ACS + real allocation
  -> DFSMS capability-gap analysis
  -> STOR-007 Data Class / Management Class foundation
  -> pre-activation checkpoint
```

STOR-007 proves Data Class ACS translation (`RC 0000`), validation, and
the positive test (`DC=SMSDATA`, ACS testing `RC 00`). It deliberately
does **not** prove SCDS activation, real allocation through the new Data
Class, the negative path, Management Class ACS, or integrated DC/MC
operation.

The next Storage work must continue from this checkpoint rather than
recreate already-proven constructs.

## Mandatory questions before a future lab

1.  Which engineering domain owns the capability?
2.  What exact capability is missing or incomplete?
3.  What existing lab/repository is upstream evidence?
4.  Which lifecycle stage is missing?
5.  What maturity increase is being attempted?
6.  What integration level is intended?
7.  What is the known-good state before the change?
8.  What proves success?
9.  Which Health Checker, SYSLOG, SDSF, SMF, RMF, LOGREC or subsystem
    evidence is relevant?
10. What can fail?
11. What is the rollback/recovery path?
12. Which configuration artifacts must be versioned?
13. What publication-security review is required?
14. What capability becomes possible afterwards?

If these questions cannot be answered, the work is not ready to become a
new engineering lab.

## Machine-readable direction

`lab.json` is the foundation for future machine-readable governance.
Future domain-native labs should progressively declare domain,
capability, lifecycle stages, maturity before/after, integration level,
automation level, upstream evidence, health checks, observability,
recovery state, configuration versioning and publication-check status.

This is a target for new work, not a retroactive requirement to rewrite
every historical lab.

## Update policy

Update this matrix when a capability is discovered, baselined,
configured, validated, recovered, automated or integrated; when a gap is
closed or discovered; or when Architecture V2 changes a domain boundary.

Never promote maturity, integration or automation without evidence.

## Architecture relationship

Architecture V2 remains authoritative for domains, taxonomy, migration,
maturity, production tracks and repository evolution. This matrix is the
**operational control surface** used to decide what engineering work
happens next.

## Next control-plane artifact

After acceptance of this matrix, build the **Known Good Configuration
Baseline** covering, where applicable, IPL/PARMLIB/PROCLIB,
APF/LINKLIST/LPA, JES2, SMF, WLM, SMS/DFSMS, USS, TCP/IP, RACF, XCF/GRS
and Health Checker.

``` text
KNOWN GOOD BASELINE
  -> CHANGE REQUEST
  -> PRE-CHANGE HEALTH / OBSERVABILITY
  -> CONTROLLED CHANGE
  -> FUNCTIONAL VALIDATION
  -> POST-CHANGE HEALTH / OBSERVABILITY
       -> PASS: update capability state
       -> FAIL: rollback / recovery / incident
```

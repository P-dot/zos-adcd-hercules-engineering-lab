# Recommendations

1. Do not remove IBMUSER authority without dependency and recovery planning.
2. Review segregation of SPECIAL and OPERATIONS administrative functions.
3. Treat START1 as a technical service identity; do not handle it as a normal user.
4. Inventory all STARTED profiles using START1 before any least-privilege change.
5. Validate DB2 service-ID OPERATIONS requirements with subsystem dependencies.
6. Review whether SYSOPR requires SPECIAL for its intended role.
7. Perform all remediation in a separate controlled lab with:
   - before evidence
   - rollback
   - explicit validation
   - after evidence

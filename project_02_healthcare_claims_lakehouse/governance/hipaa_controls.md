# HIPAA Controls & Security Design — Project 02

## PHI/PII Handling
- Member name and DOB are treated as **PHI/PII**.
- SSN is **never stored in cleartext** (only masked format in this demo).

## Controls Implemented (Design-Level)
1. **Tokenization**: `member_token` is used for analytics joins instead of direct identifiers.
2. **Masking**:
   - Static masking in curated: keep `ssn_masked`
   - Dynamic masking in warehouse: mask member name for non-privileged roles
3. **RBAC** (concept):
   - `role_analytics`: access curated/analytics with masked PII
   - `role_compliance`: access curated with full identifiers
4. **Auditability**:
   - Log all reads of curated tables with PII fields
   - Track dataset lineage from raw → curated → marts

## Retention Policy (Example)
- Raw zone: 7 years (immutable for legal/audit)
- Curated: 3 years (analytics + ops)
- Analytics marts: 2 years (aggregated metrics)

## Incident Response Notes
- Any anomalous read patterns trigger an alert (e.g., mass export of member-level data).

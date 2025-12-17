# MDM Policies — Project 04

## Matching Policy (Deterministic)
- **Email Exact Match**: confidence 0.98
- **Phone + Last Name**: confidence 0.92
- Conflicts or low-confidence matches are routed to stewardship for review.

## Survivorship Policy
- Names: prefer CRM (authoritative for identity), else most recently updated
- Contact/Address: most recent non-null value across all sources
- Always maintain:
  - Golden record timestamps (created/last_updated)
  - XREF source linkage for audit and traceability

## Stewardship Workflow (Practical)
1. DQ flags duplicates not matched (potential false negatives)
2. Steward reviews exception queue
3. Steward confirms merge or splits group
4. Changes are logged with who/when/why

## Auditability
- Keep `xref_golden_to_source` mapping
- Keep history snapshots (`golden_customers_history_snapshot.csv`)

# Data Quality Rules — Project 04

1. Email normalization: lowercase + trim
2. Phone normalization: 10-digit canonical
3. Golden record completeness targets:
   - email, phone, state must be present
4. No orphan xref:
   - every xref.source_customer_id must exist in staging
5. Stewardship exceptions:
   - ambiguous matches (multiple possible groups)
   - conflicting identifiers (same email with different names)

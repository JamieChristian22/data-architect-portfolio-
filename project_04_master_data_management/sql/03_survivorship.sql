-- Survivorship rules (example)
-- Choose "best" attribute values when multiple sources exist.

-- Strategy used in this portfolio:
-- - Prefer most recent non-null for email/phone/address fields
-- - Prefer CRM for names (or most recent if CRM not present)
-- - Write XREF mapping for lineage

-- Implementation varies by platform (can be done with window functions and QUALIFY).

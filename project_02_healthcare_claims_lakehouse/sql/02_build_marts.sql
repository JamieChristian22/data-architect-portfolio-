-- Build marts from curated claims header (example)

INSERT INTO mart_member_month_claim_cost (member_id, service_month, status, claim_type, claims, billed, allowed, paid)
SELECT
  member_id,
  TO_CHAR(service_date, 'YYYY-MM') AS service_month,
  status,
  claim_type,
  COUNT(*) AS claims,
  SUM(billed_amount) AS billed,
  SUM(allowed_amount) AS allowed,
  SUM(paid_amount) AS paid
FROM curated_claims_header
GROUP BY 1,2,3,4;

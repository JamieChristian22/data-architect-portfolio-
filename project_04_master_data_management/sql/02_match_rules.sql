-- Deterministic match rules (example)

-- Rule 1: exact email
CREATE TABLE IF NOT EXISTS match_email_exact AS
SELECT
  email_norm,
  COUNT(*) AS records
FROM stg_customers_standardized
GROUP BY 1
HAVING COUNT(*) >= 2;

-- Rule 2: phone + last name
CREATE TABLE IF NOT EXISTS match_phone_lastname AS
SELECT
  phone_norm,
  last_name,
  COUNT(*) AS records
FROM stg_customers_standardized
GROUP BY 1,2
HAVING COUNT(*) >= 2;

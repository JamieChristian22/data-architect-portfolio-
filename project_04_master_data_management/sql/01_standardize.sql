-- Project 04: Standardization step (example)

CREATE TABLE IF NOT EXISTS stg_customers_standardized AS
SELECT
  source_customer_id,
  source_system,
  first_name,
  last_name,
  LOWER(TRIM(email)) AS email_norm,
  REGEXP_REPLACE(phone, '[^0-9]', '') AS phone_norm,
  LOWER(TRIM(first_name)) || ' ' || LOWER(TRIM(last_name)) AS name_norm,
  LOWER(REPLACE(TRIM(address), 'street', 'st')) AS addr_norm,
  city, state, zip,
  updated_date
FROM raw_customers_all_sources;

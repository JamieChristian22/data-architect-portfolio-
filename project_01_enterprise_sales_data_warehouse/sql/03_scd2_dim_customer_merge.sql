-- SCD2 merge pattern (warehouse-agnostic pseudocode)
-- Tracked attributes: region, segment

-- Expire current record when change arrives
UPDATE dim_customer dc
SET valid_to = DATEADD(day, -1, ch.effective_date),
    is_current = 0
FROM stg_customer_changes ch
WHERE dc.customer_id = ch.customer_id
  AND dc.is_current = 1
  AND (dc.region <> ch.new_region OR dc.segment <> ch.new_segment);

-- Insert new current record
INSERT INTO dim_customer (customer_sk, customer_id, customer_name, email, region, segment, created_date, valid_from, valid_to, is_current)
SELECT
  /* generate new surrogate key */ ,
  c.customer_id,
  c.customer_name,
  c.email,
  ch.new_region,
  ch.new_segment,
  c.created_date,
  ch.effective_date,
  DATE '9999-12-31',
  1
FROM stg_customer_changes ch
JOIN stg_customers c ON c.customer_id = ch.customer_id;

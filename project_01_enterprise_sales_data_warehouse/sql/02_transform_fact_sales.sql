-- Build FACT from staging (pattern)
-- stg_sales: sale_id, customer_id, product_id, date_id, quantity, unit_price, discount_rate, revenue, channel

INSERT INTO fact_sales (sale_id, customer_sk, product_sk, date_id, channel, quantity, unit_price, discount_rate, revenue)
SELECT
  s.sale_id,
  c.customer_sk,
  p.product_sk,
  s.date_id,
  s.channel,
  s.quantity,
  s.unit_price,
  s.discount_rate,
  s.revenue
FROM stg_sales s
JOIN dim_product p ON p.product_id = s.product_id
JOIN dim_customer c
  ON c.customer_id = s.customer_id
 AND TO_DATE(CAST(s.date_id AS VARCHAR), 'YYYYMMDD') BETWEEN c.valid_from AND c.valid_to;

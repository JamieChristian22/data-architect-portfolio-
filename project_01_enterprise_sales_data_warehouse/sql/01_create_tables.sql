-- Project 01: Enterprise Sales Analytics Data Warehouse (Star Schema)
-- Compatible SQL (adjust DATEADD/TO_DATE syntax per your warehouse)

CREATE TABLE IF NOT EXISTS dim_date (
  date_id      INTEGER PRIMARY KEY,
  date         DATE NOT NULL,
  year         INTEGER NOT NULL,
  quarter      INTEGER NOT NULL,
  month        INTEGER NOT NULL,
  day          INTEGER NOT NULL,
  day_of_week  INTEGER NOT NULL,
  is_weekend   INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS dim_product (
  product_sk     INTEGER PRIMARY KEY,
  product_id     INTEGER NOT NULL,
  product_name   VARCHAR(200) NOT NULL,
  category       VARCHAR(80) NOT NULL,
  list_price     NUMERIC(12,2) NOT NULL,
  billing_cycle  VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS dim_customer (
  customer_sk   INTEGER PRIMARY KEY,
  customer_id   INTEGER NOT NULL,
  customer_name VARCHAR(200) NOT NULL,
  email         VARCHAR(200) NOT NULL,
  region        VARCHAR(80) NOT NULL,
  segment       VARCHAR(40) NOT NULL,
  created_date  DATE NOT NULL,
  valid_from    DATE NOT NULL,
  valid_to      DATE NOT NULL,
  is_current    INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS fact_sales (
  sale_id       INTEGER PRIMARY KEY,
  customer_sk   INTEGER NOT NULL,
  product_sk    INTEGER NOT NULL,
  date_id       INTEGER NOT NULL,
  channel       VARCHAR(40) NOT NULL,
  quantity      INTEGER NOT NULL,
  unit_price    NUMERIC(12,2) NOT NULL,
  discount_rate NUMERIC(5,2) NOT NULL,
  revenue       NUMERIC(14,2) NOT NULL
);

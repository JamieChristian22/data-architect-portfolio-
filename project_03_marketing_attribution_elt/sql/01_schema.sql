-- Project 03: Marketing Attribution (Warehouse schema)

CREATE TABLE IF NOT EXISTS dim_campaign (
  campaign_id INTEGER,
  campaign_name VARCHAR(200),
  channel VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS fact_sessions (
  session_id INTEGER,
  user_id VARCHAR(50),
  session_start_ts TIMESTAMP,
  channel VARCHAR(50),
  campaign_id INTEGER,
  landing_page VARCHAR(100),
  device VARCHAR(20),
  session_month VARCHAR(7)
);

CREATE TABLE IF NOT EXISTS fact_conversions (
  conversion_id INTEGER,
  user_id VARCHAR(50),
  conversion_ts TIMESTAMP,
  revenue NUMERIC(14,2),
  conversion_type VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS mart_attribution_last_touch (
  conversion_id INTEGER,
  user_id VARCHAR(50),
  conversion_ts TIMESTAMP,
  revenue NUMERIC(14,2),
  attributed_channel VARCHAR(50),
  attributed_campaign_id INTEGER,
  model VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS mart_marketing_roi (
  month VARCHAR(7),
  channel VARCHAR(50),
  spend NUMERIC(18,2),
  impressions BIGINT,
  clicks BIGINT,
  attributed_revenue NUMERIC(18,2),
  conversions BIGINT,
  roi NUMERIC(18,6)
);

-- Last-touch attribution (30-day lookback) — illustrative SQL pattern

SELECT
  c.conversion_id,
  c.user_id,
  c.conversion_ts,
  c.revenue,
  COALESCE(s.channel, 'Unattributed') AS attributed_channel,
  s.campaign_id AS attributed_campaign_id,
  'last_touch_30d' AS model
FROM fact_conversions c
LEFT JOIN fact_sessions s
  ON s.user_id = c.user_id
 AND s.session_start_ts <= c.conversion_ts
 AND s.session_start_ts >= DATEADD(day, -30, c.conversion_ts)
QUALIFY ROW_NUMBER() OVER (PARTITION BY c.conversion_id ORDER BY s.session_start_ts DESC) = 1;

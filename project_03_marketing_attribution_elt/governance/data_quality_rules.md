# Data Quality Rules — Project 03

## Core Checks
1. Required fields not null:
   - sessions.user_id, sessions.session_start_ts, sessions.channel
   - conversions.user_id, conversions.conversion_ts, conversions.revenue
2. Revenue non-negative; flag outliers for investigation
3. campaign_id present only for paid channels; null acceptable for Organic/Direct
4. Attribution constraints:
   - last-touch uses a 30-day lookback
   - if no eligible session, mark as 'Unattributed'

## Reconciliation
- Total spend by month/channel reconciles to raw exports.
- Total attributed revenue by month should not exceed total conversion revenue (by model).

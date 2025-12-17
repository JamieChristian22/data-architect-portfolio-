# Project 03 — Marketing Attribution ELT (Exports/APIs → Warehouse)

## Outcome
A production-style ELT pipeline producing **attribution** and **ROI** marts for marketing leadership.

## Architecture
- `architecture/marketing_elt_architecture.png`

## Data
- Raw exports: `data/raw/`
- Warehouse outputs: `data/warehouse/`

## Built Tables
- `dim_campaign`
- `fact_sessions`
- `fact_conversions`
- `mart_attribution_last_touch` (30-day lookback)
- `mart_marketing_roi`

## Evidence
- `analytics/roi_by_channel.png`
- `analytics/monthly_attributed_revenue.png`

## How to Run (Local)
```bash
python scripts/extract_exports.py
python scripts/transform_attribution.py
```

## Example Questions Answered
- Which channels and campaigns drive the best ROI?
- How does attributed revenue trend month-to-month?
- Where are conversions going unattributed (tracking gaps)?

## What This Demonstrates
- Marketing ELT architecture
- Identity stitching & attribution logic
- Metric definitions + reconciliation and DQ

## Streaming / Kafka Add-on (Optional)

This project supports real-time ingestion for clickstream + conversions:

- Producers: `streaming_kafka/producer_clickstream.py`, `streaming_kafka/producer_conversions.py`
- Topics: `clickstream.events`, `marketing.conversions`
- Landing (Bronze): Postgres via Kafka Connect (see `/streaming_kafka_layer`)
- DLQ: `dlq.marketing`

See: `streaming_kafka/README.md` for exact steps.

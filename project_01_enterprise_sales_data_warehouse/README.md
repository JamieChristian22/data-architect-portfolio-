# Project 01 — Enterprise Sales Analytics Data Warehouse (Star Schema)

## Outcome
A **BI-ready warehouse** that supports consistent revenue reporting and **historical correctness** when customer attributes change (SCD Type 2).

## What’s Included
- Architecture diagrams: `architecture/`
- Sample datasets (raw → staging → warehouse): `data/`
- DDL + transformation SQL: `sql/`
- Governance + data dictionary + DQ results: `governance/`
- Example dashboard output: `dashboards/`

## Core Data Model
- `fact_sales` (grain: 1 row per sale transaction)
- `dim_customer` (SCD2, tracked: region/segment)
- `dim_product`
- `dim_date`

See `architecture/star_schema_overview.png`.

## Running the Demo (Warehouse-Agnostic)
1. Create tables using `sql/01_create_tables.sql`
2. Load `data/warehouse/*.csv` into the corresponding tables
3. Run validations in `governance/governance_rules.md`

## Example Business Questions Answered
- Monthly revenue by region and channel
- Product revenue contribution and discount impact
- Segment performance (SMB vs Enterprise)
- Historical revenue under the customer’s attributes at time-of-sale

## Evidence
- `dashboards/monthly_revenue_by_region.png`

## Streaming / Kafka Add-on (Optional)

This project includes a streaming add-on that simulates **real-time order ingestion**:

- Producer: `streaming_kafka/producer_orders.py`
- Topic: `sales.orders`
- Landing (Bronze): Postgres via Kafka Connect (see `/streaming_kafka_layer`)

See: `streaming_kafka/README.md` for exact steps.

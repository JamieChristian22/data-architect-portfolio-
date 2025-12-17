# Data Architect Portfolio — 4 Real-World Projects

This portfolio contains **four end-to-end, production-style Data Architecture projects** with complete artifacts:  
architecture diagrams, raw/staging/curated datasets, DDL/DML SQL, Python ETL scripts, data quality checks, governance docs, and example analytics outputs.

## Projects
1. **01 — Enterprise Sales Analytics Data Warehouse (Star Schema)**  
   Build a revenue reporting warehouse with SCD2 customer dimension, conformed dimensions, and curated BI-ready fact tables.
2. **02 — Healthcare Claims Data Lakehouse (Raw → Curated → Analytics)**  
   Design a HIPAA-aware lakehouse with masking, retention, auditability, and claim-cost analytics.
3. **03 — Marketing Attribution ELT Pipeline (APIs/Exports → Warehouse)**  
   Normalize multi-channel marketing data, stitch sessions to conversions, and compute attribution + ROI metrics.
4. **04 — Master Data Management (MDM) Golden Record**  
   Match/merge duplicate customer records, survivorship rules, stewardship workflow, and history tracking.

## How to Use
Each project folder has:
- `README.md` (business problem, assumptions, architecture, schema, how to run)
- `architecture/` (diagrams)
- `data/` or `data_zones/` (raw + processed sample data)
- `sql/` (DDL + transformations)
- `scripts/` (Python ETL for projects that use it)
- `governance/` (policies, rules, data dictionary, controls)
- `analytics/` or `dashboards/` (example outputs)

> Tip: You can run the SQL in any modern warehouse (BigQuery/Snowflake/Redshift/Postgres).  
> Python scripts run locally with `pandas` + `numpy` + `matplotlib`.

## Skills Demonstrated
- Data modeling (Star schema, SCD2, lakehouse layers, MDM)
- Data pipelines (batch ELT/ETL), automation patterns, idempotent loads
- Data quality checks + exception handling
- Security & governance (masking, RBAC concepts, retention, audit)
- Business-first metrics design (revenue, claims cost, marketing ROI, customer golden record)

## License
MIT License (portfolio/demo use).

## Streaming / Kafka Layer (Real-Time Ingestion)

This portfolio includes a **Kafka-based streaming layer** (local dev) to demonstrate real-time ingestion patterns.

- Start the stack: `streaming_kafka_layer/docker-compose.yml`
- Runbook: `streaming_kafka_layer/RUNBOOK.md`
- Streaming-enabled projects:
  - Project 01 (Orders stream) → `project_01_enterprise_sales_data_warehouse/streaming_kafka/`
  - Project 03 (Clickstream + Conversions) → `project_03_marketing_attribution_elt/streaming_kafka/`

This raises technical coverage to **batch + streaming**, including topic design, DLQs, connector-based landing, and idempotent writes.

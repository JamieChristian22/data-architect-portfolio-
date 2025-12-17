# Streaming Add-on (Kafka) — Orders → Warehouse

This add-on simulates **real-time order ingestion** to complement batch loads.

## Topics
- `sales.orders` (6 partitions) — order events
- `dlq.sales` — dead-letter queue

Partitioning:
- Partition by `customer_id` to keep per-customer ordering (useful for customer-level metrics)

## Local run
1) Start shared stack:

```bash
cd ../streaming_kafka_layer
docker compose up -d
bash scripts/create_topics.sh
bash scripts/register_connectors.sh
```

2) Produce orders:

```bash
cd ../project_01_enterprise_sales_data_warehouse/streaming_kafka
pip install -r requirements.txt
python producer_orders.py
```

3) Bronze landing
The connector writes to Postgres table `bronze_sales_orders`.
From there, the warehouse layer can transform into `fact_sales` and SCD dims.

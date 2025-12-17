# Streaming Add-on (Kafka)

This project supports **real-time ingestion** using Kafka to complement batch exports.

## Topics

- `clickstream.events` (6 partitions): page views and funnel events  
- `marketing.conversions` (3 partitions): conversions (purchase/signup)  
- `dlq.marketing` (1 partition): dead-letter queue for sink failures

Partitioning strategy:
- Clickstream is partitioned by `user_id` (consumer can preserve user ordering)
- Conversions are partitioned by `user_id` (attribution join friendliness)

## Run (Local)

1) Start the shared stack:

```bash
cd ../streaming_kafka_layer
docker compose up -d
bash scripts/create_topics.sh
bash scripts/register_connectors.sh
```

2) Produce events:

```bash
cd ../project_03_marketing_attribution_elt/streaming_kafka
pip install -r requirements.txt
python producer_clickstream.py
python producer_conversions.py
```

3) Verify Bronze landing:
- Kafka UI: http://localhost:8080
- Postgres: tables `bronze_clickstream_events`, `bronze_marketing_conversions` (if you add a second connector)

## Delivery semantics & idempotency

- Producers use `acks=all` and retries → **at-least-once** delivery
- Sink uses JDBC upsert keyed by `event_id` / `conversion_id` → **idempotent writes**
- Connector routes failures to `dlq.marketing`

## Data contracts

Authoritative schemas live in `/streaming_kafka_layer/schemas/`.
This simulates schema registry-backed contracts used in production.

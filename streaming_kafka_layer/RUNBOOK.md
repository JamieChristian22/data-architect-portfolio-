# Streaming / Kafka Layer (Local Dev)

This folder provides a **production-pattern** streaming layer you can run locally:
- Kafka (KRaft)
- Schema Registry (JSON Schema)
- Kafka Connect (JDBC sink)
- Postgres (Bronze landing store)
- Kafka UI (topic inspection, consumer lag, connectors)

## 1) Start the stack

```bash
cd streaming_kafka_layer
docker compose up -d
```

Open:
- Kafka UI: http://localhost:8080
- Schema Registry: http://localhost:8081
- Connect REST: http://localhost:8083

## 2) Create topics (explicit, no auto-create)

```bash
bash scripts/create_topics.sh
```

## 3) Produce events (example producers)

Each project that uses streaming includes a `streaming_kafka/` folder with a producer/consumer.
Run the project's producer and verify messages appear in Kafka UI.

## 4) Land events into Bronze (Postgres via Kafka Connect)

```bash
bash scripts/register_connectors.sh
```

Tables will appear in Postgres:
- `bronze_clickstream_events`
- `bronze_orders_events`
- (and any other configured sinks)

## 5) How this improves your portfolio

This adds **real-time ingestion** and enterprise concerns:
- Topic design + partitions
- Event schemas + versioning
- DLQ strategy
- Delivery semantics (at-least-once, idempotency)
- Observability (lag + connector status)

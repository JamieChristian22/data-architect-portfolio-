# Streaming Design Decisions (Kafka)

## Why Kafka here?
- Decouples producers from consumers
- Supports bursty traffic and backpressure
- Enables multiple downstream consumers (BI, fraud, ops, ML)

## Delivery semantics
- **At-least-once** producers + retries
- **Idempotent** landing via upsert (primary key in record value)
- DLQ captures non-conforming records without blocking the pipeline

## Topic design
- Domain-based naming: `sales.orders`, `clickstream.events`
- Partitions sized for parallelism and expected growth:
  - clickstream: 6 partitions (high volume)
  - orders: 6 partitions (moderate volume)
  - DLQ: 1 partition (low volume)

## Security notes (how you'd harden in prod)
- TLS encryption for broker + clients
- SASL authentication (SCRAM/OAUTH)
- ACLs: least privilege per topic and consumer group
- PII/PHI: tokenize or hash before emitting (example: `ip_hash`)

## Data contracts
Schemas are stored in `schemas/` and can be registered with Schema Registry.
Breaking changes require a new major version and consumer compatibility review.

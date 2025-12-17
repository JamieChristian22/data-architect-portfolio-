#!/usr/bin/env python3
"""Produce order events to Kafka to simulate real-time order capture.

Use case:
- Transactional system emits `sales.orders`
- Kafka Connect lands to Bronze Postgres
- Warehouse ELT consumes Bronze to update `fact_sales` and dimensions

Topic: `sales.orders`
Key fields for idempotency: `order_id`
"""

from __future__ import annotations

import json
import os
import random
import uuid
from datetime import datetime, timezone

from kafka import KafkaProducer

BOOTSTRAP = os.getenv("KAFKA_BOOTSTRAP", "localhost:9092")
TOPIC = os.getenv("KAFKA_TOPIC", "sales.orders")

REGIONS = ["NA", "EMEA", "APAC", "LATAM"]
CURRENCIES = {"NA": "USD", "EMEA": "EUR", "APAC": "JPY", "LATAM": "BRL"}
SKUS = ["WIDGET-A", "WIDGET-B", "WIDGET-C", "ADDON-PRO", "ADDON-TEAM"]

def now_iso() -> str:
    return datetime.now(timezone.utc).isoformat()

def make_order() -> dict:
    region = random.choice(REGIONS)
    currency = CURRENCIES[region]
    customer_id = f"C{random.randint(1000, 9999)}"
    order_id = f"ORD-{uuid.uuid4().hex[:12].upper()}"

    items = []
    for _ in range(random.randint(1, 4)):
        sku = random.choice(SKUS)
        qty = random.randint(1, 3)
        unit = round(random.random() * 120 + 10, 2)
        items.append({"sku": sku, "qty": qty, "unit_price": unit})

    total = round(sum(i["qty"] * i["unit_price"] for i in items), 2)

    return {
        "order_id": order_id,
        "order_ts": now_iso(),
        "customer_id": customer_id,
        "region": region,
        "currency": currency,
        "items": items,
        "order_total": total,
        "source_system": "web_checkout",
        "event_version": 1,
    }

def main() -> None:
    producer = KafkaProducer(
        bootstrap_servers=[BOOTSTRAP],
        value_serializer=lambda v: json.dumps(v).encode("utf-8"),
        acks="all",
        retries=5,
        linger_ms=50,
    )

    for _ in range(500):
        producer.send(TOPIC, value=make_order())

    producer.flush()
    print(f"Produced orders to {TOPIC} @ {BOOTSTRAP}")

if __name__ == "__main__":
    random.seed(21)
    main()

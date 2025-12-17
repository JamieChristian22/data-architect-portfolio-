#!/usr/bin/env python3
"""Produce conversion events to Kafka for attribution modeling."""

from __future__ import annotations

import json
import os
import random
import uuid
from datetime import datetime, timezone

from kafka import KafkaProducer

BOOTSTRAP = os.getenv("KAFKA_BOOTSTRAP", "localhost:9092")
TOPIC = os.getenv("KAFKA_TOPIC", "marketing.conversions")

def now_iso() -> str:
    return datetime.now(timezone.utc).isoformat()

def main() -> None:
    producer = KafkaProducer(
        bootstrap_servers=[BOOTSTRAP],
        value_serializer=lambda v: json.dumps(v).encode("utf-8"),
        acks="all",
        retries=5,
    )

    for _ in range(300):
        user_id = f"U{random.randint(1, 199):05d}"
        event = {
            "conversion_id": str(uuid.uuid4()),
            "conversion_ts": now_iso(),
            "user_id": user_id,
            "conversion_type": random.choice(["purchase", "signup"]),
            "revenue": round(random.random() * 199 + 10, 2),
            "currency": "USD",
            "order_id": f"O{random.randint(100000, 999999)}",
        }
        producer.send(TOPIC, value=event)

    producer.flush()
    print(f"Produced conversions to {TOPIC} @ {BOOTSTRAP}")

if __name__ == "__main__":
    random.seed(7)
    main()

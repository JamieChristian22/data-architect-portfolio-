#!/usr/bin/env python3
"""Produce realistic clickstream + conversion events to Kafka.

This script generates events you can trace end-to-end:
Kafka topic -> Bronze (Postgres via Connect) -> ELT transforms -> attribution tables.

Local defaults assume the streaming stack is running (see /streaming_kafka_layer/RUNBOOK.md).
"""

from __future__ import annotations

import json
import os
import random
import uuid
from datetime import datetime, timezone, timedelta

from kafka import KafkaProducer

BOOTSTRAP = os.getenv("KAFKA_BOOTSTRAP", "localhost:9092")
TOPIC = os.getenv("KAFKA_TOPIC", "clickstream.events")

SALT = "portfolio_salt_v1"  # used only to produce deterministic demo hashes

def sha256_hex(s: str) -> str:
    import hashlib
    return hashlib.sha256(s.encode("utf-8")).hexdigest()

def now_iso() -> str:
    return datetime.now(timezone.utc).isoformat()

EVENT_TYPES = ["page_view", "add_to_cart", "begin_checkout", "purchase", "signup"]
PAGES = [
    "https://shop.example.com/",
    "https://shop.example.com/pricing",
    "https://shop.example.com/products/widget-a",
    "https://shop.example.com/products/widget-b",
    "https://shop.example.com/checkout",
]

UTM_SOURCES = ["google", "meta", "linkedin", "newsletter", "direct"]
UTM_MEDIA = ["cpc", "paid_social", "email", "organic"]
UTM_CAMPAIGNS = ["brand", "retargeting", "launch_q4", "promo_weekend", "partner"]

def make_event(user_id: str, session_id: str) -> dict:
    event_type = random.choices(EVENT_TYPES, weights=[70, 12, 8, 6, 4], k=1)[0]
    page = random.choice(PAGES)

    ip = f"192.168.{random.randint(0,255)}.{random.randint(1,254)}"
    ip_hash = sha256_hex(ip + SALT)

    utm = {
        "source": random.choice(UTM_SOURCES),
        "medium": random.choice(UTM_MEDIA),
        "campaign": random.choice(UTM_CAMPAIGNS),
        "content": random.choice(["", "video", "static", "carousel"]),
        "term": random.choice(["", "data architect", "warehouse", "etl", "lakehouse"]),
    }

    return {
        "event_id": str(uuid.uuid4()),
        "event_ts": now_iso(),
        "user_id": user_id,
        "session_id": session_id,
        "event_type": event_type,
        "page_url": page,
        "referrer": random.choice(["", "https://google.com", "https://facebook.com", "https://linkedin.com"]),
        "user_agent": random.choice(["Mozilla/5.0", "Safari/605.1.15", "Chrome/124.0"]),
        "ip_hash": ip_hash,
        "utm": utm,
    }

def main() -> None:
    producer = KafkaProducer(
        bootstrap_servers=[BOOTSTRAP],
        value_serializer=lambda v: json.dumps(v).encode("utf-8"),
        linger_ms=50,
        acks="all",
        retries=5,
    )

    users = [f"U{n:05d}" for n in range(1, 200)]
    for _ in range(2000):
        user_id = random.choice(users)
        session_id = f"S{random.randint(100000, 999999)}"
        # emit a small burst per session
        for _ in range(random.randint(2, 12)):
            event = make_event(user_id, session_id)
            producer.send(TOPIC, value=event)
    producer.flush()
    print(f"Produced events to {TOPIC} @ {BOOTSTRAP}")

if __name__ == "__main__":
    random.seed(42)
    main()

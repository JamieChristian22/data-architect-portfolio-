#!/usr/bin/env bash
set -euo pipefail

BOOTSTRAP="localhost:9092"

# Marketing
docker exec -it kafka kafka-topics --bootstrap-server kafka:29092 --create --topic clickstream.events --partitions 6 --replication-factor 1
docker exec -it kafka kafka-topics --bootstrap-server kafka:29092 --create --topic marketing.conversions --partitions 3 --replication-factor 1
docker exec -it kafka kafka-topics --bootstrap-server kafka:29092 --create --topic dlq.marketing --partitions 1 --replication-factor 1

# Sales Orders
docker exec -it kafka kafka-topics --bootstrap-server kafka:29092 --create --topic sales.orders --partitions 6 --replication-factor 1
docker exec -it kafka kafka-topics --bootstrap-server kafka:29092 --create --topic dlq.sales --partitions 1 --replication-factor 1

echo "Topics created."

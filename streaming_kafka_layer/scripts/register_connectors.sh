#!/usr/bin/env bash
set -euo pipefail

CONNECT_URL="http://localhost:8083"

curl -sS -X PUT "${CONNECT_URL}/connectors/jdbc-sink-clickstream/config"   -H "Content-Type: application/json"   --data @connectors/jdbc_sink_clickstream.json | jq .

curl -sS -X PUT "${CONNECT_URL}/connectors/jdbc-sink-sales-orders/config"   -H "Content-Type: application/json"   --data @connectors/jdbc_sink_sales_orders.json | jq .

curl -sS -X PUT "${CONNECT_URL}/connectors/jdbc-sink-conversions/config" \
  -H "Content-Type: application/json" \
  --data @connectors/jdbc_sink_conversions.json | jq .

echo "Connectors registered. Check Kafka UI → Connect."

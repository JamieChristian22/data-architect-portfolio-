.PHONY: up down topics connectors status

up:
	docker compose up -d

down:
	docker compose down -v

topics:
	bash scripts/create_topics.sh

connectors:
	bash scripts/register_connectors.sh

status:
	@echo "Kafka UI: http://localhost:8080"
	@echo "Schema Registry: http://localhost:8081"
	@echo "Connect REST: http://localhost:8083"

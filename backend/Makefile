include include.mk

.PHONY: compose-up
compose-up: 
	docker-compose up

.PHONY: compose-up-db
compose-up-db: 
	docker-compose up strapiDB -d
	
.PHONY: compose-down
compose-down: 
	docker-compose down
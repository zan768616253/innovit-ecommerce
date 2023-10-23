include include.mk

.PHONY: compose-up
compose-up: 
	docker-compose up
	
.PHONY: compose-down
compose-down: 
	docker-compose down
DOCKERFILES_DIR = srcs/requirements
DOCKER_COMPOSE_FILE=srcs/docker-compose.yml

.PHONY: all
all: build up

.PHONY: build
build: build_mariadb build_nginx build_wordpress

.PHONY: build_mariadb
build_mariadb:
	@echo "Building mariadb image..."
	docker build --no-cache -t mariadb $(DOCKERFILES_DIR)/mariadb

.PHONY: build_nginx
build_nginx:
	@echo "Building nginx image..."
	docker build --no-cache -t nginx $(DOCKERFILES_DIR)/nginx

.PHONY: build_wordpress
build_wordpress:
	@echo "Building wordpress image..."
	docker build --no-cache -t wordpress $(DOCKERFILES_DIR)/wordpress

.PHONY: up
up:
	@echo "Starting up containers with docker-compose..."
	docker-compose -f $(DOCKER_COMPOSE_FILE) up -d

.PHONY: down
down:
	@echo "Shutting down containers..."
	docker-compose -f $(DOCKER_COMPOSE_FILE) down

.PHONY: re
re: down build up

.PHONY: clean
clean:
	@echo "Cleaning up Docker volumes..."
	docker-compose -f $(DOCKER_COMPOSE_FILE) down -v
	docker system prune -a --volumes
	sudo rm -rf /home/nsouchal/data/wordpress/*
	sudo rm -rf /home/nsouchal/data/mariadb/*
# Définir les variables du projet
PROJECT_NAME = inception
NETWORK_NAME = inception

# Nom des services (correspond aux noms des services dans le docker-compose.yml)
SERVICES = mariadb nginx wordpress

# Dossier contenant les fichiers Docker
DOCKERFILES_DIR = srcs/requirements

DOCKER_COMPOSE_FILE=srcs/docker-compose.yml

# Cible par défaut
.PHONY: all
all: build up

# Cible pour construire toutes les images
.PHONY: build
build: build_mariadb build_nginx build_wordpress

# Cible pour construire l'image de MariaDB
.PHONY: build_mariadb
build_mariadb:
	@echo "Building mariadb image..."
	docker build -t $(PROJECT_NAME)_mariadb $(DOCKERFILES_DIR)/mariadb

# Cible pour construire l'image de Nginx
.PHONY: build_nginx
build_nginx:
	@echo "Building nginx image..."
	docker build -t $(PROJECT_NAME)_nginx $(DOCKERFILES_DIR)/nginx

# Cible pour construire l'image de WordPress
.PHONY: build_wordpress
build_wordpress:
	@echo "Building wordpress image..."
	docker build -t $(PROJECT_NAME)_wordpress $(DOCKERFILES_DIR)/wordpress

# Cible pour démarrer les conteneurs via docker-compose
.PHONY: up
up:
	@echo "Starting up containers with docker-compose..."
	docker-compose -f $(DOCKER_COMPOSE_FILE) up -d

# Cible pour arrêter les conteneurs
.PHONY: down
down:
	@echo "Shutting down containers..."
	docker-compose -f $(DOCKER_COMPOSE_FILE) down

# Cible pour reconstruire les conteneurs (rebuild)
.PHONY: re
re: down build up

# Cible pour supprimer les volumes Docker (utile si vous souhaitez réinitialiser les données)
.PHONY: clean
clean:
	@echo "Cleaning up Docker volumes..."
	docker-compose -f $(DOCKER_COMPOSE_FILE) down -v

# Cible pour vérifier l'état des conteneurs
.PHONY: status
status:
	@echo "Checking container status..."
	docker ps

# Cible pour afficher les logs des conteneurs
.PHONY: logs
logs:
	@echo "Displaying logs for all services..."
	docker-compose -f $(DOCKER_COMPOSE_FILE) logs -f
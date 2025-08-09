# Variables
COMPOSE_FILE = srcs/docker-compose.yml
DATA_PATH = /home/$(USER)/data

# Couleurs pour l'affichage
GREEN = \033[0;32m
RED = \033[0;31m
YELLOW = \033[1;33m
NC = \033[0m # No Color

.PHONY: all build up down clean fclean re logs status help

# Règle par défaut
all: build up

# Construire les images Docker
build:
	@echo "$(YELLOW)Création des dossiers de données...$(NC)"
	@mkdir -p $(DATA_PATH)/mariadb $(DATA_PATH)/wordpress
	@chmod 755 $(DATA_PATH)/mariadb $(DATA_PATH)/wordpress
	@echo "$(YELLOW)Construction des images Docker...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) build

# Démarrer les services
up:
	@echo "$(GREEN)Démarrage des services...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) up -d

# Arrêter les services
down:
	@echo "$(RED)Arrêt des services...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) down

# Nettoyer les containers et volumes
clean: down
	@echo "$(YELLOW)Nettoyage des containers et volumes...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) down -v
	@docker system prune -f

# Nettoyage complet (images, containers, volumes, données)
fclean: clean
	@echo "$(RED)Nettoyage complet...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) down -v --rmi all
	@docker system prune -af
	@sudo rm -rf $(DATA_PATH)

# Reconstruction complète
re: fclean all

# Afficher les logs
logs:
	@docker-compose -f $(COMPOSE_FILE) logs -f

# Statut des services
status:
	@echo "$(GREEN)Statut des services:$(NC)"
	@docker-compose -f $(COMPOSE_FILE) ps

# Aide
help:
	@echo "$(GREEN)Commandes disponibles:$(NC)"
	@echo "  make all     - Construire et démarrer tous les services"
	@echo "  make build   - Construire les images Docker"
	@echo "  make up      - Démarrer les services"
	@echo "  make down    - Arrêter les services"
	@echo "  make clean   - Nettoyer containers et volumes"
	@echo "  make fclean  - Nettoyage complet"
	@echo "  make re      - Reconstruction complète"
	@echo "  make logs    - Afficher les logs"
	@echo "  make status  - Statut des services"


COMPOSE_FILE = srcs/docker-compose.yml
DATA_PATH = /home/$(USER)/data


GREEN = \033[0;32m
RED = \033[0;31m
YELLOW = \033[1;33m
NC = \033[0m # No Color

.PHONY: all build up down clean fclean re logs status help


all: build up


build:
	@echo "$(YELLOW)Création des dossiers de données...$(NC)"
	@mkdir -p $(DATA_PATH)/mariadb $(DATA_PATH)/wordpress
	@chmod 755 $(DATA_PATH)/mariadb $(DATA_PATH)/wordpress
	@echo "$(YELLOW)Construction des images Docker...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) build


up:
	@echo "$(GREEN)Démarrage des services...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) up -d


down:
	@echo "$(RED)Arrêt des services...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) down


clean: down
	@echo "$(YELLOW)Nettoyage des containers et volumes...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) down -v
	@docker system prune -f


fclean: clean
	@echo "$(RED)Nettoyage complet...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) down -v --rmi all
	@docker system prune -af
	@sudo rm -rf $(DATA_PATH)


re: fclean all


logs:
	@docker-compose -f $(COMPOSE_FILE) logs -f


status:
	@echo "$(GREEN)Statut des services:$(NC)"
	@docker-compose -f $(COMPOSE_FILE) ps


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

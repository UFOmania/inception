
all:
	@docker compose up --build


down:
	@docker compose down


clean:
	@docker compose  down --rmi all -v

fclean:
	@echo "Stopping containers and removing volumes..."
	@docker compose down --rmi all -v
	@echo "Cleaning system and orphan volumes..."
	@docker system prune -af --volumes
	@echo "Full cleanup complete."


re: fclean all

.PHONY: all down clean fclean re
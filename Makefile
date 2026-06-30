all:
	@mkdir -p /home/${USER}/data/mariadb
	@mkdir -p /home/${USER}/data/wordpress
	@docker compose -f ./srcs/docker-compose.yml up --build

down:
	@docker compose -f ./srcs/docker-compose.yml  down


clean:
	@echo "Stopping containers and removing volumes..."
	@docker compose -f ./srcs/docker-compose.yml   down --rmi all -v

fclean:
	@echo "Cleaning system and orphan volumes..."
	@docker system prune -af --volumes
	@sudo rm -rf /home/massrayb/data/
	@echo "Full cleanup complete."


re: fclean all
all:
	@mkdir -p /home/massrayb/data/mariadb
	@mkdir -p /home/massrayb/data/wordpress
	@docker compose -f ./srcs/docker-compose.yml up --build

down:
	@docker compose -f ./srcs/docker-compose.yml  down 


clean:
	@echo "Stopping containers and removing volumes..."
	@docker compose -f ./srcs/docker-compose.yml   down --rmi all -v --remove-orphans

fclean: clean
	@echo "Cleaning system and orphan volumes..."
	@sudo rm -rf /home/massrayb/data/
	@echo "Full cleanup complete."


re: fclean all

.phony: all down clean 

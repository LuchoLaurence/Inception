#!bin/bash
NAME = inception
CONTAINERS		= $(shell docker ps -a -q)
VOLUMES			= $(shell docker volume ls -q)

all: start

init: 
	@mkdir -p ~/data/mariadb
	@mkdir -p ~/data/wordpress

start: init
	@docker-compose -f srcs/docker-compose.yml up -d --build

stop: 
ifneq ($(CONTAINERS),)
	@docker-compose -f srcs/docker-compose.yml down
	@echo "Containers stopped"
else
	@echo "No containers to stop"
endif

clean: stop
ifneq ($(VOLUMES),)
	@docker volume rm $$(docker volume ls -q) > /dev/null
	@docker system prune -a -f > /dev/null
	@echo "Volumes removed"
else
	@echo "No volumes to remove"
endif

fclean: clean
	@sudo rm -rf ~/data

re: fclean all

.PHONE: all init start stop clean fclean
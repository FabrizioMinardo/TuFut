#!make
include .env

SERVICE_NAME=mysql
HOST=127.0.0.1
PORT=3306

PASSWORD=${MYSQL_ROOT_PASSWORD}
DATABASE=${MYSQL_DATABASE}
USER=${MYSQL_USER}

DOCKER_COMPOSE_FILE=./docker-compose.yml
DATABASE_CREATION=./sql_project/database_structure.sql
DATABASE_POPULATION=./sql_project/population.sql

FILES=vistas funciones stored_procedures triggers


.PHONY: all up create-roles-users objects test-db access-db down

all: info up objects create-roles-users

info:
	@echo "This is a project for $(DATABASE)"
	

up:
	@echo "Create the instance of docker"
	docker compose -f $(DOCKER_COMPOSE_FILE) up -d --build

	@echo "Waiting for MySQL to be ready..."
	bash mysql_wait.sh


	@echo "Create the import and run de script"
	docker exec -it $(SERVICE_NAME) mysql -u$(MYSQL_USER) -p$(PASSWORD)  -e "source $(DATABASE_CREATION);"
	docker exec -it $(SERVICE_NAME) mysql -u$(MYSQL_USER) -p$(PASSWORD) --local-infile=1 -e "source $(DATABASE_POPULATION)"

objects:
	@echo "Create objects in database"
	@for file in $(FILES); do \
	    echo "Process $$file and add to the database: $(DATABASE_NAME)"; \
	docker exec -it $(SERVICE_NAME)  mysql -u$(MYSQL_USER) -p$(PASSWORD) -e "source ./sql_project/database_objects/$$file.sql"; \
	done

test-db:
	@echo "Testing the tables"
	docker exec -it $(SERVICE_NAME)  mysql -u$(MYSQL_USER) -p$(PASSWORD)  -e "source ./sql_project/check_db_objects.sql";

access-db:
	@echo "Access to db-client"
	docker exec -it $(SERVICE_NAME) mysql -u$(MYSQL_USER) -p$(PASSWORD) 

create-roles-users:
	@echo "Creating roles and users in the database"
	docker exec -it $(SERVICE_NAME) mysql -u$(MYSQL_USER) -p$(PASSWORD) -e "source ./sql_project/roles_users.sql"

backup-db:
	@echo "Back up database by structure and data"
	docker exec -it $(SERVICE_NAME) mysqldump -u root -pfabro123 TUFUT > back-up/TUFUT-$(shell date +\%d-\%m-\%Y_\%H-\%M).sql

down:
	@echo "Remove the Database"
	docker exec -it $(SERVICE_NAME) mysql -u$(MYSQL_USER) -p$(PASSWORD) --host $(HOST) --port $(PORT) -e "DROP DATABASE IF EXISTS $(DATABASE);"
	@echo "Bye"
	docker compose -f $(DOCKER_COMPOSE_FILE) down

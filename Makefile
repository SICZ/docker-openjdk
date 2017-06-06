CENTOS_VERSION		?= latest
OPENJDK_VERSION		?= 8-jre
OPENJDK_MAJOR_VERSION	= $(shell echo $(OPENJDK_VERSION) | sed 's/-.*//')

BASE_IMAGE_TAG		= $(CENTOS_VERSION)

DOCKER_PROJECT		= sicz
DOCKER_NAME		= openjdk
DOCKER_TAG		= $(OPENJDK_VERSION)
DOCKER_FILE_SUB		+= OPENJDK_MAJOR_VERSION

DOCKER_RUN_OPTS		= $(DOCKER_SHELL_OPTS) \
			  -v /var/run/docker.sock:/var/run/docker.sock


.PHONY: all build rebuild deploy run up destroy down clean rm start stop restart
.PHONY: status logs shell refresh test

all: destroy build deploy logs test
build: docker-build
rebuild: docker-rebuild
deploy run up: docker-deploy
destroy down clean rm: docker-destroy
start: docker-start
stop: docker-stop
restart: docker-stop docker-start
status: docker-status
logs: docker-logs
logs-tail: docker-logs-tail
shell: docker-shell
refresh: docker-refresh
test: docker-test

include ../Mk/docker.container.mk

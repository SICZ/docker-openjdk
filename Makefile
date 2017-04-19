ALPINE_TAG		?= latest
OPENJDK_TAG		?= 8-jdk
OPENJDK_MAJOR_VER	= $(shell echo $(OPENJDK_TAG) | sed 's/-.*//')

BASE_IMAGE_TAG		= $(ALPINE_TAG)

DOCKER_PROJECT		= sicz
DOCKER_NAME		= openjdk
DOCKER_TAG		= $(OPENJDK_TAG)
DOCKER_FILE_SUB		+= OPENJDK_MAJOR_VER

DOCKER_RUN_OPTS		= $(DOCKER_SHELL_OPTS) \
			  -v /var/run/docker.sock:/var/run/docker.sock


.PHONY: all build rebuild deploy run up destroy down clean rm start stop restart
.PHONY: status logs shell

all: destroy build deploy logs shell
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

include ../Mk/docker.container.mk

# docker-openjdk

[![CircleCI Status Badge](https://circleci.com/gh/sicz/docker-openjdk.svg?style=shield&circle-token=380685aec539c72da52d89c935c90fe313c85d3e)](https://circleci.com/gh/sicz/docker-openjdk)

**This project is not aimed at public consumption.
It exists to serve as a single endpoint for SICZ containers.**

An OpenJDK base images.

## Contents

### Alpine Linux based images

This images only contains essential components:
- [sicz/baseimage-alpine](https://github.com/sicz/docker-baseimage) as a base image.
- [openjdk](http://openjdk.java.net) from Alpine Linux packages suite.

### CentOS based images

This images only contains essential components:
- [sicz/baseimage-centos](https://github.com/sicz/docker-baseimage) as a base image.
- [openjdk](http://openjdk.java.net) from CentOS packages suite.

## Getting started

These instructions will get you a copy of the project up and running on your
local machine for development and testing purposes. See deployment for notes
on how to deploy the project on a live system.

### Installing

Clone GitHub repository to your working directory:
```bash
git clone https://github.com/sicz/docker-openjdk
```

### Usage

The directories with Docker image variants:
* `8-jre-alpine` - latest OpenJDK 8 Java Runtime Environment on latest Alpine Linux
* `8-jdk-alpine` - latest OpenJDK 8 Java Development Kit on latest Alpine Linux
* `8-jre-centos` - latest OpenJDK 8 Java Runtime Environment on latest CentOS
* `8-jdk-centos` - latest OpenJDK 8 Java Development Kit on latest CentOS
* `8-jre-alpine/devel` - development OpenJDK 8 Java Runtime Environment on development Alpine Linux
* `8-jdk-alpine/devel` - development OpenJDK 8 Java Development Kit on development Alpine Linux
* `8-jre-centos/devel` - development OpenJDK 8 Java Runtime Environment on latest CentOS
* `8-jdk-centos/devel` - development OpenJDK 8 Java Development Kit on latest CentOS

Use the command `make` in the project directory:
```bash
make all                          # Build and test all Docker images
make build-all                    # Build all Docker images
make rebuild-all                  # Rebuild all Docker images
make clean-all                    # Remove all containers and clean work files
make docker-pull-all              # Pull all images from Docker Registry
make docker-pull-dependencies-all # Pull all image dependencies from Docker Registry
make docker-pull-image-all        # Pull all project images from Docker Registry
make docker-pull-testimage-all    # Pull all project images from Docker Registry
make docker-push-all              # Push all project images to Docker Registry
```

Use the command `make` in directories with Docker image variants:
```bash
make all                          # Build a new image and run tests for current configuration
make ci                           # Build a new image and run tests for all configurations
make build                        # Build a new image
make rebuild                      # Build a new image without using the Docker layer caching
make config-file                  # Display the configuration file
make vars                         # Display the make variables
make up                           # Remove the containers and then run them fresh
make create                       # Create the containers
make start                        # Start the containers
make stop                         # Stop the containers
make restart                      # Restart the containers
make rm                           # Remove the containers
make wait                         # Wait for the start of the containers
make ps                           # Display running containers
make logs                         # Display the container logs
make logs-tail                    # Follow the container logs
make shell                        # Run the shell in the container
make test                         # Run the tests
make test-shell                   # Run the shell in the test container
make secrets                      # Create the Simple CA secrets
make clean                        # Remove all containers and work files
make docker-pull                  # Pull all images from the Docker Registry
make docker-pull-dependencies     # Pull the project image dependencies from the Docker Registry
make docker-pull-image            # Pull the project image from the Docker Registry
make docker-pull-testimage        # Pull the test image from the Docker Registry
make docker-push                  # Push the project image into the Docker Registry
```

## Deployment

This container is intended to serve as a base image for other containers.

You can start with this sample `Dockerfile`:
```Dockerfile
FROM sicz/openjdk:8-jre-alpine
ENV DOCKER_COMMAND=MY_COMMAND
ENV DOCKER_USER=MY_USER
# Create an user account
RUN set -ex && adduser -D -H -u 1000 ${DOCKER_USER}
# Install some packages
RUN set -ex && apk add --no-cache SOME PACKAGES
# Copy your own entrypoint scripts
COPY dockerfile-entrypoint.d /dockerfile-entrypoint.d
```

## Authors

* [Petr Řehoř](https://github.com/prehor) - Initial work.

See also the list of [contributors](https://github.com/sicz/docker-baseimage-alpine/contributors)
who participated in this project.

## License

This project is licensed under the Apache License, Version 2.0 - see the
[LICENSE](LICENSE) file for details.

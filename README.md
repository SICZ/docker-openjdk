# docker-openjdk

[![CircleCI Status Badge](https://circleci.com/gh/sicz/docker-openjdk.svg?style=shield&circle-token=380685aec539c72da52d89c935c90fe313c85d3e)](https://circleci.com/gh/sicz/docker-openjdk)

**This Docker image is not aimed at public consumption.
It exists to serve as a single endpoint for SICZ containers.**

An OpenJDK base image based on CentOS.

## Contents

This container only contains essential components:
- [sicz/baseimage-centos](https://github.com/sicz/docker-baseimage-centos) as base image.
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

Use command `make` to simplify Docker container development tasks:
```bash
make all        # Destroy running container, build new image and run tests
make build      # Build new image
make refresh    # Refresh Dockerfile
make rebuild    # Build new image without caching
make run        # Run container
make stop       # Stop running container
make start      # Start stopped container
make restart    # Restart container
make status     # Show container status
make logs       # Show container logs
make logs-tail  # Connect to container logs
make shell      # Open shell in running container
make test       # Run tests
make rm         # Destroy running container
```

## Deployment

This container is intended to serve as a base image for other containers.

You can start with this sample `Dockerfile`:
```Dockerfile
FROM sicz/openjdk:8-jdk
ENV DOCKER_COMMAND=MY_COMMAND
ENV DOCKER_USER=MY_USER
# Create an user account
RUN set -ex && adduser -M -U -u 1000 ${DOCKER_USER}
# Install some packages
RUN set -ex && yum update -y && yum install -y SOME PACKAGES && yum clean all
# Copy your own entrypoint scripts into image
COPY dockerfile-entrypoint.d /dockerfile-entrypoint.d
# Dockerfile does not allow ${DOCKER_COMMAND} variable in CMD
CMD ["MY_COMMAND"]
```

## Authors

* [Petr Řehoř](https://github.com/prehor) - Initial work.

See also the list of [contributors](https://github.com/sicz/docker-baseimage-alpine/contributors)
who participated in this project.

## License

This project is licensed under the Apache License, Version 2.0 - see the
[LICENSE](LICENSE) file for details.

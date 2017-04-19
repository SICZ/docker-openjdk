# docker-openjdk

**This Docker image is not aimed at public consumption.
It exists to serve as a single endpoint for SICZ containers.**

An OpenJDK base image based on Alpine Linux.

## Contents

This container only contains essential components:
- [sicz/baseimage-alpine](https://github.com/sicz/docker-baseimage-alpine) as base image.
- [openjdk](http://openjdk.java.net) from Alpine Linux packages suite.

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
make all        # Destroy running container, build new image and run interactive shell in container
make build      # Build new image
make rebuild    # Refresh Dockerfile and build new image
make run        # Run container
make stop       # Stop running container
make start      # Start stopped container
make restart    # Restart container
make status     # Show container status
make logs       # Show container logs
make logs-tail  # Connect to container logs
make shell      # Open shell in running container
make rm         # Destroy running container
```

## Deployment

This container is intended to serve as a base image for other containers.

You can start with this sample `Dockerfile`:
```Dockerfile
FROM sicz/openjdk:8-jdk
RUN set -x && apk add --no-cache SOME PACKAGES
COPY dockerfile-entrypoint.d /dockerfile-entrypoint.d
CMD ["MY-COMMAND"]
```

and place file `10-docker-config.sh` into `docker-entrypoint.d` directory:
```bash
#!/bin/bash

# Docker entrypoint configuration
DOCKER_COMMAND=MY-COMMAND
```

## Authors

* [Petr Řehoř](https://github.com/prehor) - Initial work.

See also the list of [contributors](https://github.com/sicz/docker-baseimage-alpine/contributors)
who participated in this project.

## License

This project is licensed under the Apache License, Version 2.0 - see the
[LICENSE](LICENSE) file for details.

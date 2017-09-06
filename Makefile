### SHELL ######################################################################

# Replace Debian Almquist Shell with Bash
ifeq ($(realpath $(SHELL)),/bin/dash)
SHELL   		:= /bin/bash
endif

# Exit immediately if a command exits with a non-zero exit status
# TODO: .SHELLFLAGS does not exists on obsoleted macOS X-Code make
# .SHELLFLAGS		= -ec
SHELL			+= -e

### MAKE_TARGETS ###############################################################

# Docker image variants
DOCKER_VARIANTS		= 8u141

# Make targets propagated to all Docker image variants
DOCKER_VARIANT_TARGETS	= build \
			  rebuild \
			  ci \
			  clean \
			  docker-pull \
			  docker-pull-dependencies \
			  docker-pull-image \
			  docker-pull-testimage \
			  docker-push

################################################################################

# Build all images and run all tests
.PHONY: all
all: ci

# Subdir targets
.PHONY: $(DOCKER_VARIANT_TARGETS)
$(DOCKER_VARIANT_TARGETS):
	@for DOCKER_VARIANT in $(DOCKER_VARIANTS); do \
		cd $(CURDIR)/$${DOCKER_VARIANT}; \
		$(MAKE) $@; \
	done

################################################################################

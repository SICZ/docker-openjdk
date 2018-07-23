### OPENJDK_VERSION ############################################################

OPENJDK_PRODUCT_VERSION	?= 8
OPENJDK_UPDATE_VERSION	?= 171

### DOCKER_IMAGE ###############################################################

ALPINE_VERSION		?= 3.8
CENTOS_VERSION		?= 7

# Latest version tag
DOCKER_IMAGE_TAGS	?= $(OPENJDK_PRODUCT_VERSION)-$(OPENJDK_EDITION)-$(BASE_IMAGE_OS)

### MK_DOCKER_IMAGE ############################################################

include $(PROJECT_DIR)/docker.version.mk

################################################################################

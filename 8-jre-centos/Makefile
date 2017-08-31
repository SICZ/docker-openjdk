### OPENJDK_CONFIG #############################################################

PROJECT_DIR		?= $(abspath ..)
include $(PROJECT_DIR)/openjdk.8-latest.mk

OPENJDK_EDITION		?= jre
OPENJDK_EDITION_DESC	?= Java Runtime Environment

### BASE_IMAGE #################################################################

BASE_IMAGE_OS		?= centos
BASE_IMAGE_NAME		?= $(DOCKER_PROJECT)/baseimage-$(BASE_IMAGE_OS)
BASE_IMAGE_TAG		?= 7

### DOCKER_IMAGE ###############################################################

DOCKER_IMAGE_TAG	?= $(OPENJDK_PRODUCT_VERSION)u$(OPENJDK_UPDATE_VERSION)-$(OPENJDK_EDITION)-$(BASE_IMAGE_OS)
DOCKER_IMAGE_TAGS	?= $(OPENJDK_PRODUCT_VERSION)-$(OPENJDK_EDITION)-$(BASE_IMAGE_OS)

### DOCKER_VERSIONS ############################################################

DOCKER_VERSIONS		?= latest devel

### MK_DOCKER_IMAGE ############################################################

include $(PROJECT_DIR)/docker.version.mk

################################################################################

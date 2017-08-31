### OPENJDK_CONFIG #############################################################

PROJECT_DIR		?= $(abspath ../..)
include $(PROJECT_DIR)/openjdk.8-devel.mk

### DOCKER_IMAGE ###############################################################

DOCKER_IMAGE_TAGS	?=

### BUILD ######################################################################

# If the image configuration variables are not defined, the development image is
# assumed to be the same as the latest image
BUILD_CONFIG		?= $(BASE_IMAGE_TAG) \
			   $(OPENJDK_PRODUCT_VERSION) \
			   $(OPENJDK_UPDATE_VERSION)

ifeq ($(strip $(BUILD_CONFIG)),)
DOCKER_CI_TARGET	?= docker-tag
DOCKER_BUILD_TARGET	?= docker-tag
DOCKER_REBUILD_TARGET	?= docker-tag
endif

### MK_DOCKER_IMAGE ############################################################

include ../Makefile

################################################################################

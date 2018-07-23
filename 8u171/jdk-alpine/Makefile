### BASE_IMAGE #################################################################

BASE_IMAGE_OS		?= alpine
BASE_IMAGE_NAME		?= $(DOCKER_PROJECT)/openjdk
BASE_IMAGE_TAG		?= $(OPENJDK_PRODUCT_VERSION)u$(OPENJDK_UPDATE_VERSION)-jre-$(BASE_IMAGE_OS)

### DOCKER_IMAGE ###############################################################

OPENJDK_EDITION		?= jdk
OPENJDK_EDITION_DESC	?= Java Development Kit

### MK_DOCKER_IMAGE ############################################################

PROJECT_DIR		?= $(abspath ../..)
include ../docker.openjdk.mk

################################################################################
